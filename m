Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF9606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gCOBLL9y;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=V5U7tDfm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80FDF4074C;
	Tue, 10 Nov 2026 16:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiGj_2XxHpct; Tue, 10 Nov 2026 16:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5E624081E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794329478;
	b=IHEnwxcjydmVQiwj5Dk+bhUJlNJLSIVQEV1J1/pewGoTKApsL++pXLFbVWnFBQE307C9
	 mdirMG56ecHHhmaG3y3vDodYeLOhmtlPeCQA0nQ0Iud6MO3a4byInedmg602tKDpVKpu2
	 s0D+QaXg5itrBFFmvmT77Rgb4zOz+iJml/ahNYiJ2zweK5ZH9MLogv7bo77dMvlD1Sthd
	 qjRwhEUOm6cDdhSGI5ukUvtgFTZj4T5lnUG3NiokDt1RozlRfIo1cbfWYD6XuMQQFrDwG
	 G0A7q0A0H6NiexuWlwB+3ZZ3FD4/W1iq6Gz4bPm6T8jwgSd2BTCjCaiJzr6fzw1BnJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794329478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
	b=st/apfRq373Clf4NXUvL+CkmJUUBT8X/ZOLw+wxCOmyLcjqzYr44Fc/UuvFQg8PtAlhC
	 fJxqkVkljL97R8ULzLXQIYIK5pntJ1ehnj7C90IKXDXZHIy0MYv543lyYoOy+7wDi5MMy
	 MU7jtOPezzHSBUVddnP/Jzy1BvKvkBs0keVtFMQazosOlyXiiZfXE+LjBjabEvAj2/IMj
	 2sfIEFkRLkEWxud8JsZyy0uBRjVIrQ2hAaEqnok8pUGF8hf4JwWp9M7yVdkmQUcK1tyUc
	 a/M35h0w5xxcEoDTvWY3h+AhHd5y+qHmjo9g0uDdEQGOJDf/w8HYuUQh2c627JWN9VQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794329478;
	bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gCOBLL9yZk1tudVqrb2zLB9jmDlqCV0bjPeXhQ1Vw08eJu+pFzr4F3/mZqBX903LJ
	 39LJQ312Iyqdu8kRsLRXuHQncNIxMPnOVhY8Q5LXT5WvRN8a7RBki0nBPcEf5i2tml
	 nqti7jVJ9jWwBa95ZlRxj4WcOhngORaHb3oiBIo50x1ovzTI6wWxO0JfNPu+QiRS9V
	 7wbaMixUkalXybfblaRK+l9kkDbgKPpKKVvEIWjexk2tjZXfdR8X8OL1dEdg7q1RNk
	 Y5YXpvDsE1I+zjNxvmSkE29+ra4AsB2X/qL0Y7Li/UrOplRrMT4clx0Yx3+m61CBax
	 uOM83X9jjbMew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E624081E;
	Tue, 10 Nov 2026 16:51:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ACAAF335
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E5DF60803
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HkeXDpaPeHlt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 03:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86A13605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=V5U7tDfm
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86A13605CF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 03:58:02 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b75712fb57so693496a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 09 Nov 2026 19:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1794283080; x=1794887880;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
 b=V5U7tDfmWwBK1jaPygBJxThocNOtTGc5H9rsB5qwfScYKy/xBc1Z+7CPDHgHcNZlmD
 CoRnCISQz6FQkAoAZ0W9PfdTYUGE+z0UGdc1eH7a7kv0XsXrqQsV6vh9rZUuLfgohGvD
 OWlbapqKDruB2xG5aM0u4IoLhAPtLsI4TCtEJPoI5FqgbtvZGynGA6dm+u4vHVE1B3u/
 sBKJ2FfYSDK+cRAm54+leRgi3Zn72gv1HOJxTCSP2dLYEy1bBy8xFp9c5duKRBfMK2Da
 5EaMoy2F4dQFFSJQHhdcyXgJOuwFKvUpnjtUGsRu4ACFbKeJn3gun0eEDeu0P+fy+vq1
 qGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794283080; x=1794887880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y1n75dlSKXk28YfIHQIdOaiTcHKQaKmSFDKJym+w+lI=;
 b=SNmnP2V5urmQyYBDadeKQB/YlyjvDdEImWSD9UFkRBRHaKB/jObgS+S3FmSkDgw+CM
 UJpOO0p4vHVXHSj6qvbLYuBMLp03r2Aus3Fx4QOj6fEFrDBt1quV8CLwqrLsfqClxCYc
 Wy6Jzxc17rc4WnS42trtyzjzaTEgTy0PiBbiMvpHD3y3VqDwi18LdsaRXve16o2XbJvH
 Q5AHHL1zn+ahRHOJIMu9NASoQn9Tr1taO15oxqOIenkxYZH74EtyMe1fa0TUp0UMzfNt
 XhM4yisMGMxKNCYkc0RMdgPUnoz3D0cI/KJZdkohUumPKUZWWl1+IRRCHx8U8H6TRZZW
 TZ+w==
