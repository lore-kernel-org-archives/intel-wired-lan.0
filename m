Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A59BCD4F24
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 May 2026 17:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBDEE60DAA;
	Tue, 12 May 2026 17:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cD0ntCIR_qZw; Tue, 12 May 2026 17:23:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D90B760DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778606581;
	bh=vBLaLy9cz7siWYOspXYDH6TBQZgbRZIgkLsPqUvuuZY=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2fIAsJ4QQgVGYYGdm/0LaP/nN9tIvSXjPlk5C2QORs6CV6CbKtBq9WB+J/evyUwSO
	 j7HEnCUicNd3r6/sb2h4TWRPacG3fcAbAHWRuPjDIgcw1gx8RVeipue71IeiBjb77N
	 PB/65KysXEJWgFgc7XCBwU5PwwmBU92bmiBhIr62uBSQu6CXkWm14+cvoP5F+1+E86
	 2woI1nyF5EWfcKmQSRumGDqEpRYbx1HAUd6K77yXKVpRuMXisnqS+aEATubJFaZ0FE
	 QmaQacJCQHqtq/S6KOyhLdkPt2wPwIY3ofSc93NFA3GT9uW8bl6crgTrzygrZRRlNq
	 FZoD/ii+2WVBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D90B760DC3;
	Tue, 12 May 2026 17:23:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAB9A398
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 15:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B915140E97
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 15:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8emdA7L-8TTI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 May 2026 15:27:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=lorenz@monogon.tech; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0FB3040DC8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FB3040DC8
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FB3040DC8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 15:27:02 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso4646771f8f.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599621; x=1779204421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBLaLy9cz7siWYOspXYDH6TBQZgbRZIgkLsPqUvuuZY=;
 b=kXyoeauvWm/V/CIocgO/NNm1iujM5qUnmcWe6A1VpvsvKjv/nZEyjPBB0JGYpiBX1y
 6/uQuUuyUOQVO2uU/DXUyKMZzMGka1edRORORd2/LJFPOBAhTizqUvszTDqQyk1ygQWM
 uhIEMAg135xUvGRTY4pRGQ+amCxGYbjFPBKFlcUliEW1+IbljtFN3SR/3r3YofZkkxne
 Mt6VU3TuFnPHhM+SxuoIn/oc86ja2fSspS70rw66kQ5L9cSPTtSX9491QibCQIXjhwb1
 Ot5/U2p7/DipdqTfIw71NjGbBfBYf1Btq+CCOwdc2r5bfIZDxpeJpcO4oDexEdDqkVYd
 QMmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EeMj9iv+6uP8+RbQbd71jUYadAtz5cQFNvNPZgOZAEInBtUZCNcWayOta+cLFpzw+ApoY9eKs3+MTijKB8cU=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxiJMrubm4cd6BkX+hu43k0yRswfRhnqqkQcTAXv1MgwY+Z/HGx
 cnpfK6ubWAP87WzFnDqGcPOxo8vkUD3S4Sl8nR9XVKEOlw4luLJP3/PAxSn5bwdrAEs=
X-Gm-Gg: Acq92OEAYzpwnmSGzCwE5Sv6SFFIFzQkxf+4rN1DmSjZ0nmVEWBbTq84xt8osvEgv2F
 1yUeYcC+said/uOrlb9D5bj8mudpsdwHTocaAI3TC6neTB7C8zOzWihGjiZESCaxod6ev1pe9xF
 ZweduyedDfxcJBaB2fvQWmUIOERcbDagt0KBLUeO/QJAk2dUJfwNlZ9XikaSUi8nZGsFwEcDGM2
 M17NUeh+KlAinbdWvLRERp6Ksojj7Y1MMce45GymC1/fLLKL4nfMUa51UIZSaPg/kfZ4EEzLwOb
 DeCf7ecvIPl5td+vNAECAnXVw3Fs3YvD0hcAJiKJvieFS/lw/PwIMo0q6sNCFoEPqaJP7UPOCT1
 E6dlF8l68NuSzAa6VjwvlT6pjMcblwn+gamcf7HuN3HtEfk+TvIYDuuUrhD9t60crP01jeo4Wwf
 ScjoSAoDG+ZcYyacSytWSyIBO3E3mdpvLkb3aRLxCSzA==
X-Received: by 2002:a05:6000:611:b0:44a:247e:67b4 with SMTP id
 ffacd0b85a97d-4515b9f31camr45918391f8f.18.1778599620798; 
 Tue, 12 May 2026 08:27:00 -0700 (PDT)
