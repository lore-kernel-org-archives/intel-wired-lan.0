Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEE606A324
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Xnm0MyCl;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVeQ4bk2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A010660896;
	Thu, 19 Nov 2026 15:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIa55CLuc8a7; Thu, 19 Nov 2026 15:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 054E760ADF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101889;
	b=QYb1lf3/3A1FBWwfhq0/E7Ufu6WM/1gUOsv07hkQEENbKRdAbgvz0J6OFiGOrL5G5W0R
	 GoIx0s4mqQfC+SZVokFg+sZRdv3l9pww34GrzHU9j26Mt1CbBdu652yFhRmoJ7/+N8h96
	 QHY29aSm1032YYi0+PVS3ZG0QqIbZOGDm4UUGi4NaGFM/JK1icRMB2agV9lKOM3uS1+8K
	 r2twOgP1TliqMiie/uXeakC6Y2tvbxA41Otleu9lbVJW70UZ757yKZkiryTxn+JUFPVTJ
	 R/Yb3uCdZieA+7m9bOiJip1UleQKCqPlp5rbzg/trFy/RCIcVGQ8Oa/RILDBK/3uo4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101889;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mA4k7vQIZdRzTiwS3tJ8NsE7M3F5X0Ml2StfmTR1854=;
	b=h0dQfc2WUHhuleUK0ofTdaHS/aAtyNWLFwp9FCaieh0ubyH7ECvHhs+iFdNh89VOZuni
	 SJ6aWd84vKivebGAB/+yN2DAXXO7jNfnzGRD6TB8Y8sPJueEtwrgbJuyRe+xD1BFURTRr
	 QahYI8/oflbAReI5MEpyNFVlpdTtfTG+pYnKQygymSF24CJ+X67uKIpuRyLKMFSaH+k0s
	 PsfBPgtJDXJh+EiJgJZs0X30YG94IZNlAVUqt3guaz594NqQw8kLbwsEt8dA0jVwmb7/w
	 PC91iGsVAOrbvzTYlSis822DPw9t+z7W8LinYb9de1fgAIVX6t0JHg1jMZwGZX7qAVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVeQ4bk2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795101889;
	bh=mA4k7vQIZdRzTiwS3tJ8NsE7M3F5X0Ml2StfmTR1854=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xnm0MyClOfLldckaS6vW3RkkI7SmggOagQECYLeacPHtOtdR770q4+3aYWW1FdNS6
	 jKQWH7xRbLPO2XhyotTGrlj5PRp/xMWYigmRhdc63GrExGZnPTFNHo/s3MLeeKVH7p
	 HvYTFKMpT4CHciZDEKJ4VU9DXFMK1/TYv/gFy9m5aRONoSD53j7jiogXTaqoUokhq4
	 Z9VUBE2ZLcYEnuP08xPzhEtj8nQXoDBRzfB8h45Wy6P+3a5WobUomVYTiHiC0ag7hb
	 /oBwftcIi+KyMDwv8xtrVVWSSoE0+sLHCQJRqqAs+mMgC6KFGNV6ndKMv870Ldh6j2
	 jCNcMvfq13ltA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 054E760ADF;
	Thu, 19 Nov 2026 15:24:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F6F02FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C2A60686
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HFdQvuvbKdV7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 15:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 667A760658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RVeQ4bk2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 667A760658
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795101885; x=1826637885;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=h3sArmcpwHFEceEaD52xHBBhEBRSRA+xDYZojzZOZOI=;
 b=RVeQ4bk2DwTW/LXAYa9KTXxYD3HvAfaYMpj+talU9RIdjjv3neqTqj4F
 GSgYbyHse8HJZHKjiVIDqUkYnkJJQOYG+xnIxV1Y7j8IPbmUJBrYGJmyX
 hUWr/MNZXa+nvYJFq3sJ5OURtSeyFckJ2MRa/YcxOY7N22MvuLw5uFkMI
 axWe4XfniTZdR89gKmBUKSPGP50ttjPi5hwlw06Gc6RWxYG9F0rDyOzb/
 Njd/MXXButWOgfVhhK/C59EuoSc2x+bV1Zb2SwUDXJSIIzhmj/t73zwAQ
 FeHT9XjtkUFwjOneLf6qPWYfp7EcKRAUq8AMwRB8/7CU8K10zJxCfd6a4 g==;
