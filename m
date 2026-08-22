Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE00C61CE2
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAE8A60AB1;
	Sat, 22 Aug 2026 00:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02DACK8KRoT3; Sat, 22 Aug 2026 00:15:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357708;
	bh=3XroO0qh9MEF9tXiHiKQKYK/hkJPwHjuPaNZS0aRIxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMAnO1Av50WxKp+icwxEcwidJGzUbN8VksqkFN/vX6WVbnO6IbHnek7dFFk1yUPrS
	 jLsIWQ8/yHMuLY7VGMaFG0Fmw3S67QMR6dwWe/jecROp7N9Z3iUeDh1/4uqkkC9VBb
	 rMNsMhh7kSNYVCLZL9Xb29gvDsrhkYQiOo1SPQ6jsGZAX4iIohGSgCFGb+2KKAUBnz
	 ogNe+ogkSm5CGX70SkhDFBh41FWKunDtd6MAZNwUMd/mK/8B9BTIglc62z+GhlM5dW
	 BwUy5TqPnsnZdajkPuy/mnaez0PCyRQeE3kbdEkKu4ytJKHy4DqHASJPVtf7twIDEk
	 HZfLlgmT3IO/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C458460ADF;
	Sat, 22 Aug 2026 00:15:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AA994C4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CFCE400E6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVYrStb8cmVU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LaNKgbaS
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6774340085
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357700; x=1818893700;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=DlI4h109h3D91YFxE5+cjvW4XJq/DU2TFXVWvUY6tBA=;
 b=LaNKgbaSBWYHcoPdDQghd60jwh8Qr55uYz4iHxClTmKWYBorA05yVocs
 JeFMzEeJiUCsv8MZk5MS1QRPBK7nF1VTbsbIKeNgyJ4EjssVXhposYkJF
 cBU4vmzuPGJqbAc7WE6VZafFkaGSHwp4ekvSAHM1xuEJmogbxR/jcyOqy
 0j8+UgA7qzPkc0BFOxqlTehbblXYkHLuSRFM+TN8N29SW/zJwBkvk7Mca
 IJk6pZatQjJGoBVzd+tKHJqqo3R95KSu9i7IfefxYNZ4k8oa5gLQeTvI5
 J9CgZ32f4ok2dDrozhHAnreNRyU9OEc1LFeul7GGIV9vyW89MWjUlXvDV Q==;
X-CSE-ConnectionGUID: RGyjix08R9eOZfapcYhW8g==
X-CSE-MsgGUID: Tocxgy63TL+eTjsu9Vv72w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584783"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:00 -0700
X-CSE-ConnectionGUID: BXV8eitrRaKEd8SbpvYJqg==
X-CSE-MsgGUID: PR6gCymGTcy/HvhxuF9jsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836487"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:14 -0700
Subject: [PATCH iwl-net 09/12] ice: keep Tx timestamp slots tracked until
 completion or timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-9-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=8547;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=qxrYNilmwPgSt3TBKAu8SKkynbSPGn+tyZnwDbi3iRg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl78najQEa72c7pPCsadS4MhkE23h+JwY+QcHLxTl6
 gRnbovtKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCI7uhn+KRlrf714QKT6tBrD
 1YMrAo/81Iox/jpHOa/iF++PNSe6yhj+6Uc5eK9P6Hl/zfiLvUfC0yf7lvHmeNTxy3EZLHE0CnN
 kBQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

From: Petr Oros <poros@redhat.com>

When the link goes down the processing loop drops every outstanding
request, and a request whose timestamp is not ready yet is freed
without reading the PHY slot. The hardware completes the capture a
moment later, the orphaned ready bit blocks the port interrupt until
the next link-up sweep, and the freed index can meanwhile be reused
by a new request whose slot the hardware then overwrites. Captured on
a reproducer as ready bits with no in_use owner right after a link
bounce.

Stop dropping on link down. Mark the outstanding requests stale so
their completions are read and discarded, reject new requests while
the link is down, and free a not yet ready slot only after the two
second timeout. This way an index is never reused while the hardware
can still write it and never left untracked while a completion can
still arrive.

