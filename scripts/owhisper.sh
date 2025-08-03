#!/usr/bin/env bash

set -e

echo "Fetching latest release..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/fastrepl/hyprnote/releases/latest | grep '"tag_name":' | grep -o 'owhisper_v[0-9.]*' | head -1)

if [ -z "$LATEST_VERSION" ]; then
    echo "Error: Could not fetch latest release"
    exit 1
fi

VERSION="${LATEST_VERSION#owhisper_v}"
echo "Latest version: $VERSION"

echo "Calculating SHA256 checksums..."
SHA_ARM_MAC=$(curl -sL "https://github.com/fastrepl/hyprnote/releases/download/${LATEST_VERSION}/owhisper-server-aarch64-apple-darwin" | shasum -a 256 | awk '{ print $1 }')
SHA_X86_MAC=$(curl -sL "https://github.com/fastrepl/hyprnote/releases/download/${LATEST_VERSION}/owhisper-server-x86_64-apple-darwin" | shasum -a 256 | awk '{ print $1 }')
SHA_X86_LINUX=$(curl -sL "https://github.com/fastrepl/hyprnote/releases/download/${LATEST_VERSION}/owhisper-server-x86_64-unknown-linux-gnu" | shasum -a 256 | awk '{ print $1 }')

echo "ARM Mac SHA256: $SHA_ARM_MAC"
echo "x86 Mac SHA256: $SHA_X86_MAC"
echo "x86 Linux SHA256: $SHA_X86_LINUX"

FORMULA_FILE="${0%/*}/../Formula/owhisper.rb"

cat <<EOF > "$FORMULA_FILE"
class Owhisper < Formula
  desc "OWhisper"
  homepage "https://github.com/fastrepl/hyprnote/tree/main/owhisper"
  version "$VERSION"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-aarch64-apple-darwin"
      sha256 "$SHA_ARM_MAC"
    else
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-x86_64-apple-darwin"
      sha256 "$SHA_X86_MAC"
    end
  end
  
  on_linux do
    url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-x86_64-unknown-linux-gnu"
    sha256 "$SHA_X86_LINUX"
  end
  
  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "owhisper-server-aarch64-apple-darwin" => "owhisper"
      else
        bin.install "owhisper-server-x86_64-apple-darwin" => "owhisper"
      end
    else
      bin.install "owhisper-server-x86_64-unknown-linux-gnu" => "owhisper"
    end
  end
  
  test do
    system "#{bin}/owhisper", "--version"
  end
end
EOF

echo "Formula updated successfully!"
