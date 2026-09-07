Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C58FC79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E60C280C88;
	Mon,  7 Sep 2026 11:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxUhTHKli-5q; Mon,  7 Sep 2026 11:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E70480C7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779063;
	b=rXB1xpAFKsO/Elq3l1cDAub6XsC2rY9tn3u+mSEw0Zy2R1B/TKUpkms3ZYvirOAjwxqC
	 OtztwkylAaEy8WOU5Qepj/tIK4ElBNZNF2+4Ob1kIPjJj06Yx7jNVUZccy3Dice9tkScH
	 YcQdr+1ZVa1UgI2w3vnPe9pZu8/ncDUIbupYAhcfDdB3OwZ1GGUuC5EFvpkYJTKtqlSXV
	 HPGRButcRL+AeGszpb+z7wFqw4/e+QMCqr/iif1WCF08bgTqaSg5vh/l/suqIfTH4jswe
	 ZfQHld65GYKe2qg25hJT7AV7bE+f+Mezizuj7V6N/VveuovgndYrJUmuT5hKN/TpgyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qLHyENhhaho3kr7Fue/Pz0TIbAHm+g8DOvlm8TQrfeU=;
	b=U3mRQOPwsDCAncu8V/WDSoD3GfFBrzaSqcDZwRKDxKHUX++bzRjbQq7bE0295pFKIB0S
	 dxsJeFHlznIZ/ws9l+2xsj8eznJO69zd8DWLdfEf/GDaGP2Ut7jX2va3mOU8arQYppC/1
	 z9qdI5udvU+tzyG0zlZLchX4fOQweaSW79rlRnU2zsN3HSRIPix14nRwMv+g3PeEv21Bb
	 41mN58bT7i5Lrrgl/k6GiBq9vEGvi6jHBFXDHZTBlK2ilp0QAb9jMtV8DSPSf9MmETZin
	 YuHFnztkw4Mq07qibuphO/oMORG2qASk7leEms2C++RSAhY54YOYM8YuGkPWdvVyl9A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g2pcRUke;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779063;
	bh=qLHyENhhaho3kr7Fue/Pz0TIbAHm+g8DOvlm8TQrfeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btZrjDyps0qV+G4KLtF/QnvFtdUxTYYFCjVhmd+Tz9RTX8NwNvCKIs6SIN/4pgX8l
	 jzq18/DAaGxJbUIDrMtONbejwc3Hsc4fVVzNM5Mp9VV+xo1f8wMN2S7W0ctrW6HR9D
	 KFELHxb5IxCPUh7TrRK4uKGFCcNVul0cNEXp/4nSXIp4Nxq7aVp7T/MFGJXfuHpbqx
	 bna/UZ4mavE4wYL4mVUiVEUVvxJ18/qdT/ZO0OXzxNkv4eqDBjTbLnH7wprtfpa3LF
	 y2yWd0M9dkcAzhye1ZGAN+uGlLq+PBonajcURgBdw6zP1fzvselxJjdcnguEA7/IhG
	 mScHvTXShC3Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E70480C7E;
	Mon,  7 Sep 2026 11:04:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A810B9CF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E37180C93
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SH8MDZfd91zz for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D114480ABD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779060;
 b=Alf85LAU89SqY1lJ8lMZkaPBiMOKJ+FQKXUA9qT2WXo+K38W+zm9wifuUX07aZ+NSOzu
 CiwSFhPe8RG55gLDHywcvVBOvskLHA13CVDycJ7NCCZiLpdkef/PTh3VZnh7yZoL+erHc
 vxX6iRg5sHr8XQxpBcdHLIPuMVJl/FNcWLVtO5f/uh39OaMhb7xzxFYLsY4M7gRZfN7J9
 g6Ii0argu1t+YKvhpRkzP5v5Y/twRhC8Cw2MaUk5TkdHmNsg+9QJ7wkDd+zLprK3mPyhZ
 au0KjnDki/zJBjujLytnoPxQSQtfMhnmSD99lCGDHVnICnRSCx2rYzMP5ZNraEGVwXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779060;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qLHyENhhaho3kr7Fue/Pz0TIbAHm+g8DOvlm8TQrfeU=;
 b=sWsTPqSlgWxZAZoa9SORFlHoZxRZJQPK8vLwQfLrALSoXXCdRz7L1AQG/HsZHVkQJrXP
 VcpS1qzt+8Vt1aERZ90Z6rL7h6uu7U9oYWkNie5u7MM06J+NTOyIVvMrc+4p/1nrmVymw
 sPo4SbF9iOzXhmsnR9UMFV5HlUfbA35VgN5uK1Ie1a30/cgW0pkVOUzy/RGXL4KN8uqBI
 A34RI2u4YlopZiavwZwRMYbzmwj7oa+Hv9iFpVXcUoDWYGFIuQZM8x22j7LXR0tvZh6nE
 1ACNBloLjjaxMA/CWwHIbe2eb1pcyNGEycr+vJQgQVDtd0E1Hovx0PjaE2d6ThfOQLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g2pcRUke; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g2pcRUke
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D114480ABD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779060; x=1820315060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P7KYpg5UPwC7kIRKVXnoSQn7FyGdFoWe6ZzbbKhMvic=;
 b=g2pcRUkeg5fyaGrmTulHhRQDAYAmcvCqZ9lvoLorRpLLtnSee9n59g6r
 wkRRtaaDqwscDWKwx8od6ZcFPVT7p9ktKh6e7c7eRE5OyVJ1m2WyGRJnv
 nhdOiM3KLEPAB5mhsxFHnJwWChs1jvLw+jN+AdL+hgDIqUj5SbDr3a5Ir
 NToujCwmtV93ih4ZU88d2rLUJrrfzL3bX3sxQSrFvYGwLbzY+HIKvSKQn
 7/0siurO3by1bquJQYOa+rDxdVoX5di/7Wi8dyXliFbnm+D3oLwzi2YDC
 8s+Wt3fPxxPMbupOjTCHBaiZ4NQvk+GBOKnExi7H2KxbmqUFsx5it+ZPK g==;
