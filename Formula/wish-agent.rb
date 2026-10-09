class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.1"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.1/wish-agent-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "3e1056aad48bb884b6a9f60842c65d6f8ca62c521610d9c21af249bc8ca1e46c"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.1/wish-agent-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "28cebcca6979bdebfe06bc6c2f8a4a650c2bfc664216008ad39546c15ca0d084"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.1/wish-agent-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d2ab2b2ba0f32db8acc7de16b6dca1a5bc8d1197f56dec2f842e7dfbc53feb9"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.1/wish-agent-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ad321cb99b9ab144799bd58bcf1c2ee2317899de27905b4ca917fcede0ea66e"
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
