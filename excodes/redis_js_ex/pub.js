const fastify = require('fastify')({
    logger: true
})
const redis = require('redis')


fastify.post("/", async (req, res) => {
    const publisher = redis.createClient({
        url: `redis://default:storemsgq@localhost:6379`
    });
    publisher.on("error", (err) => console.log("pub error :", err))
    await publisher.connect().then(console.log("pub connected!"))
    await publisher.publish('channel', JSON.stringify(req.body))
    res.type('application/json').code(201)
    return { 
      message: 'ok!'
    }
})

const server = async () => {
    try {
      await fastify.listen(3000)   
    } catch (error) {
      fastify.log.error(err);
      process.exit(1);
    }
  }
  
  server()