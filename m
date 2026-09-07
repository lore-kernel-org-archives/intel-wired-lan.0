Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84943C79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5014B80CB6;
	Mon,  7 Sep 2026 11:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1IujzXsyLB0v; Mon,  7 Sep 2026 11:04:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E465B80C88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779077;
	b=BOlyC7lPTRpDgN+Rc0uCbTxz/OSvbp83E0AMSyfCpLfQ+LS3ga8gFjonshSZR/ZTIazn
	 9qaF6D84l7s8mr34ZawbN2C9K1GkTRDKfYqVA82cGHhUHjNo8Hif8n6ENNwZuI9BOaitK
	 gDd1VXCDNYR+30ROrdeGQR1G03CqeedpQaE8fUv002FVYVQC1W/V4acz7x0iAFQdlCoJd
	 g6JyCMboTcpM+5ISv3Fo5hKAZQyLnI5Ti/fW932pCFAJSou7VK56HRb+CU0CZFltO5bkB
	 2EqhIW68NFhmLsXgy28SY+VI/5vRj34l/2EzLw72FJTTMlrgYiG/HPziPrktxj2CH2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sGeOSz51KwuK+qqsxhiRXHNKRjK1TqL7KfgYuvd6I6E=;
	b=NFGPgDBXU+MdUOuPIf1KPJ8pmEPN2gSqvAwYQVw4N6Ve69T4G3jBy/hNBqV5Iciu2p/y
	 e/9xa1MPMb1iUGc2CItbq6JUFtzeDuP+QqW4QgkHTvRR+kv/LXKPXo0xb6aSNtHCiioMZ
	 6tm46a6ei6mRxJQutAzCHmZdPnvd4en1bUlyOYioQ7r4LXhucyk0NLWsY5HBQK6psKQnE
	 8VvaV2C5IfVrn4FhGxFH9e4ofLW/RIwU0QinsRzimRvjFNCFX1H2WYZsdCRBmWt/SZ4uf
	 RilQB1av0SXAdEfEW2b5kjtc4GUQsyyI3EutY7eeAlWvuxf+cv4CILZvRM23GYnRrtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6IM0dkw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779076;
	bh=sGeOSz51KwuK+qqsxhiRXHNKRjK1TqL7KfgYuvd6I6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qr3rrhlEQDpus1wo051ehS19kDNJyTl9hgu6viUmBDD0x9ssFiLF7spqnC5xJJHN6
	 5VsVLJndclCs8xUg6SYBKzZNDeDlWhqXThLpOx7a7anID3ZKYIIjKA1k+Lt0t0xUqG
	 oasdWW8Y9dNwiZiRYffVz5KmEkabwFz0ALDk9hV+4U0f9Q6shCYet6Oz/lBPQ+T0WF
	 g3ljn4HmKTKURUKNIlrrYpXyT3ENZ5M7bP7ybQE03lAxYJDh6IhFVecoBsmAdWor6k
	 St3a/BJ+qdEpgZe66MSBaZ4YH/7FEnca7YJhbKdSoxiv+xkmRggqZNnNagBRhGo1+B
	 FhhgQ4HAquIFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E465B80C88;
	Mon,  7 Sep 2026 11:04:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D815A9CF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C89A280CA9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdsuCiamPGR6 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4F02D80CB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779072;
 b=cBVa2xPIvNUOUEGUSMNa1v70jGRgys6PYwjjEvLqtLraEnZknNLC6XhyBr6mqonykc4t
 HkkTpeQ+5DhadgF2JPzwZw/w0BWZQ397nijGgOYSOt9daxeZ3VGMKXxVsZ19tAARLMBn7
 9YB14m9lyY1DUb5wThgk5oIuKUX3LnZg393JPp1d3LcSUV2JTJUkgbfD3/Bb2/A3VP1Me
 tFK5EPs4bVVgVVFhIJnlW1DLtvYq4Xfb4Tex8qmMxewZcG0x0hXtzFmMl1YUzPo9IhunX
 k5by9bIC9w2f5ipzuErQ49Masm0/Ey8/XCNi8FGMKrGAaL2c/+TBTL9HDzWX7bEOCpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779072;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sGeOSz51KwuK+qqsxhiRXHNKRjK1TqL7KfgYuvd6I6E=;
 b=LfKU27TntiXnj1238uiYaSqsJXQc1QWo/iiqXlUPwZHpYH9XolnLrk5Gw+ofVBHkP2iY
 0b7aqh7okm5Gn/RNDNGcAl24e75hJZAUVNLNUru/5iFni/BSoyDJa0Gd1rKfJUL9z4GPb
 5Rl55aWokxKcASZzLJqPTRoNo0ImOmmpW2zZj+YEB+RK4pH64twvCGjVvkKj+CEJ4Xptx
 uk7eAZRf2FJ5PJwULcB1DN2cc2Ynmgp2Bbvy8ETA2noGntvS0YPp0uq6Bl82KYI5qOL8G
 vp5frwRlTV1d8ZL1p2LPjA1+DSGnRubZWWhSeTVRy1fJGsTZThW85rnD1mISVzaW61g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=G6IM0dkw; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=G6IM0dkw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F02D80CB9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779073; x=1820315073;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ubLXjVaWiVEC3d9/oO0nKvNmGUPCw1jkXMrVZQDc8es=;
 b=G6IM0dkwN5O7w3Uzl8mPcSjLc8NX+oB0Gg5rQV1Ebk1y6mu8LVzvFnbS
 Xl9zrQMyJLGFl2s4Rx6vF60F2IDFv5D+pdmz4OVX/ZzZtQDWI9Z55NGdy
 W58DpXG3YvUN/knED5X3SzGccWc/WQFmv+AOf1frYUL/Y51CzQVxM8eve
 zK+571BQgXB/iS6RX5cZvDNAmT6ohxEVuO8kLGG7fgd4FRRaNoWjubHGS
 ZuBFqllG2Zdao2s4Njq+tha1dWRM0sJlb3EilWNFK8mC8uZ1SDfYnpv6q
 4ahzbVl43XyyOHVaaiibh5dpH0lvovkkYSEjV97zZyE0YAhnyoM629D+4 w==;
X-CSE-ConnectionGUID: YRUcvpfHQ6mZuocPQsCBcA==
X-CSE-MsgGUID: bpm4aHiUTjGA5cUSrJha6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214091"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214091"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:33 -0700
X-CSE-ConnectionGUID: gyKt3X3IR7m+okSZiGnBnA==
X-CSE-MsgGUID: oj3vbAX2Sgi7X+r/PYk9cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195523"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:31 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 10/10] ixd: use interrupt for mailbox communication
Date: Mon,  7 Sep 2026 12:24:17 +0200
Message-ID: <20260907102418.2697317-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
References: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Switch from polling to interrupt for invoking mailbox operations when it
is available.

Add flag to store the information about the mailbox interrupt. If
interrupt is turned off mailbox will be handled by periodic workqueue.
If it is enabled interrupt will take care of it.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixd/Kconfig        |  1 +
 drivers/net/ethernet/intel/ixd/ixd.h          | 24 +++++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h | 10 ++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      | 93 +++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  2 +
 6 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
index 0a48b3bb7bc2..69c37c2cdb67 100644
--- a/drivers/net/ethernet/intel/ixd/Kconfig
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -6,6 +6,7 @@ config IXD
 	depends on PCI_MSI
 	select LIBIE_CP
 	select LIBIE_PCI
+	select LIBIE_IRQ
 	select NET_DEVLINK
 	help
 	  This driver supports Intel(R) Control Plane PCI Function
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 4a1590f937b5..51d009167213 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -5,9 +5,20 @@
 #define _IXD_H_
 
 #include <linux/net/intel/libie/controlq.h>
+#include <linux/net/intel/libie/irq.h>
 
 #define IXD_INIT_TASK_DELAY_JIFFIES	msecs_to_jiffies(500)
 
