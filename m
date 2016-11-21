From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 21 Nov 2016 13:03:47 -0800
Subject: [Intel-wired-lan] [next PATCH S53-V3 1/5] i40e: use unsigned printf
	format specifier for active_filters count
Message-ID: <1479762231-27559-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Replace the %d specifier used for printing vsi->active_filters and
vsi->promisc_threshold with an unsigned %u format specifier. While it is
unlikely in practice that these values will ever reach such a large
number they are unsigned values and thus should not be interpreted as
negative numbers.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Iff050fad5a1c8537c4c57fcd527441cd95cfc0d4
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index b8a03a0..f1f41f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -172,7 +172,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 			 f->macaddr, f->vlan,
 			 i40e_filter_state_string[f->state]);
 	}
-	dev_info(&pf->pdev->dev, "    active_filters %d, promisc_threshold %d, overflow promisc %s\n",
+	dev_info(&pf->pdev->dev, "    active_filters %u, promisc_threshold %u, overflow promisc %s\n",
 		 vsi->active_filters, vsi->promisc_threshold,
 		 (test_bit(__I40E_FILTER_OVERFLOW_PROMISC, &vsi->state) ?
 		  "ON" : "OFF"));
-- 
2.4.11

