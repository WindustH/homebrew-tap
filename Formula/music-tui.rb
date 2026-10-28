class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.12"
  license "MIT"
  head do
    url "https://github.com/WindustH/music-tui.git", branch: "main"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.12/music-tui-0.1.12-aarch64-apple-darwin.tar.gz"
    sha256 "1b89f3597e530acbe5d54a6c3705f52c9256d6a128df0b8eba4297177d1b5b17"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.12/music-tui-0.1.12-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e1b8ca0bbd6b959793ce3f44d79619cf2f102e36d58ba5f2b4e5a4e68e203af5"
  end

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
