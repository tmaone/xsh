#!/bin/sh
#
# usage: jlchecksum <filename>
#

if [ -z "$1" ]; then
    echo "Usage: ./jlchecksum <filename>" >&2
    exit 1
fi

# Get the directory of this script
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Get the basename of the file we're trying to checksum
BASENAME=$(basename $1)

# Print out a hash, and wrap around if we're longer than 64 characters
print_hash()
{
    if [ ${#1} -gt 64 ]; then
        NUM_LINES=$(( (${#1} + 63) / 64))
        for i in `seq 0 1 $((NUM_LINES - 1))`; do
            str_piece=$(echo "$1" | awk "{ string=substr(\$0, $((i*64 + 1)), $(((i+1)*64))); print string; }")
            echo "      $str_piece"
        done
    else
        echo "      $1" >&2
    fi
}

checksum_error()
{
    echo "===============================================================================" >&2
    echo "  ERROR: $CHECKSUM_TYPE checksum failure on $BASENAME, should be:" >&2
    print_hash "$TRUE_CHECKSUM"
    echo "  But \`$CHECKSUM_PROG\` results in:" >&2
    print_hash "$CURR_CHECKSUM"
    echo "  This can happen due to bad downloads or network proxies, please check your" >&2
    echo "  network proxy/firewall settings and delete deps/$BASENAME" >&2
    echo "  to force a redownload when you are ready" >&2
    echo "===============================================================================" >&2
    exit 2
}

find_checksum()
{
    if [ ! -f "$DIR/checksums/$BASENAME/$CHECKSUM_TYPE" ]; then
        echo "WARNING: $CHECKSUM_TYPE checksum for $BASENAME not found in deps/checksums/, autogenerating..." >&2

        # Generate as many checksum types as we can
        mkdir -p checksums/$BASENAME
        if [ ! -z "$MD5_PROG" ]; then
            echo $(eval $MD5_PROG) > "$DIR/checksums/$BASENAME/md5"
        fi
        if [ ! -z "$SHA512_PROG" ]; then
            echo $(eval $SHA512_PROG) > "$DIR/checksums/$BASENAME/sha512"
        fi
    fi

    TRUE_CHECKSUM=$(cat "$DIR/checksums/$BASENAME/$CHECKSUM_TYPE")
}

# These are the programs we run to hash a file
SHA512_PROG=""
MD5_PROG=""
find_checksum_progs()
{
    if [ ! -z $(which sha512sum) ]; then
        SHA512_PROG="sha512sum $BASENAME | awk '{ print \$1; }'"
    elif [ ! -z $(which shasum) ]; then
        SHA512_PROG="shasum -a 512 $BASENAME | awk '{ print \$1; }'"
    fi

    if [ ! -z $(which md5sum) ]; then
        MD5_PROG="md5sum $BASENAME | awk '{ print \$1; }'"
    elif [ ! -z $(which md5) ]; then
        MD5_PROG="md5 -q $BASENAME"
    fi
}


# Search for checksum programs and store them into SHA512_PROG, MD5_PROG, etc...
find_checksum_progs

# Choose final checksumming program, preferring SHA512 over MD5
if [ ! -z "$SHA512_PROG" ]; then
    CHECKSUM_TYPE="sha512"
    CHECKSUM_PROG=$SHA512_PROG
elif [ ! -z "$MD5_PROG" ]; then
    CHECKSUM_TYPE="md5"
    CHECKSUM_PROG=$MD5_PROG
else
    echo "WARNING: No checksumming programs found, cannot verify downloads" >&2
    exit 0
fi

# Find true checksum
find_checksum "$CHECKSUM_TYPE"

# Calculate actual checksum
CURR_CHECKSUM=$(eval $CHECKSUM_PROG)

# Make sure they're the same.  If not, error out!
if [ "$TRUE_CHECKSUM" != "$CURR_CHECKSUM" ]; then
    checksum_error
fi
