Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C7C5DF98
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Aug 2026 00:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D48C5409AC;
	Sat, 22 Aug 2026 00:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqrGwxqezKKB; Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787357707;
	bh=FBhznV1qxXD+Qyb52YXLLy53pR65HHVnzIqqTxpLFjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rg/dDgf8dXRzI6x/wQNCA6+daqfcr2WJ2SlWJKeHVJ5A29Ug2hh60EfuRY3HUdzPn
	 99eqMze1nZKc8VQ95D17MTwy/MM91vvw2/FovvxSE0EWSAKT1Hn1ywbdn+8srtZMif
	 iU5bX4VLPE4zOM+XgjjSe1LD79gHk1UJJgEhHlcff6odNE94UtUk44Xgo+zM5vrOq5
	 dzykxQeBZ9Et8Uf3jfcHjbeK6WqJMfm0l3ZTh4EoEJEvLQV+sn+OQKA/QVlvnIATjY
	 jVDGiWglUrFGlh3wNuKP0sR5dTf7BhqXzh+/KnBNG00gwMxSfd7boyFFtCWhKnQC4W
	 kMGai8VB28b8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C00B540C50;
	Sat, 22 Aug 2026 00:15:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77B8993F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DFD340A05
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z65Bia6Kb2KI for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R9kRxjIi
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F9BD400E6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Aug 2026 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787357701; x=1818893701;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=SbJzNv6jb6I/3B7TbOaZSFdPzoRQQKa1ppGoU9SXOeY=;
 b=R9kRxjIi+98JpfOy9T9aPummaYioMzd+K3zR9zsrnaR500QUTFGeBDIT
 D1IR5MqJIGF13jq7I4WfAhZ2BZ8KuYfz93nGfS8NgxGuraZZ6BZlXdNqm
 QaASCjOLkbgcUHXkQT/VaL6Bj0HGIru5oSRnilvocrm17yScJXkj+XI8D
 4f8fFwBps5nFkA/uzRoPw+CHNRw5UoBMoDzZjoaZaJ8hOLlGRelsnX1Sv
 yrl1I/S82kiPUu2cQP5NbjXJciaDI4C2oGs7GCYvD8RubzLgzjeY7S68G
 pYxPWgvjisXyPJydDuvpC8DdGtF8kagbhBtIwsTXYBZ1e9Ob7TxmK71b5 w==;
X-CSE-ConnectionGUID: CpW9slgHRCmtn2eolRCV9A==
X-CSE-MsgGUID: GltfHa6OQaWqLs5V6Bx8QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91584794"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="91584794"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:01 -0700
X-CSE-ConnectionGUID: i4KPalD7QqGmdC7xACn/HQ==
X-CSE-MsgGUID: QN2UsoOATV2WceSn/VdVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; d="scan'208";a="263836501"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 17:15:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Aug 2026 17:13:17 -0700
Subject: [PATCH iwl-net 12/12] ice: don't clear in_use until HW clears
 ready bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-75809
X-Developer-Signature: v=1; a=openpgp-sha256; l=6958;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=SbJzNv6jb6I/3B7TbOaZSFdPzoRQQKa1ppGoU9SXOeY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyOl38KrYISlmzsOXFATpOPp2nRPc8/Obc1ps/YkOsfe
 PUl+xfvjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACZyNZOR4cab9ob2z583Pnd8
 +j9YduIzO+3M2yrXd6X7/ZAK/yas28TIMD/ZI/vu2SaWEuu/CkpJYVeNFLd8tA8quP7ZanKEugI
 rHwA=
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

During a link down transition, the E825 PHY has a small window where it
does not properly respond to reading the PHY timestamp registers. When this
occurs, the PHY does not automatically clear the ready bitmap or the valid
bit for the timestamp. This begins happening slightly before a link
transition even before the firmware has notified the driver of the state
change.

The driver happily completes the timestamp, releasing the in_use bit. This
allows another request to reuse the bit potentially reporting an invalid
stale timestamp. Additionally, with the ready bit still set high the driver
continues to re-trigger the IRQ and check for timestamps in a tight loop,
wasting CPU cycles.

To fix this, re-read the PHY timestamp memory status after each read of a
PHY index. Double check if the hardware cleared the index properly. If it
hasn't, mark the timestamp index as stale and skip processing it.

