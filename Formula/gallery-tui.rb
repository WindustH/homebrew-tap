class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.15"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.15/gallery-tui-0.2.15-aarch64-apple-darwin.tar.gz"
    sha256 "68e0b1004603145f1904604fc46477ebd471d3160ce826a6618a38cbbaa4fa57"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.15/gallery-tui-0.2.15-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "98f2f0573204ed6212213df86b6b20a3a80b8510b81fb535a1a9282e3df258a3"
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
