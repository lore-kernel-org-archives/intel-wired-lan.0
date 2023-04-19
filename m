Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CB3C6FD18
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Apr 2023 11:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EA1A61656;
	Wed, 19 Apr 2023 11:50:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EA1A61656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681905049;
	bh=TAp8YMMEGdPzTwycl8T47v2XFB0OebYjbVmiTnk6Rjg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QjkbguNTC/PwSiXJC6Vq93Vd1pkZxFpEgB7DplJtNttV1Ix6Mv++SzNExSLAPhS75
	 n7sFqnuCdwJ+J501n2o5mCY9PJ6d1Wo56Y/WG4vzqe7dsYoZLgDUEzWaSVMAWesaNj
	 mxHSOp3ONCee+rqZzOpZSYuUUJpfC3fEC5lmpUCOGDZ8vKmJQBBovMo7nnCVGdB19K
	 PT7MpZdRAFi0Su0DXTiA504HYgWhS3mk7ZFSOg6U/HsUFI52yJNflDTE3dUjHYOhGn
	 X6mglTypOkeGp3ztIn37Q4SLlGa8e5Vl3BiUClrbK+VPml52ayybM39v3KS9FPf+tC
	 nQz7TWsAp5a/w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HIX5whxzdcWz; Wed, 19 Apr 2023 11:50:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF9DB61657;
	Wed, 19 Apr 2023 11:50:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF9DB61657
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 692D41C4320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 11:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42A3F8404E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 11:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42A3F8404E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hmePSLCuuxzR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Apr 2023 11:50:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74A6B83FE8
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74A6B83FE8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Apr 2023 11:50:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325760457"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; d="scan'208";a="325760457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2023 04:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691480796"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; d="scan'208";a="691480796"
Received: from gklab-018-208.igk.intel.com ([10.102.18.208])
 by orsmga002.jf.intel.com with ESMTP; 19 Apr 2023 04:50:38 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 19 Apr 2023 13:50:04 +0200
Message-Id: <20230419115006.200409-3-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230419115006.200409-1-kamil.maziarz@intel.com>
References: <20230419115006.200409-1-kamil.maziarz@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1681905040; x=1713441040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0bRR08RGTTMuU+MX1iBrpOV4yVwd/OjbGpaLI6EG3og=;
 b=BCcvxVoif8IigNbajDrVmR0Bh/P5tNAcFLQlQMWtchQV7NzfrId9oqES
 RCIVgiIn0m08RWeb0zuaOV/9gbqeIb34Gsa72gKygtjmIR/4W6I/FsIXv
 3if+zqFEPRqPKH/IoC7H3wkPl/pKN6QqLffmgxoeSB7xZi/QYch+2cdaj
 PlyvD+0TbWVR+8EYbAsnfyqAjO3894nTtcQ/Qos4VypbZoZOZSkaZheDv
 zTzcS8gAZPPtbHS8v5BD/C5D+qwImNSh+2i91ZMuzZvwztgbtpOyrGv/t
 6yrngxgqfqFbyJjGdXr/yzhF56/c4bXg3iaVxjuHhDL3PPxP4UN7Nchmc
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BCcvxVoi
Subject: [Intel-wired-lan] [PATCH net v3 2/4] iavf: Don't lock rtnl_lock
 twice in reset
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
Cc: Dawid Wesierski <dawidx.wesierski@intel.com>,
 Kamil Maziarz <kamil.maziarz@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Some ndo/ethtool callbacks are called under rtnl_lock. If such callback
then triggers a reset, the reset task might try to take the rtnl_lock
again, causing a deadlock.

Callbacks that are sensitive to rtnl_lock are scheduled when the drivers
are unable to obtain the rtnl_lock in the reset flow. This ensures that
the reset task does not attempt to double lock rtnl_lock and avoids
the deadlock.

Before this patch, a deadlock could be caused by e.g.:

echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
while :; do
ip l s $VF1 up
ethtool --set-channels $VF1 combined 8
ip l s $VF1 down
ip l s $VF1 up
ethtool --set-channels $VF1 combined 16
ip l s $VF1 down
done

Fixes: aa626da947e9 ("iavf: Detach device during reset task")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Co-developed-by: Dawid Wesierski <dawidx.wesierski@intel.com>
Signed-off-by: Dawid Wesierski <dawidx.wesierski@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
---
v2: no changes
---
v3: Instead of the flag, we are using the rtnl_trylock in the rtnl_lock sensitive functions in the iavf_reset to avoid deadlock.
    Adding the scheduling functionality so we can update the netdev later in that case.
---
 drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 35 ++++++++++++++++++---
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 47f777674087..8f48b5354025 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -256,6 +256,7 @@ struct iavf_adapter {
 	struct workqueue_struct *wq;
 	struct work_struct reset_task;
 	struct work_struct adminq_task;
+	struct work_struct set_interrupt_capability;
 	struct delayed_work client_task;
 	wait_queue_head_t down_waitqueue;
 	wait_queue_head_t reset_waitqueue;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dcf4232ba1ca..7bcf422c0b5f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1707,11 +1707,36 @@ static int iavf_set_interrupt_capability(struct iavf_adapter *adapter)
 	err = iavf_acquire_msix_vectors(adapter, v_budget);
 
 out:
-	netif_set_real_num_rx_queues(adapter->netdev, pairs);
-	netif_set_real_num_tx_queues(adapter->netdev, pairs);
+	if (rtnl_trylock()) {
+		netif_set_real_num_rx_queues(adapter->netdev, pairs);
+		netif_set_real_num_tx_queues(adapter->netdev, pairs);
+		rtnl_unlock();
+	} else {
+		queue_work(adapter->wq, &adapter->set_interrupt_capability);
+	}
+
 	return err;
 }
 
+/**
+ * iavf_delayed_set_interrupt_capability - schedule the update of the netdev
+ * @work: pointer to work_struct containing our data
+ **/
+static void iavf_delayed_set_interrupt_capability(struct work_struct *work)
+{
+	struct iavf_adapter *adapter = container_of(work, struct iavf_adapter,
+                                                   set_interrupt_capability);
+	int pairs = adapter->num_active_queues;
+
+	if(rtnl_trylock()) {
+		netif_set_real_num_rx_queues(adapter->netdev, pairs);
+		netif_set_real_num_tx_queues(adapter->netdev, pairs);
+		rtnl_unlock();
+	} else {
+		queue_work(adapter->wq, &adapter->set_interrupt_capability);
+	}
+}
+
 /**
  * iavf_config_rss_aq - Configure RSS keys and lut by using AQ commands
  * @adapter: board private structure
@@ -1930,10 +1955,8 @@ int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 			"Unable to allocate memory for queues\n");
 		goto err_alloc_queues;
 	}
-
-	rtnl_lock();
 	err = iavf_set_interrupt_capability(adapter);
-	rtnl_unlock();
+
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to setup interrupt capabilities\n");
@@ -4983,6 +5006,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&adapter->reset_task, iavf_reset_task);
 	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
+	INIT_WORK(&adapter->set_interrupt_capability, iavf_delayed_set_interrupt_capability);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
 	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
@@ -5156,6 +5180,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->watchdog_task);
 	cancel_work_sync(&adapter->adminq_task);
+	cancel_work_sync(&adapter->set_interrupt_capability);
 	cancel_delayed_work_sync(&adapter->client_task);
 
 	adapter->aq_required = 0;
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
