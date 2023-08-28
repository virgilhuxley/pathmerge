# pathmerge

## help output

```
Usage: pathmerge [OPTIONS] [paths]...

Arguments:
  [paths]...  list of paths to include

Options:
  -d, --delimiter <delimiter>  Specify delimiter to use, bash ':', fish ' ' [default: :]
  -p, --path <path>            Path string [env: PATH=/home/user/bin:/usr/bin:/usr/local/bin:/usr/local/sbin]
  -s, --sort                   If the resulting output should be sorted
  -h, --help                   Print help
  -V, --version                Print version
```

## Example Usage

### Pull PATH from env and append
```sh
PATH="/path1:/path2:/path3"
PATH="$(pathmerge /path4)"
echo $PATH
# output
/path1:/path2:/path3:/path4
```

### Provide PATH and append

```sh
NEWPATH="$(pathmerge --path /a:/b:/c /z)"

echo $NEWPATH
# output
/a:/b:/c:/z
```

### Deduplicate occurs automatically

```sh
UGLYPATH="/a:/b:/c:/a:/a:/c:/b:/c"
CLEANPATH="$(pathmerge --path $UGLYPATH)"

echo $CLEANPATH
# output
/a:/b:/c
```

### Merge/Deduplicate based on a different delimiter

```sh
PATH="/a /b /c /c /c"
NEWPATH="$(pathmerge --delimiter ' ' /z)"

echo $NEWPATH
# output
/a /b /c /z
```

### Sorting

```sh
PATH="/c:/a:/b"
NEWPATH="$(pathmerge --sort)"

echo $PATH
# output
/a:/b:/c
```

## Additional information

- Specifying the `delimiter` does not cause the output to change the delimiter,
  only what the logic triggers off of.
- `pathmerge` does not modify anything in the shell or environment, it only
  allows you to manipulate PATH formatted strings and outputs those strings.
  It is still up to the user to push those strings into their appropriate
  environment variable. e.g. `PATH=$(pathmerge)` to read from env, Deduplicate
  then push back into the `PATH` variable.
- `pathmerge` is primarily expected to be called/used by `.profiles` and `.*rc`
  files.

## NIX

WIP
