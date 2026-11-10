Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F49606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Hre1bmyc;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=PdhApXRS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6641C812B1;
	Tue, 10 Nov 2026 16:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2PgwDTmMX_2w; Tue, 10 Nov 2026 16:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7277081277
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329480;
	b=iwkVY9yLkj0sFldMmqIKjbUxVPuoCky4T+aIKcWh/8QUr93T3ZJGAQgkSDBzksB8Xi07
	 L/nxREmhmUAanlZYU5CfvK4GNXejMTFYCTZfjbVF/5OIVb+GEoSvfKwldcb7urMH+6Htf
	 LxV95T1p0Ww5IH5ojC08mDlIiSgX4QbHTgSFrNeGOkPivbyNiVZ6zQ9ChXBiX6ol59FBx
	 ZeyaKnOTAlSbfIYpSQQlTyF2ULxEo+HkWK/73yjsK1/Fril2Ig075nXzunSyV6AXXN2Ua
	 OExtSUuHRoJ/oB4kqWLSPYelX+Dng3hqVJr0Myubqy9skOH39cdNy4hMOGEI5hK7TLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
	b=KjbbMnfxr3vfiiXOQdDgMuSVrx5KLJYudQdJSHkQC0DzuR2dRJUbFlT/n8nEkml1NHVe
	 OYPbqqfVZm3bmQUPsUWG8EUZ2Tn1MWSvCLKGHKdkbGX4Fbktz/hWMA5iwGDbSfQpmdqnf
	 rPCPAlPVJjy2fSRn4Nxknuwc4xRdZ26jVd1MLtiLI0Y4SlsrDtdD4ESSyge5CWLYQVVoa
	 WYNCZIWhuKHp078FlKIOmnp+t8SuLDI9Nds1Pwo+RL326i9vP4be4Xy9Vhu+fhgTYF0sN
	 Npa96AwKLojyWvoPQiRiLJoqcIF2YQirkE5up4lzV1vjTLWmmCeKEwPwX10GuLBIUEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329480;
	bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hre1bmycjIbTqdbfzWWpUJns97CgmGt8H79rXVT7QnPQWaXpT2Ymj0V5vkhmnDDTN
	 HiiUB/Dg+yhQXZWYYMNwSW1HyXAIDEWfEYH/OyaevZRMdHW2F82qBKjZtoDxlKwCS/
	 Yhs/BL/hkkQgcCKcWAOsII9/shDJeA40Q/B8aaA8u7I9cBVBGDiAnLBxc+Twnq0xub
	 q5ajVZCZPZg4GXIe0JGoRJ1YSOxS5qs5L/XH5UgPRiJffdI/IwCh4Pjb0KDw7LL8MG
	 WWLCaBQsmIGOHtDAVFlNSC9CLB+wQdiLn1hvEeiR0lZqjBVqpBGJaMEGOcA1drO1wQ
	 9Q80xMN1rUNsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7277081277;
	Tue, 10 Nov 2026 16:51:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0898F335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2D4A4008C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6H6VQ_mNu6C0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DBCF540061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=PdhApXRS
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBCF540061
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:08 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so846416a12.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283086; x=1794887886;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
 b=PdhApXRShaTiYpRdkFhmW6Rb7k7he4tuzNARXi0YQX3cmiH644BXzOVXiMHtp4+dNO
 5isca2au//QrcXq20Yuy9jlktStgIyL2z3uUEEyyrLTAUG2M8Xnc0Soi6wl5BwbUYc5q
 lU0THHe1ffjwLK2GUObZaWkhC25V7IWQPkQpuzHesNkjkn6bTPbIVoXUCgwUYkrTkvkP
 tMJBuHsskVgRS0jpByQmjzBmus//ZOv3iE50U8KFDmzL1P9b1C9Vy9N2YBJrRMdbGC5r
 jhYS3QYharSCAg57Hx98jQsStNXvNLW33vhx6QHq/6moedRvk5sAzIR/Gf80j/IDXLLe
 Ipiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283086; x=1794887886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKtp2J/LvdqcfkW+9WIXUeirxII9N+NyVOA5Mc+RvFk=;
 b=InSSpditHqCOW0ahida8bITtJcFszLwQ6A7cqQQYfmuG0SYMOxHBwUKJlxBQBvau2U
 ZNsmVXya8ZLcsFRVnU46mSDREyASNlHWZLbpauGS8ytPxmseBz4MgzV+nej2/SBAigP7
 u1MlK5h3WHompQ3GUSxmvKfd7nTmV29rCfpj2tcvhUHkaNlBhdhxJvA+55rbApG0yC62
 ZbHajXE5efOUZsS8Z8PBSlBx/eXiV/YR3bEWWzyjDJhcmXMJ5OxZ2xYXD8hbVlCPjQBb
 corgeWJe8blpVLOBjgyCvk95YLei38XSh5TAB0q0NrDjJ2efJtfGrx/8dfQex16Aft0c
 EOtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH+CSh6i/vAhDMMDM8rXNyNfYDtZ+jdNvB2C/PgtdQB6wsgSfXOhzcaWl2WaGIq5OVOjSbyQDVQIsOy7FjINls=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+BOJ0h1GGDDg5mvsjbasVQ/re54KR3xnqdovbuaSDpg6aZqbQe
 cRq2aMZzaBl1U8vYUvCPGlzK8DNtV9z2fpD+WmFGf8T/Mc4oqSZ2LFGFYQA+BI2GGAI=
