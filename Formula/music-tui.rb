class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.9"
  license "MIT"
  head do
    url "https://github.com/WindustH/music-tui.git", branch: "main"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.9/music-tui-0.1.9-aarch64-apple-darwin.tar.gz"
    sha256 "4eada95a88e6c6ed1735a76d5f5a2a3c7e5d74fbe621c9949f7b4a95f6bc140f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.9/music-tui-0.1.9-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "db46694db5f16ee15468847d30aa3d82879b91a6fec3e7efec2a70731a1460be"
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
