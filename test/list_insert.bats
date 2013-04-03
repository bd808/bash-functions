#!/usr/bin/env bats

load test_helper

@test "insert before; found item" {
  l=a:b:c
  list_insert l d c
  assert_equal "a:b:d:c" $l
}

@test "insert after; found item" {
  l=a:b:c
  list_insert l d c after
  assert_equal "a:b:c:d" $l
}

@test "insert before; item not found" {
  L=A:B:C
  list_insert L D G
  assert_equal "D:A:B:C" $L
}

@test "insert after; item not found" {
  L=A:B:C
  list_insert L D G after
  assert_equal "A:B:C:D" $L
}

@test "insert before; index" {
  l=a:b:c
  list_insert l d 2
  assert_equal "a:b:d:c" $l
}

@test "insert after; index" {
  l=a:b:c
  list_insert l d 2 after
  assert_equal "a:b:c:d" $l
}

@test "insert before; negative index" {
  l=a:b:c
  list_insert l d -2
  assert_equal "a:d:b:c" $l
}

@test "insert after; negative index" {
  l=a:b:c
  list_insert l d -2 after
  assert_equal "a:b:d:c" $l
}

@test "insert before; past end of list" {
  l=a:b:c
  list_insert l d 5
  assert_equal "a:b:c:d" $l
}

@test "insert after; past end of list" {
  l=a:b:c
  list_insert l d 5 after
  assert_equal "a:b:c:d" $l
}

@test "insert before; before start of list" {
  l=a:b:c
  list_insert l d -5
  assert_equal "d:a:b:c" $l
}

@test "insert after; before start of list" {
  l=a:b:c
  list_insert l d -5 after
  assert_equal "d:a:b:c" $l
}

# vim:sw=2:ts=2:sts=2:et:ft=sh:
