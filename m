Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CAFC88E5A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A662180F17;
	Fri, 11 Sep 2026 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AJ_Bw6ntmTX; Fri, 11 Sep 2026 13:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D636280F37
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133463;
	b=mkpbHfs7RAkfSshFE5bcv1TRlrKe/CpA1zn6iDKi5scmmwGgP7Eb9jELjiM2i9CJ/y1B
	 cMmAVC4iIqcK2OfhHmtvy8KQ/lZ/X1uCs8u55v4bLElQ5adqijU8Xb7LdhA1qs6p7EoaO
	 DnsW3wQMebS3DPmeNJ1AVPRGgkM/Rts5UKRbmPYh0LIg/35cPVHfpVcjugHkHlHwnhosF
	 jUr0tRBRuFcRveOuo2hfCSfgZ9kdP9ewon4KsHPDM4ayOgmytmxs/RDfH71XoeUBAbKeU
	 Rfa/FP885vQWDtnFbxiLMK5G4Hc5Es45BaelyM9IRhklP97kUUOu2Lsx5LuR+A4AnBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9TIXdiAQRiXLZvGbjpoATQTNDLDiGuxnIaABVGOCLeI=;
	b=lVDxb3yE0mjTo3KmBCmN93u7+uQZWg10FEV8yQ6ytZans2vPyzXKf5KCtur6eIkbldvo
	 BGv+TnmzMmH64YgD7o/WvWuMtm7impTRQyKE4ffxhnDjngAJhnszs1HWvsq8NgpJoPMKM
	 Aswp1vBX9UNqanNHknqhrNg+jWoAkUeOq3hNiZWxvwXVrA7U66XQj+Z4qzTIbxUC34D1K
	 qSjF/jzjBrDcf7dHS4yBCxGwWdIcnL95BPPXVNs1hqdKX8b0nLrDYJpns03+73S6PyESi
	 H27r2YdK3y29Vj5zKXrdtrfnp3EYzppWlAjmpt2YTpsweRDu8RYZUQ+e8iHsyyO2BKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133463;
	bh=9TIXdiAQRiXLZvGbjpoATQTNDLDiGuxnIaABVGOCLeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CanwCsMJf/QPohs2EwKIsEFiEYlNe4kytMr1aZJt5n9J6qebyVURQryAGdoMPBy4f
	 4wrP1FFmLGCfJcAJmhGQIutgsIGcC3+rRZwNznZMAmTCH/5FX06qx3uo504bmdhKaT
	 8glNSUSUjbv657kKckmHZHYf9XJeREH0SlzC9UC7BqVDRDj2sB4QowCjHbGURmwJKc
	 amoe3CjaLF+ggiZVjdUZ9hCkue2Ldv9koeyd35epgJMS+eIy98SRS24tDEwrFkTkpQ
	 EqALSTt/xIms5QwdTReZp6PxpRWlfvNf7RsZezqByhWL1gNKPP7iIRgd1/XWdd/hnJ
	 6qaRZp5Y2BzFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D636280F37;
	Fri, 11 Sep 2026 13:31:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01B3F32F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAAB040827
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gc0zr_aNDkqF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F3CD340811
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133461;
 b=Z7OCNK4G2zI+P7GYXaKxlQPxsCBQhwEGCPCQrx8YYcp0/Y0IclAk4S0HzbDUTv7WkxEJ
 ZGpLGO4+syWzMZ2hncFaWIf/muImDlQM49G+1rzYHyYntEUDMquCuq+oHLjPYs6xQIlBw
 JKkxYQ7dgkBFEv1vwzH2gZzlKJ2qBro1wkhPRIFJYwfMMmXt/s7AWgK6qO0AEHClMeEAz
 a+OGS/SIfcsFFGQxGIRsY8qYo8gUB9yoqt2WPVxhJKfqcBq0ASzh05/UvAiUioOwHsoxR
 v6PFxitMYWa7g6G3TRefV1it0kKKDVXQvtR+O1qcjuWmgagHPUt4BEyXy97de6FK6fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133461;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=9TIXdiAQRiXLZvGbjpoATQTNDLDiGuxnIaABVGOCLeI=;
 b=KCtUFtW7MpYluVz9yJgN68rbI2HpDAF3ykQSp2iuSEnO5JvXD/cq04nA9v3Eg/Dx+aUZ
 DR2pfX7WYWWGk7/fvrltQSYxDZ3zTIhrdMwWBV5K1onzYKpV8jY9iak2csOdO2iyjMyxe
 uP+tUpU0lqUkl3tSF5xF19z0PxnoI04vyTr4TmfbImgq/tTDZQxWOuWRCfH20kxhPjaPP
 RTin76wnMCdynoGXPkVRRW3Zq/GqS2cbHBLRFEib0MJbW49ce0/CTZyALy2m1Q2hrGC87
 86+tkLIrP1cIywdLsibisE0FfuWr4Kzcz0Q8txPkD/vJBJ6nUSOOOzoUGLWHMVDUSHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YuSODjIJ; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YuSODjIJ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3CD340811
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133461; x=1820669461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yVhsmNpID+W4FiJg2NDz+omL4TIrecJz6r5xnmBMFqA=;
 b=YuSODjIJSrOVYPBhn74vIVZhi27LKodjeuX1Wu/afzj7uGOWgLiHRYdM
 rPxNvBLyNp3oQUnf8HoeqgM+tgG2UF8u1nRp/AtreXiJBlH1WRIYbhUf9
 bbxXhDQjQyFxnIUCPwGPmIqbhmBTmIhQ5LSF/xSCb4ejEkmJqaiT9pArb
 qefiIsvhu0MxeiYqW/bYap4r/TmiSaWrkAFdnx6W05vBcO9IdwcKClfwO
 k2oyeakV3uKXNu5ISxuUImn0xgZzjwfnOY3TuAmslgBP/0K0X4Ct2vQ2s
 wMesjtNTSLiK3uPaTE+VrPqq7CasgHNxfHOAnBUZF1g1ctQKyBQZLXrQu A==;
