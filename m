From: harshitha.ramamurthy@intel.com <harshitha.ramamurthy@intel.com>
Date: Wed, 24 Jan 2018 05:39:18 -0800
Subject: [Intel-wired-lan] [PATCH] i40evf: Use the correct iterator to
 access the vlan filter
Message-ID: <1516801158-60944-1-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

A previous commit changed the name of the iterator to the
vlan_filter_list. Use the correct iterator to access the
vlan filter.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index bcc5cf6..e0c64b9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1065,7 +1065,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
 
 	/* remove all VLAN filters */
 	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
-		f->remove = true;
+		vlf->remove = true;
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.7.4

