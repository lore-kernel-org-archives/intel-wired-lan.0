Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D0DC88E50
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A41B80F4F;
	Fri, 11 Sep 2026 13:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XTmga_oW_3Og; Fri, 11 Sep 2026 13:31:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 304C880F76
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133467;
	b=H2H4yS1/aQ734cr/7VC4nTaTqmllTjDPCSsPdzMO7O4YEXECVQDUNjkzuJ5TIVMZe47L
	 y4uhrCeIMAOIGVeX0TOip46eeCY1yAwciieNFZ5FZJPcsoefNruK6Q1xTmuLQUDonScVQ
	 MwT8jhFQY8rb2KT+2rpHexHCriUFxSJjxzwILFua2m6BcksNlH1NUIOo1sSn0td5Gowbf
	 hKTxQDjLxly4wR9KQgSysH9QVpggZ3x071PAbTyzWQwV8x6+5euSxYI77rZwv7jgtwKWp
	 yH5UHSkHI2YaiSeH62pusovxjY1/zCAL520jMcKMRtYQj7r3Ng20I8MhGJyJpUUrmjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UHXi1L1JX9b1koc1j68g7RL/sdgttZZqObAm6+trDDs=;
	b=fTMgTAjay1TfkWy7+DWXt+s5vuk3bgyl4Mv4iZ5D0NwhHu0p7bhYVEWDN9CCWIdv4k5D
	 DD7n/QHDWCYbQpEo1GsgiAXqfTBMcyug7MdsIOP7gkicImMpiCA5gqi+4T7pzEpmsqoI3
	 TWVSD4rwzg9zw1H2BlrT5LzTn+tc3GMXpLFSLzxj1fHi09fv+pzAH94ezXgNxNK0Z/RtI
	 HdHPWwvofXU3DQ4tzvKA37EFrM9UZAe8Un1nrs9rFdlcTjBadGp2NMVWhyt3YJWMBcG6C
	 JkR9r08YV0Vjk2c+mAwRcOw/oq9pvm2jIhkRRwg/shRKGgoEKj9ry/nIkQiqWZwjbmA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133467;
	bh=UHXi1L1JX9b1koc1j68g7RL/sdgttZZqObAm6+trDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEIOhaS7ptGk07Gd9BfBWk7GfJm3/YcqqgFfVPK+w3QmrOhvPOPy/wCZDTn3u0ntb
	 31fo+nTmFhU7tm+44810/SQQkrYuJ5rXeBHZ1qfA7cIMkDJBNdlT2YPtsVydMXToGR
	 Qxq76mMxm1j0VtoaE6tvo+d8Hz/POs5jJTD1EamFzOm7peEuoiTpNiyi1PyIphCZq3
	 WHKK6dtbBlKisE+OEsgjr1T4jkgVq7Q9V4IgPTy+E7KuxEMcRecJcrJnu7CUY3NEmD
	 PKkg1BSReVs9RjhNXlAvgprZuTYx3Ta51z6j5U3y7VCK4cgmB+afFDjehYaVbX51AY
	 RF0YoqSPMrk9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 304C880F76;
	Fri, 11 Sep 2026 13:31:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3631786
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9982540607
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cj4GwP2H-Fvy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B0E3D4082C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133462;
 b=o+jaHxKGk3HHKA3xa8p7o8rzUh0cGDeBA/0yVlsnhK/440Bni8KKyGkqRgoEr+w2Nx/E
 7tW7uNLm5xYs20OWqJCciKnBKw61CzO4aY2rfz+pE6KLOJbQ532c0kkLQUSsSMou3jqvw
 O5x9YwaH0DATK3kM0QBcNCBlkEa+dAgk4LAnOMb/oiNfm2qDdhYC5gtF+CJSBgKTwzgtC
 mvcVfRS9lO8k+QN1ACqyIXy0E4eYPnKB8SwvBm7XVj2Z1tO/WqgeSrv7BtbIUb0B8juyr
 5n4Xmewhvd2bScyz5y+puqQfesBPfhbheg1YdYwVUqbXBEhofZa5xbbC6V8QNdyGeQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133462;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=UHXi1L1JX9b1koc1j68g7RL/sdgttZZqObAm6+trDDs=;
 b=BC9myWtE7i+d2JwTWqaic65+Am/UnECSzSbryt/59DqI/I0ik693aUfWnlDRa9dVskBT
 pY9+tQbXMSElJFT3bI8rdFfNGZE5Be8nvHtat32B1fyFqN/B2j74MISyGcPyatVFPkYii
 M5P5Lth7FaPWBDd8aEvJVX47VFZjW9qQAAE9zdfFAA2uPpAoOk8L8B4pJJ3B5fT8pfi/l
 blMSuhDaPmB0vvVMILPeHB8P/9JaXyD4PY4ugBec8WeW/biLDSYvkrWHLZVs3iV51yfUP
 TwHgUrDejmqZ3cNA3ZsxnSg9wUW+t4ZhoftRfjg6KRgzywwB9qtSI0JhmdY5s1ITQ3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KW3GcapD; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KW3GcapD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0E3D4082C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133463; x=1820669463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QG3ur83XOtOOg25xuU310Iz7aILIS2X6R2xAAnUmZ/I=;
 b=KW3GcapD4h0tig7qgFM2lWl1cslxT28ooDmS7YkRidU6ZL9B+Z9rEII1
 cFi+jg+cmFM6doaNszjysdRqyf0oamdqsc33ergPDi/+omM0WruDUa1jB
 xZomsuVpTxZ/nvChx8+s/BY2fUGAsJWydo1zyGo096ECQ82ykydbzRbI8
 R5AiMsI6u8sCC8qIXYKKfL2aai2W6sG5YbTlFbWdSadS2DJ3J5JXWeJA8
 /Ya8aDqqOzC8g8tzr+xtHdA8lohHO09tVTPVT006YpJMal8w/I/0HrX5x
 OBGmEM3mWcAZGVn4s/faEwCKEcbjTYBBIm0bHqx28/cTtxPr5qN1MVQnk g==;
