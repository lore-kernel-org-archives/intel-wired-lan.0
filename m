From: Alice Michael <alice.michael@intel.com>
Date: Mon, 18 Dec 2017 05:15:25 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 2/9] i40e: avoid divide by zero
Message-ID: <20171218101525.75683-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some weird circumstances with DCB enabled, the firmware can fail to
configure the VSI, leaving us with zero traffic classes. Check for this
state when we configure RSS to avoid a panic.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4f74156..7a882d7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10839,8 +10839,13 @@ static int i40e_pf_config_rss(struct i40e_pf *pf)
 	/* Determine the RSS size of the VSI */
 	if (!vsi->rss_size) {
 		u16 qcount;
-
-		qcount = vsi->num_queue_pairs / vsi->tc_config.numtc;
+		/* If the firmware does something weird during VSI init, we
+		 * could end up with zero TCs. Check for that to avoid
+		 * divide-by-zero. It probably won't pass traffic, but it also
+		 * won't panic.
+		 */
+		qcount = vsi->num_queue_pairs /
+			 (vsi->tc_config.numtc ? vsi->tc_config.numtc : 1);
 		vsi->rss_size = min_t(int, pf->alloc_rss_size, qcount);
 	}
 	if (!vsi->rss_size)
-- 
2.9.5

