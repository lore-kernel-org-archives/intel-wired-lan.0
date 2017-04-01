From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat,  1 Apr 2017 02:01:36 -0700
Subject: [Intel-wired-lan] [net-next,
	3/4] ixgbe: move IXGBE_ALLOW_RELAXED_ORDER from architecture to
	driver
In-Reply-To: <20170401090137.54079-1-jeffrey.t.kirsher@intel.com>
References: <20170401090137.54079-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170401090137.54079-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ding Tianhong <dingtianhong@huawei.com>

The Relaxed Ordering is an specific PCI option and impact some
architecture performance just like SPARC and ARM64, so compare to
drop this to the several architecture folder, put it in driver looks
more appropriate, it will not impact or be seen for other architectures.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
Doing what the author could not do, send to the correct mailing list...

---
 arch/Kconfig                       | 3 ---
 arch/sparc/Kconfig                 | 1 -
 drivers/net/ethernet/intel/Kconfig | 4 ++++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index bc0ab44..e03d354 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -844,7 +844,4 @@ config STRICT_MODULE_RWX
 	  and non-text memory will be made non-executable. This provides
 	  protection against certain security exploits (e.g. writing to text)
 
-config IXGBE_ALLOW_RELAXED_ORDER
-	bool
-
 source "kernel/gcov/Kconfig"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f56bcf4..cf4034c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -44,7 +44,6 @@ config SPARC
 	select CPU_NO_EFFICIENT_FFS
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select PROVE_LOCKING_SMALL if PROVE_LOCKING
-	select IXGBE_ALLOW_RELAXED_ORDER
 
 config SPARC32
 	def_bool !64BIT
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 1349b45..33ef2b6 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -275,4 +275,8 @@ config FM10K
 	  To compile this driver as a module, choose M here. The module
 	  will be called fm10k.  MSI-X interrupt support is required
 
+config IXGBE_ALLOW_RELAXED_ORDER
+	bool "Intel(R) 10GbE PCI Express adapters Enable Relaxed Ordering" if SPARC
+	default y if SPARC
+
 endif # NET_VENDOR_INTEL
