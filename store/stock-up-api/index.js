"use strict";
const mysql = require('mysql2/promise');
const fastify = require('fastify')({
  logger: true
});

fastify.post("/", async (req, res) => {
  console.log(typeof req.body, req.body);
  const eventBody = JSON.parse(req.body);
  const productCnt = eventBody.MessageAttributeProductCnt;
  const productID = eventBody.MessageAttributeProductId;
  console.log(typeof productCnt, productCnt);
  
  const dbcon = await mysql.createConnection({
    // RDS에서 DB를 생성하고 연결하세요.
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DBNAME,
    port: process.env.DB_PORT
  });
  
  const [rows, fields] = await dbcon.query(
    `   SELECT
            BIN_TO_UUID(product_id) as product_id
            , name, price, stock, BIN_TO_UUID(factory_id), BIN_TO_UUID(ad_id)
        FROM product
        WHERE sku = '${productID}';
    `,
  );
  console.log('rows :', rows);
  // console.log('stock is:', rows[0].stock)
  const updatedStock = (rows[0].stock) + productCnt;
  const [updateResult] = await dbcon.query(`UPDATE product SET stock = ${updatedStock} WHERE sku = '${productID}';`);
  console.log("Result :", updateResult);
  res.type('application/json').code(200)
  return {
    message: `${productCnt}개 생산 완료 !!`,
  };
});

const server = async () => {
  try {
    await fastify.listen(process.env.PORT)   
  } catch (error) {
    fastify.log.error(err);
    process.exit(1);
  }
}

server()