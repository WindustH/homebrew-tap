class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.1"
  license "MIT"
  head "https://github.com/WindustH/music-tui.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.1/music-tui-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "efb9dc0e9e6cb01e4803a899f86ed756792012e9f2b6d90c2afb1f5dedb9613b"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.1/music-tui-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ac8c18f09ee54e9717632c0c67e99a63e018600c75399e83a165ce7977e1722d"
  end

  depends_on "rust" => :build if build.head?
  depends_on "mpd"
  depends_on "chafa"
  depends_on "sqlite"

  def install
    if build.head?
      system "git", "submodule", "update", "--init", "--recursive"
      system "cargo", "install", *std_cargo_args
    else
      bin.install "music-tui"
      doc.install "README.md"
      doc.install "doc" if File.directory?("doc")
    end
  end

  test do
    assert_match "music-tui", shell_output("#{bin}/music-tui --help")
  end
end
