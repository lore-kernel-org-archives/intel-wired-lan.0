Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77599C43458
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 03:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188FA60845;
	Tue, 30 Jun 2026 03:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnWXx-frrH09; Tue, 30 Jun 2026 03:26:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95421607E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782789971;
	bh=/SwNmCMjTxoLdqZnFpSJjNUEAyiVEzWIN9TdiRidF4U=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ef3EQx1R/XK24kNYcwb/+1pYyS9NJB6fpITJ1U2x5aLXcjO+lPpRzBGihQdIkVdY4
	 GlYbB8mb476uQRcNSxXJvLpUWl3vaFJ0+GTDqKEzXuGLoHN92e4CuZIB7SO3Vugo+O
	 OFftjSsISA9OycsNcQuUa0/PxjoeCcYQbjWO8V7JKncSvTZn8SaebuCCFFtnDdmNAA
	 xAYAGx1lW+N2As5pR2zkdz06kTqR2qYr0KGGHoX0WnsUzQAsDOwUGI2bNUvbG9ABZe
	 RTqjBK5eK0sefSwdC2xwKII8Fq/9YkFem10S5ehTdEp3PX6XE65XVpcAE++NRvAEkE
	 YXlDveJ2Twb6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95421607E7;
	Tue, 30 Jun 2026 03:26:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9444B149
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 03:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8826981347
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 03:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dh6Q92we1yy1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 03:26:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.5;
 helo=m16.mail.163.com; envelope-from=clementwei90@163.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 851CC81301
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 851CC81301
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 851CC81301
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wBHShoyN0Nq1ZWKFw--.30162S2; 
 Tue, 30 Jun 2026 11:25:42 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, Rongguang Wei <weirongguang@kylinos.cn>
Date: Tue, 30 Jun 2026 11:25:37 +0800
Message-Id: <20260630032537.42605-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHShoyN0Nq1ZWKFw--.30162S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rGrW3uFyfZrWUZrWUArb_yoW8Kr1DpF
 WDAFy5Cr1kGr45W395WF4qyr9xK3ykta45KFWDA3Z2vrn8Ar4ktr9FyF4S9ryrJFZ3Kay3
 XF1jvFWUCF4xXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hZGsWpDNzYhwAAA3K
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/S
 wNmCMjTxoLdqZnFpSJjNUEAyiVEzWIN9TdiRidF4U=; b=hBGaOmjbj7N6Dr/ioC
 r+1TQ0YrYoKS3e2LsbPSMhMxIQwtv3w5AsEnnreGabPHTuc2GuSRyrJiUum6ELLW
 24yjn3y7d5kFUpj1j1jZhiTjlr6IvgLHCSP6KBU6HdLbSZdtjC4Otkr4olLyEHxa
 fsbVZmKV2tgea0o+ES6ncQZrg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=163.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=hBGaOmjb
Subject: [Intel-wired-lan] [PATCH net-next v1] ice: use dev_err_probe in all
 appropriate places in ice_probe()
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

From: Rongguang Wei <weirongguang@kylinos.cn>

Use dev_err_probe() can conveniently combines printing
an error message with returning the errno and also
simplify the code.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 ++++++++---------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fbe111f849..81959eaec708 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5167,10 +5167,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	struct ice_hw *hw;
 	int err;
 
-	if (pdev->is_virtfn) {
-		dev_err(dev, "can't probe a virtual function\n");
-		return -EINVAL;
-	}
+	if (pdev->is_virtfn)
+		return dev_err_probe(dev, -EINVAL, "can't probe a virtual function\n");
 
 	/* when under a kdump kernel initiate a reset before enabling the
 	 * device in order to clear out any pending DMA transactions. These
@@ -5194,10 +5192,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return err;
 
 	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), dev_driver_string(dev));
-	if (err) {
-		dev_err(dev, "BAR0 I/O map error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "BAR0 I/O map error %d\n", err);
 
 	pf = ice_allocate_pf(dev);
 	if (!pf)
@@ -5208,10 +5204,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	/* set up for high or low DMA */
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (err) {
-		dev_err(dev, "DMA configuration failed: 0x%x\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "DMA configuration failed: 0x%x\n", err);
 
 	pci_set_master(pdev);
 	pf->pdev = pdev;
@@ -5246,10 +5240,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return ice_probe_recovery_mode(pf);
 
 	err = ice_init_hw(hw);
-	if (err) {
-		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "ice_init_hw failed: %d\n", err);
 
 	ice_init_dev_hw(pf);
 
-- 
2.25.1

