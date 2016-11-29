From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 28 Nov 2016 16:05:58 -0800
Subject: [Intel-wired-lan] [next PATCH S55 01/14] i40e: Disabling ntuple
	filters cleans Cloud Filters up
In-Reply-To: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480377971-23412-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch resolves the issue with Cloud Filters not being flushed from
driver memory and HW when ntuple filters get disabled. Additionally it was
possible to add Cloud Filters with ntuple mechanism off. Now Cloud Filters
can be added only with ntuple enabled. Error code is returned otherwise.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
Change-ID: I7bbc43ead41ead59be89ae2ca440a5c77fef2086
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 39 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  3 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 21 ++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 9413d8a..05552b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -224,6 +224,43 @@ struct i40e_fdir_filter {
 	u32 fd_id;
 };
 
+#define I40E_CLOUD_FIELD_OMAC   0x01
+#define I40E_CLOUD_FIELD_IMAC   0x02
+#define I40E_CLOUD_FIELD_IVLAN  0x04
+#define I40E_CLOUD_FIELD_TEN_ID 0x08
+#define I40E_CLOUD_FIELD_IIP    0x10
+
+#define I40E_CLOUD_FILTER_FLAGS_OMAC I40E_CLOUD_FIELD_OMAC
+#define I40E_CLOUD_FILTER_FLAGS_IMAC I40E_CLOUD_FIELD_IMAC
+#define I40E_CLOUD_FILTER_FLAGS_IMAC_IVLAN (I40E_CLOUD_FIELD_IMAC | \
+					    I40E_CLOUD_FIELD_IVLAN)
+#define I40E_CLOUD_FILTER_FLAGS_IMAC_TEN_ID (I40E_CLOUD_FIELD_IMAC | \
+					     I40E_CLOUD_FIELD_TEN_ID)
+#define I40E_CLOUD_FILTER_FLAGS_OMAC_TEN_ID_IMAC (I40E_CLOUD_FIELD_OMAC | \
+						  I40E_CLOUD_FIELD_IMAC | \
+						  I40E_CLOUD_FIELD_TEN_ID)
+#define I40E_CLOUD_FILTER_FLAGS_IMAC_IVLAN_TEN_ID (I40E_CLOUD_FIELD_IMAC | \
+						   I40E_CLOUD_FIELD_IVLAN | \
+						   I40E_CLOUD_FIELD_TEN_ID)
+#define I40E_CLOUD_FILTER_FLAGS_IIP  I40E_CLOUD_FIELD_IIP
+
+struct i40e_cloud_filter {
+	struct hlist_node cloud_node;
+	/* cloud filter input set follows */
+	u8 outer_mac[ETH_ALEN];
+	u8 inner_mac[ETH_ALEN];
+	__be16 inner_vlan;
+	__be32 inner_ip[4];
+	u32 tenant_id;
+	u8 flags;
+#define I40E_CLOUD_TNL_TYPE_NONE	0xff
+	u8 tunnel_type;
+	/* filter control */
+	u16 seid;
+	u16 queue_id;
+	u32 id;
+};
+
 #define I40E_ETH_P_LLDP			0x88cc
 
 #define I40E_DCB_PRIO_TYPE_STRICT	0
@@ -290,6 +327,8 @@ struct i40e_pf {
 	struct i40e_udp_port_config udp_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
 	u16 pending_udp_bitmap;
 
+	struct hlist_head cloud_filter_list;
+	u16 num_cloud_filters;
 	enum i40e_interrupt_policy int_policy;
 	u16 rx_itr_default;
 	u16 tx_itr_default;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index cc1465a..99772ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2705,6 +2705,9 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	if (pf->auto_disable_flags & I40E_FLAG_FD_SB_ENABLED)
 		return -ENOSPC;
 
+	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
+		return -EOPNOTSUPP;
+
 	if (test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state) ||
 	    test_bit(__I40E_RESET_INTR_RECEIVED, &pf->state))
 		return -EBUSY;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d718342..769f922 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5664,6 +5664,25 @@ static void i40e_fdir_filter_exit(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_cloud_filter_exit - Cleans up Cloud Filters
+ * @pf: Pointer to PF
+ *
+ * This function destroys the hlist which keeps all the Cloud Filters.
+ **/
+static void i40e_cloud_filter_exit(struct i40e_pf *pf)
+{
+	struct i40e_cloud_filter *cfilter;
+	struct hlist_node *node;
+
+	hlist_for_each_entry_safe(cfilter, node,
+				  &pf->cloud_filter_list, cloud_node) {
+		hlist_del(&cfilter->cloud_node);
+		kfree(cfilter);
+	}
+	pf->num_cloud_filters = 0;
+}
+
+/**
  * i40e_close - Disables a network interface
  * @netdev: network interface device structure
  *
@@ -6857,6 +6876,7 @@ static void i40e_fdir_teardown(struct i40e_pf *pf)
 	struct i40e_vsi *vsi;
 
 	i40e_fdir_filter_exit(pf);
+	i40e_cloud_filter_exit(pf);
 	vsi = i40e_find_vsi_by_type(pf, I40E_VSI_FDIR);
 	if (vsi)
 		i40e_vsi_release(vsi);
@@ -8801,6 +8821,7 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 		if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
 			need_reset = true;
 			i40e_fdir_filter_exit(pf);
+			i40e_cloud_filter_exit(pf);
 		}
 		pf->flags &= ~I40E_FLAG_FD_SB_ENABLED;
 		pf->auto_disable_flags &= ~I40E_FLAG_FD_SB_ENABLED;
-- 
2.4.11

