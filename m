Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC22C79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3FAD80C9A;
	Mon,  7 Sep 2026 11:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z_HV6X_VwQDu; Mon,  7 Sep 2026 11:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0909580C7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779062;
	b=RbDTG5BgTFMafcm4i+HU4fHyt+Zylbpsa/zAryoMehLIGY8tuWi8vX871oSPGCM6z5aD
	 yDq2Jwy5a/CBQ9Pc8sprL4PJO5eDMUShBhgpSbdlIK/lCB6jnlQ0d1+2Ds+FSM7ummJSP
	 UCIVGToNT6Pv3zrVXcgw2Jb3fBdz8oq9LXRcYIp4BTwg3Hp8+UJ9LEMNJQ5XDSaDDebvk
	 X8s8vYq9O6xYBmME7TU8eTVPAWPOGoS7udtEEV4fBMdAHZT3XskFCAE+JjHoyLluL8aNt
	 hsANy0XMudk61Xe7Pa0fAW3dUr+iinmRi+guNvNXt0RbvfC9f8XWW0AZqCmsPiyAtJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cxwImxr0q5BBSydQTieLbYM2P7lT1Cs7o0E5Y9c7xL8=;
	b=PTvCMElCh5AM1LJYm88pqD0qFmJynNn8/wyEsAY0mNV77BwRzVvqYJk22JToM2HUrOO4
	 7deqQTxZ99Ts0h/91NWlKVAAKICyAt2nKynyYYDlRiQKjXd+2XVtL7kp3ehlM/PQCQjQ1
	 VbmILnADGSR61SBkS3W0Mn6KnqU4Acu6Uh6CYxvAwxOzO07JpXWB6BSTsCOwzmfJQJqwI
	 Ni3IfkSgTqMmWY2bL1+xWbDoKwhyJdRncIDQMYRHlJ7kGELROPZYuv8ffSTfsW8RvyjIK
	 GSWQ3zlWqFs0JezoEMhRfY6eyzZ/5U88IenER6Mg7WxQDfaflwMboMC6ejdEJ0L1Ing==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779062;
	bh=cxwImxr0q5BBSydQTieLbYM2P7lT1Cs7o0E5Y9c7xL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m0I5hJIEZBx67cNXfiI1XUeOTkTg3I33FI+HHYK9H8JqA5xMczjGgy5WbvMiEIyOP
	 TyiVaOSrRurPz6kSUfIQNSEtIqKPOcN3Ke8213kjcUzGFRsOsCBB4CQIwc36M47x/7
	 MZtFJfrnD0ce0EjA4nVRCPMw2eAu+uBOKs8O/GObWSP6zhEJlKEa5riwX5YDUvui+B
	 MLr96SSfZr+xwORGr3pBdjK/hfeRZVZ5ToB5A++B9V+6yGOR3Niqu8nSVPouMy8YxJ
	 VbiBfq1NbAicbt4ryFLBDf+zcSl/txsfhypuQ1N+0H5/n5pgEdmlI/mLShlqGwzpQ5
	 4d0eISLKnCacQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0909580C7B;
	Mon,  7 Sep 2026 11:04:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B689E9CF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CAAD605DA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnqSoJR7war0 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 670AE6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779057;
 b=rlQJ7I51TH6g7VVDX+y5jT57ygR7nJU5JtyeNqod4e13jhdyphdluyYjWUTJh5+xyMNG
 yk7G1lHp88+Ls4dXvvyeU4FeMo4ph7uWreK1SZwgmFLb6XtQbwbofPwmR1xL1yz62Qu6n
 PBqwbUEJvk11tHxbJnIMlvYPRYC5YHwn7YdAIAw3IMsOJiiySuVXLtkcwhvEwBMKvYRsz
 gShJjCKbGaQWAUre1+SoQcfilHRzT8pdrpk5uOP2Y3M7Ol6g8fPBmywvwyFUsP04MOa0K
 7XsCjTkRBcvAzUfaHSog3fBYX5sb76MB5f7evgAE63JM9mdcBXrB6DZfDObbEtQTJeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779057;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cxwImxr0q5BBSydQTieLbYM2P7lT1Cs7o0E5Y9c7xL8=;
 b=YD20tlLmiHmuO7v4E1Ii8zObwBHHeZQRPVT3n+OFIKbdiroYk1zLsxlzuUS30/dfoQCp
 gnbXOsAU0mbwdEVYvy4rj6JKU4i3YLePoNImoBgBGZyR4A3fw3bu7siou43Dk0nEfZ64/
 SawoxCHT8MNDJSTPuEdJgo8vS6ru0sh4+DlmD3b1P69CRStr6scgIedj0GTEAKm5/DK3D
 W12XGoutlb6G6Fv8tVziA1imhOsbiWclJPH0w2/oJYHXtR5O3BJDvG6rGDetCelxwWlDO
 Gbp9uXu2MyZN8v47+yYO15alYHqHR/vbwuhHhcp8J05i/zBrrdn9csFdsY2Cwmh+r3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fPI1NqrH; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fPI1NqrH
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 670AE6067D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779058; x=1820315058;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bv8phQaMEfgsXr5h6qbfw7kFQrdcXdECIw9JeOzU7vA=;
 b=fPI1NqrHuJZA+lKKz5WrAEDFXyyYDyBeduSSz4BuoImLkc6b9vRoihVU
 aLO8saVN61uaCrMC813ATmsnGAikvgxulo92kydUC0qWiUj3tgv976Qfw
 8Z+8Ik5Y/y3lIKJakOYyDKysQMeZ0FpeB9y5mwJ3bIX+AD2A1FmAjL5zE
 AUuYOWdVmsejZ6canOs5UoKjOImpGNah7DpupVkJzDJMEA0PZb4oLVSj1
 /nD6xSxX/JchEKfG6a8iBc5MQdmFQjqlwHMwMX/dre9IIVBVCjU8bzVzF
 GxagWz45lUjiWIBS06En8PAj0b67Tj2Qc7OYJdfDr8xCTn3wfyN9EnsMJ A==;
