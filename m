From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:36 -0400
Subject: [Intel-wired-lan] [next PATCH S20 10/15] i40e: fix confusing message
In-Reply-To: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445903081-155893-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Helin Zhang <helin.zhang@intel.com>

This patch fixes the confusing kernel message of enabled RSS size,
by reporting it together with the hardware maximum RSS size.

Signed-off-by: Helin Zhang <helin.zhang@intel.com>
Change-ID: I64864dbfbc13beccc180a7871680def1f3d5a339

---
Testing-hints: Check for "RSS count/HW max RSS count" in dmesg when the
RSS size is changed through "ethtool -l ethx", especially when the
number of queues are brought down.
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 508cf9a..4e9d6e5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8110,7 +8110,8 @@ int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 
 		i40e_pf_config_rss(pf);
 	}
-	dev_info(&pf->pdev->dev, "RSS count:  %d\n", pf->alloc_rss_size);
+	dev_info(&pf->pdev->dev, "RSS count/HW max RSS count:  %d/%d\n",
+		 pf->alloc_rss_size, pf->rss_size_max);
 	return pf->alloc_rss_size;
 }
 
-- 
1.9.3

