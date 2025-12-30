# Logging

Provide logging helpers for structured logging

## Overview

Log statements and log level parsing

## Index

* [log](#log)
* [parse_log_level](#parse_log_level)

### log

Log output on a given level, checks if $LOG_LEVEL, if not set defaults to INFO

#### Example logs

```bash
# numeric log level
log 0 "This is a debug message"
log 1 "This is an info message"
log 2 "This is a warn message"
log 3 "This is an error message"

# string encapsalcated numeric log level
log "0" "This is a debug message"
log "1" "This is an info message"
log "2" "This is a warn message"
log "3" "This is an error message"

# string variable name log level
log "$LOG_DEBUG" "This is a debug message"
log "$LOG_INFO" "This is an info message"
log "$LOG_WARN" "This is a warn message"
log "$LOG_ERROR" "This is an error message"
```

#### Arguments

* **$1** (number): Numeric log level OR * **$1** (string): Variable name log level

* **$2** (string): Message to output

#### Output on stdout

* Formatted log message with ANSI color codes


### parse_log_level

Filter visability of log statements based on level


Parse log level from text representation to level number

#### Example

```bash
# Parse lower case debug log level
parse_log_level "debug"
# Parse upper case info log level
parse_log_level "INFO"
# Parse numeric warn log level
parse_log_level 2
# Parse string encapsulated number error log level
parse_log_level "3"
```

#### Arguments

* **$1** (string) or (number): Log level to parse

#### Variables set

* **LOG_LEVEL** (the): global log level to use in the script

#### Output on stdout

* numeric log level
