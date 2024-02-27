Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DD3C48BF6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Feb 2024 01:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 448F140108;
	Tue, 27 Feb 2024 01:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eYhJDMZ5xll; Tue, 27 Feb 2024 01:30:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83074401BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708997404;
	bh=VMAhDZ6j7g9miYPaWDxliHXLiq67TTyMdEfJfE6S4XM=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xky/Guq2d0QkmpI6JPpDFik32g9SgqLj9TqKxyVMphINRg5UVeLg+WlNwkxRC209H
	 zVXAYXmRuUxViOj3hYQDSLhGETYowpEikflMGQ1wDaoAFzolyssNSUdFkYJtmt/7hE
	 dcljqKS5v18CrgkaRedKNpX9Zd5TKtjo0THMBE2GZyXIXvhidNtAUUxE7FRbdzEMzd
	 k9lKqcBBT81QDx7dxj9Yexl7UbS4EE+emN2yZ0Z6qZ9e/TPHO79lTal6xePZCYTyqD
	 VqHT/xl4nb9tVI7GmEHf9VcLqQx8l45Qprt5UJ94GcZdvP08FO9nLhDJ8yzrV+8W3q
	 2ufh3ZkItIU1A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83074401BD;
	Tue, 27 Feb 2024 01:30:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3A5511BF318
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Feb 2024 01:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33195401F6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Feb 2024 01:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajmXrkweWvN0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Feb 2024 01:30:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F2DCC40017
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2DCC40017
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2DCC40017
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Feb 2024 01:30:00 +0000 (UTC)
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110]
 helo=thinkpad.home.lunn.ch) by vps0.lunn.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1remIP-008mef-Gb; Tue, 27 Feb 2024 02:30:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 26 Feb 2024 19:29:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-keee-u32-cleanup-v5-7-9e7323c41c38@lunn.ch>
References: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
In-Reply-To: <20240226-keee-u32-cleanup-v5-0-9e7323c41c38@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4144; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=IRhXR5z1n16Mavr53VIIs+mDSvzV25uDJ9u/3/XGV6A=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl3Tr4RLJWGoD9bdYDGtoVCUU3me+Qgj/1kvN92
 UIoGUeYJRuJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZd06+AAKCRDmvw3LpmlM
 hJCSEACnODCL0C97yLuf7DQbQfuu1TaH3WGtgEGtCZ7+9ti9npEK5JBt+BCoetM+PqL2mgIl1tZ
 sBFbkz8Wj+2HKvwiOdcifZn/YZ6eZL0agVDPQMsUM3XJ3Au3BL8lrn9tBPTQWM9US533zrVw7Hd
 hBV+Np7fD+OQ5EizfzzWymUYR/QHcMxWLJHMdjo/uKmN8Gi7k+oDGxHJA8xingLQl7I+VS56Xby
 EOoOOwFPFZXS/pRt02i1iKK3g4fIghGTJfH9/gXA71C1fhoMqXTzEQh0RxFIvECrlqRMNUt9693
 t2KPwcK90kmvhnC16RYKlsakHB/FU6gtN7J/A3/SGP2Mk75edJrJ9UXZxzzVW2E/FG+QhN8t8LS
 jbcFPYcRLtm50jYHYKkunJhMKsx64XjkdPcKskFYWd6F/cYmtF+y/eujBwh0EZbwpzi47Db1CES
 v0BxvikkyaczXFzULB8jrwDTUDYcfcpPZquWfTJT19Z7Wzlm2nu60CmuF3JlAPhl3sMJ/a3o9Is
 79VRxMJFb+ESoRV94lE0uGCTqSZUyAnP2fDZwe37JqAwXcVhwQvg6sJh2mnAV/26k+47MROTmk0
 V+VrxKn+gfDvqIIXmLrdzfWZoGi3fx3ubn4JlYoXeLzuiNHoS6jENMh39/qQR3uXofXXLhAFuJn
 f6fbSqLJiKjeMBw==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
 In-Reply-To:References; bh=VMAhDZ6j7g9miYPaWDxliHXLiq67TTyMdEfJfE6S4XM=; b=xN
 nm/+CKyNmo/q3ISvcn+r4O/QQnNTFWKGznnRdJVS+aZQE+W8jeOWdvGPYpyTgnbo3Avee6x7LuKA3
 jYUShBH+W9n/so5wLaJIzl5KAE+d0yt1FP6juziqwMzhopIYiXYKNNa5SFk1pIPuIZN4AjhfAG23W
 NTih1k1q6dJJlYc=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lunn.ch
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=xNnm/+CK
Subject: [Intel-wired-lan] [PATCH net-next v5 7/9] net: intel: igb: Use
 linkmode helpers for EEE
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
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Make use of the existing linkmode helpers for converting PHY EEE
register values into links modes, now that ethtool_keee uses link
modes, rather than u32 values.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 35 ++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index b87b23d2151c..99977a22b843 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3038,11 +3038,13 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 	    (hw->phy.media_type != e1000_media_type_copper))
 		return -EOPNOTSUPP;
 
