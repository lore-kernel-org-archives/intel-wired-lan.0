Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E560606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=GEELyVK8;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=X2tIq5BA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B70D812A1;
	Tue, 10 Nov 2026 16:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z47UnFdZ7x59; Tue, 10 Nov 2026 16:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 245018128F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329477;
	b=e8VoBzUMJ00glfuftrMznWUkh+9wEXaqHiDBWa3PbQFY5rUDLDUTAMCQ19zJ/FFyflda
	 yr6GTCil1RcnAt2M8p7s/4jH1M7RBnyTEfARvuNHrxKeJ8yxQdlBOpThYuGUnaqFKhmr8
	 NBy1vmXcXkZIT3oFHOxVUs7+lfdVz1vlan7bdqb1QIe+5pWe6A6Et70R5L+XOq2h0wPX5
	 eQc/pGByheOrYtJYS5IJekPfdDfIGHcHJtFvklshZjJpgrqEaAW6sxv0hjDyJeXXaoSiF
	 /0cFCdZxw/SLOeqcHtsDB/NwmQOBOd0IpsNqIYDX+N87YL66Oy/C2ZnBns/NrpEKeqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
	b=CLFfRqxYmM6QSdfB86pMKLCr5JmieFelnCc5GTQo+BQNElLO4u0kvTnK3D2JY8KE9sbG
	 m1FzhD4+CnDZJgySinETrxN1N5DlVmaJfWntBB52MGt5BZKw53sUJe4+ZX2SQ0sWlguSz
	 /rapQ38UnGUpMnO5M1H9tUG/3Gpanm+hYUg4vx16m1GFiNPGzF8I88Y3OTMJ2//WK7L50
	 bPTX5ndW2owbyCrXcZMPOBi0RmPKLLoodynAJx9wxl2q8p6yrirAXFVKgHmH0xtTgUC11
	 HH7Ocr66JImLZTJAil+TwuTVZqQhE35wa4phDRq4lp9KpJgOOUCn9ZrHLdhuI/1Ai8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329477;
	bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GEELyVK81M86XkBvvVOy9xyJmFVTxRODnNOezpGIEOhEVaB79oTNHz8D0y5vbJ+DH
	 Ud1/meP15MPLvljGQoanTAenF3RWMd4dt0Ne0XTnjGyQdfvVhfOGsvtZWoviLQ43ue
	 vBrbAVhiUpWSvGL41XrqdyRwjuQ+weIJtqJ7uW8YL+jce4F4ixjx5ja2vdSZikHbKu
	 LorJG8Em3LrTsuT46je22j9df5seZDYnKOWAsqmF0DREbe0CKgnlFgZ9tR7IWcHdlw
	 hapsWyQkuwoIkRO8i8O8nRrJEVHmb6uD3A3vE4NbR6H6YSrpYkeDW3ahnBDEXOODYy
	 Ajaq6943vqvug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 245018128F;
	Tue, 10 Nov 2026 16:51:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C409AAF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A973B407C7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puVCIfy2h3kS for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:57:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 667F74070E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=X2tIq5BA
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 667F74070E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:57:54 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b581b6b0e9so344067a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283072; x=1794887872;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
 b=X2tIq5BA8o775cI4a+p51UurO7AgBLZYdFouQMvD/Lf/mjHMk8ywV01oFwZEkCoGvq
 lgQ2OPUeH4IodXIN2LVy83dgf7V+JLi1/M19rzJtWnnP+fe1qAbADSeXKajIGCeOKvyU
 Z+u/hTbaHsWP85R5phUm8Jw+nitAHnGmArFPOV9yJI8QoV2pniznKD97WdmQQzdOR6p7
 0qeIRMHOO5wJvnINVxqMIeJkTffZ0fJa/lmjOuqjJFFvloFiRv4os4N2jLc072QYGbBW
 KV717Nkhbbxt7isZq+8f28tNoOXJOdfl7x4ClltyHF4BIgumZIgm4HQsBLKaVnm3W4Hf
 qfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283072; x=1794887872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
 b=graaCZXOd+ALModez1OtJ+LzlvkEuGv4el7rgYM+vHVNZrOuMYjAjTmyDIoVwSscl5
 4Mm7C9aPkpqkykc1F0lXkK/m/B8jL29K9ajZztn8lbtwZBo3oNi5UX1DQ+60fr8xHzbr
 0xFFhGsBts4lejJyQE/bPFx5RFGRQbhCNcXaR5G7weUOfNRNWE/98/SmGpiPWUGvz1Ko
 5XUu4c7xHEcN16nQwZbf554EwjKmb5lMxtJv7J2ZzorPprq5BS2/smSm+nOjPTV9W+TS
 MD3b7xU4CB0DUeJkTVp+Ir9c6jbLAP+yTWeff3niNuaFwdLK5R1oSJ0DvSSA4da/QGEL
 9rTA==
