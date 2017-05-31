From: Jia-Ju Bai <baijiaju1990@163.com>
Date: Wed, 31 May 2017 10:12:11 +0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix a sleep-in-atomic bug
Message-ID: <1496196731-748-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver may sleep under a spin lock, and the function call path is:
i40e_ndo_set_vf_port_vlan (acquire the lock by spin_lock_bh)
  i40e_vsi_remove_pvid
    i40e_vlan_stripping_disable
      i40e_aq_update_vsi_params
        i40e_asq_send_command
          mutex_lock --> may sleep

To fixed it, the spin lock is released before "i40e_vsi_remove_pvid", and 
the lock is acquired again after this function.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 95c23fb..0fb38ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3017,10 +3017,12 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 					   VLAN_VID_MASK));
 	}
 
+	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 	if (vlan_id || qos)
 		ret = i40e_vsi_add_pvid(vsi, vlanprio);
 	else
 		i40e_vsi_remove_pvid(vsi);
+	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
 	if (vlan_id) {
 		dev_info(&pf->pdev->dev, "Setting VLAN %d, QOS 0x%x on VF %d\n",
-- 
1.7.9.5


