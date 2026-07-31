#!/bin/zsh
# collect-system-state.zsh — read-only macOS system state collector
# Never uses sudo. Never modifies the system. Writes only to stdout.
# Errors/diagnostics go to stderr.

set -u
# Intentionally NOT using set -e: optional checks must not abort the run.

emulate -L zsh

typeset -i SCRIPT_FAILED=0

section() {
  print -- ""
  print -- "================================================================"
  print -- "$1"
  print -- "================================================================"
}

subsection() {
  print -- ""
  print -- "--- $1 ---"
}

have() {
  command -v "$1" >/dev/null 2>&1
}

run_safe() {
  # Usage: run_safe "label" cmd arg...
  local label="$1"
  local rc=0
  shift
  subsection "$label"
  "$@" 2>&1
  rc=$?
  if (( rc != 0 )); then
    print -- "[skipped/failed] $label (exit $rc)" >&2
    print -- "[unavailable or failed]"
  fi
  return 0
}

run_if() {
  # Usage: run_if "label" "cmdname" cmd arg...
  local label="$1"
  local cmdname="$2"
  shift 2
  if have "$cmdname"; then
    run_safe "$label" "$@"
  else
    subsection "$label"
    print -- "[command not found: $cmdname]"
  fi
}

redact_line() {
  # Light redaction for tokens and hardware identifiers
  sed -E \
    -e 's/(api[_-]?key|token|password|secret|authorization)[=:][[:space:]]*[^[:space:]]+/\1=[REDACTED]/Ig' \
    -e 's/Bearer[[:space:]]+[A-Za-z0-9._~+\/-]+=*/Bearer [REDACTED]/g' \
    -e 's/(Serial Number[^:]*:).*/\1 [REDACTED]/' \
    -e 's/(Hardware UUID:).*/\1 [REDACTED]/' \
    -e 's/(Provisioning UDID:).*/\1 [REDACTED]/'
}

# ---------------------------------------------------------------------------
section "COLLECTION META"
print -- "timestamp: $(/bin/date -u '+%Y-%m-%dT%H:%M:%SZ')"
print -- "collector: collect-system-state.zsh"
print -- "host_user: $(/usr/bin/id -un 2>/dev/null || print unknown)"
print -- "cwd: $(/bin/pwd)"
print -- "note: read-only collection; no sudo; no persistent files written by this script"

# ---------------------------------------------------------------------------
section "SYSTEM IDENTITY"
run_if "Computer name" scutil /usr/sbin/scutil --get ComputerName
run_if "Local HostName" scutil /usr/sbin/scutil --get LocalHostName
run_if "HostName" scutil /usr/sbin/scutil --get HostName
run_if "sw_vers" sw_vers /usr/bin/sw_vers
run_if "uname" uname /usr/bin/uname -a
run_if "architecture" uname /usr/bin/uname -m

# ---------------------------------------------------------------------------
section "HARDWARE"
if have system_profiler; then
  subsection "SPHardwareDataType (summary)"
  /usr/sbin/system_profiler SPHardwareDataType 2>/dev/null | /usr/bin/head -n 40 | redact_line || print -- "[unavailable]"
else
  subsection "SPHardwareDataType"
  print -- "[system_profiler not found]"
fi
run_if "sysctl hw summary" sysctl /usr/sbin/sysctl -n hw.model machdep.cpu.brand_string hw.ncpu hw.memsize 2>/dev/null

# ---------------------------------------------------------------------------
section "UPTIME AND BOOT"
run_if "uptime" uptime /usr/bin/uptime
if have sysctl; then
  subsection "boot time"
  /usr/sbin/sysctl -n kern.boottime 2>/dev/null || print -- "[unavailable]"
fi

# ---------------------------------------------------------------------------
section "STORAGE"
run_if "df -h" df /bin/df -h
if have diskutil; then
  subsection "APFS list (brief)"
  /usr/sbin/diskutil apfs list 2>/dev/null | /usr/bin/head -n 80 || print -- "[unavailable]"
fi
if have tmutil; then
  run_safe "Time Machine status" /usr/bin/tmutil status
  subsection "local snapshots (limited)"
  /usr/bin/tmutil listlocalsnapshots / 2>/dev/null | /usr/bin/head -n 30 || print -- "[unavailable or none]"
fi

