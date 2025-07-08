Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371F1C83F14
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Jul 2025 21:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 487E881F7B;
	Tue,  8 Jul 2025 21:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWM_ZnWxBQVn; Tue,  8 Jul 2025 21:07:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 913A382101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1752008820;
	bh=/m06LfAsZpOgVkc+9fcp81Js/Ln/Cp5NjjBiZoHapQU=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bPFLyqsMkv7nqIpcJmr9Gmm3GQSx2S5a0mlARIXVGOdkH9ZjJotbGVm+qdvc6lyFP
	 240cXVlUQ3fM9lzKJFnCdDI5m9Fv2T1mZGacP5s6Eutu9AdAryhPJageobHJjtulf4
	 Z6BBKfG4s0wFIyOsS71OFmv9xZwvkGZe1bqIZID1i6l2QQ7dCXAvwWos4ghZ7VFNMf
	 QVZacZwGVMgB+LsztjJJkXdgSKxMybNHPDe+1trk53xmWRniXpG2nMmt7xuHMK/tQc
	 Di/p3sWr2bf4bPmpq3CTywfeUk9CZ8Gs5n7FCx6v+CAQiUpaHop3WNfcSg0alqWGTd
	 ILQ85DkS3qgNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 913A382101;
	Tue,  8 Jul 2025 21:07:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EAEE15F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Jul 2025 21:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F60040101
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Jul 2025 21:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3f8IJBjjx97G for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Jul 2025 21:06:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=tatyana.e.nikolova@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 835FD400F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 835FD400F6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 835FD400F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Jul 2025 21:06:56 +0000 (UTC)
X-CSE-ConnectionGUID: 1LwQFnbnQJ2sU+kXdvp+7A==
X-CSE-MsgGUID: rLsa1DjtRo6ySLIy0vgd7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54391729"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="54391729"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 14:06:56 -0700
X-CSE-ConnectionGUID: GmYyPm1GQYiBGMM8MHpALQ==
X-CSE-MsgGUID: t1mL2TScR3uoy33OPxoxAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="179276556"
Received: from pthorat-mobl.amr.corp.intel.com (HELO
 soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 14:06:55 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, kuba@kernel.org,
 Joshua Hay <joshua.a.hay@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Date: Tue,  8 Jul 2025 16:05:53 -0500
Message-ID: <20250708210554.1662-6-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250708210554.1662-1-tatyana.e.nikolova@intel.com>
References: <20250708210554.1662-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752008817; x=1783544817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qaAZ/xVj1wyhfVARXylLN3jQXgdOYL/9V0YIZu4nP9A=;
 b=bw020Kax7cxiLegkx6NhJ/RL+xtwNjubvEewiLki/g+vg0RgysH+Ax7b
 O5J0cJu8llPrqYsEIP3s/BWYvnucmbh3r5hYZ735z0nDJgUITJpl+6VvB
 lUIrE7XSAGsguu1iewosLt8xAIjuTFJJHO8uCO5KVlpOX342uLK4CcbFZ
 uEVd0iNBudllLKniqA7CwkkwJIvzW3KEzNqul2Vmfo42ADQPl8OEb6Lub
 8ou4SfC4hgufo4rEzaUTqDKr9K3mgOHIN5YUjupnlSNfFgwSx5PA18Mvr
 9tnXGrgOMmJIunMSJ7AIGcX600EQV4kBWu9hvK6rXusAvl86NN84I8Qy6
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bw020Kax
Subject: [Intel-wired-lan] [iwl-next v3 5/6] idpf: implement IDC vport aux
 driver MTU change handler
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

From: Joshua Hay <joshua.a.hay@intel.com>

The only event an RDMA vport aux driver cares about right now is an MTU
change on its underlying vport. Implement and plumb the handler to
signal the pre MTU change event and post MTU change events to the RDMA
vport aux driver.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split (v1):
- align with iidc_rdma header naming

[3]:
- add missing break statement
- remove unnecessary iadrv NULL check

 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 31 ++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 11 +++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

 drivers/net/ethernet/intel/idpf/idpf.h     |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 31 ++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 11 +++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index e74b0f3012eb..f1bb10ae34b3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -893,5 +893,7 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
 void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info);
 void idpf_idc_deinit_vport_aux_device(struct iidc_rdma_vport_dev_info *vdev_info);
 void idpf_idc_issue_reset_event(struct iidc_rdma_core_dev_info *cdev_info);
+void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
+			     enum iidc_rdma_event_type event_type);
 
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 7516c002cdf0..eff9ba204f5f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -139,6 +139,37 @@ static int idpf_idc_init_aux_vport_dev(struct idpf_vport *vport)
 	return 0;
 }
 
+/**
+ * idpf_idc_vdev_mtu_event - Function to handle IDC vport mtu change events
+ * @vdev_info: IDC vport device info pointer
+ * @event_type: type of event to pass to handler
+ */
+void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
+			     enum iidc_rdma_event_type event_type)
+{
+	struct iidc_rdma_vport_auxiliary_drv *iadrv;
+	struct iidc_rdma_event event = { };
+	struct auxiliary_device *adev;
+
+	if (!vdev_info)
+		/* RDMA is not enabled */
+		return;
+
+	set_bit(event_type, event.type);
+
+	device_lock(&vdev_info->adev->dev);
+	adev = vdev_info->adev;
+	if (!adev || !adev->dev.driver)
+		goto unlock;
+	iadrv = container_of(adev->dev.driver,
+			     struct iidc_rdma_vport_auxiliary_drv,
+			     adrv.driver);
+	if (iadrv->event_handler)
+		iadrv->event_handler(vdev_info, &event);
+unlock:
+	device_unlock(&vdev_info->adev->dev);
+}
+
 /**
  * idpf_core_adev_release - function to be mapped to aux dev's release op
  * @dev: pointer to device to free
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 53392c01e03c..c0cd05529d33 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1925,6 +1925,9 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_calc_num_q_desc(new_vport);
 		break;
 	case IDPF_SR_MTU_CHANGE:
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IIDC_RDMA_EVENT_BEFORE_MTU_CHANGE);
+		break;
 	case IDPF_SR_RSC_CHANGE:
 		break;
 	default:
@@ -1969,9 +1972,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (current_state == __IDPF_VPORT_UP)
 		err = idpf_vport_open(vport);
 
-	kfree(new_vport);
-
-	return err;
+	goto free_vport;
 
 err_reset:
 	idpf_send_add_queues_msg(vport, vport->num_txq, vport->num_complq,
@@ -1984,6 +1985,10 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 free_vport:
 	kfree(new_vport);
 
+	if (reset_cause == IDPF_SR_MTU_CHANGE)
+		idpf_idc_vdev_mtu_event(vport->vdev_info,
+					IIDC_RDMA_EVENT_AFTER_MTU_CHANGE);
+
 	return err;
 }
 
-- 
2.37.3

