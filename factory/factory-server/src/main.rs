mod db;
mod models;
mod handlers;
mod routes;

#[macro_use]
extern crate log;

#[tokio::main]
async fn main() {
    pretty_env_logger::init();
    let db = db::init_db();
    let req_routes = routes::factory_routes(db);
    warp::serve(req_routes)
        .run(([127,0,0,1], 4000))
        .await;
}
