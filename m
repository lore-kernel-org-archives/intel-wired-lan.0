Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48008606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JCTT6XTp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRMnFxpA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25BF340A69;
	Fri, 27 Nov 2026 14:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hbff6EDOguMQ; Fri, 27 Nov 2026 14:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D13140A70
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795789321;
	b=MB4TzPjjaytJHacZC0Ejt/hoPty7pcF7LMt0Tme/zzoBjDIlaiGCml/Yj1vaRe+ae6P7
	 t7+l1TYuS3YwFDusy40IwpI/EsYKNBY44fwEtBu8XAbz3I1FMQ0zKzK0I6XwTMCYeTct6
	 ZDsTXW8ChJqfr1wuJa9Ebt2giukrE8H/MzIGLXFJMyLZZGTkHRLLuGxyE/RDywGQterwR
	 HBFskjjcqRCvcnnTbkqQXmcU9mUDzoEkVi8L7nLbp8Pdh0GEZsGZI8xbJ/105J2jNqGeL
	 M0iIv7xgAPL9J6Dr1YQFtzleGyypR6x2cSPNo+a6qnmBjzr83/FQFLL+pUr3siBci/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795789321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V0f8oQgjyKo9koJqx3c0nxz2UuKdlWqooCmOKh4COcg=;
	b=siuxgYjwrhUonN8eYE989K7x/JC6XYMBY1FoWbCmzqV0ptALHuwIRSZ0tzLfzNIfXr8t
	 7TgtiWpd3SDzijaAYm+hKhbTrvqy8rI6yFIvVaP75nY7WJKOsQBTufrrU0OJlcsAyY7WY
	 q/j7roM4U2vvxoBEcECw0mmMsUypfBLFM+gAdZ6Y3w+T2FAe24j31VUiumREPp9InI1pW
	 V3p4K3QfMU4TaJ//DWuD2Fzs558Sm6t9bOTKC1iROPA3keH93wukF4lIbueMlBYnTqjpD
	 FqkWH6vih67tJ+gxEr2g4U501Rvho9gBsSGFZ1T43gTLbSJyYGoKn2mVnBQMpGYpOrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRMnFxpA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795789321;
	bh=V0f8oQgjyKo9koJqx3c0nxz2UuKdlWqooCmOKh4COcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCTT6XTp2u9KmROHgBNIDReiKu4BxjEiovVXLHga7LO0lQDvFEhO49xXdI0ihifAe
	 M8AxuYUEamsIErdaK82egbYCNv1z6RUkVW5Fd7fBbjeDi7W56WaKL6CT6v3YTxvVUe
	 jt7oQSTnQ7HVS6ZMapRGfnoGGIT16H0HLdTDCn5GAiaT+JNYE7sz5cXH4cEObc0pHc
	 7nO7Xk9vGL0LtoJ0OLKL3OkdRRtDCCMkP1EiuaXaKpWFLP73e9SY+91ZNTPLhfCN47
	 P15vgpdXt1pWqU1EzQbj+C481jtoBc8ykBhMaKySi49Vmh0zni63M3WUmKBaGl3UOi
	 l0BUx0KwWTkjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D13140A70;
	Fri, 27 Nov 2026 14:22:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B46E8D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9ABB840A70
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5nG_CiKECMX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 14:21:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B492540A69
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bjorn@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=PRMnFxpA
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B492540A69
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D4DB4033A;
 Fri, 27 Nov 2026 14:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC761F000C1;
 Fri, 27 Nov 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789318;
 bh=V0f8oQgjyKo9koJqx3c0nxz2UuKdlWqooCmOKh4COcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PRMnFxpAl9rdD7GDhumW5o/0IExtKvyRvuUxGc0NmYejIzk258xQYlY7djROMm1Fp
 mJhlfLml/NCEPedFiRdgf72XQ8ae6G5fTl3DjVnpw597rZ/kyd8TBw7ByryFAUoudp
 fO7FgFq+2Xus15G51tWTSmWo5V8FN+i7VnB0g5gUaAzdUQk0KYcggmPyB8GEVHiZVD
 8hLNzihxU4u7C0LnlspUFHiVqhcSD2yEpT2tktDpAhaLAxMvUviKXlzfnkx/0IYEPR
 93qlzNLwyBru/RDHKQeyBiT+n0+TFWeh7R6uuwwmqk5tFuU8LBYwEQkfbwNU4+IYBq
 MsvL5X0C87CgQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/3] xsk: Keep the shared info of zero-copy buffers in
 kernel memory
