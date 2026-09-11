Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023FCC88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBFA440607;
	Fri, 11 Sep 2026 13:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvOrz_3DFEGZ; Fri, 11 Sep 2026 13:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E68A940811
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133465;
	b=g/e9to+1Bid/p3OH6TgyG7uqXy79vRw7lMvZuhWNgYHtQNUnrxmcVLqpP+Rza01EYS5F
	 VC9xes8obTds/INHIIV2TwF8JRB+R6pVOfs61RNqM+bEv8uZbaKgiHSmGTe9rlPyDDYy5
	 S0CmY2nD0+yrTh5+e4gUCttXvMbvEOSgRJPMw7Or4xYF7avUqasxGIDenXETFdH2dd+tB
	 va7kbuBmir8mEo7eMf+3JlVd2k6YoqyYMZPscIlYO5UXQCY2rNRofP6si4aJkBbLY32xl
	 TWSLmqJV5sjZgoOAEWuduzL98W9W4palG1nXqOiP8U5sB+aliGdKU8CLfRKVcaVNjLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+YjmjPe+Oscar9zEd7ypSMUzcnaoAa3/B0pAyVR7mdQ=;
	b=i2lM/knhKZFr/ksLPnuWICbvANHyTmsJNY/LJvk1nnM+2ihR4OnxMZZTv9yvO1/4J3Xk
	 tltOiEFf/2lH4kSq4cfRui1D2joyyFcaEmJRrAvdEyCwhIlTy+TamFRocfp76BVzuknc4
	 Kn0OpXM0l28QIXeoaeMsK3/v6Ynfy2FfNPc2kd7+rkMuZvhQ26NYfe6Kyi10etQbWwIyM
	 +T9y4nTleHa5SNBeHtzc3Ew5F3yd7jUlKz48Oe6WuPpuATdf0fdnVO2cbWVkUKJ/mRNjE
	 5pcIbwkTeIU44csZ516E6rklUtR7tLSmQv0/8fHsJfn88A6iwg4J62Yo7wZB2+Xy7yg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jX6N0As+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133465;
	bh=+YjmjPe+Oscar9zEd7ypSMUzcnaoAa3/B0pAyVR7mdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x9M+f3PHPb5Odpe4a3GuUcmVUBxIr23D9YCIK23hjA7LIB0klpznXiUSr514a+N8X
	 dObRA3Re9P//VSDTX/XoknNc07IfqQfhj6Hw9mzzmfExglucN4hNiqzdMVfREkt0pj
	 xyCi7Au9/uZqgGg5rnYA93u7BXx2X3hfuGJ+IyUUqfu7WGjU+h0i6tYRjQI7gY04Yk
	 f533qAPZjt3LAgaMNRWrbyXSTYprrfEDZbiTTzHkjVvNtZ0dv/tGlvvnf7WA3cFDv5
	 mpCM4CG/VJQv5MOfs76qnbrctVXKbKBgdUFziV4xZR9qthctSLQjJYFw5IzXrXr0Dg
	 Oh262bd9WRbJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E68A940811;
	Fri, 11 Sep 2026 13:31:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 475D332F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4409040811
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bjbw37p5rdcJ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF8C34080A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133460;
 b=pc9WlGuUgT1of13MqzPK2dDyWclnRZXuj36HcbwFqaGFlUTU6dK8iiK0TcNxL1sXXNs6
 L4/gamlvc0wXdSJG9n+5LUh8WPJLs0lCR6q7Q42TqvaBJnhttPqNZMRgRdO0heYskBUdU
 mPtUMQzvsOLB+MVKMC4ShItFiDnkkjn79+sJdAKmhd4yNCncqqZDbJDhX1Ho4QFHVFYSm
 6DDZIEBOlDYWLH3ixk2dwpmkoK7554p6v7MLKC9WaDDLHZP2PcrTV0FKSBCdcYhWfKiws
 odMTCdGyj0KIUgZj32RfsZfczUTxqByJHLj1oK9lSf9mJhu+9k3Tt4DZtN/eq1rkpcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133460;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+YjmjPe+Oscar9zEd7ypSMUzcnaoAa3/B0pAyVR7mdQ=;
 b=ZkY1oZ1OhBV8kf1zp4L6AsEl7BDh2K+D17Vry5UFWa/bLSwwoJqFbhr6yN4DiI7yvltJ
 T85t19S07szirsdhKn2g9a+NWw3voL7WlRuduxz0O/XAao82extUy3SmhXo0EEajM78eZ
 Dcrv0jIm++Qc9wTBzyy/aAmuZL8Bf6UzaQK4fqWakV7QKxjsRMv4V1sg4kcwrbLd64Gj4
 K+0wiyslcKqPzUqvVvMTOQCrl5NnivGtC+TIXihHCCuFbxxoPZDbWwkhW/tx8E4814NNX
 NFJQ3fiRaYf64Xlaw2cVOUVV/PBu2o0KyoNmvuPPPsaZ/iCsWgqkWRkpCEKuKyeusBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jX6N0As+; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jX6N0As+
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF8C34080A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133461; x=1820669461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P9riWv2boXkLk6zLxoN0CsIzKmkwvBfb3zPBHEmxYQ8=;
 b=jX6N0As+6QzwtIC/sRSitRu+RNUbSDBNTU0nfLvwezj3uilQSPGdh6uP
 4RbYxJ3DS+UvRmvYAzjJ6QSkTJWGiGRQfW4xJf9An/fa++wyto3F4DbNs
 EUHqTRXrvikOzzgKx/NLoYio6wYmef8Umbf630U1PvtssDHYBmspEdQpE
 6PssAqpkv3dB7l1wWekXmq+IuxOGtiontpCZJrxFwCD3VRRt8dpLPqMUb
 GR0mWQeOV0AmqsKtHVs96bZQkY8zOcCXGugcZzrPbsl798YQ/a/4bPIrW
 8pELe/tVnP3Ov3KL9gT4MjfY1g6Ls68ExxJX79R00OPXFIKGpelRxDC3L w==;
X-CSE-ConnectionGUID: zqZDNcCYRmKE/3nCN+1h6A==
X-CSE-MsgGUID: uuJtyXhiQ2CQXKPfxj2hTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107534"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107534"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:29:59 -0700
X-CSE-ConnectionGUID: wdHPv80PT8CLFjOqENIngQ==
X-CSE-MsgGUID: FDg7PDC0T2uYrms221QY1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541281"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:57 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH iwl-next v2 05/10] libie, idpf: move irq code to libie
Date: Fri, 11 Sep 2026 14:49:16 +0200
Message-ID: <20260911124921.2881348-6-michal.swiatkowski@linux.intel.com>
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

Management of irqs is the same in idpf and ixd driver. Move the common
code to separate lib to reuse it in ixd.

libie_irq keeps the allocated interrupts in an xarray split into two
index ranges: LIBIE_IRQ_STATIC for the vectors that must exist for the
device to be functional at all (mailbox, the minimum per default vport,
RDMA), and LIBIE_IRQ_DYNAMIC for the rest.

libie_irq_init() allocates the static range with pci_alloc_irq_vectors()
at probe.  When the platform supports post-enable MSI-X allocation,
libie_irq_alloc() backs the dynamic range with pci_msix_alloc_irq_at()
on demand, so vectors are only claimed once a vport actually needs them;
when it does not, the whole range is allocated up front and
LIBIE_IRQ_DYNAMIC is transparently served from the static pool.

libie_irq_reserve() hands out an index without an MSI-X vector behind it,
for queues that are mapped to a vector but never raise an interrupt
(the idpf NOIRQ vector used by XDP send queues).

Move getting irq slot before allocating q_vectors array. Alloc only
q_vectors for which there is an available interrupt.

Allocating more lead to the situation where there are unused q_vector
which can be confused.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  74 +---
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 382 ++++++------------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 104 +++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  45 +--
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +-
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/libie/irq.c        | 256 ++++++++++++
 include/linux/net/intel/libie/irq.h           |  75 ++++
 13 files changed, 560 insertions(+), 401 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/irq.c
 create mode 100644 include/linux/net/intel/libie/irq.h

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 586df3a4afe9..6e21e4749904 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -8,6 +8,7 @@ config IDPF
 	select DIMLIB
 	select LIBIE_CP
 	select LIBETH_XDP
