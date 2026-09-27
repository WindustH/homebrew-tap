class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.11"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.11/gallery-tui-0.2.11-aarch64-apple-darwin.tar.gz"
    sha256 "ae13a1b274d89dace99a1802f4a632092da5295bccd6402d35aa5831e3145970"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.11/gallery-tui-0.2.11-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "675d17600b60c908ff126e5a872da1cc8bf8c6a55d0b60cea52e8b294b1ba620"
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