-	edata->supported_u32 = (SUPPORTED_1000baseT_Full |
-				SUPPORTED_100baseT_Full);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 edata->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 edata->supported);
 	if (!hw->dev_spec._82575.eee_disable)
-		edata->advertised_u32 =
-			mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
+		mii_eee_cap1_mod_linkmode_t(edata->advertised,
+					    adapter->eee_advert);
 
 	/* The IPCNFG and EEER registers are not supported on I354. */
 	if (hw->mac.type == e1000_i354) {
@@ -3068,7 +3070,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		if (ret_val)
 			return -ENODATA;
 
-		edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+		mii_eee_cap1_mod_linkmode_t(edata->lp_advertised, phy_data);
 		break;
 	case e1000_i354:
 	case e1000_i210:
@@ -3079,7 +3081,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		if (ret_val)
 			return -ENODATA;
 
-		edata->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(phy_data);
+		mii_eee_cap1_mod_linkmode_t(edata->lp_advertised, phy_data);
 
 		break;
 	default:
@@ -3099,7 +3101,7 @@ static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		edata->eee_enabled = false;
 		edata->eee_active = false;
 		edata->tx_lpi_enabled = false;
-		edata->advertised_u32 &= ~edata->advertised_u32;
+		linkmode_zero(edata->advertised);
 	}
 
 	return 0;
@@ -3109,6 +3111,8 @@ static int igb_set_eee(struct net_device *netdev,
 		       struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {};
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp) = {};
 	struct e1000_hw *hw = &adapter->hw;
 	struct ethtool_keee eee_curr;
 	bool adv1g_eee = true, adv100m_eee = true;
@@ -3138,14 +3142,21 @@ static int igb_set_eee(struct net_device *netdev,
 			return -EINVAL;
 		}
 
-		if (!edata->advertised_u32 || (edata->advertised_u32 &
-		    ~(ADVERTISE_100_FULL | ADVERTISE_1000_FULL))) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 supported);
+		if (linkmode_andnot(tmp, edata->advertised, supported)) {
 			dev_err(&adapter->pdev->dev,
 				"EEE Advertisement supports only 100Tx and/or 100T full duplex\n");
 			return -EINVAL;
 		}
-		adv100m_eee = !!(edata->advertised_u32 & ADVERTISE_100_FULL);
-		adv1g_eee = !!(edata->advertised_u32 & ADVERTISE_1000_FULL);
+		adv100m_eee = linkmode_test_bit(
+			ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			edata->advertised);
+		adv1g_eee = linkmode_test_bit(
+			ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			edata->advertised);
 
 	} else if (!edata->eee_enabled) {
 		dev_err(&adapter->pdev->dev,
@@ -3153,7 +3164,7 @@ static int igb_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised_u32);
+	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
 	if (hw->dev_spec._82575.eee_disable != !edata->eee_enabled) {
 		hw->dev_spec._82575.eee_disable = !edata->eee_enabled;
 		adapter->flags |= IGB_FLAG_EEE;

-- 
2.43.0

