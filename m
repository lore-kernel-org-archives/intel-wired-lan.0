From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 10 Apr 2015 10:36:31 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Release semaphore bits in the
	right order
Message-ID: <20150410173631.9380.46865.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The global semaphore bits should be released in the reverse of the
order that they were taken, so correct that.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 0 files changed

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index f5f948d08b43..0a8b5e42e1a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -696,14 +696,14 @@ static void ixgbe_release_swfw_sync_semaphore(struct ixgbe_hw *hw)
 
 	/* Release both semaphores by writing 0 to the bits REGSMP and SMBI */
 
-	swsm = IXGBE_READ_REG(hw, IXGBE_SWSM);
-	swsm &= ~IXGBE_SWSM_SMBI;
-	IXGBE_WRITE_REG(hw, IXGBE_SWSM, swsm);
-
 	swsm = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC);
 	swsm &= ~IXGBE_SWFW_REGSMP;
 	IXGBE_WRITE_REG(hw, IXGBE_SWFW_SYNC, swsm);
 
+	swsm = IXGBE_READ_REG(hw, IXGBE_SWSM);
+	swsm &= ~IXGBE_SWSM_SMBI;
+	IXGBE_WRITE_REG(hw, IXGBE_SWSM, swsm);
+
 	IXGBE_WRITE_FLUSH(hw);
 }
 

