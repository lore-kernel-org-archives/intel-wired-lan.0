From: Ruud Bos <kernel.hbk@gmail.com>
Date: Wed, 13 Oct 2021 09:15:31 +0200
Subject: [Intel-wired-lan] [PATCH net-next RESEND 4/4] igb: support EXTTS on
 82580/i354/i350
In-Reply-To: <20211013071531.1145-1-kernel.hbk@gmail.com>
References: <20211013071531.1145-1-kernel.hbk@gmail.com>
Message-ID: <20211013071531.1145-5-kernel.hbk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Support for the EXTTS PTP pin function on 82580/i354/i350 based adapters.
Because the time registers of these adapters do not have the nice split in
second rollovers as the i210 has, the implementation is slightly more
complex compared to the i210 implementation.

Signed-off-by: Ruud Bos <kernel.hbk@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 20 ++++++++++---
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 36 ++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5f59c5de7033..30f16cacd972 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6807,17 +6807,29 @@ static void igb_perout(struct igb_adapter *adapter, int sdp)
 static void igb_extts(struct igb_adapter *adapter, int sdp)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 sec, nsec;
+	int auxstmpl = (sdp == 1) ? E1000_AUXSTMPL1 : E1000_AUXSTMPL0;
+	int auxstmph = (sdp == 1) ? E1000_AUXSTMPH1 : E1000_AUXSTMPH0;
+	struct timespec64 ts;
 	struct ptp_clock_event event;
 
 	if (sdp < 0 || sdp >= IGB_N_EXTTS)
 		return;
 
-	nsec = rd32((sdp == 1) ? E1000_AUXSTMPL1 : E1000_AUXSTMPL0);
-	sec  = rd32((sdp == 1) ? E1000_AUXSTMPH1 : E1000_AUXSTMPH0);
+	if ((hw->mac.type == e1000_82580) ||
+	    (hw->mac.type == e1000_i354) ||
+	    (hw->mac.type == e1000_i350)) {
+		s64 ns = rd32(auxstmpl);
+
+		ns += ((s64)(rd32(auxstmph) & 0xFF)) << 32;
+		ts = ns_to_timespec64(ns);
+	} else {
+		ts.tv_nsec = rd32(auxstmpl);
+		ts.tv_sec  = rd32(auxstmph);
+	}
+
 	event.type = PTP_CLOCK_EXTTS;
 	event.index = sdp;
-	event.timestamp = sec * 1000000000ULL + nsec;
+	event.timestamp = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
 	ptp_clock_event(adapter->ptp_clock, &event);
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 64a949bb5d8a..bc24295b6b52 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -524,7 +524,41 @@ static int igb_ptp_feature_enable_82580(struct ptp_clock_info *ptp,
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
-		return -EOPNOTSUPP;
+		/* Reject requests with unsupported flags */
+		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
+					PTP_RISING_EDGE |
+					PTP_FALLING_EDGE |
+					PTP_STRICT_FLAGS))
+			return -EOPNOTSUPP;
+
+		if (on) {
+			pin = ptp_find_pin(igb->ptp_clock, PTP_PF_EXTTS,
+					   rq->extts.index);
+			if (pin < 0)
+				return -EBUSY;
+		}
+		if (rq->extts.index == 1) {
+			tsauxc_mask = TSAUXC_EN_TS1;
+			tsim_mask = TSINTR_AUTT1;
+		} else {
+			tsauxc_mask = TSAUXC_EN_TS0;
+			tsim_mask = TSINTR_AUTT0;
+		}
+		spin_lock_irqsave(&igb->tmreg_lock, flags);
+		tsauxc = rd32(E1000_TSAUXC);
+		tsim = rd32(E1000_TSIM);
+		if (on) {
+			igb_pin_extts(igb, rq->extts.index, pin);
+			tsauxc |= tsauxc_mask;
+			tsim |= tsim_mask;
+		} else {
+			tsauxc &= ~tsauxc_mask;
+			tsim &= ~tsim_mask;
+		}
+		wr32(E1000_TSAUXC, tsauxc);
+		wr32(E1000_TSIM, tsim);
+		spin_unlock_irqrestore(&igb->tmreg_lock, flags);
+		return 0;
 
 	case PTP_CLK_REQ_PEROUT:
 		/* Reject requests with unsupported flags */
-- 
2.30.2

