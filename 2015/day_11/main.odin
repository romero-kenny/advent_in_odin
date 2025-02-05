package day_eleven

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"
import "core:testing"

string_increment :: proc(input: []rune) -> []rune {
	pos := len(input) - 1
	for {
		input[pos] = input[pos] + 1
		if input[pos] > 'z' {
			input[pos] = 'a'
			pos = (pos - 1 >= 0) ? pos - 1 : len(input) - 1
		} else { break }
	}
	return input
}

has_inc_straight :: proc(input: []rune) -> (has: bool) {
	for i in 0 ..< len(input) - 2 {
		start := input[i]
		if start + 1 == input[i + 1] && start + 2 == input[i + 2] {
			return true
		}
	}
	return
}

@test
has_inc_straight_test :: proc(test: ^testing.T) {
	test_1 := has_inc_straight({'a', 'b', 'c', 'd'})
	test_2 := has_inc_straight({'a', 'b', 'd', 'c'})
	test_3 := has_inc_straight({'d', 'a', 'b', 'c'})

	assert(test_1 == true, "abcd")
	assert(test_2 == false, "abdc")
	assert(test_3 == true, "dabc")

}

has_i_o_l :: proc(input: []rune) -> (has: bool) {
	for char in input {
		switch char {
		case 'i', 'o', 'l':
			return true
		}
	}
	return
}

@test
has_i_o_l_test :: proc(test: ^testing.T) {
	test_1 := has_i_o_l({'i'})
	test_2 := has_i_o_l({'b', 'd', 'e', 'g'})
	test_3 := has_i_o_l({'b', 'd', 'e', 'g', 'i'})

	assert(test_1 == true, "i")
	assert(test_2 == false, "bdeg")
	assert(test_3 == true, "bdegi")

}

has_double_doubles :: proc(input: []rune) -> (has: bool) {
	has_one_double: bool
	for i := 0; i < len(input) - 1; {
		if input[i] == input[i + 1] {
			if has_one_double { return true }
			else {
				has_one_double = true
				i = i + 2
				continue
			}
		}
		i = i + 1
	}
	return
}

@test
has_double_test :: proc(test: ^testing.T) {
	test_1 := has_double_doubles({'a', 'a', 'a', 'a'})
	test_2 := has_double_doubles({'a', 'a', 'a'})

	assert(test_1 == true, "4 As")
	assert(test_2 == false, "3 As")
}

meets_password_standards :: proc(check: []rune) -> bool {
	double_check := has_double_doubles(check)
	i_o_l_check := has_i_o_l(check)
	straight_check := has_inc_straight(check)

	return double_check && !i_o_l_check && straight_check
}

part_one :: proc(transcoded_password: []rune) -> (new_password: []rune) {
	for {
		string_increment(transcoded_password)
		if meets_password_standards(transcoded_password) {break}
	}
	return transcoded_password
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
	password := utf8.string_to_runes(strings.trim_space(string(file)))
	fmt.println("Day 11 - Part 1:", part_one(password))
}
