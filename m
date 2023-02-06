Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69371C636D4
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 16:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2063660B32;
	Mon,  6 Feb 2023 16:30:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2063660B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675701051;
	bh=SGs1QnIlk0ARgyRH6gT+cjQiAYPAdK2U960nOqG7jek=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=uwpWL6g0KiD4efCvDhnOWRQ7NVU6Mfaucze2eNHzGkCBHkUkEXQJP5YsJZxNtjLQ9
	 FsnQWvF2r9Mk/Lwdf6vQVegQTqiVV0po7ZyonXH4ARl6Zb7EqMRSwZjE8qaqvaUPXr
	 +vkIcAgxU7tgdUEQoPHn9IzK80Jxu3neJwQq78Zc2FHnwi5l5jyuzbmi5JkN6gp//T
	 PWbk5jUz3Up5igcdQw7OAn15XG8MjKKsiJB6kiJetV/vAvHlgweP1UmO+hMYhYH+xv
	 tZFI5aSL7OQQeSJz7ixAVt92vSLXgJMOXcgj7Cu49WnWTpTqXtccA0oUG6Sk2uUA9v
	 j6X9rsFF6HO8A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPKCV9RvAH2F; Mon,  6 Feb 2023 16:30:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06C2860B36;
	Mon,  6 Feb 2023 16:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06C2860B36
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2E69F1BF951
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2A5E8135C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2A5E8135C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VcYyQfT9dsZJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 13:51:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12F8181373
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12F8181373
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:46 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tX-0007F9-4i; Mon, 06 Feb 2023 14:50:55 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tU-0034de-Ux; Mon, 06 Feb 2023 14:50:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tU-00DaOs-Ct; Mon, 06 Feb 2023 14:50:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon,  6 Feb 2023 14:50:35 +0100
Message-Id: <20230206135050.3237952-9-o.rempel@pengutronix.de>
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
Subject: [Intel-wired-lan] [PATCH net-next v5 08/23] net: phy: migrate
 phy_init_eee() to genphy_c45_eee_is_active()
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

Reduce code duplicated by migrating phy_init_eee() to
genphy_c45_eee_is_active().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy.c | 89 +++++++------------------------------------
 1 file changed, 14 insertions(+), 75 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 41cfb24c48c1..36533746630e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1457,30 +1457,6 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
-static void mmd_eee_adv_to_linkmode(unsigned long *advertising, u16 eee_adv)
-{
-	linkmode_zero(advertising);
-
-	if (eee_adv & MDIO_EEE_100TX)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				 advertising);
-	if (eee_adv & MDIO_EEE_1000T)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				 advertising);
-	if (eee_adv & MDIO_EEE_10GT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-				 advertising);
-	if (eee_adv & MDIO_EEE_1000KX)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
-				 advertising);
-	if (eee_adv & MDIO_EEE_10GKX4)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
-				 advertising);
-	if (eee_adv & MDIO_EEE_10GKR)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
-				 advertising);
-}
-
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
@@ -1493,62 +1469,25 @@ static void mmd_eee_adv_to_linkmode(unsigned long *advertising, u16 eee_adv)
  */
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 {
+	int ret;
+
 	if (!phydev->drv)
 		return -EIO;
 
-	/* According to 802.3az,the EEE is supported only in full duplex-mode.
-	 */
-	if (phydev->duplex == DUPLEX_FULL) {
-		__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp);
-		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv);
-		int eee_lp, eee_cap, eee_adv;
-		int status;
-		u32 cap;
-
-		/* Read phy status to properly get the right settings */
-		status = phy_read_status(phydev);
-		if (status)
-			return status;
-
-		/* First check if the EEE ability is supported */
-		eee_cap = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
-		if (eee_cap <= 0)
-			goto eee_exit_err;
-
-		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
-		if (!cap)
-			goto eee_exit_err;
-
-		/* Check which link settings negotiated and verify it in
-		 * the EEE advertising registers.
-		 */
-		eee_lp = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
-		if (eee_lp <= 0)
-			goto eee_exit_err;
-
-		eee_adv = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
-		if (eee_adv <= 0)
-			goto eee_exit_err;
-
-		mmd_eee_adv_to_linkmode(adv, eee_adv);
-		mmd_eee_adv_to_linkmode(lp, eee_lp);
-		linkmode_and(common, adv, lp);
-
-		if (!phy_check_valid(phydev->speed, phydev->duplex, common))
-			goto eee_exit_err;
+	ret = genphy_c45_eee_is_active(phydev, NULL, NULL, NULL);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EPROTONOSUPPORT;
 
-		if (clk_stop_enable)
-			/* Configure the PHY to stop receiving xMII
-			 * clock while it is signaling LPI.
-			 */
-			phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
-					 MDIO_PCS_CTRL1_CLKSTOP_EN);
+	if (clk_stop_enable)
+		/* Configure the PHY to stop receiving xMII
+		 * clock while it is signaling LPI.
+		 */
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+				       MDIO_PCS_CTRL1_CLKSTOP_EN);
 
-		return 0; /* EEE supported */
-	}
-eee_exit_err:
-	return -EPROTONOSUPPORT;
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL(phy_init_eee);
 
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
