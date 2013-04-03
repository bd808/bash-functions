fixtures () {
  :
}

setup () {
  for f in bash/functions.d/*; do
    source $f
  done
}

teardown () {
  :
}

flunk () {
  if [ "$#" -eq 0 ]; then
    cat -
  else
    echo "$@"
  fi
  return 1
}

assert_equal () {
  if [ "$1" != "$2" ]; then
    { echo "expected: $1"
      echo "actual: $2"
    } | flunk
  fi
}

assert () {
  if ! "$@"; then
    flunk "failed: $@"
  fi
}