X-CSE-ConnectionGUID: F6MTIVCFSd2ErvzPnYdcdA==
X-CSE-MsgGUID: 3iDqk2+hRbWQc6q1E+Xfsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3848778"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3848778"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 07:24:45 -0800
X-CSE-ConnectionGUID: dKG4bbSwTTWy6Lbifhb0nQ==
X-CSE-MsgGUID: DXtdTinhQwie6q57MWTWyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10358795"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Nov 2026 07:24:45 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v3 4/4] ice: cancel FDIR program timer on VF exit
Date: Thu, 19 Nov 2026 16:24:38 +0100
Message-ID: <20261119152438.3577165-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
 <c858f6d0-2adb-4bd6-9889-19e14b0e30eb@intel.com>
 <20261119152438.3577165-1-aleksandr.loktionov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_vc_fdir_set_irq_ctx() arms a 10 ms rx_tmr to wait for the FDIR
programming result, but ice_vf_fdir_exit() never cancels it.

If the VF is freed (SR-IOV disabled) before the timer fires, the
callback dereferences vf->fdir and vf->pf through the kfree_rcu()d
vf. The callback even proceeds, because ice_vf_fdir_exit() does not
clear the ctx flags, and writes ctx_done from freed memory.

On a VF reset the stale timer survives ice_vf_fdir_init(), which
clears the ctx flags without deleting the timer. The next FDIR
request then passes the ICE_VF_FDIR_CTX_VALID check and re-runs
timer_setup() on the still pending timer, corrupting the timer
wheel.

Initialize the timer in ice_vf_fdir_init() and only re-arm it in
ice_vc_fdir_set_irq_ctx(). ice_vf_fdir_exit() then cancels it with
timer_delete_sync() and clears the ctx_irq flag, and never touches a
timer that was never set up: a never-initialized timer_list confuses
lockdep and the debug objects on every reset of a VF that never used
FDIR.

v2 -> v3:
 - new patch: cancel the pending FDIR program timer in
   ice_vf_fdir_exit() so it cannot fire on a freed or re-inited VF
 - move the timer_setup() from ice_vc_fdir_set_irq_ctx() to
   ice_vf_fdir_init(), so ice_vf_fdir_exit() can sync-delete the
   timer on every exit

Fixes: d6218317e2ef ("ice: Check FDIR program status for AVF")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/virt/fdir.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index aeddb91..08e2864 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -1897,7 +1897,6 @@ ice_vc_fdir_set_irq_ctx(struct ice_vf *vf, struct virtchnl_fdir_fltr_conf *conf,
 	ctx->conf = conf;
 	ctx->v_opcode = v_opcode;
 	ctx->stat = ICE_FDIR_CTX_READY;
-	timer_setup(&ctx->rx_tmr, ice_vf_fdir_timer, 0);
 
 	mod_timer(&ctx->rx_tmr, round_jiffies(msecs_to_jiffies(10) + jiffies));
 
@@ -2414,17 +2413,26 @@ void ice_vf_fdir_init(struct ice_vf *vf)
 	INIT_LIST_HEAD(&fdir->fdir_rule_list);
 
 	spin_lock_init(&fdir->ctx_lock);
+	timer_setup(&fdir->ctx_irq.rx_tmr, ice_vf_fdir_timer, 0);
 	fdir->ctx_irq.flags = 0;
 	fdir->ctx_done.flags = 0;
 	ice_vc_fdir_reset_cnt_all(fdir);
 }
 
 /**
  * ice_vf_fdir_exit - destroy FDIR resource for VF
  * @vf: pointer to the VF info
  */
 void ice_vf_fdir_exit(struct ice_vf *vf)
 {
+	unsigned long flags;
+
+	timer_delete_sync(&vf->fdir.ctx_irq.rx_tmr);
+
+	spin_lock_irqsave(&vf->fdir.ctx_lock, flags);
+	vf->fdir.ctx_irq.flags &= ~ICE_VF_FDIR_CTX_VALID;
+	spin_unlock_irqrestore(&vf->fdir.ctx_lock, flags);
+
 	ice_vc_fdir_flush_entry(vf);
 	idr_destroy(&vf->fdir.fdir_rule_idr);
 	ice_vc_fdir_rem_prof_all(vf);
-- 
2.56.0

