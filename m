Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3802AC636D4
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 16:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD213403AC;
	Mon,  6 Feb 2023 16:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD213403AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675700988;
	bh=iWvA6uYMSxhQOeuywNztIsY4r3yTVd1R/pkA5lUZmDQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TswZxf6vOY18QhWeqzx5nKfThe1ORpptF1QIxtfCsf+0t3VCncGniNFoXYYxMwC7R
	 szyForXXG0P0E1euJjxunEWfKFSLf41MtK75dN6Wx4YieHgu2NvYDZpLCY7Nqns1U5
	 t6U2/MFuL6CbXPRFsLcHQIrJIBWxp2XDvrZ0ELci0U1+iARG2lqpmPrQ9qkveepAnR
	 oRGEkWQrwdrGLXI2JzHWZqIiuHiymwt2gvLUpj37OoVTeO1Y0fXDD6yBjJUzYcvgt2
	 6e3wzp89/OzbEiFj3RgZWYikWF0Ch7cpuN/EDrmz1+SR3IWyos1IZzBfvN/jqDpv4m
	 goHnsi1Jz5vXQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHEyN704OxeR; Mon,  6 Feb 2023 16:29:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFC5740492;
	Mon,  6 Feb 2023 16:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFC5740492
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 9074A1BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69E5F607EC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69E5F607EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2BT255sbvx5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 13:51:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B59E160595
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B59E160595
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:36 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tX-0007Gw-W6; Mon, 06 Feb 2023 14:50:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tV-0034dt-QK; Mon, 06 Feb 2023 14:50:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tU-00DaQ5-VA; Mon, 06 Feb 2023 14:50:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon,  6 Feb 2023 14:50:42 +0100
Message-Id: <20230206135050.3237952-16-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230206135050.3237952-1-o.rempel@pengutronix.de>
References: <20230206135050.3237952-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: intel-wired-lan@lists.osuosl.org
X-Mailman-Approved-At: Mon, 06 Feb 2023 16:29:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 15/23] net: phy: add
 phy_has_smarteee() helper
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
Cc: Arun.Ramadoss@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 intel-wired-lan@lists.osuosl.org, kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add helper to identify PHYs with SmartEEE support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7b50cf099b2d..2378b81321df 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1407,6 +1407,15 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
 	return phydev->irq == PHY_POLL;
 }
 
+/**
+ * phy_has_rxtstamp - Tests whether a PHY supports SmartEEE.
+ * @phydev: the phy_device struct
+ */
+static inline bool phy_has_smarteee(struct phy_device *phydev)
+{
+	return phydev && phydev->drv && !!(phydev->drv->flags & PHY_SMART_EEE);
+}
+
 /**
  * phy_has_hwtstamp - Tests whether a PHY time stamp configuration.
  * @phydev: the phy_device struct
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
