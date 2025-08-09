class Owhisper < Formula
  desc "OWhisper"
  homepage "https://github.com/fastrepl/hyprnote/tree/main/owhisper"
  version "0.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://owhisper.hyprnote.com/download/latest/macos-aarch64"
      sha256 "54497aeffab1ba8dd953f0e4049a1278bbd0e7d743297058ec57626ca4d4fef2"
    else
      url "https://owhisper.hyprnote.com/download/latest/macos-x86_64"
      sha256 "23f99f04c39e9d47d945abffb97c557b379f6d70dbb616c5b9d138444d0c5d53"
    end
  end
  
  on_linux do
    url "https://owhisper.hyprnote.com/download/latest/linux-x86_64"
    sha256 "e7fe54cba659f411507a524e174ed25eb3e4fc6feab82bb8a0f6817bf182da99"
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
