From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:12 -0800
Subject: [Intel-wired-lan] [PATCH S14 12/15] ice: Remove unnecessary
 newlines from log messages
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeremiah Kyle <jeremiah.kyle@intel.com>

Two log messages contained newlines in the middle of the message. This
resulted in unexpected driver log output.

This patch removes the newlines to restore consistency with the rest of
the driver log messages.

Signed-off-by: Jeremiah Kyle <jeremiah.kyle@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index cc15b3c90656..5a6d6c8e3060 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2611,7 +2611,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 		 * as it is busy with pending work.
 		 */
 		dev_info(&pf->pdev->dev,
-			 "PF failed to honor VF %d, opcode %d\n, error %d\n",
+			 "PF failed to honor VF %d, opcode %d, error %d\n",
 			 vf_id, v_opcode, err);
 	}
 }
@@ -2771,7 +2771,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	ether_addr_copy(vf->dflt_lan_addr.addr, mac);
 	vf->pf_set_mac = true;
 	netdev_info(netdev,
-		    "mac on VF %d set to %pM\n. VF driver will be reinitialized\n",
+		    "mac on VF %d set to %pM. VF driver will be reinitialized\n",
 		    vf_id, mac);
 
 	ice_vc_dis_vf(vf);
-- 
2.14.5

