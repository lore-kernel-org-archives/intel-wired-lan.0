Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CC2C5DF69
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 19:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F14360DCE;
	Thu, 13 Aug 2026 19:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JbtQ_0gDxock; Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AB8860DCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786648088;
	bh=zjeV9JcXmMB5XUYPG/BDWWBwnse1nt9xQQ5l1gfrbe8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oo3Y7o14mioBl/poCtNCZUWMPeeHlAAoz+P5Lkno1oLm1c1ug1yN59nNe3PDSPYOF
	 3iMQt4Xp1vcw0n1s7ZbSIjX8fvHnRkIZx/84D8lwWjLYpUhRhOiccebaXJTvjrzvil
	 mxLw4KEDqAQRfscd5TY3CxZANWL3oWiP8HcWudCL6RJkvFo9R6yerXSdvfaoRvhilA
	 JysZ7v7TtTsz7SWcvPrlXAtH2bAEemzgKrVPXwclVdbWffkdfHtVMVUhjL+LUTUwdd
	 xcVovuIQ7o3LWrHIR/lPQWZC8iOzLEm0i02xfD00UphNx45TXLW8eRLhCndUDcIo3i
	 OuVz3TJwTWfrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AB8860DCD;
	Thu, 13 Aug 2026 19:08:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FF3E3DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65DB381363
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikLXItnvT5x0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::7;
 helo=mail-pj2-x07.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C080A81354
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C080A81354
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Q/suFLuq
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C080A81354
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 19:08:05 +0000 (UTC)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-38dcd98e5easo115315a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786648085; x=1787252885; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjeV9JcXmMB5XUYPG/BDWWBwnse1nt9xQQ5l1gfrbe8=;
 b=Q/suFLuqse8JLPogeg1eHLNfiPOdqLS3DQt+OEge3RQ/EkfyR2nDIUzjlLrZF5/buD
 ZWO6r60FFN0ZT6cU/UTffUCTUl96L7A16iq5C37m4qWHsOX6AHvsn0Uod2tc+Ub4rEki
 AprxXxSyT8H20n6EFz47wKzcsOfTJVj8djniP5+AXZWVdtGwCPfKhvAb2/+jkGMHUriH
 m8AjVC3Qmy5XhTxLyyd+oVA2XJj9TYY84AjijHuIHlL6OYMNZSqjsnmHESapfoXPFHzE
 yJefck9fGEnm0Aqy0JxtmzBLhtiklu9R93QUejaUNfhR+VvX+EoHgkvHpk/IdNIV20ap
 6gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648085; x=1787252885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjeV9JcXmMB5XUYPG/BDWWBwnse1nt9xQQ5l1gfrbe8=;
 b=IA/g64PRyi+pHym3fgr7d76vXZIvKFcQLFPtOd4TxjbRVJAuyd9KnxxskmlX7UyXYO
 3QFgBWHlOPYTwsbqZPANPjNl5jFn+UPE0sPYsr44WUDBn1KSYHavrmgLHwHukNtj/l1z
 UYTUg9ut2oqP/gpYaE2a3JVhz5jimCeDzmsos1RTs2j22uNVwThRreSgGGblk59lsxvn
 Ze7iz7thU6gSOX3885VzUm1xFuSw+3ZZvQEP4APuUhIWV8EjNk2Vvp7wHi5qyBzR6mE/
 0YXIoag2idzmbmqxHOq9OlioN6f195J2UTrx6TbfCRSWNV7KI7vITuKrYmVMmdTZIx7J
 mnxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZxDpjLfy+quzRDymUC4CmA4efAOWeTOKWVuCtctONfvRYx4KFolNXe0AcxzhJlDncQicojf0pCFmH+HYsi1s=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwQJiK/3m0tuSLg8BQGSsm/TSlVsKfo/pi+uRFNwMLdlCe1zs+A
 j9cAvpC8+paYdKBFAfxnHHFkXLdsPNyaYkxSguXjuFI5Vu45XBHpmGUb
X-Gm-Gg: AR+sD12O+5Dwm9XsfgQJGs+Gt33c3E1KEeaGvA3J1bGrqWGyQYhR13XyQ5l/HEx5ya6
 xzTdR4Cv2eCWq/E3146oSEAWTjaAUsOdjOHxBH9D5jK69ext/mBSXD8Iil9kTxkSSUS/eI9yIO+
 V7fdW8al2FkPwe1AZbLIeNhXfp2W8bvq/NKtUOlv5mYDoiyfGw/EZso7rTm+08r+IUU4cDSEgxF
 wTdsz4e4hf7GeEOlU/pIplRH5ou3/yo9O8DMqnw/5DbRvvcEfHN5mgTYwawcbCp/Mo3tnkpeb9v
 HogQ1zLGKa0Dnskz0Ye+Mum7zpiW1YKHeFFS8BnfzYpP2HjL6TMOGSGKJtddRKpuybdINKBfzZZ
 mgpmuC9LuSWCdB0kfxo4ffauloTrVMXCFhTdDcXoxHw9fhRNGkyoNoeb2WlJVf05M1v+nfmwjTL
 iqpTyoOJMZyUSdAw5mYyg5UbgGgqdj8cSWyI//oATQiVEFT0Sg+hqRLA==
X-Received: by 2002:a17:90b:2f0d:b0:38e:7268:220d with SMTP id
 98e67ed59e1d1-3933ed5e238mr29902a91.20.1786648085014; 
 Thu, 13 Aug 2026 12:08:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:52::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39339fe280fsm485100a91.12.2026.08.13.12.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:08:04 -0700 (PDT)
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
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Date: Thu, 13 Aug 2026 12:08:00 -0700
Message-ID: <20260813190800.222527-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190800.222527-1-sdf@fomichev.me>
References: <20260813190800.222527-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH net v2 3/3] net: stmmac: skip queueMaxSDU
 check for AF_XDP
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

Commit c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
was inspired by commit 92a0dcb8427d ("igc: offload queue max SDU from
tc-taprio"), but the igc change does not apply the check to AF_XDP.

xsk_tx_peek_desc() reserves a completion entry. Continuing without
queuing or completing the descriptor leaves the AF_XDP rings imbalanced,
so remove the check from the zero-copy path.

The assumptions is that AF_XDP zero-copy traffic bypasses the qdisc, so
taprio's queueMaxSDU check does not apply to this path.

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62de03e65a90..4a82f4351303 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2710,13 +2710,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->est && priv->est->enable &&
-		    priv->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->est->max_sdu[queue]) {
-			priv->xstats.max_sdu_txq_drop[queue]++;
-			continue;
-		}
-
 		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
 		meta = xsk_buff_get_metadata(pool, xdp_desc.addr,
-- 
2.53.0-Meta

