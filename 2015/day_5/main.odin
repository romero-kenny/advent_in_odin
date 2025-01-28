package day_5

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

naughty_strings :: [4]string{"ab", "cd", "pq", "xy"}
valid_vowels :: [5]string{"a", "e", "i", "o", "u"}

vowel_check :: proc(input: string) -> (pass: bool) {
	check: int
	for vowel in valid_vowels {
		check = strings.count(input, vowel) + check
	}
	return check > 2 ? true : false
}

double_check :: proc(input: string) -> (pass: bool) {
	for i in 1 ..< len(input) {
		if input[i - 1] == input[i] {return true}
	}
	return
}

naughty_check :: proc(input: string) -> (pass: bool) {
	for word in naughty_strings {
		if strings.contains(input, word) {return false}
	}
	return true
}

part_one :: proc(input: string) -> (total: int) {
	split_lines := strings.split_lines(input)
	defer delete(split_lines)
	for line in split_lines {
		vow_check := vowel_check(line)
		doub_check := double_check(line)
		naught_check := naughty_check(line)

		if vow_check && doub_check && naught_check {total = total + 1}
	}
	return
}

pair_check :: proc(input: string) -> (pass: bool) {
	if len(input) > 3 {
		for i in 1 ..< len(input) {
			for j := i + 2; j < len(input); j = j + 1 {
				if strings.contains(input[i - 1: i + 1], input[j - 1:j + 1]) {return true}
			}
		}
	}
	return
}

repeat_check :: proc(input: string) -> (pass: bool) {
	if len(input) > 2 {
		for i in 2 ..< len(input) {
			if input[i - 2] == input[i] {return true}
		}
	}
	return
}

part_two :: proc(input: string) -> (total: int) {
	split_lines := strings.split_lines(input)
	defer delete(split_lines)
	for line in split_lines {
		pairs := pair_check(line)
		repeat := repeat_check(line)
		if pairs && repeat {total = total + 1} else {fmt.println(line, pairs, repeat)}
	}
	return
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}

	part_1 := part_one(string(file))
	fmt.println("Day 5 - Part 1:", part_1)

	part_2 := part_two(string(file))
	fmt.println("Day 5 - Part 2:", part_2)
}
