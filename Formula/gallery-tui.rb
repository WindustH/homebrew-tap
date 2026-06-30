class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.1.1"
  license "MIT"
  head "https://github.com/WindustH/gallery-tui.git", branch: "master"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.1/gallery-tui-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "faf4b224790a0d3466e9010c6b478daf920c83740e7ec5fdd9682d16186c616c"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.1/gallery-tui-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "cf050b374f634000f190ea5b1ced7946c1c8ca45058b6d60eebb6c733a269ab6"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.1/gallery-tui-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a3430a1daabb2699785fd9b491d1451339a4ef6e2c39ed338966352e702d7043"
  end

  depends_on "rust" => :build if build.head?
  depends_on "chafa"

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
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
