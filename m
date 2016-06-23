From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 23 Jun 2016 13:54:01 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: don't try to stop queues if we've
	lost hw_addr
Message-ID: <20160623205403.20327-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the event of a surprise remove, we expect the driver to go down,
which includes calling .stop_hw(). However, this function will return an
error because the queues won't appear to cleanly disable. Prevent this
and avoid the unnecessary checks by just returning when
FM10K_REMOVED(hw->hw_addr) is true.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index d6baaea8bc7c..dd95ac4f4c64 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -207,6 +207,9 @@ s32 fm10k_disable_queues_generic(struct fm10k_hw *hw, u16 q_cnt)
 	/* clear tx_ready to prevent any false hits for reset */
 	hw->mac.tx_ready = false;
 
+	if (FM10K_REMOVED(hw->hw_addr))
+		return 0;
+
 	/* clear the enable bit for all rings */
 	for (i = 0; i < q_cnt; i++) {
 		reg = fm10k_read_reg(hw, FM10K_TXDCTL(i));
-- 
2.9.0.rc1.405.g81f467e

