From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:25 +0200
Subject: [Intel-wired-lan] [patch V2 16/36] net: sfc: Use GFP_KERNEL in
 efx_ef10_try_update_nic_stats()
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203501.078203643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

efx_ef10_try_update_nic_stats_vf() is now only invoked from thread context
and can sleep after efx::stats_lock is dropped.

Change the allocation mode from GFP_ATOMIC to GFP_KERNEL.
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adjust to Edward's stats update split
---
 drivers/net/ethernet/sfc/ef10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1873,7 +1873,7 @@ static int efx_ef10_try_update_nic_stats
 
 	efx_ef10_get_stat_mask(efx, mask);
 
-	rc = efx_nic_alloc_buffer(efx, &stats_buf, dma_len, GFP_ATOMIC);
+	rc = efx_nic_alloc_buffer(efx, &stats_buf, dma_len, GFP_KERNEL);
 	if (rc) {
 		spin_lock_bh(&efx->stats_lock);
 		return rc;

