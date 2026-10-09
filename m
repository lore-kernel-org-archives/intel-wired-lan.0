Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E0ACA601F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 120C381036;
	Fri,  9 Oct 2026 20:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8EDWzcCe6_2f; Fri,  9 Oct 2026 20:12:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6171D8105B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576772;
	b=YhrRXWrD+gmI0YqC6wGSZsOr1eN9mDLftMqSEzQvamJN/ToCUEPDSnz6Ub/BFmPLrK6i
	 vgCbED4xC9BYxP8DbwPrDcXFBtTzG4JuhvTaBStUlfHq47GFuRQSYBk2b4+/b4K8GjG7L
	 WOkw7HJaJ5y1yEtIJ2mU/zxAWfV2F06kc7lCkwEzVB2kWbF94CY5dpCnWUtdUiY3BTPGG
	 uHU5i7eAUCfkWoeuv8fgkQEGFLqas/1CrtSsh+LPIp9fBL66m0BGNvrO3AAl0+FaG6OU8
	 VzZ/XHsks0/TRml9FJnxsP+aVJ6KJD1Sb+2FulCpzCjNsAT5lvP9ul1p+zGvwfTZObg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ltaJk0hmLkOYp3ZcPUAGVAH/spxZwYHVMAKmYTQ45vA=;
	b=UWhHXgDUdBR/DUOpAcgxAuPArQ2te0khPfY0nxE1EJjQM5al1Py6YmfR0ONcTW4GfuB2
	 HtwK5sJ++rA3JX93K452b7DQLRQBM/j5n/6LR1uPp9ZN8HYCSkDx7+SrKkBmUIEyUKYl2
	 Yhpu232BwDNDAmrc4GBOb9ciHlJOwmrFSDNJKMBTc9HxPW3z+nldR5b5l54DXH8C+touq
	 XDJQqgpyDn1SjmUtuzg1sGpZUqZhAQH7AyxhTx12JDScdSpSE26O5wFXKVdQwfpyBIgPR
	 PFvS+rNBTYQXEMP6PySGwi8t5SRDwgWMXRyEptDIECLjYtQTguz/Te8iCH02RS8uMSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bET3z78X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576772;
	bh=ltaJk0hmLkOYp3ZcPUAGVAH/spxZwYHVMAKmYTQ45vA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IxA/ZVLtpcPmlGTur3vldd/OetcCmgFjyOPO50M7+BBul7QSfCpTcuWyec8QHSw6U
	 wgfOWVsirc1OsbGFUIlGOgFiVo1ic1lxgACmQwh8Y7qFGfkycvvOxRhydTNeZAS61u
	 djCwapA8VqlV9T1jaFu3yOV+v8HOayonmyL7Hs2z3ILEsnOcxnKgm6M22zRSS/g8p8
	 u8xMJD1qJmzhJ6wvhTqYUVrC2/IMlH7HnF5VeLU8MATtztpiluB71JM3A84OyNut6g
	 SMLS9W2v0qMCRdGY5bGiKQ5t5H05D89cuVbwPR5Uv3ZZ8sFgCoIL/yH+EuKT6NQKR3
	 NqhFVQ8W+MMvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6171D8105B;
	Fri,  9 Oct 2026 20:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3C363B4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D92E180FB1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2itUkiEyMvt for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08E2980FB7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576767;
 b=Zwr82s1dolT3OSqRPHEo+rszIsGyWdak13NJ4ruq9OtiSLCt4t11QPS1zl7d09mFM/pv
 lybJ3AlA08T/j2IsChlb2xDTKPpK0sLujN0XlXA3bP3pezmN9J3Y3KMkBuxT5smMfcj1g
 uVfiNMEoCU9AgZ+Mg//HeU6/IC+uQwH3HYoSR4Zw3ypBj0W6wK7zyMNn5xSkPstufvse3
 ruwAGhcn4tzp2Hq8BtYHSdLSYp9i45ZelDof37xat0aT+SnS4isXETDOdbtiWg7TpNYi6
 24Vj+nphHzxHZncCKzj/G8wPWyk0EEKI8h5NrpJulGcvPyuDNRm1QYb8F8B+Y+HG3qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576767;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ltaJk0hmLkOYp3ZcPUAGVAH/spxZwYHVMAKmYTQ45vA=;
 b=LYiLDd7IiiQicnhbB1SLBLg1Yfzp4iqfoJ9kpmkfwoFePb/GKEwtJyu3sw1fyyRLkgxV
 1Zq2wn8tCGYFG/sY13eLxWsIRiTi0Nx6+e4McBiwKRM+UP5g34ALU3pHJulfjxj9WRYI1
 Axi/kGc5U3Oj8uxNl+7OpG9bfCUbN2bAN13QhYnZKvS3RqYL5ocJ4fAV8vmVZkurURFFU
 0XYFM5T36df/3QzjUzFndfk9aMvvvU9KJYcX5D0PLpP7VKKHd1Ki+68rDIURZMv1ndU4r
 fHADhtzncINdDmiFHXfGcqqYDMtFdwW4UVAratApMiEC4gjlgYQr3V5NedhTSBnMg4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bET3z78X; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bET3z78X
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08E2980FB7
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576767; x=1823112767;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=jQ9XYj14RoHZqkpxDhTaj5dz5SQfXkluvMjMsAGK73g=;
 b=bET3z78XPkuK2Nc/wMPH2+qUWkShuJDezmXASUnrO/iGscv5fO8iOB9d
 dgaM/OkTl3DReAUzUhdprViy4YrNhiYvoe3iIBlMpET+QhhKNCW1FUcYn
 rwEz4auqgCIrFWXZ+hyKtUhmDcXyCFQOB2W8C7eLbRcFFwhizgH1eDr+W
 9qAbS/w2f7sqBWhWrg1Kr39TGok71DHTgGfUsorc2yxss2y3/6CTSEHy4
 IfszBnpN8bHXfkYIpxIJH8n8PIIgEq1pVshPrJgX0rUBM+gsxH3Qu/Zvz
 bfxQM/G2G7bCtcPZxTH5m8Ploq1iMNWJ90Aety4yJMl8G9ZqCsiZmLC6l Q==;