X-Gm-Gg: AYBFou1EA/b/oeMtckV+71+hXsuawzmYEbhSnuYgaNBiakoprQJhDpDO5N5oQB4W73u
 6YCqFmMnm+d5ysP62SBdGcfDgkD4FAmgE6wa2f723mcTkrnU82UtBsNbfail4cKGda+Ip6inVuO
 01dCO9mgGQtYUe21A4RxgVfMrsZXuLGFJsbHAjxxoX1QySD6UDfqWIbFdJYFWvt8u3FMiiG3tzv
 9fEKZk7S7BTskSnI1ba4dN5TwV2kZWMF2YKTd6y9uyhFlh2b6vMMu6qythHFDgwil+eE5MBNwOm
 3IfYYSZajlA5z/OnXjfo1n0eb23NdATPVvRLkNE+AnIn+wT2eFGzaM20J3L9qc6wYvOsxrukoMz
 JrrKxzVZ8LVyga0Ixb+gzjBrb8yBNlJl5yT57cD44A6ksiHuqFZlTirU5oFsTuxNykO7vGDKiL5
 Gn1GE92WRWp1pSst0lzUftuLusTuqjEPpzVvgwlXxhT7o9WvvzLNu21i3ETw4XIVQNGpkvuJfge
 fEwjmMWfGhoJRXRtKIuaiusbbF+5NT54Oi9EXcXmpDGxgwVIMRme3pHXH21PT/3j4pz4Lzqa7UO
 PizIW/Ktb+83eMdlczuwxFWeMC8A8e3Fq8t+pHyw146ixCTRUFPGOmaoUgbQlx8=
X-Received: by 2002:a05:6402:22d0:b0:6b1:b97b:745 with SMTP id
 4fb4d7f45d1cf-6b756af0889mr755303a12.29.1794283086393; 
 Mon, 09 Nov 2026 19:58:06 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:58:04 -0800 (PST)
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
Subject: [PATCH bpf-next 13/15] xdp: add kfuncs to load the stored RX metadata
Date: Tue, 10 Nov 2026 03:57:11 +0000
Message-ID: <1985183a511a2217fe0f42582cbd16f023d8991e.1794281983.git.tianyi@cloudflare.com>
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

A program on cpumap or devmap cannot call the XDP RX metadata kfuncs,
because they need a device-bound program. A program on veth can be
bound to veth, but the veth callbacks return -ENODATA for an
xdp_frame. So a program after the redirect cannot read the values
that the program on the NIC stored.

