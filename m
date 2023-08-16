Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228CCC001E0
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Aug 2023 14:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A695D41B83;
	Wed, 16 Aug 2023 14:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A695D41B83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692194988;
	bh=72UnLlV6itR9KNzuCYNV1WF1715hnruLJl+pdvMRRYQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=WVQ3qwZofDTug/K3UabEGJPoD/JQf+rB4/sWoS1aG+eBKD+0gZxAbd9sOaojlVi2w
	 aELI7XDatRPtv7wAoIOe56LFJtU0I7m4cfTt+BkWFdOLmpeg1vKVKu3t0ODSd9Ld1H
	 j3XK4uHyKyHILWgV6vkt2iVQrbELCixgqmF2ZLsr0NyPDigIDvXHi1rNDcS6tiws/M
	 gWuHglSDMkECU7Ic3IUKIgeGGo04rmdgICDwC5WsyC9iRry/V2p0mLMNCJT7ueNzH9
	 t1Dn7o51FBeC+dLx7HMdznyhNZT84XWe751jncp0QYef0bIb5ucut1Z6H5Zet5UZMK
	 mJqobRcu/NoNQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecsabVUjnMRM; Wed, 16 Aug 2023 14:09:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FA8641E26;
	Wed, 16 Aug 2023 14:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FA8641E26
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id EC30B1BF41B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 14:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E8A68321B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 14:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E8A68321B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5bxr0iVxR6u for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Aug 2023 14:09:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F17982F40
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Aug 2023 14:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F17982F40
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375312783"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="375312783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 07:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980753072"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="980753072"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:09:24 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 05D4735429;
 Wed, 16 Aug 2023 15:09:23 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Date: Wed, 16 Aug 2023 10:06:22 -0400
Message-Id: <20230816140623.452869-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692194967; x=1723730967;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kHT5VLpFxnW3y3muRx8bN91BLrmj1DCbAt4Yfl0iWZw=;
 b=K34qLVPttKbJqjoqJv5FDUzh1mQ0sTeQ7tLQ67O1tH6jWweKRUizNWY0
 /F15dhUILVVUyUQQs0uYL/H6xrtBZ6tPTCXiwqZZ3HgiqhxIRCj1HggYf
 2wjl4ddjZ69QWMYiHVhkZVm+RkalFTG7jCvCEOHTy/U7cztJN5NO3FJjP
 fPL49A5+Iba4DAgq994IMvwkkXSPePGLf0W1Pz8/PpIjaDLf6ITkxZpxb
 6fte7xT61d/mY/K5BrMMd+aqKLIdynuew5Mz/36penrJn5juLYCbqzNZ9
 GtIwzRaI1ULgrlYdAWtsKOvXkmdMbwQdpTuWUMAHdftOL4tKIJw5gua+s
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=K34qLVPt
Subject: [Intel-wired-lan] [PATCH net-next v3 6/7] ice: make use of
 DEFINE_FLEX() for struct ice_aqc_dis_txq_item
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Steven Zou <steven.zou@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Use DEFINE_FLEX() macro for 1-elem flex array use case
of struct ice_aqc_dis_txq_item.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 1/1 up/down: 9/-18 (-9)
---
 drivers/net/ethernet/intel/ice/ice_common.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a86255b529a0..158931424283 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4734,11 +4734,11 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 i, buf_size = __struct_size(qg_list);
 	struct ice_q_ctx *q_ctx;
 	int status = -ENOENT;
 	struct ice_hw *hw;
-	u16 i, buf_size;
 
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return -EIO;
@@ -4756,11 +4756,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		return -EIO;
 	}
 
-	buf_size = struct_size(qg_list, q_id, 1);
-	qg_list = kzalloc(buf_size, GFP_KERNEL);
-	if (!qg_list)
-		return -ENOMEM;
-
 	mutex_lock(&pi->sched_lock);
 
 	for (i = 0; i < num_queues; i++) {
@@ -4793,7 +4788,6 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		q_ctx->q_teid = ICE_INVAL_TEID;
 	}
 	mutex_unlock(&pi->sched_lock);
-	kfree(qg_list);
 	return status;
 }
 
@@ -4962,22 +4956,17 @@ int
 ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 		      u16 *q_id)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 qg_size = __struct_size(qg_list);
 	struct ice_hw *hw;
 	int status = 0;
-	u16 qg_size;
 	int i;
 
 	if (!pi || pi->port_state != ICE_SCHED_PORT_STATE_READY)
 		return -EIO;
 
 	hw = pi->hw;
 
-	qg_size = struct_size(qg_list, q_id, 1);
-	qg_list = kzalloc(qg_size, GFP_KERNEL);
-	if (!qg_list)
-		return -ENOMEM;
-
 	mutex_lock(&pi->sched_lock);
 
 	for (i = 0; i < count; i++) {
@@ -5002,7 +4991,6 @@ ice_dis_vsi_rdma_qset(struct ice_port_info *pi, u16 count, u32 *qset_teid,
 	}
 
 	mutex_unlock(&pi->sched_lock);
-	kfree(qg_list);
 	return status;
 }
 
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
