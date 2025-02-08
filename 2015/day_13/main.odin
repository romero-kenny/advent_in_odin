package day_13

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}


}
