Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D6C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A7546069E;
	Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wN1HNpBo4obY; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7343C6068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818089;
	b=mfsoPADVqfCrVuwHovnNuopIUN5dW/WrVa/VDR5kEj7/accI0i1Ptz+we13HazxVydLK
	 cvy0a0kYbUmZDmc8VmjtF1P7gDfDLlFVXtQ7abrNFkriyMeGG2RrkM9VXNL0UqIiqK+/+
	 /dy1wVSEH+NByu1qEcVEkxWYml2/y/k6Hf56z6NRlZBio+1Od4f06R5TcQ+q0xm975MDz
	 3KfzvSz2DZoMj7yElhOunuU3W8jqhvWH5nOQ0Tzhff5SlRcDC5czHH6i15UMxlVqeNJY0
	 +AFFrp7k3nC5WwuYhupYqACwoA6L3ZM+6PbQn7wirgQzHXs/f0nJ0UDs32+3a5c/4FQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6RHq+lKbojD+F3T7fWOVIQ9NEbYVOA2OmDM0VbI8dbM=;
	b=Emef8KqnAPch42v8PylI5XAsZV68fW6lPHiBr0hBcdRr/I0L1BSN9xtxfRIjE9bQpg+y
	 z82IVJRdhEhm5IrtnSAKG6JQ9sEAqiICjPiYWxncoZoyQhLd3wvESMMHmua24dHrJdWVv
	 J63JNgJ+fXt1g4FzQbwxwk78jA3rqBVX+jtIV1AL5aNEBy7ArHr5I/70ck21HlcIpKmTz
	 /652Hc2QwkX0WGfOcrynVKbtP5KSCc4v9QRTLb1sbUUxLYCT8frXG5xvKoknkQNIVWRCz
	 H8/iyL6v/UsdIjCgx9Uft1qL+1KCscTuJMo+Fx3qAYf0NpbPw8oZ6jYFQCwmhUMr0cg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818089;
	bh=6RHq+lKbojD+F3T7fWOVIQ9NEbYVOA2OmDM0VbI8dbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDxg02vEDkG19+76MjDz7Z16rADDzed3y+tmwUmlCtn2FoEA3IV/5Nhi9MRysyKRK
	 YlL4H66hE8PpQYuyygjJkbKJujnBYcsP2OThpEJJSgdN7cbed6VNYS3rg5t+YS8Ykt
	 SyzGfa/51qX4uLiwv6k9kwCQ3Q60O6vV7yKRQVE3weiIVM2UH9CSg99JmJkV1qnBWx
	 3X1/JZhxN6vCRZpIiffaKgNga0k+fXy3ZOZAkEYM9+r9/9SQbHFZYUzbw8fErhrsmH
	 OmTQdfBCzc66sVQtZruKvC9c8zD+bABJv5XLb1B2SiNNENvZjGCwG5flr8ykQOE4wZ
	 b90q8K4FJvqUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7343C6068A;
	Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C287F49D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8542807D5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kc_1V2DxfoBM for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F2CB780744
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818086;
 b=lTc3d2HCP5qx7kikF+wro7VPeM+1DO9FCwE7rEnhuNX6gmCt/yB1D8/D38txt8FHeATQ
 EsAAbBJ/NOicaUp/rJgrJw9sAYKUWZ0/Zd1NoTUN20lVDn9OH0ke2D5SeZwrlqUQboe3m
 83sOoiSQDfoQ9wNRVae9gjQVC4RF8UMDUGHSTE6UI4MG3Nlw75ccPsCzOLtJvAHLZWqD1
 9eEKM5Ednn0CdYQsXWykTfgKailam0+EdOHwV2TURWoyWZyNqk2XCp4K3i4ds+0w8IQYR
 o/3DoUiAP5JxdUGcmS6s/lFumF8KcyjgcgJ2qwnrOqiTY1nTNiKh48Pfj0mlpyuDXMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818086;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=6RHq+lKbojD+F3T7fWOVIQ9NEbYVOA2OmDM0VbI8dbM=;
 b=qcmDC5MxEjX+SqxdqTfHO/gvy4AYKwnVep2qqxrB4GDADuPxgboXOc+vWqsdyc1m3UMQ
 UjbaC9g0qvKtOCoT8WoY5nR/VOYmYyP7E3riBcl2+Ns37JtOqEKH0Ra3u3RJjjSR3VTve
 3qwjyFDDoC3SWeQFKt94A+chtoqVUgGXfZ6HHtUpLW+VtGukpoDxmVNIpJUKZ500839B8
 g137mIuzaYvn2annE5OORwabnAnVOI7Pyj06QU9bKCodGM+YkNVaIhm15auQ67d56m263
 eO1DgR36yCld0bauDOGdUDUJvdkoU0Y+KMRg5hOwU7r9LBjQlCZH6dYvVrB0R+i/1qQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mHTUjqGw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mHTUjqGw
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2CB780744
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:45 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d4eb63f16so2583367b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818084; x=1789422884; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6RHq+lKbojD+F3T7fWOVIQ9NEbYVOA2OmDM0VbI8dbM=;
 b=mHTUjqGwHis7GodGqSH1zssRKl3zITND4dAxsfQJIsSUZTW6cZK2T2skHKjdImUGa+
 YMExlHhxGUKQmMFOat33h/zfb0HZ0ssm/xev9v7o3sMoO/izx9BGYnWJD/Lwmh/2Glc4
 6WJ7x3KZ+P3Z8ELlpWuXJZq53dS1unJnI5n6QLfFZDr4vR3IEKBO1aeCjv2aEedLX59c
 B0DtTXY0ZzJ63Ncs18fCOrv9MT5BOVqHnBreEyp8JG5/wxhRk/X9Ugz/eKk1ErGoX4T0
 /AAP/uJsP7O+eP+8oyxVpZxhbN+kEpp7aUNgb3ogPX5/uRPYrb3LxfCoWO4POCIg7No0
 xZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818084; x=1789422884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6RHq+lKbojD+F3T7fWOVIQ9NEbYVOA2OmDM0VbI8dbM=;
 b=rEsSxJUnDTMucpQYw/vbJ5VrFlgOYyUnrRcejAoQI1e9Qjn0ME7Q19+3aFwBhivxTG
 CMhduW9sFvhp0O8cTPjwojuFEckkEBBZREV4MQjiyp+d5oiDwnh0qd8n1CrDF1KvmjYw
 AGQUvFRAdGN7HHoZyddEfiZD38rdD818JDheV2TYw2la7EwWqvlVekjBGYbFJJAreBC0
 VXw3HRUjso7B6QLMhQ5TzF76mi9JxqW/kBP0ZBlz3GmHkNlJPPVW2LqrpvO0pJhyv6fg
 h/eHLc3e6uFRSytCOGydgaZBajvUC3bxrnNn/wWTPcgp7OI1iVVU7uCoQ3KG8kUIAgSz
 v+mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNawkMdU3VsrsDYNeT+N3Ltrd4tkeQlM44yudscNBdJ/w8QCbuu/eYagJkZ48kN0pbZguasWHAFlBs4x61sdI=@lists.osuosl.org
