Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21092C54F4C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CECC580E86;
	Mon, 27 Jul 2026 16:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AuENVA7DQ5dg; Mon, 27 Jul 2026 16:20:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06D5580E8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785169209;
	bh=jOKl9cuatMBwnsyU1wJ+nM+sSfz+zrZVzuTsvqWf2Wk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6hiwiOEBayJd+SNxDBeb0tdDELXNbOsktnJ3d6rWj/MplUlQICzFxEHmj4ageOPyO
	 CVi7XJVW8DnmaG3H/hNCu4Z0HsFBYO4QgK0cs2UKQ1ZL7+WwrfdDY807QzrRQNJduP
	 yO8X1tz0Vd0lSMd8/5k9a7R/SS7kDO2ozexCFJpZs75RC768XpQn8smA6RR01gYhPF
	 Ke4+D7jLNSysIIQyCI2pa/JJRbIstYP0QVImHmaHKgWjX7ddJiqXsw9LheOEToI6Tw
	 5SYNzqZ+gOBbeL/U3gGb6bkIvWDoj++MRD1aIZ+TNLGRFdCw3JSRXbX2bSZKiTQlON
	 iY+cFCiR0FhAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06D5580E8D;
	Mon, 27 Jul 2026 16:20:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F223E3B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7ED04072B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8iWX3m_IVTdz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::2;
 helo=mail-pj2-x02.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D050A406FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D050A406FC
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D050A406FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3896ccc93b5so1063393a91.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 09:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169205; x=1785774005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jOKl9cuatMBwnsyU1wJ+nM+sSfz+zrZVzuTsvqWf2Wk=;
 b=SDjrduDj6zXbT1dhtpTBpY9z5OXV0AQga7+SlDVU9VmGe49sqT/fmpuGu59KCBGGv9
 AvKIN179FrsJ06PmaPj7D0AS0a5WnbK8ZFMUazqsptDV11mGGLDTfhLTnPLA5kLB+HVB
 eUTQQXJIjWV2tpOZ7TjVSO61yOYw1Q1mEJS6GM6yTecD3K9AM6vhMgMVLnczTikuyu9y
 /VOBVA3rHWTP4doL36wlQqE5QuK7ZsOATV5y+YCjHTw8kOUix2tf/0AfVXeOGLpZjWd3
 Ld72IOeayXvc8Du+YGOnzdtNdCsmxgCDMrEuZXjUQrpHcHrLrpYZkaX1g4jmfNMjA2St
 Oqnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6n9qXR6KJ+DsjMBdd6VRRnF0n8WbY1zG7AP7FzvEWRhTZ55WIp2Dk9zcrKA894GtPm8oBO7hE0I2CmVpfG/M=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwINw+4qdbpXQ5yGU0CtFZbd/IckFIgg4gk4dx54zuYkQUCbeRj
 5MzWsHzJrC1Pvh2/e/NpvbUBYcubzohSr/yYBdiVjVZ3sAMT1RizuADt
X-Gm-Gg: AR+sD13iH2EZVgJGP27kGwoV4kG0F6hLbRO6qGJxWFzDYmpio0DcQIvDKKXtDjPL2v4
 vPYj5eyWTNZWOwKsGzbMsHH4tR4l047zQm9KC2ImkG/zwbkyF9iJElmHlg65TltUmfL7UZ+UgnL
 zKaWQNUpt7v6oF/huPIQj8ZhxipU6Y+RiswRlGFiXtVEAEPg8KXSR+8hAVZVbIHON3+OX115wEI
 MyPplZyhcwtzpVYu00l936F7Djl/PQhNhwDJm4Ma0uh059pp3brlkR/lqciParrL3woPESaZJxu
 R1MI2Xmz3AGNV57ZPkiyQMV+w9wG7WZW7o/Wm43Xf2gDeJ4T1j7VfLGClHiPATBrzhPMHXNFvGr
 YI6NyE+FHMKsNee26kDVaLCMssxLNThzuMKv7VrF90dnWh4/QGt1i0UWNxQEVF09OBYSdVlQ=