X-Forwarded-Encrypted: i=1;
 AL+hErFC9MStLWew90LR8Qd58yEg2Z0Tz1d5GtqCuKUf2G1UgOXp4M7IAlXF26awCHDK7hDB+YIGk5BnJw5WibClJBE=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/PHwP2nsnvjoI5AaGs6R1EqTiricElSIywEG7xljDR27jHNQyF
 pKuxzmpZITerwtCpMPSxeSCitKw1jkCsny5OvrfCa29wE2BQp/w6tAYEpPkAZ+UBgqM=
X-Gm-Gg: AYBFou0Ds2ZBbIzqDhvYlNd82gjD9nyDXBsLJWsnZEwK2gkWFbDpAwb0nmGbH/6egJS
 +fe8KeKmcn+J+f/PW36t0qJ9s+C+Ntc6R29oBbu6++7K+giN0UmFq/eQU4a2fuWEuglm8GdH8UO
 If9WOpu1JVb1uVJsK2qLk48U0dsUSdcmyRLbQez8ChCcnrPOc0qrWjo63nXp3CIAHw1+ZOHYubP
 LWLRyKk84Ug6dWCvCA2FsYkA2O2B+DM2BtVSYSsduppwGEi4lbzdgPOEnEMhypYysq91vjupzHb
 da82mRujJyiVBF7q2vVgm/QzmluHAzCrLGrTF4XuOjKLcUG2XBZxYXC7XoOFa4e/UaS7R3sdT+D
 K/8icom5UJSEtw5UP3TXVame3U4jpyr6ylvWHoGrW0nySwCi2JpGa9lvqBsNj3HBUEdapbZ0t+5
 SBGiIPjNwXuJqSX7CLbe0wjtH+vcKt9l4KMfr4BBuMy6ZxNl3f+M9NNcfMCqLgFqH/3URwuOF81
 pgshf5/63kKa8ploxhXX727/50Hl6aBwTjDUpABiptwudqchQfIGkpRdO1nYpBfVc3Td4vbR2Uy
 R+8MV+iCQSRXbuL0YFvMrUe2JcXjav8+JjRa9j7/vjJyagh1cl43QzU7s+6zYj8=
X-Received: by 2002:a05:6402:4489:b0:6b5:8200:5008 with SMTP id
 4fb4d7f45d1cf-6b756b229f1mr1030422a12.45.1794283072341; 
 Mon, 09 Nov 2026 19:57:52 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:51 -0800 (PST)
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
Subject: [PATCH bpf-next 09/15] xdp: add the skb-ext-pass XDP feature and warn
 without it
Date: Tue, 10 Nov 2026 03:57:07 +0000
Message-ID: <aec6f3eaaab68e0fa7e4d7ee24695602f08503e3.1794281983.git.tianyi@cloudflare.com>
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

On XDP_PASS, only drivers that call xdp_skb_ext_to_skb() set the skb
fields from the skb core extension area. Other drivers silently ignore
the stored values.

Add the XDP feature NETDEV_XDP_ACT_SKB_EXT_PASS ("skb-ext-pass") for
such drivers. veth sets it, and ice sets it in a later patch. User
space reads it with netdev netlink, and an XDP program reads
xdp->rxq->dev->xdp_features after bpf_cast_to_kern_ctx().

On a native XDP device without the feature, bpf_prog_run_xdp() warns
once on XDP_PASS with stored values, like bpf_warn_invalid_xdp_action().
For a packet without stored values, this adds one check of xdp->flags.
Programs on cpumap and devmap are skipped, because the skb is built
later from the xdp_frame.

BPF_PROG_RUN with BPF_F_TEST_XDP_LIVE_FRAMES builds the skb from the
xdp_frame and sets the stored values. It still warns when its
ingress_ifindex names a native XDP device without the feature, because the
check only looks at the device features.

Update the veth and bond feature checks in the xdp_do_redirect and
xdp_bonding selftests.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 Documentation/netlink/specs/netdev.yaml       |  5 ++++
 drivers/net/veth.c                            |  3 ++-
 include/net/xdp.h                             |  6 +++++
 include/uapi/linux/netdev.h                   |  6 ++++-
 net/core/xdp.c                                | 24 +++++++++++++++++++
 tools/include/uapi/linux/netdev.h             |  6 ++++-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |  8 +++----
 .../bpf/prog_tests/xdp_do_redirect.c          |  8 +++----
 8 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 4303593e5003..7979b1ad38c7 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -50,6 +50,11 @@ definitions:
         doc: >-
           This feature informs if netdev implements non-linear XDP buffer
           support in ndo_xdp_xmit callback.
