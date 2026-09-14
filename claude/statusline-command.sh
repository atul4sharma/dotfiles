#!/usr/bin/env bash
# Claude Code status line: model, context usage, session cost, plan, and rate limits.
# Managed by the statusline-setup agent.

input=$(cat)

DIM='\033[2m'
RESET='\033[0m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'

model=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir_name=$(basename "$dir" 2>/dev/null)

# Context window usage (percentage of context used, if available).
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  ctx=$(printf "ctx %.0f%%" "$used_pct")
else
  ctx=""
fi

# Subscription plan label, read from the local account cache (not part of the
# statusLine stdin payload). Best-effort: omit silently if missing/unreadable.
org_type=""
if [ -f "$HOME/.claude.json" ]; then
  org_type=$(jq -r '.oauthAccount.organizationType // empty' "$HOME/.claude.json" 2>/dev/null)
fi
case "$org_type" in
  claude_pro) plan_label="Pro" ;;
  claude_max) plan_label="Max" ;;
  claude_team) plan_label="Team" ;;
  claude_enterprise) plan_label="Enterprise" ;;
  "") plan_label="" ;;
  *) plan_label="$org_type" ;;
esac

# Session cost, if the payload provides it (varies by Claude Code version).
# Flat-fee subscriptions (Pro/Max/Team/Enterprise) aren't billed per token, so
# this dollar figure is just API-list-price noise for them — only show it
# when no subscription plan was detected (API/Console, token-billed usage).
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // .session_cost.total_cost_usd // empty')
if [ -n "$cost" ] && [ -z "$plan_label" ]; then
  cost_str=$(printf "\$%.2f" "$cost")
else
  cost_str=""
fi

# Session duration, if available.
dur_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
if [ -n "$dur_ms" ]; then
  dur_s=$((dur_ms / 1000))
  dur_str=$(printf "%dm%02ds" $((dur_s / 60)) $((dur_s % 60)))
else
  dur_str=""
fi

# Lines added/removed — omitted from the status line (not needed).
# added=$(echo "$input" | jq -r '.cost.total_lines_added // empty')
# removed=$(echo "$input" | jq -r '.cost.total_lines_removed // empty')
# if [ -n "$added" ] || [ -n "$removed" ]; then
#   lines_str="+${added:-0}/-${removed:-0}"
# else
#   lines_str=""
# fi
lines_str=""

# Colorize a percentage: green <70, yellow <90, red >=90.
colorize_pct() {
  local pct="$1"
  local label="$2"
  local color
  if awk -v p="$pct" 'BEGIN{exit !(p<70)}'; then
    color="$GREEN"
  elif awk -v p="$pct" 'BEGIN{exit !(p<90)}'; then
    color="$YELLOW"
  else
    color="$RED"
  fi
  printf "%b%s%b" "$color" "$label" "$RESET$DIM"
}

# Format seconds-from-now until a Unix epoch as "Xh Ym" / "Ym", empty if past/invalid.
format_resets_in() {
  local resets_at="$1"
  [ -z "$resets_at" ] && return
  local now
  now=$(date +%s)
  local delta=$((resets_at - now))
  [ "$delta" -le 0 ] && return
  local h=$((delta / 3600))
  local m=$(((delta % 3600) / 60))
  if [ "$h" -gt 0 ]; then
    printf "%dh%02dm" "$h" "$m"
  else
    printf "%dm" "$m"
  fi
}

# 5-hour / 7-day subscription rate limit usage, if available.
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
rl_str=""
if [ -n "$five" ]; then
  five_label="5h:$(printf '%.0f' "$five")%"
  five_in=$(format_resets_in "$five_resets_at")
  [ -n "$five_in" ] && five_label="$five_label (resets $five_in)"
  rl_str="$(colorize_pct "$five" "$five_label")"
fi
if [ -n "$week" ]; then
  week_label="7d:$(printf '%.0f' "$week")%"
  week_in=$(format_resets_in "$week_resets_at")
  [ -n "$week_in" ] && week_label="$week_label (resets $week_in)"
  week_seg="$(colorize_pct "$week" "$week_label")"
  rl_str="${rl_str:+$rl_str }$week_seg"
fi
if [ -n "$rl_str" ]; then
  rl_str="${plan_label:+$plan_label }$rl_str"
fi

# Assemble the status line, dropping any empty fields.
parts=("$model")
[ -n "$dir_name" ] && parts+=("$dir_name")
[ -n "$ctx" ] && parts+=("$ctx")
[ -n "$cost_str" ] && parts+=("$cost_str")
[ -n "$dur_str" ] && parts+=("$dur_str")
# [ -n "$lines_str" ] && parts+=("$lines_str")
[ -n "$rl_str" ] && parts+=("$rl_str")

out=""
for p in "${parts[@]}"; do
  out="${out:+$out | }$p"
done

printf "${DIM}%b${RESET}" "$out"
