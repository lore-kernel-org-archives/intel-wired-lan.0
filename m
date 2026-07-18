Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27431C44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 15:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEA8F606F6;
	Mon, 20 Jul 2026 15:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DdFGQG8QBnVJ; Mon, 20 Jul 2026 15:21:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FCD360702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784560917;
	bh=CsnJtqNCcYIxOQeyroi0AxeK7dRAVN05DqE4BmgloCA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QqFNzxzM4MMZyA+MG5v42wYDP/FY/RozPl/cHUVkQkCdzHQVuMoxEp+WjUachCiC3
	 MBHCrvnrH7bX0cc2BtiSt1eoCqNhOXurJocRKBYbzdJhAqLYC+Th4HS61ACNZovp0p
	 ti48Q7GcrcDob5c/aP4x74uJXxkdq6g1wtLSBI18HmtfEowfTWWUXOGJNfV5MJtiPm
	 mAXCNoH1NYoeM6zHycPHZi3HCW7RL/1wsocHj+vqvSshsowhPnYjER0Y0lo9AFm9qq
	 EfvXLrZZpFyklubyGLmReBo27XnJxyLJtVFtidpHqf85J4Aq4mr4mNvzT669nwftlx
	 8jIvVysqjT9yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FCD360702;
	Mon, 20 Jul 2026 15:21:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 482BB1F6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 16:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39E4840675
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 16:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZxDPeM2ca80c for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Jul 2026 16:57:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=paweldembicki@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 265F14066D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 265F14066D
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 265F14066D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 16:57:19 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698bf7a1a2dso12258953a12.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 09:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784393838; x=1784998638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CsnJtqNCcYIxOQeyroi0AxeK7dRAVN05DqE4BmgloCA=;
 b=KKuv6MlQ8uerCQYce0onzv6dk7A9xaLSEvDodlolUEs11s0rqcoJiQyKfraLD/7pki
 2DrJ269fFQYHFIKm4nWcjxnQZpYoGilX209PG7qhgK+wPsytqhA6pcgOHKl2kQvILcZK
 M2d7QM0V4H+qE0tis6ZSBD98aSz7FfqKgehcCJw1INqrZfiNfZSqfLyXOv7LOciogA4t
 sZOvOMeOG2RSEumE4dKidIVk+CxMn7QgBa/qTlY7IuzqN3SyeN7G/t/P8ja+O1fWUcq/
 5+LFMeKuUPMdVl2ZIdGO6Gi1fN3zaCdc8PqDQtlp8JL6CqdZQohny7DcpLpBhuo5mA5/
 MrEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrECLoBk92HAb4aUCPZR5kcK8nQgqcJwrCqpnBZMDC5HnOrDCN+nl2Zhfqn9qK2bcPGRBLyxW4zP/FzSEDqCKo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzhNy3JS01YADHmbDgupnKDnAY19d7eWuGrTG/fBpfxYAkcDGU0
 rBRa8C8sXenrKQ1De8TOGpa2eWK6RyKyp1Zn5psFNPPSbfuRvqencuas
X-Gm-Gg: AfdE7clmPwRXLHyEsEkPcgvXfUPXpjFysR6wpIuru4Ij64snZOBDIODskUp+WPmIX49
 BwIaeJ/0Fwy66hySg9n36hk21nXSxsvmoQ7ENOmmW3AxWVYnda/Pj0SQzDroCaMkvY34ITMjKGb
 /AvyTIBqlQ8m7QXUQ1T2FHFiXU0YA3xGDU36CLfEXI6wnc8WiZdtNwmCWXlF2mSfrTf2lpZI/FH
 attPA8VK8yXuO8qoxhvlb3cVjWliGe2QhM+YibF24AgoqQ8SYxJnVqu5u2aC9LGdxMqRgeiqtq1
 8t4xROlcYKiPtASBFl8J3bqI+Axt3ox+vqGphpv/o3TdtHwPZ0KcvssU9MS34RzQ+9t4MBK9ALL
 BgDt7/Fzejwtx9+DOcSAGqZYB8IJ5ah+8mGLqUqike8BjQF4MFGasc904LeD0JS+PrDuHY1aLkP
 OkLhrSmKeITzkzjiA8moYs4WpwUEs=
X-Received: by 2002:a05:6402:234f:b0:699:f957:d37f with SMTP id
 4fb4d7f45d1cf-69e652ee745mr2756200a12.27.1784393837730; 
 Sat, 18 Jul 2026 09:57:17 -0700 (PDT)
