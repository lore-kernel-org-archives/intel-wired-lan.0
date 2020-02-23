From: Sasha Levin <sashal@kernel.org>
Date: Sat, 22 Feb 2020 21:21:08 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.5 47/58] ice: Use correct netif
 error function
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
Message-ID: <20200223022119.707-47-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Ben Shelton <benjamin.h.shelton@intel.com>

[ Upstream commit 1d8bd9927234081db15a1d42a7f99505244e3703 ]

Use the correct netif_msg_[tx,rx]_error() function to determine whether to
print the MDD event type.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c9b35b202639d..7f71f06fa819c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1235,7 +1235,7 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		u16 queue = ((reg & GL_MDET_TX_TCLAN_QNUM_M) >>
 				GL_MDET_TX_TCLAN_QNUM_S);
 
-		if (netif_msg_rx_err(pf))
+		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
 		wr32(hw, GL_MDET_TX_TCLAN, 0xffffffff);
-- 
2.20.1

