class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.11"
  license "MIT"
  head do
    url "https://github.com/WindustH/music-tui.git", branch: "main"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.11/music-tui-0.1.11-aarch64-apple-darwin.tar.gz"
    sha256 "635c503d1d00b696235854646065197c7938cd6c85508c4722173bf7ce9b70ee"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.11/music-tui-0.1.11-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0c2f76f20bda5483995387d7b875f8a2fb70f79de51f06088a0b73cc30015f33"
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
