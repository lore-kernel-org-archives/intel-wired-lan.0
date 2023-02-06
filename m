Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E70C636D3
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Feb 2023 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B43F060B38;
	Mon,  6 Feb 2023 16:30:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B43F060B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675701009;
	bh=f/r016XKxpn8TE2Da3RRpsKqAz9GuwU2O3+QXAKNtvw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=C4oCfGyFhph4cU3b0/+bTGDcVNrlETiRA9FvQ6nWCTkKoL6Ji/DJizy7DvofwU9bN
	 u5xvOw5qbVYd+mq0DMhpcCmyT44AFIDrUvvYsWEm6cLWseCozWH62j9hC+SY/QSHGy
	 eE0UQJrSOGmj5RNPsB0yh2vtjsnqmxIS+Fg4HnMWPhtg0UKr+jQ9TD8SaYhCW1qFzX
	 HU3xFUBpYffdg/RwHeevrZx4aeOAQ4yC9MyJ2lIDPDmIkL0V0xyCrwVLZVB0a/YsxH
	 Wnc//TVTlSrH9VFLI8IIvEGXj3nIwElr1HKi2GAld1GSrs2nrxcWN/mrI9ayLOkK0u
	 PZIk/26sNN0Jw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLF0AG11r7sk; Mon,  6 Feb 2023 16:30:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41A6B60B36;
	Mon,  6 Feb 2023 16:30:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41A6B60B36
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 120FA1BF2A7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDAD740255
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDAD740255
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNrJwGtmCwPB for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Feb 2023 13:51:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DFD740253
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DFD740253
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Feb 2023 13:51:43 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tZ-0007J8-1m; Mon, 06 Feb 2023 14:50:57 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tW-0034eS-P6; Mon, 06 Feb 2023 14:50:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ore@pengutronix.de>)
 id 1pP1tV-00DaQy-Ap; Mon, 06 Feb 2023 14:50:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon,  6 Feb 2023 14:50:47 +0100
Message-Id: <20230206135050.3237952-21-o.rempel@pengutronix.de>
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
Subject: [Intel-wired-lan] [PATCH net-next v5 20/23] tg3: replace EEE
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
 drivers/net/ethernet/broadcom/tg3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 58747292521d..ba1913e88372 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -2339,6 +2339,8 @@ static void tg3_phy_apply_otp(struct tg3 *tp)
 
 static void tg3_eee_pull_config(struct tg3 *tp, struct ethtool_eee *eee)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp) = {};
 	u32 val;
 	struct ethtool_eee *dest = &tp->eee;
 
@@ -2361,13 +2363,16 @@ static void tg3_eee_pull_config(struct tg3 *tp, struct ethtool_eee *eee)
 	/* Pull lp advertised settings */
 	if (tg3_phy_cl45_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE, &val))
 		return;
-	dest->lp_advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(lp, val);
+	ethtool_convert_link_mode_to_legacy_u32(&dest->lp_advertised, lp);
+
 
 	/* Pull advertised and eee_enabled settings */
 	if (tg3_phy_cl45_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV, &val))
 		return;
 	dest->eee_enabled = !!val;
-	dest->advertised = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(adv, val);
+	ethtool_convert_link_mode_to_legacy_u32(&dest->advertised, adv);
 
 	/* Pull tx_lpi_enabled */
 	val = tr32(TG3_CPMU_EEE_MODE);
-- 
2.30.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
