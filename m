Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A968DC88E50
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 814A74080A;
	Fri, 11 Sep 2026 13:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GuhvZBQTANwV; Fri, 11 Sep 2026 13:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 81F024082C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133472;
	b=NYiphBl2koQENfhJD+zbxjMXQJDE2jzRyNT3liF/SsU5LwoKW93spfJlsTihSXQsALvY
	 hsy4cwHGZHVJOV3c2wWWoiX72dCt+z9SY2AMdlXyyK/aAXs+dnWxDeKYwtwu+3v4rAiNs
	 mced2GQEjmrsnKh8PRZ17bWEJ/fafF3dp6lf9AFZ4ntc6Yi6CMdbUre1+r6qkGrCaS3/3
	 C/GMynx6sE+oM9U8OqUGnJhpqZv1CwHkoXgVPhYMqI7Vv1VqEBENpBdwzIaMkw9kf5P4h
	 lI6hRdhsgl44ZLdq/nFqBUnGrR7LVt5H+MaZ2/Uy6gZeyzEgb7wdLwnSNh+fxXsd1hA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D1UTRhfUyUIn9eF0FwnNN05ZayZFBnhVohb/07GTxcw=;
	b=soIkxrOjA8gl5/pJ/KbZPOXEH9Igoxd+V3DpoV2PFAP/dC6ZVeZzs4TSG0o4o4lYReGd
	 o+g7TjVhLL00O/C02raSDh1Pi0nHQByOS8/8T/Bf3p/+d1qEZKld3YZAaZM+kJlXai9jQ
	 TzNQzoqmqqFh3E2QrundeBkwmUhw19bCVEycFpINBbs13Z55r4WWa/fNl2LMGQUZgQXnn
	 jSZfcW8WhLjRNHxIx038ocVUUEed1izvdrZzTpA5vi4BrXpVWVtTIqzuovka9oa3d42tO
	 GlM4ewe0i2MzZaAFxAxWUCaJTGQd11bGCGgWfa8ZZ1vza6oCE9U1t2mJiOyCy9+r+NQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lpVMgm8Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133472;
	bh=D1UTRhfUyUIn9eF0FwnNN05ZayZFBnhVohb/07GTxcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5q3Fe0pFCSFLEJbLBhZ8fFlGsn7BfgZQNS4K8fVwhxGkdRpTaQtBX1eNSsmVy7X0j
	 /7mkbEyQnYS7IaD+FbHKtxdE7eJGRRjutygVAWJ4CItKIK3rk1mNPLGPnmwMy3prEu
	 tUk92o+/FFcJLAQApKGzTU4oCEcEDUOS13iHSof1LdxeKarUIYn3027IimM2A77fw9
	 kc2cT1ED9i8dcxGSogVRtIi7rQrNTEfU+hee0DS0GOjR3T2jiOe77+f+jJyEuFbLGU
	 tdpcikJQenp3pVoiUhR1WTuPvrNM8r1yL6M3NiugBq26t7xMKZXvgF6WRsfmr2PMrx
	 tHZcdbHIgfpVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81F024082C;
	Fri, 11 Sep 2026 13:31:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1625786
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A74FA4082C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DaOxSevnvcgM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B0BFC4080A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133469;
 b=idyf2jhtS0pIRbgix4eddmln2IQmCj03y3peFhDXKRBLXiydbYfiP0gcI8oKH17u9tOH
 NBJ50wV20t2ksHG84/HclvA5mTPEjFnEjCfp1p9tWPGqG3YEagPcAMnrxQjYRF4rkZsV4
 pZXY28W91SvtpobpLhJhxxO8247DVTpAGRyJ2DPdgIt0yy+J6FJpjnP917IjXG5bSugpM
 zOwQm/7ElLiX13S8M9mjle2XX1sAPnSaUhDi0kE22S+QeVmWbQ4aQuIGeSdXB3wGyzfki
 2sNfVOeS5D3tiEmge8yaAqMWBEKrBOrSrWryRwegWH9NHvcAdlpXlzrYw0rjLgi6iPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133469;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=D1UTRhfUyUIn9eF0FwnNN05ZayZFBnhVohb/07GTxcw=;
 b=RBkaeNOgRm5u//j71dxxmB4ARwtO+L7SYHnxioS+g0GgigMFfA9IAYNm1oucJmFM++Hz
 9BxYwIXvyqc18OyWHvEtFoo9TamR2vUatWV6JhfQzrKjmbM5tKwFbZaBEiG0oh45Y0YTc
 ZdHVpOpIQlW+CqulwFTPlFPSa+TtqwhQNPwgj0VrxgLqEKVU4tdQfs+t/8wZ4c9udI40d
 P5YU5h2afbGr/WN6L19s8AeRgeVpf0vmoj5fYNlL3V1i+bJ2C0K5g9mUBnb4xI1Q26uJB
 WEygX0XUt6lyKYbNQW3EFJvcGm7pREyQq/s0RDRGp86J4IUfHcDIcHDA2bsLT2NLjmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lpVMgm8Y; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lpVMgm8Y
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0BFC4080A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133470; x=1820669470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NdUyRRAq/orlglGiQ3Pqj8h/NIOiIbOnC2Y0Yq+IK6Y=;
 b=lpVMgm8YWr9JZfkLje5mpeB+fGumlmS2DSk/+BBi5+Ft8FpmGVgrM8b5
 vZmSsIYRrAhmme4begulUk2rjQIyFDy4lxH3qNe1hTCWfUsp//fwcqGOQ
 Se6Y/PBRN6adOI3ZpNlmuBPtYEMJMyRelIo2/csNIQoHX5Nk+WddZL/Uv
 7AT6Zo9Yyu/PnWHa9Exx/7aCj+SK2Uv9YXQBdXbfoceW1ewIFPCMvwj13
 gT6bNlnOM+mfYzPO4X8nZftmlciQKk45ziL4qRNOj89W5hIl5shWiJy1A
 FRUEj2++X6laXI2/TRg1oV+M2yCtX4Eqk8k4rB7r+cdrY5lsUNvGW3OUF g==;