Received: from localhost ([213.239.141.92])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45491304505sm33531123f8f.22.2026.05.12.08.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:27:00 -0700 (PDT)
From: Lorenz Brun <lorenz@monogon.tech>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 12 May 2026 17:26:56 +0200
Message-ID: <20260512152658.2818805-1-lorenz@monogon.tech>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 May 2026 17:23:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monogon-tech.20251104.gappssmtp.com; s=20251104; t=1778599621; x=1779204421;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vBLaLy9cz7siWYOspXYDH6TBQZgbRZIgkLsPqUvuuZY=;
 b=IyqTXriDzf7bMEt8SSNJfYYzoV8wQqbZTwJNZhz0M/AQmwnbgD8KQMkopDvxeuMjXu
 ewSoUqHngF3SSCxLlqWwRNQLvJTIf/ei+dJYk6Hi/5LekX8QV925W7T/+H3ocTjQH93o
 uIDetBP35F8iGhH8xGnI7WhdkeAOAZyRFYnrAUWJ9irfLgqyzin275V2FhmRs1PNAcCn
 bdSbiovw3ZTB/7sy/aEJpdnLQwcn4d6TM+2maTP6JjGOkCBgFx40OdX1d2ujMAwDBhd1
 N9BTr+Rhqs3NnxjhVoJ9eVT9+0+iltvGoZWj5HEP8RK/x8kIhZTLiaQziSuKcWfTrmsW
 SfYg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=monogon.tech
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=monogon-tech.20251104.gappssmtp.com
 header.i=@monogon-tech.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IyqTXriD
Subject: [Intel-wired-lan] [PATCH] xsk: switch xdp_build_skb_from_zc() to
 napi_alloc_skb()
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

xdp_build_skb_from_zc() allocated xdp->frame_sz bytes from the per-cpu
system_page_pool and built the skb head with napi_build_skb(). The
latter places skb_shared_info at the tail of the buffer, but the
helper sized the allocation as if the whole frame_sz were usable for
data. Whenever the packet plus reserved headroom approached frame_sz,
the head memcpy overran shinfo with packet content, corrupting
->flags (SKBFL_ZEROCOPY_ENABLE) and ->nr_frags, which then drove
skb_copy_ubufs() off the end of frags[] on the RX path:

  UBSAN: array-index-out-of-bounds in include/linux/skbuff.h:2541
  index 113 is out of range for type 'skb_frag_t [17]'
   skb_copy_ubufs+0x7da/0x960
   ip_local_deliver_finish+0xcd/0x110
   ice_napi_poll+0xe4/0x2a0 [ice]

The overrun bytes come from the packet, so an on-wire sender can
corrupt kernel memory remotely whenever the XDP program returns
XDP_PASS.

Rather than patch the sizing math, switch to the pattern used by other
in-tree AF_XDP zero-copy drivers like mlx5 and i40e which use
napi_alloc_skb() sized to the actual packet plus skb_put_data().
This sizes the head exactly for the data being copied, drops the
system_page_pool local_lock from this path, and removes the
structural mismatch between frame_sz and the skb head buffer. Frags
are allocated with alloc_page() per frag, matching the other drivers.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c |  2 +-
 include/net/libeth/xsk.h                 |  2 +-
 include/net/xdp.h                        |  3 +-
 net/core/xdp.c                           | 72 ++++++++----------------
 4 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c35..6c01a14fde150 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -653,7 +653,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 
 construct_skb:
 		/* XDP_PASS path */
