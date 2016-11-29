From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:06:06 -0800
Subject: [Intel-wired-lan] [next PATCH S55 09/14] i40evf: track outstanding
	client request
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The iWarp client cannot continue until this operation has been completed
by the PF driver. Sleep (with timeout) until the reply from the PF
driver has been received.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I5dc41b857bba32d0218b7ce167b5da122dadf349
---
Testing Hints : Load up VF RDMA with > 2 active VFs.

 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf.h          | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
index fc374f8..d38a2b2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h
@@ -81,6 +81,7 @@ enum i40e_virtchnl_ops {
 	I40E_VIRTCHNL_OP_GET_STATS = 15,
 	I40E_VIRTCHNL_OP_FCOE = 16,
 	I40E_VIRTCHNL_OP_EVENT = 17, /* must ALWAYS be 17 */
+	I40E_VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP = 21,
 	I40E_VIRTCHNL_OP_CONFIG_RSS_KEY = 23,
 	I40E_VIRTCHNL_OP_CONFIG_RSS_LUT = 24,
 	I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS = 25,
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 1789266..f16d9d1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -195,6 +195,7 @@ struct i40evf_adapter {
 	u64 hw_csum_rx_error;
 	u32 rx_desc_count;
 	int num_msix_vectors;
+	u32 client_pending;
 	struct msix_entry *msix_entries;
 
 	u32 flags;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 2059a8e..bee58af 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -999,6 +999,10 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		if (v_opcode != adapter->current_op)
 			return;
 		break;
+	case I40E_VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP:
+		adapter->client_pending &=
+				~(BIT(I40E_VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP));
+		break;
 	case I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS: {
 		struct i40e_virtchnl_rss_hena *vrh =
 			(struct i40e_virtchnl_rss_hena *)msg;
-- 
2.4.11

