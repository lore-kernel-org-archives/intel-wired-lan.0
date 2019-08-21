From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed, 21 Aug 2019 16:09:29 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: check __I40E_VF_DISABLE bit in
 i40e_sync_filters_subtask
Message-ID: <20190821140929.26985-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While testing VF spawn/destroy the following panic occured.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000029
[...]
Workqueue: i40e i40e_service_task [i40e]
RIP: 0010:i40e_sync_vsi_filters+0x6fd/0xc60 [i40e]
[...]
Call Trace:
 ? __switch_to_asm+0x35/0x70
 ? __switch_to_asm+0x41/0x70
 ? __switch_to_asm+0x35/0x70
 ? _cond_resched+0x15/0x30
 i40e_sync_filters_subtask+0x56/0x70 [i40e]
 i40e_service_task+0x382/0x11b0 [i40e]
 ? __switch_to_asm+0x41/0x70
 ? __switch_to_asm+0x41/0x70
 process_one_work+0x1a7/0x3b0
 worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 kthread+0x112/0x130
 ? kthread_bind+0x30/0x30
 ret_from_fork+0x35/0x40

Investigation revealed a race where pf->vf[vsi->vf_id].trusted may get
accessed by the watchdog via i40e_sync_filters_subtask() although
i40e_free_vfs() already free'd pf->vf.
To avoid this the call to i40e_sync_vsi_filters() in
i40e_sync_filters_subtask() needs to be guarded by __I40E_VF_DISABLE,
which is also used by i40e_free_vfs().

Note: put the __I40E_VF_DISABLE check after the
__I40E_MACVLAN_SYNC_PENDING check as the latter is more likely to
trigger.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6d456e579314..f25c7da59b2b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2587,6 +2587,10 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 		return;
 	if (!test_and_clear_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state))
 		return;
+	if (test_and_set_bit(__I40E_VF_DISABLE, pf->state)) {
+		set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
+		return;
+	}
 
 	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v] &&
@@ -2601,6 +2605,7 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 			}
 		}
 	}
+	clear_bit(__I40E_VF_DISABLE, pf->state);
 }
 
 /**
-- 
2.21.0

