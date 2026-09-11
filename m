Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240BC88E50
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD01380F18;
	Fri, 11 Sep 2026 13:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPaJcSEJZi50; Fri, 11 Sep 2026 13:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9246F80F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133460;
	b=QO8GCOFSwAFRGohTgeX6ImpnSa/4DwQn8vQK4llF++XzKrGTQKM7WRRMMCQsfEDaEm8r
	 Sn4ZBTNl6PAoy+ZbR6JgU3wUNKwA3AUM9aSiOlWe0os8d64nB8yfbBn3fqkcp0NIPSs5h
	 vNuxHY/vl6Yxtd5rh3coX5LM7SxkpEVPXecbwlreu331cg48GbJXcHAPpQZO69cQBScNZ
	 skQlunhTROYY33sS3ul/a0ahyh9drMsGYz2emIIgZVpNTdATNoTeVw02p/W1kBBZdSB+r
	 qmwu4KaS6YkEprf7zrXK9LP6osLz2nfg9bQ1qlcsMyhXJHNeSoq5y1h8eC3hw534yiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fxXLlViKXvNUobh0H8+MiNUwyL9/2ADeGywmg8MLJHs=;
	b=qx4FtL9FjJ2UGIe1awoq+uQP8s3pDpC3ySLbQj0jISusq5QispPYiQF0P96Wi+u1qnsD
	 Z3m/9ZwkbbZKC51E8GMcF83Z2pHsfDG3ZmS54x8nzglVMvNsZxF5op/vEsd4f6r7iHmDn
	 BRhg0f6uDrHH/6PkvWIekTD3d+HXbfc7Ij13rNGtdk4WP9dnyB7A7dhg7NF3EPGKjdXJy
	 tCgB8HMlzEjITYqYFMOvYi3V+h/rWHmMAVJ7pb5APCqsRvnWBj50AEOU3EzLaTxy1BsJe
	 zAPiS1lHuOmLHwfpBJZnZOQwWw6frYEGxCh0IOHfCI/YJatOubiG5HXiBR+r2JnIVUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133460;
	bh=fxXLlViKXvNUobh0H8+MiNUwyL9/2ADeGywmg8MLJHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dR991tCuxBwAeFxeOBHYM0P5yHt2RdZlORCYFiyECDmxWKkBUl0Gz31Xc/6ZjRkUU
	 gsk0aJohfW1rf70WL8fUWy3BBVvrH2RTtqAus4yOtslrEWGmzUaV33XKUetayMMl/L
	 5alcGXZWoH9ebD+nQ5OmvIR3Rg+/SMxlmGEAnzATiDMrJDxQO3zgUHDAI9RElxFHhc
	 rdleicXE7SJByfoVz1aiW67fGCkULesHcSPnYyZSr3U3jcHX4uTLzba4Jr3FhaXrxK
	 6598m5ly3ZfUFDoIwIvxNGekV89Wayeu/olS6+pTLB8dLfADcLUyrLmvoGGD2PGFhY
	 QQtwejCFJIrjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9246F80F24;
	Fri, 11 Sep 2026 13:31:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A70C232F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A49B94081E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmWjTTclCwW0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A2EBC40607
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133456;
 b=VoIzFaQZyhFTBcJj77817rchwgmN9cxEk3X2mEwAtAyctK3lsybkHlxMJysf7Hy4cgpz
 u2+AslAqa8X3duKdnxrC1Pwqq6NflJ1nKokfszJrpT/52ujHWKCZN8izakb6cFaEpcAUG
 +yB3295cTQ30l9qKL0ZgPOamHtapeAYtVFel38gFdfxgVedGQ2nUiz+fz7COgQaE5bP/x
 ONVatX0wGappPm1cB855by/vX29Wyn9OM2ePXzlIXUH3k749EpaOsJPlqAi6hz0ekKEck
 lU8f9dyvbJnXVOmd1EMhE/1zF7SXFjJsSPh6GE1sGq9ILratt77gtREvyVzvbYUavfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133456;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fxXLlViKXvNUobh0H8+MiNUwyL9/2ADeGywmg8MLJHs=;
 b=Za1EpQ1MwfQn7678TOS5lST01Z2/UhUI9hs1u9lXBbbc4ZcNhXx6KqbuD1XMJ0JJBSrO
 2gBWJzk5xz1VLiKnXgrDxStL6kfmdOw81z+C2B8NhRZoHdsL7NNQwbhtAikoQXVMJajfb
 W/GPPn34cYt2Avr7efEr3r2/vr5WNgUCQNAdHepuIopt/6mFz/3W+oXqESnvAIuV+wxri
 rV/+LUwEWTYOQ2oExZJG0tPt3yI4ADY1SQY0SghaTnJNJIr16QBiOqUwEtf4tsrhwNlSu
 5ghdJsdlDmTy8FKd8Bel8uMfGqnaM0v2Vv6YT11dxC119KzYooWKNxpRW6TPSzzSqSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=O7Re6QpO; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O7Re6QpO
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2EBC40607
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133457; x=1820669457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AAaLVytSDV4it8ChuKPJVtlElM17p0GfiwFxmaKqV4A=;
 b=O7Re6QpOin3zG106Io03d08wLl1XY6CwLC/WBGJ8WZkuGPkhKCJpcxGc
 5VOQvgPLaNyce6ChasXEc3J5FgL8rYZFjBhJ66EhaAmskAZtSuA4xwLgA
 Ao23RR07LW8xaYJdlVUG1YU1O5F43JEMIuEY9ZtqPmYqmU9wqg9UpjJKa
 j+VhULzjMVZ4Pv4tBHg8mIOmN1PvHa8pf7aw8n0E6Xjn5VlwMuWfvc7YE
 M+Urm12kXlC+D8qAp9TRWJ4oXql5flyd4R0XVedDqQQbWrQNVECw9V7Zv
 e1X9odF8ffNspuSKLnMhlBi99PYeELwxOyd3STS+fQ501p1eN8tElAFIM g==;
