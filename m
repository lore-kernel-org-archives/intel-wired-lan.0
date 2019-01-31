From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 31 Jan 2019 13:57:19 -0800
Subject: [Intel-wired-lan] [STABLE 4/4] ice: Set timeout when disabling
 queues
In-Reply-To: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
References: <20190131215719.8272-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190131215719.8272-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch is a backport of a single line of code from mainline
commit ddf30f7ff840 ("ice: Add handler to configure SR-IOV")

Queues are disabled during module unload using the ice_aqc_opc_dis_txqs
admin queue command. On the latest firmware, this command fails with
the following message: "Failed to disable LAN Tx queues, error: -100"

This patch fixes this issue by setting the timeout field in the command
descriptor.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index fb5e77f263e5..a8749f4a0cb8 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1865,6 +1865,8 @@ ice_aq_dis_lan_txq(struct ice_hw *hw, u8 num_qgrps,
 		return ICE_ERR_PARAM;
 	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 	cmd->num_entries = num_qgrps;
+	cmd->vmvf_and_timeout = cpu_to_le16((5 << ICE_AQC_Q_DIS_TIMEOUT_S) &
+					    ICE_AQC_Q_DIS_TIMEOUT_M);
 
 	for (i = 0; i < num_qgrps; ++i) {
 		/* Calculate the size taken up by the queue IDs in this group */
-- 
2.17.2

