class CalibreTui < Formula
  desc "Search and open books in a Calibre library from a terminal UI"
  homepage "https://github.com/WindustH/calibre-tui"
  version "0.5.1"
  license "MIT"
  head "https://github.com/WindustH/calibre-tui.git", branch: "master"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/calibre-tui/releases/download/v0.5.1/calibre-tui-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "d6f283440abe29b3a19c95a36af20253f84d75ed26c66ee0bfb659f8b99fe59b"
    else
      url "https://github.com/WindustH/calibre-tui/releases/download/v0.5.1/calibre-tui-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "455ee9f7d80164e27bfcbba35df2b4868566a6de53f0e3ce8663b4c5f9d7fd3a"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.5.1/calibre-tui-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "880cb6f6593d5da020bc0affac1b25fc968c496914799d0e90097439b8bb74ce"
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
