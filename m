Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5BC5DF66
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60615407CD;
	Mon, 17 Aug 2026 15:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGvGEvI4s-qU; Mon, 17 Aug 2026 15:27:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C307407A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786980441;
	bh=7VA9P9TmAckj6vhir0RJ/OmqAptpB42Jyovrg4yN07c=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zal3oQuTAAyV8jBFxSKyv6FMxLsHeQPRZgRwQmrE2fn5+A00GpLZ3F6ABh5a/21rv
	 aZHLEVlC7DoQlDg3OoGpB79abfyyr38xH2QNnh0cL05NBlX+/T73oK0WiN4U0Xdkxl
	 rQbuQ0Q/OFBd2g0pOnVi5n8Km2l2osrCHdy4GWpU48R1YeC8ylV4GT/6e6fA3hGgnR
	 xWrddEgCNZAFXUFpatqnsEYkbh9KVGKhi5w8gaA0bGcB+YUy9BsxNNE0PhEBPz2U/L
	 q9hBlK+JSqGjZpEgImYGGzumis5iq3G/zPI8HflgEzpNKbtKL3+rBQHQmicN/eMP/f
	 PgCHy5nS5zxeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C307407A2;
	Mon, 17 Aug 2026 15:27:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94BFA33B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A7A440CAA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ab3IQWLKX6D for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:08:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=shivani07g@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7A9A540843
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A9A540843
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fa4l8ROh
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A9A540843
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:08:37 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7ee4f241f42so1748355a34.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 18:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786756116; x=1787360916; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7VA9P9TmAckj6vhir0RJ/OmqAptpB42Jyovrg4yN07c=;
 b=fa4l8ROhLBGmSIaEl+5yJj2lNr4U3F/I4Pi6izDiCRuPE5aLLBBRtOw/lctBbxZmvd
 2CNttN1g7kezEtGaWCEOU90AYco6hyQ5eEwi9+kXSrrlI/y74h1ZM87Fe7zh/9iHTtFH
 jPGobP1ip4Xp5HxOdwUWMv+duOBkVPFXng8mPr4SPe+yGPJ049W0vxQk9kH0+pToRRSW
 bV5qJwmhMxdXKJCYOi8wKAl4Q5zDnCDqgZUGvTsS/BzQ3TStjM/Ra0xNOtk6W+NkGo/T
 T0oyJNL68YOvlij1Q0C6DqW9O+7rkJYEnqZukp6EIS5kp5IP4ZggxRcy+p4hzcTj1NTt
 /gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786756116; x=1787360916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7VA9P9TmAckj6vhir0RJ/OmqAptpB42Jyovrg4yN07c=;
 b=L7ImvSt049bvqUwUIBZAFzhmq1eEAwEiCSjXZlR3HZkbZUYKCfpLDrf1s/RvvhMXn8
 7E0obyDsAg9cr6jm8dxiWAu+nwjQh2nCIR2KRBzjeTYie/fJ5EbBN2TgjGBPykFD7pRV
 qxcCroOcMdmwXSnUPXX3fkelq4LewhAU4WCxdN7hu0/TFZiP612oFQPhD9/IAqWVgs5q
 bu9KGgi2Lo/4e1Pmq6StVtty8lG9+2kWiMr/t70+BI6g4dPZzXKEBnnRaDC4wvfYFQV5
 Ku7L+beU0I1nNHKOI2Juv8r1o3zW1oexJUANqyAZzISRZq2MA69vpJD3dqo0D0rLbKMp
 5R+A==
X-Gm-Message-State: AOJu0YwnUYPQ/sgQwUaIcs70ZE/73lBAjwRj0v6CoINQSpvdiN2zhtYp
 wXgkCuSnNJ3GSKit5Vs3VX7t/yFaA+eqhntUGgW4p404CCU6ZW73FkJiQyIeZpjd
X-Gm-Gg: AR+sD10IVxvJL2TKTGwNo/tv2gU9HTseD56VSnyO6jrH9/g0N2/sEt5VBezwJRB9yuJ
 uIGj0n1S8iDS44hRuGa91wcpkpBx0mB9qdkKztCFpr/zqY6QPOztL2/2Gu3uD9K43RxHzk3Ilic
 5kTgueRos8UG5xO7wgos7zUYVNsuVtAOQHJn+cZK4fWvYbrtq14WF3kXW2ko3i9YV5SZcebLRx8
 lYVonXxgTEKoy02sQyZVd0PuP92gGnf+dEN34c23vhfqirsplXxJKjXycLUy5Vd9t41lok2A3dR
 PRVEtZ/zF/KKAR8bxpN4b4+rV4iMgXC0yZktTAStyqtJMSYQBKC4PmvB4WRtqWTB65/2Og2ToqE
 DhI5U7c1UDFtGZDlOz2XP6UNvzC0mP4aiY7hSvtSNm4UHmGi28dnbnSFITnRrlsh+4Fhj6/jSSk
 RfaPpGWutfygVk4c1rn3r3i7CfSMx7LmCcEMmsxquK791k7Nt5fGIn91avrkA981auQ/WiOWFmV
 qOVr2Z1Gm+gnueJQ5zl