+/**
+ * enum ixd_flags - Whole device flags
+ * @IXD_MB_INTR_MODE: Mailbox in interrupt mode
+ * @IXD_FLAGS_NBITS: Must be last
+ */
+enum ixd_flags {
+	IXD_MB_INTR_MODE,
+	IXD_FLAGS_NBITS,
+};
+
 /**
  * struct ixd_adapter - Data structure representing a CPF
  * @cp_ctx: Control plane communication context
@@ -24,6 +35,9 @@
  * @vc_ver.major: Negotiated major virtchnl version
  * @vc_ver.minor: Negotiated minor virtchnl version
  * @caps: Negotiated virtchnl capabilities
+ * @mb_irq: index and virq to track mailbox
+ * @irq: libie irq for interrupts management
+ * @flags: look at enum ixd_flags for more details
  */
 struct ixd_adapter {
 	struct libie_ctlq_ctx cp_ctx;
@@ -42,6 +56,9 @@ struct ixd_adapter {
 		u32 minor;
 	} vc_ver;
 	struct virtchnl2_get_capabilities caps;
+	struct msi_map mb_irq;
+	struct libie_irq irq;
+	DECLARE_BITMAP(flags, IXD_FLAGS_NBITS);
 };
 
 /**
@@ -55,6 +72,11 @@ static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
 	return &adapter->cp_ctx.mmio_info.pdev->dev;
 }
 
+static inline struct pci_dev *ixd_to_pdev(struct ixd_adapter *adapter)
+{
+	return adapter->cp_ctx.mmio_info.pdev;
+}
+
 void ixd_ctlq_reg_init(struct ixd_adapter *adapter,
 		       struct libie_ctlq_reg *ctlq_reg_tx,
 		       struct libie_ctlq_reg *ctlq_reg_rx);
@@ -66,5 +88,7 @@ void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
 int ixd_iomap_running_regions(struct ixd_adapter *adapter);
 bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
 				   struct libie_pci_mmio_region *reg);
+void ixd_deinit_interrupts(struct ixd_adapter *adapter);
+void ixd_mailbox_irq_enable(struct ixd_adapter *adapter);
 
 #endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
index 8712e10c8c50..43daef30689a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
@@ -134,8 +134,12 @@ void ixd_ctlq_rx_task(struct work_struct *work)
 
 	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
 
-	queue_delayed_work(system_dfl_wq, &adapter->mbx_task,
-			   IXD_CTLQ_RX_TASK_DELAY_JIFFIES);
+	if (test_bit(IXD_MB_INTR_MODE, adapter->flags))
+		/* Just re-enable irq in HW. */
+		ixd_mailbox_irq_enable(adapter);
+	else
+		queue_delayed_work(system_dfl_wq, &adapter->mbx_task,
+				   IXD_CTLQ_RX_TASK_DELAY_JIFFIES);
 
 	ixd_ctlq_recv_mb_msg(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
index 05f65dff99f6..beb485b3570f 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
+++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
@@ -31,6 +31,16 @@
 #define PF_FW_ATQH			(PF_FW_MBX + 0x20)
 #define PF_FW_ATQT			(PF_FW_MBX + 0x24)
 
+/* Interrupts */
+#define PF_GLINT_DYN_CTL_INTENA_S	0
+#define PF_GLINT_DYN_CTL_INTENA_M	BIT(PF_GLINT_DYN_CTL_INTENA_S)
+#define PF_GLINT_DYN_CTL_ITR_INDX_S	3
+#define PF_GLINT_DYN_CTL_ITR_INDX_M	GENMASK(4, 3)
+
+/* Generic registers */
+#define PF_INT_DIR_OICR_ENA		0x08406000
+#define PF_INT_DIR_OICR_ENA_M		GENMASK(31, 0)
+
 /* Reset registers */
 #define PFGEN_RTRIG_REG_LEN		2048
 #define PFGEN_RTRIG			0x08407000	/* Device resets */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index 8311f7590666..af140e684a7f 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -4,6 +4,7 @@
 #include "ixd.h"
 #include "ixd_ctlq.h"
 #include "ixd_devlink.h"
+#include "ixd_lan_regs.h"
 #include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
@@ -57,6 +58,92 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
 				       LIBIE_CTLQ_MBX_ID);
 }
 
