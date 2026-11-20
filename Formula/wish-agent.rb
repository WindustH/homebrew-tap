class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.10"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.10/wish-agent-0.2.10-aarch64-apple-darwin.tar.gz"
      sha256 "2f41dbaafee42bc626b02d25c147e34fb95d8ef5b9f745296acc8f5a66a5ce72"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.10/wish-agent-0.2.10-x86_64-apple-darwin.tar.gz"
      sha256 "3774f7e6b5fb767281fa6e08b638eadb1d86bf9e3d1ea2b8067f6f82fc03bdbc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.10/wish-agent-0.2.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eba997e77d80af5025363ea36643c0b2afeca1be63125a8233b7ff8f23a022fe"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.10/wish-agent-0.2.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "56b78ff6b1b47b9c45e16b5a1c10a6628b6401909df3eb3db499ef60552ed4e8"
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
