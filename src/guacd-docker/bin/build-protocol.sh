cd "$BUILD_DIR"
autoreconf -fi && ./configure --prefix="$PREFIX_DIR"
make && make check && make install