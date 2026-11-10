Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322C606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=tzStaAJV;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ag7eP5bN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B51BF81201;
	Tue, 10 Nov 2026 16:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZPs_Zu716qCG; Tue, 10 Nov 2026 16:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6661081236
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329475;
	b=QuC8CJ84/KqWO6tBbxxZrATKf3VA7LQSZQn3oWX5Hzh5jaz1HpXbR8c/UTdef3wIiTzm
	 JtHdPxVB77mKnaURL747NXEsBUr+VKEnaGkqRF+3xoERBCVLp/0iiJi3Y+A/kf4J/9GFl
	 rKqmr4Q3SFGKuOYgu1yT43oFxwZxXqScu0nm3YALyObktRvL/UP1xioOluIjRdnOVW0tV
	 yHuAOAeqFAhuYQHSPJX70mX5ZijAxgmLOT0Kgjt/UVzzAghlt57Ujx07VwU4QRt0RAdeZ
	 X783hf2f+kxgEmZeKB60s63zmu9fZ2VWrRpJAuieGxxJ2Og9LU6x9OB+ueBSF9zJVJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F9EfUz+UskV0rhf4cQXQsxZ2euYB/mU/YoxBROtxa6Y=;
	b=Rldw1T+It2l3jqqjOfx/OUpap5iKEaP6yA3H1DcIe2J16bsotJiEl0Z6cB5rcA8oNz8i
	 FkrPm473LfZ86y85R7lLGk8EEVHVOwm3MmIZfW+9ZAMY/+2yZ+pi6ftOVbya4gWTVRygI
	 Q1aPzvNE2kwmoO9LVmzh0+z9kJXoj5ZCg6zwVKWIp0Ocg8p5JmuM9OneoI+9Dtzqz/O2o
	 CZLxJMaVBzGZJ3YryBaGC4hrHktKnnl3BeghVwqDfzDW5CapeGuuVAD02mn6VdLJdpLcX
	 dokUHCpoWABVanR6WIwVtQ6HwVPalXqkehu1UGfDnxicoO10zEeEywuumiGCR69mcgg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329475;
	bh=F9EfUz+UskV0rhf4cQXQsxZ2euYB/mU/YoxBROtxa6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzStaAJVhhx13nlnOb0cFiX2c7JLzG4MHRBUXWUBc+OTzHj72s4N0WIEYYAH0A96A
	 HyjrOju5IDs2t82qjfg8ufc2C/TwQRimY9JaDUZEJkHI9PyjqzbxxQ3cOTGW+p6DTY
	 jvksZO65C1J66H4OYhvrPDxwJhDvgn5omUanF0bKMyQj1Yqw3diQTOEDVPYruIA21s
	 8Aw2A3B2nKP3hjU8W8wh39mHUtjv+wyGVDhIPydx+BuQ0+6t6vuRqY2I6kc1dZpCCU
	 AeURYcCO1JZgJo9PD7oALgW3NBR9EV97rhdVJEVI5NQVff5mxqrNh/EYUDmgpNUn/C
	 PalOgLBGJ27Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6661081236;
	Tue, 10 Nov 2026 16:51:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99309AF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9680F4059A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eVUH3-TKUyQt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 751EC4070E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=ag7eP5bN
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 751EC4070E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:47 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so1927917a12.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283065; x=1794887865;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F9EfUz+UskV0rhf4cQXQsxZ2euYB/mU/YoxBROtxa6Y=;
 b=ag7eP5bNXlaajLhVmZvLov/7uZQZJD/oyJEWEyXTgdo/rLcbFZaWILpzCL1kmqImKz
 v/ihwlxdMyw83HhIK3v3yKDAWi7zsD9QryWRL4lw8X5N/830BuVroa/I3CZYQ25PoiTf
 WLOMUZlEpbKVH4HrEUa6+NclXGaXW7QwIih+27JieGINz5PPLe2UfqMRJ8X6J9a4xgDY
 DAxeUv308uMtstkvQkgz+COFzsGtv8AefmN2fpaaO++bEEEjiNszzcFdiw7UA3xZaAJ8
 LWgTOjSiM/8KLXQt7hgv4HRH9/BAUZC3s3hJmdmrt2xLWccmkiLmml6T3CvC8IHG0Pcs
 e3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283065; x=1794887865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F9EfUz+UskV0rhf4cQXQsxZ2euYB/mU/YoxBROtxa6Y=;
 b=rU6lwd2xKBNJjsuViGsTcaukr8HMTWSxQg7Pslf+kB6t/Cbxf0gZHf+0PuM02uPuSy
 mJ+6wEOLHfd4f0gAint40wLV6um2hozoPMuwmrkxaALQCGb02jt1uYFmliENGsH7hS7A
 AexV17aQ6FkuqFB+6Gl9/hMyj0g7W4WKBqFwz795GwLXHiZ3HBMZEeX+4w8mZrr5x861
 A4zc1hnE60E7cAlJjjxEICBeXbvdCyVUxy4DPnatte6r47yLzHw22M1aldzgpbUNHUr0
 uPvobsuvpzgvQtIYbmssgYhRyFEm+/zJIqmGALpNG31zOtwWzmitb2JzvZAsOAtaBpVb
 ZbTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG+fofSN3FlH4/66H2BQPib9LLsXEunXyUx3+WvVLAv14AvUNLJ6MKMHmugpGyviXvPkETvKOunqCfsYxQ8eAY=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8d356iIy3jZ+Dyf2LBHnxJBetghQ6sWHvvNa+KPuUVLDvMwq+D
 0W90tVV6QXwPrvaYO3WQDG2HxFTWfwvpKVjGyVAplbrtC2RHBY19OviyF8Otfakmjzc=
