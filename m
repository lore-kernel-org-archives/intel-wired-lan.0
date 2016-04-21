From: Preethi Banala <preethi.banala@intel.com>
Date: Thu, 21 Apr 2016 11:39:29 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove duplicate and unused device
	ID definitions
Message-ID: <20160421183929.14400.58480.stgit@ixgbe-dev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove duplicate and unused device ID definitions.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 7af451460374..97f0127ec03e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -89,10 +89,6 @@
 #define IXGBE_DEV_ID_X550EM_A_SFP	0x15CE
 
 /* VF Device IDs */
-#define IXGBE_DEV_ID_X550_VF_HV	0x1564
-#define IXGBE_DEV_ID_X550_VF		0x1565
-#define IXGBE_DEV_ID_X550EM_X_VF	0x15A8
-#define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
 #define IXGBE_DEV_ID_82599_VF           0x10ED
 #define IXGBE_DEV_ID_X540_VF            0x1515
 #define IXGBE_DEV_ID_X550_VF		0x1565

