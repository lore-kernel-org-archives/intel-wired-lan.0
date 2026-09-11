Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB7AC88E56
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC10F6067C;
	Fri, 11 Sep 2026 13:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ze1fS11VB7zZ; Fri, 11 Sep 2026 13:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B48736066A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133457;
	b=iKoD5k+onJEDDzJDs33wFWfZpjSRNZ0P1gZC0WKBZFKImZvSutCdnmu0GY6Pn1iDXnar
	 DPI42YEIhVU1efBdhqnAGYdgxhJO3dfTmuw862JuXmP7D8LGqDbPDFnnzJvNkOW9uHY0J
	 uD9jxjlHNbtV8wZXxbx+TFA7KBIBZQPEMQJVi43BVQ/65Tf6S2z7g4JoUz32ERNaDX5Lv
	 4kEeN9Qvq1h6DJ6PLjXbgFh1HAVCB8FtmNfF6xC8se6bgRa9YDV5CuMBiXxQ2ktY5yfHi
	 cdf5I+KKgaN8vktDvGFIoQciON+9oMh55IcVHiO2/JmpzNdTVOEFeNtff8IEP5SaxLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133457;
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
	b=npjrsT6xc3gYRa1nQnot6y/3uhhNqnBSWZY0DZw6cipK9Kjyw2EPaoIYmdm9RkoJVOK9
	 HKvl3ZA8KZT8gd/JVOlkiM57fhP/7TgUUJeuaq4v5BijArGHNOjZLEW3MZzlObGbc/+uG
	 qTGvNvi/3jepFYOZfrPOfPGyXR8zCO9t6RknbcB/ZMZ+2BIcF6c/WJloIW5aZ4tE5ZVve
	 J5pIHBQu0GS2xsP1KpxRSGSmOMxsnbB/Y9BnZ6OqVdAqq2GfEfrTd0w1jzQg/ts26DvWc
	 n+n+R+F29hK/Vkjh8isfksLHBX9HDhafZgiWmpKuQGnUkKU4byFSG+5Pc2B1iJd5MDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133457;
	bh=qLHyENhhaho3kr7Fue/Pz0TIbAHm+g8DOvlm8TQrfeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eI8NB4vvkhT/fet7eLnQcJK5lpCyVJ1Y4efJRTCv1TzSTCcy0UUFng8q8n8b3h3em
	 xz4QJ1ALGttbyKXCVz/SGiUTKTdyyTrSkgOBFIsUmmt4yLkX/Zi3phbaHqLWQetSJL
	 +WdQA/IZrLTO7xyvpAU1yLcYQR+fe+nY5AZgh3/UXRQptcMflZynoqbcKX0jB9xnxo
	 +czXK7jMcuXZ7T6n0tCgT/tAfNZYZYmhtwhnXG42zpGOvfnXag+ABtM/aI7Yjgx0DO
	 BNzFpwvgU4ybexqwm4iH5ZRXwsBUR9z/1/6CtRRfQiYdEsegtTNntS6yWIzCuicB0t
	 eKsTKRfa75UEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B48736066A;
	Fri, 11 Sep 2026 13:30:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4105786
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5FE34080A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NVr837OUs2Nn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE82840607
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133455;
 b=bGYc6/4Zvf0biJtWFfKAifvztEZ7tRGaFergwGScRsxn1aExH9Ul+N8wb4dWhzS2Vuua
 o47/GPXHvqD4WCD9G+UdV2t6+eHMhEvX91E2WJItEi8JnLTQY1NGCblqSjTgWBgiuYnEV
 83YYtsybu2oTdeJH2kHU0HvOvDbbukquWUXZuBzu9SoolhvjsFxMeI0C9UXScUjSbHAEB
 /hKwUcUDRXOxI6tcS1rn5M4A1zOYzMrXofX5rjM6jkys1jMz2CWRxHT28C0ZajfdH3+QF
 WNmWOAuadM826JF2D31z96efGy5D7xDyPbe+x3zFLJ5rK2zLisMjkADLXq/1BZVftvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133455;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qLHyENhhaho3kr7Fue/Pz0TIbAHm+g8DOvlm8TQrfeU=;
 b=TeB2/ogUd13QohOcg6BsmDV62yJbr+ucB5IkijHB2UKALO1++TbUNGEK2CWtK+BGF4yg
 Nb9nxZB6wgirEvPMYhHX6HtBIYWWtu+AOki9xOJUQQOoj6TwRWm3AHYcp1p0nPkfACxP8
 JFp7zcbLKzPPW3M3otm0HS7QAhv/fiZPa9AkqDXNnUPnHvaOVZE8kk/12Yn81wkOkSIDE
 FT7QZQwPcu4QkP6mMNM/4viKDAAD0ySaXug5LUS0+WudtrN97fdLzbXSOipSN6B4a+CQY
 LoILH5x8F0L7BeMk+55f5XHrbTFX2/n32VnCSkgFH9RgtzrGrVOxCZ7p5Bga7zZQAQg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NaGrWb2o; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NaGrWb2o
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE82840607
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133455; x=1820669455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P7KYpg5UPwC7kIRKVXnoSQn7FyGdFoWe6ZzbbKhMvic=;
 b=NaGrWb2olnhlZdDr+I53RTBztev1vfCoZ0xzU92iQP5ncOpeQm0QpY4+
 NaIBC4EJ/V1WffJkeSA5tGirKtt2axCF9b+oLLSTHnUCKe3latSz2PKnf
 zjfgDqv+mk3XYvzWYC5OJRKLptWjCME1M3qZsoutglMIGYFJnxDoqArmo
 9t1VGnbGV6vsZXDAYtjz0Kiv8cH7scQmFcFkJwhwCqJ8i+3y7pBsMllHk
 AcMJVjhrLlA0SnzT/x4aQfafwkY46L1etOQ1jQBBhOnNlZUCVPKg59I5v
 tz1ba29NlQq7bzrg4s/t6rT6AMAU3FuJrmeNnQiXbrrxGssaXZ/dO7JkA g==;
X-CSE-ConnectionGUID: adaUErWiTp+89/HpdXS9zQ==
X-CSE-MsgGUID: MdlCTv8qT0ehq8M3YvLX7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107526"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:29:53 -0700
X-CSE-ConnectionGUID: 3MTAB8GFQdqVJ0Ao1zkAYw==
X-CSE-MsgGUID: GbYNWh1PTw2ne4lj7vFJ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541267"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:52 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v2 02/10] idpf: fill q_vector interrupt registers one
 by one
Date: Fri, 11 Sep 2026 14:49:13 +0200
Message-ID: <20260911124921.2881348-3-michal.swiatkowski@linux.intel.com>
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

