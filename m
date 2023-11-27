Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803DBC4167B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Nov 2023 08:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25CB04034D;
	Mon, 27 Nov 2023 08:41:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25CB04034D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701074484;
	bh=0whtiug1AFy2WvWK2Pa6Wxh/BcFeM2Ee66QnN2UH0ts=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=K/fmLr+IyA39VnStUm+WLF5g0auPVroCFZGiOMrTUv1p5zqwnhbtW+Eg8QZ5O3T0F
	 xNp/IIIyIho04O21Q5G9dBlCU7Mi7WMR5cCvHQX+33qEJNeWAVX0xIwdXbFseLurSB
	 CzAXzxrbRGpkZtySfx66YWPO70YMycmP345IyjJQx9ZzAdD/P+lD55waeV5CP3o3/T
	 EAkKtpgpQAJkoCLV0GKQLvvnDPtYPBVLt2Frlqt4P29AVy68bawCHF54P2DODpZUAc
	 BS8B3TXqX0jpCtH+MbWtIP0dHefaJ4bkcpx54XvecVOE9ZO4EIiXRY5409d13Q+dWu
	 BlvRl8dkzOojg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZpbFnXbSsDV; Mon, 27 Nov 2023 08:41:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 366FF40362;
	Mon, 27 Nov 2023 08:41:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 366FF40362
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 030DF1BF404
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 08:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE54F40350
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 08:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE54F40350
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vHi1cUh7TgIY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Nov 2023 08:41:20 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC48C4034D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 08:41:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC48C4034D
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cfa8f7c356so14194475ad.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 00:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701074480; x=1701679280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uA+NyLywCHNJM2L1yigaSz+qISoqnMqQkC+s56gSPmI=;
 b=LbG50NZcYH/K6g7CWMrp4Dg1x63RQdh4AErofzL0EnbhGDhiiut/XgzCUWZC5w3L84
 mbAFFleiOZM9V2KYGcG6/g8T7U/GexWbtlFmYVDKeBhra0WVNb/VQlntzJngW7on+ghP
 diWmEI6a1BSmvhb2AZvTtw+RpuM4jX9yujB6BSbay8TQJRjD11AwjBHJYlmXQ8jRYP8y
 XEz/0Z+WeS+oLTCKi+PXmn1LFzKLAFGNS7UV/Fxybbkduq8uSp5JsbVMpv0AE1d21MS5
 LDQdp8/nVarQs5n+qda4lmKT6LrL63/hzh/s1tNZFtkBko+a9thRzM8FT3ygUlzoZqDP
 0pPg==
X-Gm-Message-State: AOJu0YzFWOMoVqcP2vdmMuqbWAjDMmxUpGpxlp+xkrZNuirpQcSva3vH
 X/ZMhKetFLgbBMJl4hyjn5g=
X-Google-Smtp-Source: AGHT+IEspSRKCEQlT9C6CVArofq5q13nH7/QMAh7OXabeyyYAFL0r9PEbfDsw5J/kiEVt0XVCC9eFA==
X-Received: by 2002:a17:902:968f:b0:1cc:446c:770c with SMTP id
 n15-20020a170902968f00b001cc446c770cmr7401754plp.33.1701074480005; 
 Mon, 27 Nov 2023 00:41:20 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([103.7.29.31])
 by smtp.gmail.com with ESMTPSA id
 iy15-20020a170903130f00b001b896686c78sm7675722plb.66.2023.11.27.00.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:41:19 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Mon, 27 Nov 2023 16:41:09 +0800
Message-Id: <20231127084109.44235-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701074480; x=1701679280; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uA+NyLywCHNJM2L1yigaSz+qISoqnMqQkC+s56gSPmI=;
 b=nmyPEA+Oa3J5BWX0nl6dp5jRIv5T3+a5KTfj65ZnLODdvrWhmVWhErVuyh10tTFeu3
 XJSLaHikGUoYaBeQPzpTTJ3zUoHMdps8ULwBf+U0nt+MCucO5dIpSxQP0v+Yw8Yi4VYb
 ioNlgeiiEZs9C0IhTSz+HwGtOVYJRnl8rIzv3OmvgY9KCNxlLTI2MBGF8LGOJddDij7n
 HWoPGdgIJQe+wXwesQTw4vrWpCE7JiDlDewG15B9HwQuGw2QGpGecy0NpMh4WZ+zoKaY
 gPS4DycoqEpnFl05igxX4vrn5BuWD6HXVrjsnDArRjhgxLGszXQ63t1LB0Wdyx22jY93
 NGIw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=nmyPEA+O
Subject: [Intel-wired-lan] [PATCH iwl-next] i40e: remove fake support of
 rx-frames-irq
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 kerneljasonxing@gmail.com, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jason Xing <kernelxing@tencent.com>

Since we never support this feature for I40E driver, we don't have to
display the value when using 'ethtool -c eth0'.

Before this patch applied, the rx-frames-irq is 256 which is consistent
with tx-frames-irq. Apparently it could mislead users.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index eb9a7b32af73..2a0a12a79aa3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2895,7 +2895,6 @@ static int __i40e_get_coalesce(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 
 	ec->tx_max_coalesced_frames_irq = vsi->work_limit;
-	ec->rx_max_coalesced_frames_irq = vsi->work_limit;
 
 	/* rx and tx usecs has per queue value. If user doesn't specify the
 	 * queue, return queue 0's value to represent.
@@ -3029,7 +3028,7 @@ static int __i40e_set_coalesce(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	int i;
 
-	if (ec->tx_max_coalesced_frames_irq || ec->rx_max_coalesced_frames_irq)
+	if (ec->tx_max_coalesced_frames_irq)
 		vsi->work_limit = ec->tx_max_coalesced_frames_irq;
 
 	if (queue < 0) {
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