Received: from tempest2.110.lan (xt27d7.stansat.pl. [83.243.39.215])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6ffed537sm2328520a12.24.2026.07.18.09.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:57:16 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Sat, 18 Jul 2026 18:56:25 +0200
Message-ID: <20260718165637.3621784-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 15:21:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784393838; x=1784998638; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CsnJtqNCcYIxOQeyroi0AxeK7dRAVN05DqE4BmgloCA=;
 b=KrZ1neSBJ/66TZsm9hKSOSpYxAxiGtwhEFKkR5D8AwLbaDW5mq1lNrhDtAP1aFE38r
 pBwf/9JMEnLo2AtrGXjZNryMhNmdqVUwWUtIzS7XGsB82e0ZHgJcUdRZWscQCZBbItJL
 PjbEzZVRQw0awZ3pPfglPlnqqf5Wt55eqV6pp4KSAzEnodg+8sj2+2Xw15GDAvcsMeyY
 iBDGW+Onw/1Aj47jClPvgMTym6HpUDHDoF8OsZ06jHShHgp6rBynVx8eH5Uw9uxZDfC2
 a/j+PWZkTGZ2Co619gzDdSD84DGwIVN2LXodLGpZQAPHcC9t8G1A3yCefYsDfphRESMT
 gxSQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KrZ1neSB
Subject: [Intel-wired-lan] [PATCH net-next 2/2] igb: read SFP module EEPROM
 through igb_read_sfp_data_byte
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

igb_get_module_info() and igb_get_module_eeprom() use
igb_read_phy_reg_i2c(), which accesses the external PHY register space.
On designs with an external SGMII PHY this returns PHY register contents
instead of the SFP module EEPROM requested by ethtool -m.

Use igb_read_sfp_data_byte() for module EEPROM reads. The legacy
ethtool module EEPROM offset space maps directly to the I210 I2CCMD
module address space: offsets 0x000-0x0ff address the SFP base EEPROM
and offsets 0x100-0x1ff address the diagnostics EEPROM.

Assisted-by: Codex:GPT-5
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 40 ++++++--------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 65014a54a6d1..0fb15bd940d7 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3209,7 +3209,7 @@ static int igb_get_module_info(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 status = 0;
-	u16 sff8472_rev, addr_mode;
+	u8 sff8472_rev, addr_mode;
 	bool page_swap = false;
 
 	if ((hw->phy.media_type == e1000_media_type_copper) ||
@@ -3217,22 +3217,26 @@ static int igb_get_module_info(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	/* Check whether we support SFF-8472 or not */
-	status = igb_read_phy_reg_i2c(hw, IGB_SFF_8472_COMP, &sff8472_rev);
+	status = igb_read_sfp_data_byte(hw,
+					E1000_I2CCMD_SFP_DATA_ADDR(IGB_SFF_8472_COMP),
+					&sff8472_rev);
 	if (status)
 		return -EIO;
 
 	/* addressing mode is not supported */
-	status = igb_read_phy_reg_i2c(hw, IGB_SFF_8472_SWAP, &addr_mode);
+	status = igb_read_sfp_data_byte(hw,
+					E1000_I2CCMD_SFP_DATA_ADDR(IGB_SFF_8472_SWAP),
+					&addr_mode);
 	if (status)
 		return -EIO;
 
 	/* addressing mode is not supported */
-	if ((addr_mode & 0xFF) & IGB_SFF_ADDRESSING_MODE) {
+	if (addr_mode & IGB_SFF_ADDRESSING_MODE) {
 		hw_dbg("Address change required to access page 0xA2, but not supported. Please report the module type to the driver maintainers.\n");
 		page_swap = true;
 	}
 
-	if ((sff8472_rev & 0xFF) == IGB_SFF_8472_UNSUP || page_swap) {
+	if (sff8472_rev == IGB_SFF_8472_UNSUP || page_swap) {
 		/* We have an SFP, but it does not support SFF-8472 */
 		modinfo->type = ETH_MODULE_SFF_8079;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
@@ -3251,37 +3255,17 @@ static int igb_get_module_eeprom(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 status = 0;
-	u16 *dataword;
-	u16 first_word, last_word;
 	int i = 0;
 
 	if (ee->len == 0)
 		return -EINVAL;
 
-	first_word = ee->offset >> 1;
-	last_word = (ee->offset + ee->len - 1) >> 1;
-
-	dataword = kmalloc_array(last_word - first_word + 1, sizeof(u16),
-				 GFP_KERNEL);
-	if (!dataword)
-		return -ENOMEM;
-
-	/* Read EEPROM block, SFF-8079/SFF-8472, word at a time */
-	for (i = 0; i < last_word - first_word + 1; i++) {
-		status = igb_read_phy_reg_i2c(hw, (first_word + i) * 2,
-					      &dataword[i]);
-		if (status) {
-			/* Error occurred while reading module */
-			kfree(dataword);
+	for (i = 0; i < ee->len; i++) {
+		status = igb_read_sfp_data_byte(hw, ee->offset + i, &data[i]);
+		if (status)
 			return -EIO;
-		}
-
-		be16_to_cpus(&dataword[i]);
 	}
 
-	memcpy(data, (u8 *)dataword + (ee->offset & 1), ee->len);
-	kfree(dataword);
-
 	return 0;
 }
 
-- 
2.43.0

