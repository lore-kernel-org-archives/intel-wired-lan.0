From: Joe Perches <joe@perches.com>
Date: Wed, 02 Dec 2015 00:38:55 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix i40e_print_features() VEB mode
	output
In-Reply-To: <1449041100.3224.17.camel@intel.com>
References: <1448475679-57194-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1448475679-57194-5-git-send-email-jeffrey.t.kirsher@intel.com>
 <5655FD72.70902@cogentembedded.com> <1448476535.3021.5.camel@intel.com>
 <1448480194.20113.48.camel@perches.com>
 <1449002936.1593.10.camel@perches.com> <1449041100.3224.17.camel@intel.com>
Message-ID: <1449045535.3716.10.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 7fd89545f337 ("i40e: remove BUG_ON from feature string building")
added defective output when I40E_FLAG_VEB_MODE_ENABLED was set in
function i40e_print_features.

Fix it.

Miscellanea:

o Remove unnecessary string variable
o Add space before not after fixed strings
o Use kmalloc not kzalloc
o Don't initialize i to 0, use result of first snprintf

Noticed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
?drivers/net/ethernet/intel/i40e/i40e_main.c | 42 +++++++++++++----------------
?1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4b7d874..145eeb5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10240,52 +10240,48 @@ static int i40e_setup_pf_filter_control(struct i40e_pf *pf)
?static void i40e_print_features(struct i40e_pf *pf)
?{
?	struct i40e_hw *hw = &pf->hw;
-	char *buf, *string;
-	int i = 0;
+	char *buf;
+	int i;
?
-	string = kzalloc(INFO_STRING_LEN, GFP_KERNEL);
-	if (!string) {
-		dev_err(&pf->pdev->dev, "Features string allocation failed\n");
+	buf = kmalloc(INFO_STRING_LEN, GFP_KERNEL);
+	if (!buf)
?		return;
-	}
-
-	buf = string;
?
-	i += snprintf(&buf[i], REMAIN(i), "Features: PF-id[%d] ", hw->pf_id);
+	i = snprintf(buf, INFO_STRING_LEN, "Features: PF-id[%d]", hw->pf_id);
?#ifdef CONFIG_PCI_IOV
-	i += snprintf(&buf[i], REMAIN(i), "VFs: %d ", pf->num_req_vfs);
+	i += snprintf(&buf[i], REMAIN(i), " VFs: %d", pf->num_req_vfs);
?#endif
-	i += snprintf(&buf[i], REMAIN(i), "VSIs: %d QP: %d RX: %s ",
+	i += snprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d RX: %s",
?		??????pf->hw.func_caps.num_vsis,
?		??????pf->vsi[pf->lan_vsi]->num_queue_pairs,
?		??????pf->flags & I40E_FLAG_RX_PS_ENABLED ? "PS" : "1BUF");
?
?	if (pf->flags & I40E_FLAG_RSS_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), "RSS ");
+		i += snprintf(&buf[i], REMAIN(i), " RSS");
?	if (pf->flags & I40E_FLAG_FD_ATR_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), "FD_ATR ");
+		i += snprintf(&buf[i], REMAIN(i), " FD_ATR");
?	if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
-		i += snprintf(&buf[i], REMAIN(i), "FD_SB ");
-		i += snprintf(&buf[i], REMAIN(i), "NTUPLE ");
+		i += snprintf(&buf[i], REMAIN(i), " FD_SB");
+		i += snprintf(&buf[i], REMAIN(i), " NTUPLE");
?	}
?	if (pf->flags & I40E_FLAG_DCB_CAPABLE)
-		i += snprintf(&buf[i], REMAIN(i), "DCB ");
+		i += snprintf(&buf[i], REMAIN(i), " DCB");
?#if IS_ENABLED(CONFIG_VXLAN)
-	i += snprintf(&buf[i], REMAIN(i), "VxLAN ");
+	i += snprintf(&buf[i], REMAIN(i), " VxLAN");
?#endif
?	if (pf->flags & I40E_FLAG_PTP)
-		i += snprintf(&buf[i], REMAIN(i), "PTP ");
+		i += snprintf(&buf[i], REMAIN(i), " PTP");
?#ifdef I40E_FCOE
?	if (pf->flags & I40E_FLAG_FCOE_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), "FCOE ");
+		i += snprintf(&buf[i], REMAIN(i), " FCOE");
?#endif
?	if (pf->flags & I40E_FLAG_VEB_MODE_ENABLED)
-		i += snprintf(&buf[i], REMAIN(i), "VEPA ");
+		i += snprintf(&buf[i], REMAIN(i), " VEB");
?	else
-		buf += sprintf(buf, "VEPA ");
+		i += snprintf(&buf[i], REMAIN(i), " VEPA");
?
-	dev_info(&pf->pdev->dev, "%s\n", string);
-	kfree(string);
+	dev_info(&pf->pdev->dev, "%s\n", buf);
+	kfree(buf);
?	WARN_ON(i > INFO_STRING_LEN);
?}
?
