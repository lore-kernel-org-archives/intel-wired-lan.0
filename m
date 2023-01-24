Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49967C54EED
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Jan 2023 22:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD7E360AB9;
	Tue, 24 Jan 2023 22:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD7E360AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674598490;
	bh=th36G7rhtJvMFMFeOb09CN2eqUr+oL5nz29G6pXWIDU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8GfLvV4ry+fa0IwH91Tztg4R0jxpAJCna3cRV9plo2yHyt3t37FDgBrhR2ClmY2gp
	 8eK6QO3Pf1F35T6d/FSEkcMgxKK4R21UueXYSHMt9lpzBzNErA3hj5RsFwPNwFAs0y
	 kK7nx8oKPTngm5uZ22JjFJ66MoklDug+7up19OGNEK5qmNDdunmbnRPLXveVFNIrJ1
	 PfZD8XEyP7kG/G34AztCUtqeSThracN3Fl2QfoX98ynERXCCIvxSLFSR7ac7xUm+Eb
	 QbkFJYULLmbLbt8oBXceKxjA1x5FfCyFiTP+HYNS+bq6XTunTvYfOVT4BVQi9hoPwl
	 zKC+CFhfqsKCA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aiySaRDAoqy9; Tue, 24 Jan 2023 22:14:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA42F60AFE;
	Tue, 24 Jan 2023 22:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA42F60AFE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B8FF51BF5E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jan 2023 22:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C142F41833
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jan 2023 22:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C142F41833
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z_li5tFivRn6 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Jan 2023 22:14:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5B364184E
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5B364184E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Jan 2023 22:14:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="388767215"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; d="scan'208";a="388767215"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2023 14:14:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907674593"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; d="scan'208";a="907674593"
Received: from pmstillw-desk1.amr.corp.intel.com ([10.213.174.112])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2023 14:14:36 -0800
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 24 Jan 2023 14:14:27 -0800
Message-Id: <20230124221428.114-5-paul.m.stillwell.jr@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124221428.114-1-paul.m.stillwell.jr@intel.com>
References: <20230124221428.114-1-paul.m.stillwell.jr@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674598478; x=1706134478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t3eWg0S7kD8Iybfbk1m1EdeJbLVgSo/l+y1GgV1Lpf8=;
 b=cIn8UUshQZ+PNB16DpWHSGh/2bsOBhVGgHH/Ghxgdb8EPqq7otKDJ+3f
 NKS+DqMuNe4UnIjCb/GIzUNQZZLAVBQTN2oMgLtOwj72Qru2KmIdrwaS/
 7EenH0idf7blWU/idJqEUA0abr97v1uV4eDt2BV34FYj9kLoduIyjWdO2
 PDQusxD1Sfyz+CinmIrXkGkwE9mdhylekzH/tvOfeDI5mPvayU6MgNPUY
 IEzKqk4LW9fkFb4vHHRWXDEUFUvEbCfVFwV7Q07xed1JtTY9i2NxuE4BN
 p0pGcZuhbIdjd5NrJctdqCR7TTDfMmizIMIJTSR2tbRZ5MU3ph7pqRSuJ
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cIn8UUsh
Subject: [Intel-wired-lan] [PATCH net-next v8 4/5] ice: disable FW logging
 on driver unload
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The FW is running in it's own context irregardless of what the driver
is doing. In this case, if the driver previously registered for FW
log events and then the driver unloads without informing the FW to
unregister for FW log events then the FW still has a timer running to
output FW logs.

The next time the driver loads and tries to register for FW log events
then the FW returns an error, but still enables the continued
outputting of FW logs. This causes an IO error to devlink which isn't
intuitive since the logs are still being output.

Fix this by disabling FW logging when the driver is being unloaded.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 766e7d9bea6a..46d9f7383e06 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4679,6 +4679,33 @@ static void ice_unregister_netdev(struct ice_vsi *vsi)
 	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
 }
 
+/**
+ * ice_pf_fwlog_deinit - clear FW logging metadata on device exit
+ * @pf: pointer to the PF struct
+ */
+static void ice_pf_fwlog_deinit(struct ice_pf *pf)
+{
+	struct ice_hw *hw = &pf->hw;
+
+	/* make sure FW logging is disabled to not put the FW in a weird state
+	 * for the next driver load
+	 */
+	if (hw->fwlog_ena) {
+		int status;
+
+		hw->fwlog_cfg.options &= ~ICE_FWLOG_OPTION_ARQ_ENA;
+		status = ice_fwlog_set(hw, &hw->fwlog_cfg);
+		if (status)
+			dev_warn(ice_pf_to_dev(pf), "Unable to turn off FW logging, status: %d\n",
+				 status);
+
+		status = ice_fwlog_unregister(hw);
+		if (status)
+			dev_warn(ice_pf_to_dev(pf), "Unable to unregister FW logging, status: %d\n",
+				 status);
+	}
+}
+
 /**
  * ice_cfg_netdev - Allocate, configure and register a netdev
  * @vsi: the VSI associated with the new netdev
@@ -5416,6 +5443,8 @@ static void ice_remove(struct pci_dev *pdev)
 		msleep(100);
 	}
 
+	ice_pf_fwlog_deinit(pf);
+
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
-- 
2.35.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
