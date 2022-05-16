const fetch = require('node-fetch');
const redis = require('redis');

async function streamConsumer(){
  const msgq = redis.createClient({
    url: `redis://default:${process.env.REDIS_PASSWORD}@${process.env.REDIS_HOST}:${process.env.REDIS_PORT}`
  });
  msgq.on('error', (err) => console.log("redis connect error :", err))
  await msgq.connect().then(console.log("queue connected!"));
  try {
    await msgq.subscribe('store', (msg) => {
       console.log("Message Body: ", msg);
       if(msg){
          const facReqBody = {
            "MessageGroupId": "stock-arrival-group",
            "MessageAttributeProductId": "CP-502101",
            "MessageAttributeProductCnt": 10,
            "MessageAttributeFactoryId": "FF-500293",
            "MessageAttributeRequester": "Jeongmin-kube",
            "CallbackUrl": `${process.env.CALLBACK_URL}`
          }
          console.log("factory request body :", facReqBody)
          fetch(process.env.FACTORY_URL, {
            method: 'POST',
            body: JSON.stringify(facReqBody),
            headers: { 'Content-Type': 'application/json' }
          })
          .then(res => res.json())
          .then(json => console.log("factory response :", json))
          console.log("재고 요청 성공!")   
        } else { // error case 1
         console.log("No Message")
      }})
    .then(console.log("subscribed!"));    
  } catch (error) {
    console.log("Error from Redis :", error);
    process.exit(1)
  }
}

streamConsumer()

