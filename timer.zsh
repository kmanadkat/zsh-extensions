preexec() {
  __cmd_start_time=$SECONDS
}

precmd() {
  if [[ -n "$__cmd_start_time" ]]; then
    __cmd_duration=$((SECONDS - __cmd_start_time))
    unset __cmd_start_time
  fi
}

cmd_duration_segment() {
  if [[ -n "$__cmd_duration" && $__cmd_duration -gt 2 ]]; then
    echo "${__cmd_duration}s "
  fi
}
