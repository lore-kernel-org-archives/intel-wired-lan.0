Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490EC55822
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 06:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED6794058B;
	Wed,  5 Aug 2026 06:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2oMCxpqMndg; Wed,  5 Aug 2026 06:52:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 299B44067C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785912761;
	bh=83D4vNrRhDWfISZFZF47kRKrTy5ASEnVJkHD7QrrPNo=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ahsuMwQraDdA7EP3QvkMoOwAIEplEFGOuofqg1EFquYxE8EIBgWrKpO/tmYKHaen2
	 0TXoE5DsMxYyKQhiwOTrO95yZgr/AQuPEIX5dUiYt0iGC3do7wbBlrAxGElzmk2CQE
	 tynwyalsr91BVudq0GDOZcC8aJGxKa8UEd8S2LCbzP7nE6kw6V7bIts3xVIInFA2tx
	 J+6RsFODM6IxLy3xHavNdSxGyTsFdbml1w90NGF7XPnDnyhQXxV4Zs+ic7mAZVKruk
	 t9kTiAf4XSPRjvnC2saeFXxoMEyRJkn0NbjXy5JaPXMMmDmLq5hS+BmQ2zROWSUa/W
	 GXCqUwacvLJGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 299B44067C;
	Wed,  5 Aug 2026 06:52:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FF3E270
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41ED44009E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaPP1OgclJGb for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 06:52:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.174;
 helo=out-174.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4EFEA40067
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EFEA40067
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EFEA40067
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 06:52:38 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Wed,  5 Aug 2026 14:51:28 +0800
Message-ID: <20260805065132.148625-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1785912755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83D4vNrRhDWfISZFZF47kRKrTy5ASEnVJkHD7QrrPNo=;
 b=VOU35zax/oD2coHGaox+2VgJDSzgA60M/dJjh5QbA6IWYqH6ZRNV1l8ZYQiLdZcErBvMAl
 Hlu5HxymDiej87uDuiAX0Pq6OHjRphMJLLrk4KAg0gMKfkW+iGA/dBWRQPclhf9mJ8lDav
 pPPUEHDRsmmadmfVfYN1neRNxJjMRdQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=VOU35zax
Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/5] i40e: serialize Tx
 timestamp skb ownership
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The Tx timestamp interrupt, watchdog, transmit error path, and PTP stop
path can all release ptp_tx_skb. The existing in-progress bit serializes
slot reservation, but does not protect the skb pointer. One path can
therefore free the skb while another is still using it, causing a
use-after-free or double free.

Add ptp_tx_lock to protect the timestamp slot. With all accesses
serialized, use a non-NULL ptp_tx_skb as the single indication that the
slot is occupied and remove the redundant in-progress bit. Publish and
claim the skb under the lock, then complete or free it after unlocking.

Make the transmit error path claim the slot only when it still points to
the skb whose transmission failed. This prevents delayed error cleanup
from releasing a newer timestamp request after another path recycled the
slot.

Fixes: 0bc0706b46cd ("i40e: check for Tx timestamp timeouts during watchdog")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 55 ++++++++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 38 ++++++++++----
 4 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 83e780919ac97..4c8bcaa9dd192 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -101,7 +101,6 @@ enum i40e_state {
 	__I40E_GLOBAL_RESET_REQUESTED,
 	__I40E_EMP_RESET_INTR_RECEIVED,
 	__I40E_SUSPENDED,
-	__I40E_PTP_TX_IN_PROGRESS,
 	__I40E_BAD_EEPROM,
 	__I40E_DOWN_REQUESTED,
 	__I40E_FD_FLUSH_REQUESTED,
@@ -675,6 +674,8 @@ struct i40e_pf {
 	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
 	u32 latch_event_flags;
+	/* Protects ptp_tx_skb, which also indicates the slot state. */
+	spinlock_t ptp_tx_lock;
 	spinlock_t ptp_rx_lock; /* Used to protect Rx timestamp registers. */
 	unsigned long latch_events[4];
 	bool ptp_tx;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a567..0a259351c127e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12819,6 +12819,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			 "total-port-shutdown was enabled, link-down-on-close is forced on\n");
 	}
 	mutex_init(&pf->switch_mutex);
+	spin_lock_init(&pf->ptp_tx_lock);
 
 sw_init_done:
 	return err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index ff62b5f2c8150..224568a3af085 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -728,14 +728,17 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf)
  **/
 void i40e_ptp_tx_hang(struct i40e_pf *pf)
 {
+	unsigned long flags;
 	struct sk_buff *skb;
 
 	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags) || !pf->ptp_tx)
 		return;
 
+	spin_lock_irqsave(&pf->ptp_tx_lock, flags);
+
 	/* Nothing to do if we're not already waiting for a timestamp */
-	if (!test_bit(__I40E_PTP_TX_IN_PROGRESS, pf->state))
-		return;
+	if (!pf->ptp_tx_skb)
+		goto out_unlock;
 
 	/* We already have a handler routine which is run when we are notified
 	 * of a Tx timestamp in the hardware. If we don't get an interrupt
@@ -744,12 +747,16 @@ void i40e_ptp_tx_hang(struct i40e_pf *pf)
 	if (time_is_before_jiffies(pf->ptp_tx_start + HZ)) {
 		skb = pf->ptp_tx_skb;
 		pf->ptp_tx_skb = NULL;
-		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+		spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
-		/* Free the skb after we clear the bitlock */
+		/* Free the skb after releasing the lock. */
 		dev_kfree_skb_any(skb);
 		pf->tx_hwtstamp_timeouts++;
+		return;
 	}
