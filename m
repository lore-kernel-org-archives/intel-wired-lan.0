From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:43 -0700
Subject: [Intel-wired-lan] [next PATCH S46 7/8] i40e: don't configure
	zero-size RSS table
In-Reply-To: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473715124-31296-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some rare cases, we might get a VSI with no queues. In this case, we
cannot configure RSS on this VSI as it will try to divide by zero when
configuring the lookup table.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I6ae173a7dd3481a081e079eb10eb80275de2adb0
---
Testing Hints : This bug showed up at Red Hat while
testing a DUP. It looks like you need Purley and need to enable 32 VFs
on all PFs. I haven't reproduced the bug; this was found via code
inspection.

HSD-number: 10020370

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 995dc44..7fb08f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8265,6 +8265,8 @@ static int i40e_pf_config_rss(struct i40e_pf *pf)
 	if (!vsi->rss_size)
 		vsi->rss_size = min_t(int, pf->alloc_rss_size,
 				      vsi->num_queue_pairs);
+	if (!vsi->rss_size)
+		return -EINVAL;
 
 	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
 	if (!lut)
-- 
2.4.11

