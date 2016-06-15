From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 15 Jun 2016 15:37:59 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: napi_poll must return the work
	done
Message-ID: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently the function ixgbe_poll() returns 0 when it clean completely
the rx rings, but this foul budget accounting in core code.
Fix this returning the actual work done, capped to weight - 1, since
the core doesn't allow to return the full budget when the driver modifies
the napi status

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 088c47c..8bebd86 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2887,7 +2887,7 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
 	if (!test_bit(__IXGBE_DOWN, &adapter->state))
 		ixgbe_irq_enable_queues(adapter, BIT_ULL(q_vector->v_idx));
 
-	return 0;
+	return min(work_done, budget - 1);
 }
 
 /**
-- 
1.8.3.1

