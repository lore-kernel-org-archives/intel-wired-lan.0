Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AD9C79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE1446067B;
	Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ozEaBBRJA5I0; Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3E4CB605CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818086;
	b=g4+Xw45PLT63h+v8cVNEHPtmpIS2hgtWP+c0OU3coCIBS6WItQNQSFqR1QRwy3v5oz7s
	 7dnARaYzjVjD3gsG/YFbpRKjbjUP0TzTcVRBOy8Bi9lJ5Vh6SRIV4pLjCT1yLpGqPC5fi
	 /WvEX6B7srAStdEW6nqH88yy6/gUuYj7BTxrSEnyIWAUAg24i/qtzB4H80f3k59xXVaLa
	 0X0wTZH/k5194YYJSyEMED9zgGs+fgOOYvF/7yAPfOuprDlAkeujIFPCQpwZn3yTvBWe2
	 GH54w3HujOZhIG5Lrf1hpPM/kSI2qZVTH7/YraP/H/zD0SPUvsL/eEC3fe75oHCAmqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:F:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
	b=kUuSypUzlQPx544SwbhnHK3vP1W8I4dzCqh0GW4vF58zVufibdsIbQawGKAB6lbxYFoI
	 hMEQikwZPHmzAgwpbEDpsOPxIILXhrB/JbAFJR8E42FJt6kOj9akfWtYX7X5GbT/m4WRb
	 Kltvwt5iK5fUoL37OFHUoCy5yraZPRezmkAK1+pjEYOA/5B85MJlXzeGiJ4Gi1F4LHNsC
	 AVp4VwgYnfVM8kas6vwWBMbHf1lMKNehbiCZd1ePMn1mr8WUSwqUL2eclniAFeJS26l9r
	 5MWQhsmEy5OuwTREkPA4KqeyvrdQTtJgTmxDrg13O2+YmV3v68HYA42Qiklo0CEKhYg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818086;
	bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zmPkfAlawTt7pzJzVQRSE4zpRK948xYWu6BVJdKo571UEupfi5DiteuMZP5t6vSvq
	 mfT6u7sC3moi0Rfd3u/BlFCA9gdW7dB6uo1Mwe/+AB/uPGwKabwS/JQv+w/7N/W2hv
	 Lk3Bq9o8eTIs36YdaYj37HTCYH5KtdXyvqbl94DwtLvjoqSxLLOAI+27EobKZmfR+3
	 RSZsJLw8tNn6T+OC2elvCI9vqBGUY5FV287aEpUhMS59KDL27zwRuW1stKFvh6z2eY
	 i3kZm5ko1isFKZMhn/171XGIhU0KlCBMhNyEqWDl7h9HnkFOQhzrmQDjS1QH573k5r
	 mKxKtor7KZU8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E4CB605CB;
	Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 104CE230
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0061780744
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfWem2DQaS68 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0551C807D5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818083;
 b=m7Uv1oJTP6dSAXnaEotjmcNArl392/KdrUm7jEe8uBcyMEERxf50nfESVrakcvrVQ6w8
 oQ8v/pD1tXbPS6LIOt5uHg9wTciBEayPfS+742LkoOM6LHXiMBeX+DhcaawUIBPLuPZ7F
 xxyAMmbsd79x7iOYk7/Dh+JoOtmdJoW8SnO60yQbVZ+AhcH7/H2OVG89Bl8Q39G5qYqMU
 42iNyQX+zCx7BA9kUdsywKDO/+TBAN9xSaBayhsJUmUlF2immIXRJ70TdebwXelIqQ2sC
 Sx9fqMNedWxLQuU4lDa6jjXLt5UIz9/4fXif4d4Vo+kDgBamdWPYN/UlZTTyxS7axmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818083;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:F:Content-Transfer-Encoding;
 bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
 b=elaxNEYc9J/KYi6UyS7zyD5DAsFQE4hzy1RIMg6zNMaz6F8H48wU4pT54Ll7MCOWrnw5
 ok6qVO3diuhP1341D2gwnya8cL7nmmUnaygR3gZKzL1X/YjHf7t2j2rIe+25nJXpIVIb5
 OzMyU5J6dRoe4FA5AoCOwulqJNbooqspCrVWt1XjJHrnAI7UTHo3566JxVaDQC5pnMnBK
 muf9vTOatTbu9msuGfeClKNhcaXLdJXHChaHC64AhxXSXRhZJf7LJhaEtfZn5yfQlaAjn
 RbK1+q+cEwzI31NjOv7hq9m2eMgp3Y9+7/oVhvleW5yvC4SR28nuT1Hyff4SGzZ2RwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j8lBtm9a; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j8lBtm9a
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0551C807D5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:42 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8706dfdcd4fso48824497b3.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818081; x=1789422881; darn=lists.osuosl.org;
 h=content-transfer-encoding:f:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
 b=j8lBtm9awKj72NvHk1VSrntc6VeX31w8oExrnUsAFhEfR2R3/FQKIvmTvwuRnt7/vG
 lMciT80O8O1UCWLQGO7XMmOHxeNVGL2Vq4UVm9y8e8Cdi5KgD7zSG8+Yy32Iqn91k6Qj
 cuo64m8ID2GMXhMlG9DQnOi0npJlFopVCB2XY0nViK1YtrtU/jME2dbWfUMptPGOH98w
 eFCPQ9xR/AjEKqm2H5VApJLrYAtX135ty1BbtR4rQdr8Ghhfe6Co3GttcIivCP1piR1p
 WTLu0GBKiHmKSJTbMGJp+RXHGkXtu0R6UeBG9xZkGTpkoBOvH0OBlKQYTDc5wzLDo/Hw
 9abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818081; x=1789422881;
 h=content-transfer-encoding:f:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nwpffGrF0yp02BONayMPau7nafrjjaDgDJ94lomGBcc=;
 b=tT49qN/2w40AyBwzSIAf8f6LDZr9TzMtE91N8/HkWozWOJ19HEAkLN7I6QYNHNPuFb
 olx77l8UQZ70KtcDkF8/PPC22qYFXgM3+Ipn9FOZZIH0Z3lAnE0bV7zIr6tZiraYCbTA
 QwUhDOs11tXqs7hgcTF29unoyKVe/sBO0bJ+abHU9xYTzBQXPP6EviUCF1ZZjmvzyZ9F
 Jue3eLJiCMSZGfu+eamdAZFv9RqYzjVPn+iUcbX1B2jTnH4dd4a9obRoKy9LD4iZJ96u
 egJERQ9ifpv0giNih/VEeKsfOFCgaAdpE3RyRxHq5FcoZuRimQHDzXbShRyFFcuZrzGr
 ZOqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOG1Yp3eQkofifRamtXd+zLmJR4xZ6P0MUgpnd7iMmSPWXKmngr9pBWLChqYdeXCh+sHE50jX3Sa3uwUB+VwQ=@lists.osuosl.org