Stale timestamps are already ignored by the ice_any_port_has_timestamps()
function. However, the ice_ptp_tx_tstamps_pending() function also checks
the ready bitmap. Instead, modify it to only check the software tracker.
Additionally, stop re-triggering the interrupt from the IRQ if the
timestamp tracker is calibrating or has the link marked as down. Continue
to check the hardware ready bitmap from the watchdog to catch cases of
unexpected timestamps.

With these changes, the timestamp processing no longer triggers a repeated
spamming of the IRQ during link down events where timestamps get stuck as
the PHY transitions to link down. Once link is restored, the PHY will be
reset and the stuck timestamps are cleared.

Measuring CPU utilization of the miscellaneous IRQ thread function during
timestamp storms near a link reset shows that this prevents the spikes
caused by the "stuck" ready bit. Without this fix, the CPU handling the IRQ
becomes slammed due to the IRQ re-triggering logic.

Measuring latency using the ice Tx timestamp traces does show that this fix
comes at a latency cost. Latency is measured using the ice Tx timestamp
traces for the request to completion time. I measured a couple of different
workloads both before and after this fix:

 * ptp4l using a profile with ~16 SYNC messages per second

    before: 159.40 microseconds mean, stdev 45.28
     after: 182.07 microseconds mean,  stdev 43.43

 * a C program generating 16 timestamp requests every 10 milliseconds on
   two different ports:

    before: 604.35 microseconds mean, stdev 345.32
     after: 990.13 microseconds mean, stdev 625.64

In the normal work flows this comes with about a 20 microsecond penalty on
the average, and the standard deviation remains approximately the same. For
heavy workloads with many more timestamps than expected for typical
applications this comes at a significant cost. This is because we handle
all timestamps in a single thread. If there are many concurrent timestamps
being requested at once, any which use the later slots on ports later in
the port list will take much longer to be processed once the interrupt is
fired. Since each timestamp now requires an additional PHY register access,
this cost is much higher in the case where the device is under unusually
heavy load.

However, *correctness* is more important than speed here. Additionally, we
still remain well below the default limit of 10 milliseconds that ptp4l
will wait before complaining about missing timestamps.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 54 +++++++++++++++-----------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b337247c94e0..0e44ed6b0ae8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -620,6 +620,22 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		if (err && !drop_ts)
 			continue;
 
+		/* verify ready bit cleared */
+		if (tx->has_ready_bitmap) {
+			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
+			if (err)
+				continue;
+
+			if (tstamp_ready & BIT_ULL(phy_idx)) {
+				spin_lock_irqsave(&tx->lock, flags);
+				if (!test_and_set_bit(idx, tx->stale))
+					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
+						ptp_port->port_num, phy_idx);
+				spin_unlock_irqrestore(&tx->lock, flags);
+				continue;
+			}
+		}
+
 		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
 		/* For PHYs which don't implement a proper timestamp ready
@@ -2764,10 +2780,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 		if (!tx->init)
 			return false;
 
-		if (in_irq)
+		if (in_irq) {
+			if (!ice_ptp_is_tx_tracker_up(tx))
+				return false;
+
 			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
-		else
+		} else {
 			return !bitmap_empty(tx->in_use, tx->len);
+		}
 	}
 }
 
@@ -2790,41 +2810,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
-	struct ice_hw *hw = &pf->hw;
-	int ret;
-
-	/* Check software indicator */
 	switch (pf->ptp.tx_interrupt_mode) {
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
-			return true;
-		break;
+		return ice_port_has_timestamps(&pf->ptp.port.tx, in_irq);
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf, in_irq))
-			return true;
-		break;
+		return ice_any_port_has_timestamps(pf, in_irq);
 	default:
 		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
 			  pf->ptp.tx_interrupt_mode);
-		break;
-	}
-
-	/* Check hardware indicator */
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
-			ret);
-		/* Stop triggering IRQs if we're unable to read PHY */
 		return false;
 	}
-
-	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
-	 * available, 0 if there are no waiting timestamps, and a negative
-	 * value if there was an error (which we checked for above).
-	 */
-	return ret > 0;
 }
 
 /**
@@ -2915,7 +2912,8 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	if (!ice_pf_src_tmr_owned(pf))
 		return;
 
-	if (ice_ptp_tx_tstamps_pending(pf, false)) {
+	if (ice_ptp_tx_tstamps_pending(pf, false) ||
+	    ice_check_phy_tx_tstamp_ready(hw)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
2.55.0.814.gc42f45431d0f

