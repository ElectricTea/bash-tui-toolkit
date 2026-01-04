#!/bin/bash
# @name Logging
# @brief Provide logging helpers for structured logging

# Log levels
LOG_DEBUG=0
LOG_INFO=1
LOG_WARN=2
LOG_ERROR=3

# @description Log at level using named function
#
# @arg $1 (optional) message to log
# @ example
#   # empty error message
#   error
# @example
#   # error with message
#   error "this is an error message!"

error(){
log "3" "$1"
}
warn(){
log "2" "$1"
}
info(){
log "1" "$1"
}
debug(){
log "0" "$1"
}

# @description Parse log level from text representation to level number
#
# @arg $1 string Log level to parse
# @stdout numeric log level
# @set LOG_LEVEL the global log level to use in the script
# @example
#   # Parse lower case log level
#   parse_log_level "info"
# @example
#   # Parse upper case log level
#   parse_log_level "ERROR"
# @example
#   # Parse numericlog level
#   parse_log_level 2
#   parse_log_level "2"

parse_log_level() {
  local level="$1"
  local parsed

  case "${level}" in
      debug | DEBUG | 0) parsed=$LOG_DEBUG; ;;
      info | INFO | 1)   parsed=$LOG_INFO; ;;
      warn | WARN | 2)   parsed=$LOG_WARN; ;;
      error | ERROR | 3) parsed=$LOG_ERROR; ;;
      *)             parsed=-1; ;;
  esac

  export LOG_LEVEL="${parsed}"
}

# @description Log output on a given level, checks if $LOG_LEVEL, if not set defaults to INFO
# @arg $1 numeric log level OR $1 string variable name log level
# @arg $2 string Message to output
# @stdout Formatted log message with ANSI color codes
# @examples
# log 0 "This is a debug message"
# log 1 "This is an info message"
# log 2 "This is a warn message"
# log 3 "This is an error message"
# log "$LOG_DEBUG" "This is a debug message"
# log "$LOG_INFO" "This is an info message"
# log "$LOG_WARN" "This is a warn message"
# log "$LOG_ERROR" "This is an error message"

log() {
  local level="$1"
  local message="$2"
  local color=""

  if [[ $level -lt ${LOG_LEVEL:-$LOG_INFO} ]]; then
    return
  fi

  case "${level}" in
      "$LOG_DEBUG")
        level="DEBUG"
        color='\033[1;34m'
        ;;

      "$LOG_INFO")
        level="INFO"
        color='\033[1;36m'
        ;;

      "$LOG_WARN")
        level="WARN"
        color='\033[0;33m'
        ;;

      "$LOG_ERROR")
        level="ERROR"
        color='\033[0;31m'
        ;;
  esac

  echo -e "[${color}$(printf '%-5s' "${level}")\033[0m] \033[1;35m$(date +'%Y-%m-%dT%H:%M:%S')\033[0m ${message}"
}