X-CSE-ConnectionGUID: KhnMiADZQpKPVgEFzklGig==
X-CSE-MsgGUID: AR5HIJAkToukLrupqLKqoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214061"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214061"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:18 -0700
X-CSE-ConnectionGUID: ehbeI63jQqWs1EtJwyAf8w==
X-CSE-MsgGUID: J6t88FMiRh22SmDYZvz7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195300"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:15 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 01/10] idpf: store HW vectors information
Date: Mon,  7 Sep 2026 12:24:08 +0200
Message-ID: <20260907102418.2697317-2-michal.swiatkowski@linux.intel.com>
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

Currently hardware vectors information (registers address and HW indexes)
is stored in virtchnl command. When this information is needed they
are parsed and returned. There is a need for alloc/free array for this
information each time it is called.

Information about indexes and registers are parsed in two similar
functions. Create one parse function for both and store it in irq_info
structure to use whenever it is needed.

Stored virtchnl command still has to exist, because it is used when
sending dealloc message.

Make intr_reg_init() functions (for VF and PF) return void to
simplify code. With stored irq information there is no need to alloc an
array for it, so these functions can't fail.

Previously mailbox vector wasn't filled in idpf_intr_reg_init()
function. Store the mailbox information in irq_info.vectors to have
everything in one place. Because of that tweak index in few places by
adding IDPF_MBX_Q_VEC (when allocatig or iterrating) or not substracting
IDPF_MBX_Q_VEC from q_vector_idxs, because it is no needed now.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  41 +++-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  51 ++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  34 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  42 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  13 --
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  51 ++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 187 +++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 -
 8 files changed, 179 insertions(+), 246 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index df9e42bfeaa2..84b145431693 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -36,6 +36,7 @@ struct idpf_rss_data;
 #define IDPF_NUM_FILTERS_PER_MSG	20
 #define IDPF_NUM_DFLT_MBX_Q		2	/* includes both TX and RX */
 #define IDPF_DFLT_MBX_Q_LEN		64
+#define IDPF_MBX_IRQ_INDEX		0
 /* maximum number of times to try before resetting mailbox */
 #define IDPF_MB_MAX_ERR			20
 #define IDPF_NUM_CHUNKS_PER_MSG(struct_sz, chunk_sz)	\
@@ -204,8 +205,8 @@ struct idpf_vport_max_q {
 struct idpf_reg_ops {
 	void (*ctlq_reg_init)(struct libie_mmio_info *mmio,
 			      struct libie_ctlq_create_info *cctlq_info);
-	int (*intr_reg_init)(struct idpf_vport *vport,
-			     struct idpf_q_vec_rsrc *rsrc);
+	void (*intr_reg_init)(struct idpf_vport *vport,
+			      struct idpf_q_vec_rsrc *rsrc);
 	void (*mb_intr_reg_init)(struct idpf_adapter *adapter);
 	void (*reset_reg_init)(struct idpf_adapter *adapter);
 	void (*trigger_reset)(struct idpf_adapter *adapter,
@@ -614,6 +615,40 @@ struct idpf_vport_config {
 	     iter = (++__##iter) < &(adapter)->vports[(adapter)->max_vports] ? \
 	     *__##iter : NULL)
 
+/**
+ * struct idpf_vec_regs - hardware registers related to vector
+ * @dyn_ctl: Dynamic control interrupt register offset
+ * @itrn: Interrupt Throttling Rate register offset
+ * @itrn_index_spacing: Register spacing between ITR registers of the same
+ *			vector
+ */
+struct idpf_vec_regs {
+	u32 dyn_ctl;
+	u32 itrn;
+	u32 itrn_index_spacing;
+};
+
+/**
+ * struct idpf_hw_vector - single hardware vector info
+ * @regs: address of irq registers
+ * @idx: hardware vector index
+ */
+struct idpf_hw_vector {
+	struct idpf_vec_regs regs;
+	int idx;
+};
+
+/**
+ * struct idpf_irq_info - hardware data needed to setup irq
+ * @vectors: allocated during initialization store hardware information
+ *	     for all vectors that can be used on a whole device
+ * @num: amount of vectors stored here
+ */
+struct idpf_irq_info {
+	struct idpf_hw_vector *vectors;
+	int num;
+};
+
 /**
  * struct idpf_adapter - Device data struct generated on probe
  * @pdev: PCI device struct given on probe
@@ -633,6 +668,7 @@ struct idpf_vport_config {
  * @msix_entries: MSIX table
  * @num_rdma_msix_entries: Available number of MSIX vectors for RDMA
  * @rdma_msix_entries: RDMA MSIX table
+ * @irq_info: hardware data needed to setup irq
  * @req_vec_chunks: Requested vector chunk data
  * @mb_vector: Mailbox vector data
  * @vector_stack: Stack to store the msix vector indexes
@@ -693,6 +729,7 @@ struct idpf_adapter {
 	u16 num_rdma_msix_entries;
 	struct msix_entry *rdma_msix_entries;
 	struct virtchnl2_alloc_vectors *req_vec_chunks;
+	struct idpf_irq_info irq_info;
 	struct idpf_q_vector mb_vector;
 	struct idpf_vector_lifo vector_stack;
 	irqreturn_t (*irq_mb_handler)(int irq, void *data);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 083cf6319d26..42e65f1285df 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -46,7 +46,9 @@ static void idpf_mb_intr_reg_init(struct idpf_adapter *adapter)
 {
 	struct libie_mmio_info *mmio = &adapter->ctlq_ctx.mmio_info;
 	struct idpf_intr_reg *intr = &adapter->mb_vector.intr_reg;
-	u32 dyn_ctl = le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
+	u32 dyn_ctl;
+
+	dyn_ctl = adapter->irq_info.vectors[IDPF_MBX_IRQ_INDEX].regs.dyn_ctl;
 
 	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, dyn_ctl);
 	intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
@@ -60,39 +62,27 @@ static void idpf_mb_intr_reg_init(struct idpf_adapter *adapter)
  * @vport: virtual port structure
  * @rsrc: pointer to queue and vector resources
  */
-static int idpf_intr_reg_init(struct idpf_vport *vport,
-			      struct idpf_q_vec_rsrc *rsrc)
+static void idpf_intr_reg_init(struct idpf_vport *vport,
+			       struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	u16 num_vecs = rsrc->num_q_vectors;
-	struct idpf_vec_regs *reg_vals;
+	int num_vecs = rsrc->num_q_vectors;
 	struct libie_mmio_info *mmio;
-	int num_regs, i, err = 0;
 	u32 rx_itr, tx_itr, val;
-	u16 total_vecs;
-
-	total_vecs = idpf_get_reserved_vecs(vport->adapter);
-	reg_vals = kzalloc_objs(struct idpf_vec_regs, total_vecs);
-	if (!reg_vals)
-		return -ENOMEM;
-
-	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals, total_vecs);
-	if (num_regs < num_vecs) {
-		err = -EINVAL;
-		goto free_reg_vals;
-	}
+	int i;
 
 	mmio = &adapter->ctlq_ctx.mmio_info;
 
 	for (i = 0; i < num_vecs; i++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
-		u16 vec_id = rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC;
 		struct idpf_intr_reg *intr = &q_vector->intr_reg;
-		struct idpf_vec_regs *reg = &reg_vals[vec_id];
+		u16 vec_id = rsrc->q_vector_idxs[i];
+		struct idpf_hw_vector *v;
 		u32 spacing;
 
-		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio,
-							reg->dyn_ctl_reg);
+		v = &adapter->irq_info.vectors[vec_id];
+
+		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
 		intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
 		intr->dyn_ctl_intena_msk_m = PF_GLINT_DYN_CTL_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
@@ -102,30 +92,25 @@ static int idpf_intr_reg_init(struct idpf_vport *vport,
 		intr->dyn_ctl_sw_itridx_ena_m =
 			PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
 
-		spacing = IDPF_ITR_IDX_SPACING(reg->itrn_index_spacing,
+		spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
 					       IDPF_PF_ITR_IDX_SPACING);
-		rx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0,
-					   reg->itrn_reg, spacing);
-		tx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1,
-					   reg->itrn_reg, spacing);
+		rx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
+					   spacing);
+		tx_itr = PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
+					   spacing);
 		intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
 		intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
 	}
 
 	/* Data vector for NOIRQ queues */
 
-	val = reg_vals[rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC].dyn_ctl_reg;
+	val = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].regs.dyn_ctl;
 	rsrc->noirq_dyn_ctl =
 		libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info, val);
 
 	val = PF_GLINT_DYN_CTL_WB_ON_ITR_M | PF_GLINT_DYN_CTL_INTENA_MSK_M |
 	      FIELD_PREP(PF_GLINT_DYN_CTL_ITR_INDX_M, IDPF_NO_ITR_UPDATE_IDX);
 	rsrc->noirq_dyn_ctl_ena = val;
