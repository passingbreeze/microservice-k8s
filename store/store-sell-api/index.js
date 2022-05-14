require('dotenv').config()
const app = require('fastify')({
    logger: true
})
const { default: fastify } = require('fastify');
const mysql = require("mysql2/promise");
  
app.get("/status", async (req, res) => {
    res.type('application/json').code(200)
    return {
      message: 'ok!'
    }
})

app.post("/send", async (req, res) => { // POST 람다 주소/send
    console.log("request body:", req.body);
    try {
      const dbcon = await mysql.createConnection({
        // RDS에서 DB를 생성하고 연결하세요.
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DBNAME,
        port: process.env.DB_PORT
      });
      const [rows, fields] = await dbcon.query(
        `SELECT BIN_TO_UUID(product_id) as product_id
                , name, price, stock, BIN_TO_UUID(factory_id), BIN_TO_UUID(ad_id)
            FROM product
            WHERE sku = '${req.body.MessageAttributeProductId}';
      `);
      console.log(rows, fields);
      if(rows[0].stock > 0) {
        const updateStockQuery = `
          UPDATE product
          SET stock = ${rows[0].stock - 1}
          WHERE product_id = UUID_TO_BIN('${rows[0].product_id}');
        `;
        const updatedResult = await dbcon.query(updateStockQuery)
        console.log("재고 감소!", updatedResult)
        res.type('application/json').code(200)
        return { 
          message: "판매완료"
        }
      } else {
        console.log("재고 부족 상황!!")
        const now = new Date().toString();
        const snsMsg = `${req.body.message}, This was sent: ${now}`;
        const snsParams = {
          Message: snsMsg,
          MessageGroupId: req.body.MessageGroupId,
          MessageDeduplicationId: new Date().getTime().toString(),
          Subject: req.body.subject,
          MessageAttributes: {
            ProductId: {
              StringValue: req.body.MessageAttributeProductId,
              DataType: "String",
            },
            FactoryId: {
              StringValue: req.body.MessageAttributeFactoryId,
              DataType: "String",
            },
          },
          TopicArn: process.env.SNS_TOPIC_ARN
        };
  
        const publishedResult = await sns.publish(snsParams).promise()
        console.log("published result:", publishedResult)
        res.type('application/json').code(200)
        return {
          message : "재고부족, 제품 생산 요청!"
        }
      }    
    } catch(error) {
      console.log("Error from DB Connect :", error)
      res.type('application/json').code(500)
      return { 
        message: error 
      }
    }
  })

  const server = async () => {
    try {
      await app.listen(process.env.SERVER_PORT)   
    } catch (error) {
      app.log.error(err);
      process.exit(1);
    }
  }
  
  server()