class CalibreTui < Formula
  desc "Search and open books in a Calibre library from a terminal UI"
  homepage "https://github.com/WindustH/calibre-tui"
  version "0.6.1"
  license "MIT"
  head "https://github.com/WindustH/calibre-tui.git", branch: "master"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.6.1/calibre-tui-0.6.1-aarch64-apple-darwin.tar.gz"
    sha256 "8b25be50fbbcc34655f859fe3199d80f7f8488e8a0e789344c8738772cde6647"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.6.1/calibre-tui-0.6.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0389535769c68a78e7e4678c91e95f8d5f6bc59fc4e69c173b95dc065e7ee1cb"
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
