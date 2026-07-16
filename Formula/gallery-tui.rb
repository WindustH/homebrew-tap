class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.1"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.1/gallery-tui-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "98a0276f4d163c3c436404ccc9a0a227cbe6e3e313c639e1b361362ad9437b17"
    else
      url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.1/gallery-tui-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "b226d008783acaa27927e40c62d7b021a53e7719f4f0032b20f23dec917092cd"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.1/gallery-tui-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "cbd51c94aea6c5ee420af24e95d8de14d4935b542e81d28c4cf01c8c95e0480b"
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
