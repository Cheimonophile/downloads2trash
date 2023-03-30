mod constants;
mod logging;

use std::{*};

macro_rules! err {
    ($($arg:tt)*) => {{
        log::error!($($arg)*);
        process::exit(1);
    }};
}

fn main() {
    logging::setup();
    if let Err(e) = script() {
        err!("{}", e)
    }
}

fn script() -> Result<(), Box<dyn error::Error>> {

    // get home directory
    let home_path_str = env::var("HOME")?;
    let home_path = path::Path::new(&home_path_str);
    let downloads_path = home_path.join(constants::DOWNLOADS);
    let trash_path = home_path.join(constants::TRASH);

    // iterate over the contents of downloads
    let entries = match fs::read_dir(downloads_path) {
        Ok(reader) => reader,
        Err(e) => err!("Couldn't read Downloads directory: {}", e),
    };
    for entry_path in entries {
        let file_path = entry_path?.path();
        let file_name = match file_path.file_name().and_then(|s| s.to_str()) {
            Some(s) => s,
            None => {log::warn!("Couldn't parse {}", file_path.display()); continue},
        };

        // make sure the file is not .DS_Store
        if file_name == constants::DS_STORE {
            continue;
        }

        // check if the file is in the last 7 days
        let btime = fs::File::open(&file_path)?.metadata()?.created()?;
        let diff = time::SystemTime::now().duration_since(btime)?;
        if diff < constants::MAX_AGE {
            continue;
        }


        // check that the file is in the last 7 days
        log::info!("{}", file_name);
        log::warn!("{}", trash_path.exists());
        fs::rename(&file_path, trash_path.join(file_name))?;
    }


    Ok(())
}
