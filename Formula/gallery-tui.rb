class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  version "0.2.16"
  license "MIT"

  head do
    url "https://github.com/WindustH/gallery-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.16/gallery-tui-0.2.16-aarch64-apple-darwin.tar.gz"
    sha256 "f6274a9a0894e18f02b838756391f8f5b26b0d1c4cb89bdc12593ed04dac5652"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/gallery-tui/releases/download/v0.2.16/gallery-tui-0.2.16-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f17c77053cb976c7c3011e7451036cdc18b3b14957045b8f5ea0ecb343abd078"
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
