From: Karen Sornek <karen.sornek@intel.com>
Date: Wed,  1 Sep 2021 10:27:31 +0200
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix not to overload flags
Message-ID: <20210901082731.74893-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The IAVF_FLAG_REINIT_ITR_NEEDED flag was being used for two different
purposes. As originally written, it indicates to the ITR mechanism to
update the interrupt registers to a new setting. Sometime later, it was
overloaded to indicate that interrupts need to be completely
reinitialized during reset. This causes problems when ethtool -C is used
while a reset is in progress, and can lead to RTNL deadlocks.

To fix this, add a new flag with a new name and use that to trigger
MSI-X reinit.

Fixes: 5b36e8d04b44 ("i40evf: Enable VF to request an alternate queue allocation")
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 21c957755..5a36af8b9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -272,6 +272,7 @@ struct iavf_adapter {
 #define IAVF_FLAG_LEGACY_RX			BIT(15)
 #define IAVF_FLAG_REINIT_ITR_NEEDED		BIT(16)
 #define IAVF_FLAG_QUEUES_DISABLED		BIT(17)
+#define IAVF_FLAG_REINIT_MSIX_NEEDED		BIT(20)
 /* duplicates for common code */
 #define IAVF_FLAG_DCB_ENABLED			0
 	/* flags for admin queue service task */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26..4b7a670de 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3556,7 +3556,7 @@ int iavf_process_config(struct iavf_adapter *adapter)
 			"Requested %d queues, but PF only gave us %d.\n",
 			num_req_queues,
 			adapter->vsi_res->num_queue_pairs);
-		adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
+		adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
 		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
 		iavf_schedule_reset(adapter);
 		return -ENODEV;
-- 
2.27.0

