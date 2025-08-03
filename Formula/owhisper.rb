class Owhisper < Formula
  desc "OWhisper"
  homepage "https://github.com/fastrepl/hyprnote/tree/main/owhisper"
  version "0.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-aarch64-apple-darwin"
      sha256 "cb4ab56f6a40344bce0c67a4ac22871345af3eea61aa682592a581a806166086"
    else
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-x86_64-apple-darwin"
      sha256 "7704b00230bd640bf39993a442829ae3bca1b0514de1921626799273affd46cd"
    end
  end
  
  on_linux do
    url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-x86_64-unknown-linux-gnu"
    sha256 "09691c00aefe546565657f8f882c1e00518abb9b0a9149a19aecc0537fef4e3f"
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
