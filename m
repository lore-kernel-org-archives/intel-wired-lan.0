Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAA606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=P/6AvQ6B;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Aed3gQE0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7B7D40572;
	Tue, 10 Nov 2026 16:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vtVnqORtvrOn; Tue, 10 Nov 2026 16:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B393D40582
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329473;
	b=QjU7+F2+aFB6uwIXs/yzkPDJfiMDHMlMh84zJDq3ltFOHpHZ1ahLaOlOu43oSyd1vYok
	 owVw/XS9nJkE5w7u1rFChKUV2FDTjWYy9JNV0Db9verlyiwuKzxdwbGKlX9+aSitFzcfA
	 lpZ33/+qvpSkno5KmAK1Q8ZFnt50KUwPzLhX6o7TKr9Amv4CEPG7GbXVo3+8kGbae5udn
	 3Qri0as86q7Drk4G7L4uGEgCex0MYB3bjWVfbDnKylBV3xxezm5LgcGvtSjBiDP9CsNeL
	 jqd5rI74GR2UhnYObQx+elCmDHlvv9r6ZlSO7l/nmX0GeR5JfPzQLe63biZAvDFyjUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
	b=LP/EURKR4OmFN/B+n+tdovzHT5H8fueQLud8OBAcHIozi78UyuFX8s8wrkklvwhqiqjH
	 5X21GGAg/uDjUGtmETHOychcvaLgVjTsygb8E8uGiXV2aKGGq/KifGXopsTR7i+M9Nc8R
	 6Lw5axa/F65ZoWk/8NnP9nJvMygIfNC1AcZy6cC1sVry69mB2Er8gXybysH2LehVf+wak
	 hjYQzWY7SpASLRPQRnFoT1yXUNC5Zbo9w6W/3rTSCk7CkmSJT0SPamFoQf80XKMhvHpqX
	 AmcdUbRf5/3IbDX+BT+80DrOPpWe6mPavSvOqLTyq97CX3ILhvSOfFrG/BlY/Xubcrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329473;
	bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/6AvQ6BfmNz65Lfla4R8YWf2lvwiMD9/LT1bphoT9dmM10t8bgVSO0XQjFvr2mwQ
	 qKXOiW7UUvNM6M47JJk6L3aGS9+fVRG3BnHjKcgDab14NrHv79NKC+w/OpO0FoC4Au
	 9ueXIPY5Wj0YAyLPCAG+dBGYNXGstR9yHM2SHhR7JaouEkYoBOYEAyBiDOrJDppHZX
	 L+tl3s4Yf7fke6ul2l1nt1OfzB8M4JSmggtzehSQpi80ozsBxVQ9AeFKUTlLF1R71r
	 zCU9VNES5GWq8lZ6vfXYaOAerpIEPN6kBdCFk+EfXJbEp2Vque/7yfMf3TTTMBygvG
	 HXWTDn72z4Erg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B393D40582;
	Tue, 10 Nov 2026 16:51:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3E36AF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA03E809EE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJVH5c6FiUAC for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F8D1809BB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=Aed3gQE0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F8D1809BB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:40 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so2381008a12.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283058; x=1794887858;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
 b=Aed3gQE0BF9k4em2MVBBF50qAVXi0K/mnLkvJ0ifOnyyGG4SLqKFyWthjTYwquErDE
 0VGCRS5hssB9UPuSoLIip8C1IT1AKLCdzWS1AIuKaH8JGAPjdLB6yJHppK78wtGgosfD
 277CgJuyLc3LLXF6JKoqwx6v76qrzq0efdfdGOnlG8EGUkXM0q3BYZJ83PQS8Z2jcaKq
 Hkvks4aRHpBayWFZFtvNx2EEAtJufE9E+4Nwu+wStKdWartZERwShSDHIAj6rS2lbKHo
 wOb2SxhJkjH6rFSwtb6m7Us/lF1S1x+cY3nnoOAJi6GH9rXK55VxQHrpbyTKzGUyn/4N
 GeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283058; x=1794887858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
 b=qfg9iJGDwGLLwiOTyOWfWMOLKR0GOT3c6nKO7B5WdakMI4/roQ2MieEaes6dbWZLRG
 iO8A6xk6Fprjzs7ClUv4DlHxq8HWabtWvxfCfMzbMaNtlSeBdlCZaR6IHr1gFKfrY9at
 PeTrYV1lanMCjfN/SyqkyK4PvppKhCmL3bDN+ZpuEGk0AOfxA9U/+HkYcdbiclbJBXP3
 GE9adgZT4Elo+euKpSa7XLmpeDYWauz9qkJq7WtkY9X6gXH1wJxc1pwGbnqs0C3YfAL4
 iavIJmcZViubisZIva+Da5VmQ+6dxLXK3cjZ5Ibl2X6qnedOhVtt19sfy0LqwbpysFek
 ckcg==
