class CalibreTui < Formula
  desc "Search and open books in a Calibre library from a terminal UI"
  homepage "https://github.com/WindustH/calibre-tui"
  version "0.6.0"
  license "MIT"
  head "https://github.com/WindustH/calibre-tui.git", branch: "master"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.6.0/calibre-tui-0.6.0-aarch64-apple-darwin.tar.gz"
    sha256 "87c74743232487f9e9c20f64f8e023bee97a33bca36e24f8e2aace2558655f41"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.6.0/calibre-tui-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c875274daae1e1be16a93e4a33d08a8b98835ab04e96fd9984437cb21906b699"
  end

  depends_on "rust" => :build if build.head?
  depends_on "sqlite"
  depends_on "xdg-utils" if OS.linux?

  def install
    if build.head?
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
