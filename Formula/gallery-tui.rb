class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.1.4"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.4/gallery-tui-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "f5503396a8009a00b683394d8b08016e241bf04d71bb38fb6775fe1eae5d06dd"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.4/gallery-tui-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "8b00b2a544718099aeffb0ee3f30f8c3bf037d4c1be38e87b58347ba312f9e87"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.1.4/gallery-tui-0.1.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ac75cac03d73238680f1ccf48558a8c29f5d82fe1d2167dd4435e6ab6590544a"
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