-
-free_reg_vals:
-	kfree(reg_vals);
-
-	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5d61ecb73a40..36bb6a268042 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -305,16 +305,14 @@ int idpf_req_rel_vector_indexes(struct idpf_adapter *adapter,
  */
 int idpf_intr_req(struct idpf_adapter *adapter)
 {
-	u16 num_lan_vecs, min_lan_vecs, num_rdma_vecs = 0, min_rdma_vecs = 0;
+	int num_rdma_vecs = 0, min_rdma_vecs = 0, num_lan_vecs = 0;
 	u16 default_vports = idpf_get_default_vports(adapter);
-	int num_q_vecs, total_vecs, num_vec_ids;
-	int min_vectors, actual_vecs, err;
+	int min_vectors, actual_vecs, min_lan_vecs, err;
+	int num_q_vecs, total_vecs;
 	unsigned int vector;
-	u16 *vecids;
 	int i;
 
 	total_vecs = idpf_get_reserved_vecs(adapter);
-	num_lan_vecs = total_vecs;
 	if (idpf_is_rdma_cap_ena(adapter)) {
 		num_rdma_vecs = idpf_get_reserved_rdma_vecs(adapter);
 		min_rdma_vecs = IDPF_MIN_RDMA_VEC;
@@ -376,28 +374,15 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 		goto free_rdma_msix;
 	}
 
-	adapter->mb_vector.v_idx = le16_to_cpu(adapter->caps.mailbox_vector_id);
-
-	vecids = kcalloc(actual_vecs, sizeof(u16), GFP_KERNEL);
-	if (!vecids) {
-		err = -ENOMEM;
-		goto free_msix;
-	}
-
-	num_vec_ids = idpf_get_vec_ids(adapter, vecids, actual_vecs,
-				       &adapter->req_vec_chunks->vchunks);
-	if (num_vec_ids < actual_vecs) {
-		err = -EINVAL;
-		goto free_vecids;
-	}
-
 	for (vector = 0; vector < num_lan_vecs; vector++) {
-		adapter->msix_entries[vector].entry = vecids[vector];
+		adapter->msix_entries[vector].entry =
+			adapter->irq_info.vectors[vector].idx;
 		adapter->msix_entries[vector].vector =
 			pci_irq_vector(adapter->pdev, vector);
 	}
 	for (i = 0; i < num_rdma_vecs; vector++, i++) {
-		adapter->rdma_msix_entries[i].entry = vecids[vector];
+		adapter->rdma_msix_entries[i].entry =
+			adapter->irq_info.vectors[vector].idx;
 		adapter->rdma_msix_entries[i].vector =
 			pci_irq_vector(adapter->pdev, vector);
 	}
@@ -414,20 +399,17 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 	/* Fill MSIX vector lifo stack with vector indexes */
 	err = idpf_init_vector_stack(adapter);
 	if (err)
-		goto free_vecids;
+		goto free_msix;
 
 	err = idpf_mb_intr_init(adapter);
 	if (err)
 		goto deinit_vec_stack;
 	idpf_mb_irq_enable(adapter);
-	kfree(vecids);
 
 	return 0;
 
 deinit_vec_stack:
 	idpf_deinit_vector_stack(adapter);
-free_vecids:
-	kfree(vecids);
 free_msix:
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5e66652afa5b..2b21f599f569 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4502,42 +4502,18 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
  * @rsrc: pointer to queue and vector resources
  *
  * Initialize vector indexes with values returned over mailbox.
- *
- * Return: 0 on success, negative on failure
  */
-static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
-					struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
+					 struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_alloc_vectors *ac;
-	u16 *vecids, total_vecs;
 	int i;
 
-	ac = adapter->req_vec_chunks;
-	if (!ac) {
-		for (i = 0; i < rsrc->num_q_vectors; i++)
-			rsrc->q_vectors[i].v_idx = rsrc->q_vector_idxs[i];
-
-		rsrc->noirq_v_idx = rsrc->q_vector_idxs[i];
-
-		return 0;
-	}
-
-	total_vecs = idpf_get_reserved_vecs(adapter);
-	vecids = kcalloc(total_vecs, sizeof(u16), GFP_KERNEL);
-	if (!vecids)
-		return -ENOMEM;
-
-	idpf_get_vec_ids(adapter, vecids, total_vecs, &ac->vchunks);
-
 	for (i = 0; i < rsrc->num_q_vectors; i++)
-		rsrc->q_vectors[i].v_idx = vecids[rsrc->q_vector_idxs[i]];
-
-	rsrc->noirq_v_idx = vecids[rsrc->q_vector_idxs[i]];
+		rsrc->q_vectors[i].v_idx =
+			adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
 
-	kfree(vecids);
-
-	return 0;
+	rsrc->noirq_v_idx = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
 }
 
 /**
@@ -4668,16 +4644,12 @@ int idpf_vport_intr_init(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 {
 	int err;
 
-	err = idpf_vport_intr_init_vec_idx(vport, rsrc);
-	if (err)
-		return err;
+	idpf_vport_intr_init_vec_idx(vport, rsrc);
 
 	idpf_vport_intr_map_vector_to_qs(vport, rsrc);
 	idpf_vport_intr_napi_add_all(vport, rsrc);
 
-	err = vport->adapter->dev_ops.reg_ops.intr_reg_init(vport, rsrc);
-	if (err)
-		goto unroll_vectors_alloc;
+	vport->adapter->dev_ops.reg_ops.intr_reg_init(vport, rsrc);
 
 	err = idpf_vport_intr_req_irq(vport, rsrc);
 	if (err)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index dce07fbb6e77..ecff84df776d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -318,19 +318,6 @@ enum idpf_queue_flags_t {
 #define idpf_queue_assign(f, q, v)			\
 	__assign_bit(__IDPF_Q_##f, (q)->flags, v)
 
-/**
- * struct idpf_vec_regs
- * @dyn_ctl_reg: Dynamic control interrupt register offset
- * @itrn_reg: Interrupt Throttling Rate register offset
- * @itrn_index_spacing: Register spacing between ITR registers of the same
- *			vector
- */
-struct idpf_vec_regs {
-	u32 dyn_ctl_reg;
-	u32 itrn_reg;
-	u32 itrn_index_spacing;
-};
-
 /**
  * struct idpf_intr_reg
  * @dyn_ctl: Dynamic control interrupt register
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index b537de3592f4..c0080842b7e2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -45,7 +45,9 @@ static void idpf_vf_mb_intr_reg_init(struct idpf_adapter *adapter)
 {
 	struct libie_mmio_info *mmio = &adapter->ctlq_ctx.mmio_info;
 	struct idpf_intr_reg *intr = &adapter->mb_vector.intr_reg;
-	u32 dyn_ctl = le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
+	u32 dyn_ctl;
+
+	dyn_ctl = adapter->irq_info.vectors[IDPF_MBX_IRQ_INDEX].regs.dyn_ctl;
 
 	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, dyn_ctl);
 	intr->dyn_ctl_intena_m = VF_INT_DYN_CTL0_INTENA_M;
@@ -59,39 +61,27 @@ static void idpf_vf_mb_intr_reg_init(struct idpf_adapter *adapter)
  * @vport: virtual port structure
  * @rsrc: pointer to queue and vector resources
  */
-static int idpf_vf_intr_reg_init(struct idpf_vport *vport,
-				 struct idpf_q_vec_rsrc *rsrc)
+static void idpf_vf_intr_reg_init(struct idpf_vport *vport,
+				  struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	u16 num_vecs = rsrc->num_q_vectors;
-	struct idpf_vec_regs *reg_vals;
+	int num_vecs = rsrc->num_q_vectors;
 	struct libie_mmio_info *mmio;
-	int num_regs, i, err = 0;
 	u32 rx_itr, tx_itr, val;
-	u16 total_vecs;
-
-	total_vecs = idpf_get_reserved_vecs(vport->adapter);
-	reg_vals = kzalloc_objs(struct idpf_vec_regs, total_vecs);
-	if (!reg_vals)
-		return -ENOMEM;
-
-	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals, total_vecs);
-	if (num_regs < num_vecs) {
-		err = -EINVAL;
-		goto free_reg_vals;
-	}
+	int i;
 
 	mmio = &adapter->ctlq_ctx.mmio_info;
 
 	for (i = 0; i < num_vecs; i++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
-		u16 vec_id = rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC;
 		struct idpf_intr_reg *intr = &q_vector->intr_reg;
-		struct idpf_vec_regs *reg = &reg_vals[vec_id];
+		u16 vec_id = rsrc->q_vector_idxs[i];
+		struct idpf_hw_vector *v;
 		u32 spacing;
 
-		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio,
-							reg->dyn_ctl_reg);
+		v = &adapter->irq_info.vectors[vec_id];
+
+		intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, v->regs.dyn_ctl);
 		intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
 		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
