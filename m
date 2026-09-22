Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4B8C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 10:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCFC26074A;
	Tue, 22 Sep 2026 10:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiwKbyw_vRid; Tue, 22 Sep 2026 10:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 34489606EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790073282;
	b=EWECEJNUdOb4aLTwA/5hnZl3c/PYk2dm+qCynDfnmRrWYPtJajD0gBQWbS6XiQJvcUcT
	 Y4WXlVlwDCri70xKGfQwtSejjErRoDhDs4l9/G7f5qdikEGGwOPffcuGcvxionslpmFiI
	 bhddV1jOd11AG6ZLYPXy4DWizKi3KYUfWltCtaXsfrQSbgYJTJgWS1CeWwikDvovAnKL4
	 RIMtkt0iqejXMX3T+yHWzG8MuAUWss6m86vwHyqyELZFSvZQ4nRBnhtyc7oOs5IGHiLl4
	 1NPpi8Of+sm44MIsWDBvI0nNrhL4OtG+zN4Ql6xgGQ24eo3vO+5dGFQ0OPMF1QZZ+bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790073282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=am3y0UKU6tx0D/gCCUAE01TlYxvYCZvkU5m2ed5m51U=;
	b=FslXqrtcO10hoqT5xpHYWp+pznVnBnR45X2FuULNPe5c5KVik+dcmgUbgNI65cJP1q3Q
	 DiDRDSoxVpxlsIeENUOTc3WEandui/OiD8HV6D9s9xrf9U3LsW8ZMDDpzIgTbUI6SJz14
	 Nzd8RnsOTXAiYow1dY3MhTTIuSyXD4gbV5Yy+izCVgNO854hlFTmEZRp2AMWtqiyP9/cn
	 U5bDuPlPRVoXC+cWIpFFZPfKwJK1+s7M0IOg0YYP+uy6yaihyps7h9S8xOw4HT/AvvbE1
	 0HjyxmOeIS3JF9davRDj21RYhAv5rsXfF66kpoflii9t3pp572ZeySMPmb0+1470GpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790073282;
	bh=am3y0UKU6tx0D/gCCUAE01TlYxvYCZvkU5m2ed5m51U=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5CfRK+Cq6yNeZyPTRnyaPkdlvns2yYeKr+05D+HFYe+tmNRAYDus269sBr9Bv11ML
	 LzXksWVxvQaXuwTziCi8pDiFZ21F+URorztajTTWqpMZ7oPVzyELJBY+TtMHw/u4dG
	 KDg87rO7xfm8TAKLXK7z5kUKP2QWBYO45/dEeksTT7Yp7UBeCFPfkQhucOVnpGaius
	 WntVhkHsnfbhXtVWN9oH215RYlpXCmkK2vsdJkiNsN+BioqPN5mDpZoULdWtRsYVYa
	 QpoIaZPkPdCekuyBmZcdxTc8UnHCzQU2+84sd10AaUvuAHRvd3Kfg1FwT7mOub26sk
	 5g8tg9EHhr8VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34489606EF;
	Tue, 22 Sep 2026 10:34:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A7BC9352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 10:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8567A80DAC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 10:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UpWIYlpJONnh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 10:34:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 904D780D97
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790073280;
 b=ORCsfwO4glE1lsXGP9jCrlJRTqndBpybkEwxa/gFAZfBlkVwLfY9B7LJsiJJoLlinISj
 JLPWhZusocsQJ/ABNt4gVa/mDNaCZ20qVMjFcaBcxagy5gM5BH78M5tc0aHE/x5JvnTQh
 QC6zYhZLhbE1epak0pFN8we6yI+dlPLJuVY9c2/Xh7oCCQDYibaO9DhzKrZkc2kR2vIo4
 KIMzbd/n59Q7Sf1hkc/62870AmYwMgvMZA5/V353TmPgfzhn080q0h/eHypFZCdr/8GCc
 fo7YiyRqBGZqD+6VJd/Ng85tkI+RCIDCrKIig4xbz3yWaSSqCWYqC4xQKW9d6I17ohw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790073280;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=am3y0UKU6tx0D/gCCUAE01TlYxvYCZvkU5m2ed5m51U=;
 b=Nbglv44YZO5uYHR8FPn/oRoxDMLit5c58kSmXezgWl74H4oXG0Y2lbc+K3T0D2oqbdb0
 WCeqKxOPZLZbwVKizrrQZ+wLGZj4tUglwzfTZwNC9PF2ELRvaDGyKdxi4eksmIQsBBNU8
 aGWJ2uJmVzYfujsrE9FTY3aX21vwxGi94UzQGu4GQ/bUUMibr4TUaW+MNoi2Sm5MgWPKn
 Gk17UODA5h3GbMqNu35ynbhrFLthAoNF3MJ0S/Xy+xd24co65S/ZRY7VFmSNA1bGAlPH9
 rGbe3fVlw15KPn27dJasG8n6VM5pIZ5WDb3gkIqzNi9cS1rEkg1IRVNLFDGecamJOgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gYBByvXj; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gYBByvXj
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 904D780D97
 for <intel-wired-lan@osuosl.org>; Tue, 22 Sep 2026 10:34:39 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so23691495e9.1
 for <intel-wired-lan@osuosl.org>; Tue, 22 Sep 2026 03:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790073277; x=1790678077; darn=osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=am3y0UKU6tx0D/gCCUAE01TlYxvYCZvkU5m2ed5m51U=;
 b=gYBByvXjU22PBhwmmjOVsuMsfrtNmmwjQEMR2e4o7+jlC0OS2fPk7B4F3bOMVzFlpm
 lXfKxRkNw5Dkk4YzBIAwHTBDWmqwhLE2w2gARMH9wvBT7gcRjqva1AvFMnK1LwD61tAu
 rWwDEL24weAqA4o/xc6ErNHKrfO7A0i5L5NhECjx3Y+GRjvTGSganTNGUyoM4qUO/Cwq
 GnDDPLhC9UBQn8WsKoTHidequvgpUaElHCkc74mK0vOXk0HquBnsAfwF5D6MXqIV0z0j
 +Jnjyd4r9FvNbPPAF4b4VRtTjR4eCQ1VyETikyaYS+6uXSwddFxL1w0GS3IihTM1NDkH
 Ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790073277; x=1790678077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=am3y0UKU6tx0D/gCCUAE01TlYxvYCZvkU5m2ed5m51U=;
 b=vP8pj9jZtwteByXxC8/8RhDVJcQvC/6m6AxfeGrQ7oEDvOb2B93ni6XX6SX3zEHog+
 PdXdDft7sncoOQEhVr/s1ZSzlDLnw1YLlBmzO29AsEGbO2EKacOJHvtQfgpMmGf66BPm
 /M5wIzTngOaNJUeTLiXMeGL5Kk/7NqMP1BgN+C4Cj5jQNPOauYaujt1S1egV9YSmahbY
 wkN3f6pPE5/U1f8zn1WKINiAAJjNaQRGQ6q9/AS4IQW3Fj4sIjAqbRHyIQBDVNkinIEK
 QXuqWHtNGlJJAyNyWAQxC9HWZkJVplOqCzhZMedvFgkt7v0mc7qBXWat5qYwP7W68w+R
 CROQ==
