mod constants;

use std::{*, error::Error};

use chrono::prelude::*;


macro_rules! err {
    ($($arg:tt)*) => {{
        println!("Error: {}", format!($($arg)*));
        process::exit(1);
    }};
}

fn main() {
    if let Err(e) = script() {
        panic!("{}", e)
    }
}

fn script() -> Result<(), Box<dyn Error>> {
    let downloads_path = path::Path::new(constants::DOWNLOADS);
    let trash_path = path::Path::new(constants::TRASH);
    let now = Local::now();

    // log current time
    println!("-------[ {} ]-------", now.format("%Y-%m-%d %H:%M:%S"));

    // iterate over the contents of downloads
    let entries = match fs::read_dir(downloads_path) {
        Ok(reader) => reader,
        Err(e) => err!("Couldn't read Downloads directory: {}", e),
    };
    for entry_path in entries {
        let path = entry_path?.path();
        println!("{}", path.display());
        

        // // if the file is not .DS_Store, move it to the trash
        // if file_name != constants::DS_STORE {
        //     fs::rename(&path, trash_path.join(file_name)).unwrap();
        // }
    }
    println!("Hello, world!");


    Ok(())
}
