with import <nixpkgs> {};
mkShell {
	# Import the Postgres package
	buildInputs = with pkgs; [ postgresql ];

	# Postgres
	PGDATA = ".dbdata";
	# Edit this to set the Postgres database name
	PGDB = "test";

	shellHook = ''
		#### Utils ####
		BINDIR=$PWD/.nix/bin 
		export PATH=$PATH:$BINDIR

		# Console colors
		GREEN='\033[0;32m'
		NC='\033[0m' # No Color

		#### Postgres ####
		# Create data directory if it does not exist and initialize it
		[ ! -d .dbdata ] && mkdir .dbdata && initdb
		# Initialize the database if it does not exist
		pg_ctl -l logfile -o "--unix_socket_directories='$PWD'" start && psql -h $PWD -tAl | cut -d '|' -f 1 | grep -qx "$PGDB" || createdb -h "$PWD" "$PGDB"
		[ -f "$PGDATA/postmaster.pid" ] && pg_ctl stop
		
		printf "$GREEN\nUse 'start' to start Postgres server.\nUse 'stop' to stop Postgres server.\nUse 'sql' to start the Postgres cli.\n\n$NC"
		'';
}
