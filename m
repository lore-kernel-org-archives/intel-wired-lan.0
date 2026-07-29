Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A7CC53219
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 15:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9192760624;
	Wed, 29 Jul 2026 15:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0B2mwv5NvT5; Wed, 29 Jul 2026 15:21:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A99D160602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785338486;
	bh=26wuvyCQUtwFDNC3XvJvRGJkecoG/+P+P0HW/5yjOz0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O6Qifl3mnS0XNQYwgB868f/BL+940Igsr9sCg3huqnmttLfYz/up0X3x6x/LBhqXa
	 UZVWdVhF96CW0DCHDtayZlquyolRC5eqAx0DnNRTiRLvsV+2WYo3lodnqTbYpOFBFF
	 Icgs6xDRH5k+V8mk+6G2v5b5Q4UD+ryEiTv1yHUsPB3yGdUxkHe6gR8HZ9Iu8pL9Xq
	 GXFV6i0r/rs10xgG+HWXO5OtQKovRh3Pq8NMCRu1JfT3XUlKO4dgA66WsnFQ8vOdS+
	 I/H3Dos9+A4g4SowgrmFNeHF6z9uTGe2Gza5u9DB3P4sWO4mGw0WJdRtqOPrD2NXJx
	 Gl/vRfCv1Giew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A99D160602;
	Wed, 29 Jul 2026 15:21:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB3A24BF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 08:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8DC440229
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 08:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xI9Dy9mSAjDt for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 08:01:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=hsj0512@snu.ac.kr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6880E4004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6880E4004B
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6880E4004B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 08:01:28 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-848d21bbaffso708061b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 01:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785312088; x=1785916888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=26wuvyCQUtwFDNC3XvJvRGJkecoG/+P+P0HW/5yjOz0=;
 b=Av4PvraFMAJXFfyJLueqCd2bfQA/2S6qOXqvnMMeHL82UEE7rFR20qCZHfwlbH4e9k
 aGFxiTJVcOIN49392FnW4GgDmHzzSrCa9Pp7KVDr3pt0iPB4Cnm0WhXBkA7HL2GBhCMH
 3SPGTSe1hwBcuSn4+0qDOlzsTpRjaWSXR9Fo4Z9RERvXxtPuCAu7qmkNmbxUypSXrJgy
 GLu5O7R8Cx03+lYPRNM+zIwRN7G9EBUOgW7PJXGsfWCuzEIw0v9XRGPj+XfFrHgt4TDz
 gX0cHqi6VSQlG9sb1YP5o9vo5FUBMsTafdJl9WeQFMlYSaZ7mQFoECpXXHrDngNCGV9B
 1Psg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDQnLgx/z7wBgTQppOUVykj4KYn8c1GqRYT812inHQgrdemrLLFsOTiHy8jiwR+qCRvnNFggUZcIs0EPZNLVs=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwEwkST2eihsIhTh+lEu0tlGEh/noVeFMaycufngBvxU62h5L/L
 XS0q060JGWlqxW8mxivpOADrUYu1y81jfi4oA9J6DIz8TkiBitPdGRwHyMQ+sa/zOMs=
X-Gm-Gg: AR+sD13MNg3C630NEAKc85QGKryh3+PqcpaQOBG82J/QstInrz/hBL692pvLpaBFA9F
 sb8A3Tcg2W/B2blp8aoRk/IIv57FHZVBxaiBUeWadqD8MhgZqyeCtpKjG69tlYSQ5XK3Wi/w4eH
 OfvgLa3F7L/pvwGyjXH8wha76mszTRBO0EZ28Y4P/Yqcw1Pyye3/x6HZIo3emWOz+Qp3Jz6sE5e
 1c4HvxwP6kJXFcDutPcqksbkLAcM8/pPnnUJKEt0dJbn5mDwb3YvqqiLIgGP5+faJsDAr1HK+3V
 GrjxsOAlENctRq+ZdyNczbXZnxQJcryVhBoSEapaUICD+baXi0HvN9pYJBw3+y+hZXTZyndVSRH
 ZToX2lgCaIJNUhx7aGymEkWw2vLvVP3dN3ud1K+0QsbCE8nLrLdgAAKzT+Xua1X3LPT5eM6CGcD
 XYX7zw7hsUjWf4AkZyrbiARbEmAR2wrakbn7VboxK3LxPurNJafdlaZQRZGg==
