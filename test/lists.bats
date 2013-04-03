#!/usr/bin/env bats

load test_helper

@test "list_insert: insert before; found item" {
  l=a:b:c
  list_insert l d c
  assert_equal "a:b:d:c" $l
}

@test "list_insert: insert after; found item" {
  l=a:b:c
  list_insert l d c after
  assert_equal "a:b:c:d" $l
}

@test "list_insert: insert before; item not found" {
  L=A:B:C
  list_insert L D G
  assert_equal "D:A:B:C" $L
}

@test "list_insert: insert after; item not found" {
  L=A:B:C
  list_insert L D G after
  assert_equal "A:B:C:D" $L
}

@test "list_insert: insert before; index" {
  l=a:b:c
  list_insert l d 2
  assert_equal "a:b:d:c" $l
}

@test "list_insert: insert after; index" {
  l=a:b:c
  list_insert l d 2 after
  assert_equal "a:b:c:d" $l
}

@test "list_insert: insert before; negative index" {
  l=a:b:c
  list_insert l d -2
  assert_equal "a:d:b:c" $l
}

@test "list_insert: insert after; negative index" {
  l=a:b:c
  list_insert l d -2 after
  assert_equal "a:b:d:c" $l
}

@test "list_insert: insert before; past end of list" {
  l=a:b:c
  list_insert l d 5
  assert_equal "a:b:c:d" $l
}

@test "list_insert: insert after; past end of list" {
  l=a:b:c
  list_insert l d 5 after
  assert_equal "a:b:c:d" $l
}

@test "list_insert: insert before; before start of list" {
  l=a:b:c
  list_insert l d -5
  assert_equal "d:a:b:c" $l
}

@test "list_insert: insert after; before start of list" {
  l=a:b:c
  list_insert l d -5 after
  assert_equal "d:a:b:c" $l
}

@test "list_add_dir: dir exists; not in list" {
  l=a:b:c
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  list_add_dir l $dir
  assert_equal "${dir}:a:b:c" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir exists; not in list; append" {
  l=/bin:/usr/bin:/usr/local/bin
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  list_add_dir l $dir append
  assert_equal "/bin:/usr/bin:/usr/local/bin:${dir}" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir exists; already in list" {
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  l="/bin:/usr/bin:/usr/local/bin:${dir}"
  list_add_dir l $dir
  assert_equal "/bin:/usr/bin:/usr/local/bin:${dir}" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir exists; already in list; append" {
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  l="${dir}:/bin:/usr/bin:/usr/local/bin"
  list_add_dir l $dir append
  assert_equal "${dir}:/bin:/usr/bin:/usr/local/bin" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir doesn't exist" {
  l=a:b:c
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}/.not-here"

  list_add_dir l $dir
  assert_equal "a:b:c" $l

  list_add_dir l $dir append
  assert_equal "a:b:c" $l
}

@test "list_add_dir: dir exists; not in list; other found" {
  l=a:b:c
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  list_add_dir l $dir '' b
  assert_equal "a:${dir}:b:c" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir exists; not in list; other found; append" {
  l=a:b:c
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  list_add_dir l $dir append b
  assert_equal "a:b:${dir}:c" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir exists; not in list; other not found" {
  l=a:b:c
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  list_add_dir l $dir '' g
  assert_equal "${dir}:a:b:c" $l
  rmdir ${dir} &>/dev/null || true
}

@test "list_add_dir: dir exists; not in list; other not found; append" {
  l=a:b:c
  dir="${BATS_TMPDIR}/${BATS_TEST_NAME}"
  mkdir ${dir} &>/dev/null || true
  list_add_dir l $dir append g
  assert_equal "a:b:c:${dir}" $l
  rmdir ${dir} &>/dev/null || true
}

# vim:sw=2:ts=2:sts=2:et:ft=sh:
