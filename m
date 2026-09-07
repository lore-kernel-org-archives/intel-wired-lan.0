Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F23C79FAA
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E2B860693;
	Mon,  7 Sep 2026 21:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5W6ONG_80c4; Mon,  7 Sep 2026 21:54:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 74DF0606B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818095;
	b=igXdiaSgV2HC8LhRkvoFSDDAi/22FuiXoJEBau29Wn0841CNmRf0pwHm/G3Xl5hP92/i
	 iCeJNpARq+xDcRq7fkZ1FZjX7MQ0XawJyzSo3gCQpgDlAUgJLlzn5lFaen/atjeFwPu5j
	 MIgPyRSNxpc5c1VrXxBqzAW+rNa9eJ9om6y8o7pdesNmrKFPboymrHCKhifM37TdkT7VW
	 PtWKT7CjImYhXloCL91v/EcWEV1TiAlTu5s/2pmmitYtaogvbqzbNK2er7F4yGXLI/RFi
	 heZ14SoldnqlamHdiesNKD2JRbXhaamEZnX+MMT1Lsfty7i/GvVDe9v2g1wBhqxWxpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
	b=qNRYALzgI/mjU99JBv2cEqfpv6xhteDmHKY5BZDv1X+gJmpTAK1zi/vesJRKmEW2LeZ1
	 +HveiW1X9pPtzG45Js4RIDN5Up5jsYMGvph7LExeIK125U+6eJG/yz8aUyE9asPrE4+jU
	 HXPdHZ8aKnnGG8kNoulyg/eva73xtkKzio9PtOahVmOmyegqtwGWJsH4eiZmfzFf3mJB2
	 UyBs4H5tERiHhhvO9UpxxyEMTuSCpc1ve8Wy+8GRROma4JgyAcCChIfH6SHK1FRommxka
	 JYM9OCDkn09f0E2NCg3v+4Ne+Ncc1jBeoCZ+6adjsnJLkA4kUgYMgPsUvSvGNmF0Lww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818095;
	bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9E2PxWZr/kD+8UApvc7Tk0gfuNoDZRCx9K9ukr+r3CloqhO3g41IYaLuYyttIt1jj
	 TZksFEdWICuTAxMfITBK2QdlipWUn1/OuU5+6nx7RBnntjAKFHFLlFS4MORg5FTNXJ
	 aYlI3tKDGO4cDudElnbr0++dQWrEA6mht1jy+RiX/8XwafS/9j1W374/FzQ/PfuIWF
	 xclVYQN3sVDYLQCSCTxAmo042ZleU3tzDNrK7A302Kj0D+2VBsZdShvhrQhxUJHQL9
	 VnSqqG4O+ascJiGBLOgyzrhP864gPBQ60HcQ79zghkf0qt9BjvWzqXFzfBrjgU4BF0
	 ysLaSrpG2Vn9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74DF0606B3;
	Mon,  7 Sep 2026 21:54:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C468049D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA736807D5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iY4afi4mcXNu for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 013D980898
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818090;
 b=dILpvhkIbbTNSeOvSW47D2EegEVwqE/FhQ3HjQmDHWQdDlY8LbvVmmSxDtDDJ7oycFwy
 BSQnvZ/hjYtFoHQdTwa7yRK0DDRTxgzjGxoe55H9mEZ/hqD5LS789g+2/LmRub/KQ1aWB
 T1XyHlkeor/3QteOg+BCs8gPy9D/O/Kh9upX250oMKzjnCY+DOTJq8MV2TxkpAbComvPi
 vtABl/1wmG/HuZOxyZxaCd1Q4FFALu8D7Sjl2LUFU/6pUwWIRGEh+CafscaYrxlT6giaz
 XMbmrdc3Q6GakpThn3iDVPj36sk87Lq3p33QB/1IjhbfUFdNZZUdM5H0+VwFVb0PX6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818090;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
 b=iK0+HGnatJ0IaNA8YtkG1xTypq/RGcf6mRarv8y7w4/Ast+T34pInxAnH6jGRriDVn9O
 So3IBih/COLvWmEuC9pyKQN5RNAlTxfnqTiC7M/g/BlFDsfC6vLG3GLPmm0+hsUDELxPX
 t8PMvn2gJIzn4MHoYsOIj7hh9qCwr8jv06kdxyN7JuP60n3KOC2FeQPfsnNtD8Qz640c5
 pIKJQMbTlPgiLRw2/CHMturDSX5479odUQG8TRYCaq16eqbkhDklNv1m2K5OuuMFFVRb2
 XKuU7s2WNlEc0SzcDPjUsKiEH6nBpkDvVmDw16A7m5Ncy7qqVl2FE/mmLm4gGV9mIjg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rYvbS8o1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rYvbS8o1
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 013D980898
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8726acc5eadso26726067b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818089; x=1789422889; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
 b=rYvbS8o17isgx7Kgd/Wuh/xyEOh0kdSbDl9dZRO74zQ7atl4jAXfcRQUcJ81HluTqe
 5jIEBFjlGB2A2njeT4L48qRB/vFbN+P2+dzxZC7qp6QJZMa9en41EKme9Y4llKXp7YDn
 8rGe8ANk3ig37o9Dm+HZzyPrNS4NsVGUUt+Uh5StOT1OUvj1fzmoH3c9sHwUByzaH50N
 NVRQoDRTP+PPbqAp1MuznFE6CDj+mhDpj5iljrfgsA0owT0aRwqjBIENMtCclfjbRxGl
 U7W6ox+jqOm24JtIIa5EspV2ZknQwoogjQ5AIE1O4WtVDNTg/K4tqv0tk4Tg/hvICloF
 UqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818089; x=1789422889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8dBsS+uIQswAO+1Zq7ZFjEaF0vj6TxYTsi3HHjhGAsc=;
 b=dsw9onrLt28R0NMZMARdfNPfAfKdWhUTBQb81jfpsHDbf0sfKeL30Dlx09uBHz+tEZ
 ZXRmryPNJ2KlEdLcwpR090omeequ+LiE/LzVH8CVFU60SrMhsoz3VcAK0s3b/GpsHdHJ
 sFKDHjkLXbnYZU+/ksGBB2kmMPUyAMc7KSgGenieT+x6FJ8rYxMPDb26jiqeSfdN9krL
 GxvsOUEpsbCAbu8xYWhe0zIjC6tAfQUVDYDsx58syQXySXqQzCF/fJcGjZfOARwTcMB4
 x983LIa0ezd5l2kWcTiDc/P9+K4h/kSY0NeRC1NUo2aNlyJ9PPGZnFV+FpdKLK8TW2Rk
 mX/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXhPZoxEfF6Z9A8U5M3M4Eife/PL3T4Yc/Dmt8a0DrwJAJk05Gor8bgHUWLAQTIdNMuJ0l2MaX88i0pQzeJ5E=@lists.osuosl.org
