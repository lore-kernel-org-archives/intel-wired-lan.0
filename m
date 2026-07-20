Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95B4C44515
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 14:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E166606DB;
	Mon, 20 Jul 2026 14:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ld0y6OsDBzV0; Mon, 20 Jul 2026 14:35:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D2E96067D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784558122;
	bh=Z3VaPip/rhZHQR85NvyPs/zlByfwCUa6xlhWOu76l9g=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xQ4zT3S+rWWSzvJzTacpT2OvDQBZZ4LHORUfAtdwTz9qiM0hvFZ7P4ZYeQg6XF6Sc
	 736g6fhRHzv1cPK0cir9gkpjxyXPyfJ8ObbXCklo3qdDe8O3lFw8CtIm6NXzrkO/SI
	 m9qfueFYd7BS0FNigLtDQj2COuTV5JH8RI5YQj9IgMyVEdOrxPo+GhgKV5UEQXvz/D
	 Z6/wxEW+x6OyOYdaYY/S1uwK8pRU51cPeNpzglDQ2abfahA4c5fqllUs7w3xPNJ/K5
	 fcnNn4CZu5AM2qPIi0tLc5i+qODTxicvW6tHcZWNtQw9riqFE6TwErbht1GepiRD5k
	 NPr/2MDauyEIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D2E96067D;
	Mon, 20 Jul 2026 14:35:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A2DBC206
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 14:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 797F180C81
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 14:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekS6wNOmZZ5v for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 14:35:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=mhun512@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D176480C80
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D176480C80
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D176480C80
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 14:35:19 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso78168005ad.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 07:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784558119; x=1785162919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z3VaPip/rhZHQR85NvyPs/zlByfwCUa6xlhWOu76l9g=;
 b=IqcE6M6yYHp5HGpItkIU4WowGnki3E4EHXcZG5FTfPfjmsVXTIqvw61Q+YuWTH3Thk
 UDebPPzE6N436RfW2FU2FE8VYcSGA8v1ulPa3dEI4Buzhcm7Rch6c9NZrPup5+3W1H3w
 3Gd2wTR0Wjwa3tcZdJTH6yYEm87iaxKGwg9GCB7WPiGnHSHivgBbJShapMv4Ut0DN8EU
 ivOhAlP/e8IKlT2DSO2h0Ya3NbAnESXcE+2HbrnLL6pH5ZeWH56n3qyGvrE/5xz02Uc8
 /M3exlBAB5S159I3DJf4utwFrcNSZPU88ynjHIRh60ijtj7cGIBZ2P1pkPadWx2G8TUx
 uTXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYR5tXi63ffzueotZHhpcNLiVcVMSIxmMYR1tOanrlMh8zB1qVXe+1vaCV+Ywpe4nTa2lGMlzK7CdR4no0OTU=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yz8dk9Dau7nRgnrZOzDncc295wE4KEKo6FLr7wRhakjmKeBpZCa
 NGWCLaEri7yTI2dXYWJBFqI2sEjWxndhMzt/LuL0P2bUwcC7ZXNUBIk=
X-Gm-Gg: AR+sD13LM2EtUC8ccejCIFxtW9li0GPZuGGSlHSYMyvG0UfVL/S+vAqfOdZ91xmJZRi
 q3yYtBALoLFMAbPPoe3jQ2pLwkWH1Hlt1smOfX72P7F98zogISH0LXlPcZruMr+9Ao2QvFJttcD
 i/FjW8ZKJ2U6I8v/FHlHGSzVVVyCl6UUi/PHE2l7FuJE/Hjn6HINpuKHpkg8lpetbIUghBY7ZWg
 pbFaDTbkhdMnUnTW3JKHqTmd7rpNoVcqH2w1E5HT9nCI8Hd8ZyqaR8nkkA5Sh1vvCp5Zds72a6E
 dgpE/e2FZwHmbu3XWY+sEU3QfODbigFTil8xG/jQL6RqXvX21acDF71B06JMtEASpoNGYe9rHf/
 OvVF1XAlgJmPt3idgW7fZxbhy5SLRIWN4tfJuUaUkIZq4X2kcB391bjHtKPjVlu9KEVqmf+c2oj
 NoWkNJZp/1LLWIwfotHDA7YTm/13Wo9KiflO6Q978bFhdHiusZZKRlmy2rpCZh2/W/HFiFEBM/W
 FDF+j2Ypx0SN6UEzpHuLYVxlsdL/rACTI6evjbj
