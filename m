From: Michal Maloszewski <michal.maloszewski@intel.com>
Date: Thu, 28 Apr 2022 09:30:13 +0000
Subject: [Intel-wired-lan] [PATCH net v4] iavf: Fix error when changing ring
 parameters on ice PF
Message-ID: <20220428093013.186832-1-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reset is triggered when ring parameters are being changed through
ethtool and queues are reconfigured for VF's VSI. If ring is changed
again immediately, then the next reset could be executed before
queues could be properly reinitialized on VF's VSI. It caused ice PF
to mess up the VSI resource tree.

Add a check in iavf_set_ringparam for adapter and VF's queue
state. If VF is currently resetting or queues are disabled for the VF
return with EAGAIN error.

Fixes: d732a1844507 ("i40evf: fix crash when changing ring sizes")
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
---
v4: Changed order of if statements suggested by community
    Answer to question:
    Can't we wait for the device to get into the right state?
    Throwing EAGAIN back to user space is not very friendly.
    Answer:
    When we have state which is running, it does not mean
    that we have queues configured on PF. So in order to
    configure queues on PF, the IAVF_FLAG_QUEUES has to be
    disabled. I use here EAGAIN because as long as we are not
    configured with queues, it does not make any sens to trigger
    command and we are not sure when the configuration of queues
    will end - so that is why EAGAIN is used.
v3: Correct patch to be send on right tree
v2: Changed unnecessary parentheses
---
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 3bb56714beb0..15e02a6105b9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -628,6 +628,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 
+	if (adapter->state == __IAVF_RESETTING ||
+	    adapter->state == __IAVF_RUNNING &&
+	     (adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
+		return -EAGAIN;
+
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-- 
2.27.0

