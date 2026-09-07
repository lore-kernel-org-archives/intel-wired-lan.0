Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75124C79FA0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 488EA40506;
	Mon,  7 Sep 2026 21:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlE9lmWlOQnI; Mon,  7 Sep 2026 21:54:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 18A14404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818094;
	b=TFNWuFeKKBDvXYyWWc3/3kEeTU+Iu6cFf++xo4rJXMKDlcIfo47a6slREcadP6bwemKA
	 H/A6+J7WRLH3+AS24ZI/qME1cDTyZCSC20OG+AjvsSb1/n5LxsESBWHtHy50FFAt/umZQ
	 CzFEMoaA2iFdglPGeTFz4099Nho0imJcZkAOtqRy5U0HcHWjuLIylP8jok33llzWvsU/m
	 Ms4wM8+wfXkWoiOib9DHi0TV7ikvpWuNYb0wXzfVe/aMMJbyVX68tJJ69S0qY3LgUuxDa
	 EwuCV6syU9N3pRv3GTW7/3doL5aABNTDpOD3yydcUcjQ2c27yIr2Quo49t6jOyckSsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U8WIjdrmzAfceuartpDLM7+z5YZ8GSTaR8aMPWb/Pj4=;
	b=mQhwGT3XQpoBpuaOvPlneME+P6DCHAWva3oSBIzCyXguk/bKzLFIVDyljS/+ouya6TAY
	 XZvqWcAFpsL/K4227+hWluefw9hv7oogxVzJ1eLlV0HqFqdX1t2XCSLG13lflOvXuMzY1
	 VKk7OwwM7n6LvHLs78P8Qiv0mrKY155xvSzUWVsAP4ZCSnhYMBTTDzJ9Z24kskQMkHx1a
	 +6/tBmktLjyCUX3nT3dnnqBJ0TzIYbrtFU6wT8jKiI3kebO/S+r2GU0b9bMUnXI+qt6I4
	 JtqMSVFa9mh/KK7LQTZe2txljIKf6XxumnFutsa3UjPs1uwGsJr7waEXkVEctv1wv1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818094;
	bh=U8WIjdrmzAfceuartpDLM7+z5YZ8GSTaR8aMPWb/Pj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4Krvx5MI7rUIjaIbsrr5XK8GK47wac9L0iYrRkrFogaWj8n5+x9GjEtBCiHVNUxsc
	 zRVB9NcTCFhovq0et1mt+0yyQ+Rm9PmVbRmc3BgoZeidFbSaPFaGiCV21cX/qDFPff
	 XR/Ci/lrsct2PjhJ/qN9rqnH4Dvj2SRcb2IcO/PNkaN9J8RnQ19H9GQ7KcMD38FK5z
	 ZLaqkZp2iMw66kqPi7kyB16M1J4zI31ebW+tdiiD/rzrFsXxtQROVsFwtTd/rulQc0
	 Ewu6JGhvK6z9zohp/GJuep4U8T97vG2FFss1gKIF1XVbZXbgLBsZZAb9rt/q7MuGW6
	 iFDWmFAag6c3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18A14404F8;
	Mon,  7 Sep 2026 21:54:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EAE349D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E856606A9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ch4AmsJRg7Xz for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C9DC6069E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818089;
 b=Ze6QYF1/72VMxBTWZh/pDjp0CJUmOGFvkeENEHBuWTpOoZ99aFs2vur+ahxhYVxkvBSQ
 0Z32jzLixbwPzpwLGKi3q9RjdOFvvpvhYpfGsbHiulxBMXcCegGvGjJNUizoj0GvhMTRk
 gPaIXSwJcfliIJ/+FLRGNjqzB+pxS6hVfQdVhiU4UG/SPZqKaQqvuD5YxGsx4IDaCSWCK
 6b6gV11TGft9exY2ll+dp/9R32BZiHWIu676uE9wHcdWh/MP+H04R89Ee6OBGerzLkx7w
 gui7fRX/+lgNIE3loymMUdwOLdnSkd1/lfRK7kZKrCA6nvxwM4gh4Z5M4zW8gvnCJGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818089;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=U8WIjdrmzAfceuartpDLM7+z5YZ8GSTaR8aMPWb/Pj4=;
 b=DWaeUjJlxNVruHjBUIU5wfJRS0iABTHqpVbcUxFZYNMuJ4+Wa4Paud7E7nEowtHiq70x
 5gfiQ9CtTD8a50f2H6m98+Z6szt+Eb4+v7s7rnvPfKlSGsauJYNv0aWCRhGkcn+NAma6T
 82RMBvUEs65pJ4hhqNrS1I3xrEfFFgs5NVWKAV6bWdFwUAWU9qzEon70U5hSQ0uivztM5
 9V0SxtFKBhMmD59eHSTCixOChPS7iEQW8UqN04/zMTFYi+VihbDmxF9MxJSHrs05I2ZDP
 V/6/9UIZWYu4pMZOKoE/4hFYZfQxlnJpsz+EmQFr29Vth65a4uaR/V653SfMaTpHlrg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XZEQwVQh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XZEQwVQh
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C9DC6069E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66fdf2a9aacso1525229d50.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818088; x=1789422888; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U8WIjdrmzAfceuartpDLM7+z5YZ8GSTaR8aMPWb/Pj4=;
 b=XZEQwVQhFlnlo5P0yaCojDRzGsczuo42XyuWJpuyIqKCMbtVowYOGx03YbwwGjGZAP
 N6O33hDsLl4udLGoNbrhWRj6xY9tj+7uC+8tI+uYYUPy2MwY//g2MbIZdCpkX+9vlMZU
 yqsNdyH/kVyeJO+5J3Mfm4lFF6NIT1hp6ZRGbLs70bN+pZrnBTvMonSTzevr7gKlCBoS
 ewG6GeVYlJ70DUCcf0Uzp/R8qhxP4yMcju9/5mZ6JoSOb43mSvS11yrReu6DMEcqjVcZ
 jLZdD4pQsM2g94Ygs/e5dvsZeqD8mGy+K856sUzaqXLNm2TVnULq5ugOaYaDV78opP+p
 zQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818088; x=1789422888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U8WIjdrmzAfceuartpDLM7+z5YZ8GSTaR8aMPWb/Pj4=;
 b=qvllNCYN92FwwfEoaaS2uOMQ2eXWZe4wGQbQA7+ycrg2u2Kig5MJox7HXQUcpmbY1o
 vEhOKzFd+8F7u6wQzmsObYUa2KJmyQWe29eDijUaommGt27TFxonbDT08jrN7P2yFYdM
 gdmyI2cr0y0ZeFcFybAD9hOSlUcP4yIRlaCsNb6PCegp3Z74Pf44tjBOKKL1kAW9GriC
 nBl9xt7+xCMaTnRW5BM3MB90jJEHl0hvq06uLHM1pTiwsfhnOKie4cE6MC0uniHZlfbr
 9J6dMzCAO+wiqchjWP5qJ3ugWC5RNIw+LPNUF2G8aSNx9VOb6QIqN6B1toOD7J6TQtt4
 8F8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSLWu2nmRGLEbXF+V+xseLVg8RVlIK102+URV5xsV6XsIJvKYaF41rSv4sKpw1tCyHuBozP+wPSIhTyAjhhiU=@lists.osuosl.org
