#!/bin/sh
# Build python3-astro_<version>_all.deb from Astro.py / Geo.py / Sun.py / Moon.py.
# Usage: packaging/deb/build.sh
set -eu

cd "$(dirname "$0")/../.."
REPO_ROOT="$(pwd)"
PKG_DIR="$REPO_ROOT/debian-pkg"
VERSION="0.$(git rev-list --count HEAD)"
sed -i "s/^version = .*/version = \"$VERSION\"/" pyproject.toml
sed -i "s/^Version: .*/Version: $VERSION/" packaging/deb/control

rm -rf "$PKG_DIR"
mkdir -p "$PKG_DIR/DEBIAN" "$PKG_DIR/usr/lib/python3/dist-packages"

cp packaging/deb/control "$PKG_DIR/DEBIAN/control"
cp Astro.py Geo.py Sun.py Moon.py "$PKG_DIR/usr/lib/python3/dist-packages/"

dpkg-deb --build --root-owner-group "$PKG_DIR" "python3-astro_${VERSION}_all.deb"

rm -rf "$PKG_DIR"
echo "Built python3-astro_${VERSION}_all.deb"
