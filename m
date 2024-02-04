Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E33C4828F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Feb 2024 23:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D37E2402F2;
	Sun,  4 Feb 2024 23:40:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D37E2402F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707090045;
	bh=cy2kGO2U2TPr1pnz3CApIMBYaE8Xib0u+l8VUL1Ic70=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lzuE6NIk3uzmkq4QfypEUtkupF0ylmRo19FWzrS1QHzNJbQlQRxbEgJlq7VU9//xV
	 GXH8b3ZXjOmnGOVok8eDXVnKBP8AXujQoqq0OI1exbowvovdBeJKARUXSXRLk2lmGR
	 z63xJHnMu1kcPS3Nl51OlWu7HtOp7TYwkgEZkTCIzCLlamipB1xiVAacWMRG8zd5lh
	 jqDOs1qUB7bOjiSDQuXMEzjB4FmCxUGXOsBT8AZ/9uriLKyV85B/CmZQsmAuwKnt/w
	 zMUbQScLbKBNnehhpK9xJET7m2RjsAdUG3kZ4E9+T1JmJU5ZEkTVHNbABFYiR/7LGg
	 JGFcp3+j2oNhw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0oFxE0yyVphz; Sun,  4 Feb 2024 23:40:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 545764062A;
	Sun,  4 Feb 2024 23:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 545764062A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 28A6E1BF376
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA1B7607AA
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA1B7607AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hl-UDH3ezQ3l for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Feb 2024 23:40:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B90FF607A1
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B90FF607A1
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110]
 helo=thinkpad.home.lunn.ch) by vps0.lunn.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rWm6D-006z7T-9A; Mon, 05 Feb 2024 00:40:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-1-fb6e08329d9a@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=F0mfdZrj/FgaIdcQuHDCEsazFz0S4bAcsGtKqN8CFVA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBosEVBhWdcRq7v/M/7QBQSJoRWKWr+VUNRF
 Juz9Z/insWJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgaAAKCRDmvw3LpmlM
 hHZOEADJyfCKM2B0x5eZEcjZDvkTSuCKtiAJAQ+VLAMB3eh58XyLnRuar4cYyBUONQF3h6EANYL
 UfbKHe/bd/m++33qitFc7ibDUatYE4qOrIVC6PG0OLaPlePJ6+GrzePmoIMLuv8jlpsoPRJvFKI
 Zqci5bkDmYgZDjDuAVQqQ8PmbI+uBSeMFhBM4f/C4PsGJRDYKkdBazp8bxPm0S41qHf1r13DbOB
 sITU2gPfS7j7de5THdg/HnxrdYY4SUz4LMYdldMdimlrs9rd8nXT4q+paIPH0T+AtLMqp0bg4rx
 qgc4k5TOqPwwf09kBd83hK8JwNTuMSIenx3vbWCsmaHz01HFwz2EHgs5+PWvw6ovBfVJHrKnOht
 lI3Aq9AdU23qeU0phrPTUXO9twZtjEtLfWfDW5KGRzkMW127mxKxSJNne5zYndHaqMl4FRGMqcQ
 wQgNcqtxOl0BO2pwrLfNLr3MlRLL5p9osXA7hnOluT/v9+XYgvAeV3C01avNpDfrJZ6iRPqFilk
 5LkRzFyvfP9byOUaPfEtr0hnPIIGGrarbubkxV4GF/yIBYRaTyFabpXGaYVHuh0wy2dAL0xKXBK
 Kbkw3nohgK2+f1MiZaftQTHaKOO7svZgMto9C6kaJt6ymWVY5Ujl6CnFIGM+/QcvuIqQmR3+ZBR
 mJSkbswk+bBI8rw==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
 In-Reply-To:References; bh=cy2kGO2U2TPr1pnz3CApIMBYaE8Xib0u+l8VUL1Ic70=; b=39
 8yUCJrdNtIZSuZwtLEHMPm2jkANYun+1ozzN1FQ8M6NtnyQVuwMsTNfT63FF+T/139WJJOjhowhLM
 RT5ZRslw0wFQmL1z5O3KvZsTSuGfjySd9Bf6iVrPcBgBLw66uZgna9S9Xz+ZcF/KK+qQ6srMRynsw
 XUPle5n8SGRtKzo=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=398yUCJr
Subject: [Intel-wired-lan] [PATCH 1/8] net: usb: r8152: Use linkmode helpers
 for EEE
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

Rework determining if EEE is active to make is similar as to how
phylib decides, and make use of a phylib helper to validate if EEE is
valid in for the current link mode. This then requires that PHYLIB is
selected.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/Kconfig |  1 +
 drivers/net/usb/r8152.c | 31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 3fd7dccf0f9c..3c360d4f0635 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -99,6 +99,7 @@ config USB_RTL8150
 config USB_RTL8152
 	tristate "Realtek RTL8152/RTL8153 Based USB Ethernet Adapters"
 	select MII
+	select PHYLIB
 	select CRC32
 	select CRYPTO
 	select CRYPTO_HASH
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3d806b3ff425..fa5e9b7f3bb4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/phy.h>
 #include <linux/usb.h>
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
@@ -8924,23 +8925,22 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	u32 lp, adv, supported = 0;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u16 val;
 
 	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
-	supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
-	adv = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->advertised, val);
 
 	val = r8152_mmd_read(tp, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
-	lp = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
 	eee->eee_enabled = tp->eee_en;
-	eee->eee_active = !!(supported & adv & lp);
-	eee->supported_u32 = supported;
-	eee->advertised_u32 = tp->eee_adv;
-	eee->lp_advertised_u32 = lp;
+
+	linkmode_and(common, eee->advertised, eee->lp_advertised);
+	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
 
 	return 0;
 }
@@ -8959,23 +8959,22 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 {
-	u32 lp, adv, supported = 0;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
 	u16 val;
 
 	val = ocp_reg_read(tp, OCP_EEE_ABLE);
-	supported = mmd_eee_cap_to_ethtool_sup_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->supported, val);
 
 	val = ocp_reg_read(tp, OCP_EEE_ADV);
-	adv = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->advertised, val);
 
 	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
-	lp = mmd_eee_adv_to_ethtool_adv_t(val);
+	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
 
 	eee->eee_enabled = tp->eee_en;
-	eee->eee_active = !!(supported & adv & lp);
-	eee->supported_u32 = supported;
-	eee->advertised_u32 = tp->eee_adv;
-	eee->lp_advertised_u32 = lp;
+
+	linkmode_and(common, eee->advertised, eee->lp_advertised);
+	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
 
 	return 0;
 }

-- 
2.43.0

