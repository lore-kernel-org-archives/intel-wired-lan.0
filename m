From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:46 -0700
Subject: [Intel-wired-lan] [next PATCH S91 08/11] i40evf: remove MAX_QUEUES
 and just use I40EVF_MAX_REQ_QUEUES
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We don't really need to have separate definitions for MAX_QUEUES and
I40EVF_MAX_REQ_QUEUES, since we'll always be limited by how many queues
we request anyways. If we haven't enabled requesting the maximum number
of queues, there's no reason to have our call to alloc_etherdev_mq
actually pass the higher value, since we'd never enable those queues
anyways.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      | 1 -
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 98b8349..96e537a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -81,7 +81,6 @@ struct i40e_vsi {
 #define I40E_TX_DESC(R, i) (&(((struct i40e_tx_desc *)((R)->desc))[i]))
 #define I40E_TX_CTXTDESC(R, i) \
 	(&(((struct i40e_tx_context_desc *)((R)->desc))[i]))
-#define MAX_QUEUES 16
 #define I40EVF_MAX_REQ_QUEUES 4
 
 #define I40EVF_HKEY_ARRAY_SIZE ((I40E_VFQF_HKEY_MAX_INDEX + 1) * 4)
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 3f04a182..95a222d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2331,7 +2331,7 @@ static int i40evf_validate_ch_config(struct i40evf_adapter *adapter,
 		total_max_rate += tx_rate;
 		num_qps += mqprio_qopt->qopt.count[i];
 	}
-	if (num_qps > MAX_QUEUES)
+	if (num_qps > I40EVF_MAX_REQ_QUEUES)
 		return -EINVAL;
 
 	ret = i40evf_validate_tx_bandwidth(adapter, total_max_rate);
@@ -3689,7 +3689,8 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	netdev = alloc_etherdev_mq(sizeof(struct i40evf_adapter), MAX_QUEUES);
+	netdev = alloc_etherdev_mq(sizeof(struct i40evf_adapter),
+				   I40EVF_MAX_REQ_QUEUES);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
-- 
2.9.5