# ---------------------------------------------------------------------------
section "MEMORY AND PRESSURE"
run_if "vm_stat" vm_stat /usr/bin/vm_stat
run_if "memory_pressure" memory_pressure /usr/bin/memory_pressure
if have sysctl; then
  subsection "load averages / swap"
  /usr/sbin/sysctl -n vm.loadavg vm.swapusage 2>/dev/null || print -- "[unavailable]"
fi

# ---------------------------------------------------------------------------
section "PROCESSES (LIMITED)"
if have ps; then
  subsection "top CPU (10)"
  /bin/ps -axo pid,pcpu,pmem,rss,comm -r 2>/dev/null | /usr/bin/head -n 11 || print -- "[unavailable]"
  subsection "top memory RSS (10)"
  /bin/ps -axo pid,pcpu,pmem,rss,comm -m 2>/dev/null | /usr/bin/head -n 11 || print -- "[unavailable]"
  subsection "zombie-like state sample"
  /bin/ps -axo pid,stat,comm 2>/dev/null | /usr/bin/awk '$2 ~ /Z/ {print}' | /usr/bin/head -n 20 || print -- "[none or unavailable]"
fi

# ---------------------------------------------------------------------------
section "BATTERY AND THERMAL"
if have pmset; then
  subsection "battery (pmset -g batt)"
  /usr/bin/pmset -g batt 2>/dev/null || print -- "[unavailable]"
  subsection "thermal (pmset -g therm)"
  /usr/bin/pmset -g therm 2>/dev/null || print -- "[unavailable]"
fi

# ---------------------------------------------------------------------------
section "LAUNCH SERVICES SUMMARY"
if have launchctl; then
  subsection "launchctl list (user, first 80 lines)"
  /bin/launchctl list 2>/dev/null | /usr/bin/head -n 80 || print -- "[unavailable]"
  subsection "possibly failed user jobs (non-zero last exit, sample)"
  /bin/launchctl list 2>/dev/null | /usr/bin/awk 'NR==1 || ($1+0 != 0 && $1 != "-") {print}' | /usr/bin/head -n 40 || print -- "[unavailable]"
fi
subsection "User LaunchAgents directory listing"
if [[ -d "$HOME/Library/LaunchAgents" ]]; then
  /bin/ls -la "$HOME/Library/LaunchAgents" 2>/dev/null | /usr/bin/head -n 60
else
  print -- "[no ~/Library/LaunchAgents]"
fi
subsection "System LaunchAgents listing (names only, limited)"
if [[ -d /Library/LaunchAgents ]]; then
  /bin/ls /Library/LaunchAgents 2>/dev/null | /usr/bin/head -n 60
else
  print -- "[unavailable]"
fi
subsection "System LaunchDaemons listing (names only, limited)"
if [[ -d /Library/LaunchDaemons ]]; then
  /bin/ls /Library/LaunchDaemons 2>/dev/null | /usr/bin/head -n 60
else
  print -- "[unavailable]"
fi

# ---------------------------------------------------------------------------
section "HOMEBREW"
BREW=""
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW=/opt/homebrew/bin/brew
elif [[ -x /usr/local/bin/brew ]]; then
  BREW=/usr/local/bin/brew
fi
if [[ -n "$BREW" ]]; then
  subsection "brew path / version"
  print -- "brew: $BREW"
  "$BREW" --version 2>/dev/null || print -- "[version unavailable]"
  subsection "brew prefix / arch hints"
  "$BREW" --prefix 2>/dev/null || true
  /usr/bin/file "$BREW" 2>/dev/null || true
  subsection "brew services list"
  "$BREW" services list 2>/dev/null || print -- "[services unavailable]"
  subsection "brew doctor (read-only advisory; may warn)"
  # brew doctor does not modify; may take time — bound via timeout if available
  if have timeout; then
    /usr/bin/timeout 45 "$BREW" doctor 2>&1 | /usr/bin/head -n 80 | redact_line || print -- "[doctor timed out or failed]"
  else
    "$BREW" doctor 2>&1 | /usr/bin/head -n 80 | redact_line || print -- "[doctor failed]"
  fi
else
  print -- "[Homebrew not found at /opt/homebrew/bin/brew or /usr/local/bin/brew]"
fi

