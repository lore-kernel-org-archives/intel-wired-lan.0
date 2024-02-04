Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F4C4828F
	for <intel-wired-lan@archiver.kernel.org>; Sun,  4 Feb 2024 23:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D98BD4064E;
	Sun,  4 Feb 2024 23:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D98BD4064E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707090079;
	bh=qhzUzBBE/ag86Iuv8pKOl72IzBpodGhMjRQDM/+8K5Y=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=A54esG7dDMqWqzhcnq+tcJm4jfHg+i01BPF31hUyvaFsni7s9KqnsWlj/XPKTQN2V
	 fqYl12vTe/4wJHaZkNqf08byjpOIG230sTPYcWl6Ej6S79G/nOU158ZZEEXdhIZli9
	 AHl30SiNvTOUm/hojl0lc3nzzeoV6IVSKqSB6wIX3jTaqAW/mwUAyFyLdhiCFIotmI
	 quoh5MuO/N39shkzKJBxRVMg504QG7kFkTtly7Js/kN53UuAxlb0w3/+DH5k0G6+sx
	 JPwwp2QoRZqR3dRXElcXayC9CsfppPbZDrdLEIwDhgu6Vk0YmTaTAL/yrf7RJshIwT
	 a13vSpKY61DwA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcuNXeoT9SIX; Sun,  4 Feb 2024 23:41:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A4DF408AD;
	Sun,  4 Feb 2024 23:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A4DF408AD
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 276C81BF376
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D30E415D9
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D30E415D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HNCIQgp0xaNt for <intel-wired-lan@lists.osuosl.org>;
 Sun,  4 Feb 2024 23:40:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5792C415D7
 for <intel-wired-lan@lists.osuosl.org>; Sun,  4 Feb 2024 23:40:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5792C415D7
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110]
 helo=thinkpad.home.lunn.ch) by vps0.lunn.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1rWm6a-006z7T-7L; Mon, 05 Feb 2024 00:40:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:40:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-keee-u32-cleanup-v1-8-fb6e08329d9a@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=GY/i358jYl4X2zeywHliUg8zbjHunLh0+ZONAyCsEDA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwCBqchq37ZWAaCXguBx3KZrCunBRHw7lO6YQI
 BGeHWL/fxmJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAgagAKCRDmvw3LpmlM
 hP3+EACmrlqVvQVpi8hIGv7u5kcwmZhDfq2v8zuE8ahroCH+WVKmtXgT7ujGkPXLj5rrHSNQ/Tb
 oc2Gm0y9F67PRPsKstTJE6dA+6MbKjAt6WBUiVEQq/FKf5rRumNLyD1zJa3qQqPckX1QCdLS53R
 jS5ub1Kl29ZaY1uVJSM6maQ6TLbJDCO0fihwjnPzrQjM8yeRdCakWGGi1zOSmwqqSk53LiIk9/+
 szNw6xdTqY5leQVYyCoc+iLPDMCqeO7nMnUzXwzeaPRv9y0EU676Gc06lOKBP2X4xDU6xHZqTcu
 SKzpM9We/Bgd2sKHPUEiuywZv+OOeKktgaTksyQxG6Q+TXfLXdYAFx0INrkOb1duE9nY5nGZdPG
 6/zXaCs2uwEHbGyEowgLAGCli6RLOMmMALU02Ti+Xc7GCXB9RuyiPhe1BMZijpEvi4rDKgTSifB
 sLkyNIgCwf31Xm/KGlZ/aGdKMS8l0Bnn+ZViQhpfHkWyjtSEEfY+Gu6845mPQt7/FXT4hRo3E0B
 TL1SUMeyGbGcb4j/OtcSgf3p6Kq1gMJgCaePXLGV5Nd3idrfpE9+LNZVPa0PSq6HvHm4hLnNhMP
 zZaFrKD+qEymoaFGnDIrjnkeoHcqtpFNI+rza8BkAxh6WVJLybo4W4ECsNFYch9pa5P7XNJOUpc
 hk4xXG7KVvmucew==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
 In-Reply-To:References; bh=qhzUzBBE/ag86Iuv8pKOl72IzBpodGhMjRQDM/+8K5Y=; b=a1
 1NRg3H7ioa/uQU6pi/ZYzRyp/9SW1iXD8TQh21Su2H/FGxpmTEIhW/G1CHiBRuLFnRY5iuX1nar71
 Vp/lgjZHmQODZsHCwzFL6WN98kX9yVukadk/EWHaVtIb4yyrDBPkzfpz6q9sX59x1yZZD0w8IihVb
 xM4YFFx/kjoZQLA=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=a11NRg3H
Subject: [Intel-wired-lan] [PATCH 8/8] net: intel: igc: Use linkmode helpers
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

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index e9aed4069ebe..e9d78bcb0201 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1630,8 +1630,8 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 	u32 eeer;
 
 	if (hw->dev_spec._base.eee_enable)
-		edata->advertised_u32 =
-			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
+		mii_eee_cap1_mod_linkmode_t(edata->advertised,
+					    adapter->eee_advert);
 
 	*edata = adapter->eee;
 
@@ -1653,7 +1653,7 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 		edata->eee_enabled = false;
 		edata->eee_active = false;
 		edata->tx_lpi_enabled = false;
-		edata->advertised_u32 &= ~edata->advertised_u32;
+		linkmode_zero(edata->advertised);
 	}
 
 	return 0;
@@ -1695,7 +1695,8 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
+	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
+
 	if (hw->dev_spec._base.eee_enable != edata->eee_enabled) {
 		hw->dev_spec._base.eee_enable = edata->eee_enabled;
 		adapter->flags |= IGC_FLAG_EEE;

-- 
2.43.0

