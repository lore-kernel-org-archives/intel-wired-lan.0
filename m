Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1F606A324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uvD3GBiQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWW1WySc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88BAE60AB9;
	Fri, 27 Nov 2026 08:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SZFslgBPvHEb; Fri, 27 Nov 2026 08:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D5FB60AC4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795769065;
	b=M4PkYiMa1Kau2BgxQxxRJpCMPyQN0Lek8WhTx8iQjUA+pF2CGFt2K9IfQVwjzOJfTsP0
	 lnwYNnIm/wccpsKmsHgNZNJ9lBGuT46z3xQ/ObnHhC7OYWzXyCasUPCpHxJhhyVlcxNHu
	 cgUecjb8Z6hKFAcSbo59dDvdMlYbBreviqMjB5bRSkayL5GDsF0eV91z0Fzj5KDoKrP7t
	 oMbwhQCAHOOlJR2vhQVXG3+trcwg2qR4yqmVIwn5winJiYDSdbjSfXYO3FIcfIBJ9zqdi
	 T8XRzH+K6CbiyTYndSju2tUfphBXwBlJDAc5jCRy1Vl6dsFOKqGFu9dH+B+rxryKEDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795769065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ft75ArHu5r34Kk5GxNfYciluJYRTvCnqrrb0D3xZQgQ=;
	b=NSrHFkZ2zlS/d/iVyRnVI9hlASIUfhpaWNb/zr1x/eG1i771ztOS3c3KcHP22/jshWUT
	 V4IR5+e11TIUhNpojMcqa6/IWALE4r0qU9UrdWdbJkZaLWbbtgihkWDXyXTW9TQWTR08K
	 QRmnPcjIDrA67KwZ98If22TzcuEpBjOQh9bm/Ab+/s+laMDFylJvuH0lbuPR0l28ClxMd
	 obRhaqrNDpgB4OuD9eAovo6qCx3n5eUhWWpZ14GWJHCztkDCYT07i5YxokT13ZG1F4crV
	 qVKcxTx96ThCFdxNfwWWwNUrZncCTXZX7aY8sLNIqlUEP2lzyUh3i++oDewwv2/C8Fw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795769065;
	bh=ft75ArHu5r34Kk5GxNfYciluJYRTvCnqrrb0D3xZQgQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=uvD3GBiQgiCwEt11pZbel1BDwv2QpOrSCLu7xSBJGKZStjv0MecBQDECyxgDvNG7q
	 xCkYnLipWGtmIZyoHFjwFsoVu1iGk2cvwhGbSa8vcA4Vsypx1bQYk3rdLG8FcvscHq
	 e+3ppy03LuAcGBgr/mcgUqlmwDpxcGoVYCNfE0mgXyPYHJV6waCHOAE1LgAIzIlVeP
	 O0Oi357kg9Oh4vM4McQYYkL57tHacCZ+N9157ngmOuQamsKi+FIUTkol5EvFJTKRLi
	 SKmhNU2fFLq/17RcL/3TFGC1Gt1rTIJRuNI50oHmVlx+shqzVTVoGNMlrFWaB00z8e
	 nDfhl1u6c8YwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D5FB60AC4;
	Fri, 27 Nov 2026 08:44:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D43843C0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B76794087C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lDfGHeURC0D for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 08:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7579040873
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+tkusters.aweta.nl@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hWW1WySc
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7579040873
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 08:44:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B0D460F33;
 Fri, 27 Nov 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 903BC1F00899;
 Fri, 27 Nov 2026 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795769059;
 bh=ft75ArHu5r34Kk5GxNfYciluJYRTvCnqrrb0D3xZQgQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=hWW1WySc7+j/cSN/syzUfzn2F355NkIJXfTkO3SuE0Aje7YWwmBkdq0NnutSuqKl6
 Zw7tApTdHPJ5mUy4yQftBai5I9PzC9xKtdxuSb5FLGERPMw5MBzBjWKVpK1c/PjnjO
 8RJB/BQPPsGwpfx6XIBvYngn1yHs0cdH7hc+Qo28H/sA7qW9NZUtY6PaJBScMssTCT
 jccOOasYeSq1usd+eUokPUF4E4qXGrXFwYiEkyxNtCTJg29uB7QSl21IXXbDTU4Da7
 91Scwmdn0l1UTQjEtVW9AC8Yi38LX2ru+uE0mv50xUb9UUy5yn2iXrYsPQ3lk9eP7e
 xUWpItORdzzEw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1CD6B4B63D;
 Fri, 27 Nov 2026 08:44:03 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Fri, 27 Nov 2026 09:43:59 +0100
Subject: [PATCH net] igb: leave room for the Rx timestamp header in 2 KiB
 build_skb buffers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-igb-skb-pad-v1-1-7e069eaf16d7@aweta.nl>
X-B4-Tracking: v=1; b=H4sIAM5CCWsC/yWMwQrCMBAFf6W8cxeSgFH7K+Ihada6FmLJVhFK/
 72xPc7AzALlIqzomgWFv6LyzhVs26B/hjwwSaoMZ5y31p1Jhkg6RppCoku6eg4meDYn1GIq/JD
 ffrsh84z7IfUTX9zP/w/WdQMLR1Z2dAAAAA==
X-Change-ID: 20261127-igb-skb-pad-8d96ea0a6e05
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Sven Auhagen <sven.auhagen@voleatech.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, stable@vger.kernel.org, 
 Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795769042; l=7109;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=LHZjkEOidXK7kx+tT6vj/G3tkhiPxIUoim+0JCqFf24=;
 b=AEkgnroG0gFyvAxAf2gDtHDf0wW2hJiBZV8LFjagw2b1mNptyxATLN3Htuf4uOhCZNK1fOU1e
 ipDBqw2GDHqAhCAz9ML1zYapEPSHFJVzaKpQXXJQtNZE9v4CGCfgbmN
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Content-Transfer-Encoding: 7bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Reply-To: tkusters@aweta.nl
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tjerk Kusters <tkusters@aweta.nl>

On 2 KiB build_skb Rx rings (PAGE_SIZE < 8192, legacy-rx off),
igb_skb_pad() places the DMA start so that exactly
IGB_MAX_FRAME_BUILD_SKB bytes (1536 on x86_64) are left before
skb_shared_info, and RLPML, or the PF pool limit in VMOLR when VFs are
allocated, is set to the same value. With Rx timestamping on, 82580 and
later MACs write a 16-byte timestamp header in front of the frame, so a
frame of more than 1520 bytes (without FCS) runs into skb_shared_info.
napi_build_skb() then zeroes the start of skb_shared_info, which holds
the last bytes of the frame, and __skb_put() moves skb->tail past
skb->end.

The MAC has checked the TCP or UDP checksum before that, so the payload
is delivered with its last bytes zeroed and without an error. Any
sender on the link can trigger this with frames of 1525 to 1536 bytes on
the wire, for example double-tagged frames or a peer with a larger MTU.
Any Rx timestamp filter is enough, as these MACs then timestamp all
packets. With XDP_TX, or XDP_REDIRECT to a device or CPU map,
xdp_update_frame_from_buff() hits the "missing reserved tailroom" WARN
for each such frame and drops it.

Before commit 9cbc948b5a20 ("igb: add XDP support"),
IGB_MAX_FRAME_BUILD_SKB left room for the header. That commit fixed the
frame size at 1536 bytes and gave the rest of the 2 KiB buffer to the
headroom. Reserve the header again in igb_skb_pad(). IGB_SKB_PAD is the
same for all build_skb rings, so the headroom goes from 192 to 176 bytes
on x86_64 for 2 KiB and for 3 KiB rings, and XDP programs have 16 bytes
less for bpf_xdp_adjust_head() and metadata. It was already below
XDP_PACKET_HEADROOM. The frame limit, the buffer size selection and the
MTU range for XDP do not change. IGB_2K_TOO_SMALL_WITH_PADDING already
counts the header, so the headroom stays at least NET_SKB_PAD.

That commit also took the header out of igb_rx_bufsz(), which is the
length of the DMA sync when a buffer goes to the hardware. Add
igb_rx_dma_len() for the two syncs. igb_rx_bufsz() itself stays as it
is, because it is also the frame size limit for XDP.

Tested on an I350 with kernel 7.3.1 (igb in net is the same apart from
the treewide kmalloc_obj conversions) at MTU 1500, with the Rx timestamp
filter set to ALL. A peer sent UDP datagrams of 0xff bytes in frames of
1521 to 1532 bytes (without FCS). Before this patch they were delivered
with their last 1 to 12 bytes zeroed, starting 1520 bytes into the
frame, and pings with a 0xff pattern of those sizes failed. With this
patch all of them arrive intact, also with an XDP program attached.
Frames of 1533 bytes and more are dropped by the MAC, as before. With
the timestamp filter off, and at MTU 3000 (3 KiB rings), nothing
changes. Frames that a VF sends to the PF, of up to 1536 bytes, arrive
intact with and without this patch; the MAC does not put the header in
front of them.

This was found by the Sashiko AI review of another igb series.

Link: https://lore.kernel.org/all/179551973551.3135.7270095499525377709@kernel.org/
Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
The Sashiko AI review reported this on v4 to v7 of my igb Rx timestamp
series; it is older than that series. Most recently:
https://lore.kernel.org/all/179551973551.3135.7270095499525377709@kernel.org/

This patch is independent of that series and applies on its own.

At MTU 1500, iperf3 TCP and UDP from a peer run at line rate (938 and
950 Mbit/s) with and without this patch, with the Rx timestamp filter
off and on, and the receiver's CPU load does not change measurably
(6 runs of 10 s per case, the differences are within the spread).

The patch and its description were prepared with the help of an AI
coding assistant (Claude). I reviewed them and ran the tests described in
the commit message on my test bench.
---
 drivers/net/ethernet/intel/igb/igb.h      | 21 +++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_main.c |  4 ++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 8c9b02058cec..74e441a140c1 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -153,9 +153,9 @@ struct vf_mac_filter {
 
 /* Attempt to maximize the headroom available for incoming frames.  We
  * use a 2K buffer for receives and need 1536/1534 to store the data for
- * the frame.  This leaves us with 512 bytes of room.  From that we need
- * to deduct the space needed for the shared info and the padding needed
- * to IP align the frame.
+ * the frame, plus IGB_TS_HDR_LEN for the timestamp the hardware can place
+ * in front of it.  From the rest we need to deduct the space needed for
+ * the shared info and the padding needed to IP align the frame.
  *
  * Note: For cache line sizes 256 or larger this value is going to end
  *	 up negative.  In these cases we should fall back to the 3K
@@ -190,7 +190,7 @@ static inline int igb_skb_pad(void)
 	if (IGB_2K_TOO_SMALL_WITH_PADDING)
 		rx_buf_len = IGB_RXBUFFER_3072 + SKB_DATA_ALIGN(NET_IP_ALIGN);
 	else
-		rx_buf_len = IGB_RXBUFFER_1536;
+		rx_buf_len = IGB_RXBUFFER_1536 + IGB_TS_HDR_LEN;
 
 	/* if needed make room for NET_IP_ALIGN */
 	rx_buf_len -= NET_IP_ALIGN;
@@ -421,6 +421,19 @@ static inline unsigned int igb_rx_bufsz(struct igb_ring *ring)
 	return IGB_RXBUFFER_2048;
 }
 
+/* Number of bytes the hardware can write to an Rx buffer. On 2K build_skb
+ * rings the frame is limited to IGB_MAX_FRAME_BUILD_SKB, and the timestamp
+ * header comes in front of it.
+ */
+static inline unsigned int igb_rx_dma_len(struct igb_ring *ring)
+{
+#if (PAGE_SIZE < 8192)
+	if (ring_uses_build_skb(ring) && !ring_uses_large_buffer(ring))
+		return IGB_MAX_FRAME_BUILD_SKB + IGB_TS_HDR_LEN;
+#endif
+	return igb_rx_bufsz(ring);
+}
+
 static inline unsigned int igb_rx_pg_order(struct igb_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 131df3e09ba1..67fd24d71746 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5084,7 +5084,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
 		dma_sync_single_range_for_cpu(rx_ring->dev,
 					      buffer_info->dma,
 					      buffer_info->page_offset,
-					      igb_rx_bufsz(rx_ring),
+					      igb_rx_dma_len(rx_ring),
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
@@ -9225,7 +9225,7 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
 	bi = &rx_ring->rx_buffer_info[i];
 	i -= rx_ring->count;
 
-	bufsz = igb_rx_bufsz(rx_ring);
+	bufsz = igb_rx_dma_len(rx_ring);
 
 	do {
 		if (!igb_alloc_mapped_page(rx_ring, bi))

---
base-commit: cc7fe6e741730fef549e484379281736d32746f0
change-id: 20261127-igb-skb-pad-8d96ea0a6e05

Best regards,
--  
Tjerk Kusters <tkusters@aweta.nl>


