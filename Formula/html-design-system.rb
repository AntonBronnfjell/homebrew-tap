class HtmlDesignSystem < Formula
  include Language::Python::Shebang

  desc "Build accessible HTML/CSS design systems with DTCG tokens and Storybook"
  homepage "https://github.com/AntonBronnfjell/tooling-agent-skill-markdown_html-design-system"
  url "https://github.com/AntonBronnfjell/tooling-agent-skill-markdown_html-design-system/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "1eeb476374ea8eb43767ed46e0eb397002b7dd515732f3066bcabec1c43d2dbd"
  license "MIT"

  depends_on "python@3.15"

  def install
    libexec.install Dir["*"]
    rewrite_shebang detected_python_shebang, libexec/"scripts/ds.py"
    bin.install_symlink libexec/"scripts/ds.py" => "ds"
  end

  def caveats
    <<~EOS
      To also add the skill to your AI agents (Claude Code, Cursor, Codex, ...):
        python3 #{opt_libexec}/install.py --no-cli
    EOS
  end

  test do
    system bin/"ds", "init", testpath/"ds", "--tier", "core"
    system bin/"ds", "build", testpath/"ds"
    system bin/"ds", "check", testpath/"ds"
  end
end
