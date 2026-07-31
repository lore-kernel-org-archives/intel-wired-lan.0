Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F80BC54F54
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3BD141109;
	Fri, 31 Jul 2026 12:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vB6fdJtSAvLF; Fri, 31 Jul 2026 12:49:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DA1D41115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785502188;
	bh=OMT9YR+Z2gS6Eh7vbnulZB5ih8XO9hWY1MpWR6T+nYA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/XqKYwf35sUVeWpw8UojIfWUVfiSOXWJh5d/62DFt35r/dJFrOG975Nq/DnwYT23
	 yQSiOzGZd07MTxkDfVFtkTmAmPUX29C8/5FzK2aVnM9vuBtns7LewhhdUiEV6hZsN3
	 kdhLjHUJCaVjZ1ZT8rOFlL9mY0+RbyWTWGrZ14hntlAj791nUcQJ6giFdSU8WQDTsk
	 BI0HaXe9SA/zg1oJMuQONbDp42Dnmje43vkuk60kYjDNQfQ/wJ7/zRH7OfyDBcikgj
	 Fc7/uym5oM6Emcm4Qsd7qDE6rc5VfIfmMEMKtV9VfRMvqeKk/3NjD3aKcsdAPRZlfL
	 19eLdDKYSCsug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DA1D41115;
	Fri, 31 Jul 2026 12:49:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 311A237F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2384880CA7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnVlZD9MHCTC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 12:49:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 48CCD80C76
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48CCD80C76
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48CCD80C76
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:49:45 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66804667af2so654145d50.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 05:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502184; x=1786106984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OMT9YR+Z2gS6Eh7vbnulZB5ih8XO9hWY1MpWR6T+nYA=;
 b=P4fd4qiq/k/mLXRlNFShA81JuK7roujk3ceINIEfaIN3hqE+vnJEMMuOJK0Q1Ypi0V
 JpTjFrNabZdAmS/7cUgRcnsOUw6sWtPtdSssxbmYC2Stt4m+x3t4zCdR4mW8IEFa5VHV
 b/gnD3hAylVGSyu0UrPLY4ntwnsV/p1JkMw7Fp5RMP0qX49dIBKyUQZFAsF5KRvy6La8
 0jht6GMmhlmrTIot6BGB9T+zHg8anj1+xhBa+Yh9BVR7fWSaCI9FmQmCqMM4opJWVeze
 PoU3D5uAv60lJE3zfbyjDPaaFHLuJ1BUza0jUPQj1JV7Nnk//lEsfZ6nTu0WaoKRBmrf
 IdCw==
X-Gm-Message-State: AOJu0YzdPI0jgp8/ptLXdbnBpyi5zUyVAQml1XS67YyXpQwZ+txrsP/f
 3ipR8z6I1PGYeEO0dwxCwXReP0M0yMLXvrVriZIjVXeyR+P2In0cl9SBiE28DJ/m
X-Gm-Gg: AR+sD102KbHeis6K+zBBLUUbFu/hDC+AP2r4IktnQfq+coCLjW0HJzHxkhmu7m6iCIc
 QxAscYXout7/JLYNDOkWRINu16g+QjwxzTc8KBFQxcpiGyafgTZ7UpUUyN2EfVsW3aqtWqyM47/
 7Cl58+c6SX+bFaMppY1rxJWTMguCzZyrxjHNlzJ84x5ljjvOvuvRCgx59F8KptJKE5MlQ6z/fbJ
 J34T1FBXHmTFt8aDkBUjjMru/2CajKvUJFx3uCofXDMjWg8776JNDiRf77qDTV95yRLakeeeMHg
 sTvNG8tJLQUgtJ0FySJwc1UwkOswMRK+OCgqWqcIz7w7TmPzAwfUiRvqYjsuvz24OXZaDokSiGs
 lzNXvd4/HGM1spgP1Fw1vI0eieVIOXXUNNL7mEAb7Yn6AfpelZSSiFEEfmSNRkb/IrcWra4AhWq
 sMrOTsIC1eg76a/In4IrWSeKexqMkj9msx+T9ad7w7KBlN4zpb5h/YYs0OKUA7L0s=
X-Received: by 2002:a05:690c:318:b0:81d:c233:aea0 with SMTP id
 00721157ae682-81fcbab8b90mr16379287b3.18.1785502183999; 
 Fri, 31 Jul 2026 05:49:43 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:49:43 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Matt Vollrath <tactii@gmail.com>
Date: Fri, 31 Jul 2026 08:41:09 -0400
Message-ID: <20260731124109.99065-4-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
References: <20260731124109.99065-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785502184; x=1786106984; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMT9YR+Z2gS6Eh7vbnulZB5ih8XO9hWY1MpWR6T+nYA=;
 b=Ik4Z6lg1yLhqWe8Zk09Q+ueHFdf32HmGJk1tIv05MZrWOSua+TIngscMmW13hc401u
 LnSdpDKX5vYGSBIT42t55wl39u8KmmlX8OqFxQQQHprvb6haD7IjgMBwWCz91qCjRk9k
 YB3opANopuyMVXkOJT4VhwfbMOQFrb/EBM/HuKCUJLpqnM4hI5ACFmst2zbnfdhib7do
 845kH4JAo3pUz0NUbpyAlSkONSgV5ihaCGXJRtSohtmZDFWFGtQlb/LROOqhwJqnROPv
 yQsJxCW2VlzSo8XX/6v+Eq3TLO2Y4c1TOsoWMZNKfPZavzUQDTcN4JlyMDg7yBRur1Ca
 eMIA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ik4Z6lg1
Subject: [Intel-wired-lan] [PATCH iwl-next 3/3] iavf: use cached page_pool
 ref in skb helpers
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

Deriving a reference to the page pool from netmem_desc requires loading
the struct. We already have a cached reference to the pool, so use that
instead.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 3ae2f0a0ee4d..9dc5f0761d8b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1184,6 +1184,7 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
 
 /**
  * iavf_add_rx_frag - Add contents of Rx buffer to sk_buff
+ * @pp: page pool the buffer was allocated from
  * @skb: sk_buff to place the data into
  * @rx_buffer: buffer containing page to add
  * @size: packet length from rx_desc
@@ -1193,11 +1194,11 @@ static bool iavf_cleanup_headers(struct iavf_ring *rx_ring, struct sk_buff *skb)
  *
  * The function will then update the page offset.
  **/
-static void iavf_add_rx_frag(struct sk_buff *skb,
+static void iavf_add_rx_frag(const struct page_pool *pp, struct sk_buff *skb,
 			     const struct libeth_fqe *rx_buffer,
 			     unsigned int size)
 {
-	u32 hr = netmem_get_pp(rx_buffer->netmem)->p.offset;
+	u32 hr = pp->p.offset;
 
 	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
 			       rx_buffer->netmem, rx_buffer->offset + hr,
@@ -1206,17 +1207,19 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
 
 /**
  * iavf_build_skb - Build skb around an existing buffer
+ * @pp: page pool the buffer was allocated from
  * @rx_buffer: Rx buffer to pull data from
  * @size: size of buffer to add to skb
  *
  * This function builds an skb around an existing Rx buffer, taking care
  * to set up the skb correctly and avoid any memcpy overhead.
  */
-static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
+static struct sk_buff *iavf_build_skb(const struct page_pool *pp,
+				      const struct libeth_fqe *rx_buffer,
 				      unsigned int size)
 {
 	struct page *buf_page = __netmem_to_page(rx_buffer->netmem);
-	u32 hr = pp_page_to_nmdesc(buf_page)->pp->p.offset;
+	u32 hr = pp->p.offset;
 	struct sk_buff *skb;
 	void *va;
 
@@ -1430,9 +1433,9 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 
 		/* retrieve a buffer from the ring */
 		if (skb)
-			iavf_add_rx_frag(skb, rx_buffer, fields.len);
+			iavf_add_rx_frag(pp, skb, rx_buffer, fields.len);
 		else
-			skb = iavf_build_skb(rx_buffer, fields.len);
+			skb = iavf_build_skb(pp, rx_buffer, fields.len);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-- 
2.43.0

