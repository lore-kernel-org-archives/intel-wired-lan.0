Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB3BC43327
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jun 2026 15:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF5A760DB2;
	Fri, 26 Jun 2026 15:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ms23tjWmxzKM; Fri, 26 Jun 2026 15:15:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96AEA60BFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782486950;
	bh=PA6hCiGzE66fmjJHAfRH4gg5KTKAd+aVqbApVfB/ibk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wi7mGE0ud5p+AaEL8cKnfC1dxn900gGoACYLbxrYMG81JR4VFG+MaBB9LMbY2yYK9
	 GYqWna8orLbfCnOA5xRDTslanSJU6lHnRU6wH/pCIqiAbN0steouqsFzJdtpC/jzfp
	 NK4fVIspiYbAo4gmLLuzvzqUUQDvkXipGfv7gkMGIFYkCepQuElFD+f28uk2Td0uHl
	 OXhJF8sIhpCX/Gqz7zTatHtlilDxp3C+DP0k5ldpAjQy8kGmMDtSyzV/IRlsy/u/O9
	 pExo8nIUR/EHIJAQ5DGCGRhFh+iCKXYChj80O4XDayLyXtRrE8I4S3XLae07zPYsJU
	 lxPQZoCjTxWww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96AEA60BFB;
	Fri, 26 Jun 2026 15:15:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 509C9369
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 08:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4261660EA4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 08:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFM3SP0SSEUN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jun 2026 08:47:54 +0000 (UTC)
X-Greylist: delayed 493 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 26 Jun 2026 08:47:53 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8067D60EA3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8067D60EA3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.181;
 helo=out-181.mta0.migadu.com; envelope-from=jiayuan.chen@linux.dev;
 receiver=<UNKNOWN> 
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8067D60EA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jun 2026 08:47:53 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jgarzik@redhat.com>,
 Bruce Allan <bruce.w.allan@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Jun 2026 16:39:16 +0800
Message-ID: <20260626083917.49745-1-jiayuan.chen@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 26 Jun 2026 15:15:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1782463175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PA6hCiGzE66fmjJHAfRH4gg5KTKAd+aVqbApVfB/ibk=;
 b=un/GEyo+tKyJYyVyG8EPnO3Z1mA/K0zoVG4thj9w1rO2hP1RH/KrJBkl2TW3TeTyj7LST9
 aeoRxwSaPhvEXQQQrzUcBehJzEbtNKW0OfC0xai39hKYxCesEEBSRJmwNxawy+e37Z2j+g
 ZKXX1KUQ2+zM/kQLoTAxbkxwMJcBmKY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=un/GEyo+
Subject: [Intel-wired-lan] [PATCH net] e1000e: fix IRQ leak when
 request_irq() fails in e1000_request_msix()
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

An internal syzbot instance reported the warning below.

comedi (comedi_parport) lets userspace request_irq() an arbitrary IRQ
number and can thus grab one of e1000e's MSI-X vectors. When
e1000_request_msix() then fails partway through, it returned without
freeing the vectors it had already requested; pci_disable_msix() later
tears those descriptors down while their irqaction is still attached,
leaking the /proc/irq entry.

Free the already requested IRQs on the error path.

genirq: Flags mismatch irq 28. 00200000 (eth1-tx-0) vs. 00200000 (comedi_parport)

remove_proc_entry: removing non-empty directory 'irq/27', leaking at least 'eth1-rx-0'
WARNING: fs/proc/generic.c:742 at remove_proc_entry+0x436/0x560, CPU#3: ip/445
Modules linked in:
CPU: 3 UID: 0 PID: 445 Comm: ip Not tainted 7.1.0+ #284 PREEMPT
RIP: 0010:remove_proc_entry (fs/proc/generic.c:742 (discriminator 4))
PKRU: 55555554
Call Trace:
<TASK>
unregister_irq_proc (kernel/irq/proc.c:406)
free_desc (kernel/irq/irqdesc.c:482)
irq_free_descs (kernel/irq/irqdesc.c:874 kernel/irq/irqdesc.c:865)
irq_domain_free_irqs (kernel/irq/irqdomain.c:1917)
msi_domain_free_locked.part.0 (kernel/irq/msi.c:1619 kernel/irq/msi.c:1645)
msi_domain_free_irqs_all_locked (kernel/irq/msi.c:1632)
pci_msi_teardown_msi_irqs (drivers/pci/msi/irqdomain.c:28)
pci_free_msi_irqs (drivers/pci/msi/msi.c:925)
pci_disable_msix (drivers/pci/msi/api.c:200 drivers/pci/msi/api.c:193)
e1000_request_irq (drivers/net/ethernet/intel/e1000e/netdev.c:2028)
e1000e_open (drivers/net/ethernet/intel/e1000e/netdev.c:4681)
__dev_open (net/core/dev.c:1702)
netif_change_flags (net/core/dev.c:9806)
do_setlink.isra.0 (net/core/rtnetlink.c:3207 (discriminator 1))
rtnetlink_rcv_msg (net/core/rtnetlink.c:7068)
netlink_rcv_skb (net/netlink/af_netlink.c:2556)

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 808e5cddd6a9..19b9823c5679 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2099,7 +2099,7 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 static int e1000_request_msix(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int err = 0, vector = 0;
+	int err = 0, vector = 0, i;
 
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
@@ -2111,7 +2111,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_rx, 0, adapter->rx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_free;
 	adapter->rx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->rx_ring->itr_val = adapter->itr;
@@ -2127,7 +2127,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_free;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2136,11 +2136,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_free;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_free:
+	for (i = vector - 1; i >= 0; i--)
+		free_irq(adapter->msix_entries[i].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.43.0

