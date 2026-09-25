Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7821FC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 22:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F09281318;
	Fri, 25 Sep 2026 22:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYui2UayfVUR; Fri, 25 Sep 2026 22:26:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6F48381314
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790375213;
	b=Dn5d2KSszNCWVgv+xJFdfEm/IGUQk+ja/+2FdP3pni3Q7XiQset2wLwuaRXox0KHoRJF
	 sIOc5n47w141mXOqoggugczvLtGtZsPhkPlm6TWjrb016J/SRWODaIiiK5uCRCX1uX4g8
	 lUmgYcOBXDRFGOsc76x+67peosi5eKWUZ4WmLALT7ArFEm3LGlNqQPov3GmQWuCEWj38L
	 XtMssIu64WusijYYBDdXDQbJifzF78mE2RarAWM/OzA3Mb6TyEzJQpzsEGu8yAfKBCosh
	 OSuIkDWBC2sXlgS6Qa0HbDHZDJe34CsuEQ9mE2cVR65F3Ghw2B+11IEvMzjWqwzP9Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790375213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xVJh1LUOI1qqCZmZziafmPKKwrteIiiL63WKB73QvIk=;
	b=ZAdaFY5ZOA4cakKVhoVrEYHTqGq6x1kQjJbpxw+d7wofcnvmb/pwZnmrUUbl83BTXsk4
	 LKvdPHdz17QaGGqUPst/XVZu3STaoDr/Cd97OUbQGEOlOmvZ0LcMhiwS3jUB0lrQorugm
	 YUvkPxayt8zKFsqmA+GTChPWy2QYn+gxnvr1rV0S8iRHcgoQwtgh6otsjP1HO1t1IzNqI
	 TD1MJvIFh6hwF/hBSaLPiz1cl/A9z9L9DIfmIu0WWmtIaP042cQ58ecK6rIFG++mKW9kb
	 lp1/anyHRc+HJLvw9mV6jUjaL/tDxz4dvtm1TMNJ8V9wokxi0mN5J8F+yRY8mB4L9fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790375213;
	bh=xVJh1LUOI1qqCZmZziafmPKKwrteIiiL63WKB73QvIk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kUkz99si/nPKlubob+PmkTipddrjM8IQdc66NMBKOiCZj8P1ehEXsm4GfiAcBFKBX
	 rboSb388O5squBSIm9stHU60AfXk/6wg72WxEQKHSElDptBy1JkeMwneXJwIsYD3rb
	 xU2oZpnkXUkf45GJMHW6/NLzM6gRpBW/SR3KJ2qT+3Oy7Z8snUMZ706wgn9IQHXoBN
	 i8J5J9X2TLnqdJNZmNoPHmpwMDoOiclB+ZwXM0uPd+9Sew8NkTfHbR4PCx6e9Rbjye
	 MhDKeBx0phxzlkC7JdIFJBygrJL5U4G0au3EkXGExFoSzUMZ1Pjinpib+ccs0c+3kv
	 TOlNn8vZtCiWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F48381314;
	Fri, 25 Sep 2026 22:26:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A758B335
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C1666067F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhTaW6UBKBei for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 22:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F34026066B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790375211;
 b=ZywL82Z2EI0oHqXcsfpaiWD95nmX8+oiBp60xJG40MBRP0h/DX8bLXoCSqQ+WtXH8Lr6
 D2wm90T87yqk2lUxmMrQgLgd06QpeDb2PMcN60YBnApzaNcBYH8wz9D0aEzpoAih9FEUI
 WjfwmwmhOibAuLc41ishR0KGXiRr6GijUzfBbAkPVOIgPy4zs1Ryeik9VlPAfPiM0c6F0
 5HAM7GxKLmhedY0N7icfrT+pVNEAK8UZ3lH1KU7wbgsgVmsGBOGTQqGout9GDyopWy39T
 XHs2MAy85s+bWuDs7k8GSBg9kClVtRy4zRfiqEf1uEiNaOmDVG6tVTCn/cqarE/4arA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790375211;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=xVJh1LUOI1qqCZmZziafmPKKwrteIiiL63WKB73QvIk=;
 b=rfQyJZZW2WfFBLs+z1JeDDr/zhKZV9aOx0e8IFqbq9YCTfgYpaMlGlg4jwViSGEDYBC/
 LmF9qPeJQwmFJgUTl7Kf61VxVEY/1OxEt9Zyp1ezFbpPFXc+n5i0xWM/CMtn35PrOGtib
 Y3mZlBpfymWaHvKr+aXghiqJLjthNzBNSFEBqVI1uRijoxS/j5uMcpQ0ad3NRPpvF9iMa
 YdrrgPhr44iVDzrft1ASMxWaz7/7/QPKjnlyQR96RTHba4MnrkujzvjMRNWXp2YlWgWS4
 TZJ6TF/5OHXmr5YDUd8WMTDGbjc3oV2Sxo+LWLsaWNMYDxAAgFQXFXW9o+7f5sIO5ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=monogon.tech; 
 dkim=pass header.d=monogon-tech.20251104.gappssmtp.com
 header.i=@monogon-tech.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ehifDttK; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=lorenz@monogon.tech; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=monogon-tech.20251104.gappssmtp.com
 header.i=@monogon-tech.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ehifDttK
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F34026066B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 22:26:50 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so7998185e9.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monogon-tech.20251104.gappssmtp.com; s=20251104; t=1790375208; x=1790980008;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xVJh1LUOI1qqCZmZziafmPKKwrteIiiL63WKB73QvIk=;
 b=ehifDttKysXZCX6QEeLqD25rHf784Whi8kWdK+aCTBlBP8mAtGzGPpl988O4150ktn
 9f6XTPzrtZevXfQN751iKg2LxFZmt9kvCZ6KNr50EMC4cjdEtsYMvyOTLjlh1FxYf11v
 DzsuOPeN6q3tTrIy2vyYQhfppr+wScuXonF35O113DSfdHEvDaTVQq+bpAGuC/9RXnUs
 cBrXSaGgEkXqjC0bj5hNaDWCyDeXwrl89Jan7l1L3MjGP/p07pB2Vl4PqcwRuuu5Pxzy
 OFavbZ/NO2oww19yFp+KaoTHv/otJ/YjQzfn/JWl7FGNio+7bnqY/zGRfEsl4I4qJpJ6
 MFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790375208; x=1790980008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xVJh1LUOI1qqCZmZziafmPKKwrteIiiL63WKB73QvIk=;
 b=bMvurGcwGxblE0XxQwAQ/s/3aprATHaYSYNz7JXUN7Hn2thndJy83j4myvfDI5S/8p
 cpliP9cbMaUr3bxc/3Hx0u84G93X51u4grWHgAXHQmdM9XdUtqQ89kkIOtjxAHKggwce
 64DsqeG3KwJxwan86rPYvVLIgUyYU8w1yMx3XHxSETAmclYQQe+oGmZKv5xO+9VW+FdY
 mGl4VGqjKioa1xeaUvZsmkxgsaMWUnoXDjTHIh/9flV7DKzNJtvnmk6A5AzPxJTRWKzf
 2AapJ36DnEIea1My/cBKgRgSheFKnySqBXujNHeNUBAtayFqzW2ILs+2G3kBgnW9GNJO
 oZ4w==
