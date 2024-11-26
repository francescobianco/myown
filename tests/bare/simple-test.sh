
echo "AAA"
#mush build --release

sudo chown root:wheel tests/fixtures/file1.txt
ls -la tests/fixtures/file1.txt
mush run -- tests/fixtures/file1.txt
ls -la tests/fixtures/file1.txt