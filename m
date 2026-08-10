Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8481C5B569
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 18:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A99680F28;
	Mon, 10 Aug 2026 18:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fch23m0USgQH; Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46D3E80F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786387678;
	bh=k/Ax58T4Q8crjfyLzO+c1sFhNTHsEbLvFPcefzRdh9g=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=huvVGDB5wFR5q/DfFGlZnnQVMt5Klgj+w5heJRpppzEANdjg6yyC9uuKO8Pvdq+yR
	 3/4K/UXn7HKzEYriU/iXFMjxgRojnDt5fZZeGoLAp+8kgYkGeg0JhzKJ2Ypuq1/GbJ
	 L78GoMnktEjUY5qnjsGqi6lKTWDyD9iJLm0s5kIiYDZDRTweccHagxu5sVPyIQrc21
	 vFqEqU36PzXF7fL06ZlaniiXLh3TWpU+eDHbYrV6AUHD6zcCzZH5TVdUlfLCNu2AeJ
	 7XYQuqg/VnrhMvYDi4LQ9lMBi6oMHYxFhPi2sHjn8bo1idgsJK++XgUgq+kV7/K1Ty
	 Vhz8aRQl04msA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46D3E80F1C;
	Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF67F218
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B126B60645
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jec2hfaIqDnt for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::6;
 helo=mail-pj2-x06.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1E56F605ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E56F605ED
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E56F605ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:56 +0000 (UTC)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-38f25802c19so911332a91.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 11:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387675; x=1786992475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k/Ax58T4Q8crjfyLzO+c1sFhNTHsEbLvFPcefzRdh9g=;
 b=crEwN1oZPe5rWulPgiq+7xyDTqhMhWuJdHPe+spsYXsfvyWse7gmm4I3ztT/0Jv6CI
 w4ShBtp/GGo1FO4hh8OSnJvm/k94rRkQgai/unu80QEdAuzqYYEWGs0xQdz7d2GJ5m8t
 2H61z/bfKjhMkh0Avno/5ETy9pmss+sXlddKi3kKIaxv2a0hkWl2/Y0kIe/PdfXCton8
 ZW0Z+6nIFHNPJn6VDlRUX1/TF4ncKuv/R3WZtAV8XgKqeTr4kT2dlAVZ0BbBCG46r1Hf
 OcdelsE8bSFwXfKH/jIAK3r2hes78XQIGKaUwr67dRfsqJsM9hba5cuO258xMx2MCCMC
 h0Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGJXwcNBlwK7m0RYO27anaUiP4BuRcbyaPicfobk8JdC4wzHvocBbO8r4jgY1ZViE59xbSP4LptebxSxKqKGw=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yzq7KPyyrC1baGCW49vYSzRseDJOktjZiYqlS9o3rhCYIlr/Xii
 7nUi22AVW7y6SMuP+U8lyC1WgItRwfpkyPoWYJ1WaTLA23sJvyF9Cyli
X-Gm-Gg: AR+sD11Es9E7oG5FowU0jo9DB6W9adr6TgEf0YsAuC1P3MD+JFPDEdHTYQn7dhiXZDZ
 TBlN06zoAMHuaAQg+5BNk6SsoQ998k/o30GU5vMf6CPu8zYI7DiATbdNPLOysY+PILRpn/ISM3X
 2pZTzqcyVRF0Ly3PDFP5SNGSH7PT4hhuUyYiYHZNcCr7QToDtFzKVCxI4+0vOZcgCdsKdNoDGsm
 Awm+jgDgoF6EdPxHmfOpQKhQIHo878OESP4VnT936mEWJhL6nMgHuxGhr0wjJTrpy2S/IAJxNYF
 MbwyeaBEphbPaTIhC3WJ332hKwdRgF9GsswimsTJLK59SvAM/vrijMgPtIYa7q0F4k5iQEXHj4M
 EE+SjfNkT4MmCBl90oWofQncny5Kddvo7Sl3v+iysdMwcje1ZcZfjXlIcGUEav24Qg7PUgSSDVq
 95UiV5CdajGpCOY1DyKu61x8lFYynixKMNkPM22rGN2L4vzWWKb+07yAsTcx4H5twX
X-Received: by 2002:a17:90b:1807:b0:38e:6dd:a9ad with SMTP id
 98e67ed59e1d1-39281b1b0c8mr20842462a91.0.1786387675358; 
 Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392d5226b40sm611653a91.13.2026.08.10.11.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 alice.kernel@fastmail.im, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Mon, 10 Aug 2026 11:47:51 -0700
Message-ID: <20260810184753.135756-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
References: <20260810184753.135756-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387675; x=1786992475; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k/Ax58T4Q8crjfyLzO+c1sFhNTHsEbLvFPcefzRdh9g=;
 b=Cw4YIedsaeG85vXDz4bzhhvG/st0MZHQioj+PWMsn78/Fx1QSETRHeB9V/1O2sxMQc
 RK387unt3u6fyr65scc0iJ+MexUPWh3pS2arm5nQDBNkvIYE9lweJXMpnHU7+TkGQccM
 g5c1SeM8WZ/ESoCg3j0N8xWN4MdEb0IepkNZZNgU2rVGdjtWOE9KvQ/dHuWnqnlLKMUZ
 wb0DytZ86PtFhoTT7QVYxvc9kJWICNrA2cLhm6ay36NwtP/wEoljx6nLFjUUslN2Qy0a
 PCBSj/EHH2KSGs9Moh3+bMga9MDH7dwSIE/k688UmNk0dZ4HnUZkLolq/ZWdr77JGL+U
 UMvw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Cw4YIeds
Subject: [Intel-wired-lan] [PATCH net-next 1/3] xsk: align TX metadata
 layout across ABIs
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

Add explicit padding before launch_time so xsk_tx_metadata has the same
layout on 32-bit and 64-bit systems. This intentionally replaces the
incompatible 32-bit launch-time layout while the interface is still new.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/uapi/linux/if_xdp.h       | 1 +
 tools/include/uapi/linux/if_xdp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..50d67df78911 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -149,6 +149,7 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+			__u32 reserved;
 
 			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
 			/* Launch time in nanosecond against the PTP HW Clock */
-- 
2.53.0-Meta

