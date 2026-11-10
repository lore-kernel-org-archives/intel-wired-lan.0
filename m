Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609B606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=OHOIaMBz;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CliO2VxJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91C61811E1;
	Tue, 10 Nov 2026 16:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTLgTZx4ukNH; Tue, 10 Nov 2026 16:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AB3C811ED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329470;
	b=ZsLQFA3td/9LoRxEv6WOteKVRfLsdknjNPfyw0mFW8/i72kh31Ur5A/rP/kI7PpbIVIX
	 CsAD6Gxx+iic1uUDCkFLerzifib+3hiVnHJcJ6z+uxQqI77kBp2W3uNESwrljT3KqQDm1
	 Y/Y9C/ed8JlrbmID1mCmRFa6PHqJ5MRWZ4qoiJZhJPj7lkJuxLPLN7DzTzvTRZr7QKp/S
	 M0eGKKjA/vN/EhiU+0rAJw6GtKq+RHj3oUXV0j4v0uWFiRxHPoMfP6jjcLrlN3GIbMJDV
	 bmWyJMWnWvT/RpVqZh3ZCDzZshMTt1KHp5f3+7nIfP9mgJAWEcq403nxrHBOviGfgIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oKixK7Jwu6TCrx7SV2g9n1KdVg0f5barw8E7pwYTzBI=;
	b=RHvCn1H/kYsy+i1nrVcNzQ8GEZmil41aofVMqVdOKY3v7vP6x+OYFfkt2aS1/ROl+vnW
	 1JOnFwaUKIbRoks4pQmMt9X3xLoWrj0IXb7PG4c4hh4Z2FqXOnJl6SmUqZ8WHUOtrdmQv
	 ed4oO4WQGDnjlQ9GnSdvU7Do5GENtVMfqeSua48G5XU85epw/gYyzuk3D9JQ108Os1BvU
	 QwGpJEuWksHW/F9NOiHCnuxvmuw/9A3X19jqg8opcIGM/njIJXSTSc3QMv/UHgsFMDLwj
	 DGDx2qQIVnUMkHJT/+cZOFd6y9KekdJSpTad8tDlBT2o47+CylP8IdkImQ3t+jOoh/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329470;
	bh=oKixK7Jwu6TCrx7SV2g9n1KdVg0f5barw8E7pwYTzBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHOIaMBzpTvk3Ojfv3ToHFUVRgFYefmxodY4ZR2N+0FYE684sAZIN0nqcy7CT/lgd
	 w4+I1+XIQrJ4I2fbOrKbGjW9HSYNaIQw6tllOm28YRtU2RQwKo02QPDzIJjfUA3Fkt
	 VDxOXVAFEI2Li3Bm2OWlZrn0NtD7cl7QxnC9VThVPqMFOO82+RHMJMOPZA1703JqCe
	 01Rwfjr4a0atMBdpFcadNM8FfINdbiWytSLRlARKwr/m0VqCytMskbatZ2YPJaiz/j
	 Q5Umn/3vsm19RS5WAWEu7dSgeJJHmZrIATmxa+VABdPM3jqmzTzvrM2xhKEQMzbrs1
	 Lhl00gkDwKyqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AB3C811ED;
	Tue, 10 Nov 2026 16:51:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B4860AF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE8D240312
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21zTVcumVfyN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 76ECB4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=CliO2VxJ
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76ECB4008C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:25 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b5669a5100so2126911a12.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283043; x=1794887843;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oKixK7Jwu6TCrx7SV2g9n1KdVg0f5barw8E7pwYTzBI=;
 b=CliO2VxJiCxom33zrD+TK8kAUVtOO7pOmWtDArDnfmnD7DncN4qloqJm/K7BqpeBk3
 ZQJxugrjcTHITqiLi3HiDR+KnShE4+1PiByK4yJbbjdUUaw9qP6hvUfjjyebl8d1sI5/
 jzW9zEZeqUqyTC+TXxC3PBJLgrqNTQ9tqFk2SyUOE69x/Za9P3amGIASIo2gLamJntFl
 c+nD+AnDTIpQc8KIRKIf2uCx578xug9KuRL76nPuzmnhvI1CPVtb9ARLU5HY8JmxH19j
 1SBNfJ7KM51/jglQ8izRfOjE5mkXmOOJmp2ySUPXFx/izBkE1Lwrrp0o6mk+FeEnLWaE
 6acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283043; x=1794887843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oKixK7Jwu6TCrx7SV2g9n1KdVg0f5barw8E7pwYTzBI=;
 b=MD2RsmtW/lZwebNVF7X1pCL3NnSbXmVZGoxDxGXpVf5CHeRvL+SsTPpUK7GmuNzFlq
 9WNPSGELjDtsnSkxNBkUQDZrBG1idzhhvXjmREHpxg/nY1FdYPM9sUBZZqmUQmva6FNX
 0xRSBLY/ePlwk9KEbtlmSrwHUcZ9/6CFEXojuBtiOLqJ18Od3EXA/IT8kGOJlohzXhao
 3qs1/hDvbYUXbU+ftRdXvfd0LnePjNaXnKowcff1UD7XzME6lxcTotbwPVrTy0+4E3c1
 cDYbQyNgZjonj9O1DH5W7B0KFU45bFuC0wpUJewAg69pJ07suO+Pqn7A9AOZLTQPVEMB
 6VDw==
