class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.1/wish-agent-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "6b56be2994f6c28a3c48193655a25eebc37793b4a29ac02d4716f71d7c8b04b9"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.1/wish-agent-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "a995d860bc5c356628d6f0b814e8bcb8cfe8c31d573977cedc9e3eeb6c81f3d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.1/wish-agent-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30ae81bd84eb50e172de3fa2a4fbc3854cc804badb42427cca638080c1e916be"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.1/wish-agent-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fbe6a0132ab6a0cb43178bcd01a92e1cc44d9140517c708a478783d38c27989"
    end
  end

  def install
    # The program finds its web app beside it; bin holds a link under the package's name.
    libexec.install "wish", "web"
    bin.install_symlink libexec/"wish" => "wish-agent"
    doc.install "README.md"
  end

  service do
    run [opt_bin/"wish-agent"]
    keep_alive true
    working_dir Dir.home
    environment_variables PATH: std_service_path_env
    log_path var/"log/wish-agent.log"
    error_log_path var/"log/wish-agent.log"
  end

  test do
    assert_match "wish-agent #{version}", shell_output("#{bin}/wish-agent --version")
  end
end
