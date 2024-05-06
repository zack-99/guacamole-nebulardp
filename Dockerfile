ARG GUACD_BASE_IMAGE=1.5.5
FROM guacamole/guacd:${GUACD_BASE_IMAGE} AS builder

USER root

# Install build dependencies
RUN apk add --no-cache \
        git            \
        autoconf       \
        automake       \
        autoconf       \
        make           \
        pkgconfig      \
        libtool        \
        alpine-sdk     \
        libpng-dev     \
        jpeg-dev       \
        cairo-dev      \
        freerdp-dev    \
        libogg-dev     \
        libvorbis-dev  \
        libwebp-dev    \
        cunit-dev

# Copy source to container for sake of build
ARG BUILD_DIR=/tmp/guacamole-nebulardp
COPY . ${BUILD_DIR}

#
# Base directory for installed guacamole build artifacts.
#
ARG GUACAMOLE_DIR=/opt/guacamole

#
# Base directory for installed guacamole-nebulardp build artifacts.
#
ARG PREFIX_DIR=/tmp/guacamole-nebulardp-build

# Build guacamole-server and its core protocol library dependencies
RUN ${BUILD_DIR}/src/guacd-docker/bin/build-protocol.sh


















# Use same Alpine version as the base for the runtime image
FROM guacamole/guacd:${GUACD_BASE_IMAGE}

#
# Base directory for installed build artifacts. See also the
# CMD directive at the end of this build stage.
#
# NOTE: Due to limitations of the Docker image build process, this value is
# duplicated in an ARG in the first stage of the build.
#
ARG PREFIX_DIR=/tmp/guacamole-nebulardp-build
ARG GUACAMOLE_DIR=/opt/guacamole

# Run with user root
USER root

# Copy build artifacts into this stage
COPY --from=builder ${PREFIX_DIR} ${GUACAMOLE_DIR}

# Run with user guacd
USER guacd

# Start guacd, listening on port 0.0.0.0:4822
#
# Note the path here MUST correspond to the value specified in the 
# PREFIX_DIR build argument.
#
CMD /opt/guacamole/sbin/guacd -b 0.0.0.0 -L $GUACD_LOG_LEVEL -f