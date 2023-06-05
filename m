Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13812C7EE24
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Jun 2023 18:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C89410B5;
	Mon,  5 Jun 2023 18:21:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1C89410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685989291;
	bh=JE5rsPFoTwsVIDRXILiBB0HvE/N7CGODZFelYHtwARA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=u1cz788jPeKlUuANukCU7EB9QWTJ2cudbCts+PR4HCWnjbw6iELfqXgPIMhv4KmUF
	 0Dfr6/JytB4tUJnJjblVBjqjmM5N0N4Nw3h/28RO8/DDXTjpHfp9SSONLeIZWdcgHM
	 wYbsdf9pymM1Gv6LnYcXx755kMvt9KJ1fpUf4+n6er120Y95p668j6zHh6S9BQksK/
	 7YuwzpWGZiFjxkaIboVR7sgaCKCr8VmqzE4PEj6wjdK3y5RrtGS8Q2TF+nWAme0p7B
	 k8PCU+O/Uy0yoRylc9/kzfQBfgCbGeujM6P85Ngfx/kxwcEQfQYn+UPRrkgvox4Q3P
	 uMwYv7Fsfg5HQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZNsZ0GIQjOa; Mon,  5 Jun 2023 18:21:29 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A05DA4176D;
	Mon,  5 Jun 2023 18:21:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A05DA4176D
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A97241BF3C6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Jun 2023 18:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80DE182127
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Jun 2023 18:21:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80DE182127
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2qgDBTCX8qn for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Jun 2023 18:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D28E82121
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D28E82121
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Jun 2023 18:21:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="358896805"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; d="scan'208";a="358896805"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 11:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1038863363"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; d="scan'208";a="1038863363"
Received: from dmert-dev.jf.intel.com ([10.166.241.14])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 11:21:15 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  5 Jun 2023 11:22:49 -0700
Message-Id: <20230605182258.557933-2-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605182258.557933-1-david.m.ertman@intel.com>
References: <20230605182258.557933-1-david.m.ertman@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685989278; x=1717525278;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3HEfb0+Du9CKPz7B2iEe9q9csLd2CcxkbnPCXgyv8I0=;
 b=kjtt6tkDFc/4SigZI3twSQBQ11/+PI5uvUFtf5g+v2zfjx2k8Nq/Yod7
 iK773bQfCRUmaivgwkwg6hx5LI6F1GNj6dXSxqyKIRReyDRkIyXUS4mC6
 q/nhIAwJbwrXPHqKuNJivxVm/EsGzxCzgB88jJ9fiuTx+QnYjtCYyG/Y4
 U6wERgqNq4AC7DGeyrFNj7dJDWaO7FAGzn/gG8aVdvaPuULN72F3+qC6w
 MvAU9keaRA73R5NNLnCa4Oiy5UrE/g+4ZPzDhx+xIm1OkC9JFgdsnRqTg
 KF4kaO6md5rEVAxrEkg04cI7KtIsf2EKBRdnE5QkmQUU4zSRGQkre9Tz1
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kjtt6tkD
Subject: [Intel-wired-lan] [PATCH net v2 01/10] ice: Correctly initialize
 queue context values
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
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_alloc_lan_q_ctx function allocates the queue context array for a
given traffic class. This function uses devm_kcalloc which will
zero-allocate the structure. Thus, prior to any queue being setup by
ice_ena_vsi_txq, the q_ctx structure will have a q_handle of 0 and a q_teid
of 0. These are potentially valid values.

Modify the ice_alloc_lan_q_ctx function to initialize every member of the
q_ctx array to have invalid values. Modify ice_dis_vsi_txq to ensure that
it assigns q_teid to an invalid value when it assigns q_handle to the
invalid value as well.

This will allow other code to check whether the queue context is currently
valid before operating on it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  1 +
 drivers/net/ethernet/intel/ice/ice_sched.c  | 23 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a9f2e6bff806..23a9f169bc71 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4708,6 +4708,7 @@ ice_dis_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u8 num_queues,
 			break;
 		ice_free_sched_node(pi, node);
 		q_ctx->q_handle = ICE_INVAL_Q_HANDLE;
+		q_ctx->q_teid = ICE_INVAL_TEID;
 	}
 	mutex_unlock(&pi->sched_lock);
 	kfree(qg_list);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 824bac5ce003..0db9eb8fd402 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -572,18 +572,24 @@ ice_alloc_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 new_numqs)
 {
 	struct ice_vsi_ctx *vsi_ctx;
 	struct ice_q_ctx *q_ctx;
+	u16 idx;
 
 	vsi_ctx = ice_get_vsi_ctx(hw, vsi_handle);
 	if (!vsi_ctx)
 		return -EINVAL;
 	/* allocate LAN queue contexts */
 	if (!vsi_ctx->lan_q_ctx[tc]) {
-		vsi_ctx->lan_q_ctx[tc] = devm_kcalloc(ice_hw_to_dev(hw),
-						      new_numqs,
-						      sizeof(*q_ctx),
-						      GFP_KERNEL);
-		if (!vsi_ctx->lan_q_ctx[tc])
+		q_ctx = devm_kcalloc(ice_hw_to_dev(hw), new_numqs,
+				     sizeof(*q_ctx), GFP_KERNEL);
+		if (!q_ctx)
 			return -ENOMEM;
+
+		for (idx = 0; idx < new_numqs; idx++) {
+			q_ctx[idx].q_handle = ICE_INVAL_Q_HANDLE;
+			q_ctx[idx].q_teid = ICE_INVAL_TEID;
+		}
+
+		vsi_ctx->lan_q_ctx[tc] = q_ctx;
 		vsi_ctx->num_lan_q_entries[tc] = new_numqs;
 		return 0;
 	}
@@ -595,9 +601,16 @@ ice_alloc_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 new_numqs)
 				     sizeof(*q_ctx), GFP_KERNEL);
 		if (!q_ctx)
 			return -ENOMEM;
+
 		memcpy(q_ctx, vsi_ctx->lan_q_ctx[tc],
 		       prev_num * sizeof(*q_ctx));
 		devm_kfree(ice_hw_to_dev(hw), vsi_ctx->lan_q_ctx[tc]);
+
+		for (idx = prev_num; idx < new_numqs; idx++) {
+			q_ctx[idx].q_handle = ICE_INVAL_Q_HANDLE;
+			q_ctx[idx].q_teid = ICE_INVAL_TEID;
+		}
+
 		vsi_ctx->lan_q_ctx[tc] = q_ctx;
 		vsi_ctx->num_lan_q_entries[tc] = new_numqs;
 	}
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