Add three kfuncs that read the skb core extension area:
bpf_xdp_skb_ext_load_rx_hash(), bpf_xdp_skb_ext_load_rx_vlan() and
bpf_xdp_skb_ext_load_rx_csum(). Each returns -ENODATA when its entry
is not stored. They are in the same kfunc set as the store kfuncs, so
they are not device-bound and need no driver callback. A program on
the NIC can also read back the values that it stored.

The RX metadata kfuncs could return the stored values instead. This
patch does not do that. Relaxing bpf_dev_bound_kfunc_check() for
cpumap is not trivial, and it changes these kfuncs for existing
programs, which read the values from the RX descriptor of the bound
device.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 net/core/xdp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index fdda072a5858..4df3984479a7 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1081,6 +1081,15 @@ static const void *xdp_skb_ext_get(const struct xdp_skb_ext *ext,
 	return (const void *)ext + off * XDP_SKB_EXT_ALIGN;
 }
 
+static const void *xdp_skb_ext_load(const struct xdp_md *ctx,
+				    enum xdp_skb_ext_id id)
+{
+	const struct xdp_buff *xdp = (const struct xdp_buff *)ctx;
+	const struct xdp_skb_ext *ext = xdp_buff_skb_ext(xdp);
+
+	return ext ? xdp_skb_ext_get(ext, id) : NULL;
+}
+
 /**
  * xdp_skb_ext_to_skb - Set the stored RX metadata on an skb.
  * @skb: The skb that is built from the packet.
@@ -1296,6 +1305,85 @@ __bpf_kfunc int bpf_xdp_skb_ext_del(struct xdp_md *ctx, enum xdp_skb_ext_id id)
 	return 0;
 }
 
+/**
+ * bpf_xdp_skb_ext_load_rx_hash - Load the stored RX hash of this packet.
+ * @ctx: XDP context pointer.
+ * @hash: Return value pointer.
+ * @rss_type: Return value pointer for RSS type, see &enum xdp_rss_hash_type.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENODATA`` : the RX hash is not stored
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_load_rx_hash(const struct xdp_md *ctx,
+					     u32 *hash,
+					     enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_skb_ext_hash *entry;
+
+	entry = xdp_skb_ext_load(ctx, XDP_SKB_EXT_HASH);
+	if (!entry)
+		return -ENODATA;
+
+	*hash = entry->val;
+	*rss_type = entry->type;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_skb_ext_load_rx_vlan - Load the stored VLAN tag of this packet.
+ * @ctx: XDP context pointer.
+ * @vlan_proto: Return value pointer for the TPID, in network byte order.
+ * @vlan_tci: Return value pointer for the TCI, in host byte order.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENODATA`` : the VLAN tag is not stored
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_load_rx_vlan(const struct xdp_md *ctx,
+					     __be16 *vlan_proto, u16 *vlan_tci)
+{
+	const struct xdp_skb_ext_vlan *entry;
+
+	entry = xdp_skb_ext_load(ctx, XDP_SKB_EXT_VLAN);
+	if (!entry)
+		return -ENODATA;
+
+	*vlan_proto = entry->proto;
+	*vlan_tci = entry->tci;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_skb_ext_load_rx_csum - Load the stored RX checksum status of this
+ *                                packet.
+ * @ctx: XDP context pointer.
+ * @ip_summed: Return value pointer, ``XDP_CHECKSUM_NONE`` or
+ *             ``XDP_CHECKSUM_UNNECESSARY``.
+ * @csum_level: Return value pointer for the checksum level.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENODATA`` : the checksum status is not stored
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_load_rx_csum(const struct xdp_md *ctx,
+					     enum xdp_checksum *ip_summed,
+					     u8 *csum_level)
+{
+	const struct xdp_skb_ext_csum *entry;
+
+	entry = xdp_skb_ext_load(ctx, XDP_SKB_EXT_CSUM);
+	if (!entry)
+		return -ENODATA;
+
+	*ip_summed = BIT(entry->ip_summed);
+	*csum_level = entry->level;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
@@ -1303,6 +1391,9 @@ BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_csum)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_hash)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_load_rx_csum)
 BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set = {
-- 
2.56.0