X-CSE-ConnectionGUID: 940GumfmSvSOckgp9e+4UA==
X-CSE-MsgGUID: 9r/ggyJoRuCi95peLX2p+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107539"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107539"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:30:01 -0700
X-CSE-ConnectionGUID: HinyNYxgQR6wH51IcRAerQ==
X-CSE-MsgGUID: 00BpB9msRE2vg4HMfGhB1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541287"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:30:00 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 07/10] libie,
 idpf: move parsing alloc vectors command to libie
Date: Fri, 11 Sep 2026 14:49:18 +0200
Message-ID: <20260911124921.2881348-8-michal.swiatkowski@linux.intel.com>
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

No functional changes. Just moving to make it available from other
ipu drivers.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 85 +----------------
 drivers/net/ethernet/intel/libie/irq.c        | 92 +++++++++++++++++++
 include/linux/net/intel/libie/irq.h           |  9 ++
 3 files changed, 104 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 20e471def235..3df6ad291e64 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2229,83 +2229,6 @@ int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
 	return err;
 }
 
-/**
- * idpf_create_vectors_info - Save vectors information from firmware
- * @info: parsed information is stored here
- * @caps: virtchannel capabilities
- * @vectors: vector information from firmware to be parsed
- * @num_vectors: number of vectors
- *
- * Returns 0 on success, negative on failure.
- */
-static int idpf_create_vectors_info(struct libie_irq_info *info,
-				    const struct virtchnl2_get_capabilities *caps,
-				    const struct virtchnl2_alloc_vectors *vectors,
-				    const u16 num_vectors)
-{
-	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
-	int all_vectors = num_vectors + IDPF_MBX_Q_VEC;
-	struct libie_hw_vector *vector;
-	int reg_cnt;
-
-	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
-		return -EINVAL;
-
-	info->vectors = kzalloc_objs(*info->vectors, all_vectors);
-	if (!info->vectors)
-		return -ENOMEM;
-	/* Mailbox irq information are stored in different places. Fill index 0
-	 * of our vectors info with capabilities and rest with information
-	 * from vector chunks.
-	 */
-	vector = &info->vectors[0];
-	vector->idx = le16_to_cpu(caps->mailbox_vector_id);
-	vector->regs.dyn_ctl = le32_to_cpu(caps->mailbox_dyn_ctl);
-	reg_cnt = IDPF_MBX_Q_VEC;
-
-	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
-		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
-		u32 dyn_spacing, itrn_spacing;
-		struct libie_vec_regs reg_val;
-		u16 vec_id;
-
-		reg_val.dyn_ctl = le32_to_cpu(chunk->dynctl_reg_start);
-		reg_val.itrn = le32_to_cpu(chunk->itrn_reg_start);
-		reg_val.itrn_index_spacing =
-			le32_to_cpu(chunk->itrn_index_spacing);
-
-		dyn_spacing = le32_to_cpu(chunk->dynctl_reg_spacing);
-		itrn_spacing = le32_to_cpu(chunk->itrn_reg_spacing);
-		vec_id = le16_to_cpu(chunk->start_vector_id);
-
-		for (int j = 0; j < le16_to_cpu(chunk->num_vectors); j++) {
-			if (reg_cnt >= all_vectors)
-				break;
-
-			vector = &info->vectors[reg_cnt];
-
-			vector->regs = reg_val;
-			vector->idx = vec_id;
-
-			reg_val.dyn_ctl += dyn_spacing;
-			reg_val.itrn += itrn_spacing;
-
-			vec_id += 1;
-			reg_cnt += 1;
-		}
-	}
-
-	if (reg_cnt != all_vectors) {
-		kfree(info->vectors);
-		info->vectors = NULL;
-		return -EINVAL;
-	}
-
-	info->num = num_vectors + IDPF_MBX_Q_VEC;
-
-	return 0;
-}
-
 /**
  * idpf_send_alloc_vectors_msg - Send virtchnl alloc vectors message
  * @adapter: Driver specific private structure
@@ -2350,8 +2273,8 @@ int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors)
 		goto free_rx_buf;
 	}
 
-	err = idpf_create_vectors_info(&adapter->irq_info, &adapter->caps,
-				       rcvd_vec, num_vectors);
+	err = libie_irq_create_info(&adapter->irq_info, &adapter->caps,
+				    rcvd_vec, num_vectors);
 	if (err)
 		idpf_send_dealloc_vectors_msg(adapter);
 
@@ -2378,9 +2301,7 @@ int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter)
 	int buf_size, err;
 
 	/* dealloc vectors can fail, but irq_info still needs to be cleaned */
