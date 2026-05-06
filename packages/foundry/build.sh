TERMUX_PKG_HOMEPAGE=https://github.com/foundry-rs/foundry
TERMUX_PKG_DESCRIPTION="A blazing fast, portable and modular toolkit for Ethereum application development"
TERMUX_PKG_VERSION=1.7.0
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE-MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_SRCURL="git+https://github.com/foundry-rs/foundry.git"
TERMUX_PKG_DEPENDS="libiconv, ca-certificates, zlib, openssl, libssh2, pcre2, libgit2"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	termux_setup_rust
}

termux_step_make() {
	cargo build \
		--bin forge \
		--bin anvil \
		--bin cast \
		--bin chisel \
		--jobs "${TERMUX_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--no-default-features \
		--features="cli"
}

termux_step_make_install() {
	for binary in forge anvil cast chisel; do
		install -Dm755 \
			target/"${CARGO_TARGET_NAME}"/release/$binary \
			"$TERMUX_PREFIX"/bin/$binary
	done
}
