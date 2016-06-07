From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue,  7 Jun 2016 16:08:49 -0700
Subject: [Intel-wired-lan] [PATCH v2 05/18] fm10k: use actual hardware
	registers when checking for pending Tx
In-Reply-To: <20160607230902.5457-1-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
Message-ID: <20160607230902.5457-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index a9ccc1eb3ea4..c6a464551577 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1130,9 +1130,11 @@ static u64 fm10k_get_tx_completed(struct fm10k_ring *ring)
 
 static u64 fm10k_get_tx_pending(struct fm10k_ring *ring)
 {
-	/* use SW head and tail until we have real hardware */
-	u32 head = ring->next_to_clean;
-	u32 tail = ring->next_to_use;
+	struct fm10k_intfc *interface = ring->q_vector->interface;
+	struct fm10k_hw *hw = &interface->hw;
+
+	u32 head = fm10k_read_reg(hw, FM10K_TDH(ring->reg_idx));
+	u32 tail = fm10k_read_reg(hw, FM10K_TDT(ring->reg_idx));
 
 	return ((head <= tail) ? tail : tail + ring->count) - head;
 }
-- 
2.9.0.rc1.405.g81f467e