X-CSE-ConnectionGUID: K8tidlO8TDCKdeJMNLMzZA==
X-CSE-MsgGUID: 5t8XsahrQrWkL1442yH/nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214064"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214064"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:19 -0700
X-CSE-ConnectionGUID: TSK6c8ilR3aWinYmqLdmlg==
X-CSE-MsgGUID: 3Yq7+LwsRSmC9kxhK1qFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195325"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:17 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v1 02/10] idpf: fill q_vector interrupt registers one
 by one
Date: Mon,  7 Sep 2026 12:24:09 +0200
Message-ID: <20260907102418.2697317-3-michal.swiatkowski@linux.intel.com>
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

Most structures pointer used in *_intr_reg_init() are already used in
idpf_vport_intr_req_irq(). Use it by rewriting *_intr_reg_init() to
fill one q_vector in one call.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 91 +++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  7 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 92 ++++++++++---------
 4 files changed, 105 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 84b145431693..5eafabacd167 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -197,6 +197,7 @@ struct idpf_vport_max_q {
  * struct idpf_reg_ops - Device specific register operation function pointers
  * @ctlq_reg_init: Mailbox control queue register initialization
  * @intr_reg_init: Traffic interrupt register initialization
+ * @noirq_intr_reg_init: Vector without interrupt register initialization
  * @mb_intr_reg_init: Mailbox interrupt register initialization
  * @reset_reg_init: Reset register initialization
  * @trigger_reset: Trigger a reset to occur
@@ -205,8 +206,10 @@ struct idpf_vport_max_q {
 struct idpf_reg_ops {
 	void (*ctlq_reg_init)(struct libie_mmio_info *mmio,
 			      struct libie_ctlq_create_info *cctlq_info);
-	void (*intr_reg_init)(struct idpf_vport *vport,
-			      struct idpf_q_vec_rsrc *rsrc);
+	void (*intr_reg_init)(struct idpf_adapter *adapter,
+			      struct idpf_q_vector *q_vector, u16 idx);
+	void (*noirq_intr_reg_init)(struct idpf_adapter *adapter,
+				    struct idpf_q_vec_rsrc *rsrc, u16 idx);
 	void (*mb_intr_reg_init)(struct idpf_adapter *adapter);
 	void (*reset_reg_init)(struct idpf_adapter *adapter);
 	void (*trigger_reset)(struct idpf_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 42e65f1285df..cd947fd24ff6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -58,53 +58,17 @@ static void idpf_mb_intr_reg_init(struct idpf_adapter *adapter)
 }
 
 /**
- * idpf_intr_reg_init - Initialize interrupt registers
- * @vport: virtual port structure
- * @rsrc: pointer to queue and vector resources
+ * idpf_noirq_intr_reg_init - Initialize noirq registers
+ * @adapter: adapter structure
+ * @rsrc: to store noirq register and value
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
  */
-static void idpf_intr_reg_init(struct idpf_vport *vport,
-			       struct idpf_q_vec_rsrc *rsrc)
+static void idpf_noirq_intr_reg_init(struct idpf_adapter *adapter,
+				     struct idpf_q_vec_rsrc *rsrc, u16 idx)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	int num_vecs = rsrc->num_q_vectors;
-	struct libie_mmio_info *mmio;
-	u32 rx_itr, tx_itr, val;
-	int i;
-
-	mmio = &adapter->ctlq_ctx.mmio_info;
+	u32 val = adapter->irq_info.vectors[idx].regs.dyn_ctl;
 
-	for (i = 0; i < num_vecs; i++) {
-		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
-		struct idpf_intr_reg *intr = &q_vector->intr_reg;
-		u16 vec_id = rsrc->q_vector_idxs[i];
-		struct idpf_hw_vector *v;
-		u32 spacing;
-
-		v = &adapter->irq_info.vectors[vec_id];
-
-		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
-		intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
-		intr->dyn_ctl_intena_msk_m = PF_GLINT_DYN_CTL_INTENA_MSK_M;
-		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
-		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
-		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
-		intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
-		intr->dyn_ctl_sw_itridx_ena_m =
-			PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
-
-		spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
-					       IDPF_PF_ITR_IDX_SPACING);
-		rx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
-					   spacing);
-		tx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
-					   spacing);
-		intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
-		intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
-	}
-
-	/* Data vector for NOIRQ queues */
-
-	val = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].regs.dyn_ctl;
 	rsrc->noirq_dyn_ctl =
 		libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info, val);
 
