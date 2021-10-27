From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 27 Oct 2021 14:04:47 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix VF failed to init
 adminq: -53
Message-ID: <20211027120447.28075-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Norbert Zulinski <norbertx.zulinski@intel.com>

Fix the problem with init adminq in VF reset handler.
When the PF finished reinitialize VF resource set VFR_VFACTIVE bit
in VF Reset Status register. It is sign for VF driver among others
to shut down and reinitialize the admin queue. VF handle reset procedure
is sampling this register to check every 10ms. PF driver give up to 20ms
to VF reset procedure. For a single VF reset it is enoungh time to do it
but in case request VF reset twice, the first VF reset can be not
completely finished when PF requests it one more time.
Fixed by adding additional time for VF to finish reset procedure
before sending next VF reset request by PF.

Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Norbert Zulinski <norbertx.zulinski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5a488ce..ec0e52c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -172,6 +172,9 @@ void i40e_vc_notify_vf_reset(struct i40e_vf *vf)
 	    !test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states))
 		return;
 
+	if (ktime_get_ns() - vf->reset_timestamp < I40E_VF_RESET_TIME_MIN)
+		usleep_range(30000, 60000);
+
 	abs_vf_id = vf->vf_id + (int)vf->pf->hw.func_caps.vf_base_id;
 
 	pfe.event = VIRTCHNL_EVENT_RESET_IMPENDING;
@@ -1536,6 +1539,7 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 	i40e_cleanup_reset_vf(vf);
 
 	i40e_flush(hw);
+	vf->reset_timestamp = ktime_get_ns();
 	clear_bit(__I40E_VF_DISABLE, pf->state);
 
 	return true;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 49575a6..0e7d555 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -19,6 +19,7 @@
 #define I40E_MAX_VF_PROMISC_FLAGS	3
 
 #define I40E_VF_STATE_WAIT_COUNT	20
+#define I40E_VF_RESET_TIME_MIN		30000000	// time in nsec
 
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
@@ -80,6 +81,7 @@ struct i40e_vf {
 	u16 port_vlan_id;
 	bool pf_set_mac;	/* The VMM admin set the VF MAC address */
 	bool trusted;
+	u64 reset_timestamp;
 
 	/* VSI indices - actual VSI pointers are maintained in the PF structure
 	 * When assigned, these will be non-zero, because VSI 0 is always
-- 
2.27.0