X-Forwarded-Encrypted: i=1;
 AL+hErFMgs9JfIIVJsaWnAbr4WxHUQ9PEOAhWLBtC9GkMEnY2pzXY60CJ0r6BklMLPREoARiceqgJQF0VfJbBsXlFB4=@lists.osuosl.org
X-Gm-Message-State: APuU4Z95IVk3tRAtTkSC1qyv8805OCaEUbPQVwZRhP3jnQ3/LbD3Z2br
 f7SoTT38m7bBe+QAlDfbLiuborSsy/fxRW64aerrRMhH24BJ/QH7wcJ2YDDXG+Sjo30=
X-Gm-Gg: AYBFou3FEYxPTEYg3NZ3jyCpDda1ltl1gBOF+dTAHVPJFYZkKdAxV/2kfWw0eouojdT
 49ZiQ+cfvV+CE3NvJddPIT47OnCX4bmjypWOsMB3ol8paURwuAhR5kecoBDq9hnmh1VWQpwZUHq
 Ps+Y+HBTaM8hT4u5B+iFpsAEulMd1nbE7EnqbSvvSL2kPT1AQb79qkLz3yixqTzae44gI48zsfJ
 98EEcGs4BtPyb4za17/Hg1bRlivhgQ0YJUZ7oNfI2193RI1iUlOFysVeohLMjy6RPyWdytrci09
 Ze/5ilx2UBKTmJ2DV4OUWCeNN5j02+hlLNNmlYzV1MAX9vT3j4FeJcHLFCU5Th6pssbPQBcJlIa
 8gVTHLYKfY2WPM5FM35qmT0Jn1BZuEIlI8AygwfS8sKvpD1/C9jjaI/Inh3QHrd9ZFKnl0DLKB7
 RqL4xRUnvUQWG0DadyKjTEjxXLpM9rb/gBn/3NvkEI1+lXUvovu28uLOSgAUUHiCWBwX+VA/Lq4
 IKe4RMXC69oTIJZqsIUBnysQnKHGLoU2Ld+rG/1zSp1smNveqmszmEfA2IOFEWUeNfoi1EGNlJ6
 td5JwgsZ4S/prBLT1NhLKN4NQ9lER1ZP7ylR73GsG0q18IUPXMKENPqLFE6F9QU=
X-Received: by 2002:aa7:cd92:0:b0:6af:a64f:bd44 with SMTP id
 4fb4d7f45d1cf-6b756b0d218mr745095a12.45.1794283080043; 
 Mon, 09 Nov 2026 19:58:00 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 19:57:58 -0800 (PST)
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
Subject: [PATCH bpf-next 11/15] ice: set skb RX metadata from the skb core
 extension area of xdp_buff
Date: Tue, 10 Nov 2026 03:57:09 +0000
Message-ID: <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
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

On XDP_PASS, ice builds the skb with xdp_build_skb_from_buff(). Then
ice_process_skb_fields() sets the hash and ip_summed from the RX
descriptor, and ice_receive_skb() adds the VLAN tag. The values that the
XDP program stored in the skb core extension area are not used.