@@ -113,6 +77,44 @@ static void idpf_intr_reg_init(struct idpf_vport *vport,
 	rsrc->noirq_dyn_ctl_ena = val;
 }
 
+/**
+ * idpf_intr_reg_init - Initialize interrupt registers
+ * @adapter: adapter structure
+ * @q_vector: q_vector in which the registers should be initialized
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
+ */
+static void idpf_intr_reg_init(struct idpf_adapter *adapter,
+			       struct idpf_q_vector *q_vector, u16 idx)
+{
+	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct idpf_intr_reg *intr = &q_vector->intr_reg;
+	struct libie_mmio_info *mmio;
+	u32 rx_itr, tx_itr;
+	u32 spacing;
+
+	mmio = &adapter->ctlq_ctx.mmio_info;
+
+	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
+	intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
+	intr->dyn_ctl_intena_msk_m = PF_GLINT_DYN_CTL_INTENA_MSK_M;
+	intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
+	intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
+	intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
+	intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
+	intr->dyn_ctl_sw_itridx_ena_m =
+		PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
+
+	spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
+				       IDPF_PF_ITR_IDX_SPACING);
+	rx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
+				   spacing);
+	tx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
+				   spacing);
+	intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
+	intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
+}
+
 /**
  * idpf_reset_reg_init - Initialize reset registers
  * @adapter: Driver specific private structure
@@ -171,6 +173,7 @@ static void idpf_reg_ops_init(struct idpf_adapter *adapter)
 {
 	adapter->dev_ops.reg_ops.ctlq_reg_init = idpf_ctlq_reg_init;
 	adapter->dev_ops.reg_ops.intr_reg_init = idpf_intr_reg_init;
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init = idpf_noirq_intr_reg_init;
 	adapter->dev_ops.reg_ops.mb_intr_reg_init = idpf_mb_intr_reg_init;
 	adapter->dev_ops.reg_ops.reset_reg_init = idpf_reset_reg_init;
 	adapter->dev_ops.reg_ops.trigger_reset = idpf_trigger_reset;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2b21f599f569..00c8fe692821 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4054,6 +4054,9 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 	const char *drv_name, *if_name, *vec_name;
 	int vector, err, irq_num, vidx;
 
+	vidx = rsrc->q_vector_idxs[rsrc->num_q_vectors];
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init(adapter, rsrc, vidx);
+
 	drv_name = dev_driver_string(&adapter->pdev->dev);
 	if_name = netdev_name(vport->netdev);
 
@@ -4064,6 +4067,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 		vidx = rsrc->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
 
+		adapter->dev_ops.reg_ops.intr_reg_init(adapter, q_vector, vidx);
+
 		if (q_vector->num_rxq && q_vector->num_txq)
 			vec_name = "TxRx";
 		else if (q_vector->num_rxq)
@@ -4649,8 +4654,6 @@ int idpf_vport_intr_init(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 	idpf_vport_intr_map_vector_to_qs(vport, rsrc);
 	idpf_vport_intr_napi_add_all(vport, rsrc);
 
-	vport->adapter->dev_ops.reg_ops.intr_reg_init(vport, rsrc);
-
 	err = idpf_vport_intr_req_irq(vport, rsrc);
 	if (err)
 		goto unroll_vectors_alloc;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index c0080842b7e2..df3eabe12b18 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -57,53 +57,17 @@ static void idpf_vf_mb_intr_reg_init(struct idpf_adapter *adapter)
 }
 
 /**
- * idpf_vf_intr_reg_init - Initialize interrupt registers
- * @vport: virtual port structure
- * @rsrc: pointer to queue and vector resources
+ * idpf_vf_noirq_intr_reg_init - Initialize noirq registers
+ * @adapter: adapter structure
+ * @rsrc: to store noirq register and value
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
  */
