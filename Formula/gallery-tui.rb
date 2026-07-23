class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.6"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.6/gallery-tui-0.2.6-aarch64-apple-darwin.tar.gz"
    sha256 "3f3166681bca11c0ce649116782756ef9bd8b31d23e2b0f680636edb4834c1b8"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.6/gallery-tui-0.2.6-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8b75ac2d2814da1c87972abc43705310be4156ee5e95850b9681a4746cae5f45"
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