X-CSE-ConnectionGUID: McUrfGOhQneWaHmOMDvemQ==
X-CSE-MsgGUID: aJd96eDOReyhYqi5Kd7n3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107529"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107529"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:29:55 -0700
X-CSE-ConnectionGUID: f5COFi+MQDy4M/4RmxhJ6A==
X-CSE-MsgGUID: ksyDQAxjRDaVIcXPTTretw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541273"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:53 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v2 03/10] idpf: get rid of msix_entries array
Date: Fri, 11 Sep 2026 14:49:14 +0200
Message-ID: <20260911124921.2881348-4-michal.swiatkowski@linux.intel.com>
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

There is no special need for storing MSI-X info in one array. Instead
move this data into q_vector where it is commonly used. With that one
layer of accessing correct kernel irq line number can be dropped.

Moving pci_irq_vector() after q_vectors creation will be useful when
switching to dynamic irq allocation.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |  2 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 45 ++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 61 +++++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  5 +-
 4 files changed, 51 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 5eafabacd167..86e5bb30ecc6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -668,7 +668,6 @@ struct idpf_irq_info {
  * @xnm: Xn transaction manager
  * @num_avail_msix: Available number of MSIX vectors
  * @num_msix_entries: Number of entries in MSIX table
- * @msix_entries: MSIX table
  * @num_rdma_msix_entries: Available number of MSIX vectors for RDMA
  * @rdma_msix_entries: RDMA MSIX table
  * @irq_info: hardware data needed to setup irq
@@ -728,7 +727,6 @@ struct idpf_adapter {
 	struct libie_ctlq_xn_manager *xnm;
 	u16 num_avail_msix;
 	u16 num_msix_entries;
-	struct msix_entry *msix_entries;
 	u16 num_rdma_msix_entries;
 	struct msix_entry *rdma_msix_entries;
 	struct virtchnl2_alloc_vectors *req_vec_chunks;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 36bb6a268042..5a2975081227 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -73,7 +73,7 @@ void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
 	if (!test_and_clear_bit(IDPF_MB_INTR_MODE, adapter->flags))
 		return;
 
-	kfree(free_irq(adapter->msix_entries[0].vector, adapter));
+	kfree(free_irq(adapter->mb_vector.irq.virq, adapter));
 	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
 }
 
@@ -83,15 +83,10 @@ void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
  */
 void idpf_intr_rel(struct idpf_adapter *adapter)
 {
-	if (!adapter->msix_entries)
-		return;
-
 	idpf_mb_intr_rel_irq(adapter);
 	pci_free_irq_vectors(adapter->pdev);
 	idpf_send_dealloc_vectors_msg(adapter);
 	idpf_deinit_vector_stack(adapter);
-	kfree(adapter->msix_entries);
-	adapter->msix_entries = NULL;
 	kfree(adapter->rdma_msix_entries);
 	adapter->rdma_msix_entries = NULL;
 }
@@ -130,14 +125,14 @@ static void idpf_mb_irq_enable(struct idpf_adapter *adapter)
  */
 static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 {
-	int irq_num, mb_vidx = 0, err;
+	struct msi_map *irq = &adapter->mb_vector.irq;
 	char *name;
+	int err;
 
-	irq_num = adapter->msix_entries[mb_vidx].vector;
 	name = kasprintf(GFP_KERNEL, "%s-%s-%d",
 			 dev_driver_string(&adapter->pdev->dev),
-			 "Mailbox", mb_vidx);
-	err = request_irq(irq_num, adapter->irq_mb_handler, 0, name, adapter);
+			 "Mailbox", irq->index);
+	err = request_irq(irq->virq, adapter->irq_mb_handler, 0, name, adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
@@ -156,6 +151,13 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
  */
 static int idpf_mb_intr_init(struct idpf_adapter *adapter)
 {
+	struct msi_map *mb_irq = &adapter->mb_vector.irq;
+
+	mb_irq->index = IDPF_MBX_IRQ_INDEX;
+	mb_irq->virq = pci_irq_vector(adapter->pdev, mb_irq->index);
+	if (mb_irq->virq < 0)
+		return mb_irq->virq;
+
 	adapter->dev_ops.reg_ops.mb_intr_reg_init(adapter);
 	adapter->irq_mb_handler = idpf_mb_intr_clean;
 
@@ -309,7 +311,6 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 	u16 default_vports = idpf_get_default_vports(adapter);
 	int min_vectors, actual_vecs, min_lan_vecs, err;
 	int num_q_vecs, total_vecs;
-	unsigned int vector;
 	int i;
 
 	total_vecs = idpf_get_reserved_vecs(adapter);
@@ -368,23 +369,12 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 	}
 
 	num_lan_vecs = actual_vecs - num_rdma_vecs;
-	adapter->msix_entries = kzalloc_objs(struct msix_entry, num_lan_vecs);
-	if (!adapter->msix_entries) {
-		err = -ENOMEM;
-		goto free_rdma_msix;
-	}
 
-	for (vector = 0; vector < num_lan_vecs; vector++) {
-		adapter->msix_entries[vector].entry =
-			adapter->irq_info.vectors[vector].idx;
-		adapter->msix_entries[vector].vector =
-			pci_irq_vector(adapter->pdev, vector);
-	}
-	for (i = 0; i < num_rdma_vecs; vector++, i++) {
+	for (i = 0; i < num_rdma_vecs; i++) {
 		adapter->rdma_msix_entries[i].entry =
-			adapter->irq_info.vectors[vector].idx;
+			adapter->irq_info.vectors[num_lan_vecs + i].idx;
 		adapter->rdma_msix_entries[i].vector =
-			pci_irq_vector(adapter->pdev, vector);
+			pci_irq_vector(adapter->pdev, num_lan_vecs + i);
 	}
 
 	/* 'num_avail_msix' is used to distribute excess vectors to the vports
@@ -399,7 +389,7 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 	/* Fill MSIX vector lifo stack with vector indexes */
 	err = idpf_init_vector_stack(adapter);
 	if (err)
-		goto free_msix;
+		goto free_rdma_msix;
 
 	err = idpf_mb_intr_init(adapter);
 	if (err)
@@ -410,9 +400,6 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 
 deinit_vec_stack:
 	idpf_deinit_vector_stack(adapter);
-free_msix:
-	kfree(adapter->msix_entries);
-	adapter->msix_entries = NULL;
 free_rdma_msix:
 	kfree(adapter->rdma_msix_entries);
 	adapter->rdma_msix_entries = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 00c8fe692821..c75fc1fc4f64 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3863,27 +3863,19 @@ static void idpf_q_vector_set_napi(struct idpf_q_vector *q_vector, bool link)
 
 /**
  * idpf_vport_intr_rel_irq - Free the IRQ association with the OS
- * @vport: main vport structure
  * @rsrc: pointer to queue and vector resources
  */
-static void idpf_vport_intr_rel_irq(struct idpf_vport *vport,
-				    struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vport_intr_rel_irq(struct idpf_q_vec_rsrc *rsrc)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-
-	for (u16 vector = 0; vector < rsrc->num_q_vectors; vector++) {
+	for (int vector = 0; vector < rsrc->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[vector];
-		int irq_num, vidx;
 
 		/* free only the irqs that were actually requested */
 		if (!q_vector)
 			continue;
 
-		vidx = rsrc->q_vector_idxs[vector];
-		irq_num = adapter->msix_entries[vidx].vector;
-
 		idpf_q_vector_set_napi(q_vector, false);
-		kfree(free_irq(irq_num, q_vector));
+		kfree(free_irq(q_vector->irq.virq, q_vector));
 	}
 }
 
@@ -4052,7 +4044,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	const char *drv_name, *if_name, *vec_name;
-	int vector, err, irq_num, vidx;
+	int vector, err, vidx;
 
 	vidx = rsrc->q_vector_idxs[rsrc->num_q_vectors];
 	adapter->dev_ops.reg_ops.noirq_intr_reg_init(adapter, rsrc, vidx);
@@ -4062,10 +4054,10 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 
 	for (vector = 0; vector < rsrc->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[vector];
+		int virq = q_vector->irq.virq;
 		char *name;
 
 		vidx = rsrc->q_vector_idxs[vector];
-		irq_num = adapter->msix_entries[vidx].vector;
 
 		adapter->dev_ops.reg_ops.intr_reg_init(adapter, q_vector, vidx);
 
@@ -4081,8 +4073,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
 				 vec_name, vector);
 
-		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
-				  name, q_vector);
+		err = request_irq(virq, idpf_vport_intr_clean_queues, 0, name,
+				  q_vector);
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
@@ -4096,9 +4088,9 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 
 free_q_irqs:
 	while (--vector >= 0) {
-		vidx = rsrc->q_vector_idxs[vector];
-		irq_num = adapter->msix_entries[vidx].vector;
-		kfree(free_irq(irq_num, &rsrc->q_vectors[vector]));
+		int virq = rsrc->q_vectors[vector].irq.virq;
+
+		kfree(free_irq(virq, &rsrc->q_vectors[vector]));
 	}
 
 	return err;
@@ -4194,7 +4186,7 @@ void idpf_vport_intr_deinit(struct idpf_vport *vport,
 	idpf_vport_intr_napi_dis_all(rsrc);
 	idpf_vport_intr_dis_dim_all(rsrc);
 	idpf_vport_intr_napi_del_all(rsrc);
-	idpf_vport_intr_rel_irq(vport, rsrc);
+	idpf_vport_intr_rel_irq(rsrc);
 }
 
 /**
@@ -4507,18 +4499,30 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
  * @rsrc: pointer to queue and vector resources
  *
  * Initialize vector indexes with values returned over mailbox.
+ *
+ * Return: 0 on success, negative on failure
  */
-static void idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
-					 struct idpf_q_vec_rsrc *rsrc)
+static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
+					struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	int i;
 
-	for (i = 0; i < rsrc->num_q_vectors; i++)
-		rsrc->q_vectors[i].v_idx =
+	for (i = 0; i < rsrc->num_q_vectors; i++) {
+		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
+
+		q_vector->v_idx =
 			adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
+		q_vector->irq.index = rsrc->q_vector_idxs[i];
+		q_vector->irq.virq = pci_irq_vector(adapter->pdev,
+						    q_vector->irq.index);
+		if (q_vector->irq.virq < 0)
+			return q_vector->irq.virq;
+	}
 
 	rsrc->noirq_v_idx = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
+
+	return 0;
 }
 
 /**
@@ -4530,8 +4534,6 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport,
 					 struct idpf_q_vec_rsrc *rsrc)
 {
 	int (*napi_poll)(struct napi_struct *napi, int budget);
-	int irq_num;
-	u16 qv_idx;
 
 	if (idpf_is_queue_model_split(rsrc->txq_model))
 		napi_poll = idpf_vport_splitq_napi_poll;
@@ -4541,12 +4543,9 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport,
 	for (u16 v_idx = 0; v_idx < rsrc->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[v_idx];
 
-		qv_idx = rsrc->q_vector_idxs[v_idx];
-		irq_num = vport->adapter->msix_entries[qv_idx].vector;
-
 		netif_napi_add_config(vport->netdev, &q_vector->napi,
 				      napi_poll, v_idx);
-		netif_napi_set_irq(&q_vector->napi, irq_num);
+		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
 	}
 }
 
@@ -4649,7 +4648,9 @@ int idpf_vport_intr_init(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 {
 	int err;
 
-	idpf_vport_intr_init_vec_idx(vport, rsrc);
+	err = idpf_vport_intr_init_vec_idx(vport, rsrc);
+	if (err)
+		return err;
 
 	idpf_vport_intr_map_vector_to_qs(vport, rsrc);
 	idpf_vport_intr_napi_add_all(vport, rsrc);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index ecff84df776d..57e61936ffda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -6,6 +6,7 @@
 
 #include <linux/dim.h>
 #include <linux/net/intel/virtchnl2_lan_desc.h>
+#include <linux/pci.h>
 
 #include <net/libeth/cache.h>
 #include <net/libeth/types.h>
@@ -377,6 +378,7 @@ struct idpf_intr_reg {
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
  * @v_idx: Vector index
+ * @irq: kernel and driver irq numbers
  */
 struct idpf_q_vector {
 	__cacheline_group_begin_aligned(read_mostly);
@@ -418,12 +420,13 @@ struct idpf_q_vector {
 	__cacheline_group_begin_aligned(cold);
 	u16 v_idx;
 
+	struct msi_map irq;
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 136,
 			    56 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
-			    8);
+			    8 + sizeof(struct msi_map));
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
-- 
2.49.0

