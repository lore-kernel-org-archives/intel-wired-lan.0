From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:11 -0700
Subject: [Intel-wired-lan] [PATCH S50 08/15] ice: Adjust scheduler default
 BW weight
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tarun Singh <tarun.k.singh@intel.com>

By default the queues are configured in legacy mode. The default
BW settings for legacy/advanced modes are different. The existing
code was using the advanced mode default value of 1 which was
incorrect. This caused the unbalanced BW sharing among siblings.
The recommneded default value is applied.

Signed-off-by: Tarun Singh <tarun.k.singh@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 13 ++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 99b12446c7b0..d1d827a69271 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3888,7 +3888,18 @@ ice_ena_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 q_handle,
 	 * Without setting the generic section as valid in valid_sections, the
 	 * Admin queue command will fail with error code ICE_AQ_RC_EINVAL.
 	 */
-	buf->txqs[0].info.valid_sections = ICE_AQC_ELEM_VALID_GENERIC;
+	buf->txqs[0].info.valid_sections =
+		ICE_AQC_ELEM_VALID_GENERIC | ICE_AQC_ELEM_VALID_CIR |
+		ICE_AQC_ELEM_VALID_EIR;
+	buf->txqs[0].info.generic = 0;
+	buf->txqs[0].info.cir_bw.bw_profile_idx =
+		cpu_to_le16(ICE_SCHED_DFLT_RL_PROF_ID);
+	buf->txqs[0].info.cir_bw.bw_alloc =
+		cpu_to_le16(ICE_SCHED_DFLT_BW_WT);
+	buf->txqs[0].info.eir_bw.bw_profile_idx =
+		cpu_to_le16(ICE_SCHED_DFLT_RL_PROF_ID);
+	buf->txqs[0].info.eir_bw.bw_alloc =
+		cpu_to_le16(ICE_SCHED_DFLT_BW_WT);
 
 	/* add the LAN queue */
 	status = ice_aq_add_lan_txq(hw, num_qgrps, buf, buf_size, cd);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index bf31ccf01100..1fe8b0cbf064 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -418,7 +418,7 @@ enum ice_rl_type {
 #define ICE_SCHED_DFLT_BW		0xFFFFFFFF	/* unlimited */
 #define ICE_SCHED_DFLT_RL_PROF_ID	0
 #define ICE_SCHED_NO_SHARED_RL_PROF_ID	0xFFFF
-#define ICE_SCHED_DFLT_BW_WT		1
+#define ICE_SCHED_DFLT_BW_WT		4
 #define ICE_SCHED_INVAL_PROF_ID		0xFFFF
 #define ICE_SCHED_DFLT_BURST_SIZE	(15 * 1024)	/* in bytes (15k) */
 
-- 
2.20.1

