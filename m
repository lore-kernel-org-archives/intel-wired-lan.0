From: Alice Michael <alice.michael@intel.com>
Date: Wed, 12 Jul 2017 05:46:10 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V3 07/11] i40e: Use correct flag
	to enable egress traffic for unicast promisc
In-Reply-To: <20170712094614.76501-1-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
Message-ID: <20170712094614.76501-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

Albeit, we usually set true promiscuous mode for both multicast and
unicast at the same time - however, it is possible to set it
individually, so using allmulti flag which is only for allmulticast might
caused unwanted behavior in mirroring egress traffic promiscuous for
unicast in VF.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3ef67dc..aa8d30b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1758,7 +1758,7 @@ static int i40e_vc_config_promiscuous_mode_msg(struct i40e_vf *vf,
 		}
 	} else {
 		aq_ret = i40e_aq_set_vsi_unicast_promiscuous(hw, vsi->seid,
-							     allmulti, NULL,
+							     alluni, NULL,
 							     true);
 		aq_err = pf->hw.aq.asq_last_status;
 		if (aq_ret) {
-- 
2.9.3

