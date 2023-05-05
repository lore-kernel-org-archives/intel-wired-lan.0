Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF5AC77B7D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 May 2023 09:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1D68616E4;
	Fri,  5 May 2023 09:38:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D68616E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683279508;
	bh=mUzS6UFoytQHkxsHNFTmb4xxs4we9lvkDXmFX19ISeA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=09tXBzDHgBzNYF8iRRaARVj7dnTZDMY1yW0lFdk3CfLqBbktpwzlS27q80vzBnfii
	 i7g8xy64jDmkhv4gyKC4renjLXPINiRGbVJeyVke2KixwKj/6DNBLa6xaMy2PNXrCL
	 DTmaNLw375MucxRg9tYB25SlrLwIM+8nQFjNs9XKKb7alpNignlDdbb6oFTYvwlYJ1
	 +/1JpmU8LocMrO0JtSyPbegah+2WUm84RYbwif9VKTeK/hecw9IdUdsbVYZ1+iZHCN
	 mAKn5XDrhVn6ntDYrjiFfk5rkydHYVH31a+e7sKpVcglXoFCEeJhRIg131IOCc7BYr
	 GO1rEkG2411LQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQDAvlcZXbzd; Fri,  5 May 2023 09:38:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73E2616D9;
	Fri,  5 May 2023 09:38:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C73E2616D9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4F1AE1BF393
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 May 2023 09:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF710616CB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 May 2023 09:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF710616CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdIz_fQEDyPk for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 May 2023 09:38:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2690616DC
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2690616DC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 May 2023 09:38:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="346641583"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; d="scan'208";a="346641583"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2023 02:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="821600012"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; d="scan'208";a="821600012"
Received: from gklab-018-208.igk.intel.com ([10.102.18.208])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2023 02:38:01 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri,  5 May 2023 11:37:49 +0200
Message-Id: <20230505093749.218839-5-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505093749.218839-1-kamil.maziarz@intel.com>
References: <20230505093749.218839-1-kamil.maziarz@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683279492; x=1714815492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bYfRQMqSy/AZawPNeCU+2rT2Ip+Bte74jqeeA/HUNjg=;
 b=hw2oZ1Hz3pGviiQJIXxAYSqOn1E1AlKuwd7ldOwsMibtgl9S4xAtC/yN
 4WKSqgKOc0yrjDBNbGwTcFBMXnkzSbTEpyFLP7kvDTmxoeOC/79EMf4M3
 YWTPstpPOCvolnlDDWTn7zI3UsSyWpqNxJ0IMaBpRb6H8sLTyRdD+BGT3
 yEsPl86Hez4G/ehlEDBSffe/foGDBRoiMl20VWl9yMGnRYQtcfZL3Z/zg
 nz6dwpVcxk88RxordXC0I+58SGJfThvgXleB1QQyGB0/G4RSAIGHyFlp0
 JCuBEC6b2cypayC7O73il5jjH7u12HhE4j8B6b5I8AgyxMMWE2Xb67MkW
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hw2oZ1Hz
Subject: [Intel-wired-lan] [PATCH iwl-net v5 4/4] Revert "iavf: Do not
 restart Tx queues after reset task failure"
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
Cc: Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Marcin Szycik <marcin.szycik@linux.intel.com>

This reverts commit 08f1c147b7265245d67321585c68a27e990e0c4b.

Netdev is no longer being detached during reset, so this fix can be
reverted.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
---
v1->v5: no changes
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a6c8463c1876..6c5722b107cf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2986,6 +2986,7 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	iavf_free_queues(adapter);
 	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
 	iavf_shutdown_adminq(&adapter->hw);
+	adapter->netdev->flags &= ~IFF_UP;
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 	iavf_change_state(adapter, __IAVF_DOWN);
 	wake_up(&adapter->down_waitqueue);
@@ -3080,11 +3081,6 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_disable_vf(adapter);
 		mutex_unlock(&adapter->client_lock);
 		mutex_unlock(&adapter->crit_lock);
-		if (netif_running(netdev)) {
-			rtnl_lock();
-			dev_close(netdev);
-			rtnl_unlock();
-		}
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -3235,16 +3231,6 @@ static void iavf_reset_task(struct work_struct *work)
 
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
-
-	if (netif_running(netdev)) {
-		/* Close device to ensure that Tx queues will not be started
-		 * during netif_device_attach() at the end of the reset task.
-		 */
-		rtnl_lock();
-		dev_close(netdev);
-		rtnl_unlock();
-	}
-
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 }
 
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
