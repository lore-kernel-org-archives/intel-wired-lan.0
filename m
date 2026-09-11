Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB49CC88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74C424081F;
	Fri, 11 Sep 2026 13:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ymjbiJ1KJSM9; Fri, 11 Sep 2026 13:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8DC1F40820
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133461;
	b=PKJaWgTKLz5kzK4LBXAWt9yIrq8yKA5nOMtvEd2KoyVJVY6GhvmCHU3jsmtVk27MxewO
	 5JkXqv1TU6poLPWO21R5aS97rrtxDzX4heCqD815jBtb4lINVtxyXGUKaUUBmQ1FNqr6O
	 h7//jypnL3dwr2IouY/xcdqvNJIg89HXG9EC6vuKvdr3a9kVyY2euHYXrpta4Mwp8bJXE
	 BIDdBdmU7Q7unAbLZrZw7IMX4EEtF/uAzTFPI+sXo00R/C4y37pKAaOII9ilQ2jTPHK/o
	 NIw1+1LWSySRk6gh+uRC3IlMbzqD5oEK0/bTJOxnPADvkl2Rczw4kwHNP8sFaTb0VeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C2Km/7nsz71mn9jUOp9fU7ITYCR4p+390XXSpeGF6Gc=;
	b=LZlYwLkeSi2QWPithnIi0U5cd3OAJOBpYDtxNHAXdod9dnk3TMTf9Y6Mms7aqHyT3bqq
	 r2DaEId9Xuv1l4+5XDaqfApTAlVsDx4hqxhAjTMjihcquIMQAmTnNQ9kcHRYXRjDJA9O4
	 9cq3s2P2vTMtW0+cMyB5l0pC2ak+IxoqQHcPvsJix7Y/Rcg5xOeB1/pEVj0hwmiGdIDGS
	 QkQ7Hn9Gqeks2B2QW4j7jFne2CO65DVs0mBkIJXw988S6bx0iOvmK1V9b0Fxze1MZ9oWV
	 SqMdrbUeOOIFO5rAPsoI4ZYC41EsmX0QKcbiZYvMs/1nzHFi6Nmr+LHeIMAs5eyHZGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=msKimDQu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133461;
	bh=C2Km/7nsz71mn9jUOp9fU7ITYCR4p+390XXSpeGF6Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NKV019EJkwBaEOwhBZuzItSpZkmjsHJEs2mQ3pC9j1j9m08uanrgsPT8emT/VNfWI
	 JQMsj4+RmYBSPbX2vwW+LI88z8pMvBsWqVTg/MhUd7SFBqtuBGX4Sy3C+bwnfbVkOi
	 imj/oeMsh6e0zV44YWfH1p5v3offFUzB8PKvD7KqSgafWoLAxOBEy5ywhbqcuVhPU7
	 nFwcHBcO5v/FHR+KjePOVyP6efVL9EWI9+yLOeAcnrOd0WAuQj7CNVS9GjKghT+iRW
	 lycza9I1K8qYTziZrKYelNKI2Ny4dstxWtSl69H0oBhecS9+ZkpXY1Y1S39TVfttd3
	 emqFEXijDZm6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DC1F40820;
	Fri, 11 Sep 2026 13:31:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76F13786
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68CF84080A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-KIFkfl4ZQb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE5FC40607
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133458;
 b=tGs/A69sBzwjFuZbUo/dWyJpFCrUiqlPfjj2fUNR4CPMa7f1iTP5EbCScQIwGbxIiAYK
 LKuPHZ/6npiNE0CQTrk4rtBggEX4O0wKIJi9g1v1GErfzeT2CpuFPjrUS5AIP2B4FaIY9
 GitsDtxLFdRoXfvx28YqK2k5eqzSD/OFp/a4wXnWhoAOwfWWWhxtU+Mi+CMrQumbDWrsr
 EZtLNrIFcCreJJgB7y/48C/KQ+lLRgUCl/riYBc0krFwPxQwiek6eLk75cYuQG7ZtkkZU
 a+QuonIk6XUrMxnqi3c4CYWFaGii5tk9/vdUrkMvlg2qWs90vzP5V0fF2QcPnG+JhtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133458;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=C2Km/7nsz71mn9jUOp9fU7ITYCR4p+390XXSpeGF6Gc=;
 b=J56W29jiHuOijRVcEMTbSiILwDm5O93stBfI1EYQQlFWgttiocMtC1HBCcV5uVR0OpB2
 uzxwcfsiKSZ64bq8FLeBZBvylTspoR2kjMMnghR5T3NONYvzxA+anJfU1xFx9KFH5TqD4
 6FdKxw1bXjE8uHyEySICHxs+XTXTgZMys1XZR2mqxPlOefbYuRHtFOok9szgvpg+5Rl12
 9FLY64THckUbHm7iuCtg0vVQXrKbqaqI0XwPNtmjFGMIFO5dzX4VTBsLUcIBwWdKAZ+X5
 diANr8sPY0/1bvIqWrVY/uggQAPXFCqy/2WoARMPhYKwLLTo7TSUa1uu6IPZzbr09mA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=msKimDQu; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=msKimDQu
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE5FC40607
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133459; x=1820669459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/ylOZDTopd1lsD5tWtHC0lFWnQ3WnsY6z99ehpaGslA=;
 b=msKimDQuswc3Mv339F7/KAdpjsMVT6CEDj7bFK+HngdZg4O+z+EYm2JG
 uAFkM0XE1eI5R/FqEvocd9/Zl+d3NPYq8R4axmUaJXZNVWGZXM77NAilN
 LL/qmw2wIFQGOa8FawXJ43L+krlYRyr9RSWSfNWyDPkkMICG/7fgIVsos
 XfEOh50ikUWR+ojV/ix+JYdx8FNn55lV/ds+fvPRUg1EFYnhDaQXiok8F
 8i8W5hy3JTsL0019wZaS5/rrlBeq7CbbPylhniXqbOuxbMLSt4YVw/xGn
 jhvKXSAxNdxnIAQwwImPxkCGu6BbUs6pc7ri8vUar62Ppq4aQxpL+mVKz g==;
X-CSE-ConnectionGUID: OQmaasjDTwaxnE/zgyWWNg==
X-CSE-MsgGUID: 5lVPUyFhQ8ywHVohff8Qbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107532"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107532"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:29:57 -0700
X-CSE-ConnectionGUID: QqsmpH/cQ8mGnbrlNP1ToA==
X-CSE-MsgGUID: FF4UPsocTeK9slgdN1hwNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541276"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:55 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector structure
Date: Fri, 11 Sep 2026 14:49:15 +0200
Message-ID: <20260911124921.2881348-5-michal.swiatkowski@linux.intel.com>
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
index 267ac9fa3846..90f3c40c7928 100644
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

