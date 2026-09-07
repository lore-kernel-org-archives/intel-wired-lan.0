Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF45CC79F9F
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABF5780CB6;
	Mon,  7 Sep 2026 11:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swU_avBtKDwy; Mon,  7 Sep 2026 11:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DDDE880937
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779070;
	b=kR/DSHP/RPno6V7KOeZhqmhxRwOJ9XLHUUGd2+bQdF1siR1uG1d9SSx88HtH3vKlnXVi
	 zHCDaUt6VHJDcRpUm7kIZKqwgxMej3ZysYK+MnLnvKzGjxMKOQDyfVhpp0Nm9rjnta1ZA
	 44HTyiQO8+FVozEH6BCLJf1QhlrHrdaDOLjKuRHF/mz4GUhezpj6KZolb+65gaZ3JskJ7
	 Y/Z7xbggdjFe51SO4WqJBq53bM78cPdPp4pGMCm1nvDb8IbSA8IsMnYrjK73EHRtT7xv9
	 F7NSxFAGCl3aL6hAjIDtR5QauZDOKfIEtRp9bz7LrksQB2bWUz58eznPDubgFOLoJjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bs7vuPfgr+vVsApMxW24gKdp7DAsLgVw3EvqDtSvfHI=;
	b=Ct5h+l7lfST1/ABxO2stBxa5yoMoTnlKwj1QWz14evnrEhX/XafmtZLlnUKo6KFePwj3
	 b00MnzAdAXWb0CczBKC57gznSrUzl6IJBt/fr7DOKlfymk+5OSichZz7BDImZqyU/Ve1/
	 2HH464srHGsJA/9Cjq7BDd5mqAezZvakSn56SAyQijdbfJhFRrlgrvCAXbuut0/rs2xcx
	 ZnUpcHckWm3BDMYFruHQ3TEWsUzVZ0sEnUmcMdtUiu74Qy2FCf1thDXB+vMLOsoz6/XcX
	 y4sEF3xVFjctkhzDM09Ap5WbqAZiOC9PtY5UocUrVzOydzvGWbMybVzT2YPM2kCj7jg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=naK6nluz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779069;
	bh=bs7vuPfgr+vVsApMxW24gKdp7DAsLgVw3EvqDtSvfHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Blg5YMufUdxxKQQOrmLM0hP3+gtjbd3RoOjw7snZZOOlujbe/nEMR5gZ8V1flJUVo
	 xEnviOXkjd5BrL4/TB9af6ITM/DSPPQobQCqzQuuWgTE1S4EVwjnTCRvU59NLeNUII
	 Ld+6YALqW3eKh6JrsmdvCLKLEd1cr9PcBOdnxqz9mNalj+ot3kLtPLCxDKAKydJGW/
	 KLYU8WVMXM3RS175vhfxS11TF+Pdpl5wWyjE6bUHp0PzVlJx8YxmZmmpAMt0kZvlEI
	 VF+wuepTL2P8vyVoPt6zmWOwVrD6s1Ja/dy/9I8UUtGoVk2Bqp429fjgsQ7r8fzDkS
	 wMo5TnAB3jEgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDDE880937;
	Mon,  7 Sep 2026 11:04:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 699DDA48
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DA4280C97
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F8BZ08iVeGa6 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4F39380CA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779066;
 b=lUQrZpZaWTg/XDMqCBFpURJhT2vtdZzq5PWbT5ZYmZ6Lufy7wpcAI3AY7fH2G0Eih+xY
 POLsvlDkmElwFyrcwOdmIPgGWhFRa6ez9L//poQ+tIlZXFflttoT6jhf3YXUfUQZzW5/o
 IkOVlW1i4sEH8EOmQso375cxxsZQbQm58NiVf3r8EVsP+uBVAXju2+yoJpznu0+L2953I
 Q855qvsx37r3/MC/yrvgJjELUCHeek2Tgd6azPmVtB1uYJa3dUd1te+sSFoNh+yiifsWy
 BBOEDt30I2htFmd3q+trSIyQBZI5oAIpRjdiuuR/f+StKqPb3hG/FAtmT04hJRcE1aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779066;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bs7vuPfgr+vVsApMxW24gKdp7DAsLgVw3EvqDtSvfHI=;
 b=ZpIaKZsBx/IOmAI91HiJFt8kSDwrOIfn+KT4Wny2B1Z0NkRu+H5YwEOBhpfjCMky9UB5
 6QBgmwpqCpkq8JtiuUgZq12OpHInNC/aZChL8p763gWGSyFxR4W0UGyw9kIZzR0Z4jMSC
 9KoDHoogadaPIw+fl4maWDMmPyOel5ieQTAoYTy66747xF1AAjd7/sDWy2vfCb73bJgMV
 VhYBicYuv0B/T92UiOlnYV7F0hFaAn8Yuj32EJBZb12DuoYq97vGwEhlZY6kMKfQo2HME
 NRbpINttPD2oX5osrbjdSreNOaNMsP4JDfXtykcB4bI9N/JQ8wxFdPB5YSZBkaN3H+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=naK6nluz; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=naK6nluz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F39380CA8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779067; x=1820315067;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X4VfQ772ctDM0FB8HpIEukoLsFNMo0MLMRcOWpajPno=;
 b=naK6nluzx8dZ+r7c5OXb+LASZI9omc+KRN/X5jo8zdkILP/MCZhCtRy1
 hFva4IWjxImUC/1i4cv0WCvxVKpLbOa/Brc0zCYXBriNjadKEeDwxcuWn
 bGv/jKkyfM/WPv11+GK0yHJiM4gcEsn1TULIX7ClDBJasmlYgp60s8/NW
 0g43JADs/SgrbgzPWHZv2JbQIecN+/kFjlUruCmtlCGGRDPQwCXu8gxdT
 +EAAAk8tt8MCeAkDiY5hNdhicoQPWtAUe6QHYZ058dsq0yFXa/2qRdZNF
 OTg0TGUbWVfLG/V/qW49LCV4wIFXAd1Ij9kWbCeYdeYAN6Z1RFNm6i/Gd Q==;
X-CSE-ConnectionGUID: 9tQxNr1QSfSXuEtyXRTvPg==
X-CSE-MsgGUID: AD62ic+LTxuyWd1Qo9vpwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214079"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214079"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:27 -0700
X-CSE-ConnectionGUID: IcE68psHRXqOgdVVPybwog==
X-CSE-MsgGUID: nENw2yhgQE+73Qoa1qJiMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195430"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:25 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v1 06/10] libie,
 idpf: move hardware irq info struct to libie
Date: Mon,  7 Sep 2026 12:24:13 +0200
Message-ID: <20260907102418.2697317-7-michal.swiatkowski@linux.intel.com>
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

Manually move definition related to irq info from idpf to libie_irq.
s/idpf_/libie_

It will be used by idpf and ixd driver.

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 36 +------------------
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  8 ++---
 include/linux/net/intel/libie/irq.h           | 34 ++++++++++++++++++
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index b7ed8272bc93..1c67895a014e 100644
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
  * struct idpf_adapter - Device data struct generated on probe
  * @pdev: PCI device struct given on probe
@@ -685,7 +651,7 @@ struct idpf_adapter {
 	struct msix_entry *rdma_msix_entries;
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
index e24740bbb7ca..9377af87125f 100644
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

