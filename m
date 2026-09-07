Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45980C79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE2976069E;
	Mon,  7 Sep 2026 21:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oiqx0_SBhK1q; Mon,  7 Sep 2026 21:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 39CFA60693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818092;
	b=Qn8lNDjFkhwN07NefuU7A/QBDCNDliMYUbm/1cm5yaHVMmSbag2c62zQlCjWEoqzxPfl
	 wn3tihE3FflC081HNIkRUsx5yHlTFQD2KGUJzGTSb0twPUoTHREVKk/DLqTzvyhTHykAu
	 AWqsuIuNIwTEKHW7ua8ITTOgBklVVx1rYsz8VMxrObDl2G25YoKkBoDzw6pbbTqB9mXu1
	 ATGIQpzwcj9kuyYC54Nmx4+6Ghcz7OyWAd7idkXY8mUSFsmCYNPVgovXi7v56M/RUQIAS
	 xS6Ia2oKAgHUBWpUvdXpLM/Ekr8tdUYFD2TNy7FUok6QjB/vsMUhhnFj2C0gs4r4J1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
	b=IT9dk7XU/HvU4GSTHeBC9eXIFsYhmhi236u7tjUSFvpR42XHU/+o+Jp1W6NaqWwcygvq
	 GwPMw1l1vRa7Gc1eUkbTWQy8CcjmmueJnIIpbyCIeDjiumvt2BCIQmfjypQduZipAIQtV
	 6BaNwwF92EfZKk1ztz3PjyZHiCtMm7h6e1K4caIRgjIQHiEBDNwDeWrSPBiz33I8T2aZn
	 bmBIUnwnMd2o3TDyTkZExsMPlZLPHIBPVVg73RYSHVn4pz8dikqZ9zQPIs8wyFfIL/VTt
	 nMHXaFFtvp2waorSvUVodj3h5wAoO80hEaZ1fFc0wLL0INknqyf388HL1GUfPr/NXNg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818092;
	bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZwupDagAL0Z4spiAMCM1L4SM6Wx3eZldWA+newn/fRtrfKKVEeBs53vHbwU/U0n4N
	 U6vUxrfbMxXnsA1x3Fc3p5GuBQb55HFsp8zx4ifJEJQrtgetIDkS/hFkV/aAdCu32a
	 2R1Dap3yKNQDNX36+48YdvI8NcwXsdk+FVHjaJBVEtCDGzXK/uUX6FUMJNv2Bryi0G
	 Y7ao5rCEp3dP9WKBKtTrIjVWe02ro8Dg6mLvixxGJ2bQNnyZgA3B2KWIsIQ9YbURJL
	 FJy77ibP0s4TZDmIhC7kNGhOEIM11dUdl5856wwvQzHvpTyErisQvs6kNMbZIKHWVX
	 gjZ+OHU97ufQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39CFA60693;
	Mon,  7 Sep 2026 21:54:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F7C4D62
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 302AA40099
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACVbklv9bFf2 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 775484005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818088;
 b=ZfQw+/yBQFcHHjCAIZfd07EyxzHzDcGYac3owWQhmweeOUesqP0Z77+f58M5idwkj1nh
 nxRq9W/GjIsoqWLKTdava6Q7xg/lb/uusq9mUymF6sxMglyXpGbV0wHMcCqsZsWm0wnWE
 b+S6Av+QDF3M/1fBQHvAOAY2l6j8WxkeYFB6dBkGsHXsyiqK+MoWSwgaXIpGLOMV87T8w
 hgF9GVKesNN+sn2KcCScIh1sO/gjA+v6FOKuTiQtx8yGcvo8XivjXJBhRI/I6zrs4CIk1
 oNughHEahNYj+0X3wegbrXqw/gPEV2fryi21lCxAmGulENlFuSBDPg8HqpU4jT9bfwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818088;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
 b=V104HGZCuPcHHIK/ZiRubXF5Aw7zIKaIZzUBaX5Rdbb8EyITbyjlSe5tUkRz9F+hnhik
 PGCwxdI/EUyaSEmgDBlNii3ijQt0Z7Rw/U6yq/jHg0mdNRtneKIbOhzLB78qKuIPJKS4K
 /gI7JELhZFbm51lBJ8asNzFX0i+JQhd2CBytvwVo/CsqcpIC5w/DYV1y8uD7aAZhRaMks
 9BbC6xcyvMABUSwxqlYUamg9cSJ/fgH+ye6vPBB9CfTboWZocKMEFUq94yo7D3MN7+duT
 5FQPDthMnHKmToelHMploVrSQNVPtnc6h/ezPXzg5DkvuNKjOK1jY/rHFuuEJ4zajdw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dw2TGt8O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dw2TGt8O
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 775484005A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-87005a0e052so42555777b3.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818086; x=1789422886; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
 b=dw2TGt8Oh8K5PtNCQL3FT5u2CqVr7w4YX+0GN6olVtfR3HFzPU/1d5g6fDYlk0/6Zn
 Dr8f9n5TQCOaeS5XG6CUfOCMVP9tonn1kw3RmOFqtV0znA1s/UCe645pjPhaaz+Y7War
 ZNsDmOej9pWnNuGLrmFXhMMo2qz0EVUaCvyjcSAX6mk9aiLApVY8wgXF0F7uwlE18PkG
 CNiAIHmeeO5yIR4+2kqLDX1Gg1FPdiD5MJ5reBkTJ2xfs3xfvu7ph96dKPD7NGI1f1/c
 fcsyINfQj1C4ifyn+UpqJg+Y7zOwSJndVd/wliiT2jQQf67SmXdELhW5EK1ZFktHyYG1
 fzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818086; x=1789422886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FMBKloH328hYHvt9A91TOoJByZqoZnKZvzZqMuRPjLA=;
 b=eey5cfoubjwXEMToSlhWnD3Xg9uNkzuOg+6B70PUaj8alo5oxPwJXJi1O3oAOTpz6V
 HVXxZW5HgZty/PFy6sBVyrYV4x8yCScwSErYKa7C08rfBbbv1duT8rnvjiXchCxqjFSE
 1wGXtVMFungyE5pBgzcJPsoQJH5pxQr5pRQ4QjSFji+l4LeAT74DkAXDh7svD7u3ynxd
 xTP8HzR4c0zgfB1SI5zZqpePLV69xv79m+5oYzYczn+AwPqAmN4MYBsUK3adJvAxAls3
 HbYBT6jzzBh3kQBxNh1mrTRKqveVetpvRzo4Tp8HeMLO+Wi10wXE+zJPHXA7m39POp+o
 6LsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4BALIPdNHJSGNim4px0mpim77yZXpGfRczdbfK0vK/0jJ8CPB9w39PDuaKw9MtDa2mAj2xXEOgUH651c59do=@lists.osuosl.org