-	kfree(adapter->irq_info.vectors);
-	adapter->irq_info.vectors = NULL;
-	adapter->irq_info.num = 0;
+	libie_irq_destroy_info(&adapter->irq_info);
 
 	buf_size = struct_size(&ac->vchunks, vchunks,
 			       le16_to_cpu(ac->vchunks.num_vchunks));
diff --git a/drivers/net/ethernet/intel/libie/irq.c b/drivers/net/ethernet/intel/libie/irq.c
index 0f73f8becefb..d26ffeffdcb2 100644
--- a/drivers/net/ethernet/intel/libie/irq.c
+++ b/drivers/net/ethernet/intel/libie/irq.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include <linux/net/intel/libie/irq.h>
+#include <linux/net/intel/virtchnl2.h>
 
 /**
  * libie_irq_init - init irq for whole device
@@ -250,6 +251,97 @@ int libie_irq_reserve(struct libie_irq *irq)
 }
 EXPORT_SYMBOL_NS_GPL(libie_irq_reserve, "LIBIE_IRQ");
 
+/**
+ * libie_irq_create_info - Save vectors information from firmware
+ * @info: parsed information is stored here
+ * @caps: virtchannel capabilities
+ * @vectors: vector information from firmware to be parsed
+ * @num_vectors: number of vectors
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int libie_irq_create_info(struct libie_irq_info *info,
+			  const struct virtchnl2_get_capabilities *caps,
+			  const struct virtchnl2_alloc_vectors *vectors,
+			  const u16 num_vectors)
+{
+	const struct virtchnl2_vector_chunks *chunks = &vectors->vchunks;
+	struct libie_hw_vector *vector;
+	const int mb_vectors = 1;
+	int reg_cnt, all_vectors;
+
+	if (le16_to_cpu(vectors->num_vectors) < num_vectors)
+		return -EINVAL;
+
+	all_vectors = num_vectors + mb_vectors;
+	info->vectors = kzalloc_objs(*info->vectors, all_vectors);
+	if (!info->vectors)
+		return -ENOMEM;
+	/* Mailbox irq information are stored in different places. Fill index 0
+	 * of our vectors info with capabilities and rest with information
+	 * from vector chunks.
+	 */
+	vector = &info->vectors[0];
+	vector->idx = le16_to_cpu(caps->mailbox_vector_id);
+	vector->regs.dyn_ctl = le32_to_cpu(caps->mailbox_dyn_ctl);
+	reg_cnt = mb_vectors;
+
+	for (int i = 0; i < le16_to_cpu(chunks->num_vchunks); i++) {
+		const struct virtchnl2_vector_chunk *chunk = &chunks->vchunks[i];
+		u32 dyn_spacing, itrn_spacing;
+		struct libie_vec_regs reg_val;
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
+	info->num = all_vectors;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_create_info, "LIBIE_IRQ");
+
+/**
+ * libie_irq_destroy_info - free memory allocated during building irq_info
+ * @info: libie_irq_info struct to be freed
+ */
+void libie_irq_destroy_info(struct libie_irq_info *info)
+{
+	kfree(info->vectors);
+	info->vectors = NULL;
+	info->num = 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_irq_destroy_info, "LIBIE_IRQ");
+
 /* Module */
 
 MODULE_DESCRIPTION("Helper functions for managing MSI-X in driver");
diff --git a/include/linux/net/intel/libie/irq.h b/include/linux/net/intel/libie/irq.h
index e219fde575d8..8d5873f13871 100644
--- a/include/linux/net/intel/libie/irq.h
+++ b/include/linux/net/intel/libie/irq.h
@@ -105,5 +105,14 @@ struct msi_map libie_irq_alloc(struct libie_irq *irq, enum libie_irq_type type);
 void libie_irq_free(struct libie_irq *irq, struct msi_map map);
 int libie_irq_reserve(struct libie_irq *irq);
 void libie_put_irq(struct libie_irq *irq, unsigned int index);
+/* IPU specific functions. */
+struct virtchnl2_get_capabilities;
+struct virtchnl2_alloc_vectors;
+
+void libie_irq_destroy_info(struct libie_irq_info *info);
+int libie_irq_create_info(struct libie_irq_info *info,
+			  const struct virtchnl2_get_capabilities *caps,
+			  const struct virtchnl2_alloc_vectors *vectors,
+			  const u16 num_vectors);
 
 #endif /* __LIBIE_IRQ_H */
-- 
2.49.0