X-CSE-ConnectionGUID: fpRtB1TXSmWd+OdhTD95Xw==
X-CSE-MsgGUID: 8EPiR2TsQi6dpY2sj7ruPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107536"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107536"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:30:00 -0700
X-CSE-ConnectionGUID: 6tkvScr+RrSHBX34cCo8NA==
X-CSE-MsgGUID: 7jld3dVeS7CSxTcxII4fSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541282"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:59 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 06/10] libie,
 idpf: move hardware irq info struct to libie
Date: Fri, 11 Sep 2026 14:49:17 +0200
Message-ID: <20260911124921.2881348-7-michal.swiatkowski@linux.intel.com>
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

Manually move definition related to irq info from idpf to libie_irq.
s/idpf_/libie_

It will be used by idpf and ixd driver.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 36 +------------------
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  8 ++---
 include/linux/net/intel/libie/irq.h           | 34 ++++++++++++++++++
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 51f447135693..33ee30424b77 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -577,40 +577,6 @@ struct idpf_vport_config {
 	     iter = (++__##iter) < &(adapter)->vports[(adapter)->max_vports] ? \
 	     *__##iter : NULL)
 
-/**
- * struct idpf_vec_regs - hardware registers related to vector
- * @dyn_ctl: Dynamic control interrupt register offset
- * @itrn: Interrupt Throttling Rate register offset
- * @itrn_index_spacing: Register spacing between ITR registers of the same
- *			vector
- */
-struct idpf_vec_regs {
-	u32 dyn_ctl;
-	u32 itrn;
-	u32 itrn_index_spacing;
-};
-
-/**
- * struct idpf_hw_vector - single hardware vector info
- * @regs: address of irq registers
- * @idx: hardware vector index
- */
-struct idpf_hw_vector {
-	struct idpf_vec_regs regs;
-	int idx;
-};
-
-/**
- * struct idpf_irq_info - hardware data needed to setup irq
- * @vectors: allocated during initialization store hardware information
- *	     for all vectors that can be used on a whole device
- * @num: amount of vectors stored here
- */
-struct idpf_irq_info {
-	struct idpf_hw_vector *vectors;
-	int num;
-};
-
 /**
  * struct idpf_rdma_irq - RDMA interrupt vectors data
  * @entries: MSIX table shared with the RDMA auxiliary device
@@ -695,7 +661,7 @@ struct idpf_adapter {
 	struct idpf_rdma_irq rdma_irq;
 	struct libie_irq irq;
 	struct virtchnl2_alloc_vectors *req_vec_chunks;
-	struct idpf_irq_info irq_info;
+	struct libie_irq_info irq_info;
 	struct idpf_q_vector mb_vector;
 	irqreturn_t (*irq_mb_handler)(int irq, void *data);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index cd947fd24ff6..61f5e8e4d20b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -87,7 +87,7 @@ static void idpf_noirq_intr_reg_init(struct idpf_adapter *adapter,
 static void idpf_intr_reg_init(struct idpf_adapter *adapter,
 			       struct idpf_q_vector *q_vector, u16 idx)
 {
-	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct libie_hw_vector *v = &adapter->irq_info.vectors[idx];
 	struct idpf_intr_reg *intr = &q_vector->intr_reg;
 	struct libie_mmio_info *mmio;
 	u32 rx_itr, tx_itr;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index df3eabe12b18..4c1c2476613b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -86,7 +86,7 @@ static void idpf_vf_noirq_intr_reg_init(struct idpf_adapter *adapter,
 static void idpf_vf_intr_reg_init(struct idpf_adapter *adapter,
 				  struct idpf_q_vector *q_vector, u16 idx)
 {
-	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct libie_hw_vector *v = &adapter->irq_info.vectors[idx];
 	struct idpf_intr_reg *intr = &q_vector->intr_reg;
 	struct libie_mmio_info *mmio;
 	u32 rx_itr, tx_itr;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 65ddc6f893fc..20e471def235 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1855,7 +1855,7 @@ idpf_prep_map_unmap_queue_set_vector_msg(u32 vport_id, void *buf,
  */
 static int
 idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
-					 const struct idpf_irq_info *info,
+					 const struct libie_irq_info *info,
 					 bool map)
 {
 	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
@@ -2238,14 +2238,14 @@ int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
  *
  * Returns 0 on success, negative on failure.
  */
-static int idpf_create_vectors_info(struct idpf_irq_info *info,
+static int idpf_create_vectors_info(struct libie_irq_info *info,
 				    const struct virtchnl2_get_capabilities *caps,
 				    const struct virtchnl2_alloc_vectors *vectors,
 				    const u16 num_vectors)
 {
 	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
 	int all_vectors = num_vectors + IDPF_MBX_Q_VEC;
-	struct idpf_hw_vector *vector;
+	struct libie_hw_vector *vector;
 	int reg_cnt;
 
 	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
@@ -2266,7 +2266,7 @@ static int idpf_create_vectors_info(struct idpf_irq_info *info,
 	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
 		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
 		u32 dyn_spacing, itrn_spacing;
-		struct idpf_vec_regs reg_val;
+		struct libie_vec_regs reg_val;
 		u16 vec_id;
 
 		reg_val.dyn_ctl = le32_to_cpu(chunk->dynctl_reg_start);
diff --git a/include/linux/net/intel/libie/irq.h b/include/linux/net/intel/libie/irq.h
index 8af8fc22ab09..e219fde575d8 100644
--- a/include/linux/net/intel/libie/irq.h
+++ b/include/linux/net/intel/libie/irq.h
@@ -64,6 +64,40 @@ struct libie_irq {
 	struct xarray entries;
 };
 
+/**
+ * struct libie_vec_regs - hardware registers related to vector
+ * @dyn_ctl: Dynamic control interrupt register offset
+ * @itrn: Interrupt Throttling Rate register offset
+ * @itrn_index_spacing: Register spacing between ITR registers of the same
+ *			vector
+ */
+struct libie_vec_regs {
+	u32 dyn_ctl;
+	u32 itrn;
+	u32 itrn_index_spacing;
+};
+
+/**
+ * struct libie_hw_vector - single hardware vector info
+ * @regs: address of irq registers
+ * @idx: hardware vector index
+ */
+struct libie_hw_vector {
+	struct libie_vec_regs regs;
+	int idx;
+};
+
+/**
+ * struct libie_irq_info - hardware data needed to setup irq
+ * @vectors: allocated during initialization store hardware information
+ *	     for all vectors that can be used on a whole device
+ * @num: amount of vectors stored here
+ */
+struct libie_irq_info {
+	struct libie_hw_vector *vectors;
+	int num;
+};
+
 int libie_irq_init(struct libie_irq *irq, struct pci_dev *pdev,
 		   int min, int max);
 void libie_irq_deinit(struct libie_irq *irq);
-- 
2.49.0

