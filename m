From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:35 -0700
Subject: [Intel-wired-lan] [PATCH net-next 15/15] iavf: don't be so alarming
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Reduce the log level of a couple of messages. These can appear during normal
reset and rmmod processing, and the driver recovers just fine. Debug
level is fine for these.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7730de0ef236..06be785c0d82 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3352,7 +3352,7 @@ static int iavf_close(struct net_device *netdev)
 				    adapter->state == __IAVF_DOWN,
 				    msecs_to_jiffies(500));
 	if (!status)
-		netdev_warn(netdev, "Device resources not yet released\n");
+		netdev_dbg(netdev, "Device resources not yet released\n");
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index d78206e168bc..ba27b2168fd3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1866,8 +1866,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		break;
 	default:
 		if (adapter->current_op && (v_opcode != adapter->current_op))
-			dev_warn(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
-				 adapter->current_op, v_opcode);
+			dev_dbg(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
+				adapter->current_op, v_opcode);
 		break;
 	} /* switch v_opcode */
 	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-- 
2.20.1

