Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8675DC636D3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 16:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4100B400D0;
	Mon,  6 Feb 2023 16:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4100B400D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675701002;
	bh=pwNsqxS4sy3l2YwAsqqOuNx1yID1cCAU4PFb9hfim50=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vMCYcsq6dj8bWr8vYI0mQXJHGhSE12fSv/tGRNGNhUFxvogCK3mm1BWB9KwbDrvMP
	 ZPwbvWtpR3MtUd6+VkuDqNqpsO3O1PfVR/cP0zROWGXJ0mD3NKYa+Ase15E0rLXmrc
	 FmKvl10cE221tdNGe+k6QBqlAAM4qKiQWW+XiLi1cnUv/fTnWD4jITjMCukvdHWpSA
	 N9jKfdZKDLXIvv3skP/+h45oi4AvGLLZrHNnGGn/YXtjYLGA+iWcbO1ImK0HkcVRN8
	 GE3Dv4MYrNWt7bG3UiCuE3F+8bK5LHHbekXEZ54K8Rr0431Z3orH6dgTsgL6P+54Sz
	 yMviKlaXtDomQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJ8aFl4igIR1; Mon,  6 Feb 2023 16:30:00 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 575C0404B1;
	Mon,  6 Feb 2023 16:30:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 575C0404B1
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 105E01BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07954403B8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07954403B8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrWds8x77abF for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 13:51:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 489124021C
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 489124021C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:37 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tY-0007Hk-Bm; Mon, 06 Feb 2023 14:50:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tW-0034eH-8Z; Mon, 06 Feb 2023 14:50:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tV-00DaQJ-1A; Mon, 06 Feb 2023 14:50:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon,  6 Feb 2023 14:50:43 +0100
Message-Id: <20230206135050.3237952-17-o.rempel@pengutronix.de>
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
Subject: [Intel-wired-lan] [PATCH net-next v5 16/23] net: fec: add support
 for PHYs with SmartEEE support
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

Ethernet controller in i.MX6*/i.MX7* series do not provide EEE support.
But this chips are used sometimes in combinations with SmartEEE capable
PHYs.
So, instead of aborting get/set_eee access on MACs without EEE support,
ask PHY if it is able to do the EEE job by using SmartEEE.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c73e25f8995e..00f3703db69d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3102,8 +3102,15 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct ethtool_eee *p = &fep->eee;
 
-	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
-		return -EOPNOTSUPP;
+	if (!(fep->quirks & FEC_QUIRK_HAS_EEE)) {
+		if (!netif_running(ndev))
+			return -ENETDOWN;
+
+		if (!phy_has_smarteee(ndev->phydev))
+			return -EOPNOTSUPP;
+
+		return phy_ethtool_get_eee(ndev->phydev, edata);
+	}
 
 	if (!netif_running(ndev))
 		return -ENETDOWN;
@@ -3123,8 +3130,15 @@ fec_enet_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
 	struct ethtool_eee *p = &fep->eee;
 	int ret = 0;
 
-	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
-		return -EOPNOTSUPP;
+	if (!(fep->quirks & FEC_QUIRK_HAS_EEE)) {
+		if (!netif_running(ndev))
+			return -ENETDOWN;
+
+		if (!phy_has_smarteee(ndev->phydev))
+			return -EOPNOTSUPP;
+
+		return phy_ethtool_set_eee(ndev->phydev, edata);
+	}
 
 	if (!netif_running(ndev))
 		return -ENETDOWN;
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
