class Atp < Formula
  desc "One command for all the platforms: read, search, post, chat and download"
  homepage "https://github.com/WindustH/atp"
  version "0.3.0"
  license "MIT"

  head do
    url "https://github.com/WindustH/atp.git", branch: "main"
    depends_on "cmake" => :build
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.3.0/atp-0.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "6244730a78b099f8fc32cf4a3b1f605d4f54ef71d321ba7a95b078a5a648c450"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/atp/releases/download/v0.3.0/atp-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d8f0a0c291383fdf13cd23e538ee46b274c71c067c351646311b908e8c6a1323"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.3.0/atp-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "dc9ac31318d3b7f165b0dda73602f1a4ce2b0d719fb433e61919956f898ce373"
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "atp"
      doc.install "README.md", "README.zh-CN.md"
    end
  end

  def caveats
    <<~EOS
      ffmpeg is optional: ATP uses it to merge video and audio downloads.
        brew install ffmpeg
    EOS
  end

  test do
    assert_match "atp #{version}", shell_output("#{bin}/atp --version")
  end
end
