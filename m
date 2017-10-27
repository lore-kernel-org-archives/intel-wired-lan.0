From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Fri, 27 Oct 2017 02:35:40 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 2/6] i40e: Map TCs
	with the VSI seids
In-Reply-To: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
Message-ID: <150909694002.48377.13680917261556432785.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add mapping of TCs with the seids of the channel VSIs. TC0
will be mapped to the main VSI seid and all other TCs are
mapped to the seid of the corresponding channel VSI.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |    1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index eb01776..f3c501e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -739,6 +739,7 @@ struct i40e_vsi {
 	u16 next_base_queue;	/* next queue to be used for channel setup */
 
 	struct list_head ch_list;
+	u16 tc_seid_map[I40E_MAX_TRAFFIC_CLASS];
 
 	void *priv;	/* client driver data reference. */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1cf9ba2..2ff7384 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6100,6 +6100,7 @@ static int i40e_configure_queue_channels(struct i40e_vsi *vsi)
 	int ret = 0, i;
 
 	/* Create app vsi with the TCs. Main VSI with TC0 is already set up */
+	vsi->tc_seid_map[0] = vsi->seid;
 	for (i = 1; i < I40E_MAX_TRAFFIC_CLASS; i++) {
 		if (vsi->tc_config.enabled_tc & BIT(i)) {
 			ch = kzalloc(sizeof(*ch), GFP_KERNEL);
@@ -6130,6 +6131,7 @@ static int i40e_configure_queue_channels(struct i40e_vsi *vsi)
 					i, ch->num_queue_pairs);
 				goto err_free;
 			}
+			vsi->tc_seid_map[i] = ch->seid;
 		}
 	}
 	return ret;

