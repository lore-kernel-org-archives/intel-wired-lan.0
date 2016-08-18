From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Thu, 18 Aug 2016 12:48:14 -0700
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Do not clear RAR entry when
 clearing VMDq for SAN MAC
Message-ID: <147154969452.19009.9564111024941912803.stgit@ahduyck-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The RAR entry for the SAN MAC address was being cleared when we were
clearing the VMDq pool bits.  In order to prevent this we need to add
an extra check to protect the SAN MAC from being cleared.

Fixes: 6e982aeae ("ixgbe: Clear stale pool mappings")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index b4217f3..c47b605 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2958,8 +2958,10 @@ s32 ixgbe_clear_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	}
 
 	/* was that the last pool using this rar? */
-	if (mpsar_lo == 0 && mpsar_hi == 0 && rar != 0)
+	if (mpsar_lo == 0 && mpsar_hi == 0 &&
+	    rar != 0 && rar != hw->mac.san_mac_rar_index)
 		hw->mac.ops.clear_rar(hw, rar);
+
 	return 0;
 }
 

