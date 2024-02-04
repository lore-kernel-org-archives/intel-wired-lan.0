Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F66C4828F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Feb 2024 23:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A596E4070B;
	Sun,  4 Feb 2024 23:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A596E4070B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707090050;
	bh=sauFk9hjjr6pfRUCRoWd8WYck0QUyoBECM2fduhdkgE=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Rq5AatzmWxbu00iX6myy5aGAQMsNWWv0N5HmtxlIEDsKeE9FJ5okU/HVgI2nO1AvA
	 bSu/k2KvV9HGbBchbGlXIGnDxMHgj8zOLmwhl0xwS9ZWaqtIjTNxKrVKeJhXwfj06B
	 ksn+bHZ0vqUJCJP1fmPUZLZYSy1lye7us1mLJsRyXvu/kx70cmv4EtsvJToHZQiV5R
	 6afww9wE1S+gqi0CqKwIxwMMFkbTab/mCys9gDNw3he8gjVs5AhqRzYToR17nli3ys
	 LxjJIFcSwDC5sX/v20drBuecpank/2r133Yxl6dlG/LaZ+o3YRwF4tHqh82FfRA+kR
	 H7WQ9okFA5SMg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ilTLKWYhl_F4; Sun,  4 Feb 2024 23:40:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C149A405F5;
	Sun,  4 Feb 2024 23:40:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C149A405F5
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5DE0F1BF376
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 366E2415D9
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 366E2415D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLnc-tanumWl for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Feb 2024 23:40:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 614E9415D7
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 614E9415D7
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110]
 helo=thinkpad.home.lunn.ch) by vps0.lunn.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rWm6G-006z7T-I3; Mon, 05 Feb 2024 00:40:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-2-fb6e08329d9a@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Cpjch1b1D9Jp2vWORWgwbDnErRScd5QZqvv0qT6yMzg=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBoJEjpNMDvkqadpv9yFL1h1A7Hf4gta7ioS
 jqRDownKJiJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaAAKCRDmvw3LpmlM
 hAw+D/9nrVrHGFvrGdpbtwShUj8PZP0T7RCUAoJ6QYG56CQ2SmAP71TvYlHb3DASw4BWmQoA0V2
 LsthsrcZyDqnp2ub/TjkQkwTjmKjxR1ZpUQHcr5aQelUaEcbHtksNSRwweFkYxOjWISV0bTM7F7
 B5ByV1VebraSgmTmbm/y3kbnA0c4EY9mAErdGDB2F5Ff3tl4BsaHZ4cH/xyUb/IbmhR0OZF5mvt
 rmdtp0jgqkHle3Fv2O0uXvvuxxKo+pBVBmBYYrunWf+G3ClU0LysWaCp2rHvIRxKdbInGLOZBiz
 rg3Vj8d+g3YMwMuimq53fdNdocRi0UzP4TLtKXsXSngKhWtO7avR8GoG8Cu41LlDnl2RFx6vsG9
 1iyr1AY7pLkjImh4Izm5aHjoE1gKvpOgBo3CIptG9nyRr0i+Xmsxszdz+Y9mEZcyEjKyQ0ccAe1
 3K+LVEE6TwS1c60DA58q+sgf0ftr8J5X7fN/G6Z+lELW3hUERaMTNbpfQ2quSRFTLiaByJ4UB8o
 CGuvyV7q1rY8/Pn5dSq06oTZqUDYYhq4au3FsKynxlS2kFiteSasMDqZKGS81DLvAY65Gh+7pPt
 jTXBfGreO1lv6eYVwBxPBb3dBgzKphFugUDCOatb29/E/KbGH/qhHYGvflDBxQz5Y6r+vQ48jez
 lFnQVxEVru1w4Xg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
 In-Reply-To:References; bh=sauFk9hjjr6pfRUCRoWd8WYck0QUyoBECM2fduhdkgE=; b=AC
 yqW11GQSsth0jqiJMmkoQvKInfmu5V9qNxon//vnegtjVdxg3I1jNSddotbXYx8zhCVbVqc+JqFGt
 WfpdQ9j1B3nCR98SlcK3JhrdtTPgfx2yadhAzlvhvrgFXw714lqDTDUNNqjsqrftdtA6KaZK59iDs
 1T1x5udWmwS0Sz4=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=ACyqW11G
Subject: [Intel-wired-lan] [PATCH 2/8] net: usb: ax88179_178a: Use linkmode
 helpers for EEE
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
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_178a.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index d6168eaa286f..d4bf9865d87b 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -676,21 +676,21 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 					    MDIO_MMD_PCS);
 	if (val < 0)
 		return val;
-	data->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(data->supported, val);
 
 	/* Get advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
 
 	/* Get LP advertisement EEE */
 	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
 					    MDIO_MMD_AN);
 	if (val < 0)
 		return val;
-	data->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
 
 	return 0;
 }
@@ -698,7 +698,7 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 static int
 ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
-	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised_u32);
+	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
 
 	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
 					      MDIO_MMD_AN, tmp16);
@@ -1663,7 +1663,6 @@ static int ax88179_reset(struct usbnet *dev)
 	ax88179_disable_eee(dev);
 
 	ax88179_ethtool_get_eee(dev, &eee_data);
-	eee_data.advertised_u32 = 0;
 	ax88179_ethtool_set_eee(dev, &eee_data);
 
 	/* Restart autoneg */

-- 
2.43.0

