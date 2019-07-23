From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:01:37 -0400
Subject: [Intel-wired-lan] [next PATCH S8 05/12] i40e: reset veb.tc_stats
 when resetting veb.stats
In-Reply-To: <20190723100144.57435-1-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
Message-ID: <20190723100144.57435-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The stats structure for the VEB switch statistics is reset periodically,
but the tc_stats are not reset at the same time.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4551d97771c9..5c280c025085 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -534,6 +534,10 @@ void i40e_pf_reset_stats(struct i40e_pf *pf)
 			       sizeof(pf->veb[i]->stats));
 			memset(&pf->veb[i]->stats_offsets, 0,
 			       sizeof(pf->veb[i]->stats_offsets));
+			memset(&pf->veb[i]->tc_stats, 0,
+			       sizeof(pf->veb[i]->tc_stats));
+			memset(&pf->veb[i]->tc_stats_offsets, 0,
+			       sizeof(pf->veb[i]->tc_stats_offsets));
 			pf->veb[i]->stat_offsets_loaded = false;
 		}
 	}
-- 
2.21.0

