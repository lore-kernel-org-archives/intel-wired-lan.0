From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 19 Jul 2016 16:23:29 -0700
Subject: [Intel-wired-lan] [PATCH v1 1/3] i40e: move i40e_vsi_config_rss
	below i40e_get_rss_aq
In-Reply-To: <20160719232331.31422-1-jacob.e.keller@intel.com>
References: <20160719232331.31422-1-jacob.e.keller@intel.com>
Message-ID: <20160719232331.31422-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move this function below the two functions related to configuring RSS
via the admin queue. This helps co-locate the two functions, and made it
easier to spot a bug in the first i40e_config_rss_aq function as
compared to the i40e_get_rss_aq function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 54 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a2340dbfe07e..d482443d01de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7995,33 +7995,6 @@ config_rss_aq_out:
 	return ret;
 }
 
-/**
- * i40e_vsi_config_rss - Prepare for VSI(VMDq) RSS if used
- * @vsi: VSI structure
- **/
-static int i40e_vsi_config_rss(struct i40e_vsi *vsi)
-{
-	u8 seed[I40E_HKEY_ARRAY_SIZE];
-	struct i40e_pf *pf = vsi->back;
-	u8 *lut;
-	int ret;
-
-	if (!(pf->flags & I40E_FLAG_RSS_AQ_CAPABLE))
-		return 0;
-
-	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
-	if (!lut)
-		return -ENOMEM;
-
-	i40e_fill_rss_lut(pf, lut, vsi->rss_table_size, vsi->rss_size);
-	netdev_rss_key_fill((void *)seed, I40E_HKEY_ARRAY_SIZE);
-	vsi->rss_size = min_t(int, pf->alloc_rss_size, vsi->num_queue_pairs);
-	ret = i40e_config_rss_aq(vsi, seed, lut, vsi->rss_table_size);
-	kfree(lut);
-
-	return ret;
-}
-
 /**
  * i40e_get_rss_aq - Get RSS keys and lut by using AQ commands
  * @vsi: Pointer to vsi structure
@@ -8068,6 +8041,33 @@ static int i40e_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 	return ret;
 }
 
+/**
+ * i40e_vsi_config_rss - Prepare for VSI(VMDq) RSS if used
+ * @vsi: VSI structure
+ **/
+static int i40e_vsi_config_rss(struct i40e_vsi *vsi)
+{
+	u8 seed[I40E_HKEY_ARRAY_SIZE];
+	struct i40e_pf *pf = vsi->back;
+	u8 *lut;
+	int ret;
+
+	if (!(pf->flags & I40E_FLAG_RSS_AQ_CAPABLE))
+		return 0;
+
+	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
+	if (!lut)
+		return -ENOMEM;
+
+	i40e_fill_rss_lut(pf, lut, vsi->rss_table_size, vsi->rss_size);
+	netdev_rss_key_fill((void *)seed, I40E_HKEY_ARRAY_SIZE);
+	vsi->rss_size = min_t(int, pf->alloc_rss_size, vsi->num_queue_pairs);
+	ret = i40e_config_rss_aq(vsi, seed, lut, vsi->rss_table_size);
+	kfree(lut);
+
+	return ret;
+}
+
 /**
  * i40e_config_rss_reg - Configure RSS keys and lut by writing registers
  * @vsi: Pointer to vsi structure
-- 
2.9.0.rc1.405.g81f467e

