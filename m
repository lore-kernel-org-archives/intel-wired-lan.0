Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF18606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uV1S2vS1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWkXIDg9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 213AA40840;
	Thu, 12 Nov 2026 00:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yk1Q6VFZpZ39; Thu, 12 Nov 2026 00:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 303AF40842
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794443700;
	b=PO+D0H0pnOZ98x6ZgTFWvVf6jkfioKaQSyRRElRG+4dLYwPh3vufSGRWO6BJ350yEy3A
	 gkFPRlvd9w4+KeN4eLAKZqK3zSHil8M2eijA5PcjfNcK57HGWPLtVnnOU1SqhwYYwXu7P
	 FtVNhlCuAKnqgLiHwexEWokwXltGnMltHG1vaHkqs6wSSRHavzAPljQpLSTrQ/YKZWbl+
	 f80WlRhr847Gdrt7wTcniBE9mdtAs41I5SRJCzMoSSiSsGIzXZncTaakQ/2xGW+yZG5rn
	 SdL7D28hzvpBg9SP21HxuqGyBfFrsftljeQB5fXapCeG1K5TXv5Hd+EcGRu62iMv3yQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794443700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
	b=jJ58g0rLOLf4annCuuoR38dANiR/fLbNd1lho74FQTxv0EnRdaEAWvmZHqWhg/r+2xSh
	 nIaLLmxnqaxKxJAwOSiAWXQ5E2KQb+rhh/yaS+p7CJaLBIA2LpmZKoR7fq/be1SeHneer
	 rOGHXHEOFfWVBTEdrfhdxtE+8qoyq0XN5imBGEC101Xi6wKsrtJctglqpOsEMJgWgjuzB
	 BBBqfDhexlM8sNALyhgGb78X3+Y/L5aS5QgnIkle12JCwNCdKQZd1iGu4p/cLN4cihz4Z
	 RXHxT3J2wvvbjswYDL8Wxnp6/It6OfApSyh+dAy7IeA2pr35TtQEYdQkVVQdBxXBbLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWkXIDg9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794443700;
	bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
	h=Date:Cc:Subject:From:To:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uV1S2vS1APSHflyOBDh/TXez1GCt6xnSoryolFWEboeV/1kIN6uHjfoQcSclGdZkh
	 FrZnubmBUxkbGn22XSgKy+OxcgOWOPrPxkaJr5we0bNnHOyJHnIRulR7Rj1r+ebl4i
	 hLgl7+2OSyYWBs9tM8U37tw+QpGURuIYDgjad+myqiJjY1Eo28jVLYCtO4TWqscctF
	 1CE4Uy2gFx96ck7He5Nt81PmLuFR92oq36xxpETGTNpPcPpP3zvmNDKcEBpyDsTb9s
	 nhAg/I7+e4acysYgvPwnBeVbJQIDh7DIErIW+OLXB2v07n79n4l7ttYz4ImwAzRfnN
	 huoWtNQn45jxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 303AF40842;
	Thu, 12 Nov 2026 00:35:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1A552E5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 00:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7D5340842
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 00:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpAfiK8StexC for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 00:34:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C1E640840
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com;
 envelope-from=alexei.starovoitov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RWkXIDg9
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C1E640840
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 00:34:57 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8b5e5e64494so2014557b3a.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794443697; x=1795048497; darn=lists.osuosl.org;
 h=mime-version:content-transfer-encoding:references:in-reply-to:to
 :from:subject:cc:message-id:date:content-type:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
 b=RWkXIDg9pt4UKYssZF/FrumImQADPbM1AJSZWtwqPneFqzUeYNCZPLToAnOcKLpmEe
 sJFdSsJqjcGFPMGwdcOhLEjVeJbSBfupzdFShX9s2w2meviG/NLwcnHov4PYV9Z8dFTa
 cqcewSwZnMMI6iXPkWn8xihRtx80afbJRV+NNXGqQMBxcXY/QmNdfZBpHq5jG7S2S5Nk
 CXLWnP5B9N5HH+E5nmiqkGZamjyW2FgXNMPkCB9VH+jjMvX9KBvZzZxnERhAomgdWAMX
 oyIUW7VhybJsiBVOYOLuJFaModLtMzcJYGU0BLKtvvFKrp6NBbMc3x7KgS/X5WU7ctJI
 6DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794443697; x=1795048497;
 h=mime-version:content-transfer-encoding:references:in-reply-to:to
 :from:subject:cc:message-id:date:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
 b=X7htmoAe1mA/L/fnxYrYw4DrKtLmpD0O6oqdfJdLp1czwyvVtBEMwsaZC/D2dqigrl
 9fC9fhY5UHrHZgdjoM/NQtaVTMPt+jcVI4Q11CYl75dFlOVxXNRDeNSdEYiisVWi22Qd
 AgLubSXTkIUKioNKE7QCK5cFKZn2GHNaPbvMF+B/4NlddKPCs5WKvEtGoaYmk8MJ8g3L
 mu+QZreCxI4q9Eo6cZbUQPylkb7ovm3FkcaksYLkYWPJ+LfmArJgkur8yVkWOio8Fkxj
 7b3KcNz4EuYo9Ahb5dxskO3TgfAQ2iNH4cG7CwIsoDAcYyy69hwrjUc/iRmeXGlHhgK3
 ZJRA==
