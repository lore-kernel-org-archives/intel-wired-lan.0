Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D507CD8C8E
	for <intel-wired-lan@archiver.kernel.org>; Sun,  7 Jun 2026 14:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F418761070;
	Sun,  7 Jun 2026 14:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yFu6uUvYc48; Sun,  7 Jun 2026 14:57:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29FFE61011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780844246;
	bh=mrsfiJvZujVMJsxbWI6VmHgpGn8Fz7/vkXorwSa3nAA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y2nluxO04vUsQKSVVgrSbuKir+LavT3GPz8ZjTR2M/VMhiZSgljfT1Azpv/ZJ4biS
	 kibSiVj7iI+x7ffDF+9tllKblusaK7ojB5eWzCIkBOJ4HAx58mx9YWLtj4yCUY+E0F
	 +qfK27Hxe2dFSFiTavkmpbgAs+srKCzcmTgMduZUJPeHl+ifX0egPiRNqy3IqQQUCl
	 feCQfFK2RsGyTNpodMzFqZXSngvI76xpWEp4cvlONVb1QLY8FdPV8UX+wmpcdkoEoi
	 /rZ0m57oc49u/QPI/KYBiCTbfkBRySQ41G8aIBHNbLJwH6GoeS8HUr1FOihqFfiRup
	 GmRm8tNBBs+sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29FFE61011;
	Sun,  7 Jun 2026 14:57:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2C782C1
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 14:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C47AB4058F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 14:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bObj7sbzHJWB for <intel-wired-lan@lists.osuosl.org>;
 Sun,  7 Jun 2026 14:57:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.224.82.86;
 helo=mail-m8286.xmail.ntesmail.com; envelope-from=dawei.feng@seu.edu.cn;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C6AFB40266
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6AFB40266
Received: from mail-m8286.xmail.ntesmail.com (mail-m8286.xmail.ntesmail.com
 [156.224.82.86])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6AFB40266
 for <intel-wired-lan@lists.osuosl.org>; Sun,  7 Jun 2026 14:57:18 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4163e2705;
 Sun, 7 Jun 2026 22:57:10 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Dirk Brandewie <dirk.j.brandewie@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 Dawei Feng <dawei.feng@seu.edu.cn>, stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
Date: Sun,  7 Jun 2026 22:57:06 +0800
Message-Id: <20260607145706.2933860-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ea29678dd03a2kunm392e2c96b787a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTRhIVklIQkxPT0pOHkMZGFYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 b=XwqtSqIGXZcPQOauGN+4pq8mJd9J+ZwpxFkIekP0stgMnFI1UFr1kBGk7Q2uu3Msok1J36bm/eeWHCGpTnCCjMdyH3KQVFufKsII36BtIvSUMDDgHhgLvUQQY5jmFv1sPA6aowAonWCy9X7wPA4pqWgONC7nPKlEPwjHbncEz+w=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=mrsfiJvZujVMJsxbWI6VmHgpGn8Fz7/vkXorwSa3nAA=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=seu.edu.cn
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=XwqtSqIG
Subject: [Intel-wired-lan] [PATCH net] e1000: fix memory leak in
 e1000_probe()
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

In the e1000_probe() path, e1000_sw_init() allocates adapter->tx_ring and
adapter->rx_ring. If the subsequent CE4100-specific MDIO BAR mapping
fails, the error handling jumps past the ring cleanup code, leaking both
allocations.

Fix this leak by moving the err_mdio_ioremap label above the ring
deallocation logic. This guarantees the proper release of these resources
and prevents the memory leak.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
CE4100 reference platform to test with, no runtime testing was able to
be performed.

Fixes: 5377a4160bb65 ("e1000: Add support for the CE4100 reference platform")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 9b09eb144b81..d7f5c6f16142 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1222,11 +1222,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (hw->flash_address)
 		iounmap(hw->flash_address);
+err_mdio_ioremap:
 	kfree(adapter->tx_ring);
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-err_mdio_ioremap:
 	iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
-- 
2.34.1

