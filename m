Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F887C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2847680CAF;
	Mon,  7 Sep 2026 11:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ni9E-xYaVeGe; Mon,  7 Sep 2026 11:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B2C4580CA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779066;
	b=YQZMCtk1+/ZQHpCL3MTOWk7NGWlNK0FHWvEwDOfSp+q0YOWh1UfrPUJ3WCLQlrzwBCze
	 zMh/Zdf4SYGeu6H7Ks4su1KLyRkjfHHoN8RBFSpKsd8QZmTjpMJayADrEdJRSzkPxEn6O
	 MmfENYiyJ6fsCQwJOSpOqsfrORyrMC7kW+oSEtdxmThc+dHxPaY3OrIPy/sr0yBF9qSyj
	 fnkQIFtjvDQtVTa52DbhuDPSorZDL2rFOIQiq3Uc9t8ZzUKnTo+Sk15QJl8B/21/D2IN7
	 4n4Gqm6b+JAnPQxE8XDiiJAQvYsMOuyViNwvlCAUXa7B3Oanek2OCcYIY9eGyQR/iTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uoMX3Y9/ObTKBxvbNQ3tp1z0d97PrZGu792ijsD8k+I=;
	b=LUX7upJCTFcQ4Lx9FkmWOGQCoDZ33RdaKz8HPtzV2EOTPJd1165X2xuSQ7EW6+qlZukq
	 CKO32P/69ruKPvUXpj0+GLpz7xZ3aOn4Kd0XOKX2RENtE/2bxjwosKwiwJFVSZDsBUTTo
	 PKgPjMJMYgNIe6BroxtgiVjB9Ymj3b9RXro8nEO17XNtVg2ZaI306tRHvsbJ2fBDCg1ER
	 aKZQQX0LVHKKuEZy3nVc2Q1OdcHj1A2z/BiUJP66mvnmvupr+XOUv3G9f3yTnDk2Nh88b
	 kOQgy2Vs62pDZEVWFCang90SHtxe8uUY5EI1wOfl/Z3OFmi6gkd37E0rgmSSA+vDX/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="d/ZFPgQ5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779066;
	bh=uoMX3Y9/ObTKBxvbNQ3tp1z0d97PrZGu792ijsD8k+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a9gbeTlVdhleiBieDV4o4bNO27wHGg4Qqs9ex3RwWvqXStb5AviBIJ9BdAgJg3vby
	 mIx/HpBV9SW0gedrpucdXhzx8yOsV4aFRiHffASObb5K7g1c0uYX0fDrKymHjNOO1U
	 s+WoaOf5XTZI5NZT/mRMQc/M0yWGSrTM1ARVFmErMGSEde3CBS8UEzv2+ZMVbtrsQ4
	 oHVQRQr61Xs346kMkU9SBS8WbwEwCWggHsrEYVnOOaqOV7dKdSIg9PwWZC2BWF8jBH
	 Pd/myHSe/ZbPgfq8VBTL6/y7Esagvt6n3quKhtmDY2cV/inDR1BqzaxkypmjGtjIBi
	 7O8EWbQ6YkUJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C4580CA6;
	Mon,  7 Sep 2026 11:04:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA769CF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED18480CA2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wLeRp-shCMdM for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B5AA780937
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779063;
 b=F8Obl1U095rmIMZswP0H9t6uDVJrZ5I8M1F8FmiGfiFRcmsOwHbCAg+RgCgzEzuhbdln
 pKToOqVPHlsyxZyFN2Iq0ruMiVDvvTxfQK8mn/RyHNGwdWC9X6kUI2lUPRMd8LhejXI9o
 iYhilr3QyLO2JZybU/BCaYP4j0ztNZ4Wrj9bjgzLXSba/G3xnojdaK0vByFQW+DIalhRj
 NZJf/qjbkpaf5iVd9sCzK94GiHbjqIPW3zRUH7F+mNxNzHSlfhYDUyjuUiTUA8VU965oe
 zBXrwBbkcG3CjyziC5c/hmHmpHOBO93zx0wZNu8mQL7hM2go+u0woUcT8vr1g1rDPAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779063;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=uoMX3Y9/ObTKBxvbNQ3tp1z0d97PrZGu792ijsD8k+I=;
 b=MNnfTiz1Cxnz11tav7xvHLZkCNNPCJ71amfaUyUbxYYDbgyvcX6webtnyga0OgP7O7Ie
 urYT32QA86kUTYGwIyyWQQuu7+YYLM7gCf+IaHowGHQXAr5QyfsWqSvVa3//UnWgF8oEV
 9xLy7ytIoDpMAgaiHb6/aKrETah1LNdm330xknJu8Tu7aZMqMVM7VP+eHGjpuuUzRZVwR
 NzE6BrlCUGLopQVuisc77aRCvSQvo116geekGPlMw7byKj37ojS+PI1lS/2sYZ9MEMeQa
 37oUKbxpWyW7EQ9Dm7wVjm24NVJ1526Xhdlf0eCL+ok2kGAjdC5M1ZmLu/lrYsWnT2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="d/ZFPgQ5"; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d/ZFPgQ5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5AA780937
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779064; x=1820315064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F0pplmPp/ILlSOcSyeqQ+ooDXozDLzWq7pPp/tL7t/4=;
 b=d/ZFPgQ5oqqOWkt7AFoGpQELm7KWpvgGhDTpLpnOQbPPWrzzlKCVN9WY
 QOtnZDbzJX2iZXgkSS71Cw0b1KF5Nscp1eyF1qo8P60HPy96tZNj1K39s
 T1/uf5Wc1wqwMDMWE9sfEl1PSASWTyseCmTQyEGcdOf3eOSivpnLqF9n9
 mCETFSt4V9lLutmNxqEOQX4m7+r4mHX+N7Lu2IG4V/oxZsa8BRsOpLr62
 R5riVIiE5xOdY1SpMDQkj/9tTSi3pJCkE4u8+N3W2ziNcmjZzkY7/t05q
 7h2WA5L8XCcNbcri9yGT+iftzhDwDe8lqjIcluRUH09kVgWYINT1nmuEF A==;
