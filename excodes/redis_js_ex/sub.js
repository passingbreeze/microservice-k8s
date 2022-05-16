const redis = require('redis');

async function sub() {
  const subscriber = redis.createClient({
    url: `redis://default:storemsgq@localhost:6379`
  });
  subscriber.on("error", (err) => console.log("sub error :", err))
  await subscriber.connect().then(console.log("sub connected!"))

  await subscriber.subscribe('channel', (message) => {
    console.log(JSON.parse(message)); // 'message'
  });
    
}

sub()