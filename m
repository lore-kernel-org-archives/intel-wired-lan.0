From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:52 +0200
Subject: [Intel-wired-lan] [patch 06/35] net: cxgb3: Cleanup in_interrupt()
 usage
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194920.437625772@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>

t3_sge_stop() is called from task context and from error handlers in
interrupt context. It relies on in_interrupt() to differentiate the
contexts.

in_interrupt() is deprecated as it is ill defined and does not provide what
it suggests.

Instead of replacing it with some other construct, simply split the
function into t3_sge_stop_dma(), which can be called from any context, and
t3_sge_stop() which can be only called from task context.

This has the advantage that any bogus invocation of t3_sge_stop() from
wrong contexts can be caught by debug kernels instead of being papered over
by the conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vishal Kulkarni <vishal@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org

---
 drivers/net/ethernet/chelsio/cxgb3/adapter.h    |    1 
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |    2 -
 drivers/net/ethernet/chelsio/cxgb3/sge.c        |   44 ++++++++++++++----------
 3 files changed, 29 insertions(+), 18 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb3/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
@@ -313,6 +313,7 @@ void t3_os_link_fault(struct adapter *ad
 void t3_os_link_fault_handler(struct adapter *adapter, int port_id);
 
 void t3_sge_start(struct adapter *adap);
+void t3_sge_stop_dma(struct adapter *adap);
 void t3_sge_stop(struct adapter *adap);
 void t3_start_sge_timers(struct adapter *adap);
 void t3_stop_sge_timers(struct adapter *adap);
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2996,7 +2996,7 @@ void t3_fatal_err(struct adapter *adapte
 	unsigned int fw_status[4];
 
 	if (adapter->flags & FULL_INIT_DONE) {
-		t3_sge_stop(adapter);
+		t3_sge_stop_dma(adapter);
 		t3_write_reg(adapter, A_XGM_TX_CTRL, 0);
 		t3_write_reg(adapter, A_XGM_RX_CTRL, 0);
 		t3_write_reg(adapter, XGM_REG(A_XGM_TX_CTRL, 1), 0);
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -3271,30 +3271,40 @@ void t3_sge_start(struct adapter *adap)
 }
 
 /**
- *	t3_sge_stop - disable SGE operation
+ *	t3_sge_stop_dma - Disable SGE DMA engine operation
  *	@adap: the adapter
  *
- *	Disables the DMA engine.  This can be called in emeregencies (e.g.,
- *	from error interrupts) or from normal process context.  In the latter
- *	case it also disables any pending queue restart tasklets.  Note that
- *	if it is called in interrupt context it cannot disable the restart
- *	tasklets as it cannot wait, however the tasklets will have no effect
- *	since the doorbells are disabled and the driver will call this again
- *	later from process context, at which time the tasklets will be stopped
- *	if they are still running.
+ *	Can be invoked from interrupt context e.g.  error handler.
+ *
+ *	Note that this function cannot disable the restart of tasklets as
+ *	it cannot wait if called from interrupt context, however the
+ *	tasklets will have no effect since the doorbells are disabled. The
+ *	driver will call tg3_sge_stop() later from process context, at
+ *	which time the tasklets will be stopped if they are still running.
  */
-void t3_sge_stop(struct adapter *adap)
+void t3_sge_stop_dma(struct adapter *adap)
 {
 	t3_set_reg_field(adap, A_SG_CONTROL, F_GLOBALENABLE, 0);
-	if (!in_interrupt()) {
-		int i;
+}
+
+/**
+ *	t3_sge_stop - disable SGE operation completly
+ *	@adap: the adapter
+ *
+ *	Called from process context. Disables the DMA engine and any
+ *	pending queue restart tasklets.
+ */
+void t3_sge_stop(struct adapter *adap)
+{
+	int i;
+
+	t3_sge_stop_dma(adap);
 
-		for (i = 0; i < SGE_QSETS; ++i) {
-			struct sge_qset *qs = &adap->sge.qs[i];
+	for (i = 0; i < SGE_QSETS; ++i) {
+		struct sge_qset *qs = &adap->sge.qs[i];
 
-			tasklet_kill(&qs->txq[TXQ_OFLD].qresume_tsk);
-			tasklet_kill(&qs->txq[TXQ_CTRL].qresume_tsk);
-		}
+		tasklet_kill(&qs->txq[TXQ_OFLD].qresume_tsk);
+		tasklet_kill(&qs->txq[TXQ_CTRL].qresume_tsk);
 	}
 }
 

