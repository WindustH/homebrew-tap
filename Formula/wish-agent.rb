class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.2"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.2/wish-agent-0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "a4dbed5aac9e2fbff69efe5246d8756d94c8c248ba11ef66662b4d0329bbb6c2"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.2/wish-agent-0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "c07a9e402808afc1839027364d098ad772cf16ddeb79e118223506ff699ffd6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.2/wish-agent-0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f092ae167ae07b880cdc94657ba13ed3d2aa3b8457f11e93e66ed0c88cb9cf9"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.2/wish-agent-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "68c47b004acb0ce86906e41a13b29f1e7983f1a11231b6296bccbd1118c6a3bc"
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
