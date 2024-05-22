# Pre-populate build control variables such that the custom build prefix is
# used for C headers, locating libraries, etc.
export CFLAGS="-I${PREFIX_DIR}/include"
export LDFLAGS="-L${PREFIX_DIR}/lib"
export PKG_CONFIG_PATH="${PREFIX_DIR}/lib/pkgconfig" 

# Ensure thread stack size will be 8 MB (glibc's default on Linux) rather than
# 128 KB (musl's default)
export LDFLAGS="$LDFLAGS -Wl,-z,stack-size=8388608"

install_from_git() {

    URL="$1"
    PATTERN="$2"
    shift 2

    # Calculate top-level directory name of resulting repository from the
    # provided URL
    REPO_DIR="$(basename "$URL" .git)"

    # Allow dependencies to be manually omitted with the tag/commit pattern "NO"
    if [ "$PATTERN" = "NO" ]; then
        echo "NOT building $REPO_DIR (explicitly skipped)"
        return
    fi

    # Clone repository and change to top-level directory of source
    cd /tmp
    git clone "$URL"
    cd $REPO_DIR/

    # Locate tag/commit based on provided pattern
    VERSION="$(git tag -l --sort=-v:refname | grep -Px -m1 "$PATTERN" \
        || echo "$PATTERN")"

    # Switch to desired version of source
    echo "Building $REPO_DIR @ $VERSION ..."
    git -c advice.detachedHead=false checkout "$VERSION"

    # Configure build using CMake or GNU Autotools, whichever happens to be
    # used by the library being built
    if [ -e CMakeLists.txt ]; then
        cmake -DCMAKE_INSTALL_PREFIX:PATH="$PREFIX_DIR" "$@" .
    else
        [ -e configure ] || autoreconf -fi
        ./configure --prefix="$PREFIX_DIR" "$@"
    fi

    # Build and install
    make && make install

}

install_from_git "https://github.com/libssh2/libssh2" "$WITH_LIBSSH2" $LIBSSH2_OPTS
install_from_git "https://github.com/seanmiddleditch/libtelnet" "$WITH_LIBTELNET" $LIBTELNET_OPTS

cd "$BUILD_DIR"
autoreconf -fi && ./configure --prefix="$PREFIX_DIR"
make && make check && make install