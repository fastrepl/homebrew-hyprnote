#!/usr/bin/env bash

set -e

VERSION="0.0.3"

echo "Calculating SHA256 checksums..."
SHA_ARM_MAC=$(curl -sL "https://owhisper.hyprnote.com/download/latest/macos-aarch64" | shasum -a 256 | awk '{ print $1 }')
SHA_X86_MAC=$(curl -sL "https://owhisper.hyprnote.com/download/latest/macos-x86_64" | shasum -a 256 | awk '{ print $1 }')
SHA_X86_LINUX=$(curl -sL "https://owhisper.hyprnote.com/download/latest/linux-x86_64" | shasum -a 256 | awk '{ print $1 }')

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
      url "https://owhisper.hyprnote.com/download/latest/macos-aarch64"
      sha256 "$SHA_ARM_MAC"
    else
      url "https://owhisper.hyprnote.com/download/latest/macos-x86_64"
      sha256 "$SHA_X86_MAC"
    end
  end
  
  on_linux do
    url "https://owhisper.hyprnote.com/download/latest/linux-x86_64"
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