+      -
+        name: skb-ext-pass
+        doc: >-
+          This feature informs if netdev sets the skb fields from the skb
+          core extension area when it builds the skb after XDP_PASS.
   -
     type: flags
     name: xdp-rx-metadata
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3eca92d3dc60..b402f8ed5096 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1304,7 +1304,8 @@ static void veth_set_xdp_features(struct net_device *dev)
 		struct veth_priv *priv_peer = netdev_priv(peer);
 		xdp_features_t val = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
-				     NETDEV_XDP_ACT_RX_SG;
+				     NETDEV_XDP_ACT_RX_SG |
+				     NETDEV_XDP_ACT_SKB_EXT_PASS;
 
 		if (priv_peer->_xdp_prog || veth_gro_requested(peer))
 			val |= NETDEV_XDP_ACT_NDO_XMIT |
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 7c9a812b6e86..7148e8ef00e1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -509,6 +509,8 @@ static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
 }
 
 void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext);
+void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
+			   const struct xdp_buff *xdp);
 
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
@@ -771,6 +773,10 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 			act = xdp_master_redirect(xdp);
 	}
 
+	if (unlikely(xdp_buff_has_skb_ext(xdp)) && act == XDP_PASS &&
+	    !(xdp->rxq->dev->xdp_features & NETDEV_XDP_ACT_SKB_EXT_PASS))
+		xdp_skb_ext_warn_pass(prog, xdp);
+
 	return act;
 }
 #endif /* __LINUX_NET_XDP_H__ */
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 9026e0414fbe..a450e63cb941 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -25,6 +25,9 @@
  *   XDP buffer support in the driver napi callback.
  * @NETDEV_XDP_ACT_NDO_XMIT_SG: This feature informs if netdev implements
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
+ * @NETDEV_XDP_ACT_SKB_EXT_PASS: This feature informs if netdev sets the skb
+ *   fields from the skb core extension area when it builds the skb after
+ *   XDP_PASS.
  */
 enum netdev_xdp_act {
 	NETDEV_XDP_ACT_BASIC = 1,
@@ -34,9 +37,10 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_SKB_EXT_PASS = 128,
 
 	/* private: */
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = 255,
 };
 
 /**
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9f311b3c0d2b..36d6bb38b719 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1115,6 +1115,30 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 	}
 }
 
+/**
+ * xdp_skb_ext_warn_pass - Warn if XDP_PASS does not use the stored values.
+ * @prog: The XDP program that returned XDP_PASS.
+ * @xdp: The packet, with the XDP_FLAGS_HAS_SKB_EXT flag, on a device
+ *	 without NETDEV_XDP_ACT_SKB_EXT_PASS.
+ */
+void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
+			   const struct xdp_buff *xdp)
+{
+	const struct net_device *dev = xdp->rxq->dev;
+
+	/* The skb is built later from the xdp_frame */
+	if (prog->expected_attach_type == BPF_XDP_CPUMAP ||
+	    prog->expected_attach_type == BPF_XDP_DEVMAP)
+		return;
+	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
+	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
+		return;
+
+	pr_warn_once("XDP_PASS on prog %s (id %u): dev %s has no skb-ext-pass XDP feature, the stored RX metadata is lost\n",
+		     prog->aux->name, prog->aux->id, dev->name);
+}
+EXPORT_SYMBOL_GPL(xdp_skb_ext_warn_pass);
+
 __bpf_kfunc_start_defs();
 
 /**
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 9026e0414fbe..a450e63cb941 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -25,6 +25,9 @@
  *   XDP buffer support in the driver napi callback.
  * @NETDEV_XDP_ACT_NDO_XMIT_SG: This feature informs if netdev implements
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
+ * @NETDEV_XDP_ACT_SKB_EXT_PASS: This feature informs if netdev sets the skb
+ *   fields from the skb core extension area when it builds the skb after
+ *   XDP_PASS.
  */
 enum netdev_xdp_act {
 	NETDEV_XDP_ACT_BASIC = 1,
@@ -34,9 +37,10 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_SKB_EXT_PASS = 128,
 
 	/* private: */
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = 255,
 };
 
 /**
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c42488e445c2..c61b01c58342 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -625,7 +625,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -646,7 +646,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_NDO_XMIT |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -663,7 +663,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	 */
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -678,7 +678,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_NDO_XMIT |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index dd34b0cc4b4e..e1cd3b951dac 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -170,7 +170,7 @@ void test_xdp_do_redirect(void)
 
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_src query_opts.feature_flags"))
 		goto out;
 
@@ -180,7 +180,7 @@ void test_xdp_do_redirect(void)
 
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_dst query_opts.feature_flags"))
 		goto out;
 
@@ -195,7 +195,7 @@ void test_xdp_do_redirect(void)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_src query_opts.feature_flags gro on"))
 		goto out;
 
@@ -206,7 +206,7 @@ void test_xdp_do_redirect(void)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_dst query_opts.feature_flags gro on"))
 		goto out;
 
-- 
2.56.0

