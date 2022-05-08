use std::convert::Infallible;
use std::collections::VecDeque;
use warp::{self, http::StatusCode};

use crate::models::ProductReq;
use crate::db::Db;

pub async fn list_manufactures(db: Db) -> Result<impl warp::Reply, Infallible> {
    
    let req = db.lock().await;
    let reqs: VecDeque<ProductReq> = req.clone();
    Ok(warp::reply::json(&reqs))
}

pub async fn create_manufacture(
    new_req: ProductReq,
    db: Db,
) -> Result<impl warp::Reply, Infallible> {
    
    let mut reqs = db.lock().await;
    for req in reqs.iter() {
        if req.MessageAttributeProductId == new_req.MessageAttributeProductId {
            return Ok(StatusCode::BAD_REQUEST);
        }
    }
    if reqs.len() >= 10 {
        reqs.pop_front();
    }
    reqs.push_back(new_req);
    Ok(StatusCode::CREATED)
}

pub async fn delete_customer(requester: String, db: Db) -> Result<impl warp::Reply, Infallible> {
    let mut reqs = db.lock().await;

    let reqs_count = reqs.len();

    reqs.retain(|req| req.MessageAttributeRequester != requester);

    let deleted = reqs.len() != reqs_count;
    if deleted {
        Ok(StatusCode::NO_CONTENT)
    } else {
        Ok(StatusCode::NOT_FOUND)
    }
}