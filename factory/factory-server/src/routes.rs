use std::convert::Infallible;
use warp::{self, Filter};

use crate::db::Db;
use crate::handlers;
use crate::models::ProductReq;

pub fn factory_routes(
    db: Db
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
     get_reqs_list(db.clone())
        .or(create_req(db.clone()))
}

fn get_reqs_list(
    db:Db
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    warp::path("manufactures")
            .and(warp::get())
            .and(with_db(db))
            .and_then(handlers::list_manufactures)
} 

fn create_req(
    db:Db
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    warp::path("manufactures")
        .and(warp::post())
        .and(body_to_json())
        .and(with_db(db))
        .and_then(handlers::create_manufacture)
}

fn with_db(db: Db) -> impl Filter<Extract = (Db,), Error = Infallible> + Clone {
    warp::any().map(move || db.clone())
}

fn body_to_json() -> impl Filter<Extract = (ProductReq, ), Error = warp::Rejection> + Clone {
    warp::body::content_length_limit(1024*16)
            .and(warp::body::json())
}