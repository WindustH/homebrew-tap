class Atp < Formula
  desc "One command for all the platforms: read, search, post, chat and download"
  homepage "https://github.com/WindustH/atp"
  version "0.1.1"
  license "MIT"

  head do
    url "https://github.com/WindustH/atp.git", branch: "main"
    depends_on "cmake" => :build
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.1.1/atp-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "7b7c6fb8381efa4b30875bd35791055a121c8313dc07365e87e7bd104234c656"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/atp/releases/download/v0.1.1/atp-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e13cc6d10fca0c8b3dd242fbf383370a975db07e85dfeec86bba57c13270c3fe"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.1.1/atp-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "ed78ce7bc1d97fe2dcfa10fff8b95e0a0f24c656e74ffdb7b71d0148ca451a7b"
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
