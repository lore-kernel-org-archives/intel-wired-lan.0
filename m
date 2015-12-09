From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed,  9 Dec 2015 15:50:27 -0800
Subject: [Intel-wired-lan] [next PATCH S23 07/13] i40evf: allow channel
	bonding of VFs
In-Reply-To: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1449705033-4968-8-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

In some modes, bonding would not enslave VF interfaces. This is due to
bonding calling change_mtu and the immediately calling open. Because of
the asynchronous nature of the admin queue mechanism, the VF returns
-EBUSY to the open call, because it knows the previous operation hasn't
finished yet. This causes bonding to fail with a less-than-useful error
message.

To fix this, remove the check for pending operations at the beginning of
open. But this introduces a new bug where the driver will panic on a
quick close/open cycle. To fix that, we add a new driver state,
__I40EVF_DOWN_PENDING, that the driver enters when down is called. The
driver finally transitions to a fully DOWN state when it receives
confirmation from the PF driver that all the queues are disabled. This
allows open to complete even if there is a pending mtu change, and
bonding is finally happy.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I06f4c7e435d5bacbfceaa7c3f209e0ff04be21cc
---
 drivers/net/ethernet/intel/i40evf/i40evf.h          | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 9 +++++----
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index be1b72b..9e15f68 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -173,6 +173,7 @@ enum i40evf_state_t {
 	__I40EVF_RESETTING,		/* in reset */
 	/* Below here, watchdog is running */
 	__I40EVF_DOWN,			/* ready, can be opened */
+	__I40EVF_DOWN_PENDING,		/* descending, waiting for watchdog */
 	__I40EVF_TESTING,		/* in ethtool self-test */
 	__I40EVF_RUNNING,		/* opened, working */
 };
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 455394c..d859045 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1032,7 +1032,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	struct i40evf_mac_filter *f;
 
-	if (adapter->state == __I40EVF_DOWN)
+	if (adapter->state <= __I40EVF_DOWN_PENDING)
 		return;
 
 	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
@@ -2142,7 +2142,8 @@ static int i40evf_open(struct net_device *netdev)
 		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
 		return -EIO;
 	}
-	if (adapter->state != __I40EVF_DOWN || adapter->aq_required)
+
+	if (adapter->state != __I40EVF_DOWN)
 		return -EBUSY;
 
 	/* allocate transmit descriptors */
@@ -2197,14 +2198,14 @@ static int i40evf_close(struct net_device *netdev)
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 
-	if (adapter->state <= __I40EVF_DOWN)
+	if (adapter->state <= __I40EVF_DOWN_PENDING)
 		return 0;
 
 
 	set_bit(__I40E_DOWN, &adapter->vsi.state);
 
 	i40evf_down(adapter);
-	adapter->state = __I40EVF_DOWN;
+	adapter->state = __I40EVF_DOWN_PENDING;
 	i40evf_free_traffic_irqs(adapter);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index c1c5262..d3739cc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -804,6 +804,8 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 	case I40E_VIRTCHNL_OP_DISABLE_QUEUES:
 		i40evf_free_all_tx_resources(adapter);
 		i40evf_free_all_rx_resources(adapter);
+		if (adapter->state == __I40EVF_DOWN_PENDING)
+			adapter->state = __I40EVF_DOWN;
 		break;
 	case I40E_VIRTCHNL_OP_VERSION:
 	case I40E_VIRTCHNL_OP_CONFIG_IRQ_MAP:
-- 
2.1.0

