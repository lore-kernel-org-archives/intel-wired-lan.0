Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D3DC38142
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Feb 2023 16:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C64378134F;
	Wed,  1 Feb 2023 16:26:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C64378134F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675268773;
	bh=c1COm9BT0p2O5E0UVQ5XBthe6ibleemY6UNyyLAaJmQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JORnQrdWk0fDRGZ81KZLa0sX9kM7Yt1Ctny1OXHSn9eZvlnkrateYsUMN6BLi342p
	 a2i+8pb1Ku0ZmsIEKzHrw/ou49QGuvwU6360vd4VvRN0uTXUIRGQQRFJ7Gp8cYlhaC
	 pF/vNFh7+eEIEA/VPnRy3jkFCNPhrlv3DBxYCYYaJ4MgiM7BMCmSsDm7AY3+OtXYIm
	 p84crdC6aNCQ2LK1rJ0+XgohzFER87pJB3qHJq2hz8uCy99Tk3hmfavjRqsi9KOb/L
	 V1/XgCODoVEP/pV/k/WlPfQkyqd0F/T4V1zl02FFa12zqDBOZYeXR/blrel3tTW93Q
	 fOIpTSR3bZBEw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id est8RWJ9MgNp; Wed,  1 Feb 2023 16:26:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B623981371;
	Wed,  1 Feb 2023 16:26:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B623981371
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BB6191BF388
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 15:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A227941968
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 15:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A227941968
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UEJQHOmXiEHc for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Feb 2023 15:17:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2CB64194A
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2CB64194A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 15:17:12 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pNEZY-0002rr-KZ; Wed, 01 Feb 2023 15:58:52 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pNEZY-001w28-K2; Wed, 01 Feb 2023 15:58:51 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pNEZT-009hXb-Jm; Wed, 01 Feb 2023 15:58:47 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed,  1 Feb 2023 15:58:43 +0100
Message-Id: <20230201145845.2312060-22-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201145845.2312060-1-o.rempel@pengutronix.de>
References: <20230201145845.2312060-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: intel-wired-lan@lists.osuosl.org
X-Mailman-Approved-At: Wed, 01 Feb 2023 16:25:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 21/23] r8152: replace EEE
 ethtool helpers to linkmode variants
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
 drivers/net/usb/r8152.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index decb5ba56a25..dbfde0aec003 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8745,17 +8745,23 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 static int r8152_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
 {
-	u32 lp, adv, supported = 0;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_able) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_adv) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_lp) = {};
+	u32 lp, adv, supported;
 	u16 val;
 
 	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
-	supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_100_10000_adv_mod_linkmode_t(lm_able, val);
+	ethtool_convert_link_mode_to_legacy_u32(&supported, lm_able);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
-	adv = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_100_10000_adv_mod_linkmode_t(lm_adv, val);
+	ethtool_convert_link_mode_to_legacy_u32(&adv, lm_adv);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
-	lp = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_100_10000_adv_mod_linkmode_t(lm_lp, val);
+	ethtool_convert_link_mode_to_legacy_u32(&lp, lm_lp);
 
 	eee->eee_enabled = tp->eee_en;
 	eee->eee_active = !!(supported & adv & lp);
@@ -8768,7 +8774,11 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
 
 static int r8152_set_eee(struct r8152 *tp, struct ethtool_eee *eee)
 {
-	u16 val = ethtool_adv_to_mmd_eee_adv_t(eee->advertised);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
+	u16 val;
+
+	adv[0] = eee->advertised;
+	val = linkmode_adv_to_mii_eee_100_10000_adv_t(adv);
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
@@ -8780,17 +8790,23 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_eee *eee)
 
 static int r8153_get_eee(struct r8152 *tp, struct ethtool_eee *eee)
 {
-	u32 lp, adv, supported = 0;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_able) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_adv) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lm_lp) = {};
+	u32 lp, adv, supported;
 	u16 val;
 
 	val = ocp_reg_read(tp, OCP_EEE_ABLE);
-	supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_100_10000_adv_mod_linkmode_t(lm_able, val);
+	ethtool_convert_link_mode_to_legacy_u32(&supported, lm_able);
 
 	val = ocp_reg_read(tp, OCP_EEE_ADV);
-	adv = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_100_10000_adv_mod_linkmode_t(lm_adv, val);
+	ethtool_convert_link_mode_to_legacy_u32(&adv, lm_adv);
 
 	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
-	lp = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_100_10000_adv_mod_linkmode_t(lm_lp, val);
+	ethtool_convert_link_mode_to_legacy_u32(&lp, lm_lp);
 
 	eee->eee_enabled = tp->eee_en;
 	eee->eee_active = !!(supported & adv & lp);
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
