# From https://github.com/fogleman/AdventOfCode2018/blob/master/1.py

import fileinput

# Creates a list of lines from stdin using fileinput.input().
# THe list is Iterable
lines = list(fileinput.input())

def part1():
    return sum(map(int, lines))

def part2():
    f = 0
    seen = {f}
    while True:
        for line in lines:
            f += int(line)
            if f in seen:
                return f
            seen.add(f)

print(part1())
print(part2())