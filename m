From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 19 Jul 2016 16:23:31 -0700
Subject: [Intel-wired-lan] [PATCH v1 3/3] i40e: use configured RSS key and
	lookup table in i40e_vsi_config_rss
In-Reply-To: <20160719232331.31422-1-jacob.e.keller@intel.com>
References: <20160719232331.31422-1-jacob.e.keller@intel.com>
Message-ID: <20160719232331.31422-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A previous refactor added support to store user configuration for VSIs,
so that extra VSIs such as for VMDq can use this information when
configuring. Unfortunately the i40e_vsi_config_rss function was missed
in this refactor, and the values were being ignored. Fix this by
checking for the fields and using those instead of always using the
default values.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7617ee4a86b0..141f2ac48fe4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8044,13 +8044,26 @@ static int i40e_vsi_config_rss(struct i40e_vsi *vsi)
 	if (!(pf->flags & I40E_FLAG_RSS_AQ_CAPABLE))
 		return 0;
 
+	if (!vsi->rss_size)
+		vsi->rss_size = min_t(int, pf->alloc_rss_size,
+				      vsi->num_queue_pairs);
+	if (!vsi->rss_size)
+		return -EINVAL;
+
 	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
 	if (!lut)
 		return -ENOMEM;
-
-	i40e_fill_rss_lut(pf, lut, vsi->rss_table_size, vsi->rss_size);
-	netdev_rss_key_fill((void *)seed, I40E_HKEY_ARRAY_SIZE);
-	vsi->rss_size = min_t(int, pf->alloc_rss_size, vsi->num_queue_pairs);
+	/* Use the user configured hash keys and lookup table if there is one,
+	 * otherwise use default
+	 */
+	if (vsi->rss_lut_user)
+		memcpy(lut, vsi->rss_lut_user, vsi->rss_table_size);
+	else
+		i40e_fill_rss_lut(pf, lut, vsi->rss_table_size, vsi->rss_size);
+	if (vsi->rss_hkey_user)
+		memcpy(seed, vsi->rss_hkey_user, I40E_HKEY_ARRAY_SIZE);
+	else
+		netdev_rss_key_fill((void *)seed, I40E_HKEY_ARRAY_SIZE);
 	ret = i40e_config_rss_aq(vsi, seed, lut, vsi->rss_table_size);
 	kfree(lut);
 
-- 
2.9.0.rc1.405.g81f467e

