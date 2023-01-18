Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB80C677F1
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Jan 2023 23:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89FC2405AE;
	Wed, 18 Jan 2023 23:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89FC2405AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674085641;
	bh=Ib9/qN9uq8oCieI0obkEH2ie9ZDDELVLOygYDtXfXqk=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ba8VlNtx3cyUrF9wGmBzselGtdmbaciVa05Z+pT9+6DHhxScjJAI9SmXAkF5WcOVD
	 xMNhLLF7Tx31vCqe/vPaBiuk43TPvkRkEGFVcOb4eXJAo6jbovHMquh2dlElEbnHEd
	 XwCA1nqXgBLwtSpQpb4stsO43YhatxSK7VijV5jeSLxxcA5BtX0afgE88pvMhQOLpr
	 zeCwDTSaWhu4fqCveq+vfkosGMYdE1p3hosKy6NBcwC4fV4+x7NpG130QOZATbUXe2
	 EOM7ibvUP40zgtlmsb7BcdqLtw2avFQiA02fd4CgCigHvcNfqiLoyUoQfJ0GfgbzJX
	 5KVteBvlPYp1A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JXaW8fovU4pv; Wed, 18 Jan 2023 23:47:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51C464092C;
	Wed, 18 Jan 2023 23:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51C464092C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 64E931BF392
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 23:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40DA4610AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 23:47:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40DA4610AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5DUoxNyqv603 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Jan 2023 23:47:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 954CB6107E
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 954CB6107E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Jan 2023 23:47:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DC46161ACF;
 Wed, 18 Jan 2023 23:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36586C433F1;
 Wed, 18 Jan 2023 23:47:02 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Date: Wed, 18 Jan 2023 17:46:11 -0600
Message-Id: <20230118234612.272916-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118234612.272916-1-helgaas@kernel.org>
References: <20230118234612.272916-1-helgaas@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674085622;
 bh=jU3LaV/UIN+dmBuggye012PcdlnkG7nIjHD98dbjUpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i4ewNbWLwndEi0QGob/RnVhLVMjzuxxSDIsj4Wz1njkOXrN9upsBTs0ek+BPlL5as
 abQIZHzIDFX9Jwrt81zSgXU7iG8Dbwt1h94kki3ko5cioXiZCIEOkfZy25ZCh1f3dr
 cwwgILQ4BWtV58AG2KtydiFYCCAOURTCsyziY0YAzmDaWvSTIo8CbjQ0m+Kduuv8KF
 a5m+O4VBqcZLRX63ASPiFiX6tv4WrapyoAdu8xmNdUJFKlAq3GU9Bbw/9tXyKRoDdh
 ioomQ2xowXpviJFHoiZqGEtYa8ZQnlTel79kH9P1YvHZBQ3eW1ffOOj5raLHnFojuh
 cQDucPtnpq7qQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=i4ewNbWL
Subject: [Intel-wired-lan] [PATCH 8/9] igc: Remove redundant
 pci_enable_pcie_error_reporting()
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Bjorn Helgaas <bhelgaas@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() enables the device to send ERR_*
Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native"), the PCI core does this for all devices during enumeration.

Remove the redundant pci_enable_pcie_error_reporting() call from the
driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
from the driver .remove() path.

Note that this doesn't control interrupt generation by the Root Port; that
is controlled by the AER Root Error Command register, which is managed by
the AER service driver.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 44b1740dc098..a4df4ef088a9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6430,8 +6430,6 @@ static int igc_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
-	pci_enable_pcie_error_reporting(pdev);
-
 	err = pci_enable_ptm(pdev, NULL);
 	if (err < 0)
 		dev_info(&pdev->dev, "PCIe PTM not supported by PCIe bus/controller\n");
@@ -6636,7 +6634,6 @@ static int igc_probe(struct pci_dev *pdev,
 err_ioremap:
 	free_netdev(netdev);
 err_alloc_etherdev:
-	pci_disable_pcie_error_reporting(pdev);
 	pci_release_mem_regions(pdev);
 err_pci_reg:
 err_dma:
@@ -6684,8 +6681,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	free_netdev(netdev);
 
-	pci_disable_pcie_error_reporting(pdev);
-
 	pci_disable_device(pdev);
 }
 
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