X-Gm-Message-State: AFuF++lxYj8CwfuNC5GEZEQ4MuN4vCwurpvcHGUzqrLgyoiEURvEUyw6
 5ow8bsYlE7WJMkcRiuMUNmP86cJSXSWBO6elsXVA4qTdHMlbsN6Cmbj3ysBIEi9H
X-Gm-Gg: AYBFou26dFkKAWxI5+aHEBWSzh2Nx2zkR2ZHmzbKfgN+FFTyOAIWNSYO/BtrwT3PVlw
 YDKC5MrWPjwlksqDHI4R43CIaYLfItqF8gV25hbQ8p8Maoqs1qpYSVhKDhGerXNukBWBSU6uABB
 DkLCITF1uwVyM1uCw85TuUWZjeLtFm8Ba33khFRdstZ4MrF6qtVo5bDc7V5F/cS6ntGXEYJayBe
 3aR2GJJVg2VJ0I2vT6kwPF/Cjy/zeYiCGrt4aVg60hoUDTrfJXBu0DkOdJuJhf2eAShb9iGpqk+
 nr9VD9ZVmBIxLxWvwvcq8gFoqjX8vcFiyaH23rIJVJYzAlP6ZjmUxBlyCnLdFs3o8V8wXBtkWlf
 03BQXOuK7titSdz9eIxpNBAbOpXEDoyHIqVYNyoqyTpHQib0aFqsfT5wmUAfIuETphCE697IAZY
 1ieaMvJybPRwEpOsV4nSUeecyXT5F1PHa09PG39xGRUVpDDBuieOsgH2xy3rkOHl/4k7FlEmSro
 B9/KKzxxQh2nHOTwP+ra+BXwDnUB0ZbgsUSAxf0qCQuIxnS/ZUbSoE0S8+Bew==