-static void idpf_vf_intr_reg_init(struct idpf_vport *vport,
-				  struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vf_noirq_intr_reg_init(struct idpf_adapter *adapter,
+					struct idpf_q_vec_rsrc *rsrc, u16 idx)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	int num_vecs = rsrc->num_q_vectors;
-	struct libie_mmio_info *mmio;
-	u32 rx_itr, tx_itr, val;
-	int i;
-
-	mmio = &adapter->ctlq_ctx.mmio_info;
+	u32 val = adapter->irq_info.vectors[idx].regs.dyn_ctl;
 
-	for (i = 0; i < num_vecs; i++) {
-		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
-		struct idpf_intr_reg *intr = &q_vector->intr_reg;
-		u16 vec_id = rsrc->q_vector_idxs[i];
-		struct idpf_hw_vector *v;
-		u32 spacing;
-
-		v = &adapter->irq_info.vectors[vec_id];
-
-		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
-		intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
-		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
-		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
-		intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
-		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
-		intr->dyn_ctl_swint_trig_m = VF_INT_DYN_CTLN_SWINT_TRIG_M;
-		intr->dyn_ctl_sw_itridx_ena_m =
-			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
-
-		spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
-					       IDPF_VF_ITR_IDX_SPACING);
-		rx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
-					  spacing);
-		tx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
-					  spacing);
-		intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
-		intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
-	}
-
-	/* Data vector for NOIRQ queues */
-
-	val = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].regs.dyn_ctl;
 	rsrc->noirq_dyn_ctl =
 		libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info, val);
 
@@ -112,6 +76,44 @@ static void idpf_vf_intr_reg_init(struct idpf_vport *vport,
 	rsrc->noirq_dyn_ctl_ena = val;
 }
 
+/**
+ * idpf_vf_intr_reg_init - Initialize interrupt registers
+ * @adapter: adapter structure
+ * @q_vector: q_vector in which the registers should be initialized
+ * @idx: global software irq index used to get hardware information from
+ *	 irq_info structure
+ */
+static void idpf_vf_intr_reg_init(struct idpf_adapter *adapter,
+				  struct idpf_q_vector *q_vector, u16 idx)
+{
+	struct idpf_hw_vector *v = &adapter->irq_info.vectors[idx];
+	struct idpf_intr_reg *intr = &q_vector->intr_reg;
+	struct libie_mmio_info *mmio;
+	u32 rx_itr, tx_itr;
+	u32 spacing;
+
+	mmio = &adapter->ctlq_ctx.mmio_info;
+
+	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
+	intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
+	intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
+	intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
+	intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
+	intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
+	intr->dyn_ctl_swint_trig_m = VF_INT_DYN_CTLN_SWINT_TRIG_M;
+	intr->dyn_ctl_sw_itridx_ena_m =
+		VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
+
+	spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
+				       IDPF_VF_ITR_IDX_SPACING);
+	rx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
+				  spacing);
+	tx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
+				  spacing);
+	intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
+	intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
+}
+
 /**
  * idpf_vf_reset_reg_init - Initialize reset registers
  * @adapter: Driver specific private structure
@@ -157,6 +159,8 @@ static void idpf_vf_reg_ops_init(struct idpf_adapter *adapter)
 {
 	adapter->dev_ops.reg_ops.ctlq_reg_init = idpf_vf_ctlq_reg_init;
 	adapter->dev_ops.reg_ops.intr_reg_init = idpf_vf_intr_reg_init;
+	adapter->dev_ops.reg_ops.noirq_intr_reg_init =
+		idpf_vf_noirq_intr_reg_init;
 	adapter->dev_ops.reg_ops.mb_intr_reg_init = idpf_vf_mb_intr_reg_init;
 	adapter->dev_ops.reg_ops.reset_reg_init = idpf_vf_reset_reg_init;
 	adapter->dev_ops.reg_ops.trigger_reset = idpf_vf_trigger_reset;
-- 
2.49.0

