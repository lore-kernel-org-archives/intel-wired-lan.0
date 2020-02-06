From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 Feb 2020 01:20:12 -0800
Subject: [Intel-wired-lan] [PATCH S37 v3 14/15] ice: Use correct netif error
 function
In-Reply-To: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
Message-ID: <20200206092013.23388-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ben Shelton <benjamin.h.shelton@intel.com>

Use the correct netif_msg_[tx,rx]_error() function to determine whether to
print the MDD event type.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 456c8efe49c5..2297a5a5c572 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1231,7 +1231,7 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		u16 queue = ((reg & GL_MDET_TX_TCLAN_QNUM_M) >>
 				GL_MDET_TX_TCLAN_QNUM_S);
 
-		if (netif_msg_rx_err(pf))
+		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
 		wr32(hw, GL_MDET_TX_TCLAN, 0xffffffff);
-- 
2.20.1