X-Gm-Gg: AYBFou1EeqbcSHRbiViVUFcPxIAI08hVmgVjAvXjO2LYUZdkwRafs38uT9IE9ElFxDk
 +tkzo4AVQPhbP0RQU3+aGJAM9nDZXIGClHa/8+d1jGESnwfaxPXG64nUyqIph1vsltbSqaTvxkm
 poH6w0iFQW9m8r2hx7pbDPswdANo3N4A2SH4r/Aa3ExvetyI9fiXVTZbY/2XjpY/gJPNqNDqFZa
 a2FbNnlMhMgHQAmq2GP193HO/p0esg7W2sz9lqBKG73VfZ2yZA2zcDNQOB7XlfWONZF3K6+wfQq
 rhnYCy2dChrKWyiukFoJwIXa7knZEnnfTQuSpEWegd9kHzlYMhlOqsW+IvT285yxgYXJrEx5mOp
 KbQKc24NtAG8k8Cs/zi+aaRrcF1epteE1b0nmL7s9HDWcJUGG7jb7JrxcvHuptmTV1eWlkFWqlu
 X3206s3gW8qNngFokivzNFZqzQdwFqfHw0w4907PnLIs3Oh3Tl6tbofP7u3oCuN3p3BiWBuBhMl
 ikNY3kDzm1FHpd60qxQd0k+0ubjJdbkwCpCxMgEjvLnSUITbKO5zDzW4bSFbNTi8RjiJBcf3Kzv
 GHCPXKrTmlxsS/QTF45eIUjM+BwnvFlvXQzV2OVn0STzSXL41ISjJkGuh7IRW5E=
X-Received: by 2002:a05:6402:2750:b0:6b3:b10c:40f9 with SMTP id
 4fb4d7f45d1cf-6b756af5982mr1263386a12.31.1794283065131; 
 Mon, 09 Nov 2026 19:57:45 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:43 -0800 (PST)
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
Subject: [PATCH bpf-next 07/15] xdp: set skb RX metadata from the skb core
 extension area of xdp_frame
Date: Tue, 10 Nov 2026 03:57:05 +0000
Message-ID: <eca7d73b0881b59f0f7b3cf8d6e022e70c8ed800.1794281983.git.tianyi@cloudflare.com>
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

cpumap, veth and BPF_PROG_RUN build the skb from an xdp_frame with
__xdp_build_skb_from_frame(). It now calls the new helper
xdp_skb_ext_to_skb() if the xdp_frame has the XDP_FLAGS_HAS_SKB_EXT
flag.

