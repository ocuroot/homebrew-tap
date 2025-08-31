class Ocuroot < Formula
  desc "A release orchestrator managing GitOps-like workflows without replacing your existing tools."
  homepage "https://www.ocuroot.com"
  url "https://github.com/ocuroot/ocuroot.git",
      tag:      "v0.3.10",
      revision: "cadaf88ba8c00beddb9d81e955e04dc7936d8714"
  license "Apache-2.0"
  head "https://github.com/ocuroot/ocuroot.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X github.com/ocuroot/ocuroot/about.Version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/ocuroot"

    generate_completions_from_executable(bin/"ocuroot", "completion")
  end

  test do
    system "#{bin}/ocuroot", "version"
  end
end
