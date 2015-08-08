From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:18:59 -0700
Subject: [Intel-wired-lan] [PATCH V5 15/19] ixgbe: Correct error path in
	semaphore handling
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231858.94784.79556.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The timeout path is supposed to release the semaphore, so do that.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 5e4f256e9eb2..1918d6fa669d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -710,6 +710,11 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 		usleep_range(50, 100);
 	}
 
+	/* Release semaphores and return error if SW NVM semaphore
+	 * was not granted because we do not have access to the EEPROM
+	 */
+	hw_dbg(hw, "REGSMP Software NVM semaphore not granted\n");
+	ixgbe_release_swfw_sync_semaphore(hw);
 	return IXGBE_ERR_EEPROM;
 }
 

