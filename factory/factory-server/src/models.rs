use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Default, Deserialize, Serialize)]
pub struct ProductReq {
    pub MessageAttributeProductId: String,
    pub MessageAttributeProductCnt: i32,
    pub MessageAttributeFactoryId: String,
    pub MessageAttributeRequester: String,
    pub CallbackURL: String
}

/*
curl --location --request POST 'http://factory.p3.api.codestates-devops.be:8080/manufacture' \
--header 'Content-Type: application/json' \
--data-raw '{
  "MessageGroupId": "stock-arrival-group",
  "MessageAttributeProductId": "CP-502101",
  "MessageAttributeProductCnt": 10,
  "MessageAttributeFactoryId": "FF-500293",
  "MessageAttributeRequester": "홍길동",
  "CallbackUrl": "https://rr298yy7hk.execute-api.ap-northeast-2.amazonaws.com/arrival"
}'
*/