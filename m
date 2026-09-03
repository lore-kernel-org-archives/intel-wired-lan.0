Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FAAC61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 15:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 322CF407FD;
	Thu,  3 Sep 2026 15:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tP5PtHzDv7F8; Thu,  3 Sep 2026 15:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B7851405BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788450818;
	b=eUoTgdkfzurDs+xmKqz3LYJBZfNZ9jfFrH9p9qsb7BPhyVM3nWsJMY0ws/hyUfQvZPhL
	 R+Z8fpPGuCwmKO3RQBWrPwqC1539iWsELe5zWDCb19L0tohme/mOeXKSIsZXGO7jdFeGW
	 9z6e7gCy8BDtO58MkWcOonmbACfBMzTgHDxxlHTXTJwDzXJiJ8BcGOtwOUDC/z7YouyQQ
	 nvcXfqXspoVwrQABcAeUcMuWXC9JbkoamL9hcaBWh8bQzGPGFaOYnv1GRGm29Iem3ReAi
	 h20Pn2HlGtH0FerYPwsy9pXizpyBU6q7Eu8IAN2CQaSncCnTsZBVPyI9wq5NzuVll3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788450818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PHz986DAN3OTgNZI3aFz9jetQpviejHajdF51t98HAc=;
	b=MFiXJFDHOegieD+6N6no8dobiwFh5nWdCUC7ilRhn3WMAL+q7IPeQGGKaJrTowh6lWtd
	 uxza6tyuW3FKpZvoud/Ao7fx5nNuoCDTpbFDwOiySzbGN/RANbkqx8mWCZ/lhh7WkOGT1
	 ReGEDFKPKNiVMJWGTHoBGuqBmxvOHYQ5WdXGKIZ2zhye2D1CpuM88+U+GSbGCTE46tGAa
	 AV1XI22gqeGD/63LRxlBHAIsijm36iCa3Ty1wK3I8fZRxRbXOpV3+yj0e3Qec4zX5Ntub
	 nDUcgIZTyvhBHiTutqHaRSM6Wy3mN64KhBMTod1OS/cJBq//MAR9LNui7Uwc7pzjkPw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788450818;
	bh=PHz986DAN3OTgNZI3aFz9jetQpviejHajdF51t98HAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twG9jyWLPbArkwAcLD7ZuwiJxIZiOHNQhQ4mVmt8tNyboX1XapeOTuM+b79z3xGjk
	 Iy64/P4AVLAlQrZMYbW4Cql5/FgumW+VjMEiv1At5g9WzTn4+Bm1j87rRTjZzjIRZI
	 Ocu6pQCYiazsuAL7opKKaym2caf7VIWGSOhHdd+BtbQ5TU+jhStfGqH5zyS0NICJtw
	 LXLlmaQpN25N9XJ/c7QNjwsdZHHJQZfIoa5kx/V3dYWZNWldDRaVRjCFAywUF+vb35
	 PjQVqx0KAmGuAy3Tjv5Txypzp2d2SNy/BCF3H0uLb2foKFWwdjVzUhAwYQi+qyPwg3
	 dV7O0rFn0H47A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7851405BB;
	Thu,  3 Sep 2026 15:53:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55CD3265
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 08:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16D3D608B9
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 08:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NhXJbrvRK89C for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 08:50:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2D1E60869
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=220.197.31.105
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788425405;
 b=ot7eLK7jhdcrifjLvgkgiIz/Mxu8JEOhpwxdAEy/F0jLfCglq5ufTonM+NBrFx5G7gZr
 kT0jq9wrQv10dH8cBtkJXBCyPlpzKFMBu8QLz/N7kstqCuIch4nfvTlTYgSjF/gPziD/h
 IVvBtvU8j4LlccoQdQn53GBWaiVP0OioJ/sY/0I4rHXZJF7woUFygglc0DXfF6Qa3B0P6
 FK6kdxf7juSvp9NPIaFVAnv3YY+vutYydARv7ogT+8K5vfhtuRuOlduTWX1z96QAoHp4i
 E7Ln5ePKVEYqN4183JvtI+HaifiPg4C0r8Ck43MpAqGE+F8SpbSE46Q76vJHycXSkkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788425405;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
 bh=PHz986DAN3OTgNZI3aFz9jetQpviejHajdF51t98HAc=;
 b=Y22QZTsjZ8yAgj3kg+Y9RdqjbOcpaxdkIUdDcMsIplELlESp8IbjuM6jOftOB/p14RgU
 zvTZz2zfMUkyc09iTFCRXQqEh+/tyhaBNGujaPFMIQrp/9OK4FMHyVGM40ut1xL3N+tF5
 OTxEL2Rr2tsYcrFgCKrg+Qe56oy7ZJUu/5miza+F6TLhEz5/S2FV0RUVuNS1edkNEMMhI
 i1bHGqyQoHpyWhT+gWsl7TkWC7UBnuSUgNo0pBv7/WhEfeBiWMsnMUFcE4x7q4ImE6ku+
 bpPccl2+CeueHsJf/ZONeQt4o/LVsHCIYLUu/WhYKT5U4K2FopqQ4LoVK9unXlxqsww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=resnics.com; 
 arc=none smtp.remote-ip=220.197.31.105
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 03 Sep 2026 08:50:04 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=resnics.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.105;
 helo=mail-m19731105.qiye.163.com; envelope-from=zhouruizhe@resnics.com;
 receiver=<UNKNOWN> 
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com
 [220.197.31.105])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2D1E60869
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [115.220.204.6])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5aac;
 Thu, 3 Sep 2026 16:44:51 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ruizhe Zhou <zhouruizhe@resnics.com>, intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 07/14] fm10k: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:32 +0800
Message-Id: <20260903084339.870562-8-zhouruizhe@resnics.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260903084339.870562-1-zhouruizhe@resnics.com>
References: <20260903084339.870562-1-zhouruizhe@resnics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0667139c003ackunm85c9d55b5cc3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGR5OVh8eGEgfQkNJTUwZGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
X-Mailman-Approved-At: Thu, 03 Sep 2026 15:53:37 +0000
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

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a wider request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure is still reported and aborts initialization.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index f5b4d062709a..afe939f8f4ef 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2111,8 +2111,6 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
-	if (err)
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&pdev->dev,
 			"DMA configuration failed: %d\n", err);
-- 
2.27.0