X-Gm-Message-State: AFuF++n87BHRuAgsVkcVuMPd2u9ARUNKO5hRiJqw9oQhKWX14FEkk/DG
 jqLbvuT39tVupSiVF4IxWh166m62OBN00QrfwtrwiaEBoI3tuhzsUTs9ohnO7AGJWQ8=
X-Gm-Gg: AYBFou0peXP5YhLMRxqZHnzi/7kOEDfV4w6woWp9RCadL1xMAMu+TdrQN+81JK4883k
 K3BFsexAE74B2y9WF4BkMZAe/FETtysHsqFHJ/aKOjGJgGqqfiFekDAj3C6Do4uQIuXC8vgox7U
 grvlPb6EyCZWMxeCelmVAfukmwtUKP7xrbJiP06lOgQ6Z0+ByZ9ytdqbcdXdamL9vJqkGi3WDQE
 YunTgLTOagHJqyT08oClnQ6gmd3MoU8r18f09xfXdgelCoPh21UdDkG+5W9d4LLGsQRxqDLXvb1
 AOT467Drlhz0LkHJ4nOPkvsscnfF8t4fMDf+8gyaXPw48FqTph4gQFuSmN/IpV/cWu3dcbhm+dU
 APQ/okjoFDoZyqA6jyLsNJbh5YjRBrsiuf+JYAjJBPn/xmyw9bFZQHM6TEpn5JSPlva+5KBR4us
 CZ4T+v1NBWbTphYYsDJ7uguBhN2+LPZNRbkwguOd5s3bYNf2tq6Wr0imDaz6UyUlYPY9hJxZAF4
 i5P62G4ZQ==
X-Received: by 2002:a05:600c:468d:b0:49f:f9d1:e618 with SMTP id
 5b1f17b1804b1-49ff9d1e6b1mr6117185e9.17.1790375208314; 
 Fri, 25 Sep 2026 15:26:48 -0700 (PDT)
Received: from localhost ([2a02:21b4:a206:6d0c:a5d9:765b:ca48:8993])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fe5cd4271sm260036395e9.5.2026.09.25.15.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:26:46 -0700 (PDT)
From: Lorenz Brun <lorenz@monogon.tech>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ice: fix pktgen crash in eswitch mode
Date: Sat, 26 Sep 2026 00:26:44 +0200
Message-ID: <20260925222645.354053-1-lorenz@monogon.tech>
X-Mailer: git-send-email 2.54.0
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

When pktgen reuses an skb on an ICE port representor, the representor
forwards it to the uplink through dev_queue_xmit(). If the lower qdisc
retains the skb, a subsequent transmission of the same skb overwrites
its list pointers. Dequeuing it from qdisc->gso_skb then dereferences a
NULL skb->next in __skb_unlink().

Disable SKB reuse for this ice path to prevent this.

Crash signature:
   __dev_queue_xmit+0x5c9/0xf20
   ice_eswitch_port_start_xmit+0x83/0xd0 [ice]
   pktgen_thread_worker+0x82f/0x1c10 [pktgen]

Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 096566c697f4..2603cb0f6a54 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -305,6 +305,7 @@ ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
 	eth_hw_addr_random(netdev);
 	netdev->netdev_ops = ops;
 	ice_set_ethtool_repr_ops(netdev);
+	netdev->priv_flags &= ~IFF_TX_SKB_SHARING;
 
 	netdev->hw_features |= NETIF_F_HW_TC;
 
-- 
2.54.0

