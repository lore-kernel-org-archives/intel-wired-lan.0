Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA1CC43458
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jun 2026 23:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9642483626;
	Tue, 30 Jun 2026 23:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLPJCQyoOdLv; Tue, 30 Jun 2026 23:18:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 130E483639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782861532;
	bh=Q3oKrcYfK4EcJwy6+qlhjhL07P4Gym4g5kSWUwkUKGE=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5qplNAU616iVTqHBEGjQsNu30pKB07nBwRvowtcFpTiz0N9bDMaCs3B4L89XXjTjt
	 Z3h0WElCGvzJkVB9PMm/mm3z3a+RIB3D+KZKw0vOBPJR4admoAud/UCrLLJO9Jgvnb
	 1bvQMxNibbY2paRP8Px/xCQjZ2z5rXlaHeZCWoh0YinJO9q0n7x3fX8QxPAZKT55MB
	 6wSqEDN06YmiEFEzOJ3gJVjyM9KCZjg5O41rw/xaKTCKCKMQ63SvfDBZpDhl9KU3Vm
	 Od3Qi8oytMIsxSHTJ7YC7O7n1ZwxDd3vPm6DmZFSPwECAHJ9NaMp793tcYiRbMD7pD
	 uzk4bv5h7fInQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 130E483639;
	Tue, 30 Jun 2026 23:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 430621344
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 23:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2645960DC5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 23:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F8mkzNMgCxxG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jun 2026 23:18:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 681DA60DC4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 681DA60DC4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 681DA60DC4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jun 2026 23:18:49 +0000 (UTC)
X-CSE-ConnectionGUID: k8VBRjGeRPC1S3xW/4Q2Cg==
X-CSE-MsgGUID: OeVa4xUcQc2xOia1h6WYWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="86135265"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="86135265"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 16:18:47 -0700
X-CSE-ConnectionGUID: yyQUHXcDRtC0JuuZzxCzRA==
X-CSE-MsgGUID: FaFF0FSRQvaiSIvRKwd3zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="251972107"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
 by orviesa008.jf.intel.com with ESMTP; 30 Jun 2026 16:18:48 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jay.bhat@intel.com,
 ivan.d.barrera@intel.com, aleksandr.loktionov@intel.com,
 larysa.zaremba@intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-pci@vger.kernel.org, madhu.chittim@intel.com, decot@google.com,
 willemb@google.com, sheenamo@google.com, lukas@wunner.de
Date: Tue, 30 Jun 2026 16:18:53 -0700
Message-Id: <20260630231854.11536-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260630231854.11536-1-emil.s.tantilov@intel.com>
References: <20260630231854.11536-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782861529; x=1814397529;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=H++89qxpLaHmACQBNFHOWU+EDWqINXpJ1HRaaNeroTY=;
 b=KGFn1Y5o+rAtKQha/WxZUQ7HwA0KHcb27sEluvvr8grnJ14UZAdCmfX4
 bld0xu5X/dkDupQzU7yleApqgpSof7QMb9NeSE7FZw1rqoxWqKxAjKDkz
 OMrg6FTqUIxQcwFvbBeFkQkJTEt8XIvfUGAzYKdta4Ppw7YMo4mD7POjT
 X67Nqygu/gnpii+TDrJDoN8m3pI8pLFWi60Du+mVz5P8Yev37svzr1xSG
 xCanqUdSvyjl7bRCHpaAmi78H/NuE9xzaBc3p7jI3WqhY+5J4RMa74HDl
 C0G5QpQb8o7sa1/NXAkxbDSxnZHBujjOBSmiYbT4qgliYx9Hc3V31DLW+
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KGFn1Y5o
Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/2] idpf: remove conditional
 MBX deinit from idpf_vc_core_deinit()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Previously it was assumed that idpf_vc_core_deinit() is always being
called during reset handling, where the MBX is disabled by the reset,
with remove being the exception. Ideally the driver needs to communicate
the changes to FW in all instances where the MBX is not already disabled.
Remove the remove_in_prog check from idpf_vc_core_deinit() as the MBX was
already disabled while handling the reset via libie_ctlq_xn_shutdown()
in the service task. This is also needed by the following patch,
introducing PCI callbacks support, specifically in the case where FLR is
being triggered by a user, in which case, the driver still has the ability
to notify FW before the reset happens.

Add call to libie_ctlq_xn_shutdown() in idpf_shutdown() to avoid a possible
regression where long timeouts can happen on shutdown when FW is down.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Jay Bhat <jay.bhat@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 10 +---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 5a191644b28e..064bf3583824 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -191,6 +191,8 @@ static void idpf_shutdown(struct pci_dev *pdev)
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+	if (adapter->xnm)
+		libie_ctlq_xn_shutdown(adapter->xnm);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e0e510b1f1e1..cc5aeec3d00b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3195,24 +3195,16 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
-	bool remove_in_prog;
-
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	/* Avoid transaction timeouts when called during reset */
-	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
-		libie_ctlq_xn_shutdown(adapter->xnm);
-
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_idc_deinit_core_aux_device(adapter);
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
-	if (remove_in_prog)
-		libie_ctlq_xn_shutdown(adapter->xnm);
+	libie_ctlq_xn_shutdown(adapter->xnm);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.37.3

