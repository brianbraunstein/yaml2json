#!/bin/bash -eu

function main() {
  cd "$(dirname "$(readlink -f "$0")")"

  rm -rf results
  mkdir -p results

  for x in *.yaml; do
    test_one "${x%.yaml}" || touch results/failed
  done | tee results/tmp

  if [[ -e results/failed ]]; then
    mv results/tmp results/failure
    exit 1
  fi

  mv results/tmp results/success
}

function test_one() {
  echo -n "Testing $1: "

  result=$(../genfiles/yaml2json-pretest < "$1.yaml")
  expected=$(< "$1.json")
  [[ "$expected" == "$result" ]] && {
    echo "success"
    return 0
  }

  echo "ERROR"
  (
    echo "---- expected --------------------------"
    echo "$expected"
    echo "----------------------------------------"
    echo "---- result ----------------------------"
    echo "$result"
    echo "----------------------------------------"
  ) | sed 's/^/  /'
  return 1
}

main