X-Gm-Message-State: AFuF++mGl46VzQjUOT9aezlZWR5XBFc+hDUcmsESJR+ltytloSQwOcae
 xj1VJxFCHBHBWClpWHAhUDav47PBuVALOulErOV5WFIMJ7O55KeG1cS6
X-Gm-Gg: AYBFou3lMvotIds1V86KtKFkPIilvpnEjlQFu4cpJNjy9H83t4UUkFN0FWt9AVNLk4l
 xiXvxcc3MyLT8w3JHfKLp2mIbSJQx7umej8vuZMqcbU0v38As0+BVHg/TQVxoKV1OeiSe6JUsjh
 4Zym1DGAyXoNMEYdAx0lBnxd46Ony8/R8nK9MeoLz35QM/ETc8evICteRu6JsIBBF1D/CldRXZX
 S6bjgeVQUiImGo1sN5AEsMmR7CSdr5MrRyUN+8m745lB+YYH07BdjUdcVGWsJP1Ky6xCLCriuXE
 x4a81nee4Mv/gCN41f4E5Y5504LqOInutCujWbtTc82hYEMVByUPiCvFi5gen6M4/tzYU8X/tJ3
 ij2JMyO9UoSz5pP6nfaGrc+n5rmpc3h2iAXRzVN8GQsiJs9BvqAnwvpU1tQfe1U7m80hvsLeNXN
 ehcbmZgZS2HIHbeKx/6LnQJ7+8fscZ65d/uvRYUh+yVTBWgr1D+BpjE/DE+0HJTMHMLsQWjHdO/
 wDbYPwT23tpkZLdYA==
X-Received: by 2002:a05:690c:c509:b0:873:5bb2:6c21 with SMTP id
 00721157ae682-8735bb26f1emr64757207b3.40.1788818081486; 
 Mon, 07 Sep 2026 14:54:41 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-871493168dasm78139017b3.11.2026.09.07.14.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:41 -0700 (PDT)
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
Subject: [PATCH 0/9] linkmode: better use bitmap API
Date: Mon,  7 Sep 2026 17:54:29 -0400
Message-ID: <20260907215439.409858-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
F: include/linux/linkmode.h
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

Several linkmode users discard the return value of bitmap_and() and
then call linkmode_empty() on the result. Propagate the return value
through linkmode_and() and use it to avoid redundant bitmap scans.

Add bitmap_and_and() and bitmap_and_andnot() for callers that combine
three masks. The new helpers perform the operation and emptiness check
in a single pass.

Yury Norov (9):
  bitmap: add bitmap_and_and() and bitmap_and_andnot()
  linkmode: make linkmode_and() return boolean
  net: amd: xgbe: use linkmode_and() return value in
    xgbe_set_link_ksettings()
  ixgbe: use linkmode_and() return value in ixgbe_get_eee_fw()
  net: phy: use linkmode_and() return value in
    genphy_c45_eee_is_active()
  net: avoid copies before linkmode_and()
  net: phy: use linkmode operation return values in phy_device.c
  r8152: use linkmode_and_and() in EEE checks
  MAINTAINERS: co-maintain linkmode.h under BITMAP

 MAINTAINERS                                   |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  9 ++-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  5 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  3 +-
 drivers/net/phy/phy-c45.c                     |  3 +-
 drivers/net/phy/phy.c                         |  7 +-
 drivers/net/phy/phy_device.c                  | 14 ++--
 drivers/net/usb/r8152.c                       | 10 +--
 include/linux/bitmap.h                        | 32 ++++++++
 include/linux/linkmode.h                      | 21 ++++-
 lib/bitmap.c                                  | 46 ++++++++---
 lib/test_bitmap.c                             | 78 +++++++++++++++++++
 12 files changed, 188 insertions(+), 41 deletions(-)

-- 
2.53.0

