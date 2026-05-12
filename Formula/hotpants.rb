class Hotpants < Formula
  desc "High Order Transform of Psf ANd Template Subtraction"
  homepage "https://github.com/Astro-Lee/hotpants"
  url "https://github.com/Astro-Lee/hotpants/archive/refs/tags/v5.1.11.tar.gz"
  sha256 "1da3f9b80a21a507e1a665e624d628bf33da5675d2d50aab84700310632c03d8"

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
