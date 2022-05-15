"use strict";

const fetch = require('node-fetch');
const redis = require('redis');

function chkStockEmpty(type, msg){
  return type === 'Notification' && msg === '재고 부족';
}


async function streamConsumer(){
  const msgq = redis.createClient({
    url: `redis://${process.env.REDIS_USER}:${process.env.REDIS_PASSWORD}@${process.env.REDIS_HOST}:${process.env.REDIS_PORT}`
  });
  await msgq.connect();
  for(;;){
    try {
      let facReqBody = "";
      await msgq.subscribe('store', (msg) => {
          console.log("Message Body: ", msg);
          const msgBody = JSON.parse(msg)
          if(msgBody){
            const msgType = msgBody.Type, emptyStockMsg = msgBody.Message.split(',')[0]
            if(chkStockEmpty(msgType, emptyStockMsg)){
              facReqBody = {
                "MessageGroupId": "stock-arrival-group",
                "MessageAttributeProductId": "CP-502101",
                "MessageAttributeProductCnt": 10,
                "MessageAttributeFactoryId": "FF-500293",
                "MessageAttributeRequester": "김수한무 거북이와 두루미 삼천갑자 동방삭 치치카포 사리사리센타 워리워리 세브리깡 무두셀라 구름이 허리케인에 담벼락 담벼락에 서생원 서생원에 고양이 고양이엔 바둑이 바둑이는 돌돌이 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세 남산 위에 저 소나무 철갑을 두른 듯 바람 서리 불변함은 우리 기상일세 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세 ",
                "CallbackUrl": "https://cvp39wy27e.execute-api.ap-northeast-2.amazonaws.com/arrival"
              }
              // 공장으로 보낼 메시지 만들기
            } else {
              return {
                message : "메세지가 없습니다."
              };
            }
          } else {
            return {
              message : "메세지가 올바른 형식이 아닙니다."
            };
          }
        }
      );
    
      const factoryRes = await fetch(process.env.FACTORY_URL, {
        method: 'POST',
        body: JSON.stringify(facReqBody),
        headers: { 'Content-Type': 'application/json' }
      })
      console.log("factory response :", factoryRes);
      // return factoryRes
      return {
        message : "재고 요청 성공!"
      };
      
    } catch (error) {
      console.log("Error from Redis :", error);
      process.exit(1)
    }
  }
}

streamConsumer()