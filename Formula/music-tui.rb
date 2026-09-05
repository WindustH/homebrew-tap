class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.8"
  license "MIT"
  head do
    url "https://github.com/WindustH/music-tui.git", branch: "main"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.8/music-tui-0.1.8-aarch64-apple-darwin.tar.gz"
    sha256 "48f055a3ffe9521945d17de97c861e5b891fdbee0afda0a307d32b99b37e3b78"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.8/music-tui-0.1.8-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "471cdf91736e2d4db45b44c37362656c076663599724688b53a15b08a482d393"
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
