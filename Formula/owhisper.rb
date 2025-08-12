class Owhisper < Formula
  desc "OWhisper"
  homepage "https://github.com/fastrepl/hyprnote/tree/main/owhisper"
  version "0.0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://owhisper.hyprnote.com/download/latest/macos-aarch64"
      sha256 "a3c6b217ec202e3ebe2dbb8aee0ceb039c5179e0fcf89a4d9101d517dfaf52a9"
    else
      url "https://owhisper.hyprnote.com/download/latest/macos-x86_64"
      sha256 "3bc3aaf8318695e4dd7d7e2fadba62bf814594147d9099f2ef44f024c9ff234e"
    end
  end
  
  on_linux do
    url "https://owhisper.hyprnote.com/download/latest/linux-x86_64"
    sha256 "189ee0a2f843fb8b659023fa9a5caf03a585e784a43f8583591c962aa5da2823"
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
