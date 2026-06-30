class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.1.3"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.3/gallery-tui-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "89b6455dfd5b3c1b3220a9962adb926e4d0e532761d387d516830297f00a0e63"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.3/gallery-tui-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "48f0d6ae5df6b09b6d350735d5c1694ed7da17c143b0dec119e26576a7015af4"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.3/gallery-tui-0.1.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "be86ecdc5d7c46d3f7781bbe3a9cc339ad3e92351cd318d06c286159cfe184f4"
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
