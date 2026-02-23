Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CAEE98E14
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 10:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D1CF40B64;
	Mon, 23 Feb 2026 10:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i05FL7x2yVFa; Mon, 23 Feb 2026 10:22:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6991640A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771842179;
	bh=sfqIfmpaPHl2QPRtHiNN5Lr1cArSpywZy9kVlOTbH20=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DmJ2gHFWXkrGSWCebWB8b+6nuEnGcZf+0vDIjgAg6bbe2zFNAq3BGEz/jkIWmRCxt
	 qmvvhUIpX2AJQT1iyexSAlzpsPcOt4aa50hF7m0KkyShUpxWtgpMdGAAfcSxpmhnnC
	 4WboEAFjLh+VsebtI8N1WLrOITfApGg9sE8XSxrYVhzebZTjNYgI/PJ6ME4g335MuZ
	 YQrPnOOipzJrhwoamfIaKywxgvjzdbSww37UaJ+ZWb9pU7uGGmGrv5tvCMmvAp0/2c
	 FUmrqGxKKD8giGVFzpf9TW0ug+NFm732zwXrlXqXoDQph+EjZgsKJzTGb7YYPXEzTZ
	 G/MvG7GG1RrSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6991640A99;
	Mon, 23 Feb 2026 10:22:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F4EB1CE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 10:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A271E40AA1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 10:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPq2R88PJBpy for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 10:22:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AC19340A97
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC19340A97
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC19340A97
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 10:22:55 +0000 (UTC)
X-CSE-ConnectionGUID: TRuepQSYQRWiAzNRalMp2Q==
X-CSE-MsgGUID: 0jREmAlOQCuF4MGIJffZUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444724"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="76444724"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 02:22:55 -0800
X-CSE-ConnectionGUID: 8u7F0LlCR3qRjeI9gQ1A4g==
X-CSE-MsgGUID: p2KXPAsoSUCEVswHJN9s+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="246121746"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:51 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id EACD328169;
 Mon, 23 Feb 2026 10:22:48 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Natalia Wochtman <natalia.wochtman@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 23 Feb 2026 10:52:11 +0100
Message-ID: <20260223095222.3205363-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223095222.3205363-1-larysa.zaremba@intel.com>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771842176; x=1803378176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PhZmw2HezwgE5pFRtdOSxaDFfThUcjyd1oY4SxpvDQk=;
 b=GaZNKIx1iI5+TqE1XlrxN6sou0Cz/OKXUwFtaMh4Hwh0o4rlvKvMP/tz
 kkrNSiOD5kWK+t1o0Mm4pdJcw9sy9nQem6Z2cubqF/LMt8NethEmZOdxy
 eVAJVPdnO5uUEbPpNpQsomt3y+GdJez6SE+cnW4Y/ny8gNpxtUsu29/RW
 bqjab+Hl9eD6HGf41fiw8wgsuVOhYDC8jhtZS0wnAUEB7/nbDhJp4HHpb
 98P0nj+bi1q5+L5+L1EQjR1fRIdxBnm55CorO8tOoLb2EYCxlVFX/2OOX
 38U/iZRX09FzvHX+BF0jxeRFebXH92VvRW4U5nxMz/o45Q399T2rW07tV
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GaZNKIx1
Subject: [Intel-wired-lan] [PATCH iwl-next 04/10] ixgbevf: branch prediction
 and cleanup
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

Add likely/unlikely markers for better branch prediction. While touching
some functions, cleanup the code a little bit.

This patch is not supposed to make any logic changes.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 24b8f4bb415b..39124c430537 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -570,7 +570,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 	u16 ntu = rx_ring->next_to_use;
 
 	/* nothing to do or no valid netdev defined */
-	if (!cleaned_count || !rx_ring->netdev)
+	if (unlikely(!cleaned_count || !rx_ring->netdev))
 		return;
 
 	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
@@ -586,7 +586,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 
 		rx_desc++;
 		ntu++;
-		if (unlikely(ntu == rx_ring->count)) {
+		if (unlikely(ntu == fq.count)) {
 			rx_desc = IXGBEVF_RX_DESC(rx_ring, 0);
 			ntu = 0;
 		}
@@ -823,7 +823,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 
 		rx_desc = IXGBEVF_RX_DESC(rx_ring, rx_ring->next_to_clean);
 		size = le16_to_cpu(rx_desc->wb.upper.length);
-		if (!size)
+		if (unlikely(!size))
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -855,7 +855,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!xdp_res && !skb) {
+		if (unlikely(!xdp_res && !skb)) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
 		}
@@ -867,21 +867,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res ||
+		    unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
 			skb = NULL;
 			continue;
 		}
 
-		/* probably a little skewed due to removing CRC */
-		total_rx_bytes += skb->len;
-
 		/* Workaround hardware that can't do proper VEPA multicast
 		 * source pruning.
 		 */
-		if ((skb->pkt_type == PACKET_BROADCAST ||
-		     skb->pkt_type == PACKET_MULTICAST) &&
-		    ether_addr_equal(rx_ring->netdev->dev_addr,
-				     eth_hdr(skb)->h_source)) {
+		if (unlikely((skb->pkt_type == PACKET_BROADCAST ||
+			      skb->pkt_type == PACKET_MULTICAST) &&
+			     ether_addr_equal(rx_ring->netdev->dev_addr,
+					      eth_hdr(skb)->h_source))) {
 			dev_kfree_skb_irq(skb);
 			continue;
 		}
@@ -889,13 +887,14 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		/* populate checksum, VLAN, and protocol */
 		ixgbevf_process_skb_fields(rx_ring, rx_desc, skb);
 
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		total_rx_packets++;
+
 		ixgbevf_rx_skb(q_vector, skb);
 
 		/* reset skb pointer */
 		skb = NULL;
-
-		/* update budget accounting */
-		total_rx_packets++;
 	}
 
 	/* place incomplete frames back on ring for completion */
-- 
2.52.0