X-Forwarded-Encrypted: i=1;
 AL+hErEDUYU/8jJGplZxJQRV7XGEurwDtYhJXAKOxUVIm7nZpucfHKtDKzCQIL1R5IEkSdOp6u2RxhBCdPzZP0Nuz7Y=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8Obq5WKH8cce291GRcia6IYnSz5ryeNYV1052EAaEtvT5LKIgf
 qTbA+9+g5v63XdfpbC2dbYAH2g2iTx1+Sqh6TCf6TX7Zky4rXP7W6EJc
X-Gm-Gg: AYBFou0pYtI1OYkBVOYwmsigADP1gyD+T/WCMY25m/jPZalukz6Z3GauCpgmFK/oRqA
 B9QV/8updj8HWDzMsTtzaQ+WOxwYwDBHBGuVngWxuwpLLGW+SLEV9vb6f5rdEAd06Cr2QWaIha5
 zd0xnH7ojEQ+zubLmVs4sBgGibstaDBFLlOUzIQnnYw9HAMPwuw0mLVwr5jpdM019QsuTFGVEun
 0ZCNQWFYeTzk/KjFbWs5BjeVfmbyFQ7jDFhqDkPBhuKEXhCvu0eu29DGrLAve16I6TCO5g0yZYL
 BK6xr0XIgE/8q4U6nF7Au+/ZGb4XPMGJpC+Ypl/scc+PtY0w/fBRwdIANfznH1VCMHpbFKA+bh9
 UQAsjNgt5Mf+73xALKRvxSHB78UYDAcRM09RDHcYej/ajsfq+s4uufGAUmal3VpaHrQUfgUp+LG
 BPo9Q4FeDloIMxVUeaHxx5MEdCD4jv1q9JCigSt8D0QloSriADkIKqXqd/z0iPWhI+M818M1VfG
 /7AWZQJYoD1APPwsGOms2f6X410JAvH1/NQSeDE3F/SZbXvJ3DtQIhuryJUQuHriwhPZF/0uNvo
 YrHnrxXuGUPhhkDbT+7ag8BwAw0eAMNJTFiWP1Zk5+06ZnOImnC1UwIbMdEzTAH1myyEt1uygy3
 vipceitHQ1af2TtPVruBnmmCEfjXNyaUjSw==
X-Received: by 2002:a05:6a20:2451:b0:3e2:1a24:fb7e with SMTP id
 adf61e73a8af0-3f2fda8c6b2mr4281249637.40.1794443696335; 
 Wed, 11 Nov 2026 16:34:56 -0800 (PST)
Received: from localhost ([153.61.198.241]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d67e52esm2026298a12.10.2026.11.11.16.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 16:34:55 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 00:34:54 +0000
Message-Id: <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Lorenzo Bianconi" <lorenzo@kernel.org>, "Vladimir
 Vdovin" <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Donald Hunter" <donald.hunter@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "Maciej Fijalkowski"
 <maciej.fijalkowski@intel.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Magnus Karlsson"
 <magnus.karlsson@intel.com>, "Tushar Vyavahare"
 <tushar.vyavahare@intel.com>, "Jason Xing" <kerneljasonxing@gmail.com>,
 "Nikolay Aleksandrov" <razor@blackwall.org>, "Madalin Bucur"
 <madalin.bucur@nxp.com>, "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Chris J Arges" <carges@cloudflare.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <llvm@lists.linux.dev>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tianyi Gao" <tianyi@cloudflare.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 07:56 PM Tianyi Gao <tianyi@cloudflare.com> wrote:
> The layout of the area follows skb extensions (struct skb_ext). A small
> header gives the offset of each entry. An entry takes headroom only when
> the program stores it, so the area does not grow with each new type of
> RX metadata, unlike [4]. Unlike skb_ext, the area needs no allocation.

I'm with Stan on this. It looks heavy.

How about the following idea:

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231ad..7f30d24 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,8 +81,15 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* The prog stored these members of struct xdp_rx_meta */
+	XDP_FLAGS_RX_HASH		= BIT(3),
+	XDP_FLAGS_RX_VLAN		= BIT(4),
+	XDP_FLAGS_RX_CSUM		= BIT(5),
 };

