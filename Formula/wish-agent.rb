class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.5"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.5/wish-agent-0.2.5-aarch64-apple-darwin.tar.gz"
      sha256 "63fbf0eefec61aeb9607e835cebeff2e25f3497b73007255593349fc6faf7915"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.5/wish-agent-0.2.5-x86_64-apple-darwin.tar.gz"
      sha256 "4be0d3658416c5626bddef231ce872fbb8639edab451476444f23b42140eecf7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.5/wish-agent-0.2.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "191068a5c5158ac5da02ada2294282629232ff7a948a98f2dfc64fe37bd142d7"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.5/wish-agent-0.2.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f197b1d561f15d32456d6dfae7881d92f5c5b9587080313217d36de3d5cc300"
    end
  end

  def install
    # The program finds its web app beside it; bin holds a link.
    libexec.install "wish", "web"
    bin.install_symlink libexec/"wish"
    doc.install "README.md"
  end

  service do
    run [opt_bin/"wish"]
    keep_alive true
    working_dir Dir.home
    environment_variables PATH: std_service_path_env
    log_path var/"log/wish-agent.log"
    error_log_path var/"log/wish-agent.log"
  end

  test do
    assert_match "wish #{version}", shell_output("#{bin}/wish --version")
  end
end
