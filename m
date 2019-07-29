From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Jul 2019 02:04:49 -0700
Subject: [Intel-wired-lan] [PATCH S24 v2 07/12] ice: reject VF attempts to
 enable head writeback
In-Reply-To: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
Message-ID: <20190729090454.5501-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The virtchnl interface provides a mechanism for a VF driver to request
head writeback support. This feature is deprecated as of AVF 1.0, but
older versions of a VF driver may still attempt to request the mode.

Since the ice hardware does not support head writeback, we should not
accept Tx queue configuration which attempts to enable it.

Currently, the driver simply assumes that the headwb_enabled bit will
never be set.

If a VF driver does request head writeback, the configuration will
return successfully, even though head writeback is not enabled. This
leaves the VF driver in a non functional state since it is assuming to
be operating in head writeback mode.

Fix the PF driver to reject any attempt to setup headwb_enabled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 1b1d1ea0c8f9..73ab6222d29b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2109,6 +2109,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		if (qpi->txq.vsi_id != qci->vsi_id ||
 		    qpi->rxq.vsi_id != qci->vsi_id ||
 		    qpi->rxq.queue_id != qpi->txq.queue_id ||
+		    qpi->txq.headwb_enabled ||
 		    !ice_vc_isvalid_q_id(vf, qci->vsi_id, qpi->txq.queue_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
-- 
2.20.1