+
+out_unlock:
+	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 }
 
 /**
@@ -763,17 +770,21 @@ void i40e_ptp_tx_hang(struct i40e_pf *pf)
 void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf)
 {
 	struct skb_shared_hwtstamps shhwtstamps;
-	struct sk_buff *skb = pf->ptp_tx_skb;
 	struct i40e_hw *hw = &pf->hw;
+	unsigned long flags;
+	struct sk_buff *skb;
 	u32 hi, lo;
 	u64 ns;
 
 	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags) || !pf->ptp_tx)
 		return;
 
-	/* don't attempt to timestamp if we don't have an skb */
-	if (!pf->ptp_tx_skb)
-		return;
+	spin_lock_irqsave(&pf->ptp_tx_lock, flags);
+
+	/* Take ownership of the skb before another cleanup path can free it. */
+	skb = pf->ptp_tx_skb;
+	if (!skb)
+		goto out_unlock;
 
 	lo = rd32(hw, I40E_PRTTSYN_TXTIME_L);
 	hi = rd32(hw, I40E_PRTTSYN_TXTIME_H);
@@ -781,17 +792,21 @@ void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf)
 	ns = (((u64)hi) << 32) | lo;
 	i40e_ptp_convert_to_hwtstamp(&shhwtstamps, ns);
 
-	/* Clear the bit lock as soon as possible after reading the register,
-	 * and prior to notifying the stack via skb_tstamp_tx(). Otherwise
-	 * applications might wake up and attempt to request another transmit
-	 * timestamp prior to the bit lock being cleared.
+	/* Mark the slot available as soon as possible after reading the
+	 * register and before notifying the stack via skb_tstamp_tx().
+	 * Otherwise, applications might wake up and request another transmit
+	 * timestamp before the slot is available.
 	 */
 	pf->ptp_tx_skb = NULL;
-	clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
 	/* Notify the stack and free the skb after we've unlocked */
 	skb_tstamp_tx(skb, &shhwtstamps);
 	dev_kfree_skb_any(skb);
+	return;
+
+out_unlock:
+	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 }
 
 /**
@@ -1539,19 +1554,21 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 {
 	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_hw *hw = &pf->hw;
+	unsigned long flags;
+	struct sk_buff *skb;
 	u32 regval;
 
+	spin_lock_irqsave(&pf->ptp_tx_lock, flags);
 	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
 	pf->ptp_tx = false;
-	pf->ptp_rx = false;
+	skb = pf->ptp_tx_skb;
+	pf->ptp_tx_skb = NULL;
+	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
-	if (pf->ptp_tx_skb) {
-		struct sk_buff *skb = pf->ptp_tx_skb;
+	pf->ptp_rx = false;
 
-		pf->ptp_tx_skb = NULL;
-		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+	if (skb)
 		dev_kfree_skb_any(skb);
-	}
 
 	if (pf->ptp_clock) {
 		ptp_clock_unregister(pf->ptp_clock);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 894f2d06d39d0..f430546acf422 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3198,7 +3198,9 @@ static int i40e_tso(struct i40e_tx_buffer *first, u8 *hdr_len,
 static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		     u32 tx_flags, u64 *cd_type_cmd_tso_mss)
 {
+	unsigned long flags;
 	struct i40e_pf *pf;
+	int tsyn = 0;
 
 	if (likely(!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
 		return 0;
@@ -3211,23 +3213,28 @@ static int i40e_tsyn(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	 * we are not already transmitting a packet to be timestamped
 	 */
 	pf = i40e_netdev_to_pf(tx_ring->netdev);
+	spin_lock_irqsave(&pf->ptp_tx_lock, flags);
+
 	if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
-		return 0;
+		goto out_unlock;
 
-	if (pf->ptp_tx &&
-	    !test_and_set_bit_lock(__I40E_PTP_TX_IN_PROGRESS, pf->state)) {
+	if (pf->ptp_tx && !pf->ptp_tx_skb) {
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		pf->ptp_tx_start = jiffies;
 		pf->ptp_tx_skb = skb_get(skb);
+		tsyn = 1;
 	} else {
 		pf->tx_hwtstamp_skipped++;
-		return 0;
 	}
 
-	*cd_type_cmd_tso_mss |= (u64)I40E_TX_CTX_DESC_TSYN <<
-				I40E_TXD_CTX_QW1_CMD_SHIFT;
+out_unlock:
+	spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
-	return 1;
+	if (tsyn)
+		*cd_type_cmd_tso_mss |= (u64)I40E_TX_CTX_DESC_TSYN <<
+					I40E_TXD_CTX_QW1_CMD_SHIFT;
+
+	return tsyn;
 }
 
 /**
@@ -3957,10 +3964,21 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 cleanup_tx_tstamp:
 	if (unlikely(tx_flags & I40E_TX_FLAGS_TSYN)) {
 		struct i40e_pf *pf = i40e_netdev_to_pf(tx_ring->netdev);
+		struct sk_buff *ptp_skb = NULL;
+		unsigned long flags;
+
+		spin_lock_irqsave(&pf->ptp_tx_lock, flags);
+		/* Another cleanup path may have handed the slot
+		 * to a new skb.
+		 */
+		if (pf->ptp_tx_skb == skb) {
+			ptp_skb = pf->ptp_tx_skb;
+			pf->ptp_tx_skb = NULL;
+		}
+		spin_unlock_irqrestore(&pf->ptp_tx_lock, flags);
 
-		dev_kfree_skb_any(pf->ptp_tx_skb);
-		pf->ptp_tx_skb = NULL;
-		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+		if (ptp_skb)
+			dev_kfree_skb_any(ptp_skb);
 	}
 
 	return NETDEV_TX_OK;
-- 
2.43.0