X-Received: by 2002:a9d:69ca:0:b0:7f3:daf9:eda3 with SMTP id
 46e09a7af769-7f3daf9f40emr4856740a34.4.1786756116462; 
 Fri, 14 Aug 2026 18:08:36 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282fesm2232153a34.14.2026.08.14.18.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 18:08:36 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Matthew Vick <matthew.vick@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Sat, 15 Aug 2026 01:08:27 +0000
Message-Id: <20260815010827.91912-3-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260815010827.91912-1-shivani07g@gmail.com>
References: <20260815010827.91912-1-shivani07g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 15:27:18 +0000
Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] igb: Clear pending Tx
 timestamp requests when disabling Tx timestamping
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

Disabling Tx hardware timestamping clears TSYNCTXCTL.EN but leaves an
outstanding request in ptp_tx_skb. Re-enabling within
IGB_PTP_TX_TIMEOUT therefore finds the single timestamp slot occupied
and skips new requests until the watchdog reports a misleading timeout,
producing a blackout of up to 15 seconds.

Cancel timestamp retrieval when disabling Tx timestamping, then publish
HWTSTAMP_TX_OFF and release the pending request under ptp_tx_lock. The
transmit path tests both the configured mode and slot ownership under
the same lock, so no request can be admitted between clearing the slot
and publishing the disabled state. Updates to the saved configuration
and the watchdog mode check use that lock as well.

Suspend uses the same cleanup helper without changing the saved mode,
allowing reset to restore the requested configuration after resume.

Only count a timestamp request as skipped when hardware timestamping is
enabled and the slot is occupied. Requests carrying SKBTX_HW_TSTAMP
while the feature is disabled could never have been serviced and are
ignored without changing the counter.

Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items and interrupts.")
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 26 +++++++++++++----------
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 20 +++++++++++++++--
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fc70f7aa4ce0..42204e3307d6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6565,18 +6565,22 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
 		unsigned long flags;
 
+		/* A timestamp that was requested while Tx timestamping was
+		 * not enabled can never be delivered, it is not "skipped".
+		 */
 		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !adapter->ptp_tx_skb) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			tx_flags |= IGB_TX_FLAGS_TSTAMP;
-
-			adapter->ptp_tx_skb = skb_get(skb);
-			adapter->ptp_tx_start = jiffies;
-			if (adapter->hw.mac.type == e1000_82576)
-				schedule_work(&adapter->ptp_tx_work);
-		} else {
-			adapter->tx_hwtstamp_skipped++;
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON) {
+			if (!adapter->ptp_tx_skb) {
+				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+				tx_flags |= IGB_TX_FLAGS_TSTAMP;
+
+				adapter->ptp_tx_skb = skb_get(skb);
+				adapter->ptp_tx_start = jiffies;
+				if (adapter->hw.mac.type == e1000_82576)
+					schedule_work(&adapter->ptp_tx_work);
+			} else {
+				adapter->tx_hwtstamp_skipped++;
+			}
 		}
 		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 3cc05f9198f8..adc7be6a2ee2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -914,6 +914,9 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
+	if (adapter->tstamp_config.tx_type != HWTSTAMP_TX_ON)
+		goto unlock;
+
 	if (!adapter->ptp_tx_skb)
 		goto unlock;
 
@@ -933,19 +936,22 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 /**
  * igb_ptp_clear_tx_tstamp - drop a pending Tx timestamp request
  * @adapter: private network adapter structure
+ * @disable: whether to disable Tx timestamp admission
  *
  * Cancel the timestamp retrieval work and free a pending timestamp skb.
  *
  * Context: Must be called in sleepable context with ptp_tx_lock not held;
  *          cancel_work_sync() waits for igb_ptp_tx_work() which takes it.
  */
-static void igb_ptp_clear_tx_tstamp(struct igb_adapter *adapter)
+static void igb_ptp_clear_tx_tstamp(struct igb_adapter *adapter, bool disable)
 {
 	unsigned long flags;
 
 	cancel_work_sync(&adapter->ptp_tx_work);
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+	if (disable)
+		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
@@ -1250,6 +1256,13 @@ static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
 	regval |= tsync_tx_ctl;
 	wr32(E1000_TSYNCTXCTL, regval);
 
+	/* Drop a possibly pending Tx timestamp request when disabling Tx
+	 * timestamping. It would otherwise block new requests until it is
+	 * flagged as timed out by the watchdog up to 15 seconds later.
+	 */
+	if (!tsync_tx_ctl)
+		igb_ptp_clear_tx_tstamp(adapter, true);
+
 	/* enable/disable RX */
 	regval = rd32(E1000_TSYNCRXCTL);
 	regval &= ~(E1000_TSYNCRXCTL_ENABLED | E1000_TSYNCRXCTL_TYPE_MASK);
@@ -1310,6 +1323,7 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct netlink_ext_ack *extack)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
+	unsigned long flags;
 	int err;
 
 	err = igb_ptp_set_timestamp_mode(adapter, config);
@@ -1317,7 +1331,9 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev,
 		return err;
 
 	/* save these settings for future reference */
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 	adapter->tstamp_config = *config;
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 
 	return 0;
 }
@@ -1461,7 +1477,7 @@ void igb_ptp_suspend(struct igb_adapter *adapter)
 	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
 
-	igb_ptp_clear_tx_tstamp(adapter);
+	igb_ptp_clear_tx_tstamp(adapter, false);
 }
 
 /**