X-Received: by 2002:a05:6a00:bd09:b0:847:8ccc:d7c6 with SMTP id
 d2e1a72fcca58-84e931844b0mr6501081b3a.31.1785312087869; 
 Wed, 29 Jul 2026 01:01:27 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba3519a5sm540157a12.18.2026.07.29.01.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:01:27 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Seongjun Hong <hsj0512@snu.ac.kr>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Jul 2026 08:01:00 +0000
Message-ID: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 15:21:24 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1785312088; x=1785916888; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=26wuvyCQUtwFDNC3XvJvRGJkecoG/+P+P0HW/5yjOz0=;
 b=b2qoYDhXaS62TABQUrmXhHy2pSnoO2aULZRQ5/EUNrCoEMA/E1uLsjqWBAuKVnLcgO
 AA21MXGK5Lmed0D/MYlyBmPIiCBpdlxxL4hKczSx4GPkLKs5PTjYV7JmvFpmAyC0bmda
 BtCSnc5NIMukYeOOxobwQqVhB2hzO6CcWbvw4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=snu.ac.kr
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.a=rsa-sha256
 header.s=google header.b=b2qoYDhX
Subject: [Intel-wired-lan] [PATCH] e1000: drop dead switch statements in
 configure_tx/rx
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

remove unnecessary branch

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 55 ++++++++-----------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 9b09eb144b81..5d67d61ebfee 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1599,24 +1599,18 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 	u32 ipgr1, ipgr2;
 
 	/* Setup the HW Tx Head and Tail descriptor pointers */
-
-	switch (adapter->num_tx_queues) {
-	case 1:
-	default:
-		tdba = adapter->tx_ring[0].dma;
-		tdlen = adapter->tx_ring[0].count *
-			sizeof(struct e1000_tx_desc);
-		ew32(TDLEN, tdlen);
-		ew32(TDBAH, (tdba >> 32));
-		ew32(TDBAL, (tdba & 0x00000000ffffffffULL));
-		ew32(TDT, 0);
-		ew32(TDH, 0);
-		adapter->tx_ring[0].tdh = ((hw->mac_type >= e1000_82543) ?
-					   E1000_TDH : E1000_82542_TDH);
-		adapter->tx_ring[0].tdt = ((hw->mac_type >= e1000_82543) ?
-					   E1000_TDT : E1000_82542_TDT);
-		break;
-	}
+	tdba = adapter->tx_ring[0].dma;
+	tdlen = adapter->tx_ring[0].count *
+		sizeof(struct e1000_tx_desc);
+	ew32(TDLEN, tdlen);
+	ew32(TDBAH, (tdba >> 32));
+	ew32(TDBAL, (tdba & 0x00000000ffffffffULL));
+	ew32(TDT, 0);
+	ew32(TDH, 0);
+	adapter->tx_ring[0].tdh = ((hw->mac_type >= e1000_82543) ?
+					E1000_TDH : E1000_82542_TDH);
+	adapter->tx_ring[0].tdt = ((hw->mac_type >= e1000_82543) ?
+					E1000_TDT : E1000_82542_TDT);
 
 	/* Set the default values for the Tx Inter Packet Gap timer */
 	if ((hw->media_type == e1000_media_type_fiber ||
@@ -1884,21 +1878,16 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
-	switch (adapter->num_rx_queues) {
-	case 1:
-	default:
-		rdba = adapter->rx_ring[0].dma;
-		ew32(RDLEN, rdlen);
-		ew32(RDBAH, (rdba >> 32));
-		ew32(RDBAL, (rdba & 0x00000000ffffffffULL));
-		ew32(RDT, 0);
-		ew32(RDH, 0);
-		adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ?
-					   E1000_RDH : E1000_82542_RDH);
-		adapter->rx_ring[0].rdt = ((hw->mac_type >= e1000_82543) ?
-					   E1000_RDT : E1000_82542_RDT);
-		break;
-	}
+	rdba = adapter->rx_ring[0].dma;
+	ew32(RDLEN, rdlen);
+	ew32(RDBAH, (rdba >> 32));
+	ew32(RDBAL, (rdba & 0x00000000ffffffffULL));
+	ew32(RDT, 0);
+	ew32(RDH, 0);
+	adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ?
+					E1000_RDH : E1000_82542_RDH);
+	adapter->rx_ring[0].rdt = ((hw->mac_type >= e1000_82543) ?
+					E1000_RDT : E1000_82542_RDT);
 
 	/* Enable 82543 Receive Checksum Offload for TCP and UDP */
 	if (hw->mac_type >= e1000_82543) {
-- 
2.43.0