X-Received: by 2002:a17:902:d4c5:b0:2c9:2ee6:693e with SMTP id
 d9443c01a7336-2cf34873ddfmr172634965ad.18.1784558118851; 
 Mon, 20 Jul 2026 07:35:18 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347166e6sm57973575ad.59.2026.07.20.07.35.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Jul 2026 07:35:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Milena Olech <milena.olech@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>,
 Ijae Kim <ae878000@gmail.com>
Date: Mon, 20 Jul 2026 23:35:10 +0900
Message-Id: <20260720143511.43408-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784558119; x=1785162919; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z3VaPip/rhZHQR85NvyPs/zlByfwCUa6xlhWOu76l9g=;
 b=TxOSAS1h/rwsvOUeAt3G59I3rD1/xnjGe4FH2RkbYTl5GUNeZoR/dfyRy2x9wIDcMB
 MIgrr3taGixXu6YJbHOszulCMgjbpLOYIdVEoTR/i+Z5K57hMM5wqlo8VNI3rXa1PxCf
 IJmiB3yyzQ6lEv0StfZ4zTOTkxCL7UqXFwZrK0fxfi4sHeVz4aT3aTLRp0ZZS4LJCTgE
 xa+6m0gt/Bc/bU2AfGrBMCCij34fcvhaf7o7h9QPHYKs11yWvY4BrP0xcFc2AcIrOqeu
 jZ9lyJnSXNApyrTDLRPqnfpbnmRi8guDTfQ7tBBT2+6AH5cH4T8A9g+epfebFV8zd0hm
 Qr3A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TxOSAS1h
Subject: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe failure
 and on remove
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

idpf_probe() enables PCIe Precision Time Measurement with
pci_enable_ptm(), which takes a reference on the device and on every
PTM-capable device up the path to the PTM Root.

Neither the probe error path nor idpf_remove() drops that reference, so
the PTM enable counts of this device and of its upstream path stay
elevated with no bound driver, and the device's PTM control bits remain
set.  pcim_enable_device() only arranges for pci_disable_device() and
does not undo the PTM enable.

Add the matching pci_disable_ptm() to the common probe unwind and to
idpf_remove().  pci_enable_ptm() failure is not fatal here, so guard both
calls with pcie_ptm_enabled(): pci_disable_ptm() decrements
dev->ptm_enable_cnt unconditionally and then recurses upstream, so
calling it after a failed enable would drive this device's count negative
and wrongly decrement parents shared with other endpoints.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Rebased; aa8671af0c38 ("PCI/PTM: Drop pci_enable_ptm() granularity
  parameter") changed the call signature, so v2 no longer applied.
- Guard both pci_disable_ptm() calls with pcie_ptm_enabled(), as
  pci_disable_ptm() is refcounted and recurses upstream since
  e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and
  Switch Upstream Ports").  Raised by Tony Nguyen.
- Dropped the v2 claim that pci_disable_ptm() is a no-op when PTM was not
  enabled; that is no longer true.

Changes in v2:
- Disable PTM in the probe error path, as requested by Emil Tantilov.

 drivers/net/ethernet/intel/idpf/idpf_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index ab3c409..97bafeb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -159,6 +159,8 @@ destroy_wqs:
 	mutex_destroy(&adapter->queue_lock);
 	mutex_destroy(&adapter->vc_buf_lock);
 
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
 	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
@@ -266,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
 
-		goto err_free;
+		goto err_disable_ptm;
 	}
 
 	pci_set_master(pdev);
@@ -279,7 +281,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!adapter->init_wq) {
 		dev_err(dev, "Failed to allocate init workqueue\n");
 		err = -ENOMEM;
-		goto err_free;
+		goto err_disable_ptm;
 	}
 
 	adapter->serv_wq = alloc_workqueue("%s-%s-service",
@@ -366,6 +368,9 @@ err_mbx_wq_alloc:
 	destroy_workqueue(adapter->serv_wq);
 err_serv_wq_alloc:
 	destroy_workqueue(adapter->init_wq);
+err_disable_ptm:
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
 err_free:
 	kfree(adapter);
 	return err;
-- 
2.47.1