To avoid an IRQ storm in the event that we really do have a stale packet
that is not timestamped, modify ice_ptp_tx_tstamps_pending() to ignore
stale timestamps when checking for whether to re-arm the IRQ from the
miscellaneous thread function. Instead, only check for stale packets in the
auxiliary work thread. This way we do not check in a tight loop waiting for
a timestamp that may never come.

This effectively reverts commit fcc2cef37fed ("ice/ptp: fix the PTP worker
retrying indefinitely if the link went down"), which tried to release an
index before this 2 second wait period.

Fixes: fcc2cef37fed ("ice/ptp: fix the PTP worker retrying indefinitely if the link went down")
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  8 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 44 +++++++++++++++----------------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index da2003ba3bb0..13158a9319fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -132,6 +132,9 @@ struct ice_ptp_tx {
 #define INDEX_PER_PORT_E82X		16
 #define INDEX_PER_PORT			64
 
+/* Maximum number of timestamp indexes across all devices */
+#define INDEX_PER_PORT_MAX              INDEX_PER_PORT
+
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
  *
@@ -316,7 +319,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf);
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts);
 
@@ -364,7 +367,8 @@ static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	return IRQ_HANDLED;
 }
 
-static inline bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+static inline bool
+ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bb631ae9e67d..c84d63b8d261 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3248,7 +3248,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	ice_flush(hw);
 
-	if (ice_ptp_tx_tstamps_pending(pf)) {
+	if (ice_ptp_tx_tstamps_pending(pf, true)) {
 		/* If any new Tx timestamps happened while in interrupt,
 		 * re-arm the interrupt to trigger it again.
 		 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a049dc7a2241..1a9bf8839404 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -364,9 +364,12 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 static bool
 ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
 {
+	struct ice_ptp_port *ptp_port =
+		container_of(tx, struct ice_ptp_port, tx);
+
 	lockdep_assert_held(&tx->lock);
 
-	return tx->init && !tx->calibrating;
+	return tx->init && !tx->calibrating && ptp_port->link_up;
 }
 
 /**
@@ -563,7 +566,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
-	bool link_up;
 	int err;
 	u8 idx;
 
@@ -581,14 +583,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			return;
 	}
 
-	/* Drop packets if the link went down */
-	link_up = ptp_port->link_up;
-
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = !link_up;
+		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Drop packets which have waited for more than 2 seconds */
@@ -1372,6 +1371,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	if (pf->hw.reset_ongoing)
 		return;
 
+	if (!linkup)
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
 		int pin, err;
@@ -2763,28 +2765,29 @@ void ice_ptp_process_ts(struct ice_pf *pf)
 	}
 }
 
-static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
+static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 {
-	bool more_timestamps;
+	DECLARE_BITMAP(tstamps, INDEX_PER_PORT_MAX) = {};
 
 	scoped_guard(spinlock_irqsave, &tx->lock) {
 		if (!tx->init)
 			return false;
 
-		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
+		if (in_irq)
+			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
+		else
+			return !bitmap_empty(tx->in_use, tx->len);
 	}
-
-	return more_timestamps;
 }
 
-static bool ice_any_port_has_timestamps(struct ice_pf *pf)
+static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 {
 	bool have_tstamps = false;
 	struct ice_ptp_port *port;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
-		if (ice_port_has_timestamps(&port->tx)) {
+		if (ice_port_has_timestamps(&port->tx, in_irq)) {
 			have_tstamps = true;
 			break;
 		}
@@ -2794,7 +2797,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 	return have_tstamps;
 }
 
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_hw *hw = &pf->hw;
 	int ret;
@@ -2804,11 +2807,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx))
+		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
 			return true;
 		break;
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf))
+		if (ice_any_port_has_timestamps(pf, in_irq))
 			return true;
 		break;
 	default:
@@ -2884,7 +2887,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		/* E830 can read timestamps in the top half using rd32() */
 		ice_ptp_process_ts(pf);
 
-		if (ice_ptp_tx_tstamps_pending(pf)) {
+		if (ice_ptp_tx_tstamps_pending(pf, true)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -2914,7 +2917,6 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	int ret;
 
 	if (!pf->ptp.port.tx.has_ready_bitmap)
 		return;
@@ -2922,11 +2924,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	if (!ice_pf_src_tmr_owned(pf))
 		return;
 
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
-			ret);
-	} else if (ret) {
+	if (ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
2.55.0.814.gc42f45431d0f

