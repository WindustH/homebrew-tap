class GalleryTui < Formula
  desc "Terminal image gallery powered by Ratatui and Chafa"
  homepage "https://github.com/WindustH/gallery-tui"
  url "https://github.com/WindustH/gallery-tui/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "6da590cf3661e29c1f3ea7baf0ebd1c348b681cfdfea6f3f853cb236ee962d25"
  license "MIT"
  head "https://github.com/WindustH/gallery-tui.git", branch: "master"

  depends_on "rust" => :build
  depends_on "chafa"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "gallery-tui", shell_output("#{bin}/gallery-tui --help")
  end
end