Date: Fri, 27 Nov 2026 15:21:28 +0100
Message-ID: <20261127142131.3527737-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127142131.3527737-1-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A packet that a driver receives in zero-copy mode over several buffers
keeps its shared info, the fragment list and its count, in the
tailroom of the UMEM chunk of its head. Userspace may write the UMEM
at any time, also while the kernel walks the fragments, and a
rewritten list or count makes the kernel read and write out of bounds.

Keep the shared info in the buffer pool, which outlives its buffers
and the queues that point to it, and let the device write up to the
end of the chunk. One shared info per pool is enough, as a pool builds
one multi-buffer packet at a time. libeth read it later, at an XDP_TX
bulk flush, which the previous patch fixes.

Multi-buffer pools now give the device the whole chunk, as
single-buffer pools already do, and allow a larger UMEM headroom.
bpf_xdp_adjust_tail() can grow a packet up to the end of its chunk.
Copy mode does not change.

Found by an AI code review agent, in its review of another series.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xdp.h           | 32 ++++++++++++++++++++++++++------
 include/net/xdp_sock_drv.h  | 29 +++++++++--------------------
 include/net/xsk_buff_pool.h |  2 ++
 net/xdp/xdp_umem.c          |  3 +--
 net/xdp/xsk_buff_pool.c     | 17 +++++++++--------
 5 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..68dc9caacfa9 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -65,6 +65,10 @@ struct xdp_rxq_info {
 	u32 reg_state;
 	struct xdp_mem_info mem;
 	u32 frag_size;
+	/* Shared info of buffers with %XDP_FLAGS_SINFO_EXT, in the XSk buffer
+	 * pool, set by xsk_pool_set_rxq_info().
+	 */
+	struct skb_shared_info *ext_sinfo;
 } ____cacheline_aligned; /* perf critical, avoid false-sharing */
 
 struct xdp_txq_info {
@@ -81,6 +85,13 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* The shared info lives in &xdp_rxq_info.ext_sinfo, not at the end of
+	 * the frame, as userspace may write the frame. The frame reserves no
+	 * tailroom, so the data may reach its end. The pool builds one such
+	 * buffer at a time, so a consumer that uses the shared info later
+	 * must copy what it needs.
+	 */
+	XDP_FLAGS_SINFO_EXT		= BIT(3),
 };
 
 struct xdp_buff {
@@ -178,17 +189,26 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 
 /* Reserve memory area at end-of data area.
  *
- * This macro reserves tailroom in the XDP buffer by limiting the
- * XDP/BPF data access to data_hard_end.  Notice same area (and size)
- * is used for XDP_PASS, when constructing the SKB via build_skb().
+ * This reserves tailroom in the XDP buffer by limiting the XDP/BPF data
+ * access to data_hard_end.  Notice same area (and size) is used for
+ * XDP_PASS, when constructing the SKB via build_skb(). Buffers with
+ * %XDP_FLAGS_SINFO_EXT keep the shared info elsewhere and reserve none.
  */
-#define xdp_data_hard_end(xdp)				\
-	((xdp)->data_hard_start + (xdp)->frame_sz -	\
-	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+static __always_inline void *xdp_data_hard_end(const struct xdp_buff *xdp)
+{
+	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
+		tailroom = 0;
+	return xdp->data_hard_start + xdp->frame_sz - tailroom;
+}
 
 static inline struct skb_shared_info *
 xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
 {
+	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
+		return xdp->rxq->ext_sinfo;
+
 	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
 }
 
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index a40ad3f90f13..fc22314e72c4 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -41,11 +41,6 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return XDP_PACKET_HEADROOM + pool->headroom;
 }
 
-static inline u32 xsk_pool_get_tailroom(bool mbuf)
-{
-	return mbuf ? SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) : 0;
-}
-
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
@@ -56,20 +51,13 @@ static inline u32 __xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
 }
 
