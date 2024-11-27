
push:
	git add .
	git commit -am "Release"
	git push

format:
	@shfmt -w src/
	@shfmt -p src/ >/dev/null

test:
	bash tests/bare/simple-test.sh