# ---------------------------------------------------------------------------
section "NETWORKING"
run_if "interfaces (ifconfig summary)" ifconfig /sbin/ifconfig -a
run_if "default route" route /usr/sbin/route -n get default
if have scutil; then
  subsection "DNS (scutil --dns, limited)"
  /usr/sbin/scutil --dns 2>/dev/null | /usr/bin/head -n 60 || print -- "[unavailable]"
fi
if have netstat; then
  subsection "listening TCP (netstat -anp tcp, limited)"
  /usr/sbin/netstat -anp tcp 2>/dev/null | /usr/bin/grep -i LISTEN | /usr/bin/head -n 40 || print -- "[unavailable]"
fi
if have lsof; then
  subsection "listening sockets (lsof -nP -iTCP -sTCP:LISTEN, limited)"
  /usr/sbin/lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null | /usr/bin/head -n 40 || print -- "[unavailable]"
fi

# ---------------------------------------------------------------------------
section "SECURITY POSTURE"
if [[ -x /usr/libexec/ApplicationFirewall/socketfilterfw ]]; then
  subsection "Application Firewall"
  /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null || print -- "[unavailable]"
fi
run_if "FileVault status" fdesetup /usr/bin/fdesetup status
run_if "Gatekeeper status" spctl /usr/sbin/spctl --status
run_if "SIP status" csrutil /usr/bin/csrutil status

# ---------------------------------------------------------------------------
section "APPLE SILICON / ROSETTA"
run_if "uname -m" uname /usr/bin/uname -m
if [[ -x /usr/bin/pgrep ]]; then
  subsection "oahd (Rosetta) process"
  if /usr/bin/pgrep -x oahd >/dev/null 2>&1; then
    print -- "oahd running: yes (Rosetta translation service present)"
  else
    print -- "oahd running: no"
  fi
fi
if [[ -d /Library/Apple/usr/libexec/oah ]]; then
  print -- "Rosetta install path present: /Library/Apple/usr/libexec/oah"
fi
subsection "sample Intel binaries among top processes (best-effort, limited)"
if have ps && have file; then
  /bin/ps -axo pid,comm -r 2>/dev/null | /usr/bin/tail -n +2 | /usr/bin/head -n 25 | while read -r pid comm; do
    # Resolve path when possible
    path=$(/bin/ps -p "$pid" -o comm= 2>/dev/null)
    [[ -z "$path" ]] && continue
    if [[ -x "$path" ]]; then
      ft=$(/usr/bin/file -b "$path" 2>/dev/null || true)
      case "$ft" in
        *x86_64*|*i386*)
          print -- "pid=$pid path=$path type=$ft"
          ;;
      esac
    fi
  done | /usr/bin/head -n 15
fi

# ---------------------------------------------------------------------------
section "CRASHES AND LOGS (LIMITED)"
subsection "DiagnosticReports (names, limited)"
for d in "$HOME/Library/Logs/DiagnosticReports" /Library/Logs/DiagnosticReports; do
  if [[ -d "$d" ]]; then
    print -- "dir: $d"
    /bin/ls -lt "$d" 2>/dev/null | /usr/bin/head -n 15 || true
  fi
done
if have log; then
  subsection "recent shutdown causes (last 24h, limited)"
  /usr/bin/log show --style syslog --predicate 'eventMessage CONTAINS "Previous shutdown cause"' --last 1d 2>/dev/null | /usr/bin/tail -n 20 || print -- "[unavailable without privileges or no matches]"
fi

# ---------------------------------------------------------------------------
section "SOFTWARE UPDATES (LIST ONLY)"
if have softwareupdate; then
  subsection "softwareupdate --list"
  /usr/sbin/softwareupdate --list 2>&1 | /usr/bin/head -n 40 || print -- "[unavailable]"
else
  print -- "[softwareupdate not found]"
fi

# ---------------------------------------------------------------------------
section "SYSTEM EXTENSIONS (BRIEF)"
if have systemextensionsctl; then
  /usr/bin/systemextensionsctl list 2>/dev/null | /usr/bin/head -n 40 || print -- "[unavailable]"
else
  print -- "[systemextensionsctl not found]"
fi

# ---------------------------------------------------------------------------
section "COLLECTION COMPLETE"
print -- "status: complete"
print -- "script_failed_flag: $SCRIPT_FAILED"
exit 0