X-Gm-Message-State: AFuF++n7RTMstiq248SJZc8Hu28Coj9YN3Hzy69T7qzHr0qz4OfX4SM4
 DvBb23hfU9BPUpq3jR4j9KZWxPtF7Mmo6vCgQaRUas5MlKf7bj6pqC9j
X-Gm-Gg: AYBFou0e81nB1tMfGl6WFOWodEcMEO+phaizIrsbyC48jcZzJ0y+OKM7aXR2a0FsA79
 Dsu5fgWmc7/5N8XmOVmd9g8BI/r+gxntpPrx1K/46kqAlSeLbn3ZpNqKDELdxx/vtY+mjkZR8ge
 XzybqjkCptEebjNjxvZ8m5vkpTk+z4f0K9FEc0bXUovxK/PsIxzXQM4Uz2HFcvtOxSbw880AGNy
 TqltfDWwbrYqzhyPnKsVLCO9ObpMR1xqgCULybl3YDPpQsEUPOHiUs4dMWK1yA1kIX0tWClb3Ri
 J5Ss3lMF0oHLDbDxui6liX4IWi2HbBgGx8UIg5w9tfJJOyfmyHemYbn4HgLPW4a4Jw0MUXcfGcS
 zo4rTL2Nuhq9UaZZGkqkhBywMVP/hWnSP6URQMzRj7l63xuG+A/NDxKT4WBqVIA5Frbl0QO/cKx
 du4ck99sebk0az3oMzG/igNxycJZr5vl38ZxY86MA26jsk6q8MnQU0CFWCmTmOqg6fbCX9aNAWs
 rySV8rSiDsPTKE5/KTulrQ3uEy+
X-Received: by 2002:a05:690c:39b:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-87c098a896emr9838697b3.12.1788818084460; 
 Mon, 07 Sep 2026 14:54:44 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-87143bb048dsm77918817b3.1.2026.09.07.14.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:44 -0700 (PDT)
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
Subject: [PATCH 3/9] net: amd: xgbe: use linkmode_and() return value in
 xgbe_set_link_ksettings()
Date: Mon,  7 Sep 2026 17:54:32 -0400
Message-ID: <20260907215439.409858-4-ynorov@nvidia.com>
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

bitmap_empty() is O(N).

Use the return value of linkmode_and() when validating the requested
advertisement instead of scanning the result bitmap separately.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index a9f4fcc4daae..113a10855938 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -231,6 +231,7 @@ static int xgbe_set_link_ksettings(struct net_device *netdev,
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct ethtool_link_ksettings *lks = &pdata->phy.lks;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+	bool has_advertising;
 	u32 speed;
 	int ret;
 
@@ -267,11 +268,11 @@ static int xgbe_set_link_ksettings(struct net_device *netdev,
 		  __ETHTOOL_LINK_MODE_MASK_NBITS, cmd->link_modes.advertising,
 		  __ETHTOOL_LINK_MODE_MASK_NBITS, lks->link_modes.supported);
 
-	linkmode_and(advertising, cmd->link_modes.advertising,
-		     lks->link_modes.supported);
+	has_advertising = linkmode_and(advertising,
+				       cmd->link_modes.advertising,
+				       lks->link_modes.supported);
 
-	if ((cmd->base.autoneg == AUTONEG_ENABLE) &&
-	    bitmap_empty(advertising, __ETHTOOL_LINK_MODE_MASK_NBITS)) {
+	if (!has_advertising && cmd->base.autoneg == AUTONEG_ENABLE) {
 		netdev_err(netdev,
 			   "unsupported requested advertisement\n");
 		return -EINVAL;
-- 
2.53.0

