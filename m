From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Thu,  2 Sep 2021 08:28:46 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix queues reservation scheme
Message-ID: <20210902082846.49744-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Depending on the CPU count and NVM configuration, PF reset and
rebuild may fail if more queues are allocated (e.g. attach XDP program),
causes kernel NULL pointer dereference. The issue is that during rebuild,
FDIR VSI's queue pile is not zeroed, despite no VSIs, but PF exisiting.
The change causes all queue pairs released from the queue pile.

Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 000991afcf27..61ec0b6c1d05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -196,7 +196,7 @@ static int i40e_get_lump(struct i40e_pf *pf, struct i40e_lump_tracking *pile,
 		return -EINVAL;
 	}
 
-	/* start the linear search with an imperfect hint */
+	/* start from beginning because earlier areas may have been freed */
 	i = pile->search_hint;
 	while (i < pile->num_entries) {
 		/* skip already allocated entries */
@@ -227,6 +227,26 @@ static int i40e_get_lump(struct i40e_pf *pf, struct i40e_lump_tracking *pile,
 	return ret;
 }
 
+/**
+ * i40e_put_all_lump - return a lump of generic resource
+ * @pile: the pile of resource to search
+ *
+ * Returns the count of items in the lump
+ **/
+static void i40e_put_all_lump(struct i40e_lump_tracking *pile)
+{
+	u16 i;
+
+	if (!pile)
+		return;
+
+	for (i = 0;
+	     i < pile->num_entries;
+	     i++) {
+		pile->list[i] = 0;
+	}
+}
+
 /**
  * i40e_put_lump - return a lump of generic resource
  * @pile: the pile of resource to search
@@ -13966,7 +13986,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 	pf = vsi->back;
 
-	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
+	i40e_put_all_lump(pf->qp_pile);
 	i40e_vsi_clear_rings(vsi);
 
 	i40e_vsi_free_arrays(vsi, false);
-- 
2.27.0

