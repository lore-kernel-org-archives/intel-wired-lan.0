Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CECAC001DB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Aug 2023 10:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A2381446;
	Thu, 10 Aug 2023 10:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56A2381446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691663945;
	bh=wT+ueXp5NSI35RKVUsQMoCfJlX9hIgwi0kM28V+FzyE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=h3DN0JfUB16ZEPthC56WgVM2B01r7wTw/IQioPpNd9HzwV1armVvzCpAHadrpaYkg
	 IPcg9QUmeRZlpPtzv0qo7MOIx4EACC3pu/iQP6vlBwNa3adAfcIkuAy7kltr9f4IHE
	 ZuB9Nw5viQF6htdscou7TxH91Ja6Qpp2R62YNYMVs7GOpEg4VldGWe1HHOYqD2Q3KB
	 Fj6Xo2hXLcIozWYoxqSuNrlUIeFsffriEGjpPmDh/ymQlw0jiPruMv/lotLKD6RNX0
	 p9dTWNlbArA3xrh45F9IYgwgqBgSKD2zALO0zheupPf/gu715jJiCLJgp6EPBp8zxg
	 KSiEShExdV2Uw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q1huamyPvYFQ; Thu, 10 Aug 2023 10:39:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4299582125;
	Thu, 10 Aug 2023 10:39:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4299582125
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 188411BF34D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E65EC41576
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E65EC41576
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JtNq4onj4QDO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Aug 2023 10:38:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E92B416D1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E92B416D1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260823"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="370260823"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 03:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237177"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="767237177"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:43 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 39EBE340DA;
 Thu, 10 Aug 2023 11:38:43 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Date: Thu, 10 Aug 2023 06:35:08 -0400
Message-Id: <20230810103509.163225-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691663926; x=1723199926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BF7cE5dz2JhMGxpxJeiyh6dv9ygPGiyynieI2gJHd/Y=;
 b=hOAGCY0GcwlSnFL6Xdwk/a9MVdtJbdW6Qa1Uw/74FzVFbGV3IUdXMb1Y
 WpIStrJ8k8WAVIYi9JLVC7RTxNdRfgkQY8l3BHV1GJIhkwTfc2C3OVK+a
 cZXEiiwlAAYFf/KwpIRVDLwwuk0FgJ1nJ8zfg82beIHmuAm7BQ+fzB6rX
 jUqUmhsP0xfFwN7LjiuF5masvVCyuSWzw39stD7oJPT0aBAqDV2uTzjRQ
 /3nl5afsvXPjQ8zyopbx6npMzgjmeeTOCTfg3W5Sn/8w4oFCBxlXrsGRO
 HxmIV/3SN5YFh+TLSHKUVblfkRpPhOKB4aT5Txd9hcwXGD58OPLADTxf9
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hOAGCY0G
Subject: [Intel-wired-lan] [PATCH net-next v1 6/7] ice: make use of
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
index a86255b529a0..ca30316d70a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4734,11 +4734,11 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 		enum ice_disq_rst_src rst_src, u16 vmvf_num,
 		struct ice_sq_cd *cd)
 {
-	struct ice_aqc_dis_txq_item *qg_list;
+	DEFINE_FLEX(struct ice_aqc_dis_txq_item, qg_list, q_id, 1);
+	u16 i, buf_size = const_flex_size(qg_list);
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
+	u16 qg_size = const_flex_size(qg_list);
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
