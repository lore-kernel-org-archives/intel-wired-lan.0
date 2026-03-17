Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A0F33802
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Mar 2026 06:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5108F81434;
	Tue, 17 Mar 2026 06:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNpGwRd5j9Wk; Tue, 17 Mar 2026 06:22:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83B9F8144F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773728564;
	bh=U0c0no8qOQMhS+4Ff84jEoupUlPveySfmNiJKU+YoOs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4kSBTMXNjiwPmu1iL8vdSvsVTIw2lG17UqyCEQ8qqyCOwS57PPqts2wKteRq+2+e5
	 2yMlk9rsqKM6MZYh4TecYJrk3KRx9XUy1Pc+3h/94gpNWDH4rWzQwQesGFoThddwEZ
	 TtVUZj7oqGj7+7tpFY55382fcY/eGbaM12KiTiikhzWnXjxP+0MH7+HuPQ2YJSf1cb
	 9orm7BT5KxvJHO7AUOPoviP1Y/uPeUrxhBFEaDxbegp88n9I8ZpZcjdigKHzHRPeEA
	 PLlEp+4eR4NxnZ7E/tB7WhO5cq/wuZeu+7ZxCUGcaZLBinYkQXhqD8lWThB4fj9mk9
	 3j1z9bEaiMsOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83B9F8144F;
	Tue, 17 Mar 2026 06:22:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F63B3BE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 06:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10AB941442
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 06:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ac6T1f8xZrrQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Mar 2026 06:22:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D6ED641414
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6ED641414
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6ED641414
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 06:22:40 +0000 (UTC)
Received: from ms-a2 (16.4.31.150.dy.iij4u.or.jp [150.31.4.16])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62H6MFGB069015
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Mar 2026 15:22:15 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
 kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Tue, 17 Mar 2026 06:21:46 +0000
Message-ID: <20260317062205.39406-3-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>
References: <20260317062205.39406-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=U0c0no8qOQMhS+4Ff84jEoupUlPveySfmNiJKU+YoOs=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1773728536; v=1;
 b=TJTOZ7+V/mCxUCGS7AljPoa45TxfGqhV/+/mADeZuHUN8prPHkhvj8GtK/oST9Nr
 sLavL70/izk6R8YpKdEEtkdZTCH6isRAMaxYc465Pny7DOyWbSSWo1iHMd5ZJPy/
 ZND8Knn15TV1BtThtOnkdQybVzOLf2Or6hfIFqsyp18T4t6FySh8XvNnqXuWgAK0
 A9/njzdVf6GGlfHZvCwQ8ss0NLCxtMhHG5fyY+4VPNi1K2QnjyV3DUNbCOU7/DBR
 T+J4STSBkhvC69fJCNIrVuXWOnUlTMLLlkfLOSVVtSLaMuJcQhHo7U3+yH/q+vtp
 Z95a+9WQTUSY6HeLhae1sQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=TJTOZ7+V
Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/2] igc: enable build_skb on
 the non-XDP small-frame RX path
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

igc implements igc_build_skb(), but it is currently unused because the
IGC_RING_FLAG_RX_BUILD_SKB_ENABLED bit is never set. Enable the
build_skb path when XDP is not active and the configured maximum frame
size fits within IGC_MAX_FRAME_BUILD_SKB.

In a single-queue small-packet (64-byte) RX microbenchmark on my setup,
enabling build_skb improved the receive rate from about 3.11 Mpps to
about 3.30 Mpps, while reducing missed packets from about 484 kpps to
about 300 kpps.

Keep the XDP path unchanged for now, since it uses a different RX buffer
layout based on XDP_PACKET_HEADROOM, and enabling it there would need
separate validation and buffer layout adjustments.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc.h      | 4 ++++
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index e66799507f81..acbd2c237667 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -734,6 +734,10 @@ enum igc_ring_flags_t {
 
 #define ring_uses_build_skb(ring) \
 	test_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define set_ring_uses_build_skb(ring) \
+	set_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define clear_ring_uses_build_skb(ring) \
+	clear_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
 
 static inline unsigned int igc_rx_bufsz(struct igc_ring *ring)
 {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 79192b02e6be..b44f89311a4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring)
 		igc_clean_rx_ring_page_shared(ring);
 
 	clear_ring_uses_large_buffer(ring);
+	clear_ring_uses_build_skb(ring);
 
 	ring->next_to_alloc = 0;
 	ring->next_to_clean = 0;
@@ -654,6 +655,9 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 
 	if (igc_xdp_is_enabled(adapter))
 		set_ring_uses_large_buffer(ring);
+	else if (!(adapter->flags & IGC_FLAG_RX_LEGACY) &&
+		 adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
+		set_ring_uses_build_skb(ring);
 
 	/* disable the queue */
 	wr32(IGC_RXDCTL(reg_idx), 0);
-- 
2.51.0