X-CSE-ConnectionGUID: R3we1nVCRqeabEwiNWAtHg==
X-CSE-MsgGUID: gRWOX2GsReuAV0aKdUL9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261913"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261913"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:45 -0700
X-CSE-ConnectionGUID: 9nWrfNhRRqmvW7JgqgMhwQ==
X-CSE-MsgGUID: M3ipZvaLQs+mYNL/wsiMoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189811"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 09 Oct 2026 13:11:22 -0700
Subject: [PATCH iwl-next v2 6/6] ice: remove unused aggregator node functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-6-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3607;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=jQ9XYj14RoHZqkpxDhTaj5dz5SQfXkluvMjMsAGK73g=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXttUM9JNlrQGH+g4k/Amz0LJxjvUkjPr/m/ugNLul
 x4H2eM6SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmMgNe4Z/JmfK51kVlTHu/Kab
 vXlFVjjTHBXdrFSr46rHhbQDrv51Yvif9Ktb636Pv957yeVz509VXNRXPPOB5vX/rNklT+rPfv3
 ECQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

With the introduction of ice_cfg_vsi_agg(), the ice_cfg_agg() and
ice_move_vsi_to_agg() functions are no longer used. Remove them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.h |  6 ---
 drivers/net/ethernet/intel/ice/ice_sched.c | 61 ------------------------------
 2 files changed, 67 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index b9ea9174f3d9..30b55bab09d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -140,12 +140,6 @@ int ice_cfg_vsi_agg(struct ice_port_info *pi, u16 vsi_handle,
 		    u32 min_id, u32 max_id, u8 tc_bitmap,
 		    u32 *configured_id);
 int
-ice_cfg_agg(struct ice_port_info *pi, u32 agg_id,
-	    enum ice_agg_type agg_type, u8 tc_bitmap);
-int
-ice_move_vsi_to_agg(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
-		    u8 tc_bitmap);
-int
 ice_cfg_q_bw_lmt(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 		 u16 q_handle, enum ice_rl_type rl_type, u32 bw);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index f0b1924b0411..fbee7863394a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2777,37 +2777,6 @@ static int ice_sched_cfg_agg(struct ice_port_info *pi,
 	return 0;
 }
 
-/**
- * ice_cfg_agg - config aggregator node
- * @pi: port information structure
- * @agg_id: aggregator ID
- * @agg_type: aggregator type queue, VSI, or aggregator group
- * @tc_bitmap: bits TC bitmap
- *
- * This function configures aggregator node(s).
- */
-int
-ice_cfg_agg(struct ice_port_info *pi, u32 agg_id, enum ice_agg_type agg_type,
-	    u8 tc_bitmap)
-{
-	struct ice_sched_agg_info *agg_info;
-	unsigned long bitmap = tc_bitmap;
-	struct ice_hw *hw = pi->hw;
-	int status;
-
-	mutex_lock(&pi->sched_lock);
-	agg_info = xa_load(&hw->agg_nodes, agg_id);
-	if (!agg_info)
-		agg_info = ice_alloc_agg_info(hw, agg_id, agg_id, agg_type);
-	if (IS_ERR(agg_info))
-		return PTR_ERR(agg_info);
-	status = ice_sched_cfg_agg(pi, agg_info, &bitmap);
-	if (!status)
-		ice_save_agg_tc_bitmap(agg_info, &bitmap);
-	mutex_unlock(&pi->sched_lock);
-	return status;
-}
-
 /**
  * ice_get_agg_vsi_info - get the aggregator ID
  * @agg_info: aggregator info
@@ -3052,36 +3021,6 @@ ice_sched_cfg_node_bw_alloc(struct ice_hw *hw, struct ice_sched_node *node,
 	return ice_sched_update_elem(hw, node, &buf);
 }
 
-/**
- * ice_move_vsi_to_agg - moves VSI to new or default aggregator
- * @pi: port information structure
- * @agg_id: aggregator ID
- * @vsi_handle: software VSI handle
- * @tc_bitmap: TC bitmap of enabled TC(s)
- *
- * Move or associate VSI to a new or default aggregator node.
- */
-int
-ice_move_vsi_to_agg(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
-		    u8 tc_bitmap)
-{
-	struct ice_sched_agg_info *agg_info;
-	unsigned long bitmap = tc_bitmap;
-	int status;
-
-	mutex_lock(&pi->sched_lock);
-	agg_info = xa_load(&pi->hw->agg_nodes, agg_id);
-	if (!agg_info)
-		return -EINVAL;
-	status = ice_sched_assoc_vsi_to_agg(pi, agg_info, vsi_handle,
-					    &bitmap);
-	if (!status)
-		status = ice_save_agg_vsi_tc_bitmap(agg_info, vsi_handle,
-						    &bitmap);
-	mutex_unlock(&pi->sched_lock);
-	return status;
-}
-
 /**
  * ice_find_available_agg - Find or create aggregator node
  * @pi: port information structure

-- 
2.56.0.rc0.395.gd1f3524e15dc

