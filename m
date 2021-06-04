From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:23 -0700
Subject: [Intel-wired-lan] [PATCH net-next 03/15] iavf: obtain crit_section
 lock in iavf_close() immediately
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

iavf_close() checks the adapter state outside of the crit_section lock
so that it can quickly bail out of the function if the interface is already
down. This doesn't work as intended, though, since it may be seeing a
transient state if iavf_reset_task() is running on a separate thread. If
this happens the driver will hit a panic later in iavf_remove() since the
active resources were never unconfigured correctly.

To fix this the adapter state is checked after grabbing the crit_section
lock.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4c55773c6ee1..f97d04b47292 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3271,13 +3271,15 @@ static int iavf_close(struct net_device *netdev)
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int status;
 
-	if (adapter->state <= __IAVF_DOWN_PENDING)
-		return 0;
-
 	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
 
+	if (adapter->state <= __IAVF_DOWN_PENDING) {
+		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
+		return 0;
+	}
+
 	set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
 	if (CLIENT_ENABLED(adapter))
 		adapter->flags |= IAVF_FLAG_CLIENT_NEEDS_CLOSE;
-- 
2.20.1

