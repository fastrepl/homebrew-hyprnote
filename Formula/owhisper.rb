class Owhisper < Formula
  desc "OWhisper"
  homepage "https://github.com/fastrepl/hyprnote/tree/main/owhisper"
  version "0.0.1"
  
  sha256 :no_check

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-aarch64-apple-darwin"
    else
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-x86_64-apple-darwin"
    end
  end
  
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-aarch64-unknown-linux-gnu"
    else
      url "https://github.com/fastrepl/hyprnote/releases/download/owhisper_v#{version}/owhisper-server-x86_64-unknown-linux-gnu"
    end
  end
  
  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "owhisper-server-aarch64-apple-darwin" => "owhisper"
      else
        bin.install "owhisper-server-x86_64-apple-darwin" => "owhisper"
      end
    else
      if Hardware::CPU.arm?
        bin.install "owhisper-server-aarch64-unknown-linux-gnu" => "owhisper"
      else
        bin.install "owhisper-server-x86_64-unknown-linux-gnu" => "owhisper"
      end
    end
  end
  
  test do
    system "#{bin}/owhisper", "--version"
  end
end