Three drivers (atlantic, mana and netvsc) call the wrapper
xdp_build_skb_from_frame() in their RX and TX routines, and then set the
skb fields from the RX descriptor or transmit the skb. The stored values
must be ignored there to keep their behaviour consistent. So the wrapper
clears the flag. A driver that supports them calls xdp_skb_ext_to_skb()
itself, as ice does in a later patch.

xdp_skb_ext_to_skb() is based on [1].

Link: https://lore.kernel.org/all/175146831960.1421237.9105904582430357235.stgit@firesoul/ [1]
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 include/net/xdp.h |  7 ++++++
 net/core/xdp.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index d8b77d80bfbe..7c9a812b6e86 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -329,6 +329,11 @@ static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
 }
 
+static __always_inline bool xdp_frame_has_skb_ext(const struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_HAS_SKB_EXT);
+}
+
 static __always_inline u32
 xdp_frame_get_skb_flags(const struct xdp_frame *frame)
 {
@@ -503,6 +508,8 @@ static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
 	return (void *)ext + ext->chunks * XDP_SKB_EXT_ALIGN;
 }
 
+void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext);
+
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index eea04e7b7204..9f311b3c0d2b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -829,10 +829,10 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 
 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
+	if (xdp_frame_has_skb_ext(xdpf))
+		xdp_skb_ext_to_skb(skb, xdp_skb_ext(xdpf));
 
 	/* Optional SKB info, currently missing:
-	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 
@@ -857,6 +857,9 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 
 	memset(skb, 0, offsetof(struct sk_buff, tail));
 
+	/* The callers set the RX fields themselves or transmit the skb */
+	xdpf->flags &= ~XDP_FLAGS_HAS_SKB_EXT;
+
 	return __xdp_build_skb_from_frame(xdpf, skb, dev);
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_frame);
@@ -1065,6 +1068,53 @@ static void *xdp_skb_ext_add(struct xdp_buff *xdp, enum xdp_skb_ext_id id)
 	return (void *)ext + newoff * XDP_SKB_EXT_ALIGN;
 }
 
+static const void *xdp_skb_ext_get(const struct xdp_skb_ext *ext,
+				   enum xdp_skb_ext_id id)
+{
+	u8 off = ext->offset[id];
+
+	if (!(off & XDP_SKB_EXT_ENTRY_ACTIVE))
+		return NULL;
+	off &= ~XDP_SKB_EXT_ENTRY_ACTIVE;
+
+	return (const void *)ext + off * XDP_SKB_EXT_ALIGN;
+}
+
+/**
+ * xdp_skb_ext_to_skb - Set the stored RX metadata on an skb.
+ * @skb: The skb that is built from the packet.
+ * @ext: The skb core extension area of the packet.
+ *
+ * Call it only when the packet has the XDP_FLAGS_HAS_SKB_EXT flag.
+ */
+void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
+{
+	const struct xdp_skb_ext_hash *hash;
+	const struct xdp_skb_ext_vlan *vlan;
+	const struct xdp_skb_ext_csum *csum;
+
+	hash = xdp_skb_ext_get(ext, XDP_SKB_EXT_HASH);
+	if (hash) {
+		enum pkt_hash_types type = PKT_HASH_TYPE_NONE;
+
+		if (hash->type & XDP_RSS_L4)
+			type = PKT_HASH_TYPE_L4;
+		else if (hash->type & (XDP_RSS_L3_IPV4 | XDP_RSS_L3_IPV6))
+			type = PKT_HASH_TYPE_L3;
+		skb_set_hash(skb, hash->val, type);
+	}
+
+	vlan = xdp_skb_ext_get(ext, XDP_SKB_EXT_VLAN);
+	if (vlan)
+		__vlan_hwaccel_put_tag(skb, vlan->proto, vlan->tci);
+
+	csum = xdp_skb_ext_get(ext, XDP_SKB_EXT_CSUM);
+	if (csum) {
+		skb->ip_summed = csum->ip_summed;
+		skb->csum_level = csum->level;
+	}
+}
+
 __bpf_kfunc_start_defs();
 
 /**
-- 
2.56.0

