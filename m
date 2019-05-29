From: Lihong Yang <lihong.yang@intel.com>
Date: Wed, 29 May 2019 16:06:42 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Check and set the PF driver state
 first in i40e_ndo_set_vf_mac
Message-ID: <20190529230642.87106-1-lihong.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The PF driver state flag __I40E_VIRTCHNL_OP_PENDING needs to be
checked and set at the beginning of i40e_ndo_set_vf_mac. Otherwise,
if there are error conditions before it, the flag will be cleared
unexpectedly by this function to cause potential race conditions.
Hence move the check to the top of this function.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 38484ed6880d..ac3a130ee7d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3940,6 +3940,11 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	int bkt;
 	u8 i;
 
+	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
+		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
+		return -EAGAIN;
+	}
+
 	/* validate the request */
 	ret = i40e_validate_vf(pf, vf_id);
 	if (ret)
@@ -3964,11 +3969,6 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 		goto error_param;
 	}
 
-	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
-		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
-		return -EAGAIN;
-	}
-
 	if (is_multicast_ether_addr(mac)) {
 		dev_err(&pf->pdev->dev,
 			"Invalid Ethernet address %pM for VF %d\n", mac, vf_id);
-- 
2.20.1

