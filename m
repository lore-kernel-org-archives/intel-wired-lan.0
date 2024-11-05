Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D37D3E776
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Nov 2024 21:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 196A340684;
	Tue,  5 Nov 2024 21:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lt91piN_Gegt; Tue,  5 Nov 2024 21:49:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 814CC4067B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730843364;
	bh=JD54flJrinjNRoif5w3d+Lr4biCM6FQZfIpCxJtemio=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2QkPwg2/GEBkr+PeniT1rXnFNvBuyklV6gXMJBLMS4GfJYvgi6zCFTBSaIdRb2T8
	 VOSrBq0/YngwUfHlbIFnxUmvcXLea9eVkUt5OB0UNzozAa3UcrytuYZLKwQ/pIIiQ8
	 YrwwvJxi3t7LZUvSOYXJkdSi30YebP2I5yGGFK5tQ0F+TFtfdQhC++y58pqYEoXQGQ
	 nkKsBphKFDojPNc/GTRveeGEvOCqj9MoDEsBdxKX/asB2N4nRtJvpGjDRODb44Wu71
	 Vxefzcdf1nvcMxQoQ22xru4FgynAQh+A6ToJ3tBD4NXL3DAlCEsY3FX8iziFaozUjv
	 U2iLaN51YKmGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 814CC4067B;
	Tue,  5 Nov 2024 21:49:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D0351DE2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Nov 2024 21:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BF9A40679
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Nov 2024 21:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5iVfH5WrNWp for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Nov 2024 21:49:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=tarun.k.singh@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 321CD4067B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 321CD4067B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 321CD4067B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Nov 2024 21:49:18 +0000 (UTC)
X-CSE-ConnectionGUID: RBXOTBToRzWyk26vJrCrJg==
X-CSE-MsgGUID: LdtgLux7RvCYAAMhWSoFHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30735928"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="30735928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 13:49:16 -0800
X-CSE-ConnectionGUID: rdnFo2JFTYKAgEeC/gfb+g==
X-CSE-MsgGUID: dE6mHU+ISQeE0T42JJf4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="85010425"
Received: from coyotepass-34596-p1.jf.intel.com ([10.166.80.48])
 by orviesa008.jf.intel.com with ESMTP; 05 Nov 2024 13:49:06 -0800
From: Tarun K Singh <tarun.k.singh@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Tue,  5 Nov 2024 13:48:59 -0500
Message-ID: <20241105184859.741473-5-tarun.k.singh@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241105184859.741473-1-tarun.k.singh@intel.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730843358; x=1762379358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cPWS4f0r9yWak9dT8ctCM7VCSSxRTsgXjzI+Wr46d5I=;
 b=hiucLDQJf66BCCiE1J0zlEsPUzvr85Uec5X27I7MVfnp/FXiH8WbDjwJ
 mNZ+TNyqNXKuM5sLObil7nsK9UJBqkubJofCSt6G3D9CyQ1RuRZZIf+1E
 durhMsisG0E8JkNWql5XvY93a6rkvArrsZLdIEuSdnk7mdqgfax1yYOMa
 5ZBQ0hOl0s3q5sBANOU6w5VUuSZXev0Tuo/p2PNfRv9DYoN7B4GikG7+5
 d1rLYyVNLm7Ew4P1Pn/cK38cq9XLGAIF9o2cQ1XmNiADwFI9bF6jktz09
 cGWsUwzLdiuGJui3gcNFkJcoDrYlZtFJa51sG1m1m0qmWrgui67CwnqHF
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hiucLDQJ
Subject: [Intel-wired-lan] [PATCH iwl-net v1 4/4] idpf: add lock class key
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

From: Ahmed Zaki <ahmed.zaki@intel.com>

Add lock class key changes to prevent lockdep from complaining
when PF reset the VFs.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Tarun K Singh <tarun.k.singh@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 32 +++++++++++++--------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 04bbc048c829..082026c2a7ab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -11,6 +11,10 @@ MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS(LIBETH);
 MODULE_LICENSE("GPL");
 
+/* Prevent lockdep from complaining when PF reset the VFs */
+static struct lock_class_key idpf_pf_vport_init_lock_key;
+static struct lock_class_key idpf_pf_work_lock_key;
+
 /**
  * idpf_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -140,9 +144,25 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_tx_splitq = true;
 	adapter->req_rx_splitq = true;
 
+	mutex_init(&adapter->vport_init_lock);
+	mutex_init(&adapter->vport_cfg_lock);
+	mutex_init(&adapter->vector_lock);
+	mutex_init(&adapter->queue_lock);
+	mutex_init(&adapter->vc_buf_lock);
+
+	INIT_DELAYED_WORK(&adapter->init_task, idpf_init_task);
+	INIT_DELAYED_WORK(&adapter->serv_task, idpf_service_task);
+	INIT_DELAYED_WORK(&adapter->mbx_task, idpf_mbx_task);
+	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
+	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
+
 	switch (ent->device) {
 	case IDPF_DEV_ID_PF:
 		idpf_dev_ops_init(adapter);
+		lockdep_set_class(&adapter->vport_init_lock,
+				  &idpf_pf_vport_init_lock_key);
+		lockdep_init_map(&adapter->vc_event_task.work.lockdep_map,
+				 "idpf-PF-vc-work", &idpf_pf_work_lock_key, 0);
 		break;
 	case IDPF_DEV_ID_VF:
 		idpf_vf_dev_ops_init(adapter);
@@ -233,18 +253,6 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_cfg_hw;
 	}
 
-	mutex_init(&adapter->vport_init_lock);
-	mutex_init(&adapter->vport_cfg_lock);
-	mutex_init(&adapter->vector_lock);
-	mutex_init(&adapter->queue_lock);
-	mutex_init(&adapter->vc_buf_lock);
-
-	INIT_DELAYED_WORK(&adapter->init_task, idpf_init_task);
-	INIT_DELAYED_WORK(&adapter->serv_task, idpf_service_task);
-	INIT_DELAYED_WORK(&adapter->mbx_task, idpf_mbx_task);
-	INIT_DELAYED_WORK(&adapter->stats_task, idpf_statistics_task);
-	INIT_DELAYED_WORK(&adapter->vc_event_task, idpf_vc_event_task);
-
 	adapter->dev_ops.reg_ops.reset_reg_init(adapter);
 	set_bit(IDPF_HR_DRV_LOAD, adapter->flags);
 	queue_delayed_work(adapter->vc_event_wq, &adapter->vc_event_task,
-- 
2.46.0