X-Gm-Message-State: AFuF++nECIKId8kKmdWmrob/lGI7K7ibY4Rk3UE59+YoLoCzPh3jA+sm
 mJUYdLJlJ8/MX5mOQm73QU1PHEBAMPdJLsrjBi6vUXBj0rK1MiNs+4C4
X-Gm-Gg: AYBFou1A1/H49pqUbQ3Mka6uAfunJjMLzXlcpxXD/6BQUBmLu+MFRn5UaXuTIBsQZZ4
 zSij+cCziktr/OGrn0rByuzkrzHANrMEeAWoTvGPB8BUd27A7cGkmFpM+j2EZJU7bImt/G1wLWP
 r9H7rBifXUCPCNQmAMeiNvvfZYvboABrAYbaSnTyC2MhDOqgrqHNTYJf92moceA0WSVZyXjYFga
 KbJ2+czIYdqCtFl99cIFSeHRoy1S69QLuxjHJx/PSvOHz4mik7ZWV6AjpXnOupC9oQqmrbeYlVB
 R26B2tg25D8sBaEjU7NSAnW8jdBChmVSiMJ1LAWcM8/6P/vyojupVUBfjmOoeWXsqCunnk4vkV8
 FTvX7PsS5CTfz5uY5H9IWbwaFs1lYBqbTcYHr/pzTDi0AmYf7Z9aysfj89dBHItDLjrzB29rJ04
 294KblVOmr5ndAxOglyoE3wZ93a9nIUa7oOXk+my5OpDRmte16gigNL6kZkzDpQU9QonyC6ePU1
 FpKGhAe0LUsqR4S1j8H/irAn/gW
X-Received: by 2002:a53:d751:0:b0:66f:c1be:84f3 with SMTP id
 956f58d0204a3-66fc1be873emr4452634d50.97.1788818087837; 
 Mon, 07 Sep 2026 14:54:47 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714a87ead5sm77758477b3.28.2026.09.07.14.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:47 -0700 (PDT)
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
Subject: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Date: Mon,  7 Sep 2026 17:54:36 -0400
Message-ID: <20260907215439.409858-8-ynorov@nvidia.com>
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

Use the return value of linkmode_and() where the resulting mask was
previously scanned for emptiness. In phy_probe(), combine the AND and
AND-NOT operations and use the return value of linkmode_and_andnot().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/phy/phy_device.c | 14 ++++++--------
 include/linux/linkmode.h     |  9 +++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..3430605695c5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1565,8 +1565,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 
 	caps = sfp_get_module_caps(phydev->sfp_bus);
 
-	linkmode_and(sfp_support, port->supported, caps->link_modes);
-	if (linkmode_empty(sfp_support)) {
+	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
 		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");
 		return -EINVAL;
 	}
@@ -3761,15 +3760,14 @@ static int phy_probe(struct device *dev)
 	/* Some PHYs may advertise, by default, not support EEE modes. So,
 	 * we need to clean them. In addition remove all disabled EEE modes.
 	 */
-	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
-		     phydev->advertising_eee);
-	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
-			phydev->eee_disabled_modes);
-
 	/* There is no "enabled" flag. If PHY is advertising, assume it is
 	 * kind of enabled.
 	 */
-	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
+	phydev->eee_cfg.eee_enabled =
+		linkmode_and_andnot(phydev->advertising_eee,
+				    phydev->advertising_eee,
+				    phydev->supported_eee,
+				    phydev->eee_disabled_modes);
 
 	/* Get master/slave strap overrides */
 	of_set_phy_timing_role(phydev);
diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index c08632c10c3d..49587a2e0f69 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -26,6 +26,15 @@ static inline bool linkmode_and(unsigned long *dst, const unsigned long *a,
 	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
+static inline bool linkmode_and_andnot(unsigned long *dst,
+				       const unsigned long *a,
+				       const unsigned long *b,
+				       const unsigned long *c)
+{
+	return bitmap_and_andnot(dst, a, b, c,
+				 __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
 static inline void linkmode_or(unsigned long *dst, const unsigned long *a,
 				const unsigned long *b)
 {
-- 
2.53.0

