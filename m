From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Tue, 26 Jun 2018 06:49:02 -0300
Subject: [Intel-wired-lan] [PATCH 0/9] Fix references for some missing
 documentation files
Message-ID: <cover.1530005114.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Having nothing to do while waiting for my plane to arrive while
returning back from Japan, I ended by writing a small series of 
patches meant to reduce the number of bad Documentation/* 
links that are detected by:
	./scripts/documentation-file-ref-check

I ended by rebasing this patch series against linux-next, because
of those two patches:
	3b0c3ebe2a42 Documentation: e100: Fix docs build error
	805f16a5f12f Documentation: e1000: Fix docs build error

They basically fix documentation builds with upstream Kernel. Both
got merged on -rc2.

The first two patches in this series makes the script to ignore some
false positives.

Patches 3 to 6 corrects the location of some documentation files.

Patches 7 and 8 were actually two patches meant to fix the build
error. I ended by rebasing them over linux-next, as they fix some
troubles with the ReST syntax with causes warnings.

Patch 9 converts Documentation/trace/histogram.txt to ReST
syntax. It also had to be rebased against linux-next, due to some minor
conflicts with:
    064f35a95224 ("tracing: Fix some errors in histogram documentation")

After this series, the script still produces 16 warnings:

Documentation/devicetree/bindings/input/mtk-pmic-keys.txt: Documentation/devicetree/bindings/input/keys.txt
Documentation/devicetree/bindings/input/mtk-pmic-keys.txt: Documentation/devicetree/bindings/input/keys.txt
Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt: Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
Documentation/devicetree/dynamic-resolution-notes.txt: Documentation/devicetree/dt-object-internal.txt
Documentation/scsi/scsi_mid_low_api.txt: Documentation/Configure.help
Documentation/translations/zh_CN/HOWTO: Documentation/DocBook/
Documentation/translations/zh_CN/basic_profiling.txt: Documentation/basic_profiling
Documentation/translations/zh_CN/basic_profiling.txt: Documentation/basic_profiling
MAINTAINERS: Documentation/fpga/
MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
arch/powerpc/Kconfig: Documentation/vm/protection-keys.rst
drivers/isdn/mISDN/dsp_core.c: Documentation/isdn/mISDN.cert
drivers/scsi/Kconfig: file:Documentation/scsi/tmscsim.txt
drivers/vhost/vhost.c: Documentation/virtual/lguest/lguest.c
include/linux/fs_context.h: Documentation/filesystems/mounting.txt
include/linux/lsm_hooks.h: Documentation/filesystems/mounting.txt

IMHO, the above should be fixed by the corresponding maintainers.

The ones that scarry me most are the DT binding documentation, as
the binding documentation for some stuff are likely broken.

Btw, two of the above are new on linux-next (include/linux/fs_context.h
and include/linux/lsm_hooks.h) . That makes me wander that we should
likely add some logic (or run the detect script) at checkpatch.pl or make
it to call ./scripts/documentation-file-ref-check.

Mauro Carvalho Chehab (9):
  scripts/documentation-file-ref-check: remove some false positives
  scripts/documentation-file-ref-check: ignore sched-pelt false positive
  docs: zh_CN: fix location of oops-tracing.txt
  devicectree: bindings: fix location of leds common file
  MAINTAINERS: fix location of ina2xx.txt device tree file
  gpio.h: fix location of gpio legacy documentation
  networking: e100.rst: Get rid of Sphinx warnings
  networking: e1000.rst: Get rid of Sphinx warnings
  docs: histogram.txt: convert it to ReST file format

 .../devicetree/bindings/leds/common.txt       |    2 +-
 Documentation/networking/e100.rst             |   27 +-
 Documentation/networking/e1000.rst            |  187 ++-
 Documentation/trace/events.rst                |    2 +-
 .../trace/{histogram.txt => histogram.rst}    | 1242 +++++++++--------
 Documentation/trace/index.rst                 |    1 +
 .../translations/zh_CN/oops-tracing.txt       |    4 +-
 MAINTAINERS                                   |    2 +-
 include/linux/gpio.h                          |    2 +-
 kernel/trace/Kconfig                          |    2 +-
 scripts/documentation-file-ref-check          |    6 +
 11 files changed, 767 insertions(+), 710 deletions(-)
 rename Documentation/trace/{histogram.txt => histogram.rst} (73%)

-- 
2.17.1


