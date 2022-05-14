# Event from SQS

## Records

### Record 예시
  Records: [
    {
      messageId: '3df58c80-78e3-47d5-8758-81f9b8b714c0',
      receiptHandle: 'AQEBMPutuhztaxD4jUBcg0IdcFLxdBnDPTH8zppho9cVpl0eKJ9P7+tH7+OtK5zTlOTBHmbSPK4w3Rh6gGVk/ypS3vCaGAKzfFjqThP604BMNRP2zltUuoki1i9T5bsleO6PfTVMUxJAkV8mFUmHIaUJqrIysZgyIoab74tAcN9tUbJIRvVuSWtWIfbNnimEYMUHqK6DZ4LKMx+4ykxHg2e3aqVWUnWGmP78EKSx90KAiBbQBxb1HNsRpkqwYDeMRqe6rz0p6FM6ptWLRoPFdNcrncIc/Efz85JMjP1TYx21i8o=',
      body: '{\n' +
        '  "Type" : "Notification",\n' +
        '  "MessageId" : "dd45122a-004c-5bfc-a6fa-48cd213f9859",\n' +
        '  "SequenceNumber" : "10000000000000014000",\n' +
        '  "TopicArn" : "arn:aws:sns:ap-northeast-2:235824954020:proj3-chk-stock-empty.fifo",\n' +
        '  "Subject" : "부산도너츠 재고 부족",\n' +
        '  "Message" : "재고 부족 \\n \\n This was sent: Sat Apr 30 2022 20:36:19 GMT+0900 (대한민국 표준시)",\n' +
        '  "Timestamp" : "2022-04-30T11:36:19.701Z",\n' +
        '  "UnsubscribeURL" : "https://sns.ap-northeast-2.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:ap-northeast-2:235824954020:proj3-chk-stock-empty.fifo:66bbae91-5938-432e-b5bf-7e9c0393a4f3",\n' +
        '  "MessageAttributes" : {\n' +
        '    "FactoryId" : {"Type":"String","Value":"FF-500293"},\n' +
        '    "ProductId" : {"Type":"String","Value":"CP-502101"}\n' +
        '  }\n' +
        '}',
      attributes: [Object],
      messageAttributes: {},
      md5OfBody: '16d3ff4112331881b28658054de91374',
      eventSource: 'aws:sqs',
      eventSourceARN: 'arn:aws:sqs:ap-northeast-2:235824954020:stock_queue.fifo',
      awsRegion: 'ap-northeast-2'
    }
  ]
}