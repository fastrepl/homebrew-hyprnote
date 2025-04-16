cask "hyprnote@nightly" do
  version :latest
  sha256 :no_check
  
  url "https://cdn.crabnebula.app/download/fastrepl/hyprnote/latest/platform/dmg-aarch64?channel=nightly"
  name "Hyprnote Nightly"
  desc "Nightly build of Hyprnote application"
  homepage "https://github.com/fastrepl/hyprnote"
  
  auto_updates true
  depends_on macos: ">= :sonoma"
  
  app "Hyprnote Nightly.app"
  
  zap trash: [
    "~/Library/Application Support/com.hyprnote.nightly",
  ]
end