X-Forwarded-Encrypted: i=1;
 AL+hErFrR3Zpm/5AbrNHAv3KocPiQmkjQFkp5IZVaUGKcCV7Ki6XOyWMmCZoNgTZVUYOmeZE+p7Q2fvuEV5/CKB/mRQ=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8BbfZik0motc96PCVb1t3JcFfyq3dSEAwSj1vXVsHvAoESXuz4
 KH7BOHCgTLFCLm9xCApQgs5ybnYmJGlaVANZEJknoiV6f3B9b1t3muMpHXUcq/8/DT4=
X-Gm-Gg: AYBFou2O2tiTmJzdlPby7hJ+xRDtDa63MfpcFobkIuMNzhOApcnFrYYQAJDse8izrGr
 wZbRcVgLPj+tS04Do7xiOOmIhQHrEpDkssgFa8VIXkH6K+mh3hEZLznCsh/BzlztGe5x/r6MmMz
 SFMyRrHtmoMuzv+eiqMmsz4ShGvRKjRMU9vKTVTz7qEWlSHl0ngGHTAfvWwpwGldZbdMOhx/dSG
 REwqHPohtD+Q5OU6Y8BrFgqbYqJBRqPsf+ufkUqsLoqJjTMGU7TdvUMMPU/QCGPyiJHhRuww1jB
 C8Sfy+HTgSywrPbwbZ6CCgL1200Jd/Mkh8T2pE1ZM73JwtANZ+wB7DfKlW7GMlBLJ/8m9Zd4aDX
 QXab/8eMUKeQyfSe/Sr4U/BDmtPVIFSzEeS9JvW6U8fz6Kx2Oh6z4zOLgFXaR+ykeehHfCSHNX5
 gl7Vn/4BUsMHXaNEi+GkOuX4CoRjOYhKvSvefFAtX8sJpmJxpYqfMF1jKaEAJlDL8AkVEEgxcsJ
 7yPEP6CK0c7E7+tHMmMP8TzdePrxsCut5zbSpeVkKvJh+NMV02RGKU0rfB4rxa9GKhrLCXKAUlR
 BUZ8t7bBTv9VF3tQJYU5cPbKG2hpcTf0XW7y7/b5pZlINr8At55kAn/lfjiVtTA=
X-Received: by 2002:a05:6402:4007:b0:6b5:8695:f839 with SMTP id
 4fb4d7f45d1cf-6b756b0bf4cmr1096174a12.45.1794283058320; 
 Mon, 09 Nov 2026 19:57:38 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:36 -0800 (PST)
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
Subject: [PATCH bpf-next 05/15] xdp: add a kfunc to store the RX checksum
 status
Date: Tue, 10 Nov 2026 03:57:03 +0000
Message-ID: <f17f2567802dde23ad1cf81b572e0834c6531fe7.1794281983.git.tianyi@cloudflare.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add bpf_xdp_skb_ext_store_rx_csum(). It stores the RX checksum status in
the skb core extension area. A later patch sets the stored status on the
skb built from the xdp_frame. The program can read the status from the
NIC with bpf_xdp_metadata_rx_checksum() from Lorenzo's RX checksum kfunc
series [1].

