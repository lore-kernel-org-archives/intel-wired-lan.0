Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA145C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Nov 2022 22:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97F1881EEA;
	Thu,  3 Nov 2022 22:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97F1881EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667512968;
	bh=3Ug9p9JrPC+Eur+Bb2k3+2X0MwB4e6wDdH2f9yKDjBc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qnfPUwGZ+2FFX9v7pKUmPgYLdyYAjlEdK77uKdIH/xKrS9vVgukS38W10zm6lUFa1
	 SAlBcNyJSXVTsWqPo00JJWA0EzvfBVBPuD2V2bjyjRL36s3l6S7yxwckVvK/DP56CL
	 4Zz6qU/uHwLW4iCGXAo9NnpsoIC1WDd68Vtb5wSu6tyRvOehbY1f5Cjx4Jjo/hFgfu
	 AOFswEr8Eamo+QnIgp7ItT1oUc0QHW7ld2lJ0fZuj3lrAiVodAl7hHW7WzcJT0664A
	 K2GKCWr1oFfXp4Cp/KtseG76/920gFZ7hFXVSvgXCJzD5o/Fmwk4kNHeisYQwk2kNl
	 a35Z+XZJer54w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id piB5R_IQJcGN; Thu,  3 Nov 2022 22:02:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73FEC81F59;
	Thu,  3 Nov 2022 22:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73FEC81F59
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 54D961BF2F2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Nov 2022 22:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6388981F77
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Nov 2022 22:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6388981F77
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0XDKi_9fy30E for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Nov 2022 22:02:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B35C81F87
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B35C81F87
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Nov 2022 22:02:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307436993"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; d="scan'208";a="307436993"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2022 15:01:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="777480299"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; d="scan'208";a="777480299"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.7])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2022 15:01:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Thu,  3 Nov 2022 15:01:43 -0700
Message-Id: <20221103220145.1851114-14-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.38.0.83.gd420dda05763
In-Reply-To: <20221103220145.1851114-1-jacob.e.keller@intel.com>
References: <20221103220145.1851114-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667512920; x=1699048920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/qG+xlitAR9bKgl0lO+uCeTn/Fo3ulxCKU5GpkO4vbY=;
 b=k0KLZiQlt06wKaGfoKkekALpQzmcvkhOt10E2h19DSaXMYD4/9ziPR2d
 uwbf58Qxs0wAZhMCrThOxirlM+T+ZOmK2NBWDdXdPz1JTHDQrWXL60UBk
 yhcwPUviLf8tCgEuqOSEnjhtgewiCCk+nPKkVklKarEaR01K12nfCAMCi
 p2kcU6ts/+TNBfc+ZoYjFCD7mCNX5JZGbaowdHHVm4sZrM9160IgNVe/N
 jS88TQljnTJ9F+y/fZzGAoP4cxRhV4SecoiXNA0a3JuCcpAPGtYxkZn3I
 FBBdiRWGW/2wXMskfthLjooiKsGccxWL9vZD9pU6KEKgwxCXFqCd7di8+
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=k0KLZiQl
Subject: [Intel-wired-lan] [PATCH net-next v2 13/15] ice: only check set
 bits in ice_ptp_flush_tx_tracker
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice_ptp_flush_tx_tracker function is called to clear all outstanding Tx
timestamp requests when the port is being brought down. This function
iterates over the entire list, but this is unnecessary. We only need to
check the bits which are actually set in the ready bitmap.

Replace this logic with for_each_set_bit, and follow a similar flow as in
ice_ptp_tx_tstamp_cleanup. Note that it is safe to call dev_kfree_skb_any
on a NULL pointer as it will perform a no-op so we do not need to verify
that the skb is actually NULL.

The new implementation also avoids clearing (and thus reading!) the PHY
timestamp unless the index is marked as having a valid timestamp in the
timestamp status bitmap. This ensures that we properly clear the status
registers as appropriate.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
No changes since v1

 drivers/net/ethernet/intel/ice/ice_ptp.c | 38 ++++++++++++++++++------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5b9a2886d69c..7c0caf0a566f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -853,28 +853,48 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
  * ice_ptp_flush_tx_tracker - Flush any remaining timestamps from the tracker
  * @pf: Board private structure
  * @tx: the tracker to flush
+ *
+ * Called during teardown when a Tx tracker is being removed.
  */
 static void
 ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 {
+	struct ice_hw *hw = &pf->hw;
+	u64 tstamp_ready;
+	int err;
 	u8 idx;
 
-	for (idx = 0; idx < tx->len; idx++) {
+	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
+	if (err) {
+		dev_dbg(ice_pf_to_dev(pf), "Failed to get the Tx tstamp ready bitmap for block %u, err %d\n",
+			tx->block, err);
+
+		/* If we fail to read the Tx timestamp ready bitmap just
+		 * skip clearing the PHY timestamps.
+		 */
+		tstamp_ready = 0;
+	}
+
+	for_each_set_bit(idx, tx->in_use, tx->len) {
 		u8 phy_idx = idx + tx->offset;
+		struct sk_buff *skb;
+
+		/* In case this timestamp is ready, we need to clear it. */
+		if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
+			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
 
 		spin_lock(&tx->lock);
-		if (tx->tstamps[idx].skb) {
-			dev_kfree_skb_any(tx->tstamps[idx].skb);
-			tx->tstamps[idx].skb = NULL;
-			pf->ptp.tx_hwtstamp_flushed++;
-		}
+		skb = tx->tstamps[idx].skb;
+		tx->tstamps[idx].skb = NULL;
 		clear_bit(idx, tx->in_use);
 		clear_bit(idx, tx->stale);
 		spin_unlock(&tx->lock);
 
-		/* Clear any potential residual timestamp in the PHY block */
-		if (!pf->hw.reset_ongoing)
-			ice_clear_phy_tstamp(&pf->hw, tx->block, phy_idx);
+		/* Count the number of Tx timestamps flushed */
+		pf->ptp.tx_hwtstamp_flushed++;
+
+		/* Free the SKB after we've cleared the bit */
+		dev_kfree_skb_any(skb);
 	}
 }
 
-- 
2.38.0.83.gd420dda05763

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