+/* Device RX buffers typically come in 128-byte units. The shared info
+ * of zero-copy buffers lives in the pool, see xp_set_rxq_info(), so the
+ * device may write up to the end of the chunk.
+ */
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
-	u32 frame_size =  __xsk_pool_get_rx_frame_size(pool);
-	struct xdp_umem *umem = pool->umem;
-	bool mbuf;
-
-	/* Reserve tailroom only for zero-copy pools that opted into
-	 * multi-buffer. The reserved area is used for skb_shared_info,
-	 * matching the XDP core's xdp_data_hard_end() layout.
-	 */
-	mbuf = pool->dev && (umem->flags & XDP_UMEM_SG_FLAG);
-	frame_size -= xsk_pool_get_tailroom(mbuf);
-
-	return ALIGN_DOWN(frame_size, 128);
+	return ALIGN_DOWN(__xsk_pool_get_rx_frame_size(pool), 128);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
@@ -152,7 +140,6 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 		xp_free(pos);
 	}
 
-	xdp_get_shared_info_from_buff(xdp)->nr_frags = 0;
 	xdp_buff_clear_frags_flag(xdp);
 out:
 	xp_free(xskb);
@@ -226,8 +213,10 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
 	xdp->data_meta = xdp->data;
 	xdp->data_end = xdp->data + size;
-	/* Frags flag is cleared when the frags of a head are released */
-	xdp->flags &= XDP_FLAGS_HAS_FRAGS;
+	/* Frags flag is cleared when the frags of a head are released. The
+	 * shared info flag stays, see xp_set_rxq_info().
+	 */
+	xdp->flags &= XDP_FLAGS_HAS_FRAGS | XDP_FLAGS_SINFO_EXT;
 }
 
 static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 02e89350faf9..f43e618ae707 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -59,6 +59,8 @@ struct xsk_buff_pool {
 	spinlock_t rx_lock;
 	struct list_head free_list;
 	struct list_head xskb_list;
+	/* Fragment list of the packet being built, out of userspace reach */
+	struct skb_shared_info sinfo;
 	u32 heads_cnt;
 	u16 queue_id;
 
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index cd8643360eb3..e78a43c3c3e9 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -203,8 +203,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (!unaligned_chunks && chunks_rem)
 		return -EINVAL;
 
-	if (headroom > chunk_size - XDP_PACKET_HEADROOM -
-		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - 128)
+	if (headroom > chunk_size - XDP_PACKET_HEADROOM - 128)
 		return -EINVAL;
 
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 5ec092f7cb6f..553630170229 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -125,8 +125,14 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
 {
 	u32 i;
 
-	for (i = 0; i < pool->heads_cnt; i++)
+	/* Userspace may write the UMEM. Keep the shared info in the pool,
+	 * and let the device write up to the end of each chunk.
+	 */
+	for (i = 0; i < pool->heads_cnt; i++) {
 		pool->heads[i].xdp.rxq = rxq;
+		pool->heads[i].xdp.flags |= XDP_FLAGS_SINFO_EXT;
+	}
+	rxq->ext_sinfo = &pool->sinfo;
 }
 EXPORT_SYMBOL(xp_set_rxq_info);
 
@@ -229,12 +235,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		segs = 1;
 	}
 
-	/* open-code xsk_pool_get_rx_frame_size() as pool->dev is not
-	 * set yet at this point; we are before getting down to driver
-	 */
-	frame_size = __xsk_pool_get_rx_frame_size(pool) -
-		     xsk_pool_get_tailroom(mbuf);
-	frame_size = ALIGN_DOWN(frame_size, 128);
+	frame_size = xsk_pool_get_rx_frame_size(pool);
 
 	if (needed > frame_size * segs) {
 		err = -EINVAL;
@@ -629,7 +630,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
 	xskb->xdp.data_meta = xskb->xdp.data;
-	xskb->xdp.flags &= XDP_FLAGS_HAS_FRAGS;
+	xskb->xdp.flags &= XDP_FLAGS_HAS_FRAGS | XDP_FLAGS_SINFO_EXT;
 
 	if (pool->dev)
 		xp_dma_sync_for_device(pool, xskb->dma, pool->frame_len);
-- 
2.56.1