ice_clean_rx_irq() takes the skb core extension pointer from the
xdp_buff before it builds the skb, and passes it to ice_receive_skb().
ice_receive_skb() calls xdp_skb_ext_to_skb() right before GRO. The
stored values then replace the values from the descriptor before the skb
leaves the driver. ice now sets the skb-ext-pass XDP feature.

Zero-copy is not supported in this patch. ice_clean_rx_irq_zc() passes
NULL for the skb core extension pointer to ice_receive_skb(). Hence the
skb-ext-pass feature does not cover AF_XDP zero-copy queues.

Export xdp_skb_ext_to_skb(), because ice can be a module.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 3 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 3 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 4 +++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 7 ++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 3 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 2 +-
 net/core/xdp.c                                | 5 ++++-
 7 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 454fba07d4ec..cb619689d11a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3461,7 +3461,8 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
-			       NETDEV_XDP_ACT_RX_SG;
+			       NETDEV_XDP_ACT_RX_SG |
+			       NETDEV_XDP_ACT_SKB_EXT_PASS;
 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index a730aa368c92..90f2ce5da022 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -52,7 +52,8 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
-			       NETDEV_XDP_ACT_RX_SG;
+			       NETDEV_XDP_ACT_RX_SG |
+			       NETDEV_XDP_ACT_SKB_EXT_PASS;
 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
 
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2c7c4962882..06a1a5fdc43b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -966,6 +966,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	/* start the loop to process Rx packets bounded by 'budget' */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
+		const struct xdp_skb_ext *ext;
 		struct libeth_fqe *rx_buf;
 		struct sk_buff *skb;
 		unsigned int size;
@@ -1041,6 +1042,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		continue;
 
 construct_skb:
+		ext = xdp_buff_skb_ext(&xdp->base);
 		skb = xdp_build_skb_from_buff(&xdp->base);
 		xdp->data = NULL;
 
@@ -1061,7 +1063,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		ice_receive_skb(rx_ring, skb, vlan_tci, ext);
 
 		/* update budget accounting */
 		total_rx_pkts++;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..85439853596f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -247,17 +247,22 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
  * @rx_ring: Rx ring in play
  * @skb: packet to send up
  * @vlan_tci: VLAN TCI for packet
+ * @ext: skb core extension area of the packet, or NULL
  *
  * This function sends the completed packet (via. skb) up the stack using
  * gro receive functions (with/without VLAN tag)
  */
 void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
+ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci,
+		const struct xdp_skb_ext *ext)
 {
 	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
 		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
 				       vlan_tci);
 
+	if (ext)
+		xdp_skb_ext_to_skb(skb, ext);
+
 	napi_gro_receive(&rx_ring->q_vector->napi, skb);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index f17990b68b62..cfc77847696e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -133,6 +133,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       union ice_32b_rx_flex_desc *rx_desc,
 		       struct sk_buff *skb);
 void
-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
+ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci,
+		const struct xdp_skb_ext *ext);
 
 #endif /* !_ICE_TXRX_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 0643017541c3..f64659dc8313 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -670,7 +670,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		vlan_tci = ice_get_vlan_tci(rx_desc);
 
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
-		ice_receive_skb(rx_ring, skb, vlan_tci);
+		ice_receive_skb(rx_ring, skb, vlan_tci, NULL);
 	}
 
 	rx_ring->next_to_clean = ntc;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 984299199906..fdda072a5858 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1086,7 +1086,9 @@ static const void *xdp_skb_ext_get(const struct xdp_skb_ext *ext,
  * @skb: The skb that is built from the packet.
  * @ext: The skb core extension area of the packet.
  *
- * Call it only when the packet has the XDP_FLAGS_HAS_SKB_EXT flag.
+ * Call it only when the packet has the XDP_FLAGS_HAS_SKB_EXT flag. A driver
+ * calls it after it sets the skb fields from the RX descriptor, and sets
+ * NETDEV_XDP_ACT_SKB_EXT_PASS.
  */
 void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 {
@@ -1115,6 +1117,7 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 		skb->csum_level = csum->level;
 	}
 }
+EXPORT_SYMBOL_GPL(xdp_skb_ext_to_skb);
 
 /**
  * xdp_skb_ext_warn_pass - Warn if XDP_PASS does not use the stored values.
-- 
2.56.0