@@ -101,30 +91,25 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport,
 		intr->dyn_ctl_sw_itridx_ena_m =
 			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
 
-		spacing = IDPF_ITR_IDX_SPACING(reg->itrn_index_spacing,
+		spacing = IDPF_ITR_IDX_SPACING(v->regs.itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-		rx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_0,
-					  reg->itrn_reg, spacing);
-		tx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_1,
-					  reg->itrn_reg, spacing);
+		rx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_0, v->regs.itrn,
+					  spacing);
+		tx_itr = VF_INT_ITRN_ADDR(VIRTCHNL2_ITR_IDX_1, v->regs.itrn,
+					  spacing);
 		intr->rx_itr = libie_pci_get_mmio_addr(mmio, rx_itr);
 		intr->tx_itr = libie_pci_get_mmio_addr(mmio, tx_itr);
 	}
 
 	/* Data vector for NOIRQ queues */
 
-	val = reg_vals[rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC].dyn_ctl_reg;
+	val = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].regs.dyn_ctl;
 	rsrc->noirq_dyn_ctl =
 		libie_pci_get_mmio_addr(&adapter->ctlq_ctx.mmio_info, val);
 
 	val = VF_INT_DYN_CTLN_WB_ON_ITR_M | VF_INT_DYN_CTLN_INTENA_MSK_M |
 	      FIELD_PREP(VF_INT_DYN_CTLN_ITR_INDX_M, IDPF_NO_ITR_UPDATE_IDX);
 	rsrc->noirq_dyn_ctl_ena = val;
