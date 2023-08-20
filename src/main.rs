pub mod pathmerge;

mod prelude {
    pub use crate::pathmerge::{make_pathmerge_command, run_pathmerge};
}

use prelude::*;

fn main() {
    let output = run_pathmerge(make_pathmerge_command().get_matches());
    println!("{}", output);
}
