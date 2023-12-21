#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/loeffel-io/ls-lint"
TOOL_NAME="ls-lint"
TOOL_TEST="ls-lint -h"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if ls-lint is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# Change this function if ls-lint has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url arch platform
	version="$1"
	filename="$2"

	arch=$(uname -m)
	case $arch in
	arm64) arch="arm64" ;; # m1 macs
	aarch64) arch="arm64" ;;
	*) arch="amd64" ;;
	esac
	platform="$(uname | tr '[:upper:]' '[:lower:]')-${arch}"
	# Adapt the release URL convention for ls-lint
	url="$GH_REPO/releases/download/v${version}/ls-lint-${platform}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	# debug
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"
		chmod +x "$install_path/$TOOL_NAME"
		$install_path/$TOOL_TEST
		# TODO: Assert ls-lint executable exists.
		test -x "$install_path/$TOOL_TEST" || fail "Expected $install_path/$TOOL_NAME to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