-
-free_reg_vals:
-	kfree(reg_vals);
-
-	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index f2a58b814cb8..fbb3a0ba9791 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -896,54 +896,6 @@ idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
 	return 0;
 }
 
-/**
- * idpf_get_reg_intr_vecs - Get vector queue register offset
- * @adapter: adapter structure to get the vector chunks
- * @reg_vals: Register offsets to store in
- * @num_vecs: number of entries the @reg_vals array can hold
- *
- * Return: number of registers that got populated
- */
-int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
-			   struct idpf_vec_regs *reg_vals, int num_vecs)
-{
-	struct virtchnl2_vector_chunks *chunks;
-	struct idpf_vec_regs reg_val;
-	u16 num_vchunks, num_vec;
-	int num_regs = 0, i, j;
-
-	chunks = &adapter->req_vec_chunks->vchunks;
-	num_vchunks = le16_to_cpu(chunks->num_vchunks);
-
-	for (j = 0; j < num_vchunks; j++) {
-		struct virtchnl2_vector_chunk *chunk;
-		u32 dynctl_reg_spacing;
-		u32 itrn_reg_spacing;
-
-		chunk = &chunks->vchunks[j];
-		num_vec = le16_to_cpu(chunk->num_vectors);
-		reg_val.dyn_ctl_reg = le32_to_cpu(chunk->dynctl_reg_start);
-		reg_val.itrn_reg = le32_to_cpu(chunk->itrn_reg_start);
-		reg_val.itrn_index_spacing = le32_to_cpu(chunk->itrn_index_spacing);
-
-		dynctl_reg_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
-		itrn_reg_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
-
-		for (i = 0; i < num_vec && num_regs < num_vecs; i++) {
-			reg_vals[num_regs].dyn_ctl_reg = reg_val.dyn_ctl_reg;
-			reg_vals[num_regs].itrn_reg = reg_val.itrn_reg;
-			reg_vals[num_regs].itrn_index_spacing =
-						reg_val.itrn_index_spacing;
-
-			reg_val.dyn_ctl_reg += dynctl_reg_spacing;
-			reg_val.itrn_reg += itrn_reg_spacing;
-			num_regs++;
-		}
-	}
-
-	return num_regs;
-}
-
 /**
  * idpf_vport_get_q_reg - Get the queue registers for the vport
  * @reg_vals: register values needing to be set
@@ -2274,6 +2226,83 @@ int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
 	return err;
 }
 
+/**
+ * idpf_create_vectors_info - Save vectors information from firmware
+ * @info: parsed information is stored here
+ * @caps: virtchannel capabilities
+ * @vectors: vector information from firmware to be parsed
+ * @num_vectors: number of vectors
+ *
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_create_vectors_info(struct idpf_irq_info *info,
+				    const struct virtchnl2_get_capabilities *caps,
+				    const struct virtchnl2_alloc_vectors *vectors,
+				    const u16 num_vectors)
+{
+	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
+	int all_vectors = num_vectors + IDPF_MBX_Q_VEC;
+	struct idpf_hw_vector *vector;
+	int reg_cnt;
+
+	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
+		return -EINVAL;
+
+	info->vectors = kzalloc_objs(*info->vectors, num_vectors + IDPF_MBX_Q_VEC);
+	if (!info->vectors)
+		return -ENOMEM;
+	/* Mailbox irq information are stored in different places. Fill index 0
+	 * of our vectors info with capabilities and rest with information
+	 * from vector chunks.
+	 */
+	vector = &info->vectors[0];
+	vector->idx = le16_to_cpu(caps->mailbox_vector_id);
+	vector->regs.dyn_ctl = le32_to_cpu(caps->mailbox_dyn_ctl);
+	reg_cnt = IDPF_MBX_Q_VEC;
+
+	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
+		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
+		u32 dyn_spacing, itrn_spacing;
+		struct idpf_vec_regs reg_val;
+		u16 vec_id;
+
+		reg_val.dyn_ctl = le32_to_cpu(chunk->dynctl_reg_start);
+		reg_val.itrn = le32_to_cpu(chunk->itrn_reg_start);
+		reg_val.itrn_index_spacing =
+			le32_to_cpu(chunk->itrn_index_spacing);
+
+		dyn_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
+		itrn_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
+		vec_id = le16_to_cpu(chunk->start_vector_id);
+
+		for (int j = 0; j < le16_to_cpu(chunk->num_vectors); j++) {
+			if (reg_cnt >= all_vectors)
+				break;
+
+			vector = &info->vectors[reg_cnt];
+
+			vector->regs = reg_val;
+			vector->idx = vec_id;
+
+			reg_val.dyn_ctl += dyn_spacing;
+			reg_val.itrn += itrn_spacing;
+
+			vec_id += 1;
+			reg_cnt += 1;
+		}
+	}
+
+	if (reg_cnt != all_vectors) {
+		kfree(info->vectors);
+		info->vectors = NULL;
+		return -EINVAL;
+	}
+
+	info->num = num_vectors + IDPF_MBX_Q_VEC;
+
+	return 0;
+}
+
 /**
  * idpf_send_alloc_vectors_msg - Send virtchnl alloc vectors message
  * @adapter: Driver specific private structure
@@ -2318,11 +2347,13 @@ int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors)
 		goto free_rx_buf;
 	}
 
-	if (le16_to_cpu(adapter->req_vec_chunks->num_vectors) < num_vectors) {
-		kfree(adapter->req_vec_chunks);
-		adapter->req_vec_chunks = NULL;
-		err = -EINVAL;
-	}
+	err = idpf_create_vectors_info(&adapter->irq_info, &adapter->caps,
+				       rcvd_vec, num_vectors);
+	if (err)
+		/* Unroll getting vectors and leave it in clean state for
+		 * the next try.
+		 */
+		idpf_send_dealloc_vectors_msg(adapter);
 
 free_rx_buf:
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
@@ -2346,6 +2377,11 @@ int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter)
 	struct virtchnl2_vector_chunks *vcs;
 	int buf_size, err;
 
