class CalibreTui < Formula
  desc "Search and open books in a Calibre library from a terminal UI"
  homepage "https://github.com/WindustH/calibre-tui"
  version "0.6.4"
  license "MIT"
  head "https://github.com/WindustH/calibre-tui.git", branch: "master"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.6.4/calibre-tui-0.6.4-aarch64-apple-darwin.tar.gz"
    sha256 "a5e140a65c81d21a25c79755286258686049c7eddd1f45050af5391be3f5de23"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.6.4/calibre-tui-0.6.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4b7cd08ba186cf763ab842680a4f6b2b38e34a5bde2af80eb9c47d0ff6e6454e"
  end

  depends_on "rust" => :build if build.head?
  depends_on "sqlite"
  depends_on "xdg-utils" if OS.linux?

  def install
    if build.head?
      system "git", "submodule", "update", "--init", "--recursive"
      system "cargo", "install", *std_cargo_args
    else
      bin.install "calibre-tui"
      doc.install "README.md"
      doc.install Dir["README.*.md"]
      doc.install "doc" if File.directory?("doc")
      doc.install "preset"
    end
  end

  test do
    assert_match "calibre-tui", shell_output("#{bin}/calibre-tui --help")
  end
end
