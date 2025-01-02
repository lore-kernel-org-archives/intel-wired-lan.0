Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C95E77194
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Jan 2025 17:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0906E40343;
	Thu,  2 Jan 2025 17:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXgBDt3UmVSR; Thu,  2 Jan 2025 17:41:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA4AD40355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1735839716;
	bh=7AmYte8oTBIV4rhftXrsFRb4h3cQ6cpdyY2nNfyPAUo=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jLsc5E8oK5gvFM4OK7y8xM9wnn8nFnrUUdSjEZjNMkXZKw5IrEie1nteKH1tQc1Hv
	 29qfG6GhfMJ8FnaqJQhOOazF8B5a6ZtvYdWnxI4RbS1lp1ewLrQgLUdNSLV/FYGh3I
	 ctcD3Rwyy8EUi2waCgS0RixcbkSkU9bpNS8ZEP5tIGzo6aHjgMZWHAz97Fohm5phDh
	 VtAawUhogRBiBjIT8d2hJLmqDRZUD8jaU2cPGsUf6B1+j6U+/ffxBJwXn37lWgO+Pr
	 8/YEy+copzg1uZgJ270R984vpdwdFuzL4iOq/yav+qeQTSy/1+mbvhY5hT5MmqBNbe
	 VUJaFG0vMdvIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA4AD40355;
	Thu,  2 Jan 2025 17:41:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D259AF24
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jan 2025 17:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B268A40353
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jan 2025 17:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Toiiem_bzUUc for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Jan 2025 17:41:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:5b::1;
 helo=mx.treblig.org; envelope-from=linux@treblig.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BC20240343
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC20240343
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC20240343
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Jan 2025 17:41:52 +0000 (UTC)
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tTPCb-007u04-2Q;
 Thu, 02 Jan 2025 17:41:45 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Date: Thu,  2 Jan 2025 17:41:42 +0000
Message-ID: <20250102174142.200700-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102174142.200700-1-linux@treblig.org>
References: <20250102174142.200700-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=7AmYte8oTBIV4rhftXrsFRb4h3cQ6cpdyY2nNfyPAUo=; b=eZX1CAuydvfqHvVp
 PRoGyZI90PuSx8iEZoNUzUIp99xN7QQ6NEca7FKzdfEjGqJwVlPiranManolBAyuUG7/GZ72w39lc
 fLA122L4mlaQiGqg0BFoZ5xGeAoY/ZwQjZ5xgJN8kGw6IsEa36rYr/TqRIbh2/OThUo25zSa3fA1B
 2jKrg3rJAssXlGdSyed7Mwk8LvkvDkjhgROdp2S3qH+MRJlJsRu1qnvlG/Nxxyg9s0C7TKRQtPQUQ
 0EC906u1aPudUTFqKkv35iijvsOw2jHwupiLtSjmiPBBLJ5VYM/hSoPv22t6nlMzj8n7CqC2Z2q06
 j3KksT/A+aHEJi7nGA==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=treblig.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org
 header.a=rsa-sha256 header.s=bytemarkmx header.b=eZX1CAuy
Subject: [Intel-wired-lan] [PATCH net-next 3/3] igc: Remove unused
 igc_read/write_pcie_cap_reg
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

The last uses of igc_read_pcie_cap_reg() and igc_write_pcie_cap_reg()
were removed in 2019 by
commit 16ecd8d9af26 ("igc: Remove the obsolete workaround")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/igc/igc_hw.h   |  3 ---
 drivers/net/ethernet/intel/igc/igc_main.c | 25 -----------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 7ec7e395020b..be8a49a86d09 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -279,7 +279,4 @@ struct net_device *igc_get_hw_dev(struct igc_hw *hw);
 #define hw_dbg(format, arg...) \
 	netdev_dbg(igc_get_hw_dev(hw), format, ##arg)
 
-s32  igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-s32  igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-
 #endif /* _IGC_HW_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9c92673a7240..f58cd6940434 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6779,31 +6779,6 @@ static const struct net_device_ops igc_netdev_ops = {
 	.ndo_get_tstamp		= igc_get_tstamp,
 };
 
-/* PCIe configuration access */
-s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	if (!pci_is_pcie(adapter->pdev))
-		return -IGC_ERR_CONFIG;
-
-	pcie_capability_read_word(adapter->pdev, reg, value);
-
-	return IGC_SUCCESS;
-}
-
-s32 igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	struct igc_adapter *adapter = hw->back;
-
-	if (!pci_is_pcie(adapter->pdev))
-		return -IGC_ERR_CONFIG;
-
-	pcie_capability_write_word(adapter->pdev, reg, *value);
-
-	return IGC_SUCCESS;
-}
-
 u32 igc_rd32(struct igc_hw *hw, u32 reg)
 {
 	struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
-- 
2.47.1

