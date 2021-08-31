From: Karen Sornek <karen.sornek@intel.com>
Date: Tue, 31 Aug 2021 13:16:35 +0200
Subject: [Intel-wired-lan] [PATCH net v1] igb: Fix removal of unicast MAC
 filters of VFs
Message-ID: <20210831111635.16161-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move checking condition of VF MAC filter before clearing
or adding MAC filter to VF to prevent potential blackout caused
by removal of neccessary and working VF's MAC filer.

Fixes: 1b8b062a99dc ("igb: add VF trust infrastructure")
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 28 +++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 842b50cc9..98e977fe5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7648,6 +7648,20 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 	struct vf_mac_filter *entry = NULL;
 	int ret = 0;
 
+	if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
+	    !vf_data->trusted) {
+		dev_warn(&pdev->dev,
+			 "VF %d requested MAC filter but is administratively denied\n",
+			  vf);
+		return -EINVAL;
+	}
+	if (!is_valid_ether_addr(addr)) {
+		dev_warn(&pdev->dev,
+			 "VF %d attempted to set invalid MAC filter\n",
+			  vf);
+		return -EINVAL;
+	}
+
 	switch (info) {
 	case E1000_VF_MAC_FILTER_CLR:
 		/* remove all unicast MAC filters related to the current VF */
@@ -7661,20 +7675,6 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 		}
 		break;
 	case E1000_VF_MAC_FILTER_ADD:
-		if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
-		    !vf_data->trusted) {
-			dev_warn(&pdev->dev,
-				 "VF %d requested MAC filter but is administratively denied\n",
-				 vf);
-			return -EINVAL;
-		}
-		if (!is_valid_ether_addr(addr)) {
-			dev_warn(&pdev->dev,
-				 "VF %d attempted to set invalid MAC filter\n",
-				 vf);
-			return -EINVAL;
-		}
-
 		/* try to find empty slot in the list */
 		list_for_each(pos, &adapter->vf_macs.l) {
 			entry = list_entry(pos, struct vf_mac_filter, l);
-- 
2.27.0