X-Forwarded-Encrypted: i=1;
 AL+hErGb5GRLYTiqqQtTsx8rsezqbYc8RhxvWRH2J+BoEt8hUzQ6PuBaSxhj1rfzSPRwoM+2d+potx712lgr9g6KcUg=@lists.osuosl.org
X-Gm-Message-State: APuU4Z84HdoTpR1gDwfucdvkHhKqd+MiAmnu5em5C2N71zU4U6UcduTQ
 PNlWKQolDHPf8YyOwwVMfo7Ivvvn1Z9Tbeuw9KWbBkknQorXoL9A54pMxxS3mGRQc/g=
X-Gm-Gg: AYBFou2vTfhJcCPe02ouUZ6M+QofgL7Bi//OLWPGOdeNvFHSB1VLgnp+pCSN9IdNcn/
 R55zJYd+xTx/H9f6exowBCp7Qp3skFjH5C/xxlbcqArfViuA8FsksMolTmuj0B+8FEgXGqJb/N8
 pkNdEeWxPzLi6+vqy1Wkhf6P4erNHduVnkUduxVPdlrvqPskcccwcclsCAvXIdzhrO9JzkCrAuL
 Ltd163r9811QMSMrvkN95UKuLuR4WpyV0d0llQTb2p4MEATbaGVWbUTNplkF3H4q2N9YsfF4zOD
 sClGmZKbnVNoqNnoYo7QS9Z/OV46zZ7+Q5jdmaQgP6qtR9RTfGmXFmJeSH0pRigoDinjEJWzZuX
 Vzqwv2Y3orDHpU+Q1zQSJopESj367hZYRGNiXqOeRVi9KLopBYdFmZnQkEWUQdAzXuYxu56d27H
 fsVN4Af5RssZWybgEv6W7FkG8bjGRx9keSuy5wSTqabndQF932Oql6KXlG+Whe7xsjvvObOt9Ra
 zGNFQQsSc2oGwnf9C5/s/bbxCzulqDZ3vZ5eRqlNRmILQAzwl3Q8h8Fp+2PioI+8Nsd1V1A7Z+W
 K/6YrhdEGB/WSOpbLADCnw8KhEPDedR4LdVaju1S2KM8pl029/BXfFK7AnzBbpI=
X-Received: by 2002:a05:6402:a6c7:10b0:6ac:73f8:2e4f with SMTP id
 4fb4d7f45d1cf-6b756aeaf80mr752992a12.29.1794283043237; 
 Mon, 09 Nov 2026 19:57:23 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:21 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vladimir Vdovin <deliran@verdict.gg>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Donald Hunter <donald.hunter@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Chris J Arges <carges@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 llvm@lists.linux.dev, kernel-team@cloudflare.com,
 Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area after
 the xdp_frame
Date: Tue, 10 Nov 2026 03:56:59 +0000
Message-ID: <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 16:51:07 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reserve the skb core extension area in the headroom, right after the
xdp_frame. An XDP program stores RX metadata there for the skb that is
built later.

The area begins with a header, struct xdp_skb_ext. It records the offset
of each entry and the end of the last entry, in 4-byte units.
bpf_xdp_adjust_head(), bpf_xdp_adjust_meta() and bpf_xdp_pull_data() use
xdp_skb_ext_end() as their lower bound, so packet data and metadata
cannot overwrite the entries.

