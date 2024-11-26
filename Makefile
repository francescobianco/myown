
push:
	git add .
	git commit -am "Release"
	git push

test:
	bash tests/bare/simple-test.sh
