class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.1.3"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.3/wish-agent-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "88aad54f476dab1e771ec8e66f1e1d5e2622693cc2cd3ffae3bb1ebe3e9ddc24"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.3/wish-agent-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "767b520e239ad7b8e1966270595c0bcd1da673c5f823704a34ce499ac097c65f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.3/wish-agent-0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c8d396138fb92a5c6203b2c9571d4398dfdec784cc7f45d0cec97a5d47980da"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.3/wish-agent-0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0dfc25f167c0ad90846d1049b7f2a2a41a49aec15f1050617580bffd3303419e"
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
