From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:32 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 03/13] i40e: re-enable PTP L4
	capabilities for XL710 if FW >6.0
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

Starting with XL710 FW 5.3 PTP L4 was disabled for XL710 due to a bug.  The
bug has since been resolved in XL710 FW >6.0 and PTP L4 can now be
re-enabled on those devices with updated firmware.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e54163b..e9fc34c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9075,6 +9075,11 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	    (pf->hw.aq.fw_maj_ver >= 5)))
 		pf->hw_features |= I40E_HW_USE_SET_LLDP_MIB;
 
+	/* Enable PTP L4 if FW > v6.0 */
+	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
+	    (pf->hw.aq.fw_maj_ver >= 6))
+		pf->hw_features |= I40E_HW_PTP_L4_CAPABLE;
+
 	if (pf->hw.func_caps.vmdq) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
 		pf->flags |= I40E_FLAG_VMDQ_ENABLED;
-- 
2.9.4