The XDP_FLAGS_HAS_SKB_EXT flag indicates that the header is valid. Most
drivers reuse the xdp_buff between packets, so xdp_prepare_buff() clears
it. With BPF_F_TEST_XDP_LIVE_FRAMES, reset_ctx() restores the flags
before each run, and ctx_was_changed() compares them.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kernel.org/
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 include/net/xdp.h  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 net/bpf/test_run.c |  4 +++-
 net/core/filter.c  |  8 +++-----
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..c888353425d4 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,6 +81,9 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	XDP_FLAGS_HAS_SKB_EXT		= BIT(3), /* skb core extension header
+						   * is valid
+						   */
 };
 
 struct xdp_buff {
@@ -146,6 +149,16 @@ static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline bool xdp_buff_has_skb_ext(const struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_HAS_SKB_EXT);
+}
+
+static __always_inline void xdp_buff_clear_skb_ext_flag(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_HAS_SKB_EXT;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -174,6 +187,7 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data = data;
 	xdp->data_end = data + data_len;
 	xdp->data_meta = meta_valid ? data : data + 1;
+	xdp_buff_clear_skb_ext_flag(xdp);
 }
 
 /* Reserve memory area at end-of data area.
@@ -450,6 +464,37 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 	return xdp_frame;
 }
 
+/* skb core extensions: RX metadata that an XDP program stores in the
+ * headroom right after the xdp_frame, for the skb that is built later.
+ */
+enum xdp_skb_ext_id {
+	XDP_SKB_EXT_HASH,
+	XDP_SKB_EXT_VLAN,
+	XDP_SKB_EXT_CSUM,
+	XDP_SKB_EXT_NUM,
+};
+
+#define XDP_SKB_EXT_ALIGN	4
+
+struct xdp_skb_ext {
+	u8 offset[XDP_SKB_EXT_NUM];	/* in chunks of 4 bytes */
+	u8 chunks;			/* same */
+};
+
+static __always_inline struct xdp_skb_ext *xdp_skb_ext(struct xdp_frame *frame)
+{
+	return (void *)(frame + 1);
+}
+
+static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
+{
+	struct xdp_skb_ext *ext = xdp_skb_ext(xdp->data_hard_start);
+
+	if (!xdp_buff_has_skb_ext(xdp))
+		return ext;
+	return (void *)ext + ext->chunks * XDP_SKB_EXT_ALIGN;
+}
+
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..f25581851339 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -223,7 +223,8 @@ static bool ctx_was_changed(struct xdp_page_head *head)
 {
 	return head->orig_ctx.data != head->ctx.data ||
 		head->orig_ctx.data_meta != head->ctx.data_meta ||
-		head->orig_ctx.data_end != head->ctx.data_end;
+		head->orig_ctx.data_end != head->ctx.data_end ||
+		head->orig_ctx.flags != head->ctx.flags;
 }
 
 static void reset_ctx(struct xdp_page_head *head)
@@ -234,6 +235,7 @@ static void reset_ctx(struct xdp_page_head *head)
 	head->ctx.data = head->orig_ctx.data;
 	head->ctx.data_meta = head->orig_ctx.data_meta;
 	head->ctx.data_end = head->orig_ctx.data_end;
+	head->ctx.flags = head->orig_ctx.flags;
 	xdp_update_frame_from_buff(&head->ctx, head->frame);
 	head->frame->mem_type = head->orig_ctx.rxq->mem.type;
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..4f6698f75d90 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4243,9 +4243,8 @@ static unsigned long xdp_get_metalen(const struct xdp_buff *xdp)
 
 BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	unsigned long metalen = xdp_get_metalen(xdp);
-	void *data_start = xdp_frame_end + metalen;
+	void *data_start = xdp_skb_ext_end(xdp) + metalen;
 	void *data = xdp->data + offset;
 
 	if (unlikely(data < data_start ||
@@ -4547,13 +4546,12 @@ static const struct bpf_func_proto bpf_xdp_adjust_tail_proto = {
 
 BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	void *meta = xdp->data_meta + offset;
 	unsigned long metalen = xdp->data - meta;
 
 	if (xdp_data_meta_unsupported(xdp))
 		return -ENOTSUPP;
-	if (unlikely(meta < xdp_frame_end ||
+	if (unlikely(meta < xdp_skb_ext_end(xdp) ||
 		     meta > xdp->data))
 		return -EINVAL;
 	if (unlikely(xdp_metalen_invalid(metalen)))
@@ -12794,7 +12792,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 
 	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
 
-	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
+	headroom = start - xdp_skb_ext_end(xdp);
 	tailroom = data_hard_end - xdp->data_end;
 
 	delta = len - data_len;
-- 
2.56.0

