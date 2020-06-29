From: Francesco Ruggeri <fruggeri@arista.com>
Date: Mon, 29 Jun 2020 14:18:01 -0700
Subject: [Intel-wired-lan] [PATCH] igb: reinit_locked() should be called
 with rtnl_lock
Message-ID: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We observed a panic in igb_reset_task caused by this race condition
when doing a reboot -f:

	kworker			reboot -f

	igb_reset_task
	igb_reinit_locked
	igb_down
	napi_synchronize
				__igb_shutdown
				igb_clear_interrupt_scheme
				igb_free_q_vectors
				igb_free_q_vector
				adapter->q_vector[v_idx] = NULL;
	napi_disable
	Panics trying to access
	adapter->q_vector[v_idx].napi_state

This commit applies to igb the same changes that were applied to ixgbe
in commit 8f4c5c9fb87a ("ixgbe: reinit_locked() should be called with
rtnl_lock") and commit 88adce4ea8f9 ("ixgbe: fix possible race in
reset subtask").

Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8bb3db2cbd41..b79a78e102f3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6224,9 +6224,11 @@ static void igb_reset_task(struct work_struct *work)
 	struct igb_adapter *adapter;
 	adapter = container_of(work, struct igb_adapter, reset_task);
 
+	rtnl_lock();
 	igb_dump(adapter);
 	netdev_err(adapter->netdev, "Reset adapter\n");
 	igb_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**

