From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Thu, 19 Nov 2015 11:34:15 -0800
Subject: [Intel-wired-lan] [V3: next PATCH S22 02/12] i40e: fix mismatched
	declaration
In-Reply-To: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447961665-12344-3-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

i40e_vsi_add_pvid() was declared in the i40e.h file as a different
return type than the function implementation.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I22ea1f05e1d3c79d1b198dd375a766d839ea4706
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index adfc450..04a3e87 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -717,7 +717,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16 uplink_seid,
 void i40e_veb_release(struct i40e_veb *veb);
 
 int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc);
-i40e_status i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid);
+int i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid);
 void i40e_vsi_remove_pvid(struct i40e_vsi *vsi);
 void i40e_vsi_reset_stats(struct i40e_vsi *vsi);
 void i40e_pf_reset_stats(struct i40e_pf *pf);
-- 
2.1.0

