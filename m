From: =?unknown-8bit?q?Ond=C5=99ej_Hlavat=C3=BD?= <ohlavaty@redhat.com>
Date: Mon, 28 May 2018 18:39:13 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix parsing of TC actions for
 HW offload
Message-ID: <20180528163913.16315-1-ohlavaty@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The previous code was optimistic, accepting the offload of whole action
chain when there was a single known action (drop/redirect). This results
in offloading a rule which should not be offloaded, because its behavior
cannot be reproduced in the hardware.

For example:

$ tc filter add dev eno1 parent ffff: protocol ip \
    u32 ht 800: order 1 match tcp src 42 FFFF \
    action mirred egress mirror dev enp1s16 pipe \
    drop

The controller is unable to mirror the packet to a VF, but still
offloads the rule by dropping the packet.

Change the approach of the function to a pessimistic one, rejecting the
chain when an unknown action is found. This is better suited for future
extensions.

Note that both recognized actions always return TC_ACT_SHOT, therefore
it is safe to ignore actions behind them.

Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Ond?ej Hlavat? <ohlavaty@redhat.com>

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba99f7b8..d01e1f0280cf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9054,7 +9054,6 @@ static int parse_tc_actions(struct ixgbe_adapter *adapter,
 {
 	const struct tc_action *a;
 	LIST_HEAD(actions);
-	int err;
 
 	if (!tcf_exts_has_actions(exts))
 		return -EINVAL;
@@ -9075,14 +9074,14 @@ static int parse_tc_actions(struct ixgbe_adapter *adapter,
 
 			if (!dev)
 				return -EINVAL;
-			err = handle_redirect_action(adapter, dev->ifindex, queue,
-						     action);
-			if (err == 0)
-				return err;
+			return handle_redirect_action(adapter, dev->ifindex,
+						      queue, action);
 		}
+
+		return -EINVAL;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 #else
 static int parse_tc_actions(struct ixgbe_adapter *adapter,
-- 
2.17.0