X-Gm-Message-State: AFuF++kFMNM3z2fLLbjNqOt7fdmcP2c0AVbfj1C83HjPVjHoJZa48Z5l
 ItXioToptAH2nGy/yYNL8WqCgQbwslZN5IXKX5T+4RD9pEv6W1x/3ND8
X-Gm-Gg: AYBFou3UZ2MCd43Qzo4K23cQWTRiLmIvluhyF8MK61brRbNRtakv/VOrZwYDVTZQUO2
 DthAyDF4OP7TXF3omhIE4EPhQ904HgQY8Gt7CRQ3mJp0+eDoyUBQSWc/0bKNZv9MYQkiOYTqM11
 rmDz16hRZiOdc2lFitTrQkZwVfnIghNI3BCLfwh2fWeF/6VLJM1MsC9uKrmb4CQ/fcTFm7aI9Lq
 FZMhHf8lFxNQZk1t8ItkXwrqiSigDnJYPV7yOwvWil2EAPNLAnufZgNInafw8O1DtYQNjooHTA8
 ofvUOfV++JXk4tdAhEvD89cz17mSdJOrjVlq39rzcTaz0rp4beuySL5xPxNjywZzCJ/KggkpulV
 UZBDofdeRCS/mjBNCqlyy2UhuSEuYGl0BMFmSE2UQUQoUun2GPU0omVTl6JlN/pHmOMtJpv7JMO
 oFtbX5uiV4mO9UgqSn6bBGcnJ0Zso4g6tpQd+osWvB0XF1aT3zVrPvzqAt0TMG4ONiu74xOt0mA
 iglvw7jB6ly7iUAKn5oHz3ZiYuY
X-Received: by 2002:a05:690c:c4fa:b0:866:e57f:58db with SMTP id
 00721157ae682-8711ec239e9mr98053137b3.0.1788818088629; 
 Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714c1e1eacsm78453177b3.49.2026.09.07.14.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 8/9] r8152: use linkmode_and_and() in EEE checks
Date: Mon,  7 Sep 2026 17:54:37 -0400
Message-ID: <20260907215439.409858-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
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

Combine the three link mode masks in a single operation and use its
return value to determine whether EEE is active.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/usb/r8152.c  | 10 ++++------
 include/linux/linkmode.h |  8 ++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..75f0574fe1d4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9149,9 +9149,8 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	if (speed & _100bps)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
 
-	linkmode_and(common, common, eee->advertised);
-	linkmode_and(common, common, eee->lp_advertised);
-	eee->eee_active = !linkmode_empty(common);
+	eee->eee_active = linkmode_and_and(common, common, eee->advertised,
+					   eee->lp_advertised);
 
 	return 0;
 }
@@ -9222,9 +9221,8 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 	if (speed & _100bps)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
 
-	linkmode_and(common, common, eee->advertised);
-	linkmode_and(common, common, eee->lp_advertised);
-	eee->eee_active = !linkmode_empty(common);
+	eee->eee_active = linkmode_and_and(common, common, eee->advertised,
+					   eee->lp_advertised);
 
 	return 0;
 }
diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 49587a2e0f69..efd392dc62ae 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -26,6 +26,14 @@ static inline bool linkmode_and(unsigned long *dst, const unsigned long *a,
 	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
+static inline bool linkmode_and_and(unsigned long *dst,
+				    const unsigned long *a,
+				    const unsigned long *b,
+				    const unsigned long *c)
+{
+	return bitmap_and_and(dst, a, b, c, __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
 static inline bool linkmode_and_andnot(unsigned long *dst,
 				       const unsigned long *a,
 				       const unsigned long *b,
-- 
2.53.0

