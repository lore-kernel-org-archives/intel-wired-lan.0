Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB55C677F1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Jan 2023 16:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CDCE940BFD;
	Tue, 17 Jan 2023 16:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDCE940BFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673972636;
	bh=ZYlc9V8MK1Yprj49U/T0jiB2bTYDe2ZpGI70I2HRLJU=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=b5fyai7voA34RQEGpPMjpwdPewEtOXRJZJ1l4A6YYeo/ZVwKOcMf23MZgnzEZYqpI
	 jnwla0FIEGP6h9SM+S0a01LnZCdC8wFlLGPaZJvYe0ENulU/UseVDp4kv5cDAyLo1G
	 8umtoemi+4VHmswSaf1HRmpvZ5gPkGTGcFUAXHL4zufcRZ6JJh76bgqp9ZYLijH72H
	 u7IJXe744IsN8/H8zQk5w1yi8S4oBG92FpWAbv/jtm7L8y5MYULn642ccIQ6kYK8lZ
	 pFliw1HUdR99IaaSI4KoSYXtCxpSXhZHWZfX7RWnDKqPOe3sqRAf3+zTv1ySY+HeZr
	 X9NgH+hz5+L7Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Znsi1OIT4zhj; Tue, 17 Jan 2023 16:23:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D237840BFA;
	Tue, 17 Jan 2023 16:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D237840BFA
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 519BB1BF3BC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 23:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D55B60AB0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 23:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D55B60AB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wukqSlsnpvbM for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Jan 2023 23:58:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6240060A99
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6240060A99
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Jan 2023 23:58:46 +0000 (UTC)
Received: from mwalle01.sab.local (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id D8A0816EA;
 Tue, 17 Jan 2023 00:52:47 +0100 (CET)
From: Michael Walle <michael@walle.cc>
Date: Tue, 17 Jan 2023 00:52:21 +0100
MIME-Version: 1.0
Message-Id: <20230116-net-next-c45-seperation-part-3-v1-6-0c53afa56aad@walle.cc>
References: <20230116-net-next-c45-seperation-part-3-v1-0-0c53afa56aad@walle.cc>
In-Reply-To: <20230116-net-next-c45-seperation-part-3-v1-0-0c53afa56aad@walle.cc>
To: Sean Wang <sean.wang@mediatek.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Byungho An <bh74.an@samsung.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>
X-Mailer: b4 0.11.1
X-Mailman-Approved-At: Tue, 17 Jan 2023 16:23:09 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=walle.cc; s=mail2022082101; t=1673913168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmJ+9CmwjBTs3CG9j8tedbOIS1gGBtjDkwnDw2VO6LM=;
 b=eItgcFr83H0p1PU0iNChDNdiOgj8KhYJ8woVXKsLke+s9Qzn4YWii5eReEsBuleyYQt6qF
 zdB3j5sZRNRt7IYX77xPINY9PI563Domlhi3UUM6iYnR/7cJNfvw2qJ9K/pFln4/WldMhR
 KLEda5zh67qih83Ir652RtZkToIDVhs+vwYaXJQkzFrYdR4NRzGcjoj7o0P9BTVYD+HGzh
 e91HRJCCAaJRUCf8LXpvVLVkoVWluGPxBaeiv+On9tzW4vLvj/LrS/kvi4VC8xZIjuV/fH
 dq6rAn7Pjrjnz7XuZr3iXlIGBZFY2xdOTT7geNfbJloqNBU6E5xeHvWycz+NAw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc
 header.a=rsa-sha256 header.s=mail2022082101 header.b=eItgcFr8
Subject: [Intel-wired-lan] [PATCH net-next 06/12] ixgbe: Use C45 mdiobus
 accessors
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
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Michael Walle <michael@walle.cc>, intel-wired-lan@lists.osuosl.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Andrew Lunn <andrew@lunn.ch>

When performing a C45 bus transaction, make use of the c45 variants of
the bus read/write helpers. The ability to pass a special register
value is being removed to clean up the mdio bus driver API.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ab8370c413f3..59f9d82ce532 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8937,7 +8937,8 @@ ixgbe_mdio_read(struct net_device *netdev, int prtad, int devad, u16 addr)
 		int regnum = addr;
 
 		if (devad != MDIO_DEVAD_NONE)
-			regnum |= (devad << 16) | MII_ADDR_C45;
+			return mdiobus_c45_read(adapter->mii_bus, prtad,
+						devad, regnum);
 
 		return mdiobus_read(adapter->mii_bus, prtad, regnum);
 	}
@@ -8960,7 +8961,8 @@ static int ixgbe_mdio_write(struct net_device *netdev, int prtad, int devad,
 		int regnum = addr;
 
 		if (devad != MDIO_DEVAD_NONE)
-			regnum |= (devad << 16) | MII_ADDR_C45;
+			return mdiobus_c45_write(adapter->mii_bus, prtad, devad,
+						 regnum, value);
 
 		return mdiobus_write(adapter->mii_bus, prtad, regnum, value);
 	}

-- 
2.30.2
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
