From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 30 Jan 2021 15:49:49 -0800
Subject: [Intel-wired-lan] [PATCH] csky: change a Kconfig symbol name to fix
 e1000 build error
Message-ID: <20210130234949.21090-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000's #define of CONFIG_RAM_BASE conflicts with a Kconfig symbol in
arch/csky/Kconfig.
The symbol in e1000 has been around longer, so change arch/csky/
to use DRAM_BASE instead of RAM_BASE to remove the conflict.
(although e1000 is also a 2-line change)

Not tested: I don't have a build toolchain for CSKY.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: Guo Ren <guoren@linux.alibaba.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky at vger.kernel.org
---
IMO "CONFIG_" namespace should belong to Kconfig files, not
individual drivers, but e1000 isn't the only driver that uses
CONFIG_ symbols.

 arch/csky/Kconfig            |    2 +-
 arch/csky/include/asm/page.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210129.orig/arch/csky/include/asm/page.h
+++ linux-next-20210129/arch/csky/include/asm/page.h
@@ -28,7 +28,7 @@
 #define SSEG_SIZE	0x20000000
 #define LOWMEM_LIMIT	(SSEG_SIZE * 2)
 
-#define PHYS_OFFSET_OFFSET (CONFIG_RAM_BASE & (SSEG_SIZE - 1))
+#define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
 
 #ifndef __ASSEMBLY__
 
--- linux-next-20210129.orig/arch/csky/Kconfig
+++ linux-next-20210129/arch/csky/Kconfig
@@ -314,7 +314,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "11"
 
-config RAM_BASE
+config DRAM_BASE
 	hex "DRAM start addr (the same with memory-section in dts)"
 	default 0x0
 
