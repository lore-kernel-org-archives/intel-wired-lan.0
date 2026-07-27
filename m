Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D2FC54F4D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1653D80E7B;
	Mon, 27 Jul 2026 16:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQST0WaDG10m; Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6731F80E82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169206;
	bh=1XKcSH10NxhyObCdsXRn5dtH9ICKV5W4CaAB3/o++lY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OLXsJSp9uG5QhpdnRe43r/BvMju4ZPH3ie1VrHNb9kVytp55ZX1Kz70/4dkp8Rf3V
	 WO6LlMJT7H6oa6HnYbxodL/9iEXYsjXcwH41rh7FyUcIVLAsZZanuRju4Jv56BUHk7
	 WuDS7nA9H9yvsloF8d4ZDBj2O9CvUdQSuV0T/bKR5sD0XNi9WFCdmJTaboNG603Vyn
	 77lWr6g/Xakaak6kgRkayCJhpew/cKDs4zd/M8we+RZJlwTcHeSczSUik0+PmFk0z9
	 rIU2Rsbwq/3k7AFIXkp+XY/Msaacm43OsMBk+Ee3Mj2FwyvjoIKX59u9rrOF2+/aAy
	 4A8A629HnIRvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6731F80E82;
	Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C8696357
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA73C40729
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tllx3eksp8e6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::1;
 helo=mail-pj2-x01.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 18CBB406FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18CBB406FC
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18CBB406FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2ce7ac92dfcso26873145ad.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169203; x=1785774003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1XKcSH10NxhyObCdsXRn5dtH9ICKV5W4CaAB3/o++lY=;
 b=XLgu+9WnoIGxW8gdvkgK6SdPormysrQx75fi6WidvP8cVf/XL575IHRnKrzVB6ybYq
 irrE22ybkUfDnfrzdx8FTcbhSEwfTvFIFTG+5kDvZNj8MPPz/saC+a8fsXQtM0SOAKrE
 E1Fzg5pil3DHErfFyO9K2DwIy8j5RxgxF6BZHuNiXDvvyA3LERj+R6XjFPBB8BNQ7cY8
 Q57x3v9ccDagc6cYHvXJLPi9DthREKYP6QrdsgnE15RUYLA18ICHDKTKaYVbzaRLDvLW
 Tto0EVEY6aMeEeMF5/TxyNxbzz0n5fd0B8uGP4lLHdQQGPYjz+wtkTOElWQOAaIohBvn
 3I1A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro239XE1TxEKXEUOY84WIeIDrOI4ErJur+5dkcffpVOqRDiWxeziscgqoHhhdiBgoTbUPDyKe0jxG6uZTbIY80=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yxx/AqjWFwrOk9eUosMM9KWmgp7KtTnlNM+33PFBVCx/CGF40UB
 xv/Gc8WgoyNrN3r+73L4mBzQajKJ7N8+nxgFT07RytePqK10vi5WU+1B
X-Gm-Gg: AR+sD13JuOYgSBuOGUwHC4EAgZThATZ2Z+PfSZZ+MK69FzwK8NzaVSaxxdzwvNvcgGF
 porZxTe38jMGOo26D2nqfXLe6p8fyfDDSJuVN3FkcgdmAC3S2u4UJ/iV5RAfgSVhxyuJmR7MbL+
 f/kNYNLmC7/2DDVwThq3TFQT8xMAMzhadCq3J1bDs/S/LYn0mEnKkKVVrQ4nExGqwef0pt3ICDz
 +BQaR9UZcU8RWeJ7qglwdPb0mY72PpdlANkjZxNQNb9FoELefmI2U5FXpX58hhhD/z/vj0m6iUy
 gbgxiRV1olTgAKz/u54z8K8ZuRCGU7z8rNIjxRzCw4n59yzUHJwKHC3SzDYiu8N/iio5FcIkd+0
 PW8LGSSMXIDJAhf8/TzqabTBL6KxUMiPbeANVyV0DkLwzeIsh+vJr+UC0iE4gfMbsx6Y6qBP0P8
 Qbeovm
X-Received: by 2002:a17:903:3808:b0:2ce:9439:59a5 with SMTP id
 d9443c01a7336-2cfde878665mr86179875ad.36.1785169203061; 
 Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d00599b631sm8906615ad.42.2026.07.27.09.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:20:02 -0700 (PDT)
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
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Date: Mon, 27 Jul 2026 09:19:56 -0700
Message-ID: <20260727161959.885642-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169203; x=1785774003; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XKcSH10NxhyObCdsXRn5dtH9ICKV5W4CaAB3/o++lY=;
 b=JOPjoeGP4DC2RX94hbDuilQfbNrljwzhczNO+e7lYNHzLweJ/vKohmfDICT3likOqr
 3mXkiIZW6P7N4g/Du0syc5ym/kjVpX771i5gqwPutNLKNGGFRIN3k4CqgsFLxSlifs8z
 ne8pp+7sGRJNo3HfhjXkOyfgQrx5+bSD2/bXV+Ok/elQwrm+eKZsoVjNVmDkgipp/hLh
 jMwG6XHzZX5Fp4N44MjpkGgKtLuWCbChl9A7ewO+8so2OnkuoN67ni6haUwMqZ2pSQfl
 v+WCJySHBgg3z4zkaz0UfaX5kI+VSjQTOip8Ns9FYMAPm1RV9qdgUYkT9s7p0WSXT7Qa
 9vmA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JOPjoeGP
Subject: [Intel-wired-lan] [PATCH net 3/6] xsk: clear metadata pointer when
 no timestamp is requested
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

User space can change metadata flags after request processing. Rereading
them during completion can therefore make the kernel write a timestamp
that was not requested when the packet was submitted.

Clear the metadata pointer during request processing unless timestamp
completion is requested. Completion handling can then use the pointer
itself instead of rereading the flags.

On the mlx5 multi-packet WQE path metadata is evaluated per batch:
xsk_tx_metadata_request() runs only for the descriptor that starts a
session, just like the checksum offload that is applied once through the
shared WQE. Only that descriptor's pointer is reset, so completion
handling can record a timestamp for the other descriptors of the session
regardless of their own XDP_TXMD_FLAGS_TIMESTAMP bit. The write stays
inside the metadata area; the single-WQE, other zero-copy, and generic
paths reset the pointer per descriptor and are unaffected.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/xdp_sock.h | 14 ++++++++++----
 net/xdp/xsk.c          |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 06c081feff42..2b2eb9b9d580 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -141,13 +141,16 @@ INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 					    struct xsk_tx_metadata_compl *compl)
 {
+	compl->tx_timestamp = NULL;
+
 	if (!meta)
 		return;
 
-	if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
-		compl->tx_timestamp = &meta->completion.tx_timestamp;
-	else
-		compl->tx_timestamp = NULL;
+	/* we can only arrive here if the completion timestamp has been
+	 * requested via XDP_TXMD_FLAGS_TIMESTAMP, see xsk_tx_metadata_request
+	 */
+
+	compl->tx_timestamp = &meta->completion.tx_timestamp;
 }
 
 /**
@@ -182,6 +185,9 @@ static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
 		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
 			ops->tmo_request_checksum(meta->request.csum_start,
 						  meta->request.csum_offset, priv);
+
+	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+		*pmeta = NULL;
 }
 
 /**
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f906d51b6699..fcc6f17f3576 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -998,6 +998,8 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
 		skb->skb_mstamp_ns = meta->request.launch_time;
+	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+		meta = NULL;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 
 	return 0;
-- 
2.53.0-Meta

