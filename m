Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CA2C7EE23
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Jun 2023 01:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66F1181276;
	Tue,  6 Jun 2023 01:33:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66F1181276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686015217;
	bh=9Dn1/ubOy6yRPkmBDQQVOS9H/iXUxV57iHQLACmN3K4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=7Mx+6i3GC50H2LHvo+O75u+0OVJBLsHjcyoq+lSV3byoijf9fDKInKouu26LgovVL
	 l1A/mKTBib3C+d4KDHeNkN2hNVUDjIcLxPwJ3u8yOWCDcPgvjmIey9/gBb24x7c4kP
	 0MUsludnDXYjZ5z31Jyr1lRfUKCmofl3QtEKN1vTCAu6MlAnNnBrjA8RRZHdT+v4JD
	 hB6YVXRlUc9RNcvY6xqmcjD7HaI3nGIBaZlIrHWwpb1OgyngxjZlxrHQhyig0Wy629
	 db9AE5k7uyTbp5K2U0lD0aNJGQYQAKEgvDUOQpu/4m36vRBzP0lSXD+ViNug0O99y/
	 OyCjX/gAl9qyw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NfjCpywMOg6x; Tue,  6 Jun 2023 01:33:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 523AF812AC;
	Tue,  6 Jun 2023 01:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 523AF812AC
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 25B7A1BF4DD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jun 2023 01:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F399D40879
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jun 2023 01:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F399D40879
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2UOrHusdCErn for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Jun 2023 01:33:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACFCD40876
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACFCD40876
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Jun 2023 01:33:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336887987"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; d="scan'208";a="336887987"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 18:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="833020984"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; d="scan'208";a="833020984"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.24.14.106])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 18:33:30 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  5 Jun 2023 18:33:23 -0700
Message-Id: <20230606013325.602823-3-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606013325.602823-1-vinicius.gomes@intel.com>
References: <20230606013325.602823-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686015212; x=1717551212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AFGJ6J7puHAvhYQqicW/O7U/R4gEpuBlkK45m8LQppU=;
 b=i/0pH0EDWgGQx6JUuLmhSx9WuL/r/1cLKJ4WtujMgXTWPhzPNwSMpw5Z
 Cc1CN8vFozRsxJzTsYthT5TH9xUTowlm0it0i3xnB7rJRPX4iFViwoCi4
 kdZYSC40G+om7icV8oGsoyfyRCW6atRQmDZFIVjvO2U4txsGvQWNfpVbk
 +EwC5qhvyjx/ITwkSSBQYbJzogjXzOFafVIszNLNMeqPbnYVOxN8TTvTD
 uCU5MiQ6TRwVcz9ncThCMmJrVXkKBkr5x+f7T/pgFRyIlFlSZkoGm9V34
 t1qLnKhwmGEnhcQz+gA/QxArHPKbxf6Zu+dj/AOUK8aKi0HVZ289uGPOv
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=i/0pH0ED
Subject: [Intel-wired-lan] [PATCH iwl-net v3 2/4] igc: Check if hardware TX
 timestamping is enabled earlier
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
Cc: vladimir.oltean@nxp.com, kurt@linutronix.de, anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Before requesting a packet transmission to be hardware timestamped,
check if the user has TX timestamping enabled. Fixes an issue that if
a packet was internally forwarded to the NIC, and it had the
SKBTX_HW_TSTAMP flag set, the driver would mark that timestamp as
skipped.

In reality, that timestamp was "not for us", as TX timestamp could
never be enabled in the NIC.

Checking if the TX timestamping is enabled earlier has a secondary
effect that when TX timestamping is disabled, there's no need to check
for timestamp timeouts.

We should only take care to free any pending timestamp when TX
timestamping is disabled, as that skb would never be released
otherwise.

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

WIP
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c |  5 +--
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 42 +++++++++++++++++++++--
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 7da0657ea48f..66fb67c17e4f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -581,6 +581,7 @@ enum igc_ring_flags_t {
 	IGC_RING_FLAG_TX_CTX_IDX,
 	IGC_RING_FLAG_TX_DETECT_HANG,
 	IGC_RING_FLAG_AF_XDP_ZC,
+	IGC_RING_FLAG_TX_HWTSTAMP,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a61afa69975e..d3cfb8e97ac8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1578,7 +1578,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		}
 	}
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
+	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		/* FIXME: add support for retrieving timestamps from
 		 * the other timer registers before skipping the
 		 * timestamping request.
@@ -1586,7 +1587,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		unsigned long flags;
 
 		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON && !adapter->ptp_tx_skb) {
+		if (!adapter->ptp_tx_skb) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 56128e55f5c0..42f622ceb64b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -536,9 +536,36 @@ static void igc_ptp_enable_rx_timestamp(struct igc_adapter *adapter)
 	wr32(IGC_TSYNCRXCTL, val);
 }
 
+static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
+{
+	unsigned long flags;
+
+	cancel_work_sync(&adapter->ptp_tx_work);
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	adapter->ptp_tx_skb = NULL;
+
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+}
+
 static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	int i;
+
+	/* Clear the flags first to avoid new packets to be enqueued
+	 * for TX timestamping.
+	 */
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		clear_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags);
+	}
+
+	/* Now we can clean the pending TX timestamp requests. */
+	igc_ptp_clear_tx_tstamp(adapter);
 
 	wr32(IGC_TSYNCTXCTL, 0);
 }
@@ -546,12 +573,23 @@ static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
 static void igc_ptp_enable_tx_timestamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	int i;
 
 	wr32(IGC_TSYNCTXCTL, IGC_TSYNCTXCTL_ENABLED | IGC_TSYNCTXCTL_TXSYNSIG);
 
 	/* Read TXSTMP registers to discard any timestamp previously stored. */
 	rd32(IGC_TXSTMPL);
 	rd32(IGC_TXSTMPH);
+
+	/* The hardware is ready to accept TX timestamp requests,
+	 * notify the transmit path.
+	 */
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		set_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags);
+	}
+
 }
 
 /**
@@ -1026,9 +1064,7 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
 		return;
 
-	cancel_work_sync(&adapter->ptp_tx_work);
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
-	adapter->ptp_tx_skb = NULL;
+	igc_ptp_clear_tx_tstamp(adapter);
 
 	if (pci_device_is_present(adapter->pdev)) {
 		igc_ptp_time_save(adapter);
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