+	/* dealloc vectors can fail, but irq_info still needs to be cleaned */
+	kfree(adapter->irq_info.vectors);
+	adapter->irq_info.vectors = NULL;
+	adapter->irq_info.num = 0;
+
 	buf_size = struct_size(&ac->vchunks, vchunks,
 			       le16_to_cpu(ac->vchunks.num_vchunks));
 	vcs = kmemdup(&ac->vchunks, buf_size, GFP_KERNEL);
@@ -3340,51 +3376,6 @@ int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	return 0;
 }
 
-/**
- * idpf_get_vec_ids - Initialize vector id from Mailbox parameters
- * @adapter: adapter structure to get the mailbox vector id
- * @vecids: Array of vector ids
- * @num_vecids: number of vector ids
- * @chunks: vector ids received over mailbox
- *
- * Will initialize the mailbox vector id which is received from the
- * get capabilities and data queue vector ids with ids received as
- * mailbox parameters.
- * Returns number of ids filled
- */
-int idpf_get_vec_ids(struct idpf_adapter *adapter,
-		     u16 *vecids, int num_vecids,
-		     struct virtchnl2_vector_chunks *chunks)
-{
-	u16 num_chunks = le16_to_cpu(chunks->num_vchunks);
-	int num_vecid_filled = 0;
-	int i, j;
-
-	vecids[num_vecid_filled] = adapter->mb_vector.v_idx;
-	num_vecid_filled++;
-
-	for (j = 0; j < num_chunks; j++) {
-		struct virtchnl2_vector_chunk *chunk;
-		u16 start_vecid, num_vec;
-
-		chunk = &chunks->vchunks[j];
-		num_vec = le16_to_cpu(chunk->num_vectors);
-		start_vecid = le16_to_cpu(chunk->start_vector_id);
-
-		for (i = 0; i < num_vec; i++) {
-			if ((num_vecid_filled + i) < num_vecids) {
-				vecids[num_vecid_filled + i] = start_vecid;
-				start_vecid++;
-			} else {
-				break;
-			}
-		}
-		num_vecid_filled = num_vecid_filled + i;
-	}
-
-	return num_vecid_filled;
-}
-
 /**
  * idpf_vport_get_queue_ids - Initialize queue id from Mailbox parameters
  * @qids: Array of queue ids
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5d27805ff40f..ec4c79191c85 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -10,7 +10,6 @@
 
 struct idpf_adapter;
 struct idpf_netdev_priv;
-struct idpf_vec_regs;
 struct idpf_vport;
 struct idpf_vport_max_q;
 struct idpf_vport_config;
@@ -21,8 +20,6 @@ void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter);
 int idpf_vc_core_init(struct idpf_adapter *adapter);
 void idpf_vc_core_deinit(struct idpf_adapter *adapter);
 
-int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
-			   struct idpf_vec_regs *reg_vals, int num_vecs);
 int idpf_queue_reg_init(struct idpf_vport *vport,
 			struct idpf_q_vec_rsrc *rsrc,
 			struct idpf_queue_id_reg_info *chunks);
@@ -129,9 +126,6 @@ int idpf_send_delete_queues_msg(struct idpf_adapter *adapter,
 
 int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport,
 				 struct idpf_q_vec_rsrc *rsrc);
-int idpf_get_vec_ids(struct idpf_adapter *adapter,
-		     u16 *vecids, int num_vecids,
-		     struct virtchnl2_vector_chunks *chunks);
 int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors);
 int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter);
 int idpf_send_map_unmap_queue_vector_msg(struct idpf_adapter *adapter,
-- 
2.49.0

