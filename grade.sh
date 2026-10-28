#!/usr/bin/env bash
set -u
PASS=0; FAIL=0
pass(){ echo "PASS: $1"; PASS=$((PASS+1)); }
fail(){ echo "FAIL: $1"; FAIL=$((FAIL+1)); }
echo "=== Assignment 1 - Linux / Bash / Networking / Git ==="
for f in README.md system-info.sh disk-check.sh network-check.sh; do
  [[ -f "$f" ]] && pass "Required file exists: $f" || fail "Missing required file: $f"
done
mkdir -p logs
for f in system-info.sh disk-check.sh network-check.sh; do
  if [[ -f "$f" ]]; then
    bash -n "$f" >/dev/null 2>&1 && pass "Bash syntax: $f" || fail "Bash syntax: $f"
    [[ -x "$f" ]] && pass "Executable: $f" || fail "Not executable: $f"
  fi
done
if [[ -x ./system-info.sh ]]; then
  output=$(./system-info.sh 2>&1); rc=$?
  [[ $rc -eq 0 ]] && pass "system-info.sh exits successfully" || fail "system-info.sh exit code $rc"
  for term in hostname user kernel uptime; do
    echo "$output" | grep -qi "$term" && pass "system-info contains $term" || fail "system-info missing $term"
  done
fi
if [[ -x ./disk-check.sh ]]; then
  for input in 0 101 abc; do
    ./disk-check.sh "$input" >/dev/null 2>&1; rc=$?
    [[ $rc -eq 2 ]] && pass "disk-check rejects invalid threshold '$input'" || fail "disk-check should reject '$input' with code 2"
  done
  ./disk-check.sh 100 / >/dev/null 2>&1; rc=$?
  [[ $rc -eq 0 || $rc -eq 1 ]] && pass "disk-check accepts valid threshold/path" || fail "disk-check valid input failed"
fi
if [[ -x ./network-check.sh ]]; then
  ./network-check.sh >/dev/null 2>&1; rc=$?
  [[ $rc -ne 0 ]] && pass "network-check rejects missing host" || fail "network-check should reject missing host"
  ./network-check.sh localhost >/dev/null 2>&1; rc=$?
  [[ $rc -eq 0 || $rc -eq 1 ]] && pass "network-check accepts localhost input" || fail "network-check localhost test failed"
  for port in 0 65536 abc; do
    ./network-check.sh localhost "$port" >/dev/null 2>&1; rc=$?
    [[ $rc -eq 2 ]] && pass "network-check rejects invalid port '$port'" || fail "network-check should reject port '$port' with code 2"
  done
fi
if find logs -type f ! -name .gitkeep -print -quit 2>/dev/null | grep -q .; then
  pass "Log file was created"
else
  fail "No log file found under logs/"
fi
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  commits=$(git rev-list --count HEAD 2>/dev/null || echo 0)
  [[ "$commits" -ge 5 ]] && pass "Git has at least 5 commits" || fail "Git has fewer than 5 commits"
  branches=$(git for-each-ref --format='%(refname:short)' refs/heads | grep -vE '^(main|master)$' | wc -l | tr -d ' ')
  [[ "$branches" -ge 1 ]] && pass "Non-main branch exists" || echo "WARN: no local feature branch found"
else
  echo "WARN: Git checks skipped"
fi
echo "======================================"; echo "Passed: $PASS"; echo "Failed: $FAIL"
[[ $FAIL -eq 0 ]]
