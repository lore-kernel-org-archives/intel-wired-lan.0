Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396A2C433EF
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Jul 2022 12:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5AE54157E;
	Mon,  4 Jul 2022 12:41:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5AE54157E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656938505;
	bh=xl6Mkr8KzHQkMgPnTkGZjkCyl7usCybNde8W89gFkJ4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=NxZjI/qxW0Lh6nl3eaMroSZ11FiKnlSoGcDs1z16pWcRaM561wwV2+rDfSTyp1Dlq
	 j54BqyY4teKQN6yq4V8R7OklDuLsK7nifbSUfkhdnYd95S/K/0XiqS2rXJDrMJ2JpI
	 muArzfzhCS2expAPtPDqhOb8olzMQXiQjbBTC4ExGdJodV7GbG3vbSBGapZzDa13VG
	 mdg4hD1sWd/DVFZuRnjYWmxkARUmirWp43UrUKuZeCBQuodYYvC++AR6C47+GTdmBf
	 80r1HpKp0iO9GRcErZ8V4EogQBiHH/zrp/cdqB0Ajq0XbkFF0XZzppu02cwWOTl7eW
	 ovm2uF7S2oEIA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6AqIyQGd1aNA; Mon,  4 Jul 2022 12:41:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B150E41588;
	Mon,  4 Jul 2022 12:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B150E41588
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id CAAE41BF368
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 12:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B13584157E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 12:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B13584157E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q4phdJGWCDAj for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Jul 2022 12:41:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C32C6404BE
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C32C6404BE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Jul 2022 12:41:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="271891982"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="271891982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 05:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="649586826"
Received: from amlin-018-068.igk.intel.com (HELO localhost.igk.intel.com)
 ([10.102.18.68])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2022 05:41:39 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  4 Jul 2022 14:41:22 +0200
Message-Id: <20220704124122.1339160-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656938501; x=1688474501;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VKEDSbfZfRpneei2EA3dFmZqoYWlri93oOhV3h4/yGE=;
 b=E3Muqm0YvjRS2H1zf/2ke+5xsh5cWNh39SobnNWcdqUFmKcXW1FS0Be2
 s8P5euVDpG1z/3W1NRqfuoSvL77i/2kdZaGOs4ztm+ghO0qzTGYxn5qiq
 nXGVI1JQ7wexWLXxiBW3clbg+FRO31TU4ciF9KdLWFVE4h2gDK2SDp0kr
 niwFhOr/WhiCkkobeV58RSV0LlZJB4ASxIfDQYettEimC9pImZya6iDvY
 ZF1US3tFTXFZQc1WYuxChfxVrcXy6P+HEifXRySvops3s0msn1TPKsFbC
 EPIELihzRdowEfQVTtRhK/lhsYHLUqt1bQhpF0Dz1PKyuuKam+yrk0Mvh
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E3Muqm0Y
Subject: [Intel-wired-lan] [PATCH net v1 2/2] iavf: Fix race condition
 between iavf_shutdown and iavf_remove
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
Cc: SlawomirX Laba <slawomirx.laba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: SlawomirX Laba <slawomirx.laba@intel.com>

Fix a deadlock introduced by commit
974578017fc1 ("iavf: Add waiting so the port is initialized in remove")
due to race condition between iavf_shutdown and iavf_remove, where
iavf_remove stucks forever in while loop since iavf_shutdown already
set __IAVF_REMOVE adapter state.

Fix this by checking if the __IAVF_IN_REMOVE_TASK has already been
set and return if so.

Fixes: 974578017fc1 ("iavf: Add waiting so the port is initialized in remove")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 74be5e3a09df..13e56caf0202 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4744,23 +4744,23 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
 static void iavf_remove(struct pci_dev *pdev)
 {
 	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
-	struct net_device *netdev = adapter->netdev;
 	struct iavf_fdir_fltr *fdir, *fdirtmp;
 	struct iavf_vlan_filter *vlf, *vlftmp;
-	struct iavf_adv_rss *rss, *rsstmp;
-	struct iavf_mac_filter *f, *ftmp;
 	struct iavf_cloud_filter *cf, *cftmp;
 	struct iavf_hw *hw = &adapter->hw;
+	struct iavf_adv_rss *rss, *rsstmp;
+	struct iavf_mac_filter *f, *ftmp;
+	struct net_device *netdev;
 	int err;
 
-	/* When reboot/shutdown is in progress no need to do anything
-	 * as the adapter is already REMOVE state that was set during
-	 * iavf_shutdown() callback.
-	 */
-	if (adapter->state == __IAVF_REMOVE)
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	if (test_and_set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return;
 
-	set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section);
 	/* Wait until port initialization is complete.
 	 * There are flows where register/unregister netdev may race.
 	 */
-- 
2.27.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
