From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri,  5 Feb 2021 09:41:15 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix return of set the new
 channel count
Message-ID: <20210205094115.15222-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixed return correct code from set the new channel count.
Implemented by check if reset is done in appropriate time.
This solution give a extra time to pf for reset vf in case
when user want set new channel count for all vfs.
Without this patch it is possible to return misleading output
code to user and vf reset not to be correctly performed by pf.

Fixes: 5520deb15326("iavf: Enable support for up to 16 queues")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 3ebfef7..d9ed4d4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1522,6 +1522,7 @@ static int iavf_set_channels(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 num_req = ch->combined_count;
+	int i;
 
 	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
 	    adapter->num_tc) {
@@ -1544,6 +1545,20 @@ static int iavf_set_channels(struct net_device *netdev,
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	iavf_schedule_reset(adapter);
+
+	/* wait for the reset is done */
+	for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
+		msleep(IAVF_RESET_WAIT_MS);
+		if (adapter->flags & IAVF_FLAG_RESET_PENDING)
+			continue;
+		break;
+	}
+	if (i == IAVF_RESET_WAIT_COUNT) {
+		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+		adapter->num_active_queues = num_req;
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

