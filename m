From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:32 -0700
Subject: [Intel-wired-lan] [PATCH net-next 12/15] iavf: Log info when VF is
 entering and leaving Allmulti mode
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

Add log when VF is entering and leaving Allmulti mode.
The change of VF state is visible in dmesg now.
Without this commit, entering and leaving Allmulti mode
is not logged in dmesg.

Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 3c3fd604218e..d78206e168bc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -711,15 +711,23 @@ void iavf_set_promiscuous(struct iavf_adapter *adapter, int flags)
 	if (flags & FLAG_VF_MULTICAST_PROMISC) {
 		adapter->flags |= IAVF_FLAG_ALLMULTI_ON;
 		adapter->aq_required &= ~IAVF_FLAG_AQ_REQUEST_ALLMULTI;
-		dev_info(&adapter->pdev->dev, "Entering multicast promiscuous mode\n");
+		dev_info(&adapter->pdev->dev, "%s is entering multicast promiscuous mode\n",
+			 adapter->netdev->name);
 	}
 
 	if (!flags) {
-		adapter->flags &= ~(IAVF_FLAG_PROMISC_ON |
-				    IAVF_FLAG_ALLMULTI_ON);
-		adapter->aq_required &= ~(IAVF_FLAG_AQ_RELEASE_PROMISC |
-					  IAVF_FLAG_AQ_RELEASE_ALLMULTI);
-		dev_info(&adapter->pdev->dev, "Leaving promiscuous mode\n");
+		if (adapter->flags & IAVF_FLAG_PROMISC_ON) {
+			adapter->flags &= ~IAVF_FLAG_PROMISC_ON;
+			adapter->aq_required &= ~IAVF_FLAG_AQ_RELEASE_PROMISC;
+			dev_info(&adapter->pdev->dev, "Leaving promiscuous mode\n");
+		}
+
+		if (adapter->flags & IAVF_FLAG_ALLMULTI_ON) {
+			adapter->flags &= ~IAVF_FLAG_ALLMULTI_ON;
+			adapter->aq_required &= ~IAVF_FLAG_AQ_RELEASE_ALLMULTI;
+			dev_info(&adapter->pdev->dev, "%s is leaving multicast promiscuous mode\n",
+				 adapter->netdev->name);
+		}
 	}
 
 	adapter->current_op = VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE;
-- 
2.20.1

