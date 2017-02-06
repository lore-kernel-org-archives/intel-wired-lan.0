From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:40 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 03/11] i40e: rework exit flow of
	i40e_add_fdir_ethtool
In-Reply-To: <20170206223846.31052-1-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
Message-ID: <20170206223846.31052-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Refactor the exit flow of the i40e_add_fdir_ethtool function. Move the
input_label to the end of the function, removing the dependency on
having a non-zero return value. Add a comment explaining why it is ok
not to free the fdir data structure, because the structure is now stored
in the fdir_filter_list.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: I723342181d59cd0c9f3b31140c37961ba37bb242
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9ba3f18f2e8b..cfe4db974c8e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2790,12 +2790,19 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	}
 
 	ret = i40e_add_del_fdir(vsi, input, true);
-free_input:
 	if (ret)
-		kfree(input);
-	else
-		i40e_update_ethtool_fdir_entry(vsi, input, fsp->location, NULL);
+		goto free_input;
 
+	/* Add the input filter to the fdir_input_list, possibly replacing
+	 * a previous filter. Do not free the input structure after adding it
+	 * to the list as this would cause a use-after-free bug.
+	 */
+	i40e_update_ethtool_fdir_entry(vsi, input, fsp->location, NULL);
+
+	return 0;
+
+free_input:
+	kfree(input);
 	return ret;
 }
 
-- 
2.12.0.rc0.151.g8a5726c42288

