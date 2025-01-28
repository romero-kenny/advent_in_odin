package day_4

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:crypto/hash"

part_one :: proc(input, prefix_key: string) -> (answer: int) {
	for i in 0..=5_000_000 {
		itoa_buffer: [16]byte

		str_i := strconv.itoa(itoa_buffer[:], i)
		concat, err := strings.concatenate([]string{input, str_i})
		defer delete(concat)
		// fmt.println(concat)

		test := hash.hash_string(hash.Algorithm.Insecure_MD5, concat)
		defer delete(test)
		test_str := fmt.aprintf("%02x", string(test))
		// fmt.println(test_str)

		if strings.has_prefix(test_str, prefix_key){
			answer = i
			return
		}
	}
	return
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
	
	part_1 := part_one(strings.trim_space(string(file)), "00000")
	fmt.println("Day 4 - Part 1:", part_1)

	part_2 := part_one(strings.trim_space(string(file)), "000000")
	fmt.println("Day 4 - Part 2:", part_2)

}
