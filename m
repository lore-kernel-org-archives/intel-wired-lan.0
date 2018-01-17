From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Jan 2018 08:16:00 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 05/12] i40evf: Alloc queues
 for ADq on VF
In-Reply-To: <20180117161607.49344-1-avinash.dayanand@intel.com>
References: <20180117161607.49344-1-avinash.dayanand@intel.com>
Message-ID: <20180117161607.49344-6-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch allocates number of queues requested by the user as a part
of TC command when ADq is enabled on a VF.

In order to be consistent in design with PF implementation of ADq,
don't allow to set channels via ethtool from VF when ADq is already
enabled. This means the users will not be able to change the number of
queues/channels via ethtool for a VF when ADq is ON. In order to be
able to use set channels, users will be required to disable ADq first
and then try setting the channels again.

When ADq is enabled on VF, it goes through a reset during which VSIs
and queues are re-configured. Meanwhile if we receive link status
message from PF even before the queues are re-configured, just ignore
this link up message.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  6 ++++++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index aded3ad..e679325 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -695,6 +695,12 @@ static int i40evf_set_channels(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
+	    adapter->num_tc) {
+		dev_info(&adapter->pdev->dev, "Cannot set channels since ADq is enabled.\n");
+		return -EINVAL;
+	}
+
 	/* All of these should have already been checked by ethtool before this
 	 * even gets to us, but just to be sure.
 	 */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index ec0275f..9d36553 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1146,6 +1146,9 @@ static int i40evf_alloc_queues(struct i40evf_adapter *adapter)
 	 */
 	if (adapter->num_req_queues)
 		num_active_queues = adapter->num_req_queues;
+	else if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
+		 adapter->num_tc)
+		num_active_queues = adapter->ch_config.total_qps;
 	else
 		num_active_queues = min_t(int,
 					  adapter->vsi_res->num_queue_pairs,
@@ -1473,6 +1476,16 @@ int i40evf_init_interrupt_scheme(struct i40evf_adapter *adapter)
 		goto err_alloc_q_vectors;
 	}
 
+	/* If we've made it so far while ADq flag being ON, then we haven't
+	 * bailed out anywhere in middle. And ADq isn't just enabled but actual
+	 * resources have been allocated in the reset path.
+	 * Now we can truly claim that ADq is enabled.
+	 */
+	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
+	    adapter->num_tc)
+		dev_info(&adapter->pdev->dev, "ADq Enabled, %u TCs created",
+			 adapter->num_tc);
+
 	dev_info(&adapter->pdev->dev, "Multiqueue %s: Queue pair count = %u",
 		 (adapter->num_active_queues > 1) ? "Enabled" : "Disabled",
 		 adapter->num_active_queues);
@@ -3244,6 +3257,7 @@ static void i40evf_remove(struct pci_dev *pdev)
 	/* Shut down all the garbage mashers on the detention level */
 	adapter->state = __I40EVF_REMOVE;
 	adapter->aq_required = 0;
+	adapter->flags &= ~I40EVF_FLAG_REINIT_ITR_NEEDED;
 	i40evf_request_reset(adapter);
 	msleep(50);
 	/* If the FW isn't responding, kick it once, but only once. */
-- 
2.9.4

