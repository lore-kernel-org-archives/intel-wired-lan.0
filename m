From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 22 Dec 2021 07:21:59 +0100
Subject: [Intel-wired-lan] [PATCH net-next 1/3] ice: add check for eswitch
 support
In-Reply-To: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
References: <20211222062201.36302-1-michal.swiatkowski@linux.intel.com>
Message-ID: <20211222062201.36302-2-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Driver support eswitch mode if there is SRIOV capabilities on hardware
and CONFIG_ICE_SWITCHDEV is on.

Create function to check if it is supported. Use it in MSI-X
reservation to not reserve additional vector when eswitch isn't
supported.

Introduce new capability flags to allow driver to disable eswitch
support when MSI-X reservation fails.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 29 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h | 12 ++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    | 15 ++++++----
 4 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 0b9b5b9c24b6..1ca309feabbf 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -488,6 +488,7 @@ enum ice_pf_flags {
 	ICE_FLAG_MDD_AUTO_RESET_VF,
 	ICE_FLAG_VF_VLAN_PRUNING,
 	ICE_FLAG_LINK_LENIENT_MODE_ENA,
+	ICE_FLAG_ESWITCH_CAPABLE,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 30a00fe59c52..fbe640d501c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -678,3 +678,32 @@ int ice_eswitch_rebuild(struct ice_pf *pf)
 
 	return 0;
 }
+
+/**
+ * ice_is_eswitch_supported - check if eswitch can be supported
+ * @pf: pointer to PF structure
+ */
+bool ice_is_eswitch_supported(struct ice_pf *pf)
+{
+	return test_bit(ICE_FLAG_ESWITCH_CAPABLE, pf->flags);
+}
+
+/**
+ * ice_eswitch_set_cap - set eswitch cap based on SRIOV cap
+ * @pf: pointer to PF structure
+ */
+void ice_eswitch_set_cap(struct ice_pf *pf)
+{
+	clear_bit(ICE_FLAG_ESWITCH_CAPABLE, pf->flags);
+	if (test_bit(ICE_FLAG_SRIOV_CAPABLE, pf->flags))
+		set_bit(ICE_FLAG_ESWITCH_CAPABLE, pf->flags);
+}
+
+/**
+ * ice_eswitch_clear_cap - clear switchdev cap when driver can't support it
+ * @pf: pointer to PF structure
+ */
+void ice_eswitch_clear_cap(struct ice_pf *pf)
+{
+	clear_bit(ICE_FLAG_ESWITCH_CAPABLE, pf->flags);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 0d0fadaf2ba5..b405e1c9c2bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -29,6 +29,9 @@ void ice_eswitch_set_target_vsi(struct sk_buff *skb,
 				struct ice_tx_offload_params *off);
 netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev);
+bool ice_is_eswitch_supported(struct ice_pf *pf);
+void ice_eswitch_set_cap(struct ice_pf *pf);
+void ice_eswitch_clear_cap(struct ice_pf *pf);
 #else /* CONFIG_ICE_SWITCHDEV */
 static inline void ice_eswitch_release(struct ice_pf *pf) { }
 
@@ -36,6 +39,9 @@ static inline void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf) { }
 static inline void ice_eswitch_replay_vf_mac_rule(struct ice_vf *vf) { }
 static inline void ice_eswitch_del_vf_mac_rule(struct ice_vf *vf) { }
 
+static inline void ice_eswitch_set_cap(struct ice_pf *pf) { }
+static inline void ice_eswitch_clear_cap(struct ice_pf *pf) { }
+
 static inline int
 ice_eswitch_add_vf_mac_rule(struct ice_pf *pf, struct ice_vf *vf,
 			    const u8 *mac)
@@ -81,5 +87,11 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	return NETDEV_TX_BUSY;
 }
+
+static inline bool
+ice_is_eswitch_supported(struct ice_pf *pf)
+{
+	return false;
+}
 #endif /* CONFIG_ICE_SWITCHDEV */
 #endif /* _ICE_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 296c4dd90e26..e31c01673d3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3735,6 +3735,8 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 	if (func_caps->common_cap.ieee_1588)
 		set_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
 
+	ice_eswitch_set_cap(pf);
+
 	pf->max_pf_txqs = func_caps->common_cap.num_txq;
 	pf->max_pf_rxqs = func_caps->common_cap.num_rxq;
 }
@@ -3810,11 +3812,13 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 	}
 
 	/* reserve for switchdev */
-	needed = ICE_ESWITCH_MSIX;
-	if (v_left < needed)
-		goto no_hw_vecs_left_err;
-	v_budget += needed;
-	v_left -= needed;
+	if (ice_is_eswitch_supported(pf)) {
+		needed = ICE_ESWITCH_MSIX;
+		if (v_left < needed)
+			goto no_hw_vecs_left_err;
+		v_budget += needed;
+		v_left -= needed;
+	}
 
 	/* total used for non-traffic vectors */
 	v_other = v_budget;
@@ -3920,6 +3924,7 @@ static int ice_ena_msix_range(struct ice_pf *pf)
 		needed, v_left);
 	err = -ERANGE;
 exit_err:
+	ice_eswitch_clear_cap(pf);
 	pf->num_rdma_msix = 0;
 	pf->num_lan_msix = 0;
 	return err;
-- 
2.31.1

