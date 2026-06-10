#!/bin/bash
# Claude Code status line — powerline-style segments, Catppuccin Mocha.
# Receives session JSON on stdin; first line of stdout is rendered as the status bar.
# Requires a Nerd Font / powerline-patched font for the arrow and branch glyphs.

input=$(cat)

IFS=$'\t' read -r model cwd ctx added removed <<<"$(jq -r '[
  (.model.display_name // "Claude"),
  (.workspace.current_dir // .cwd // ""),
  (.context_window.used_percentage // 0),
  (.cost.total_lines_added // 0),
  (.cost.total_lines_removed // 0)
] | @tsv' <<<"$input")"

# Catppuccin Mocha palette as "R;G;B" — segment colors follow the
# Starship catppuccin-powerline preset: red > peach > yellow > crust > lavender,
# with crust text on colored segments. Git flags use Latte green/red, dark
# enough to read on the yellow segment.
crust="17;17;27"
text="205;214;244"
red="243;139;168"
peach="250;179;135"
yellow="249;226;175"
green="166;227;161"
lavender="180;190;254"
surface1="69;71;90"
dark_green="64;160;43"
dark_red="210;15;57"

# Glyphs via byte escapes — literal PUA chars are invisible in editors and get
# lost too easily.
ARROW=$(printf '\xee\x82\xb0')   # U+E0B0 powerline right arrow
BRANCH=$(printf '\xee\x82\xa0')  # U+E0A0 git branch

out=""
prev_bg=""
# seg <bg> <fg> <content> — content may embed extra fg codes but must not reset
seg() {
  local bg=$1 fg=$2 content=$3
  if [ -n "$prev_bg" ]; then
    out+=$'\e[38;2;'"${prev_bg}m"$'\e[48;2;'"${bg}m${ARROW}"
  fi
  out+=$'\e[48;2;'"${bg}m"$'\e[38;2;'"${fg}m"" ${content} "
  prev_bg=$bg
}

fg() { printf '\e[38;2;%sm' "$1"; }

seg "$red"   "$crust" "✦ ${model}"
seg "$peach" "$crust" "${cwd/#$HOME/~}"

if branch=$(git -C "$cwd" branch --show-current 2>/dev/null) && [ -n "$branch" ]; then
  flags=""
  if ! git -C "$cwd" diff --cached --quiet 2>/dev/null; then flags+="$(fg "$dark_green")+"; fi
  if ! git -C "$cwd" diff --quiet 2>/dev/null; then flags+="$(fg "$dark_red")!"; fi
  seg "$yellow" "$crust" "${BRANCH} ${branch}${flags:+ ${flags}}"
fi

# lines changed: dark surface background, green for added / red for removed
if [ "${added:-0}" != "0" ] || [ "${removed:-0}" != "0" ]; then
  seg "$surface1" "$green" "+${added}$(fg "$text")/$(fg "$red")-${removed}"
fi

seg "$lavender" "$crust" "◐ ${ctx}%"

# close the bar: arrow from last bg onto the default background
out+=$'\e[0m\e[38;2;'"${prev_bg}m${ARROW}"$'\e[0m'

printf '%s\n' "$out"
