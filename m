Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4461CF55103
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Mar 2026 18:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EF7883BD3;
	Sat,  7 Mar 2026 18:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQmzRq531NMs; Sat,  7 Mar 2026 18:28:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3C0883EBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772908127;
	bh=wNehNCtg8C9+gzplHafZhq5oL1T1yTUahHTVgkm8zbs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1swoUGqdC47++rDXFpt2YMgtew6hv9L+Cw76iemIWYM8wBaje5KVjOHlX91SGEjJ
	 vVAr/+3jS6Hyl27wBG4tB9g8xtrTP2GXC14aa1aWfIN3oDo0a6ukuqH065mb3/btaV
	 JmXuQuJRQiz5IA2XFgVXvViZQyoo2jbNOO7eC2u4KUfr2Itc+Pv7e5/7ow0OnCcobh
	 lz/yolK36CdvzEg7OsqygcGwD4C9MH1+nUNi+dUTuOjECEX9LleisreI4OE781zLil
	 hZ1TWN+SfC2/4/fhJ4pQ2WRK/qPXWnZdhjUwnRInKm3RqJW/TAIvqL6rjGWg9QPHzp
	 iFkfDEZWpFBBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C0883EBB;
	Sat,  7 Mar 2026 18:28:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C227223
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Mar 2026 18:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02A88838E6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Mar 2026 18:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B-jP3l_LS6vX for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Mar 2026 18:28:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D015483BD3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D015483BD3
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D015483BD3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Mar 2026 18:28:44 +0000 (UTC)
Received: from ms-a2 (79.25.31.150.dy.iij4u.or.jp [150.31.25.79])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 627ISFwa043186
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 8 Mar 2026 03:28:15 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
 Kohei Enju <kohei@enjuk.jp>
Date: Sat,  7 Mar 2026 18:27:38 +0000
Message-ID: <20260307182808.155027-2-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260307182808.155027-1-kohei@enjuk.jp>
References: <20260307182808.155027-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=wNehNCtg8C9+gzplHafZhq5oL1T1yTUahHTVgkm8zbs=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1772908095; v=1;
 b=Tpl254sK200v8NVKeVmog7ZJfg64cufpqMtOUjVK+LzSdvzmd6L//0PgsTOcp+2m
 59OrxPHGawG44YLA5sDxJkY1ijGAmjOqLbM1UUx19tGXCcxeUwpQ/JzIJ4SqqLOd
 +WVnx3AEfSg0Nce3J1xbhLUJwJ6v5KkVvZF2Z30iwWEZ6LUzobKaSJbqws0HsEqP
 7y5M89OmZDn9qnliGd5sor0QKNDXb34eHSdrZwdWTMgNpAox70z+7UUYopcfOJdp
 8+N0SxAbi8FlvzgmC3JUD+uNfapr+XqSAv3x4JfV4Dp3+HX35ozj2dFBKuSSBKi8
 MrSR8Df24vkjXH1iovoKLA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=Tpl254sK
Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX hardware
 timestamps in igc_build_skb()
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

igc_construct_skb() sets RX hardware timestamps, but igc_build_skb()
does not. This has not been observable so far since igc currently does
not enable the build_skb RX path.

Set RX hardware timestamps in igc_build_skb() as well so that both skb
construction paths provide the same behavior.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ebd831a4ff53..3a4c1ebe4faa 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1964,13 +1964,16 @@ static void igc_add_rx_frag(struct igc_ring *rx_ring,
 
 static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 				     struct igc_rx_buffer *rx_buffer,
-				     struct xdp_buff *xdp)
+				     struct igc_xdp_buff *ctx)
 {
-	unsigned int size = xdp->data_end - xdp->data;
-	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
-	unsigned int metasize = xdp->data - xdp->data_meta;
+	unsigned int size, truesize, metasize;
+	struct xdp_buff *xdp = &ctx->xdp;
 	struct sk_buff *skb;
 
+	size = xdp->data_end - xdp->data;
+	truesize = igc_get_rx_frame_truesize(rx_ring, size);
+	metasize = xdp->data - xdp->data_meta;
+
 	/* prefetch first cache line of first page */
 	net_prefetch(xdp->data_meta);
 
@@ -1979,6 +1982,11 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
+	if (ctx->rx_ts) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+	}
+
 	/* update pointers within the skb to store the data */
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	__skb_put(skb, size);
@@ -2681,7 +2689,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		} else if (skb)
 			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
 		else if (ring_uses_build_skb(rx_ring))
-			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
+			skb = igc_build_skb(rx_ring, rx_buffer, &ctx);
 		else
 			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
 
-- 
2.51.0

