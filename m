From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  4 Aug 2016 18:45:47 +0200
Subject: [Intel-wired-lan] [next PATCH] i40e: Expose 'trust' flag to
	userspace via ndo_get_vf_config.
Message-ID: <1470329147-25005-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This enables
	ip -d l
to indicate if trust is on or off for VFs.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 6fcbf76..4bd66d7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2995,6 +2995,7 @@ int i40e_ndo_get_vf_config(struct net_device *netdev,
 	else
 		ivi->linkstate = IFLA_VF_LINK_STATE_DISABLE;
 	ivi->spoofchk = vf->spoofchk;
+	ivi->trusted = vf->trusted;
 	ret = 0;
 
 error_param:
-- 
2.5.5

