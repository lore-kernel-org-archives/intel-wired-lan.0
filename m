Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C64CC5DF8A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 16:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45CB960745;
	Wed, 19 Aug 2026 16:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OEibZtBoPItD; Wed, 19 Aug 2026 16:05:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787155546;
	bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FMaIu5SyhcqkjLqeW/TotGIKHjWMnvJ7KzFmbIsqX9KjsC+ReoPPaavZDGHa1eH/y
	 adEkT7catIBYCr2mIOR2Tv2Y2ojuwp0dHhGewqPu2z4NhTbiOO9GDSTK4OhuDYRQE5
	 zCFu+d8k79SeFkdx9qiAgdJWn7nl0lCY75NHNVn/oHcZ9dz6m5tod8RFDRL+kIzcgW
	 HBcxYz0gIoPwwgjZ6ldAcfH91/AtlOEA1ZYnRSoIHxFYt1Xl7rZy+eUX40mgktkRS2
	 D9V3LtEtS9KGF8AA1AX2FneYQfEymDCyDb3+8eOhVY/KiGBxlQen8ErKB6aMvJiZQz
	 MunyMyiaCmDTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0333C6072F;
	Wed, 19 Aug 2026 16:05:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC5941EA4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1A7A405CD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utrGLVM1f0bY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 16:05:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::4;
 helo=mail-pj2-x04.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hGhfT78a
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32CF0405C5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 16:05:41 +0000 (UTC)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cac634f921so3655325ad.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787155541; x=1787760341; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
 b=hGhfT78arBibpJVnw513mjBLyidqlopvuPadmMytgzM6Wy19aTNGYIBZMaIBa6FW/y
 HBMTgTX1xmj7H9QU9YxdAJGSCWO9Q/+LsiX0J2DuipdnvGTgIlWOI03Fa+X9JkpAWC+Z
 AEO9yt4QpaF4ljNdXUc1ekLG9sTjvb6Ki3obCdWQt9DCwOGs/CZdYfyP9FIgN3bXMh5s
 CsWXe+yr6IWyD5YupgqAVU24cXYCGwBGahMbtF8aTJ2FVje4jsbtXUKETIPEU96WA5UN
 b7KEjpgk0gHb9gz9aWu9lwukdwg23ZzmnppMrOcm7dMoVMy2edH9aRfdQIMFm+AUQYcn
 PMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787155541; x=1787760341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKdPBJAuwbKNHRSj/o9wx9GTRe/KKjDR+X94RAURNcg=;
 b=KyCZ+I9ttlnSLxvWBSkf57CYkdUVq71WX9DjRNKgByaI8XEChumWlqYVxiFKfTVNun
 1bKZF9fHFXFPVx7iyJadeACG7cQ9EqzTdK8+DlvF550rUml4Hp1AsfXTFTiuByUosj4E
 +rproCG7rKJiAyrbe1xHfZZp2u3wlJJ1oUkW+mIp4gZXjg6Ye+E6mpA141SNeAlHFoKt
 Vb2/LXv8x/d8JJ2ulyPy2iN/dAOkpYlKZ0UGAWFKOkT5v4uJkPXLOhSLBQRWlabLzTPA
 na9tn5jJ/v4GcXo5RwGdPm0Bc1LDpkpV66cmuH978R2uemKGH5kO3ScLQIy5YgoAtIXS
 neAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5O6Kl7MgCrL6xKTegU9f44KhWzh2YjGL992OSs/w+s3Tr1DCLz61+riiuIERsT9MuRYJn95JUiAf4uUOeh5g=@lists.osuosl.org
X-Gm-Message-State: AFuF++me0/35Z4SUwxBGS8QRn+1Gpz7oeYVCdURHgLmEKf5ld5lkDznA
 j5bQ1I3lRWGoXR2IQMzFRDbtGVdQy1ay9qZNJHRciyGo2v6Gj40PX4g6
X-Gm-Gg: AR+sD11K0XGJEF7lGA2MPVWRxutMY2Qx9HO6FPnBMNi0QeFerh1NT1P8eb4+fegMGxG
 ikDcDoeAaYZHAkb9NKIDt9Xmp/taEV5YwNgQ2srEipxEZZUV8+w7jSnS5yonJEO0zm36f9AFDqj
 qJCjtY8zn2wnTo5H8+/d2Ol2J3nUunks5dbfGONQIxyI30dE2wwmMRLGKhnHA9NxkuY5naEhSTW
 /R5vxlBsR4fREg0Lheof1YgojBuxpO8qC7lNhPNYNk3M8kHigYyASwWYe1w4QCtR5H8hqkcaz69
 JEATrFVzCzQr4nFVqGvgmzoga2VS7lchXNSCOeqM5iy2kuMZNhJuRUxfEp/19Hdv38u1nKK5OSu
 vYZMeZz4QaH58H2rmxua3pomI1C3JAD3I8dQg4bzbXGHNaiGCl1tW6nOwfQ3qocXSJ3PVlYUsQx
 9rWXWkqS3Zc3VIWceiJDx1RY+shk80wRT1j08/u5oTwOqEneQKujzZDY0CghkwFbbe
X-Received: by 2002:a17:90b:3fc4:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-3958110c755mr10914058a91.12.1787155541199; 
 Wed, 19 Aug 2026 09:05:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17eb5sm3740911a91.3.2026.08.19.09.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:05:40 -0700 (PDT)
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
 guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
Subject: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Date: Wed, 19 Aug 2026 09:05:35 -0700
Message-ID: <20260819160535.1472459-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819160535.1472459-1-sdf@fomichev.me>
References: <20260819160535.1472459-1-sdf@fomichev.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

stmmac drops AF_XDP zero-copy frames that exceed taprio's queueMaxSDU
after xsk_tx_peek_desc() has reserved their completion entries.

Completing a rejected descriptor is unsafe because AF_XDP completions are
ordered: xsk_tx_completed(pool, 1) would complete the oldest outstanding
descriptor, which may still be owned by hardware. Instead, leave the
completion pending so the ring eventually wedges and increment the drop
counter to expose the application error without risking hardware
misbehavior.

Document this intentional ring imbalance at the check.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62de03e65a90..6a532747c039 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2713,6 +2713,10 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (priv->est && priv->est->enable &&
 		    priv->est->max_sdu[queue] &&
 		    xdp_desc.len > priv->est->max_sdu[queue]) {
+			/* Completions are ordered, so this descriptor cannot
+			 * be completed safely. Wedge the ring to expose the
+			 * application error instead.
+			 */
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
-- 
2.53.0-Meta

