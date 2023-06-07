Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F225EC7EE2F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Jun 2023 01:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EE2840280;
	Wed,  7 Jun 2023 01:58:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EE2840280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686103096;
	bh=KeunC9XFDF5scf8Tt1kkQ7x0T6iU3pdUgO7BDhDiirg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ztFKRVD/CmZaaLNcKY9fQTZlSS/EAUp23tpuXKsYks1ndd/m6MJzuRvZvh9YKmF9f
	 RgwG3eaC0gikqw6WupPSlUUh+CHIGaXkaZbxkLbjyksLVSarjEFF6i25lTWWZ7UBcJ
	 6lYAFQiyYZCYi7cGiexEQce2QT9/K+nJ8C9EbjJPcs8WluZ8ArfSN2rUmOyozQrVee
	 EbdMz8lM0Iite2Bs/pzwAoje/9d3/hhbu94fGX95PQm86+D24JTkjzV1Lz8zevDXXp
	 8HzRQCOkWbRhMQIwRJe1jmL/wCFmUnxZP3yPR2O9r8OmU5X3Y6h2jocNNwHSAhCTqE
	 tPJLyi1Cap84g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQRYWTPNzikb; Wed,  7 Jun 2023 01:58:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C16B405D4;
	Wed,  7 Jun 2023 01:58:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C16B405D4
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 39F6C1BF2C8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Jun 2023 01:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11BC060D4C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Jun 2023 01:58:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11BC060D4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r82KHFfeJccF for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Jun 2023 01:58:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A563D60B5D
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A563D60B5D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Jun 2023 01:58:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [222.129.46.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A3D7341E1B; 
 Wed,  7 Jun 2023 01:58:05 +0000 (UTC)
From: Aaron Ma <aaron.ma@canonical.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jgarzik@redhat.com>,
 Auke Kok <auke-jan.h.kok@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed,  7 Jun 2023 09:56:46 +0800
Message-Id: <20230607015646.558534-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526163001.67626-1-aaron.ma@canonical.com>
References: <20230526163001.67626-1-aaron.ma@canonical.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20210705; t=1686103089;
 bh=9jQwoFHBV0DDoVB44LwqGLuFZFu+qgP0qrXPp4Wffu4=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=qQ/7P+1fG3bdkLmOfMffEJDAFJg1UOD71vAaX0HtvAtd6KnqmSKjcJgagsJOOkFfK
 6f7G0eINeEvzyXgCRAZj2eWFI2ZNj7W6MdOR0WOZP04KqKC5EayxXfd8Bmw4ZPByn7
 hcePI1re75lB4FLgCrLn7vtCG4TaK2qV9o+XknnNdoGOrctWq6Klc7PfB6qrRwKiQV
 RBkjiW1tonKq2vANjoqlnDN0OAwksJNysvzthBYnjJF05oTxgdnlcvRGmFfZY9SUUp
 WFS9KuYV1nQhSD0MZqa/HgRazR5nmPa622ADsNC5hmPttMgiohNrNBY+9nfRuKEvnN
 CBjZmQOp3pGdQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=qQ/7P+1f
Subject: [Intel-wired-lan] [PATCH net v2] igb: fix hang issue of AER error
 during resume
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PCIe AER error_detected caused a race issue with igb_resume.
Protect error_detected when igb is in down state.

Error logs:
kernel: igb 0000:02:00.0: disabling already-disabled device
kernel: WARNING: CPU: 0 PID: 277 at drivers/pci/pci.c:2248 pci_disable_device+0xc4/0xf0
kernel: RIP: 0010:pci_disable_device+0xc4/0xf0
kernel: Call Trace:
kernel:  <TASK>
kernel:  igb_io_error_detected+0x3e/0x60
kernel:  report_error_detected+0xd6/0x1c0
kernel:  ? __pfx_report_normal_detected+0x10/0x10
kernel:  report_normal_detected+0x16/0x30
kernel:  pci_walk_bus+0x74/0xa0
kernel:  pcie_do_recovery+0xb9/0x340
kernel:  ? __pfx_aer_root_reset+0x10/0x10
kernel:  aer_process_err_devices+0x168/0x220
kernel:  aer_isr+0x1b5/0x1e0
kernel:  ? __pfx_irq_thread_fn+0x10/0x10
kernel:  irq_thread_fn+0x21/0x70
kernel:  irq_thread+0xf8/0x1c0
kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
kernel:  ? __pfx_irq_thread+0x10/0x10
kernel:  kthread+0xef/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x29/0x50
kernel:  </TASK>
kernel: ---[ end trace 0000000000000000 ]---

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217446
Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Reviewed-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
V1->V2: Add target tree tag net and Fixes tag.

 drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 58872a4c2540..8333d4ac8169 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9581,14 +9581,21 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
 	if (netif_running(netdev))
 		igb_down(adapter);
 	pci_disable_device(pdev);
+	rtnl_unlock();
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