X-CSE-ConnectionGUID: vjWFZG7ASKWxx9EVWlFDLg==
X-CSE-MsgGUID: g0B6LAC/QE2Q075uOORtKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214072"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214072"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:23 -0700
X-CSE-ConnectionGUID: 0ddHicIZQTCos+KuA/VGjA==
X-CSE-MsgGUID: OgWQMPyrQxe22AC09v6Qug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195369"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:21 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 04/10] idpf: drop v_idx from q_vector structure
Date: Mon,  7 Sep 2026 12:24:11 +0200
Message-ID: <20260907102418.2697317-5-michal.swiatkowski@linux.intel.com>
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

Storing another index related to irq in q_vector can be misleading. It
is only used when matching q_vectors with queues. It can be obtained
using 0-based software irq index.

Use irq.index (from q_vector) and get the hardware irq index
(q_vector->v_idx earlier) from irq_info structure.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     |  4 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h     |  5 +----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 86e5bb30ecc6..785d551c795d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -301,7 +301,7 @@ struct idpf_fsteer_fltr {
  * @q_vectors: array of queue vectors
  * @q_vector_idxs: starting index of queue vectors
  * @num_q_vectors: number of IRQ vectors allocated
- * @noirq_v_idx: ID of the NOIRQ vector
+ * @noirq_v_idx: software IRQ index used to get hardware vector information
  * @noirq_dyn_ctl_ena: value to write to the above to enable it
  * @noirq_dyn_ctl: register to enable/disable the vector for NOIRQ queues
  * @txq_grps: array of TX queue groups
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c75fc1fc4f64..2a3dd04ebe23 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4511,8 +4511,6 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
 	for (i = 0; i < rsrc->num_q_vectors; i++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[i];
 
-		q_vector->v_idx =
-			adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
 		q_vector->irq.index = rsrc->q_vector_idxs[i];
 		q_vector->irq.virq = pci_irq_vector(adapter->pdev,
 						    q_vector->irq.index);
@@ -4520,7 +4518,7 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport,
 			return q_vector->irq.virq;
 	}
 
-	rsrc->noirq_v_idx = adapter->irq_info.vectors[rsrc->q_vector_idxs[i]].idx;
+	rsrc->noirq_v_idx = rsrc->q_vector_idxs[i];
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 57e61936ffda..9a2e3665277f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -377,7 +377,6 @@ struct idpf_intr_reg {
  * @rx_itr_value: RX interrupt throttling rate
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
- * @v_idx: Vector index
  * @irq: kernel and driver irq numbers
  */
 struct idpf_q_vector {
@@ -418,15 +417,13 @@ struct idpf_q_vector {
 	__cacheline_group_end_aligned(read_write);
 
 	__cacheline_group_begin_aligned(cold);
-	u16 v_idx;
-
 	struct msi_map irq;
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 136,
 			    56 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
-			    8 + sizeof(struct msi_map));
+			    sizeof(struct msi_map));
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fbb3a0ba9791..71cac3e70ed8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1848,12 +1848,14 @@ idpf_prep_map_unmap_queue_set_vector_msg(u32 vport_id, void *buf,
  * idpf_send_map_unmap_queue_set_vector_msg - send virtchnl map or unmap
  *					      queue set vector message
  * @qs: set of the queues to map or unmap
+ * @info: interrupts info to map software index to firmware one
  * @map: true for map and false for unmap
  *
  * Return: 0 on success, -errno on failure.
  */
 static int
 idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
+					 const struct idpf_irq_info *info,
 					 bool map)
 {
 	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
@@ -1893,7 +1895,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 				vec = q->rxq->q_vector;
 
 			if (vec) {
-				v_idx = vec->v_idx;
+				v_idx = vec->irq.index;
 				itr_idx = vec->rx_itr_idx;
 			} else {
 				v_idx = qs->qv_rsrc->noirq_v_idx;
@@ -1913,7 +1915,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 				vec = q->txq->q_vector;
 
 			if (vec) {
-				v_idx = vec->v_idx;
+				v_idx = vec->irq.index;
 				itr_idx = vec->tx_itr_idx;
 			} else {
 				v_idx = qs->qv_rsrc->noirq_v_idx;
@@ -1925,7 +1927,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 		}
 
 		vqv[i].queue_id = cpu_to_le32(qid);
-		vqv[i].vector_id = cpu_to_le16(v_idx);
+		vqv[i].vector_id = cpu_to_le16(info->vectors[v_idx].idx);
 		vqv[i].itr_idx = cpu_to_le32(itr_idx);
 	}
 
@@ -1989,7 +1991,8 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_adapter *adapter,
 	if (k != num_q)
 		return -EINVAL;
 
-	return idpf_send_map_unmap_queue_set_vector_msg(qs, map);
+	return idpf_send_map_unmap_queue_set_vector_msg(qs, &adapter->irq_info,
+							map);
 }
 
 /**
-- 
2.49.0