+#define XDP_FLAGS_RX_META \
+	(XDP_FLAGS_RX_HASH | XDP_FLAGS_RX_VLAN | XDP_FLAGS_RX_CSUM)
+
 struct xdp_buff {
 	void *data;
 	void *data_end;
@@ -174,6 +181,7 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data = data;
 	xdp->data_end = data + data_len;
 	xdp->data_meta = meta_valid ? data : data + 1;
+	xdp->flags &= ~XDP_FLAGS_RX_META;
 }

 /* Reserve memory area at end-of data area.
@@ -310,6 +318,48 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };

+/*
+ * RX metadata that an XDP prog stores for the skb that is built later.
+ * It follows the xdp_frame in the headroom. The headroom is taken only
+ * when one of XDP_FLAGS_RX_META is set.
+ */
+struct xdp_rx_meta {
+	u32 hash;
+	__be16 vlan_proto;
+	u16 vlan_tci;
+	u8 hash_type;	/* enum pkt_hash_types */
+	u8 ip_summed;
+	u8 csum_level;
+};
+
+static __always_inline struct xdp_rx_meta *xdp_rx_meta(void *data_hard_start)
+{
+	return data_hard_start + sizeof(struct xdp_frame);
+}
+
+/* The lowest address that the packet and data_meta can use */
+static __always_inline void *xdp_buff_headroom_start(const struct xdp_buff *xdp)
+{
+	struct xdp_rx_meta *meta = xdp_rx_meta(xdp->data_hard_start);
+
+	return xdp->flags & XDP_FLAGS_RX_META ? meta + 1 : meta;
+}
+
+void __xdp_rx_meta_to_skb(struct sk_buff *skb, const struct xdp_rx_meta *meta,
+			  u32 flags);
+
+/*
+ * A driver calls it on XDP_PASS after it sets the skb fields from
+ * the RX descriptor.
+ */
+static inline void xdp_buff_rx_meta_to_skb(const struct xdp_buff *xdp,
+					   struct sk_buff *skb)
+{
+	if (unlikely(xdp->flags & XDP_FLAGS_RX_META))
+		__xdp_rx_meta_to_skb(skb, xdp_rx_meta(xdp->data_hard_start),
+				     xdp->flags);
+}
+
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
@@ -648,6 +698,12 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };

+enum xdp_checksum {
+	XDP_CHECKSUM_NONE		= BIT(CHECKSUM_NONE),
+	XDP_CHECKSUM_UNNECESSARY	= BIT(CHECKSUM_UNNECESSARY),
+	XDP_CHECKSUM_COMPLETE		= BIT(CHECKSUM_COMPLETE),
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc6..f255818 100644
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
index 9245009..efbe293 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4243,9 +4243,8 @@ static unsigned long xdp_get_metalen(const struct xdp_buff *xdp)

 BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	unsigned long metalen = xdp_get_metalen(xdp);
-	void *data_start = xdp_frame_end + metalen;
+	void *data_start = xdp_buff_headroom_start(xdp) + metalen;
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
+	if (unlikely(meta < xdp_buff_headroom_start(xdp) ||
 		     meta > xdp->data))
 		return -EINVAL;
 	if (unlikely(xdp_metalen_invalid(metalen)))
@@ -12794,7 +12792,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)

 	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;

-	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
+	headroom = start - xdp_buff_headroom_start(xdp);
 	tailroom = data_hard_end - xdp->data_end;

 	delta = len - data_len;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8..ca17609 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -829,10 +829,10 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,

 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
+	if (xdpf->flags & XDP_FLAGS_RX_META)
+		__xdp_rx_meta_to_skb(skb, xdp_rx_meta(xdpf), xdpf->flags);

 	/* Optional SKB info, currently missing:
-	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */

@@ -857,6 +857,9 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,

 	memset(skb, 0, offsetof(struct sk_buff, tail));

+	/* The callers set the RX fields themselves or transmit the skb */
+	xdpf->flags &= ~XDP_FLAGS_RX_META;
+
 	return __xdp_build_skb_from_frame(xdpf, skb, dev);
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_frame);
@@ -990,9 +993,154 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
 }

