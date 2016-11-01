hello.so: hello.cpp
	clang++ -fPIC -shared $< -o $@

hello.exe: hello.cpp
	clang++ $< -o $@
	./$@
