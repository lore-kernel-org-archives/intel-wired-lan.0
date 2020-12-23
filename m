From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 23 Dec 2020 12:36:58 -0800
Subject: [Intel-wired-lan] [PATCH v2 2/9] igc: Refactor igc_xdp_run_prog()
In-Reply-To: <20201223203705.78705-1-andre.guedes@intel.com>
References: <20201223203705.78705-1-andre.guedes@intel.com>
Message-ID: <20201223203705.78705-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Refactor igc_xdp_run_prog() helper, preparing the code for AF_XDP
zero-copy support which is added by upcoming patches.

With AF_XDP zero-copy support, igc_poll() will have a dedicated path
when rx ring's memory model is MEM_TYPE_XSK_BUFF_POOL. To avoid code
duplication as much as possible, encapsulate the code specific to
handling XDP program actions into a local helper so it can be reused by
the zero-copy path.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 56 +++++++++++------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 0e582a4ee986..56b791b356dc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2029,38 +2029,22 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
 	return res;
 }
 
-static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
-					struct xdp_buff *xdp)
+/* This function assumes rcu_read_lock() is held by the caller. */
+static int igc_xdp_do_run_prog(struct igc_adapter *adapter,
+			       struct bpf_prog *prog,
+			       struct xdp_buff *xdp)
 {
-	struct bpf_prog *prog;
-	int res;
-	u32 act;
-
-	rcu_read_lock();
-
-	prog = READ_ONCE(adapter->xdp_prog);
-	if (!prog) {
-		res = IGC_XDP_PASS;
-		goto unlock;
-	}
+	u32 act = bpf_prog_run_xdp(prog, xdp);
 
-	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
-		res = IGC_XDP_PASS;
-		break;
+		return IGC_XDP_PASS;
 	case XDP_TX:
-		if (igc_xdp_xmit_back(adapter, xdp) < 0)
-			res = IGC_XDP_CONSUMED;
-		else
-			res = IGC_XDP_TX;
-		break;
+		return igc_xdp_xmit_back(adapter, xdp) < 0 ?
+			IGC_XDP_CONSUMED : IGC_XDP_TX;
 	case XDP_REDIRECT:
-		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
-			res = IGC_XDP_CONSUMED;
-		else
-			res = IGC_XDP_REDIRECT;
-		break;
+		return xdp_do_redirect(adapter->netdev, xdp, prog) < 0 ?
+			IGC_XDP_CONSUMED : IGC_XDP_REDIRECT;
 	default:
 		bpf_warn_invalid_xdp_action(act);
 		fallthrough;
@@ -2068,9 +2052,25 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 		trace_xdp_exception(adapter->netdev, prog, act);
 		fallthrough;
 	case XDP_DROP:
-		res = IGC_XDP_CONSUMED;
-		break;
+		return IGC_XDP_CONSUMED;
 	}
+}
+
+static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
+					struct xdp_buff *xdp)
+{
+	struct bpf_prog *prog;
+	int res;
+
+	rcu_read_lock();
+
+	prog = READ_ONCE(adapter->xdp_prog);
+	if (!prog) {
+		res = IGC_XDP_PASS;
+		goto unlock;
+	}
+
+	res = igc_xdp_do_run_prog(adapter, prog, xdp);
 
 unlock:
 	rcu_read_unlock();
-- 
2.29.2

