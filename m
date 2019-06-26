From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:22 -0700
Subject: [Intel-wired-lan] [PATCH S22 11/16] ice: Add stats for Rx drops at
 the port level
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we are not reporting dropped counts at the port level to
ethtool or netlink. This was found when debugging Rx dropped issues
and the total packets sent did not equal the total packets received
minus the rx_dropped, which was very confusing. To determine dropped
counts at the port level we need to read the PRTRPB_RDPC register.
To fix reporting we will store the dropped counts in the PF's
rx_discards. This will be reported to netlink by storing it in the
PF VSI's rx_missed_errors signaling that the receiver missed the
packet. Also, we will report this to ethtool in the rx_dropped.nic
field.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 3250dfc00002..87652d722a30 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -337,5 +337,6 @@
 #define VSIQF_HLUT_MAX_INDEX			15
 #define VFINT_DYN_CTLN(_i)			(0x00003800 + ((_i) * 4))
 #define VFINT_DYN_CTLN_CLEARPBA_M		BIT(1)
+#define PRTRPB_RDPC				0x000AC260
 
 #endif /* _ICE_HW_AUTOGEN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8d6c4f64cdb9..8a506ba943d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3609,6 +3609,8 @@ static void ice_update_vsi_stats(struct ice_vsi *vsi)
 		cur_ns->rx_errors = pf->stats.crc_errors +
 				    pf->stats.illegal_bytes;
 		cur_ns->rx_length_errors = pf->stats.rx_len_errors;
+		/* record drops from the port level */
+		cur_ns->rx_missed_errors = pf->stats.eth.rx_discards;
 	}
 }
 
@@ -3642,6 +3644,10 @@ static void ice_update_pf_stats(struct ice_pf *pf)
 			  &prev_ps->eth.rx_broadcast,
 			  &cur_ps->eth.rx_broadcast);
 
+	ice_stat_update32(hw, PRTRPB_RDPC, pf->stat_prev_loaded,
+			  &prev_ps->eth.rx_discards,
+			  &cur_ps->eth.rx_discards);
+
 	ice_stat_update40(hw, GLPRT_GOTCL(pf_id), pf->stat_prev_loaded,
 			  &prev_ps->eth.tx_bytes,
 			  &cur_ps->eth.tx_bytes);
-- 
2.20.1

