Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ED6E7544C
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Oct 2023 11:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9D5B41FBF;
	Tue,  3 Oct 2023 11:13:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9D5B41FBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696331620;
	bh=oS9+s/sCiv8ejSMuQSg1TxdfWuTia2CHtuvPJV8Vwg0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=M7QRzW8YhDj0unFh8Sf+R/z7Z5gQUmd2Wsvkhzkkb8kirA1R2ck3fvTEHwpI6CJug
	 mVB+gbIE80eg6xt6WodLv2+wsCOHd0Q4dN8z+ANya/XCK4AybFEUSlWGw2in1hIvoL
	 YIonb2MM3o7tVBtjs9BIzmdtyTPT4caeGRNcMNKr3wxcJL1NTk3nAuzz66YtygHrBh
	 HZk9h03VRS+Z0K3lgEkdyUZxSX3hJqGqhFzaAaMNcdL+Y0wvMYF3EgkOpn546kfGjU
	 ghlx9zt2TTft9DACUj2XCVaIDTpAzCU0S9nPWDrVO3mVcQIlV7+Iax2kmC+py9JWsQ
	 MJ/u41nOSujjw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyftwNcZ5BjX; Tue,  3 Oct 2023 11:13:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5B2C41FC3;
	Tue,  3 Oct 2023 11:13:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5B2C41FC3
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 777FF1BF3EA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 11:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FA8C8223D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 11:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FA8C8223D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lcGhQ5MWfFty for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Oct 2023 11:13:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95DF58223B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Oct 2023 11:13:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95DF58223B
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385672467"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; d="scan'208";a="385672467"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2023 04:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744465845"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; d="scan'208";a="744465845"
Received: from s240.igk.intel.com (HELO DevelopmentVM.nql.local)
 ([10.102.18.202])
 by orsmga007.jf.intel.com with ESMTP; 03 Oct 2023 04:13:33 -0700
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  3 Oct 2023 13:17:45 +0200
Message-Id: <20231003111745.77267-1-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696331615; x=1727867615;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=58GcIcQdqRW4cIKfLSUcTHM3PgY1ROknSy4YpjzF3Ak=;
 b=bYkG0MJEBKCyRialWzKLfouUiJiSx9iZ3LcO9sjprT7BN7BuHK1SyHUV
 r4x+dKwmXhhvD3cVkE/Y4Nry3OSzNU3FOWLaMM2Kt0FIRNjELXdGjbQS2
 xlLlSPk6dL7DnYygOlp8ZPArUfeYF2WMU8lfERFeeRSNs0E6kpjzTen46
 hYvXNLRRDBUAoXieRTQYYw7giS7Oe7hkRRLwYsFzDVifAanWCgtqGd/pn
 WCk5b7z6FvB5zZj0HDf+7iYNF5ZAfkndQDOyrjz3bUyOm4PkIHTfrAZXh
 wdJgaXyQq7ZS2ykHTj4XEqICajo6MS8e9fGAi3uzhrY65g6a6+tDx+ANe
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bYkG0MJE
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: Fix safe mode when DDP is
 missing
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
Cc: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 Jan Sokolowski <jan.sokolowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

One thing is broken in the safe mode, that is
ice_deinit_features() is being executed even
that ice_init_features() was not causing stack
trace during pci_unregister_driver().

Add check on the top of the function.

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8286adae946..ded0d807c5c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4683,6 +4683,9 @@ static void ice_init_features(struct ice_pf *pf)
 
 static void ice_deinit_features(struct ice_pf *pf)
 {
+	if (ice_is_safe_mode(pf))
+		return;
+
 	ice_deinit_lag(pf);
 	if (test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags))
 		ice_cfg_lldp_mib_change(&pf->hw, false);
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