-		skb = xdp_build_skb_from_zc(first);
+		skb = xdp_build_skb_from_zc(&rx_ring->q_vector->napi, first);
 		if (!skb) {
 			xsk_buff_free(first);
 			first = NULL;
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 82b5d21aae878..922b4587acd3f 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -468,7 +468,7 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
 	if (act != LIBETH_XDP_PASS)
 		return act != LIBETH_XDP_ABORTED;
 
-	skb = xdp_build_skb_from_zc(&xdp->base);
+	skb = xdp_build_skb_from_zc(napi, &xdp->base);
 	if (unlikely(!skb)) {
 		libeth_xsk_buff_free_slow(xdp);
 		return true;
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c358..fb2452243fd36 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -375,7 +375,8 @@ void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
 struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
-struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
+struct sk_buff *xdp_build_skb_from_zc(struct napi_struct *napi,
+				      struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..54005b64e6cbb 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -677,16 +677,14 @@ EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
  * @skb: skb to copy frags to
  * @xdp: XSk &xdp_buff from which the frags will be copied
- * @pp: &page_pool backing page allocation, if available
  *
  * Copy all frags from XSk &xdp_buff to the skb to pass it up the stack.
- * Allocate a new buffer for each frag, copy it and attach to the skb.
+ * Allocate a new page for each frag, copy it and attach to the skb.
  *
- * Return: true on success, false on netmem allocation fail.
+ * Return: true on success, false on page allocation fail.
  */
 static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
-					    const struct xdp_buff *xdp,
-					    struct page_pool *pp)
+					    const struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = skb_shinfo(skb);
 	const struct skb_shared_info *xinfo;
@@ -699,20 +697,18 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 	for (u32 i = 0; i < nr_frags; i++) {
 		const skb_frag_t *frag = &xinfo->frags[i];
 		u32 len = skb_frag_size(frag);
-		u32 offset, truesize = len;
 		struct page *page;
 
-		page = page_pool_dev_alloc(pp, &offset, &truesize);
+		page = alloc_page(GFP_ATOMIC | __GFP_NOWARN);
 		if (unlikely(!page)) {
 			sinfo->nr_frags = i;
 			return false;
 		}
 
-		memcpy(page_address(page) + offset, skb_frag_address(frag),
-		       LARGEST_ALIGN(len));
-		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
+		memcpy(page_address(page), skb_frag_address(frag), len);
+		__skb_fill_page_desc_noacc(sinfo, i, page, 0, len);
 
-		tsize += truesize;
+		tsize += PAGE_SIZE;
 		if (page_is_pfmemalloc(page))
 			flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 	}
@@ -725,49 +721,34 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 
 /**
  * xdp_build_skb_from_zc - create an skb from XSk &xdp_buff
+ * @napi: NAPI instance the buffer was received on (provides the skb cache)
  * @xdp: source XSk buff
  *
  * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb
- * head, new buffer for the head, copy the data and initialize the skb fields.
- * If there are frags, allocate new buffers for them and copy.
- * Buffers are allocated from the system percpu pools to try recycling them.
- * If new skb was built successfully, @xdp is returned to XSk pool's freelist.
- * On error, it remains untouched and the caller must take care of this.
+ * sized to the packet from the NAPI cache, copy the head data, and copy
+ * any frags into freshly allocated pages.
+ *
+ * If a new skb was built successfully, @xdp is returned to the XSk pool's
+ * freelist. On error, it remains untouched and the caller must take care
+ * of this.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
+struct sk_buff *xdp_build_skb_from_zc(struct napi_struct *napi,
+				      struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
-	u32 len = xdp->data_end - xdp->data_meta;
-	u32 truesize = xdp->frame_sz;
-	struct sk_buff *skb = NULL;
-	struct page_pool *pp;
-	int metalen;
-	void *data;
+	u32 totallen = xdp->data_end - xdp->data_meta;
+	u32 metalen = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
 
-	if (!IS_ENABLED(CONFIG_PAGE_POOL))
+	skb = napi_alloc_skb(napi, totallen);
+	if (unlikely(!skb))
 		return NULL;
 
-	local_lock_nested_bh(&system_page_pool.bh_lock);
-	pp = this_cpu_read(system_page_pool.pool);
-	data = page_pool_dev_alloc_va(pp, &truesize);
-	if (unlikely(!data))
-		goto out;
-
-	skb = napi_build_skb(data, truesize);
-	if (unlikely(!skb)) {
-		page_pool_free_va(pp, data, true);
-		goto out;
-	}
-
-	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_put_data(skb, xdp->data_meta, totallen);
 
-	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
-
-	metalen = xdp->data - xdp->data_meta;
-	if (metalen > 0) {
+	if (metalen) {
 		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
 	}
@@ -775,18 +756,15 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 	skb_record_rx_queue(skb, rxq->queue_index);
 
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
-	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
+	    unlikely(!xdp_copy_frags_from_zc(skb, xdp))) {
 		napi_consume_skb(skb, true);
-		skb = NULL;
-		goto out;
+		return NULL;
 	}
 
 	xsk_buff_free(xdp);
 
 	skb->protocol = eth_type_trans(skb, rxq->dev);
 
-out:
-	local_unlock_nested_bh(&system_page_pool.bh_lock);
 	return skb;
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
-- 
2.51.2

