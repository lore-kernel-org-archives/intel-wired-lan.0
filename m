From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat,  1 Apr 2017 02:01:37 -0700
Subject: [Intel-wired-lan] [net-next,
	4/4] ixgbe: enable IXGBE_ALLOW_RELAXED_ORDER for ARM64
In-Reply-To: <20170401090137.54079-1-jeffrey.t.kirsher@intel.com>
References: <20170401090137.54079-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170401090137.54079-4-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ding Tianhong <dingtianhong@huawei.com>

The IXGBE_ALLOW_RELAXED_ORDER will enable Relaxed Ordering (RO) which allows
transactions that do not have any order of completion requirements to
complete more efficiently compare to the Stricted Ordering (SO) for ixgbe
net card. Some architecture will see high write-to-memory performance when RO is
enabled on the data transactions just like the SPARC did.

The aarch64 could both support Relaxed Ordering (RO) and Stricted Ordering (SO),
so enable this config could get much more better performance, didn't see any
adverse effects.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
Doing what the author could not do, send to the correct mailing list...

---
 drivers/net/ethernet/intel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 33ef2b6..6743b7e 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -276,7 +276,7 @@ config FM10K
 	  will be called fm10k.  MSI-X interrupt support is required
 
 config IXGBE_ALLOW_RELAXED_ORDER
-	bool "Intel(R) 10GbE PCI Express adapters Enable Relaxed Ordering" if SPARC
-	default y if SPARC
+	bool "Intel(R) 10GbE PCI Express adapters Enable Relaxed Ordering" if (SPARC || ARM64)
+	default y if (SPARC || ARM64)
 
 endif # NET_VENDOR_INTEL
