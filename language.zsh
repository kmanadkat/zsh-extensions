language_segment() {

  # --- Node.js ---
  if [[ -f package.json ]]; then
    if command -v node >/dev/null 2>&1; then
      echo "%F{46} $(node -v)%f "
      return
    fi
  fi

  # --- Python (virtualenv first priority) ---
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name=$(basename "$VIRTUAL_ENV")
    local py_version=$(python3 --version 2>&1 | awk '{print $2}')
    echo "%F{39} ${venv_name}:${py_version}%f "
    return
  fi

  # --- Python project detection ---
  if [[ -f pyproject.toml || -f requirements.txt || -f setup.py || -f Pipfile ]]; then
    if command -v python3 >/dev/null 2>&1; then
      local py_version=$(python3 --version 2>&1 | awk '{print $2}')
      echo "%F{39} ${py_version}%f "
      return
    fi
  fi
}