X-Gm-Message-State: AFuF++kVRA3wx4Hw6Y0F4SroLsBrlB07RGU0eLCjcYEz8UhI9w1VF2NK
 hRtKRuCFlEeHTpQueBt5StFS2hgm4iOy9qqMfC7LtjOeXidoCvWsL6Ng
X-Gm-Gg: AYBFou0a5CukUxzV1NAxRzTe178IkJ4UPBiTBkqfv7MSxJV2K/IuUQHTrDhc6ZczRWG
 E12zp5yT7zDKlYQaYYLUHp+6tnJk5XHQeCFoCCim5lOk9Q6v4VIQfQ7QbU5k2i0dpU1+8yfHLT0
 UxbIBDiTw04wquN2lbKatK5OJdCnoj3EPJJKK7b8xe6P8dILcbXNImTqTbIMI51Vq+pfJp0fhBy
 PAf6huKJ2/TER8wTwz3E8M4/vav5QlU4KS0aVHMSpiMV43GJxcJrGwefSAULPVR6Iq+zISlMCDX
 3TzGihe9PBWUEQmC3H/UqvS8Yozn1MEKJR22sJg2wFeiafYMNXfYJflC7NtbCYMhrms5bAEZ/qu
 siduhgt9BqquCvlcUIgIZN4Phypp2u3a6Me9rF/PichI8XzFCp5/bphOKunuoYum0O/DSfGpbM7
 O+GLLO3P45tWcaUCYOfEq/MxezweU8M26+whpUzqT+rsc7w718V2SXl7pMEF3chen9/3pP41jRy
 V2et4nuM6vLK7WPQw==
X-Received: by 2002:a05:690c:88:b0:864:6f4d:ef7f with SMTP id
 00721157ae682-87121acbbc5mr98578937b3.7.1788818086189; 
 Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-87149316356sm77902237b3.9.2026.09.07.14.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:45 -0700 (PDT)
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
Subject: [PATCH 5/9] net: phy: use linkmode_and() return value in
 genphy_c45_eee_is_active()
Date: Mon,  7 Sep 2026 17:54:34 -0400
Message-ID: <20260907215439.409858-6-ynorov@nvidia.com>
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

Use the return value of linkmode_and() to detect an empty set of
common EEE modes and get rid of a separate linkmode_empty() call.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/phy/phy-c45.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 870920311f9a..27da1b9ddbc5 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1623,8 +1623,7 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *lp)
 	if (lp)
 		linkmode_copy(lp, tmp_lp);
 
-	linkmode_and(common, phydev->advertising_eee, tmp_lp);
-	if (linkmode_empty(common))
+	if (!linkmode_and(common, phydev->advertising_eee, tmp_lp))
 		return 0;
 
 	return phy_check_valid(phydev->speed, phydev->duplex, common);
-- 
2.53.0