X-CSE-ConnectionGUID: /nSaDZmhSSWE9+RXhHcrGA==
X-CSE-MsgGUID: 5pBoSn8fQryILlUDoOgR5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107548"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107548"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:30:06 -0700
X-CSE-ConnectionGUID: aZG0P84JQ0K5aLnjTKeMyA==
X-CSE-MsgGUID: ZUlasN0KSICgTmNdTqQm6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541303"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:30:05 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 10/10] ixd: use interrupt for mailbox communication
Date: Fri, 11 Sep 2026 14:49:21 +0200
Message-ID: <20260911124921.2881348-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
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
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  28 ++++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  10 ++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      | 126 ++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |   2 +
 6 files changed, 173 insertions(+), 2 deletions(-)

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
index 4a1590f937b5..ed5ffe04f48d 100644
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
@@ -24,6 +35,11 @@
  * @vc_ver.major: Negotiated major virtchnl version
  * @vc_ver.minor: Negotiated minor virtchnl version
  * @caps: Negotiated virtchnl capabilities
+ * @mb_irq: index and virq to track mailbox
+ * @irq: libie irq for interrupts management
+ * @mb_dyn_ctl: mailbox dynamic control register address
+ * @oicr_ena: direct OICR enable register address
+ * @flags: look at enum ixd_flags for more details
  */
 struct ixd_adapter {
 	struct libie_ctlq_ctx cp_ctx;
@@ -42,6 +58,11 @@ struct ixd_adapter {
 		u32 minor;
 	} vc_ver;
 	struct virtchnl2_get_capabilities caps;
+	struct msi_map mb_irq;
+	struct libie_irq irq;
+	void __iomem *mb_dyn_ctl;
+	void __iomem *oicr_ena;
+	DECLARE_BITMAP(flags, IXD_FLAGS_NBITS);
 };
 
 /**
@@ -55,6 +76,11 @@ static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
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
@@ -66,5 +92,7 @@ void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
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
index 58e58c75981b..b924ada5f831 100644
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
index 8311f7590666..e13614603a9e 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -4,6 +4,7 @@
 #include "ixd.h"
 #include "ixd_ctlq.h"
 #include "ixd_devlink.h"
+#include "ixd_lan_regs.h"
 #include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
@@ -57,6 +58,125 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
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
+	writel(PF_GLINT_DYN_CTL_INTENA_M | PF_GLINT_DYN_CTL_ITR_INDX_M,
+	       adapter->mb_dyn_ctl);
+	writel(PF_INT_DIR_OICR_ENA_M, adapter->oicr_ena);
+}
+
+static void ixd_mailbox_irq_disable(struct ixd_adapter *adapter)
+{
+	/* Clear INTENA, keep the ITR index pointing to the no update one. */
+	writel(PF_GLINT_DYN_CTL_ITR_INDX_M, adapter->mb_dyn_ctl);
+	writel(0, adapter->oicr_ena);
+}
+
+static int ixd_mailbox_irq_regs_init(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio = &adapter->cp_ctx.mmio_info;
+	u32 dyn_ctl = le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
+
+	adapter->mb_dyn_ctl = libie_pci_get_mmio_addr(mmio, dyn_ctl);
+	adapter->oicr_ena = libie_pci_get_mmio_addr(mmio, PF_INT_DIR_OICR_ENA);
+
+	if (!adapter->mb_dyn_ctl || !adapter->oicr_ena)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ixd_mailbox_irq_deinit(struct ixd_adapter *adapter)
+{
+	if (!test_and_clear_bit(IXD_MB_INTR_MODE, adapter->flags))
+		return;
+
+	ixd_mailbox_irq_disable(adapter);
+
+	/* The mailbox task re-arms the interrupt, make sure it isn't running
+	 * anymore before the irq line is freed.
+	 */
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
+	kfree(free_irq(adapter->mb_irq.virq, adapter));
+	libie_irq_free(&adapter->irq, adapter->mb_irq);
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
+	if (!name) {
+		libie_irq_free(&adapter->irq, adapter->mb_irq);
+
+		return -ENOMEM;
+	}
+
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
+	err = ixd_mailbox_irq_regs_init(adapter);
+	if (err)
+		goto free_irq;
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
@@ -154,6 +274,12 @@ void ixd_init_task(struct work_struct *work)
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
index 488a919f3b1b..e83550da3e9a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -9,6 +9,7 @@
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
 MODULE_IMPORT_NS("LIBIE_CP");
 MODULE_IMPORT_NS("LIBIE_PCI");
+MODULE_IMPORT_NS("LIBIE_IRQ");
 MODULE_LICENSE("GPL");
 
 /**
@@ -25,6 +26,7 @@ static void ixd_remove(struct pci_dev *pdev)
 	ixd_devlink_unregister(adapter);
 
 	/* Leave the device clean on exit */
+	ixd_deinit_interrupts(adapter);
 	if (adapter->xnm)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 	ixd_trigger_reset(adapter);
-- 
2.49.0

