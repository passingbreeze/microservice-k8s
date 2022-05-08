use std::sync::Arc;
use std::fs::File;
use std::collections::VecDeque;

use tokio::sync::Mutex;
use serde_json::from_reader;

use crate::models::ProductReq;

pub type Db = Arc<Mutex<VecDeque<ProductReq>>>;

pub fn init_db() -> Db {
    let file = File::open("./data/requests.json");
    match file {
        Ok(json) => {
            let requests = from_reader(json).unwrap();
            Arc::new(Mutex::new(requests))
        }
        Err(_) => Arc::new(Mutex::new(VecDeque::new())),
    }
}
