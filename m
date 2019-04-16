From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:24:36 -0700
Subject: [Intel-wired-lan] [PATCH S19 12/15] ice: Reorganize ice_vf struct
In-Reply-To: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172439.27908-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The ice_vf struct can be used hundreds of times in our
driver so it pays to use less memory per struct.

ice_vf prior to this commit:
  /* size: 112, cachelines: 2, members: 25 */
  /* sum members: 101, holes: 4, sum holes: 8 */
  /* bit holes: 2, sum bit holes: 11 bits */
  /* padding: 3 */
  /* last cacheline: 48 bytes */

ice_vf after this commit:
  /* size: 104, cachelines: 2, members: 25 */
  /* sum members: 100, holes: 3, sum holes: 4 */
  /* bit holes: 1, sum bit holes: 3 bits */
  /* last cacheline: 40 bytes */

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 60f024ae281d..9583ad3f6fb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -49,29 +49,34 @@ struct ice_vf {
 	struct ice_pf *pf;
 
 	s16 vf_id;			/* VF ID in the PF space */
-	u32 driver_caps;		/* reported by VF driver */
+	u16 lan_vsi_idx;		/* index into PF struct */
 	int first_vector_idx;		/* first vector index of this VF */
 	struct ice_sw *vf_sw_id;	/* switch ID the VF VSIs connect to */
 	struct virtchnl_version_info vf_ver;
+	u32 driver_caps;		/* reported by VF driver */
 	struct virtchnl_ether_addr dflt_lan_addr;
 	u16 port_vlan_id;
 	u8 pf_set_mac:1;		/* VF MAC address set by VMM admin */
 	u8 trusted:1;
-	u16 lan_vsi_idx;		/* index into PF struct */
+	u8 spoofchk:1;
+	u8 link_forced:1;
+	u8 link_up:1;			/* only valid if VF link is forced */
+	/* VSI indices - actual VSI pointers are maintained in the PF structure
+	 * When assigned, these will be non-zero, because VSI 0 is always
+	 * the main LAN VSI for the PF.
+	 */
 	u16 lan_vsi_num;		/* ID as used by firmware */
+	unsigned int tx_rate;		/* Tx bandwidth limit in Mbps */
+	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
+
 	u64 num_mdd_events;		/* number of MDD events detected */
 	u64 num_inval_msgs;		/* number of continuous invalid msgs */
 	u64 num_valid_msgs;		/* number of valid msgs detected */
 	unsigned long vf_caps;		/* VF's adv. capabilities */
-	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
-	unsigned int tx_rate;		/* Tx bandwidth limit in Mbps */
-	u8 link_forced:1;
-	u8 link_up:1;			/* only valid if VF link is forced */
-	u8 spoofchk:1;
+	u8 num_req_qs;			/* num of queue pairs requested by VF */
 	u16 num_mac;
 	u16 num_vlan;
 	u16 num_vf_qs;			/* num of queue configured per VF */
-	u8 num_req_qs;			/* num of queue pairs requested by VF */
 };
 
 #ifdef CONFIG_PCI_IOV
-- 
2.20.1

