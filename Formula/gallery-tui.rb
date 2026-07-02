class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.1.5"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.5/gallery-tui-0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "a7621c6379aef8c800a8c1c9c089af275f4ff50c3fb25f1d8c28405bd31eec9b"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.5/gallery-tui-0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "b5e9e5eaf3fe9e90e3260139b63f29c76d1206cc10cb3813a88dc18e15042979"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.5/gallery-tui-0.1.5-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "4505c658a47512dfb0ec0b7b4801da6d8f66097fdccaa6200cbd0bebc0684b46"
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
