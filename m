Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78248C636D3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 16:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30DD6404B1;
	Mon,  6 Feb 2023 16:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30DD6404B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675700959;
	bh=fVGLCH26/f4PVxR5E1tuiyUakt9ySNUQiNBoFu60PTo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JtRjRb/N8ITsJe0kfJggSvJguHqez6YUFjCFlSVtsmy2lcaVAmeF7kANfkNEP6wBn
	 eM/Hu8n068f4eh+3QyJQ5JmKrolgKQc7olfzDj1GYNofFGH+7VLylr4Imn+zA17avI
	 ibFeTEdagme77PCv8ASSwW787JBz24rbMGH1T3jHedItoy3CgKVE2bJr+ADMUko80h
	 i2AP+sFj0m+O0VE1gi5sy2tk52dd1ITcAcZj30IQJz04i7r9RDRQ+n9CX30L1WVF5C
	 JVSVpNiPAuGJNYzYiRj/hDQbCPOd1RfepUM0p3fmcSX97qopTFf5ou11g8zyxOe/NU
	 kA+VioiZJjOQA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdPXLy9dHfb5; Mon,  6 Feb 2023 16:29:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C21AB40499;
	Mon,  6 Feb 2023 16:29:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C21AB40499
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D30D91BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADDEF40360
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADDEF40360
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id casdyQid4Ie7 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 13:51:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6CDD4021C
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6CDD4021C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:32 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tX-0007Fo-UC; Mon, 06 Feb 2023 14:50:55 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tV-0034dm-L6; Mon, 06 Feb 2023 14:50:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tV-00DaRJ-GV; Mon, 06 Feb 2023 14:50:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon,  6 Feb 2023 14:50:49 +0100
Message-Id: <20230206135050.3237952-23-o.rempel@pengutronix.de>
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
Subject: [Intel-wired-lan] [PATCH net-next v5 22/23] net: usb: ax88179_178a:
 replace EEE ethtool helpers to linkmode variants
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

Replace EEE ethtool helpers with linkmode variants. This will
reduce similar code snippets and prepare ethtool EEE interface to linkmode
migration.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/ax88179_178a.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index aff39bf3161d..77cc795ef6ee 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -652,6 +652,9 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_eee *data)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_able) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_adv) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_lp) = {};
 	int val;
 
 	/* Get Supported EEE */
@@ -659,21 +662,24 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_eee *data)
 					    MDIO_MMD_PCS);
 	if (val < 0)
 		return val;
-	data->supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(lm_able, val);
+	ethtool_convert_link_mode_to_legacy_u32(&data->supported, lm_able);
 
 	/* Get advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(lm_adv, val);
+	ethtool_convert_link_mode_to_legacy_u32(&data->advertised, lm_adv);
 
 	/* Get LP advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(lm_lp, val);
+	ethtool_convert_link_mode_to_legacy_u32(&data->lp_advertised, lm_lp);
 
 	return 0;
 }
@@ -681,7 +687,11 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_eee *data)
 static int
 ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_eee *data)
 {
-	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
+	u16 tmp16;
+
+	adv[0] = data->advertised;
+	tmp16 = linkmode_to_mii_eee_cap1_t(adv);
 
 	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					      MDIO_MMD_AN, tmp16);
@@ -706,7 +716,7 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			return false;
 		}
 
-		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
+		cap = eee_cap & (MDIO_EEE_100TX | MDIO_EEE_1000T);
 		if (!cap) {
 			priv->eee_active = 0;
 			return false;
@@ -729,8 +739,8 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			return false;
 		}
 
-		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
-		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
+		adv = eee_adv & (MDIO_EEE_100TX | MDIO_EEE_1000T);
+		lp = eee_lp & (MDIO_EEE_100TX | MDIO_EEE_1000T);
 		supported = (ecmd.speed == SPEED_1000) ?
 			     SUPPORTED_1000baseT_Full :
 			     SUPPORTED_100baseT_Full;
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
