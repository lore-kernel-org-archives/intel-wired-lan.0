Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D154C54F4C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F195880C10;
	Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBVGkrogrpWs; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DA6E80E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169205;
	bh=0IHSYEqP/JaWlXEBlk0DX7t1dhJCuZAYJeNyk0qp2ns=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oRs2EJ82SgFfh7b1ZF/vQBOCW01pnHnOZXqpCbZfBKrnyLrZ+1dzH9DiEBArpDQMP
	 TUIQwtgITzI1LMoGmUD8J0Fxrh9dVykuV5Ysma+vu4vmRGwZDcEWboc//kwIP1Ou9G
	 9b33IiXTtI2MMcxqdMwmdEQll4PY+aTOjeA8SFzxg/I7yrGw1QZjZFdTQQIxPM8S4S
	 L2f0cV5LubQQDxxas2X2T4JIuZKAgvwHwBxpDg47Z/Reu9MiegD1IdRpe8khVfAlOT
	 gBG/Q4JvZNP6mGr5IDvh6W61JIROC1c8DTReZcQhi19Z2a1ZPfMpFCuhFmLKlYRPa3
	 I5wsNLg0FO5gA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DA6E80E7B;
	Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 233663B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15A7C60632
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_F8pzNpwpIN for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::2;
 helo=mail-pj2-x02.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 39AE260712
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39AE260712
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39AE260712
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:02 +0000 (UTC)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2ccbff2e6a7so17921315ad.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169201; x=1785774001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0IHSYEqP/JaWlXEBlk0DX7t1dhJCuZAYJeNyk0qp2ns=;
 b=KLBYdQjvxtzIJX1qImQU9f8s9BUs0A2ga7Eva5dC/YnYD5jsSK0J6S4sToA+NRpT2v
 gc+aiMWwDucOK4/kjRzFZr6FifpO3T0BWWm+RO4Na1mNjHunwCLglnEphRYK0JU/XuwR
 LeNQNUiExDgGTBSQ+0EoJ26FGEY6uhnKdAupuUjIr9esQI391nFwYJ8+thIeE6U1nHZh
 RzOBGnTy5OJ2aNmB3wZGdSkOe7H+ajfNewpKbJhTJNG4+s8LoEjMONvAb1rKn1duqyin
 P1BODo6fDGVnS2g96jScQxAzLJbq8vAZSjkKVx4u8ZOJbUMf0/FmljcKnvjnrLGP8AxN
 v1xw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqh/pSeQYDdPedLLdUT/A+OP7WuVnDrDFvQI1C9rDBY510TofhSq2opuU3dhpP4O/NgvfaKoX+2VMOlhKHgxJo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzZZCT/BZueFCvHRio8MZK9Hbpt7X95N7j0zssMlJYSvLUzcd9Q
 iaG3FkBENth6wWFTkD7fkBqoSgBsTIBUvP8cUNXzKYLvbiW9fM/NqMr9
X-Gm-Gg: AR+sD108E54iZvqip4m/rLzkclBZEQpwk75TvBIBLcDdqB8Op5+IhKIj6ukE6ubt1mu
 NKgRpzNh1SxJnIqHXeF29O5UM6AkqU7ICTUVy4BvNNRyqHcl7Ne+eIJ8wCT2ND8LikCYtZmhanL
 0Vfz018dXVp5Tb9XqEP3K+9M1C0F33jioUuVygDpgpCmnkXDnarVHZBnRYzaOdvuA51to6gY+pB
 vQy7nTGBFiFB7dgxCNMqnz+mFZfRykUZ7PM37VMWxIVoh7rad9Fe02oL6Eq4E1EknZJrhnVCet6
 pNaNGqL5dq2XyW9zmUDYRlUcyUeWGU4ttg0LJKzFvafWa3dS7kRY6ly+KkWPcv/zx2GllrOzXla
 kJN0qu7nnItmRBPOhQDVM5IzgOhh7qyHGD4Fxdvcy2rcXHl1v2GmTXzrB0n5QG5w4qN8=
X-Received: by 2002:a17:903:2f4d:b0:2cb:3f5b:6663 with SMTP id
 d9443c01a7336-2cfde78b5ecmr87867845ad.11.1785169201307; 
 Mon, 27 Jul 2026 09:20:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d849sm37758895ad.81.2026.07.27.09.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:20:01 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aleksander.lobakin@intel.com,
 horms@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 witu@nvidia.com, alice.kernel@fastmail.im, dtatulea@nvidia.com,
 yoong.siang.song@intel.com, martin.lau@kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, leon@kernel.org,
 AutonomousCodeSecurity@microsoft.com,
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Date: Mon, 27 Jul 2026 09:19:54 -0700
Message-ID: <20260727161959.885642-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169201; x=1785774001; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0IHSYEqP/JaWlXEBlk0DX7t1dhJCuZAYJeNyk0qp2ns=;
 b=lkMIr8/hzYBIDjOwkudhnkO2Rk323CfsZX6yf/Jfy7TlnwhCL+Pr1egkL2xKwsszg/
 ia8yYR/EYGd1tA5Zsh/AIWZKMo57QGRmHT11B7Q/75zZsbC9LjnKIWNZzMM5dDhGoInB
 m9DsJZL7LmCn3NakGtL2MCie5ISi58HMtDYdb6zGLA666wJj3KYklXyJ2yCAyBdav4bA
 +QAnkaZRCvsMEB2VJSMq67p5kHka5vUXUSygy8gaIHAk0dENPSCw4OIMe4nJ5WdIO9PM
 AfXHE5oU//LOHf73nCqvSkOp3Dl21FEEAou4Mc9suy9+EnVTjunYgBkaM3EqyZ4wh4eA
 5XlA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lkMIr8/h
Subject: [Intel-wired-lan] [PATCH net 1/6] xsk: require at least 16 bytes of
 TX metadata
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

AF_XDP accepts a TX metadata length as small as eight bytes, but every
supported request needs the flags plus at least one eight-byte request
field. Such short metadata also lets the kernel read beyond the registered
area.

Require 16 bytes rather than sizeof(struct xsk_tx_metadata) to preserve
compatibility with applications that do not use launch-time metadata.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://lore.kernel.org/netdev/20260720155210.34229-1-blbllhy@gmail.com/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/xdp/xdp_umem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 58da2f4f4397..cd8643360eb3 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -210,6 +210,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
 		if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
 			return -EINVAL;
+		if (mr->tx_metadata_len < 16)
+			return -EINVAL;
 		umem->tx_metadata_len = mr->tx_metadata_len;
 	}
 
-- 
2.53.0-Meta

