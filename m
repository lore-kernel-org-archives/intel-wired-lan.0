Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B904C531DF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Aug 2024 07:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE16C400F2;
	Thu, 22 Aug 2024 07:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id It4KTHF1Veb2; Thu, 22 Aug 2024 07:42:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94939405BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1724312539;
	bh=M7j9L59GoB4WO48ZSttcnFNGmhQsi1TdLvFuvMN+Xzg=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=82RJp6Vp6oXj35tnbazAHicpBnVmUI0CIujwWEENxx/nUfpdhpMuGpEROEwUpQJ0W
	 NsCBexvcr7K5V/wkuLmSBhvxkOzn0E0a1NNA+a7p2ReLYNmQlx0XwgWKx5aY28vMYy
	 ZI1iBJ2gtZxq0ZlRdO6LvvIiiKWt8VvRvUTXPdY3ZHb0k2OWVXsbxeBML4eR5nVMi3
	 qZevxwj991Et18tyn7o/ro24q2orJ0lm0f0yHgIi29a+y5l7SOm+Fnt7yjt8TdY7L5
	 YeYWJHpnAgKZNmxqisxhUBPUMqoNbRGoLa9tQ6Qxzks9LUUOGtnaRMnZfuKnCtvUdu
	 8qJSVsX9+4qZQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94939405BA;
	Thu, 22 Aug 2024 07:42:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id D8F201BF322
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4F7260A63
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKd8csMI3GOD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Aug 2024 07:42:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=kurt@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CBE3E60A61
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBE3E60A61
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBE3E60A61
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Aug 2024 07:42:17 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Thu, 22 Aug 2024 09:42:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-igb_xdp_tx_lock-v1-1-718aecc753da@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAM7rxmYC/x3MTQqAIBBA4avErBNK+pGuEiGpUw2FhUoJ4d2Tl
 t/ivRc8OkIPQ/GCw5s8nTajLgvQ22xXZGSygVe8qQTnjFYlo7lkiPI49c5UJ5puMUb3rYBcXQ4
 Xiv9xBHoOZjHAlNIHS0iOmWoAAAA=
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=IVVS9HlZbTPv/6DwViQSU27m2irFcmQgtNlpAYr8SOM=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmxuvUZ9c5esw25f4mqk2o0qQTm320poXw8CsGg
 8XEJ8vaBX2JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZsbr1AAKCRDBk9HyqkZz
 gkTCD/9PN3By/GanTcZE8G9EYmZ1onOWBw6K0jL/Ik59CpMNryrBD9TGsuAyldTeOG6AmMg6oof
 Qmcx0tbB/zkNNOb38f2S/HheSOseT61ewtAU8xu7RgQGMvqrWi9OCCH9xPzzHtnG2XRl5I41oW7
 NxObM8SxxLAByhcuVrochegurC8VHquuQcctSDKlym+svEpiTes5ixs9zVQBUDQTmBNPRMZxbMl
 s48rytPCukcPKyR8jtXuyowHpW/O1oXtCVLHu/tb7ZQPyRP6+0kSuSKlV2DyfNoz9PNqGBgaNCC
 Y6Q575jqbjz/Wm+0M4ZVKbEMEd5B95sM+lU1dVRbPNHeK1sDK3YlKpl3tzXks7EGVzmzWzKfRi+
 bSVqwBOdIBtYnzqTepBL+jeGLwMKGJiDCgdmEsBdaVMHBnUmR9ox87JGGqvuudYJXHydAsyB/JL
 anxfsqpdaQkLPk0xEVmahH3lP1DlH7Esw0a8kYhn85fTk+vgxDsdvd1+XIHRYMiNveGZnR4bFou
 +1vs0VghDhOFCIrleiAy3HGoQURxaY8QCWkxRFN7n9vwCBwQbHC6c5MlIPg+GAZ1cGhhMt6sgHM
 BYnyA1ZNt/Wf745ez8zKuUnoh8n9SBiOFEre6Iqnee7YagokVckL6eAGEQUYBZxfloMgzmNZMhm
 oQhDxHt+97grDVg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1724312533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M7j9L59GoB4WO48ZSttcnFNGmhQsi1TdLvFuvMN+Xzg=;
 b=wLYW/7X3/tgdaHKfBzb53GeHGvrexN8Z3qDaZqNziPSieZwZsR5fnXnFbRwI4syeqob4MS
 IEjdmIBAsvhBQHUZfL5fAMEK8QtV2poP0+Oo0RNDu2OJLcce99n1RP/qMQhZBQ8CM2/MTS
 Ky15Qn0Jpuy72op9edA9JXFcwvN47y7UWIW3pZQKiZKLGhOOw4erF4qSbyEBSLidzjSK1v
 7iVcl7yzEVHLBZZOCTv1iAn1sJqVyOqtGBKQKjO5ppeK1UNASM+4rRf2VCQ8y0HuMJThTM
 ksF3ZiOIgTTTXR555ox9dSTCB8Ckl04lShuxaqQdlyuyjv/oLXgmTd7eDPzImA==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1724312533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M7j9L59GoB4WO48ZSttcnFNGmhQsi1TdLvFuvMN+Xzg=;
 b=liKH38/Vxwo7zuN47LsxtYil8YUiuYHkfgTVZjo4dgXPvEJcqXJVkclcijShTZzzBqj0UY
 lVobnFQ2LOlzdwBQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLYW/7X3; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=liKH38/V
Subject: [Intel-wired-lan] [PATCH iwl-net] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
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
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Benjamin Steinke <benjamin.steinke@woks-audio.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Always call igb_xdp_ring_update_tail() under __netif_tx_lock, add a comment
and lockdep assert to indicate that. This is needed to share the same TX
ring between XDP, XSK and slow paths. Furthermore, the current XDP
implementation is racy on tail updates.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Add lockdep assert and fixes tag]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 33a42b4c21e0..c71eb2bbb23d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -33,6 +33,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/pm_runtime.h>
 #include <linux/etherdevice.h>
+#include <linux/lockdep.h>
 #ifdef CONFIG_IGB_DCA
 #include <linux/dca.h>
 #endif
@@ -2914,8 +2915,11 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+/* This function assumes __netif_tx_lock is held by the caller. */
 static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
+	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
 	 */
@@ -3000,11 +3004,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 		nxmit++;
 	}
 
-	__netif_tx_unlock(nq);
-
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		igb_xdp_ring_update_tail(tx_ring);
 
+	__netif_tx_unlock(nq);
+
 	return nxmit;
 }
 
@@ -8854,12 +8858,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
+	unsigned int total_bytes = 0, total_packets = 0;
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
-	struct sk_buff *skb = rx_ring->skb;
-	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
+	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8987,7 +8993,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);

---
base-commit: a0b4a80ed6ce2cf8140fe926303ba609884b5d9b
change-id: 20240822-igb_xdp_tx_lock-b6846fddc758

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>