+static irqreturn_t ixd_mailbox_irq_handler(int __always_unused irq, void *data)
+{
+	struct ixd_adapter *adapter = (struct ixd_adapter *)data;
+
+	queue_delayed_work(system_dfl_wq, &adapter->mbx_task, 0);
+
+	return IRQ_HANDLED;
+}
+
+void ixd_mailbox_irq_enable(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio = &adapter->cp_ctx.mmio_info;
+	u32 dyn_ctl = le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
+
+	writel(PF_GLINT_DYN_CTL_INTENA_M | PF_GLINT_DYN_CTL_ITR_INDX_M,
+	       libie_pci_get_mmio_addr(mmio, dyn_ctl));
+	writel(PF_INT_DIR_OICR_ENA_M,
+	       libie_pci_get_mmio_addr(mmio, PF_INT_DIR_OICR_ENA));
+}
+
+static void ixd_mailbox_irq_deinit(struct ixd_adapter *adapter)
+{
+	if (test_and_clear_bit(IXD_MB_INTR_MODE, adapter->flags)) {
+		kfree(free_irq(adapter->mb_irq.virq, adapter));
+		libie_irq_free(&adapter->irq, adapter->mb_irq);
+		/* Kick off mailbox task. */
+		queue_delayed_work(system_dfl_wq, &adapter->mbx_task, 0);
+	}
+}
+
+static int ixd_mailbox_irq_init(struct ixd_adapter *adapter)
+{
+	struct msi_map *irq = &adapter->mb_irq;
+	char *name;
+	int err;
+
+	*irq = libie_irq_alloc(&adapter->irq, LIBIE_IRQ_STATIC);
+	if (irq->index < 0)
+		return irq->index;
+
+	name = kasprintf(GFP_KERNEL, "%s-%s-%d",
+			 dev_driver_string(ixd_to_dev(adapter)), "Mailbox", 0);
+	err = request_irq(irq->virq, ixd_mailbox_irq_handler, 0, name, adapter);
+	if (err) {
+		kfree(name);
+		libie_irq_free(&adapter->irq, adapter->mb_irq);
+		dev_err(ixd_to_dev(adapter), "IRQ request for mailbox failed, error: %d\n",
+			err);
+
+		return err;
+	}
+
+	set_bit(IXD_MB_INTR_MODE, adapter->flags);
+
+	return 0;
+}
+
+void ixd_deinit_interrupts(struct ixd_adapter *adapter)
+{
+	ixd_mailbox_irq_deinit(adapter);
+	libie_irq_deinit(&adapter->irq);
+}
+
+static int ixd_init_interrupts(struct ixd_adapter *adapter)
+{
+	struct libie_irq *irq = &adapter->irq;
+	int err;
+
+	err = libie_irq_init(irq, ixd_to_pdev(adapter), 1, 1);
+	if (err)
+		return err;
+
+	err = ixd_mailbox_irq_init(adapter);
+	if (err)
+		goto free_irq;
+
+	ixd_mailbox_irq_enable(adapter);
+
+	return 0;
+
+free_irq:
+	libie_irq_deinit(irq);
+
+	return err;
+}
+
 /**
  * ixd_deinit_dflt_mbx - Deinitialize default mailbox
  * @adapter: adapter info struct
@@ -154,6 +241,12 @@ void ixd_init_task(struct work_struct *work)
 		adapter->init_task.vc_retries = 0;
 		adapter->init_task.success = true;
 		ixd_devlink_register(adapter);
+
+		err = ixd_init_interrupts(adapter);
+		if (err)
+			dev_err(ixd_to_dev(adapter),
+				"Failed to initialize interrupts: %d\n",
+				err);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 3f90b26b8989..d3e76f8bc80b 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -9,6 +9,7 @@
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
 MODULE_IMPORT_NS("LIBIE_CP");
 MODULE_IMPORT_NS("LIBIE_PCI");
+MODULE_IMPORT_NS("LIBIE_IRQ");
 MODULE_LICENSE("GPL");
 
 /**
@@ -28,6 +29,7 @@ static void ixd_remove(struct pci_dev *pdev)
 	if (adapter->xnm)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 	ixd_trigger_reset(adapter);
+	ixd_deinit_interrupts(adapter);
 	ixd_deinit_dflt_mbx(adapter);
 
 	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
-- 
2.49.0

