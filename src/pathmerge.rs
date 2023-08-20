use clap::{Arg, ArgAction, ArgMatches, Command};
use std::collections::BTreeSet;

pub fn make_pathmerge_command() -> Command {
    Command::new("pathmerge")
        .version(env!("CARGO_PKG_VERSION"))
        .arg(
            Arg::new("delimiter")
                .help("Specify delimiter to use, bash ':', fish ' '")
                .default_value(":")
                .short('d')
                .long("delimiter"),
        )
        .arg(
            Arg::new("path")
                .help("Path string")
                .short('p')
                .long("path")
                .env("PATH"),
        )
        .arg(
            Arg::new("sort")
                .help("If the resulting output should be sorted")
                .short('s')
                .long("sort")
                .action(ArgAction::SetTrue),
        )
        .arg(
            Arg::new("paths")
                .help("list of paths to include")
                .num_args(0..),
        )
}
pub fn run_pathmerge(matches: ArgMatches) -> String {
    // get delimiter (String)
    let delimiter = matches
        .get_one::<String>("delimiter")
        .expect("Problem with delmiter");

    // get paths (Vec<&str>)
    let mut sys_path: Vec<&str> = matches
        .get_one::<String>("path")
        .expect("Problem reading path argument")
        .split(delimiter)
        .collect();

    // get sort (bool)
    let should_sort = *matches.get_one::<bool>("sort").expect("With sort flag");

    // get paths (Vec<&String>)
    let pths: Vec<&String> = matches
        .get_many::<String>("paths")
        .unwrap_or_default()
        .collect();

    //
    pths.iter().for_each(|s: &&String| {
        sys_path.push(s);
    });

    // Use the successful insertion into the btree set determine which elements
    // to keep to retain ordering. Then throw away the btree.
    {
        let mut bt = BTreeSet::new();
        let _ = &sys_path.retain(|x| bt.insert(*x));
    }

    if should_sort {
        sys_path.sort()
    } else {
        // don't sort
    };
    sys_path.join(delimiter)
}