X-Received: by 2002:a05:600c:6095:b0:49d:17d4:aff2 with SMTP id
 5b1f17b1804b1-49fc566e558mr196870795e9.1.1790073276922; 
 Tue, 22 Sep 2026 03:34:36 -0700 (PDT)
Received: from sashaneftin-pc-GB-BSi5-1135G7.home ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ccd185sm72579525e9.8.2026.09.22.03.34.35
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 03:34:36 -0700 (PDT)
From: Sasha Neftin <sashaneftin@gmail.com>
To: intel-wired-lan@osuosl.org
Subject: [iwl-net, v1] igc: Fix typo in IGC_NO_QUEUE macro definition
Date: Tue, 22 Sep 2026 13:34:34 +0300
Message-ID: <20260922103434.55912-1-sashaneftin@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Correct the macro name from IGC_N0_QUEUE (using digit '0') to
IGC_NO_QUEUE (using letter 'O') in igc_defines.h and update its
usage in igc_main.c.

Fixes: 16ecd8d9af26 ("igc: Remove the obsolete workaround")
Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 3f504751c2d9..ab55b88d4d96 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -721,7 +721,7 @@
 #define IGC_LP_EEE_1000BT_MASK	BIT(2)
 #define IGC_LP_EEE_100BT_MASK	BIT(1)
 
-#define IGC_N0_QUEUE		-1
+#define IGC_NO_QUEUE		-1
 
 #define IGC_MAX_MAC_HDR_LEN	127
 #define IGC_MAX_NETWORK_HDR_LEN	511
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..ba75350291f5 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4223,8 +4223,8 @@ static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector)
 {
 	struct igc_adapter *adapter = q_vector->adapter;
 	struct igc_hw *hw = &adapter->hw;
-	int rx_queue = IGC_N0_QUEUE;
-	int tx_queue = IGC_N0_QUEUE;
+	int rx_queue = IGC_NO_QUEUE;
+	int tx_queue = IGC_NO_QUEUE;
 
 	if (q_vector->rx.ring)
 		rx_queue = q_vector->rx.ring->reg_idx;
@@ -4233,11 +4233,11 @@ static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector)
 
 	switch (hw->mac.type) {
 	case igc_i225:
-		if (rx_queue > IGC_N0_QUEUE)
+		if (rx_queue > IGC_NO_QUEUE)
 			igc_write_ivar(hw, msix_vector,
 				       rx_queue >> 1,
 				       (rx_queue & 0x1) << 4);
-		if (tx_queue > IGC_N0_QUEUE)
+		if (tx_queue > IGC_NO_QUEUE)
 			igc_write_ivar(hw, msix_vector,
 				       tx_queue >> 1,
 				       ((tx_queue & 0x1) << 4) + 8);
-- 
2.43.0

