From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:10 -0700
Subject: [Intel-wired-lan] [next PATCH S36 02/12] i40e: Add allmulti support
	for the VF
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This patch enables a feature to enable/disable all multicast
for a trusted VF.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-Id: I926eba7f8850c8d40f8ad7e08bbe4056bbd3985f
---
 drivers/net/ethernet/intel/i40evf/i40evf.h          |  3 +++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 15 ++++++++++++++-
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 15 +++++++++++++--
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 1b93d66..34d50ba 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -215,6 +215,7 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE	BIT(12)
 #define I40EVF_FLAG_ADDR_SET_BY_PF		BIT(13)
 #define I40EVF_FLAG_PROMISC_ON			 BIT(15)
+#define I40EVF_FLAG_ALLMULTI_ON			 BIT(16)
 /* duplicates for common code */
 #define I40E_FLAG_FDIR_ATR_ENABLED		 0
 #define I40E_FLAG_DCB_ENABLED			 0
@@ -241,6 +242,8 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_AQ_SET_RSS_LUT		BIT(14)
 #define I40EVF_FLAG_AQ_REQUEST_PROMISC		BIT(15)
 #define I40EVF_FLAG_AQ_RELEASE_PROMISC		BIT(16)
+#define I40EVF_FLAG_AQ_REQUEST_ALLMULTI		BIT(17)
+#define I40EVF_FLAG_AQ_RELEASE_ALLMULTI		BIT(18)
 
 	/* OS defined structs */
 	struct net_device *netdev;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index b548dbe..642bb45 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -934,6 +934,13 @@ bottom_of_search_loop:
 		 adapter->flags & I40EVF_FLAG_PROMISC_ON)
 		adapter->aq_required |= I40EVF_FLAG_AQ_RELEASE_PROMISC;
 
+	if (netdev->flags & IFF_ALLMULTI &&
+	    !(adapter->flags & I40EVF_FLAG_ALLMULTI_ON))
+		adapter->aq_required |= I40EVF_FLAG_AQ_REQUEST_ALLMULTI;
+	else if (!(netdev->flags & IFF_ALLMULTI) &&
+		 adapter->flags & I40EVF_FLAG_ALLMULTI_ON)
+		adapter->aq_required |= I40EVF_FLAG_AQ_RELEASE_ALLMULTI;
+
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 }
 
@@ -1612,7 +1619,13 @@ static void i40evf_watchdog_task(struct work_struct *work)
 		goto watchdog_done;
 	}
 
-	if (adapter->aq_required & I40EVF_FLAG_AQ_RELEASE_PROMISC) {
+	if (adapter->aq_required & I40EVF_FLAG_AQ_REQUEST_ALLMULTI) {
+		i40evf_set_promiscuous(adapter, I40E_FLAG_VF_MULTICAST_PROMISC);
+		goto watchdog_done;
+	}
+
+	if ((adapter->aq_required & I40EVF_FLAG_AQ_RELEASE_PROMISC) &&
+	    (adapter->aq_required & I40EVF_FLAG_AQ_RELEASE_ALLMULTI)) {
 		i40evf_set_promiscuous(adapter, 0);
 		goto watchdog_done;
 	}
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index c5d33a2..f134456 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -641,6 +641,7 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags)
 {
 	struct i40e_virtchnl_promisc_info vpi;
+	int promisc_all;
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -649,11 +650,21 @@ void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags)
 		return;
 	}
 
-	if (flags) {
+	promisc_all = I40E_FLAG_VF_UNICAST_PROMISC |
+		      I40E_FLAG_VF_MULTICAST_PROMISC;
+	if ((flags & promisc_all) == promisc_all) {
 		adapter->flags |= I40EVF_FLAG_PROMISC_ON;
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_REQUEST_PROMISC;
 		dev_info(&adapter->pdev->dev, "Entering promiscuous mode\n");
-	} else {
+	}
+
+	if (flags & I40E_FLAG_VF_MULTICAST_PROMISC) {
+		adapter->flags |= I40EVF_FLAG_ALLMULTI_ON;
+		adapter->aq_required &= ~I40EVF_FLAG_AQ_REQUEST_ALLMULTI;
+		dev_info(&adapter->pdev->dev, "Entering multicast promiscuous mode\n");
+	}
+
+	if (!flags) {
 		adapter->flags &= ~I40EVF_FLAG_PROMISC_ON;
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_RELEASE_PROMISC;
 		dev_info(&adapter->pdev->dev, "Leaving promiscuous mode\n");
-- 
2.4.11

