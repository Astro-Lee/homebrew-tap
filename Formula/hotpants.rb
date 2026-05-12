class Hotpants < Formula
  desc "High Order Transform of Psf ANd Template Subtraction"
  homepage "https://github.com/Astro-Lee/hotpants"
  url "https://github.com/Astro-Lee/hotpants/archive/refs/tags/v5.1.11.tar.gz"
  sha256 "REPLACE_WITH_ACTUAL_SHA256"

  depends_on "cfitsio"

  def install
    system "make"
    bin.install "hotpants"
    bin.install "extractkern"
    bin.install "maskim"
  end

  test do
    assert_path_exists bin/"hotpants"
    assert_path_exists bin/"extractkern"
    assert_path_exists bin/"maskim"
  end
end