The kfunc accepts XDP_CHECKSUM_NONE with csum_level 0, and
XDP_CHECKSUM_UNNECESSARY with csum_level up to SKB_MAX_CSUM_LEVEL:

- Storing XDP_CHECKSUM_UNNECESSARY asserts that the checksums are
  correct, as in [2]. A program must store it only after it has verified
  the checksums.
- Storing XDP_CHECKSUM_NONE invalidates the checksum status, as
  requested in [3][4].
- After a decap, storing a lower csum_level updates the status, as
  requested in [5].
- CHECKSUM_COMPLETE is not passed to the stack for now, as suggested in
  [5].

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/20260630191510.81402-2-deliran@verdict.gg/ [2]
Link: https://lore.kernel.org/all/20260227153231.78d16b69@kernel.org/ [3]
Link: https://lore.kernel.org/all/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/ [4]
Link: https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/ [5]
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
enum xdp_checksum has the same names and values as in [1], so this
patch does not depend on that series. The series merged later drops its
copy.

Stanislav was not sure that any NIC reports a level of 2 or more [4]. A
separate maximum for XDP would give the same skb field two limits, so
the kfunc uses SKB_MAX_CSUM_LEVEL.
---
 include/net/xdp.h |  6 +++++
 net/core/xdp.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 23c976e92898..d8b77d80bfbe 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -701,6 +701,12 @@ enum xdp_rss_hash_type {
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
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 2c1d5ec3311b..eea04e7b7204 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1004,9 +1004,15 @@ struct xdp_skb_ext_vlan {
 	u16 tci;
 };
 
+struct xdp_skb_ext_csum {
+	u8 ip_summed; /* CHECKSUM_* */
+	u8 level;
+};
+
 static const u8 xdp_skb_ext_type_len[] = {
 	[XDP_SKB_EXT_HASH] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_hash),
 	[XDP_SKB_EXT_VLAN] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_vlan),
+	[XDP_SKB_EXT_CSUM] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_csum),
 };
 
 /* Limit the header and all entries to 64 bytes, so that a new entry
@@ -1120,6 +1126,56 @@ __bpf_kfunc int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
 	return 0;
 }
 
+/**
+ * bpf_xdp_skb_ext_store_rx_csum - Store the RX checksum status of this packet.
+ * @ctx: XDP context pointer.
+ * @ip_summed: ``XDP_CHECKSUM_NONE`` or ``XDP_CHECKSUM_UNNECESSARY``.
+ * @csum_level: Number of consecutive verified checksums minus one, up to
+ *              ``SKB_MAX_CSUM_LEVEL``. Must be 0 with ``XDP_CHECKSUM_NONE``.
+ *
+ * Store ``XDP_CHECKSUM_UNNECESSARY`` only after the program has verified
+ * the checksums.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @ip_summed is not supported, or @csum_level is not valid
+ *   for it
+ * * ``-ENOSPC`` : not enough headroom for the entry
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_store_rx_csum(struct xdp_md *ctx,
+					      enum xdp_checksum ip_summed,
+					      u8 csum_level)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_skb_ext_csum *entry;
+	u8 val;
+
+	switch (ip_summed) {
+	case XDP_CHECKSUM_NONE:
+		if (csum_level)
+			return -EINVAL;
+		val = CHECKSUM_NONE;
+		break;
+	case XDP_CHECKSUM_UNNECESSARY:
+		if (csum_level > SKB_MAX_CSUM_LEVEL)
+			return -EINVAL;
+		val = CHECKSUM_UNNECESSARY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	entry = xdp_skb_ext_add(xdp, XDP_SKB_EXT_CSUM);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	entry->ip_summed = val;
+	entry->level = csum_level;
+
+	return 0;
+}
+
 /**
  * bpf_xdp_skb_ext_del - Delete a stored entry of this packet.
  * @ctx: XDP context pointer.
@@ -1149,6 +1205,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_csum)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
 BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
 
-- 
2.56.0