X-Received: by 2002:a17:90b:5826:b0:38e:7268:220c with SMTP id
 98e67ed59e1d1-38f2966033emr8517144a91.32.1785169204964; 
 Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f64150874sm75066a91.16.2026.07.27.09.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
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
Date: Mon, 27 Jul 2026 09:19:58 -0700
Message-ID: <20260727161959.885642-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169205; x=1785774005; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jOKl9cuatMBwnsyU1wJ+nM+sSfz+zrZVzuTsvqWf2Wk=;
 b=MbQtWuYdeDFkmNbHXu3QNhwLAqeE+Yv2lhL5qoEDtCuNaipFwNmBFdK8wvDHQ71JrA
 7Q7Js3orJDfQ/YANELJipJhSkqv0nfFLSxQDd5Hgrb3jBZcLXEdrQlrWwW2q7dTEM82o
 KfzFJbEPM5jTFfpsyrp7vlcjcK2PQkPX+tdlkjL41RnG4CPQTK8bug2TR+f1JUGsbKzw
 A8jfZCW/nDjtEpugYE62dtxfFb3wv9bDwCtwsfgS0jDlE2Ug3i6lKSNptPTvaySRS/kv
 9oFIWwinXIBkRwrpEFG8DyV0nkufMfxmFOCmP6kt4i7k+IV1sXaitdwG8XVbbNSAGKB7
 G4vA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MbQtWuYd
Subject: [Intel-wired-lan] [PATCH net 5/6] xsk: move
 xsk_tx_metadata_request() to xdp_sock_drv.h
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

xsk_tx_metadata_request() must validate metadata with
xsk_buff_valid_tx_metadata(), which is defined in xdp_sock_drv.h. Move the
helper there before adding that dependency. All callers already include
the destination header, so this has no functional effect.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/xdp_sock.h     | 43 --------------------------------------
 include/net/xdp_sock_drv.h | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 2b2eb9b9d580..6e70b320b399 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -153,43 +153,6 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 	compl->tx_timestamp = &meta->completion.tx_timestamp;
 }
 
-/**
- *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
- *  and call appropriate xsk_tx_metadata_ops operation.
- *  @pmeta: pointer to pointer to AF_XDP metadata area
- *  @ops: pointer to struct xsk_tx_metadata_ops
- *  @priv: pointer to driver-private aread
- *
- *  This function should be called by the networking device when
- *  it prepares AF_XDP egress packet.
- */
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
-{
-	const struct xsk_tx_metadata *meta = *pmeta;
-
-	if (!meta)
-		return;
-
-	if (ops->tmo_request_launch_time)
-		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-			ops->tmo_request_launch_time(meta->request.launch_time,
-						     priv);
-
-	if (ops->tmo_request_timestamp)
-		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
-			ops->tmo_request_timestamp(priv);
-
-	if (ops->tmo_request_checksum)
-		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
-			ops->tmo_request_checksum(meta->request.csum_start,
-						  meta->request.csum_offset, priv);
-
-	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
-		*pmeta = NULL;
-}
-
 /**
  *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completion
  *  and call appropriate xsk_tx_metadata_ops operation.
@@ -239,12 +202,6 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 {
 }
 
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
-{
-}
-
 static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
 					    const struct xsk_tx_metadata_ops *ops,
 					    void *priv)
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 68a787601357..f87c4215673e 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -271,6 +271,43 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
 }
 
+/**
+ *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
+ *  and call appropriate xsk_tx_metadata_ops operation.
+ *  @pmeta: pointer to pointer to AF_XDP metadata area
+ *  @ops: pointer to struct xsk_tx_metadata_ops
+ *  @priv: pointer to driver-private aread
+ *
+ *  This function should be called by the networking device when
+ *  it prepares AF_XDP egress packet.
+ */
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
+					   const struct xsk_tx_metadata_ops *ops,
+					   void *priv)
+{
+	const struct xsk_tx_metadata *meta = *pmeta;
+
+	if (!meta)
+		return;
+
+	if (ops->tmo_request_launch_time)
+		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(meta->request.launch_time,
+						     priv);
+
+	if (ops->tmo_request_timestamp)
+		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
+			ops->tmo_request_timestamp(priv);
+
+	if (ops->tmo_request_checksum)
+		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
+			ops->tmo_request_checksum(meta->request.csum_start,
+						  meta->request.csum_offset, priv);
+
+	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+		*pmeta = NULL;
+}
+
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
@@ -483,6 +520,12 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return false;
 }
 
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
+					   const struct xsk_tx_metadata_ops *ops,
+					   void *priv)
+{
+}
+
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
-- 
2.53.0-Meta

