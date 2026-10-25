class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.3"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.3/wish-agent-0.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "5c1e4ad5e20486ffeb6b7fc5387d194e651c5d9d819cae56061ed9d9537408e3"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.3/wish-agent-0.2.3-x86_64-apple-darwin.tar.gz"
      sha256 "89f0d1b04d7370e070d0b4f9e5561e7a7eb0ad49dbab40e2503bc05219d50066"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.3/wish-agent-0.2.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "91173c4af8538a772858efeb1895b3835c2b0c6fd2c96d6324db52b5dfbfddb4"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.3/wish-agent-0.2.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "133392a01c62a088843ddba54bef3ec2ce3ab13048249e3113f3423919cc7ab0"
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
