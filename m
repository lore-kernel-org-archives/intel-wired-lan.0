Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCD7C5B567
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 18:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC3380F2F;
	Mon, 10 Aug 2026 18:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDyGJjk7WSP4; Mon, 10 Aug 2026 18:48:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B137080F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786387681;
	bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jk2xaSuZW825tDStEG8D3td3s2jit2BzmAcXl9zKuP+0Bz3NHuHE9VUuEoIyJfvSe
	 zyYYr+U9zuAIL3aogxBa1p/x3ND2PU07iYEOSCagV4LYHWiUK0Qm2BvRX5i2F/iwjZ
	 T+J8zM+BjFQvSZ+Kgcq4chkd3+XWFgl5qocuEB34idCQIBIyT8Q/nw+HhhOEkvQnYp
	 iZIhPavd8CO/iSDLhuPpKdTBad2rnMdwprVXLQcaxjxBSVzKGrFwVfsnaADPiYOsYl
	 fK9nSQpzzKOB3jpfJHOS8OvRH6A3HtAkg7AI2MbWwMdjvmBKsNgMGTPtZ0rYbmna1A
	 MUTRpRHL8HZyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B137080F1C;
	Mon, 10 Aug 2026 18:48:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7B4B24E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5CC760645
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6VS7lM_Ykdv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 18:47:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::;
 helo=mail-pz2-x00.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 045F6605ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 045F6605ED
Received: from mail-pz2-x00.google.com (mail-pz2-x00.google.com
 [IPv6:2607:f8b0:4864:3b::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 045F6605ED
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 18:47:57 +0000 (UTC)
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c888c001628so1453115a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 11:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387677; x=1786992477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
 b=P6TVXhf2eSLYQPnf3sZsmRO5/tKNwxkljlcE9c1Gy7OhcBwd+G6awsjK+XAPEWtzyR
 bk6UwVvE2bUI8vCLi85K+W+RN7hCHwE4vKId8+n9rzDIhCipRIJb5vERedJ5NfProRoS
 pngFx/6j4dJTlR58kV3AsQ3OvX59vvN0QCxB5duyUK07eCc473Te24lsrBRr4CH3mVCK
 a8EmXuxRXDKgHA20GlD+OyIhddUtagebM1wKvqlGFuAgYTCTbDewgAffuKCcn+PLCku9
 d8Kb2BmsiPM3kK+SsaV0SD3m2Y6iO0Fcu6kKs+IL+jjIeRfpher2eS6hyVql/djDE1UX
 aLfw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7d5wF25f8qmpKF4LSeMFr5qpDKDSpxREiMM499yExa4HXOWCXtTIgoFrKtPLt3XAu5FnuvSWBcNECv6r2Mns=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yx4GGaPLKa1A/lF/tMgQk70O6g27g8/F8FlLuB4ESdMHDLdumz0
 tbH0qAw41eKpQDrGAS8Rmz8aEG7h4MEbAAzKnl2WvZhFuI0nXE4KViv2
X-Gm-Gg: AR+sD13NtLIke3zSPWDb0ijNv7X05+qm0S77+FG39QuHhBJCGX0N0CCUpBXOJoMgS5B
 j9AN1Yz+vlHVLfQ1Ff6286BhMZKw35gpj87Dj/yY0MxX++v/HD4Awenm0nzSXHkps+odj6/GJjF
 wbgxkm1fr+jbpYP3VCsypATiFdz4a5ZeXL+EViTFQ5sn7SjfEgdVhLV1bkLJ2S2mlqVeqNnMx/C
 jjYw4Cucc1nuzJiDJ0LYWTkcy6PRbMbuzlOqugMGfa0WgLsOeZUlfGC2ide8vpwvk7b95MN2wrD
 s3ietKF+Yyqbl2tsqey8INErSY6vjGtGBNpS4UOR8LIVxMhWZ7Igl3tnLvwDBAM5URX/Tjgvvq3
 x1pYB5KSpzEbonTNw2OIqTbFIxpGkJbZyI6JfwfZOmK1E2Dlx7hlKZyxunnn1I8OCcm3fPmIlne
 /mt9XFV7HRDdsHo/6+dwVozlPKTRNhqLfhRwToVcL+nbB85QTRvOUGGQ==
X-Received: by 2002:a05:6a20:918c:b0:3c3:89cf:f3a with SMTP id
 adf61e73a8af0-3cbce6cb365mr23635499637.5.1786387677292; 
 Mon, 10 Aug 2026 11:47:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f38882fsm4517610a12.31.2026.08.10.11.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:47:56 -0700 (PDT)
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
Date: Mon, 10 Aug 2026 11:47:53 -0700
Message-ID: <20260810184753.135756-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>
References: <20260810184753.135756-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387677; x=1786992477; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/h1pNasFi/92T6RUAvXDvHq7QawRH4lT9AOvszwUiP4=;
 b=NKejMilEtwjb4Jg60i0Bm3NuWUuSmvQnFi1BiGmkBLlm89yEJfCRLgi6OfGXA4rfMf
 ybZUSYIwT3RWww3XmEklhgV+n0z6g7zCb15HnzIR7ZLRKyYmnFCB1KWEOaEY7mTkJ0A3
 BUlF2DZwwgTyNKYTQbU6ax3i7KSaDDMM34VSQyxHd1hFJxH7k1viU5wLn3M8T9xd+Jaq
 a0booFA0zZILn+fiH61gRsM5rjIH0xmEELplrZ/3r8l7Z4z7625120zM83w7LqIILEP4
 Ja8pjfBfzCkROHnH4OwxzK+B/Z17jFSUB41/v88K3rsd6vz2Zw8Lojpc3GIMI/D62E1+
 EpsQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NKejMilE
Subject: [Intel-wired-lan] [PATCH net-next 3/3] net: stmmac: skip
 queueMaxSDU check for AF_XDP
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

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa35cfecc4f..6e9d4cb336ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2714,13 +2714,6 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
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

