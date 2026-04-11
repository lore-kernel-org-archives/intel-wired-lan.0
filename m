Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C577DF45A12
	for <intel-wired-lan@archiver.kernel.org>; Sat, 11 Apr 2026 00:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93BD1405A2;
	Sat, 11 Apr 2026 00:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J1RFxb0WsEBi; Sat, 11 Apr 2026 00:39:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D28344025C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775867995;
	bh=ompqMLO0FpOnjSJ67voGfooRZTz61clLZLJwY7an6Gs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pq+sRtpC9k85Q6w96mTOVBMQTfWBbhzO0VvtwJsBzgMjKzvEZRI+Bx3VLBuTHmYPs
	 8cY3CpJktOli4H5bY/yuaz/aLWNoPTJj/iCk+bt48JXCeBARcPvNWSoHNh4GHnUdLi
	 Pw0D4DnAraYY1UzSUE6e+49iD41YMbKzVgdjug4+zMurQ9PUsUcpYhKVhgYYjAzg1K
	 hurFvQuu6ojxxXqHCRYUczuysJpi/BGHOabDAI14/pVoRgHE8OgtemSVEaE+WUpwXG
	 pthL9tDbMT3WIsCNxGf9LA94dQoxLcaUqc08nru60VscIC4zA4hbEUh9Yt7oVFLkdp
	 eTZ947bwt+bww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28344025C;
	Sat, 11 Apr 2026 00:39:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66EEE194
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Apr 2026 00:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44D81414BE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Apr 2026 00:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWqgO8luptE9 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 11 Apr 2026 00:39:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 939DA41753
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 939DA41753
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 939DA41753
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Apr 2026 00:39:52 +0000 (UTC)
X-CSE-ConnectionGUID: nXm5T178R1WAa2ZAXZ8iyg==
X-CSE-MsgGUID: SW+fjpEcRsq0oYsgeUnzAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="64423725"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="64423725"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 17:39:51 -0700
X-CSE-ConnectionGUID: PiUauI7oSXq01LAz3hPfzA==
X-CSE-MsgGUID: Iot3WUGkQ42RCe3vJhrIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="228392490"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
 by orviesa010.jf.intel.com with ESMTP; 10 Apr 2026 17:39:51 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jay.bhat@intel.com,
 ivan.d.barrera@intel.com, aleksandr.loktionov@intel.com,
 larysa.zaremba@intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-pci@vger.kernel.org, madhu.chittim@intel.com, decot@google.com,
 willemb@google.com, sheenamo@google.com
Date: Fri, 10 Apr 2026 17:39:58 -0700
Message-Id: <20260411003959.30959-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260411003959.30959-1-emil.s.tantilov@intel.com>
References: <20260411003959.30959-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775867992; x=1807403992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=fJ+x0FuS4kfTxKVTAiQAsAjahv+Ub5YWK+sKz1QUweY=;
 b=RVqJbQ9247ijNadt2FgiEdROBGGqofwFenttURyCIFwTRbQkUwwnRIvg
 vXsbHts7IYQahtXnhmfyikgiHiRA/6dxme2P8YlJB/GM7rRYP1gkhChzy
 FnFC38fneWTCV/QFnEcn3GKFCCVxY05EOdA374CTNb0ufqDA06uRYQT8z
 UE9JnwmN/JdnRG95/6qMCOiYk9FiNC8A8RrjGT+f39CA4ll3yey1RM2zM
 tR4tDQB477575lSsceSITFVJ9mFcZIlzTU9V0KcFxqh3MTbFL9F8at6a8
 vJ8Uru1ts/fds0bmuHybP83gOFZkXh7crhdAsqirKxOivcJEvR0WHYsKj
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RVqJbQ92
Subject: [Intel-wired-lan] [PATCH iwl-next 1/2] idpf: remove conditonal MBX
 deinit from idpf_vc_core_deinit()
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
called during reset handling, with remove being an exception. Ideally
the driver needs to communicate the changes to FW in all instances where
the MBX is not already disabled. Remove the remove_in_prog check from
idpf_vc_core_deinit() as the MBX was already disabled while handling the
reset via libie_ctlq_xn_shutdown() by the service task. This is also
needed by the following patch, introducing PCI callbacks support.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Jay Bhat <jay.bhat@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 129c8f6b0faa..fceaf3ec1cd4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3229,24 +3229,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
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
-		idpf_deinit_dflt_mbx(adapter);
-
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
 	idpf_idc_deinit_core_aux_device(adapter);
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
-
-	if (remove_in_prog)
-		idpf_deinit_dflt_mbx(adapter);
+	idpf_deinit_dflt_mbx(adapter);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 
-- 
2.37.3