+void __xdp_rx_meta_to_skb(struct sk_buff *skb, const struct xdp_rx_meta *meta,
+			  u32 flags)
+{
+	if (flags & XDP_FLAGS_RX_HASH)
+		skb_set_hash(skb, meta->hash, meta->hash_type);
+	if (flags & XDP_FLAGS_RX_VLAN)
+		__vlan_hwaccel_put_tag(skb, meta->vlan_proto, meta->vlan_tci);
+	if (flags & XDP_FLAGS_RX_CSUM) {
+		skb->ip_summed = meta->ip_summed;
+		skb->csum_level = meta->csum_level;
+	}
+}
+EXPORT_SYMBOL_GPL(__xdp_rx_meta_to_skb);
+
+static struct xdp_rx_meta *xdp_rx_meta_reserve(const struct xdp_buff *xdp)
+{
+	struct xdp_rx_meta *meta = xdp_rx_meta(xdp->data_hard_start);
+	void *start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
+
+	/* User space can write the headroom of AF_XDP zero-copy buffers */
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return ERR_PTR(-EOPNOTSUPP);
+	if ((void *)(meta + 1) > start)
+		return ERR_PTR(-ENOSPC);
+	return meta;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_xdp_store_rx_hash - Store the RX hash for the skb of this packet.
+ * @ctx: XDP context pointer.
+ * @hash: RX hash value.
+ * @rss_type: RSS hash type, see &enum xdp_rss_hash_type.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENOSPC`` : not enough headroom
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
+				      enum xdp_rss_hash_type rss_type)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_rx_meta *meta = xdp_rx_meta_reserve(xdp);
+
+	if (IS_ERR(meta))
+		return PTR_ERR(meta);
+
+	meta->hash = hash;
+	if (rss_type & XDP_RSS_L4)
+		meta->hash_type = PKT_HASH_TYPE_L4;
+	else if (rss_type & (XDP_RSS_L3_IPV4 | XDP_RSS_L3_IPV6))
+		meta->hash_type = PKT_HASH_TYPE_L3;
+	else
+		meta->hash_type = PKT_HASH_TYPE_NONE;
+	xdp->flags |= XDP_FLAGS_RX_HASH;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_store_rx_vlan_tag - Store the VLAN tag for the skb of this packet.
+ * @ctx: XDP context pointer.
+ * @vlan_proto: VLAN tag protocol identifier (TPID), in network byte order.
+ * @vlan_tci: VLAN TCI, in host byte order.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @vlan_proto is not 802.1Q or 802.1AD
+ * * ``-ENOSPC`` : not enough headroom
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_store_rx_vlan_tag(struct xdp_md *ctx, __be16 vlan_proto,
+					  u16 vlan_tci)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_rx_meta *meta = xdp_rx_meta_reserve(xdp);
+
+	if (IS_ERR(meta))
+		return PTR_ERR(meta);
+	if (vlan_proto != htons(ETH_P_8021Q) &&
+	    vlan_proto != htons(ETH_P_8021AD))
+		return -EINVAL;
+
+	meta->vlan_proto = vlan_proto;
+	meta->vlan_tci = vlan_tci;
+	xdp->flags |= XDP_FLAGS_RX_VLAN;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_store_rx_csum - Store the checksum status for the skb of this packet.
+ * @ctx: XDP context pointer.
+ * @ip_summed: ``XDP_CHECKSUM_NONE`` or ``XDP_CHECKSUM_UNNECESSARY``.
+ * @csum_level: Number of consecutive verified checksums minus one, up to
+ *              ``SKB_MAX_CSUM_LEVEL``. Must be 0 with ``XDP_CHECKSUM_NONE``.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @ip_summed is not supported, or @csum_level is not valid
+ *   for it
+ * * ``-ENOSPC`` : not enough headroom
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_store_rx_csum(struct xdp_md *ctx,
+				      enum xdp_checksum ip_summed,
+				      u8 csum_level)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_rx_meta *meta = xdp_rx_meta_reserve(xdp);
+
+	if (IS_ERR(meta))
+		return PTR_ERR(meta);
+	if (ip_summed == XDP_CHECKSUM_NONE && !csum_level)
+		meta->ip_summed = CHECKSUM_NONE;
+	else if (ip_summed == XDP_CHECKSUM_UNNECESSARY &&
+		 csum_level <= SKB_MAX_CSUM_LEVEL)
+		meta->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		return -EINVAL;
+
+	meta->csum_level = csum_level;
+	xdp->flags |= XDP_FLAGS_RX_CSUM;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(xdp_rx_meta_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_hash)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_vlan_tag)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_csum)
+BTF_KFUNCS_END(xdp_rx_meta_kfunc_ids)
+
+static const struct btf_kfunc_id_set xdp_rx_meta_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &xdp_rx_meta_kfunc_ids,
+};
+
 static int __init xdp_metadata_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_rx_meta_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
 }
 late_initcall(xdp_metadata_init);

