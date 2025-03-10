#!/bin/sh
BIN_DIR="$RUNNER_TOOL_CACHE/cocogitto/$COG_VERSION"

if ! [ -f $BIN_DIR/cog ]; then
    case ${RUNNER_ARCH}_${RUNNER_OS} in
    ARM_Linux)
        COG_VARIANT="armv7-unknown-linux-musleabihf"
        ;;
    ARM64_Linux)
        COG_VARIANT="aarch64-unknown-linux-gnu"
        ;;
    X64_macOS)
        COG_VARIANT="x86_64-apple-darwin"
        ;;
    X64_Linux)
        COG_VARIANT="x86_64-unknown-linux-musl"
        ;;
    X64_Windows)
        COG_VARIANT="x86_64-pc-windows-msvc"
        ;;
    *)
        echo "::error:: cog is not supported on ${RUNNER_ARCH} and ${RUNNER_OS}"
        echo See https://github.com/cocogitto/cocogitto/releases
        exit 1
        ;;
    esac

    TAR="cocogitto-${COG_VERSION}-${COG_VARIANT}.tar.gz"
    mkdir -p "$BIN_DIR"
    cd "$BIN_DIR" || exit
    curl -OL https://github.com/cocogitto/cocogitto/releases/download/"$COG_VERSION"/"$TAR"
    tar --strip-components=1 -xzf $TAR
    rm $TAR
fi

echo "$BIN_DIR" >> "$GITHUB_PATH"