+	select LIBIE_IRQ
 	help
 	  This driver supports Intel(R) Infrastructure Data Path Function
 	  devices.
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 785d551c795d..51f447135693 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -24,6 +24,7 @@ struct idpf_rss_data;
 #include <linux/net/intel/iidc_rdma.h>
 #include <linux/net/intel/iidc_rdma_idpf.h>
 #include <linux/net/intel/libie/controlq.h>
+#include <linux/net/intel/libie/irq.h>
 #include <linux/net/intel/virtchnl2.h>
 
 #include "idpf_txrx.h"
@@ -299,7 +300,6 @@ struct idpf_fsteer_fltr {
  * struct idpf_q_vec_rsrc - handle for queue and vector resources
  * @dev: device pointer for DMA mapping
  * @q_vectors: array of queue vectors
- * @q_vector_idxs: starting index of queue vectors
  * @num_q_vectors: number of IRQ vectors allocated
  * @noirq_v_idx: software IRQ index used to get hardware vector information
  * @noirq_dyn_ctl_ena: value to write to the above to enable it
@@ -328,7 +328,6 @@ struct idpf_fsteer_fltr {
 struct idpf_q_vec_rsrc {
 	struct device		*dev;
 	struct idpf_q_vector	*q_vectors;
-	u16			*q_vector_idxs;
 	u16			num_q_vectors;
 	u16			noirq_v_idx;
 	u32			noirq_dyn_ctl_ena;
@@ -526,46 +525,6 @@ struct idpf_avail_queue_info {
 	u16 avail_complq;
 };
 
-/**
- * struct idpf_vector_info - Utility structure to pass function arguments as a
- *			     structure
- * @num_req_vecs: Vectors required based on the number of queues updated by the
- *		  user via ethtool
- * @num_curr_vecs: Current number of vectors, must be >= @num_req_vecs
- * @index: Relative starting index for vectors
- * @default_vport: Vectors are for default vport
- */
-struct idpf_vector_info {
-	u16 num_req_vecs;
-	u16 num_curr_vecs;
-	u16 index;
-	bool default_vport;
-};
-
-/**
- * struct idpf_vector_lifo - Stack to maintain vector indexes used for vector
- *			     distribution algorithm
- * @top: Points to stack top i.e. next available vector index
- * @base: Always points to start of the free pool
- * @size: Total size of the vector stack
- * @vec_idx: Array to store all the vector indexes
- *
- * Vector stack maintains all the relative vector indexes at the *adapter*
- * level. This stack is divided into 2 parts, first one is called as 'default
- * pool' and other one is called 'free pool'.  Vector distribution algorithm
- * gives priority to default vports in a way that at least IDPF_MIN_Q_VEC
- * vectors are allocated per default vport and the relative vector indexes for
- * those are maintained in default pool. Free pool contains all the unallocated
- * vector indexes which can be allocated on-demand basis. Mailbox vector index
- * is maintained in the default pool of the stack.
- */
-struct idpf_vector_lifo {
-	u16 top;
-	u16 base;
-	u16 size;
-	u16 *vec_idx;
-};
-
 /**
  * struct idpf_queue_id_reg_chunk - individual queue ID and register chunk
  * @qtail_reg_start: queue tail register offset
@@ -652,6 +611,18 @@ struct idpf_irq_info {
 	int num;
 };
 
+/**
+ * struct idpf_rdma_irq - RDMA interrupt vectors data
+ * @entries: MSIX table shared with the RDMA auxiliary device
+ * @map: libie IRQ mappings corresponding to @entries
+ * @num: number of vectors granted for RDMA
+ */
+struct idpf_rdma_irq {
+	struct msix_entry *entries;
+	struct msi_map *map;
+	u16 num;
+};
+
 /**
  * struct idpf_adapter - Device data struct generated on probe
  * @pdev: PCI device struct given on probe
@@ -666,14 +637,11 @@ struct idpf_irq_info {
  * @asq: Send control queue info
  * @arq: Receive control queue info
  * @xnm: Xn transaction manager
- * @num_avail_msix: Available number of MSIX vectors
- * @num_msix_entries: Number of entries in MSIX table
- * @num_rdma_msix_entries: Available number of MSIX vectors for RDMA
- * @rdma_msix_entries: RDMA MSIX table
+ * @rdma_irq: RDMA interrupt vectors data
+ * @irq: libie irq structure
  * @irq_info: hardware data needed to setup irq
  * @req_vec_chunks: Requested vector chunk data
  * @mb_vector: Mailbox vector data
- * @vector_stack: Stack to store the msix vector indexes
  * @irq_mb_handler: Handler for hard interrupt for mailbox
  * @tx_timeout_count: Number of TX timeouts that have occurred
  * @avail_queues: Device given queue limits
@@ -706,7 +674,6 @@ struct idpf_irq_info {
  * @req_tx_splitq: TX split or single queue model to request
  * @req_rx_splitq: RX split or single queue model to request
  * @vport_ctrl_lock: Lock to protect the vport control flow
- * @vector_lock: Lock to protect vector distribution
  * @queue_lock: Lock to protect queue distribution
  * @vc_buf_lock: Lock to protect virtchnl buffer
  * @ptp: Storage for PTP-related data
@@ -725,14 +692,11 @@ struct idpf_adapter {
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
 	struct libie_ctlq_xn_manager *xnm;
-	u16 num_avail_msix;
-	u16 num_msix_entries;
-	u16 num_rdma_msix_entries;
-	struct msix_entry *rdma_msix_entries;
+	struct idpf_rdma_irq rdma_irq;
+	struct libie_irq irq;
 	struct virtchnl2_alloc_vectors *req_vec_chunks;
 	struct idpf_irq_info irq_info;
 	struct idpf_q_vector mb_vector;
-	struct idpf_vector_lifo vector_stack;
 	irqreturn_t (*irq_mb_handler)(int irq, void *data);
 
 	u32 tx_timeout_count;
@@ -770,7 +734,6 @@ struct idpf_adapter {
 	bool req_rx_splitq;
 
 	struct mutex vport_ctrl_lock;
-	struct mutex vector_lock;
 	struct mutex queue_lock;
 	struct mutex vc_buf_lock;
 
@@ -1031,9 +994,6 @@ u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
 int idpf_initiate_soft_reset(struct idpf_vport *vport,
 			     enum idpf_vport_reset_cause reset_cause);
 void idpf_deinit_task(struct idpf_adapter *adapter);
-int idpf_req_rel_vector_indexes(struct idpf_adapter *adapter,
-				u16 *q_vector_idxs,
-				struct idpf_vector_info *vec_info);
 void idpf_set_ethtool_ops(struct net_device *netdev);
 void idpf_vport_intr_write_itr(struct idpf_q_vector *q_vector,
 			       u16 itr, bool tx);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b6cd1c25ae5d..5d15bef6eec3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -396,14 +396,14 @@ idpf_idc_init_msix_data(struct idpf_adapter *adapter)
 	struct iidc_rdma_core_dev_info *cdev_info;
 	struct iidc_rdma_priv_dev_info *privd;
 
-	if (!adapter->rdma_msix_entries)
+	if (!adapter->rdma_irq.entries)
 		return;
 
 	cdev_info = adapter->cdev_info;
 	privd = cdev_info->iidc_priv;
 
-	privd->msix_entries = adapter->rdma_msix_entries;
-	privd->msix_count = adapter->num_rdma_msix_entries;
+	privd->msix_entries = adapter->rdma_irq.entries;
+	privd->msix_count = adapter->rdma_irq.num;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5a2975081227..ddd1dff391e0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -9,56 +9,85 @@
 
 static const struct net_device_ops idpf_netdev_ops;
 
-/**
- * idpf_init_vector_stack - Fill the MSIX vector stack with vector index
- * @adapter: private data struct
- *
- * Return 0 on success, error on failure
- */
-static int idpf_init_vector_stack(struct idpf_adapter *adapter)
+static int idpf_rdma_intr_init(struct idpf_adapter *adapter, u16 num)
 {
-	struct idpf_vector_lifo *stack;
-	u16 min_vec;
-	u32 i;
-
-	mutex_lock(&adapter->vector_lock);
-	min_vec = adapter->num_msix_entries - adapter->num_avail_msix;
-	stack = &adapter->vector_stack;
-	stack->size = adapter->num_msix_entries;
-	/* set the base and top to point at start of the 'free pool' to
-	 * distribute the unused vectors on-demand basis
-	 */
-	stack->base = min_vec;
-	stack->top = min_vec;
+	struct idpf_rdma_irq *rdma_irq = &adapter->rdma_irq;
+	int i;
 
-	stack->vec_idx = kcalloc(stack->size, sizeof(u16), GFP_KERNEL);
-	if (!stack->vec_idx) {
-		mutex_unlock(&adapter->vector_lock);
+	if (!idpf_is_rdma_cap_ena(adapter))
+		return 0;
 
+	rdma_irq->entries = kzalloc_objs(struct msix_entry, num);
+	if (!rdma_irq->entries)
 		return -ENOMEM;
+
+	rdma_irq->map = kzalloc_objs(struct msi_map, num);
+	if (!rdma_irq->map) {
+		kfree(rdma_irq->entries);
+		rdma_irq->entries = NULL;
+
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < min(IDPF_MIN_RDMA_VEC, num); i++) {
+		struct msi_map map = libie_irq_alloc(&adapter->irq,
+						     LIBIE_IRQ_STATIC);
+		if (map.index < 0) {
+			for (int j = i - 1; j >= 0; j--)
+				libie_irq_free(&adapter->irq, rdma_irq->map[j]);
+
+			kfree(rdma_irq->map);
+			rdma_irq->map = NULL;
+			kfree(rdma_irq->entries);
+			rdma_irq->entries = NULL;
+
+			return -EINVAL;
+		}
+
+		rdma_irq->map[i] = map;
+		rdma_irq->entries[i].entry =
+			adapter->irq_info.vectors[map.index].idx;
+		rdma_irq->entries[i].vector = map.virq;
+	}
+	for (; i < num; i++) {
+		struct msi_map map = libie_irq_alloc(&adapter->irq,
+						     LIBIE_IRQ_DYNAMIC);
+
+		/* Lower number of entries if alloc fails. */
+		if (map.index < 0)
+			break;
+
+		rdma_irq->map[i] = map;
+		rdma_irq->entries[i].entry =
+			adapter->irq_info.vectors[map.index].idx;
+		rdma_irq->entries[i].vector = map.virq;
 	}
 
-	for (i = 0; i < stack->size; i++)
-		stack->vec_idx[i] = i;
+	rdma_irq->num = i;
 
-	mutex_unlock(&adapter->vector_lock);
+	if (i != num)
+		dev_warn(&adapter->pdev->dev,
+			 "Warning: %d RDMA vectors requested, %d granted\n",
+			 num, i);
 
 	return 0;
 }
 
-/**
- * idpf_deinit_vector_stack - zero out the MSIX vector stack
- * @adapter: private data struct
- */
-static void idpf_deinit_vector_stack(struct idpf_adapter *adapter)
+static void idpf_rdma_intr_free(struct idpf_adapter *adapter)
 {
-	struct idpf_vector_lifo *stack;
+	struct idpf_rdma_irq *rdma_irq = &adapter->rdma_irq;
+
+	if (!idpf_is_rdma_cap_ena(adapter))
+		return;
+
+	for (int i = 0; i < rdma_irq->num; i++)
+		libie_irq_free(&adapter->irq, rdma_irq->map[i]);
 
-	mutex_lock(&adapter->vector_lock);
-	stack = &adapter->vector_stack;
-	kfree(stack->vec_idx);
-	stack->vec_idx = NULL;
-	mutex_unlock(&adapter->vector_lock);
+	kfree(rdma_irq->map);
+	rdma_irq->map = NULL;
+	kfree(rdma_irq->entries);
+	rdma_irq->entries = NULL;
+	rdma_irq->num = 0;
 }
 
 /**
@@ -74,6 +103,7 @@ void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
 		return;
 
 	kfree(free_irq(adapter->mb_vector.irq.virq, adapter));
+	libie_irq_free(&adapter->irq, adapter->mb_vector.irq);
 	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
 }
 
@@ -84,11 +114,9 @@ void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
 void idpf_intr_rel(struct idpf_adapter *adapter)
 {
 	idpf_mb_intr_rel_irq(adapter);
-	pci_free_irq_vectors(adapter->pdev);
+	idpf_rdma_intr_free(adapter);
+	libie_irq_deinit(&adapter->irq);
 	idpf_send_dealloc_vectors_msg(adapter);
-	idpf_deinit_vector_stack(adapter);
-	kfree(adapter->rdma_msix_entries);
-	adapter->rdma_msix_entries = NULL;
 }
 
 /**
@@ -151,152 +179,22 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
  */
 static int idpf_mb_intr_init(struct idpf_adapter *adapter)
 {
-	struct msi_map *mb_irq = &adapter->mb_vector.irq;
+	struct idpf_q_vector *mb_vector = &adapter->mb_vector;
+	int err;
+
+	mb_vector->irq = libie_irq_alloc(&adapter->irq, LIBIE_IRQ_STATIC);
 
-	mb_irq->index = IDPF_MBX_IRQ_INDEX;
-	mb_irq->virq = pci_irq_vector(adapter->pdev, mb_irq->index);
-	if (mb_irq->virq < 0)
-		return mb_irq->virq;
+	if (mb_vector->irq.index < 0)
+		return mb_vector->irq.index;
 
 	adapter->dev_ops.reg_ops.mb_intr_reg_init(adapter);
 	adapter->irq_mb_handler = idpf_mb_intr_clean;
 
-	return idpf_mb_intr_req_irq(adapter);
-}
-
-/**
- * idpf_vector_lifo_push - push MSIX vector index onto stack
- * @adapter: private data struct
- * @vec_idx: vector index to store
- */
-static int idpf_vector_lifo_push(struct idpf_adapter *adapter, u16 vec_idx)
-{
-	struct idpf_vector_lifo *stack = &adapter->vector_stack;
-
-	lockdep_assert_held(&adapter->vector_lock);
-
-	if (stack->top == stack->base) {
-		dev_err(&adapter->pdev->dev, "Exceeded the vector stack limit: %d\n",
-			stack->top);
-		return -EINVAL;
-	}
-
-	stack->vec_idx[--stack->top] = vec_idx;
-
-	return 0;
-}
-
-/**
- * idpf_vector_lifo_pop - pop MSIX vector index from stack
- * @adapter: private data struct
- */
-static int idpf_vector_lifo_pop(struct idpf_adapter *adapter)
-{
-	struct idpf_vector_lifo *stack = &adapter->vector_stack;
-
-	lockdep_assert_held(&adapter->vector_lock);
-
-	if (stack->top == stack->size) {
-		dev_err(&adapter->pdev->dev, "No interrupt vectors are available to distribute!\n");
-
-		return -EINVAL;
-	}
-
-	return stack->vec_idx[stack->top++];
-}
-
-/**
- * idpf_vector_stash - Store the vector indexes onto the stack
- * @adapter: private data struct
- * @q_vector_idxs: vector index array
- * @vec_info: info related to the number of vectors
- *
- * This function is a no-op if there are no vectors indexes to be stashed
- */
-static void idpf_vector_stash(struct idpf_adapter *adapter, u16 *q_vector_idxs,
-			      struct idpf_vector_info *vec_info)
-{
-	int i, base = 0;
-	u16 vec_idx;
-
-	lockdep_assert_held(&adapter->vector_lock);
-
-	if (!vec_info->num_curr_vecs)
-		return;
-
-	/* For default vports, no need to stash vector allocated from the
-	 * default pool onto the stack
-	 */
-	if (vec_info->default_vport)
-		base = IDPF_MIN_Q_VEC;
-
-	for (i = vec_info->num_curr_vecs - 1; i >= base ; i--) {
-		vec_idx = q_vector_idxs[i];
-		idpf_vector_lifo_push(adapter, vec_idx);
-		adapter->num_avail_msix++;
-	}
-}
-
-/**
- * idpf_req_rel_vector_indexes - Request or release MSIX vector indexes
- * @adapter: driver specific private structure
- * @q_vector_idxs: vector index array
- * @vec_info: info related to the number of vectors
- *
- * This is the core function to distribute the MSIX vectors acquired from the
- * OS. It expects the caller to pass the number of vectors required and
- * also previously allocated. First, it stashes previously allocated vector
- * indexes on to the stack and then figures out if it can allocate requested
- * vectors. It can wait on acquiring the mutex lock. If the caller passes 0 as
- * requested vectors, then this function just stashes the already allocated
- * vectors and returns 0.
- *
- * Returns actual number of vectors allocated on success, error value on failure
- * If 0 is returned, implies the stack has no vectors to allocate which is also
- * a failure case for the caller
- */
-int idpf_req_rel_vector_indexes(struct idpf_adapter *adapter,
-				u16 *q_vector_idxs,
-				struct idpf_vector_info *vec_info)
-{
-	u16 num_req_vecs, num_alloc_vecs = 0, max_vecs;
-	struct idpf_vector_lifo *stack;
-	int i, j, vecid;
-
-	mutex_lock(&adapter->vector_lock);
-	stack = &adapter->vector_stack;
-	num_req_vecs = vec_info->num_req_vecs;
-
-	/* Stash interrupt vector indexes onto the stack if required */
-	idpf_vector_stash(adapter, q_vector_idxs, vec_info);
-
-	if (!num_req_vecs)
-		goto rel_lock;
-
-	if (vec_info->default_vport) {
-		/* As IDPF_MIN_Q_VEC per default vport is put aside in the
-		 * default pool of the stack, use them for default vports
-		 */
-		j = vec_info->index * IDPF_MIN_Q_VEC + IDPF_MBX_Q_VEC;
-		for (i = 0; i < IDPF_MIN_Q_VEC; i++) {
-			q_vector_idxs[num_alloc_vecs++] = stack->vec_idx[j++];
-			num_req_vecs--;
-		}
-	}
-
-	/* Find if stack has enough vector to allocate */
-	max_vecs = min(adapter->num_avail_msix, num_req_vecs);
-
-	for (j = 0; j < max_vecs; j++) {
-		vecid = idpf_vector_lifo_pop(adapter);
-		q_vector_idxs[num_alloc_vecs++] = vecid;
-	}
-	adapter->num_avail_msix -= max_vecs;
-
-rel_lock:
-	mutex_unlock(&adapter->vector_lock);
+	err = idpf_mb_intr_req_irq(adapter);
+	if (err)
+		libie_irq_free(&adapter->irq, mb_vector->irq);
 
-	return num_alloc_vecs;
+	return err;
 }
 
 /**
@@ -307,26 +205,24 @@ int idpf_req_rel_vector_indexes(struct idpf_adapter *adapter,
  */
 int idpf_intr_req(struct idpf_adapter *adapter)
 {
-	int num_rdma_vecs = 0, min_rdma_vecs = 0, num_lan_vecs = 0;
 	u16 default_vports = idpf_get_default_vports(adapter);
-	int min_vectors, actual_vecs, min_lan_vecs, err;
-	int num_q_vecs, total_vecs;
-	int i;
+	int num_q_vecs, total_vecs, static_vecs;
+	struct libie_irq *irq = &adapter->irq;
+	int num_rdma_vecs = 0;
+	int err;
 
 	total_vecs = idpf_get_reserved_vecs(adapter);
 	if (idpf_is_rdma_cap_ena(adapter)) {
 		num_rdma_vecs = idpf_get_reserved_rdma_vecs(adapter);
-		min_rdma_vecs = IDPF_MIN_RDMA_VEC;
-
 		if (!num_rdma_vecs) {
 			/* If idpf_get_reserved_rdma_vecs is 0, vectors are
 			 * pulled from the LAN pool.
 			 */
-			num_rdma_vecs = min_rdma_vecs;
-		} else if (num_rdma_vecs < min_rdma_vecs) {
+			num_rdma_vecs = IDPF_MIN_RDMA_VEC;
+		} else if (num_rdma_vecs < IDPF_MIN_RDMA_VEC) {
 			dev_err(&adapter->pdev->dev,
 				"Not enough vectors reserved for RDMA (min: %u, current: %u)\n",
-				min_rdma_vecs, num_rdma_vecs);
+				IDPF_MIN_RDMA_VEC, num_rdma_vecs);
 			return -EINVAL;
 		}
 	}
@@ -341,70 +237,32 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 		return -EAGAIN;
 	}
 
-	min_lan_vecs = IDPF_MBX_Q_VEC + IDPF_MIN_Q_VEC * default_vports;
-	min_vectors = min_lan_vecs + min_rdma_vecs;
-	actual_vecs = pci_alloc_irq_vectors(adapter->pdev, min_vectors,
-					    total_vecs, PCI_IRQ_MSIX);
-	if (actual_vecs < 0) {
-		dev_err(&adapter->pdev->dev, "Failed to allocate minimum MSIX vectors required: %d\n",
-			min_vectors);
-		err = actual_vecs;
+	static_vecs = IDPF_MBX_Q_VEC + IDPF_MIN_Q_VEC * default_vports +
+		      min(IDPF_MIN_RDMA_VEC, num_rdma_vecs);
+	err = libie_irq_init(irq, adapter->pdev, static_vecs, total_vecs);
+	if (err) {
+		dev_err(&adapter->pdev->dev, "Failed to allocate MSIX vectors: %d\n",
+			err);
+		err = -EAGAIN;
 		goto send_dealloc_vecs;
 	}
 
-	if (idpf_is_rdma_cap_ena(adapter)) {
-		if (actual_vecs < total_vecs) {
-			dev_warn(&adapter->pdev->dev,
-				 "Warning: %d vectors requested, only %d available. Defaulting to minimum (%d) for RDMA and remaining for LAN.\n",
-				 total_vecs, actual_vecs, IDPF_MIN_RDMA_VEC);
-			num_rdma_vecs = IDPF_MIN_RDMA_VEC;
-		}
-
-		adapter->rdma_msix_entries = kzalloc_objs(struct msix_entry,
-							  num_rdma_vecs);
-		if (!adapter->rdma_msix_entries) {
-			err = -ENOMEM;
-			goto free_irq;
-		}
-	}
-
-	num_lan_vecs = actual_vecs - num_rdma_vecs;
-
-	for (i = 0; i < num_rdma_vecs; i++) {
-		adapter->rdma_msix_entries[i].entry =
-			adapter->irq_info.vectors[num_lan_vecs + i].idx;
-		adapter->rdma_msix_entries[i].vector =
-			pci_irq_vector(adapter->pdev, num_lan_vecs + i);
-	}
-
-	/* 'num_avail_msix' is used to distribute excess vectors to the vports
-	 * after considering the minimum vectors required per each default
-	 * vport
-	 */
-	adapter->num_avail_msix = num_lan_vecs - min_lan_vecs;
-	adapter->num_msix_entries = num_lan_vecs;
-	if (idpf_is_rdma_cap_ena(adapter))
-		adapter->num_rdma_msix_entries = num_rdma_vecs;
-
-	/* Fill MSIX vector lifo stack with vector indexes */
-	err = idpf_init_vector_stack(adapter);
+	err = idpf_mb_intr_init(adapter);
 	if (err)
-		goto free_rdma_msix;
+		goto free_irq;
 
-	err = idpf_mb_intr_init(adapter);
+	err = idpf_rdma_intr_init(adapter, num_rdma_vecs);
 	if (err)
-		goto deinit_vec_stack;
+		goto free_mb_irq;
+
 	idpf_mb_irq_enable(adapter);
 
 	return 0;
 
-deinit_vec_stack:
-	idpf_deinit_vector_stack(adapter);
-free_rdma_msix:
-	kfree(adapter->rdma_msix_entries);
-	adapter->rdma_msix_entries = NULL;
+free_mb_irq:
+	idpf_mb_intr_rel_irq(adapter);
 free_irq:
-	pci_free_irq_vectors(adapter->pdev);
+	libie_irq_deinit(irq);
 send_dealloc_vecs:
 	idpf_send_dealloc_vectors_msg(adapter);
 
@@ -986,7 +844,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 	idpf_vport_intr_deinit(vport, rsrc);
 	idpf_xdp_rxq_info_deinit_all(rsrc);
 	idpf_vport_queues_rel(vport, rsrc);
-	idpf_vport_intr_rel(rsrc);
+	idpf_vport_intr_rel(rsrc, &adapter->irq);
 	clear_bit(IDPF_VPORT_UP, np->state);
 
 	if (rtnl)
@@ -1042,10 +900,8 @@ static void idpf_decfg_netdev(struct idpf_vport *vport)
  */
 static void idpf_vport_rel(struct idpf_vport *vport)
 {
-	struct idpf_q_vec_rsrc *rsrc = &vport->dflt_qv_rsrc;
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
-	struct idpf_vector_info vec_info;
 	struct idpf_rss_data *rss_data;
 	struct idpf_vport_max_q max_q;
 	u16 idx = vport->idx;
@@ -1065,16 +921,6 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 	max_q.max_complq = vport_config->max_q.max_complq;
 	idpf_vport_dealloc_max_qs(adapter, &max_q);
 
-	/* Release all the allocated vectors on the stack */
-	vec_info.num_req_vecs = 0;
-	vec_info.num_curr_vecs = rsrc->num_q_vectors;
-	vec_info.default_vport = vport->default_vport;
-
-	idpf_req_rel_vector_indexes(adapter, rsrc->q_vector_idxs, &vec_info);
-
-	kfree(rsrc->q_vector_idxs);
-	rsrc->q_vector_idxs = NULL;
-
 	idpf_vport_deinit_queue_reg_chunks(vport_config);
 
 	kfree(adapter->vport_params_recvd[idx]);
@@ -1196,8 +1042,8 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 					   struct idpf_vport_max_q *max_q)
 {
 	struct idpf_rss_data *rss_data;
-	u16 idx = adapter->next_vport;
 	struct idpf_q_vec_rsrc *rsrc;
+	u16 idx = adapter->next_vport;
 	struct idpf_vport *vport;
 	u16 num_max_q;
 	int err;
@@ -1247,13 +1093,10 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	rsrc = &vport->dflt_qv_rsrc;
 	rsrc->dev = &adapter->pdev->dev;
-	rsrc->q_vector_idxs = kcalloc(num_max_q, sizeof(u16), GFP_KERNEL);
-	if (!rsrc->q_vector_idxs)
-		goto free_vport;
 
 	err = idpf_vport_init(vport, max_q);
 	if (err)
-		goto free_vector_idxs;
+		goto free_vport;
 
 	/* LUT and key are both initialized here. Key is not strictly dependent
 	 * on how many queues we have. If we change number of queues and soft
@@ -1264,7 +1107,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	rss_data = &adapter->vport_config[idx]->user_config.rss_data;
 	rss_data->rss_key = kzalloc(rss_data->rss_key_size, GFP_KERNEL);
 	if (!rss_data->rss_key)
-		goto free_qreg_chunks;
+		goto deinit_vport_queues;
 
 	/* Initialize default RSS key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
@@ -1287,10 +1130,8 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 free_rss_key:
 	kfree(rss_data->rss_key);
 	rss_data->rss_key = NULL;
-free_qreg_chunks:
+deinit_vport_queues:
 	idpf_vport_deinit_queue_reg_chunks(adapter->vport_config[idx]);
-free_vector_idxs:
-	kfree(rsrc->q_vector_idxs);
 free_vport:
 	kfree(vport);
 
@@ -1485,6 +1326,12 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	/* we do not allow interface up just yet */
 	netif_carrier_off(vport->netdev);
 
+	/*
+	 * num_q_vectors can be lowered by previous open/close cycle or
+	 * error during open. Reset it back to default value. Still can be
+	 * changed when there is not enough interrupts available.
+	 */
+	idpf_vport_set_num_q_vectors(rsrc, vport->num_xdp_txq);
 	err = idpf_vport_intr_alloc(vport, rsrc);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to allocate interrupts for vport %u: %d\n",
@@ -1599,7 +1446,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 queues_rel:
 	idpf_vport_queues_rel(vport, rsrc);
 intr_rel:
-	idpf_vport_intr_rel(rsrc);
+	idpf_vport_intr_rel(rsrc, &adapter->irq);
 
 err_rtnl_unlock:
 	if (rtnl)
@@ -2062,7 +1909,8 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_up));
 
 	if (reset_cause == IDPF_SR_Q_CHANGE)
-		idpf_vport_alloc_vec_indexes(vport, &vport->dflt_qv_rsrc);
+		idpf_vport_set_num_q_vectors(&vport->dflt_qv_rsrc,
+					     vport->num_xdp_txq);
 
 	err = idpf_set_real_num_queues(vport);
 	if (err)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 1e4dd9b713a0..e27ad0e6e4e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -18,6 +18,7 @@ MODULE_IMPORT_NS("LIBETH");
 MODULE_IMPORT_NS("LIBIE_CP");
 MODULE_IMPORT_NS("LIBIE_PCI");
 MODULE_IMPORT_NS("LIBETH_XDP");
+MODULE_IMPORT_NS("LIBIE_IRQ");
 MODULE_LICENSE("GPL");
 
 /**
@@ -177,7 +178,6 @@ static void idpf_remove(struct pci_dev *pdev)
 	adapter->netdevs = NULL;
 
 	mutex_destroy(&adapter->vport_ctrl_lock);
-	mutex_destroy(&adapter->vector_lock);
 	mutex_destroy(&adapter->queue_lock);
 	mutex_destroy(&adapter->vc_buf_lock);
 
@@ -338,7 +338,6 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->msg_enable = netif_msg_init(-1, IDPF_AVAIL_NETIF_M);
 
 	mutex_init(&adapter->vport_ctrl_lock);
-	mutex_init(&adapter->vector_lock);
 	mutex_init(&adapter->queue_lock);
 	mutex_init(&adapter->vc_buf_lock);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2a3dd04ebe23..a75d4cc35013 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3823,14 +3823,18 @@ static void idpf_vport_intr_napi_dis_all(struct idpf_q_vec_rsrc *rsrc)
 /**
  * idpf_vport_intr_rel - Free memory allocated for interrupt vectors
  * @rsrc: pointer to queue and vector resources
+ * @irq: libie_irq structure to be passed to libie_irq_free()
  *
  * Free the memory allocated for interrupt vectors  associated to a vport
  */
-void idpf_vport_intr_rel(struct idpf_q_vec_rsrc *rsrc)
+void idpf_vport_intr_rel(struct idpf_q_vec_rsrc *rsrc, struct libie_irq *irq)
 {
+	libie_put_irq(irq, rsrc->noirq_v_idx);
+
 	for (u16 v_idx = 0; v_idx < rsrc->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[v_idx];
 
+		libie_irq_free(irq, q_vector->irq);
 		kfree(q_vector->xsksq);
 		q_vector->xsksq = NULL;
 		kfree(q_vector->complq);
@@ -3863,15 +3867,17 @@ static void idpf_q_vector_set_napi(struct idpf_q_vector *q_vector, bool link)
 
 /**
  * idpf_vport_intr_rel_irq - Free the IRQ association with the OS
+ * @vport: main vport structure
  * @rsrc: pointer to queue and vector resources
  */
-static void idpf_vport_intr_rel_irq(struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vport_intr_rel_irq(struct idpf_vport *vport,
+				    struct idpf_q_vec_rsrc *rsrc)
 {
 	for (int vector = 0; vector < rsrc->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[vector];
 
 		/* free only the irqs that were actually requested */
-		if (!q_vector)
+		if (!q_vector->irq.virq)
 			continue;
 
 		idpf_q_vector_set_napi(q_vector, false);
@@ -4044,10 +4050,10 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	const char *drv_name, *if_name, *vec_name;
-	int vector, err, vidx;
+	int vector, err;
 
-	vidx = rsrc->q_vector_idxs[rsrc->num_q_vectors];
-	adapter->dev_ops.reg_ops.noirq_intr_reg_init(adapter, rsrc, vidx);
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init(adapter, rsrc,
+						     rsrc->noirq_v_idx);
 
 	drv_name = dev_driver_string(&adapter->pdev->dev);
 	if_name = netdev_name(vport->netdev);
@@ -4057,9 +4063,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 		int virq = q_vector->irq.virq;
 		char *name;
 
-		vidx = rsrc->q_vector_idxs[vector];
-
-		adapter->dev_ops.reg_ops.intr_reg_init(adapter, q_vector, vidx);
+		adapter->dev_ops.reg_ops.intr_reg_init(adapter, q_vector,
+						       q_vector->irq.index);
 
 		if (q_vector->num_rxq && q_vector->num_txq)
 			vec_name = "TxRx";
@@ -4186,7 +4191,7 @@ void idpf_vport_intr_deinit(struct idpf_vport *vport,
 	idpf_vport_intr_napi_dis_all(rsrc);
 	idpf_vport_intr_dis_dim_all(rsrc);
 	idpf_vport_intr_napi_del_all(rsrc);
-	idpf_vport_intr_rel_irq(rsrc);
+	idpf_vport_intr_rel_irq(vport, rsrc);
 }
 
 /**
@@ -4496,31 +4501,38 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 /**
  * idpf_vport_intr_init_vec_idx - Initialize the vector indexes
  * @vport: virtual port
- * @rsrc: pointer to queue and vector resources
+ * @tmp_irqs: place to store reserved irqs number
+ * @num_vec: number of q_vectors
  *
- * Initialize vector indexes with values returned over mailbox.
+ * Initialize vector indexes with values returned from libie_irq
  *
- * Return: 0 on success, negative on failure
+ * Return: number of initialized vectors, or negative value in case of error
  */
 static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
-					struct idpf_q_vec_rsrc *rsrc)
+					struct msi_map *tmp_irqs, u16 num_vec)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	int i;
 
-	for (i = 0; i < rsrc->num_q_vectors; i++) {
-		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
+	for (i = 0; i < num_vec; i++) {
+		if (vport->default_vport && i == 0) {
+			tmp_irqs[i] = libie_irq_alloc(&adapter->irq,
+						      LIBIE_IRQ_STATIC);
+			if (tmp_irqs[i].index < 0)
+				return tmp_irqs[i].index;
+			continue;
+		}
 
-		q_vector->irq.index = rsrc->q_vector_idxs[i];
-		q_vector->irq.virq = pci_irq_vector(adapter->pdev,
-						    q_vector->irq.index);
-		if (q_vector->irq.virq < 0)
-			return q_vector->irq.virq;
+		tmp_irqs[i] = libie_irq_alloc(&adapter->irq, LIBIE_IRQ_DYNAMIC);
+		/* not crucial if there is already allocated irq */
+		if (tmp_irqs[i].index < 0) {
+			if (i == 0)
+				return tmp_irqs[i].index;
+			break;
+		}
 	}
 
-	rsrc->noirq_v_idx = rsrc->q_vector_idxs[i];
-
-	return 0;
+	return i;
 }
 
 /**
@@ -4561,17 +4573,49 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 {
 	u16 txqs_per_vector, rxqs_per_vector, bufqs_per_vector;
 	struct idpf_vport_user_config_data *user_config;
+	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_q_vector *q_vector;
 	struct idpf_q_coalesce *q_coal;
+	struct msi_map *tmp_irqs;
+	int irqs, i, noirq_v_idx;
 	u32 complqs_per_vector;
 	u16 idx = vport->idx;
 
-	user_config = &vport->adapter->vport_config[idx]->user_config;
+	user_config = &adapter->vport_config[idx]->user_config;
 
+	tmp_irqs = kzalloc_objs(struct msi_map, rsrc->num_q_vectors);
+	if (!tmp_irqs)
+		return -ENOMEM;
+
+	noirq_v_idx = libie_irq_reserve(&adapter->irq);
+	if (noirq_v_idx < 0) {
+		kfree(tmp_irqs);
+		return noirq_v_idx;
+	}
+
+	rsrc->noirq_v_idx = noirq_v_idx;
+
+	irqs = idpf_vport_intr_init_vec_idx(vport, tmp_irqs,
+					    rsrc->num_q_vectors);
+	if (irqs < 0) {
+		libie_put_irq(&adapter->irq, rsrc->noirq_v_idx);
+		kfree(tmp_irqs);
+		return irqs;
+	}
+
+	rsrc->num_q_vectors = irqs;
 	rsrc->q_vectors = kzalloc_objs(struct idpf_q_vector,
 				       rsrc->num_q_vectors);
-	if (!rsrc->q_vectors)
+	if (!rsrc->q_vectors) {
+		libie_put_irq(&adapter->irq, rsrc->noirq_v_idx);
+		for (i = 0; i < rsrc->num_q_vectors; i++)
+			libie_irq_free(&adapter->irq, tmp_irqs[i]);
+		kfree(tmp_irqs);
 		return -ENOMEM;
+	}
+
+	for (i = 0; i < rsrc->num_q_vectors; i++)
+		rsrc->q_vectors[i].irq = tmp_irqs[i];
 
 	txqs_per_vector = DIV_ROUND_UP(rsrc->num_txq_grp,
 				       rsrc->num_q_vectors);
@@ -4627,10 +4671,12 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 			goto error;
 	}
 
+	kfree(tmp_irqs);
 	return 0;
 
 error:
-	idpf_vport_intr_rel(rsrc);
+	idpf_vport_intr_rel(rsrc, &adapter->irq);
+	kfree(tmp_irqs);
 
 	return -ENOMEM;
 }
@@ -4646,10 +4692,6 @@ int idpf_vport_intr_init(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 {
 	int err;
 
-	err = idpf_vport_intr_init_vec_idx(vport, rsrc);
-	if (err)
-		return err;
-
 	idpf_vport_intr_map_vector_to_qs(vport, rsrc);
 	idpf_vport_intr_napi_add_all(vport, rsrc);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9a2e3665277f..f40a0a67d7ea 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1079,7 +1079,7 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport,
 			    struct idpf_q_vec_rsrc *rsrc);
 void idpf_vport_queues_rel(struct idpf_vport *vport,
 			   struct idpf_q_vec_rsrc *rsrc);
-void idpf_vport_intr_rel(struct idpf_q_vec_rsrc *rsrc);
+void idpf_vport_intr_rel(struct idpf_q_vec_rsrc *rsrc, struct libie_irq *irq);
 int idpf_vport_intr_alloc(struct idpf_vport *vport,
 			  struct idpf_q_vec_rsrc *rsrc);
 void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 90f3c40c7928..65ddc6f893fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2251,7 +2251,7 @@ static int idpf_create_vectors_info(struct idpf_irq_info *info,
 	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
 		return -EINVAL;
 
-	info->vectors = kzalloc_objs(*info->vectors, num_vectors + IDPF_MBX_Q_VEC);
+	info->vectors = kzalloc_objs(*info->vectors, all_vectors);
 	if (!info->vectors)
 		return -ENOMEM;
 	/* Mailbox irq information are stored in different places. Fill index 0
@@ -3257,47 +3257,16 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 }
 
 /**
- * idpf_vport_alloc_vec_indexes - Get relative vector indexes
- * @vport: virtual port data struct
+ * idpf_vport_set_num_q_vectors - Set the number of vectors
  * @rsrc: pointer to queue and vector resources
+ * @xdpqs: number of noirq queues (XDP)
  *
- * This function requests the vector information required for the vport and
- * stores the vector indexes received from the 'global vector distribution'
- * in the vport's queue vectors array.
- *
- * Return: 0 on success, error on failure
+ * This function set the number of q_vectors for the vport.
  */
-int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport,
-				 struct idpf_q_vec_rsrc *rsrc)
+void idpf_vport_set_num_q_vectors(struct idpf_q_vec_rsrc *rsrc, u16 xdpqs)
 {
-	struct idpf_vector_info vec_info;
-	int num_alloc_vecs;
-	u32 req;
-
-	vec_info.num_curr_vecs = rsrc->num_q_vectors;
-	if (vec_info.num_curr_vecs)
-		vec_info.num_curr_vecs += IDPF_RESERVED_VECS;
-
 	/* XDPSQs are all bound to the NOIRQ vector from IDPF_RESERVED_VECS */
-	req = max(rsrc->num_txq - vport->num_xdp_txq, rsrc->num_rxq) +
-	      IDPF_RESERVED_VECS;
-	vec_info.num_req_vecs = req;
-
-	vec_info.default_vport = vport->default_vport;
-	vec_info.index = vport->idx;
-
-	num_alloc_vecs = idpf_req_rel_vector_indexes(vport->adapter,
-						     rsrc->q_vector_idxs,
-						     &vec_info);
-	if (num_alloc_vecs <= 0) {
-		dev_err(&vport->adapter->pdev->dev, "Vector distribution failed: %d\n",
-			num_alloc_vecs);
-		return -EINVAL;
-	}
-
-	rsrc->num_q_vectors = num_alloc_vecs - IDPF_RESERVED_VECS;
-
-	return 0;
+	rsrc->num_q_vectors = max(rsrc->num_txq - xdpqs, rsrc->num_rxq);
 }
 
 /**
@@ -3356,7 +3325,7 @@ int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	idpf_vport_init_num_qs(vport, vport_msg, rsrc);
 	idpf_vport_calc_num_q_desc(vport, rsrc);
 	idpf_vport_calc_num_q_groups(rsrc);
-	idpf_vport_alloc_vec_indexes(vport, rsrc);
+	idpf_vport_set_num_q_vectors(rsrc, vport->num_xdp_txq);
 
 	vport->crc_enable = adapter->crc_enable;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index ec4c79191c85..8fad35a8c64c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -124,8 +124,7 @@ int idpf_send_delete_queues_msg(struct idpf_adapter *adapter,
 				struct idpf_queue_id_reg_info *chunks,
 				u32 vport_id);
 
-int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport,
-				 struct idpf_q_vec_rsrc *rsrc);
+void idpf_vport_set_num_q_vectors(struct idpf_q_vec_rsrc *rsrc, u16 xdpqs);
 int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors);
 int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter);
 int idpf_send_map_unmap_queue_vector_msg(struct idpf_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index 9c5fdebb6766..47fb77191604 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -37,3 +37,9 @@ config LIBIE_PCI
 	help
 	  Helper functions for management of PCI resources belonging
 	  to networking devices.
+
+config LIBIE_IRQ
+	tristate
+	help
+	  Helpers used to manage irqs by drivers, take care of managing static
+	  and dynamic interrupts, using xarray to store irqs and track usage.
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index 3065aa057798..380af47398d8 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -20,3 +20,7 @@ libie_fwlog-y			:= fwlog.o
 obj-$(CONFIG_LIBIE_PCI)		+= libie_pci.o
 
 libie_pci-y			:= pci.o
+
+obj-$(CONFIG_LIBIE_IRQ)		+= libie_irq.o
+
+libie_irq-y			:= irq.o
diff --git a/drivers/net/ethernet/intel/libie/irq.c b/drivers/net/ethernet/intel/libie/irq.c
new file mode 100644
index 000000000000..0f73f8becefb
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/irq.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/net/intel/libie/irq.h>
+
+/**
+ * libie_irq_init - init irq for whole device
+ * @irq: pointer to libie_irq structure
+ * @pdev: pdev which interrupts is used
+ * @min: number of static interrupts
+ * @max: max - min is the number of dynamic interrupts
+ *
+ * Function will call pci_alloc_irq_vectors(). Minimum vectors value is a number
+ * of LIBIE_IRQ_STATIC. It means that if there is no enough interrupts for
+ * all static interrupts this function will return -ENOSPC.
+ *
+ * If there is no support for dynamic interrupts allocation
+ * pci_alloc_irq_vectors() is called with max value, otherwise max is equal to
+ * min. There is no need to change the limits values for LIBIE_IRQ_DYNAMIC.
+ * The libie_irq_alloc() function is changing the LIBIE_IRQ_DYNAMIC to
+ * LIBIE_IRQ_STATIC when there is no such support. User of this helpers doesn't
+ * have to think if there is dynamic support or there isn't.
+ *
+ * Limits' max is the last index that can be used. Assuming 0 index is valid
+ * (which is true here) there is need to subtract one from the number of
+ * interrupts.
+ * Ex. min = 5 -> limits.min = 0, limits.max = 4; indexes 0, 1, 2, 3, 4
+ *
+ * Return: 0 in case of success otherwise -ENOSPC or -EINVAL when called
+ *         with min == 0
+ */
+int libie_irq_init(struct libie_irq *irq, struct pci_dev *pdev,
+		   int min, int max)
+{
+	int vectors;
+
+	/* At least one static vector needs to be allocated */
+	if (!min || min > max)
+		return -EINVAL;
+
+	irq->limits[LIBIE_IRQ_STATIC].min = 0;
+	irq->limits[LIBIE_IRQ_STATIC].max = min - 1;
+	irq->limits[LIBIE_IRQ_DYNAMIC].min = min;
+	irq->limits[LIBIE_IRQ_DYNAMIC].max = max - 1;
+
+	if (!pci_msix_can_alloc_dyn(pdev))
+		irq->limits[LIBIE_IRQ_STATIC].max = max - 1;
+	else
+		/* max can be lowered, as rest can be allocated dynamically */
+		max = min;
+
+	vectors = pci_alloc_irq_vectors(pdev, min, max, PCI_IRQ_MSIX);
+	if (vectors < 0)
+		return vectors;
+
+	/* static vectors needs to be lowered if there is not enough irqs */
+	if (irq->limits[LIBIE_IRQ_STATIC].max + 1 > vectors)
+		irq->limits[LIBIE_IRQ_STATIC].max = vectors - 1;
+
+	irq->pdev = pdev;
+	xa_init_flags(&irq->entries, XA_FLAGS_ALLOC);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_init, "LIBIE_IRQ");
+
+/**
+ * libie_irq_deinit - deinit irq initialized by libie_irq_init()
+ * @irq: libie_irq stored in driver data
+ *
+ * Should be called after all irqs are cleaned by libie_put_irq()
+ */
+void libie_irq_deinit(struct libie_irq *irq)
+{
+	struct libie_irq_entry *entry;
+	unsigned long i;
+
+	if (!irq->pdev)
+		return;
+
+	xa_for_each(&irq->entries, i, entry)
+		kfree(entry);
+	xa_destroy(&irq->entries);
+	pci_free_irq_vectors(irq->pdev);
+	irq->pdev = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_deinit, "LIBIE_IRQ");
+
+/**
+ * libie_get_irq - get new allocated entry for specific irq type
+ * @irq: libie_irq structure used to get limits and entries xarray
+ * @type: one of the enum libie_irq_type
+ *
+ * Return: struct libie_irq_entry * in case of success or NULL otherwise
+ */
+static struct libie_irq_entry *libie_get_irq(struct libie_irq *irq,
+					     enum libie_irq_type type)
+{
+	struct libie_irq_entry *entry;
+	unsigned int index;
+
+	if (!irq->pdev)
+		return NULL;
+
+	/* Change entry type if dynamic isn't supported. Reflect correct type
+	 * to not call pci_msix_free_irq() during freeing this irq.
+	 */
+	if (!pci_msix_can_alloc_dyn(irq->pdev))
+		type = LIBIE_IRQ_STATIC;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return NULL;
+
+	if (xa_alloc(&irq->entries, &index, entry, irq->limits[type],
+		     GFP_KERNEL))
+		goto free_entry;
+
+	entry->index = index;
+	entry->type = type;
+
+	return entry;
+
+free_entry:
+	kfree(entry);
+	return NULL;
+}
+
+/**
+ * libie_put_irq - inform that the irq isn't used anymore
+ * @irq: libie_irq structure used to get entries xarray
+ * @index: software 0-based index of irq to be marked as unused
+ */
+void libie_put_irq(struct libie_irq *irq, unsigned int index)
+{
+	struct libie_irq_entry *entry;
+
+	entry = xa_erase(&irq->entries, index);
+	kfree(entry);
+}
+EXPORT_SYMBOL_NS_GPL(libie_put_irq, "LIBIE_IRQ");
+
+/**
+ * libie_irq_alloc - alloc new irq, or get existing one in case of static
+ * @irq: libie_irq structure
+ * @type: one of enum libie_irq_type
+ *
+ *
+ * For LIBIE_IRQ_DYNAMIC function allocs new interrupt and return it.
+ * For LIBIE_IRQ_STATIC function returns already allocated one.
+ *
+ * The function should be called for getting irq information (index and virq)
+ * for specific irq type. Returned information should be stored to use index for
+ * gathering HW specific information and virq to request/free irq line.
+ *
+ * Calling this function with LIBIE_IRQ_DYNAMIC type when dynamic irq isn't
+ * support is fine and will use limits from static field set in
+ * libie_irq_init().
+ *
+ * Return: map.index = -ENOENT if there is no free interrupts of chosen type
+ *	   map.index = -EINVAL if pci_irq_vector() fails
+ *	   correct map.index and map.virq if everything is fine
+ */
+struct msi_map libie_irq_alloc(struct libie_irq *irq, enum libie_irq_type type)
+{
+	struct msi_map map = { .index = -ENOENT,
+			       .virq = 0 };
+	struct libie_irq_entry *entry;
+
+	entry = libie_get_irq(irq, type);
+	if (!entry)
+		return map;
+
+	if (entry->type == LIBIE_IRQ_DYNAMIC) {
+		map = pci_msix_alloc_irq_at(irq->pdev, entry->index, NULL);
+		if (map.index < 0)
+			goto put_irq;
+	} else {
+		map.index = entry->index;
+		map.virq = pci_irq_vector(irq->pdev, map.index);
+		if (map.virq < 0) {
+			/* In dynamic case error is in .index, put it there
+			 * also for static case to allow the caller always look
+			 * for an error in the same place.
+			 */
+			map.index = map.virq;
+			goto put_irq;
+		}
+	}
+
+	return map;
+
+put_irq:
+	libie_put_irq(irq, entry->index);
+	return map;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_alloc, "LIBIE_IRQ");
+
+/**
+ * libie_irq_free - free irq, allocated using libie_alloc_irq()
+ * @irq: libie_irq structure
+ * @map: msi_map structure returned from libie_alloc_irq()
+ *
+ * In case of dynamic allocation and LIBIE_IRQ_DYNAMIC type pci_msix_free_irq()
+ * is called. Otherwise only free driver irq entry related resources.
+ *
+ * It is safe to call this function with map that doesn't exist in xarray
+ * as long as the map.virq is 0 or negative. It is true when libie_irq_alloc()
+ * has failed.
+ */
+void libie_irq_free(struct libie_irq *irq, struct msi_map map)
+{
+	struct libie_irq_entry *entry;
+
+	if (map.virq <= 0 || map.index < 0)
+		return;
+
+	entry = xa_load(&irq->entries, map.index);
+	if (!entry)
+		return;
+
+	if (entry->type == LIBIE_IRQ_DYNAMIC)
+		pci_msix_free_irq(irq->pdev, map);
+
+	libie_put_irq(irq, map.index);
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_free, "LIBIE_IRQ");
+
+/**
+ * libie_irq_reserve - reserve a interrupt index without allocating MSI-X
+ * @irq: libie_irq structure containing interrupt management data
+ *
+ * This function reserves an interrupt index from the dynamic range without
+ * actually allocating the corresponding MSI-X vector. The reserved index can
+ * be used for hardware queue configuration before the actual interrupt
+ * allocation. The caller should use libie_put_irq() to release the reserved
+ * index when no longer needed.
+ *
+ * Return: Reserved interrupt index on success, or -ENOENT if no dynamic
+ *         interrupt indices are available.
+ */
+int libie_irq_reserve(struct libie_irq *irq)
+{
+	struct libie_irq_entry *ent = libie_get_irq(irq, LIBIE_IRQ_DYNAMIC);
+
+	if (!ent)
+		return -ENOENT;
+
+	return ent->index;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_reserve, "LIBIE_IRQ");
+
+/* Module */
+
+MODULE_DESCRIPTION("Helper functions for managing MSI-X in driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/net/intel/libie/irq.h b/include/linux/net/intel/libie/irq.h
new file mode 100644
index 000000000000..8af8fc22ab09
--- /dev/null
+++ b/include/linux/net/intel/libie/irq.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef __LIBIE_IRQ_H
+#define __LIBIE_IRQ_H
+
+#include <linux/pci.h>
+
+/* In whole code in libie_irq index means the software 0-based irq index
+ * for driver purpose, virq means the linux irq line number. Index can be used
+ * for getting HW registers address and HW indexes (ex. for idpf there is
+ * another irq index used in virtchnl communication which isn't driver index or
+ * linux irq number). It is following the scheme from structure msi_map.
+ */
+
+/**
+ * enum libie_irq_type - enum representing types of irq entries
+ * @LIBIE_IRQ_STATIC: irq static allocated from kernel at driver probe
+ * @LIBIE_IRQ_DYNAMIC: irq dynamic allocated during normal driver operation
+ * @LIBIE_IRQ_NUM_TYPES: must be the last one, used to define the array size
+ *
+ * Enum is used to get software irq indexes from some kind of pool. The pool is
+ * based on xa_array. Depending on the limit value passed to xa_alloc() software
+ * irq indexes only from limited range can be returned.
+ *
+ * LIBIE_IRQ_STATIC .min = 0, max = 5 -> 5 irq static allocated to be sure that
+ *	all default vport can operate
+ * LIBIE_IRQ_DYNAMIC .min = 6, max = HW irq max -> rest to be dynamically used
+ *	when needed
+ */
+enum libie_irq_type {
+	LIBIE_IRQ_STATIC,
+	LIBIE_IRQ_DYNAMIC,
+	LIBIE_IRQ_NUM_TYPES,
+};
+
+/**
+ * struct libie_irq_entry - structure to store irq entry information
+ * @index: managed by software 0 based irq index, used to get correct hardware
+ *	   information about irq (HW index and HW registers address)
+ * @type: the type of irq, look at enum libie_irq_type for more information
+ *
+ * This structure is used to store the basic information about irq used during
+ * alloc and free. Type needs to be known, because freeing dynamic type needs
+ * extra call.
+ */
+struct libie_irq_entry {
+	int index;
+	enum libie_irq_type type;
+};
+
+/**
+ * struct libie_irq - main structure to be used by libie_irq code
+ * @pdev: pdev of driver that is using this lib
+ * @limits: the irq pool scheme definition, take a look at irq_type note
+ * @entries: xarray to store irq entries
+ *
+ * pdev and limits values need to be passed by the driver during lib
+ * initialization.
+ */
+struct libie_irq {
+	struct pci_dev *pdev;
+	struct xa_limit limits[LIBIE_IRQ_NUM_TYPES];
+	struct xarray entries;
+};
+
+int libie_irq_init(struct libie_irq *irq, struct pci_dev *pdev,
+		   int min, int max);
+void libie_irq_deinit(struct libie_irq *irq);
+struct msi_map libie_irq_alloc(struct libie_irq *irq, enum libie_irq_type type);
+void libie_irq_free(struct libie_irq *irq, struct msi_map map);
+int libie_irq_reserve(struct libie_irq *irq);
+void libie_put_irq(struct libie_irq *irq, unsigned int index);
+
+#endif /* __LIBIE_IRQ_H */
-- 
2.49.0

