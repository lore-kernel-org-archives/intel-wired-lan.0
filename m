Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EF5D730A2
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 05:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7C7340EC6;
	Fri,  3 Apr 2026 05:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKdXTTHZktg9; Fri,  3 Apr 2026 05:40:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCB6140DD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775194836;
	bh=npPSbMQTCkcp97FGA0r+KQLsidDaBONjog1NqR0SkWk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ab+P6p2NcaIRUxpuHdpZHAr6ib95BdRugipy2/dG1JOxhK4SNLB/faYFc1YtiaQ5c
	 sgiis/SDb3CzASlJU3p4AArXn5ZorBeEC5/LLKX4WTMcH1qrPYwdezvwG/+Ke5Y7cB
	 psldJ/wJVUBW3YGq0bgjqOpLlCtCkaPGwWD0yyDef86OZN4fFeGkl/NWU3YZMoxk+L
	 i72YoQZ1SnGsKPbEbZRRb4iuGoT8jBjEhscbMUEaKaDvA0iGf6yGH2TZcR0Wsb7whV
	 E/W15WynGMEa+mcFLftU7DFYCwONvCCy0RwiA4hu9CeBX1mmpwthVDskN2juMTDcCg
	 iJQ1jOzudvHBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCB6140DD9;
	Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFE8D2CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5F134008E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLNW4bFNi5ju for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B0CB040071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0CB040071
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0CB040071
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
X-CSE-ConnectionGUID: YBK9uirhSkSvlxmzqY/jIw==
X-CSE-MsgGUID: vTAJp0RFSsyS+xN7DlFFPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981740"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="75981740"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 22:40:34 -0700
X-CSE-ConnectionGUID: dJvPbdxvRq6eXaDMyo6WoQ==
X-CSE-MsgGUID: W/ZDutBATP2QJMcCCfXdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223904917"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:33 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Date: Fri,  3 Apr 2026 07:40:20 +0200
Message-ID: <20260403054029.3789616-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775194835; x=1806730835;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4SetMd8mZKvQCSRcPieNR/Q4dweJ+wEjZtdoJ2n6YU4=;
 b=n22A4tTAgqKVzAGMKF4oMoyIznUdvfIY0grrhBaR+zqucrfNtu5YzZNy
 glgUTCQLt4THJXYljb/JZdt7f6UMvYrsc2dy47hkN9Q6LuwqlR2h4ocBF
 dK4USWVYUrq91kr/AdhUa5DKdzhzD+cMK3dEQYeNVszThBIB4CG1/hajx
 zktwqvijR7tFYAY+a5tG7keK/GPOqp9krGuX6U4OWfWPl5BNfBLsMLwCE
 jtP19AY+4qRM6EihvDyphimomE7mf8824VZGPVDuYFwwHprLnXDP4cll1
 Zn3uaFpT3zuoVhqqRhXuCeDfs13WL9adpIhNf2OmAxycZ7sB+zhjB13/Z
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n22A4tTA
Subject: [Intel-wired-lan] [PATCH iwl-net 2/10] ice: update FW on all DCB
 changes
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

From: Dave Ertman <david.m.ertman@intel.com>

Currently, in SW DCB mode, if a new DCB configuration comes in that
only changes the TCBW table or the TSA table, the driver does not treat
that as enough of a change to reconfigure the FW settings.

Change the check for reconfiguration needed to include these singular
changes as significant.

Fixes: a17a5ff6812c ("ice: Refactor the LLDP MIB change event handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 0b194c8..43978d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -481,13 +481,17 @@ ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
 
 		if (memcmp(&new_cfg->etscfg.tcbwtable,
 			   &old_cfg->etscfg.tcbwtable,
-			   sizeof(new_cfg->etscfg.tcbwtable)))
+			   sizeof(new_cfg->etscfg.tcbwtable))) {
+			need_reconfig = true;
 			dev_dbg(dev, "ETS TC BW Table changed.\n");
+		}
 
 		if (memcmp(&new_cfg->etscfg.tsatable,
 			   &old_cfg->etscfg.tsatable,
-			   sizeof(new_cfg->etscfg.tsatable)))
+			   sizeof(new_cfg->etscfg.tsatable))) {
+			need_reconfig = true;
 			dev_dbg(dev, "ETS TSA Table changed.\n");
+		}
 	}
 
 	/* Check if PFC configuration has changed */
-- 
2.52.0
