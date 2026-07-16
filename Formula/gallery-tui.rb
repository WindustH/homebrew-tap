class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.2"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.2/gallery-tui-0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "2e708e7c2fcb68c4f0c3a3b0eeeebbe419c8e3c0107b01c5c7298e598c1ad01a"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.2/gallery-tui-0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "efd82dffb788847f3b7835c1a9f68f06d913fe9b3f332b0defa7d44624792ebe"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.2/gallery-tui-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8c4620ea64ae41fda55471a4e038283b71d0023dbbed4bddf3d909b00efb5592"
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
