From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:31 -0700
Subject: [Intel-wired-lan] [PATCH S43 02/15] ice: print Rx MDD auto reset
 message before VF reset
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Rx MDD auto reset message was not being logged because logging occurred
after the VF reset and the VF MDD data was reinitialized.

Log the Rx MDD auto reset message before triggering the VF reset.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     |  7 +++++-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 25 ++++++++++++++-----
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 ++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6af21510c694..9a05945c6419 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1326,8 +1326,13 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			 * PF can be configured to reset the VF through ethtool
 			 * private flag mdd-auto-reset-vf.
 			 */
-			if (test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags))
+			if (test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)) {
+				/* VF MDD event counters will be cleared by
+				 * reset, so print the event prior to reset.
+				 */
+				ice_print_vf_rx_mdd_event(vf);
 				ice_reset_vf(&pf->vf[i], false);
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index a046bd3431c6..7c8c1687f0bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3764,6 +3764,24 @@ int ice_get_vf_stats(struct net_device *netdev, int vf_id,
 	return 0;
 }
 
+/**
+ * ice_print_vf_rx_mdd_event - print VF Rx malicious driver detect event
+ * @vf: pointer to the VF structure
+ */
+void ice_print_vf_rx_mdd_event(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+	struct device *dev;
+
+	dev = ice_pf_to_dev(pf);
+
+	dev_info(dev, "%d Rx Malicious Driver Detection events detected on PF %d VF %d MAC %pM. mdd-auto-reset-vfs=%s\n",
+		 vf->mdd_rx_events.count, pf->hw.pf_id, vf->vf_id,
+		 vf->dflt_lan_addr.addr,
+		 test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)
+			  ? "on" : "off");
+}
+
 /**
  * ice_print_vfs_mdd_event - print VFs malicious driver detect event
  * @pf: pointer to the PF structure
@@ -3793,12 +3811,7 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf)
 		if (vf->mdd_rx_events.count != vf->mdd_rx_events.last_printed) {
 			vf->mdd_rx_events.last_printed =
 							vf->mdd_rx_events.count;
-
-			dev_info(dev, "%d Rx Malicious Driver Detection events detected on PF %d VF %d MAC %pM. mdd-auto-reset-vfs=%s\n",
-				 vf->mdd_rx_events.count, hw->pf_id, i,
-				 vf->dflt_lan_addr.addr,
-				 test_bit(ICE_FLAG_MDD_AUTO_RESET_VF, pf->flags)
-					  ? "on" : "off");
+			ice_print_vf_rx_mdd_event(vf);
 		}
 
 		/* only print Tx MDD event message if there are new events */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 474293ff4fe5..0adff89a6749 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -132,6 +132,7 @@ bool ice_is_any_vf_in_promisc(struct ice_pf *pf);
 void
 ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event);
 void ice_print_vfs_mdd_events(struct ice_pf *pf);
+void ice_print_vf_rx_mdd_event(struct ice_vf *vf);
 #else /* CONFIG_PCI_IOV */
 #define ice_process_vflr_event(pf) do {} while (0)
 #define ice_free_vfs(pf) do {} while (0)
@@ -141,6 +142,7 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf);
 #define ice_set_vf_state_qs_dis(vf) do {} while (0)
 #define ice_vf_lan_overflow_event(pf, event) do {} while (0)
 #define ice_print_vfs_mdd_events(pf) do {} while (0)
+#define ice_print_vf_rx_mdd_event(vf) do {} while (0)
 
 static inline bool
 ice_reset_all_vfs(struct ice_pf __always_unused *pf,
-- 
2.20.1

