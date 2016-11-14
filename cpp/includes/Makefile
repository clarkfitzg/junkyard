# -o is output file
# -g generates debug information
hello.exe: hello.c
	clang $< -o $@ -g
	./$@

# dots.txt: hello.c
# 	clang -dependency-dot $@ $< 

headers: hello.c
	clang $< -MD
