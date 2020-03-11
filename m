From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 11 Mar 2020 09:37:40 +0100
Subject: [Intel-wired-lan] [PATCH 2/7] i40e: Use scnprintf() for avoiding
 potential buffer overflow
In-Reply-To: <20200311083745.17328-1-tiwai@suse.de>
References: <20200311083745.17328-1-tiwai@suse.de>
Message-ID: <20200311083745.17328-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8c3e753bfb9d..ff431c13f858 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14478,29 +14478,29 @@ static void i40e_print_features(struct i40e_pf *pf)
 
 	i = snprintf(buf, INFO_STRING_LEN, "Features: PF-id[%d]", hw->pf_id);
 #ifdef CONFIG_PCI_IOV
-	i += snprintf(&buf[i], REMAIN(i), " VFs: %d", pf->num_req_vfs);
+	i += scnprintf(&buf[i], REMAIN(i), " VFs: %d", pf->num_req_vfs);
 #endif
-	i += snprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d",
+	i += scnprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d",
 		      pf->hw.func_caps.num_vsis,
 		      pf->vsi[pf->lan_vsi]->num_queue_pairs);
 	if (pf->flags & I40E_FLAG_RSS_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), " RSS");
+		i += scnprintf(&buf[i], REMAIN(i), " RSS");
 	if (pf->flags & I40E_FLAG_FD_ATR_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), " FD_ATR");
+		i += scnprintf(&buf[i], REMAIN(i), " FD_ATR");
 	if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
-		i += snprintf(&buf[i], REMAIN(i), " FD_SB");
-		i += snprintf(&buf[i], REMAIN(i), " NTUPLE");
+		i += scnprintf(&buf[i], REMAIN(i), " FD_SB");
+		i += scnprintf(&buf[i], REMAIN(i), " NTUPLE");
 	}
 	if (pf->flags & I40E_FLAG_DCB_CAPABLE)
-		i += snprintf(&buf[i], REMAIN(i), " DCB");
-	i += snprintf(&buf[i], REMAIN(i), " VxLAN");
-	i += snprintf(&buf[i], REMAIN(i), " Geneve");
+		i += scnprintf(&buf[i], REMAIN(i), " DCB");
+	i += scnprintf(&buf[i], REMAIN(i), " VxLAN");
+	i += scnprintf(&buf[i], REMAIN(i), " Geneve");
 	if (pf->flags & I40E_FLAG_PTP)
-		i += snprintf(&buf[i], REMAIN(i), " PTP");
+		i += scnprintf(&buf[i], REMAIN(i), " PTP");
 	if (pf->flags & I40E_FLAG_VEB_MODE_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), " VEB");
+		i += scnprintf(&buf[i], REMAIN(i), " VEB");
 	else
-		i += snprintf(&buf[i], REMAIN(i), " VEPA");
+		i += scnprintf(&buf[i], REMAIN(i), " VEPA");
 
 	dev_info(&pf->pdev->dev, "%s\n", buf);
 	kfree(buf);
-- 
2.16.4

