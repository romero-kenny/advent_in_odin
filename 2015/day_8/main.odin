package day_8

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

string_info :: struct {
	char_in_string, char_in_memory: int,
}

read_line :: proc(line: string) -> string_info {
	string_end, escape, hexa: bool
	hexa_buffer: rune
	count_mem: int
	for char in line {
		switch char {
		case '\\':
			if escape {
				count_mem = count_mem + 1
				escape = false

			} else {
				escape = true
			}
		case '"':
			if escape {
				count_mem = count_mem + 1
				escape = false
			}
		case 'x':
			if escape {
				hexa = true
				escape = false
				hexa_buffer = 0
			} else {
				count_mem = count_mem + 1
			}
		case '0' ..= '9', 'a' ..= 'f':
			if hexa {
				if hexa_buffer != 0 {
					count_mem = count_mem + 1
					hexa = false
				} else {
					hexa_buffer = char
				}
			} else {
				count_mem = count_mem + 1
			}
		case:
			if char != ' ' && char != '\n' {
				count_mem = count_mem + 1
			}
			if hexa {
				hexa = false
			}
		}
	}
	return {len(line), count_mem}
}

part_one :: proc(input: string) -> (answer: int) {
	// we don't even have to write the characters out, we know what each
	// code should be, so we can just add instead of the write the string
	input_split := strings.split_lines(input)
	defer delete(input_split)
	for line in input_split {
		line_info := read_line(line)
		answer = answer + (line_info.char_in_string - line_info.char_in_memory)
	}
	return
}

encode_line :: proc(line: string) -> string_info {
	buffer: [64]byte
	builder := strings.builder_from_bytes(buffer[:])
	strings.write_rune(&builder, '"')

	count_encoded := len(line) > 1 ? 2 : 0
	count_original: int
	for char in line {
		switch char {
		case '"', '\\':
			count_encoded = count_encoded + 2
			strings.write_rune(&builder, '\\')
		case:
			count_encoded = count_encoded + 1
		}
		strings.write_rune(&builder, char)
	}

	strings.write_rune(&builder, '"')
	tmp_str := strings.to_string(builder)
	fmt.println("original: ", line, len(line), "\nencoded: ", tmp_str, count_encoded)

	return {count_encoded, len(line)}
}

part_two :: proc(input: string) -> (answer: int) {
	input_split := strings.split_lines(input)
	defer delete(input_split)
	for line in input_split {
		line_info := encode_line(line)
		answer = answer + (line_info.char_in_string - line_info.char_in_memory)
	}
	return
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
	fmt.println("Day 8 - Part One:", part_one(string(file)))
	fmt.println("Day 8 - Part Two:", part_two(string(file)))
}
