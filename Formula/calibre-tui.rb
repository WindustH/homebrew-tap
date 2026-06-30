class CalibreTui < Formula
  desc "Search and open books in a Calibre library from a terminal UI"
  homepage "https://github.com/WindustH/calibre-tui"
  version "0.5.0"
  license "MIT"
  head "https://github.com/WindustH/calibre-tui.git", branch: "master"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/calibre-tui/releases/download/v0.5.0/calibre-tui-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "9f2a7b2a4caedf738bebb9f6966b6ed1d72d69f279b1412e7fd68cb0e38d0f62"
    else
      url "https://github.com/WindustH/calibre-tui/releases/download/v0.5.0/calibre-tui-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "712df9e8dd155f820949db40791df71f5b2a57a71db97938ecc648e9acffbc8a"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/calibre-tui/releases/download/v0.5.0/calibre-tui-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "754433e8683202fdb0d4959eaef97a1c769fe1adf6be1a2e91b1e98ac77958b1"
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
