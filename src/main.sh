usage() {
	echo "Usage: myown [-r] file1 [file2 ...]"
	echo "  -r    Apply changes recursively"
	exit 1
}

main() {

	# Leggi utente e gruppo di $HOME
	USER_GROUP=$(ls -ld "$HOME" | awk '{print $3 ":" $4}')

	# Variabile per la modalità ricorsiva
	RECURSIVE=""
	TARGETS=""

	# Analizza gli argomenti
	for ARG in "$@"; do
		if [ "$ARG" = "-r" ]; then
			RECURSIVE="-R"
		else
			TARGETS="$TARGETS $ARG"
		fi
	done

	# Controlla che ci siano file o directory
	if [ -z "$TARGETS" ]; then
		usage
	fi

	# Applica utente e gruppo agli argomenti
	for TARGET in $TARGETS; do
		if [ -e "$TARGET" ]; then
			chown $RECURSIVE "$USER_GROUP" "$TARGET" >/dev/null 2>/dev/null && true
			if [ $? -eq 0 ]; then
				echo "Changed ownership of $TARGET to $USER_GROUP"
			else
				echo "High privileded are required"
				sudo chown $RECURSIVE "$USER_GROUP" "$TARGET" && true
				if [ $? -eq 0 ]; then
					echo "Changed ownership of $TARGET to $USER_GROUP"
				else
					echo "Failed to change ownership of $TARGET" >&2
				fi

			fi
		else
			echo "File or directory $TARGET does not exist" >&2
		fi
	done

}
