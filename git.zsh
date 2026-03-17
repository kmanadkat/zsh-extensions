git_branch() {
  git symbolic-ref --short HEAD 2>/dev/null || \
  git rev-parse --short HEAD 2>/dev/null
}

git_segment() {
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  local git_output
  git_output=$(git status --porcelain 2>/dev/null)

  local added=0
  local staged=0
  local modified=0
  local untracked=0
  local deleted=0

  while IFS= read -r line; do
    [[ -z "$line" ]] && continue

    # Untracked
    if [[ "$line" == "??"* ]]; then
      ((untracked++))
      continue
    fi

    local x=${line[1]}
    local y=${line[2]}

    [[ "$x" == "A" ]] && ((added++))
    [[ "$x" != " " && "$x" != "A" ]] && ((staged++))
    [[ "$y" == "M" ]] && ((modified++))
    [[ "$x" == "D" || "$y" == "D" ]] && ((deleted++))

  done <<< "$git_output"

  local ahead behind
  ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
  behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

  local stash=0
  stash=$(git rev-list --walk-reflogs --count refs/stash 2>/dev/null)

  local indicators=""

  [[ $added -gt 0 ]] && indicators+=" ++$added"
  [[ $staged -gt 0 ]] && indicators+=" +$staged"
  [[ $modified -gt 0 ]] && indicators+=" !$modified"
  [[ $untracked -gt 0 ]] && indicators+=" ?$untracked"
  [[ $deleted -gt 0 ]] && indicators+=" ✘$deleted"
  [[ $ahead -gt 0 ]] && indicators+=" ↑$ahead"
  [[ $behind -gt 0 ]] && indicators+=" ↓$behind"
  [[ $stash -gt 0 ]] && indicators+=" ⚑$stash"

  local color=82  # green
  [[ -n "$indicators" ]] && color=221  # red if dirty

  echo "%F{$color} $branch$indicators%f"
}

