From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  1 Oct 2015 14:37:35 -0400
Subject: [Intel-wired-lan] [next PATCH S18 2/8] i40e: fix a bug in debugfs
	with add/del macaddr
In-Reply-To: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443724661-92168-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

The new code flow requires us to grab the filter list lock before
adding/deleting the filter.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I4eaef508ab4da2d1b2e23f20f2a78d931d5b6aeb

---
Testing-hints: 5645669
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index c38e9ee..6baeefc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1137,7 +1137,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		f = i40e_add_filter(vsi, ma, vlan, false, false);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 		ret = i40e_sync_vsi_filters(vsi, true);
 		if (f && !ret)
 			dev_info(&pf->pdev->dev,
@@ -1174,7 +1176,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
+		spin_lock_bh(&vsi->mac_filter_list_lock);
 		i40e_del_filter(vsi, ma, vlan, false, false);
+		spin_unlock_bh(&vsi->mac_filter_list_lock);
 		ret = i40e_sync_vsi_filters(vsi, true);
 		if (!ret)
 			dev_info(&pf->pdev->dev,
-- 
1.9.3

