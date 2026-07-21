class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.5"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.5/gallery-tui-0.2.5-aarch64-apple-darwin.tar.gz"
    sha256 "e7bb126f54911ee7105bb23beae5c025f110e6e3893bed2463131ad51482003f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.5/gallery-tui-0.2.5-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c31d294e000537f28b7a9b7adfaa47470280de863b597aaebc8993eea1666f03"
  end

  depends_on "rust" => :build if build.head?
  depends_on "chafa"

  def install
    if build.head?
      system Formula["rust"].opt_bin/"cargo", "install", *std_cargo_args
    else
      bin.install "gallery-tui"
      doc.install "README.md"
      doc.install "doc"
    end
  end

  test do
    assert_match "gallery-tui", shell_output("#{bin}/gallery-tui --help")
  end
end
