From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:59 -0400
Subject: [Intel-wired-lan] [next PATCH S13 13/15] i40e: print neato new
	features
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

To help users and developers know what compile options
and hardware features are enabled at compile time, print
VxLAN is available.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I3162f3b7678dc725a597f964217920eb218b480b
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2771259..469e1d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9914,6 +9914,9 @@ static void i40e_print_features(struct i40e_pf *pf)
 	}
 	if (pf->flags & I40E_FLAG_DCB_CAPABLE)
 		buf += sprintf(buf, "DCB ");
+#if IS_ENABLED(CONFIG_VXLAN)
+	buf += sprintf(buf, "VxLAN ");
+#endif
 	if (pf->flags & I40E_FLAG_PTP)
 		buf += sprintf(buf, "PTP ");
 #ifdef I40E_FCOE
-- 
1.9.3

