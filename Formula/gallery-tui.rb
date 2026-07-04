class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.1.6"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.6/gallery-tui-0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "25760cb73cb03822dde1ad56a883b4e2b9ab4d1c765c286976f58a9d3f55dc11"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.6/gallery-tui-0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "8532c7567aa12cd3c0deb794f5b0ed9c4bf5ee7a45b59dd8140204ef73a3e35c"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.6/gallery-tui-0.1.6-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "65c14fb0384a9795219c83b0c5346da28cfd92a93bdb2d79a9b852f94ed417d7"
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
