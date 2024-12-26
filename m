Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFBFE7718E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Dec 2024 16:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F7A605DA;
	Thu, 26 Dec 2024 16:52:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbS7YXP2D65V; Thu, 26 Dec 2024 16:52:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2C426064D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1735231956;
	bh=zewCXryLBAmS6GupELoPnKwlpgE7Rk2QDzMgSD+MVFI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=itp+P9bHj1WrOP9CT75Gu3PMihj72cWd8p3/lwkb2Q2MoY65uKqK8tQK+mqf07qz+
	 JDV7lFz10IGQg32yAMWvE8TL0K34FapMt6qOQP20oUhtyoX4wl4blPYKnWlqrcP14G
	 8PfJsW+G1qJpwIdSL1DssAlSNVPW62uocvhqV2N9EUQjtPo0dSFr+zTjLUsVMJ+boG
	 0YSGNevAl9zmsma54+AhGBZ+G3WsyctJ8X2XqrSm8IWfsoLdIlQv8/fJB5RaWWFhOX
	 pB85KH5waV39Udub0N8o7LGGZTNaQfYaF0U/thXu+T9ClHc7XmjdsRsTwrHi8//YcM
	 dL0JW4ag9Hq0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2C426064D;
	Thu, 26 Dec 2024 16:52:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1BBD757
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Dec 2024 16:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C194B80B73
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Dec 2024 16:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCM3bdTAWvYH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Dec 2024 16:52:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:5b::1;
 helo=mx.treblig.org; envelope-from=linux@treblig.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EAE0880AF9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAE0880AF9
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAE0880AF9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Dec 2024 16:52:33 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tQr5t-007IaP-2F;
 Thu, 26 Dec 2024 16:52:17 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Date: Thu, 26 Dec 2024 16:52:14 +0000
Message-ID: <20241226165215.105092-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226165215.105092-1-linux@treblig.org>
References: <20241226165215.105092-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=zewCXryLBAmS6GupELoPnKwlpgE7Rk2QDzMgSD+MVFI=; b=VKUFBX6eoigWH2fU
 UaSvitHog9H9Hgo/eFU/GROMJPIk7yTVpAJZ6VT9ugngCqffiqtzxbJ1Dd3c29n5sehqyNeDPjdyL
 zt90AgJvEL8JnoOpGYj8iQuoBwxPC6LZovwizBp1zY+NKwoGErtkXKf0eV1B8AyG9XYBrLgcRdqy7
 AjMXaOT24qh/YgqTs6VJh8yCXPXJrXsaziCS7Iosz/N0335sfTIXxXU2AhzwbhpROKHOXTWdpur0P
 4X1Bc0Jkbl7314fJjLLE4bVQH3T9Yi73ajhLaZYHOjHkh0fHWGU++29NUDu5vO1J+2IIdDmIcRjE3
 FnN1CqyH5Gj8T83oOg==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=treblig.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org
 header.a=rsa-sha256 header.s=bytemarkmx header.b=VKUFBX6e
Subject: [Intel-wired-lan] [RFC net-next 2/3] igc: Remove unused
 igc_read/write_pci_cfg wrappers
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

igc_read_pci_cfg() and igc_write_pci_cfg were added in 2018 as part of
commit 146740f9abc4 ("igc: Add support for PF")
but have remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/igc/igc_hw.h   |  2 --
 drivers/net/ethernet/intel/igc/igc_main.c | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index d9d1a1a11daf..7ec7e395020b 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -281,7 +281,5 @@ struct net_device *igc_get_hw_dev(struct igc_hw *hw);
 
 s32  igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
 s32  igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
-void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
 
 #endif /* _IGC_HW_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..9c92673a7240 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6780,20 +6780,6 @@ static const struct net_device_ops igc_netdev_ops = {
 };
 
 /* PCIe configuration access */
-void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	pci_read_config_word(adapter->pdev, reg, value);
-}
-
-void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	pci_write_config_word(adapter->pdev, reg, *value);
-}
-
 s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 {
 	struct igc_adapter *adapter = hw->back;
-- 
2.47.1

