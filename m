Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F2FC30653
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Jul 2024 09:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49A6280C87;
	Mon,  1 Jul 2024 09:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RBk5QXWtQ4-U; Mon,  1 Jul 2024 09:08:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DF4080C88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719824905;
	bh=dwokcwK71RRmLgOgIN0UqhDmh4xnBwx2r0rsxxx2TgE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=FzIwmt99Fy0kiYU/HOZDM44MnA30HoQ/JR0deYYvci7ppn/zHgWMMQnnrZBwLDlcE
	 WWBBdwcokU+2Ji8VltA586oPcgRk/0vJwdojHJ/E9eEjha6026S3Y/ADNQyThqY/js
	 S6Nb8/l33xYOEmtvaUR5VsiZrJvIXtFMUyWNEVT9QT+g5kQfvCeyroNhX6bN0GVMud
	 mAwQRIm4K5yrJkV/mK5daK1yuO4Zfpirs4qmrv3vXN0UHQmL+i9xJ5eJMkHOySK3u5
	 Ge4cXdcYkmCpE0Z2Hxp4adcA0kuKdBM3wiICk0JlX8vgMVNEihKg/Agd6eQhuNqKHi
	 ZpeuKu+A64CBQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DF4080C88;
	Mon,  1 Jul 2024 09:08:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2D25F1BF35C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 09:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1895B409F2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 09:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uW3oR364-05y for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Jul 2024 09:08:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=wojciech.drewek@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1C5F3409F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C5F3409F0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C5F3409F0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 09:08:22 +0000 (UTC)
X-CSE-ConnectionGUID: RRjvlx5oR1eCIUPmdi5PSA==
X-CSE-MsgGUID: 2SIQhDIhQRmAnpMTDxTLrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="27619852"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="27619852"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 02:08:13 -0700
X-CSE-ConnectionGUID: a+j0va57ThSCMnb84GNGxg==
X-CSE-MsgGUID: JgXYfGS6SCuOGaCyI9jnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="45281920"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa006.fm.intel.com with ESMTP; 01 Jul 2024 02:08:11 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 512E4125BB;
 Mon,  1 Jul 2024 10:08:10 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  1 Jul 2024 11:05:46 +0200
Message-Id: <20240701090546.31243-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719824903; x=1751360903;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YzoctkienM/RHSl/MxnQWSeBZnA19kNmBR99veARymE=;
 b=CFPTWS0IlB++TgNzxvQQFo330LIewhOXx6K5JwS1FpZiagPO+oDVOFpJ
 WO168w4TRcDt2+l1FYPdIo89F+sOOB5cN4wdp03A9MPzTgNg0ift8zBMW
 K3i7SLPFHt2fjfeCCdClxDA35+IX7KIcFN9DhoIYo/hdOZlQE57k+v8q1
 TeSFIK0W6ZFI/Ijg3wsBcjRC28M3PygQNIjtqUs6hJTIR6NjhVmz1gkpj
 2wvPRpaNVBm5hTYEqC8TWPziVsQ9dGkhnIQebltUgRf0Ys0rsSwT69qJA
 LHl4cULaLd6sZbujmTCJA2SPSfBh4grOPZCCSPNlclXW7ERFn6qPXNB97
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CFPTWS0I
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix recipe read procedure
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
Cc: przemyslaw.kitszel@intel.com, marcin.szycik@linux.intel.com,
 netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When ice driver reads recipes from firmware information about
need_pass_l2 and allow_pass_l2 flags is not stored correctly.
Those flags are stored as one bit each in ice_sw_recipe structure.
Because of that, the result of checking a flag has to be casted to bool.
Note that the need_pass_l2 flag currently works correctly, because
it's stored in the first bit.

Fixes: bccd9bce29e0 ("ice: Add guard rule when creating FDB in switchdev")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 1191031b2a43..ffd6c42bda1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2413,10 +2413,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 		/* Propagate some data to the recipe database */
 		recps[idx].is_root = !!is_root;
 		recps[idx].priority = root_bufs.content.act_ctrl_fwd_priority;
-		recps[idx].need_pass_l2 = root_bufs.content.act_ctrl &
-					  ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
-		recps[idx].allow_pass_l2 = root_bufs.content.act_ctrl &
-					   ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
+		recps[idx].need_pass_l2 = !!(root_bufs.content.act_ctrl &
+					     ICE_AQ_RECIPE_ACT_NEED_PASS_L2);
+		recps[idx].allow_pass_l2 = !!(root_bufs.content.act_ctrl &
+					      ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2);
 		bitmap_zero(recps[idx].res_idxs, ICE_MAX_FV_WORDS);
 		if (root_bufs.content.result_indx & ICE_AQ_RECIPE_RESULT_EN) {
 			recps[idx].chain_idx = root_bufs.content.result_indx &
-- 
2.40.1

