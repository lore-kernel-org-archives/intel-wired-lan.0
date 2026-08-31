Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC474C624C6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FCA260669;
	Mon, 31 Aug 2026 16:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7-tZTdkOT7W; Mon, 31 Aug 2026 16:11:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788192666;
	bh=0rt0343SZLyXGntLB6mzXEntq0HAhds06Dv2PE0EjnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bkw6Vrh/jWkGFxTPFHvZLN07a+NuxxiaIMhLA3TOUb9AfaXgy7lF3A1QrlSXKAcBT
	 F3172spcFQkCW3S4WKgv5x0kSxmJpMLbdx8fKZKL3rOPFU9JttPRmjXQ2gSNhTgbgA
	 PBYzCaNMqdqLYZJPLU4YoYvhph7xUh3lhtWDISrOqgNLvtRbv3Zz5RMw3mKRomo9UC
	 NDJJqKziYCAUdRBWziaKIkMKE6eKlCzITKcAcfBMIMANx57Pmlm6OHPxIqZPTzuOWe
	 B57mxGdb3ZmL+5RGFZSB6WazX6KNOOd9oxQcIj2GL3xqfunBeje8SWaD0QILiDwsWW
	 0Br+t1phHdFMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F236065A;
	Mon, 31 Aug 2026 16:11:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02B8C23E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A991F806BA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3QZDhL_YPsfv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 16:11:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fc9b4I7z
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3718807AD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788192665; x=1819728665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IwD6K4kyRlobXqoQ3K9YRRFrKFYFz7RBmaw8RRy0dR0=;
 b=fc9b4I7zphv9EG6BOFkNn59b2GAy+zv+IyhEmosgV1mgt6oTmo/MuYCf
 ErMGXwcVIXom91w4IDoZSKib6v6Xnk8KFOqVDk36WAtXUEBY6BJWkpPDX
 BrILCI70qMLhmzLGF0Ev/qqqAcbyG1C1r76c4b+4DolIvQHuYy+rjGFTV
 d7nfQ3Of+kS0OTGVy5DYkYBhLTo1T/tnPoE0pKicF5PuMR150/1Yk0auO
 mqX5Nnvo7gKt8/lsCmhQMuV0kRbba6NrZzkkaEDhl4OEnN7Gh8vqZPlmZ
 UEtJLXHrJ6uyRLGoh29mBlopz6A49kr0Bhlz0Id6AYpfgfNjTMye+u2nc Q==;
X-CSE-ConnectionGUID: uQpr1LCNRrCGBY3EdZpCkQ==
X-CSE-MsgGUID: 0r7we6j4QyG513A73fCCTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88729033"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88729033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 09:11:04 -0700
X-CSE-ConnectionGUID: oAH6JQQJRpKKJj3svqALWQ==
X-CSE-MsgGUID: zR9iogMoQxC1Rcb3gjUSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="262706482"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2026 09:11:03 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 2/3] ice: Zero out the PTP control PF pointer at
 ice_adapter cleanup
Date: Mon, 31 Aug 2026 16:10:59 +0000
Message-ID: <20260831161100.216773-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
References: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
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

Zero out the ctrl_pf pointer in ice_adapter when the control PF is removed.
This prevents potential dangling pointer dereference when accessing
PTP-related structures from other PFs of the same adapter.

Fixes: e800654e85b5b ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reported-by: Frederick Lawler <fred@cloudflare.com>
Closes: https://lkml.indiana.edu/2507.3/01388.html
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ec2fd89c18a8..48296a4a8abd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3085,9 +3085,25 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
 	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
+static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
+{
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+	 * is being removed to prevent any secondary PFs from accessing
+	 * it after it is deleted.
+	 */
+	if (cmpxchg(&pf->adapter->ctrl_pf,
+		    (struct ice_pf __rcu *)pf, NULL) ==
+			(struct ice_pf __rcu *)pf)
+		synchronize_rcu();
+}
+
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
@@ -3397,7 +3413,9 @@ void ice_ptp_init(struct ice_pf *pf)
 err_clean_pf:
 	mutex_destroy(&ptp->port.ps_lock);
 	ice_ptp_cleanup_pf(pf);
+
 err_exit:
+	ice_ptp_cleanup_adapter(pf);
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3425,6 +3443,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	if (pf->ptp.state != ICE_PTP_READY) {
 		mutex_destroy(&pf->ptp.port.ps_lock);
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_cleanup_adapter(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
@@ -3439,6 +3458,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0

