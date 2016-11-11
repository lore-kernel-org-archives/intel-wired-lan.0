From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:28 -0800
Subject: [Intel-wired-lan] [next PATCH S54 04/15] i40e: delete filter after
	adding its replacement when converting
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Fix a subtle issue with the code for converting VID=-1 filters into VID=0 
filters when adding a new VLAN. Previously the code deleted the VID=-1 
filter, and then added a new VID=0 filter. In the rare case that the 
addition fails due to -ENOMEM, we end up completely deleting the filter 
which prevents recovery if memory pressure subsides. While it is not 
strictly an issue because it is likely that memory issues would result 
in many other problems, we shouldn't delete the filter until after the 
addition succeeds.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Icba07ddd04ecc6a3b27c2e29f2c1c8673d266826
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8f176d0..a034521 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2522,7 +2522,6 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 						 I40E_VLAN_ANY);
 			if (!del_f)
 				continue;
-			__i40e_del_filter(vsi, del_f);
 			add_f = i40e_add_filter(vsi, f->macaddr, 0);
 			if (!add_f) {
 				dev_info(&vsi->back->pdev->dev,
@@ -2531,6 +2530,7 @@ int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid)
 				spin_unlock_bh(&vsi->mac_filter_hash_lock);
 				return -ENOMEM;
 			}
+			__i40e_del_filter(vsi, del_f);
 		}
 	}
 
-- 
2.4.11

