Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB2BC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 058E040B46;
	Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 14lh25Yr7EWx; Fri, 25 Sep 2026 23:58:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E101440B68
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380688;
	b=oULcUM3dNZFihHOd5jZ+shdR1KMDISmbhsCRt2OFRwh1haBDByduTCtWKheYVQ9ZhJaT
	 45V5Tu7QM8ADIvr04jUdo8WTXKsM1PZ1zQROPvYcCihXoDVICyDVyKbIhvtSmiQ/VLORb
	 IC+Ea8OPzViENImBYQO/W/HPK5P/V/pywl+KNcpO2pZ8YD7EaRla2KJe4mRwVz3PFWWzi
	 69gDBeup1F5bsykPvj19G23PhlAL84hsxqLzKJYite00qBrXxkmZNi1rB8NSlOaMHf+eN
	 WCkjhly9gaPBFvM6s6lPSi01te7uoQ2Lo6giAWEdvCV5rMjCb2urM3ttL1tdxs7xJvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y5HNRIAH4OH6GD9R2cx2Siny7DaN0EG6aBCN07sktQc=;
	b=oXXeHWJ0Fd/njpHxYDpXPnBPEl9hEtGdipIsSkDwwu21dnxePFUjbhFzae6myvNr0iT3
	 QZK0tOd83ieT3e15VEskCxCxPOZmQJGzWxnFG8RrxLI6rT/cqt9Wx9h7Jb3p1ZAYU8I0Z
	 h54wQrp7ipc22QgdD7tBNqRjhgsSjmW+992CzsZfktldGche2pfgXalPRQp9dURrRMDcP
	 IXkTCgoimDO6f4An12DHWm18Q3ZCCtiGyBMuKgP1rPKKAjpcNHnR8r5stsLo5/Y0ksID2
	 7iatkHkcICxXLJVMJF5j24SyMN4t/WN1xeUNf8Myk/4NJNRg1eH1ilRogqniCQFIBvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bT6dsoUo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380687;
	bh=Y5HNRIAH4OH6GD9R2cx2Siny7DaN0EG6aBCN07sktQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9I0kWdPw458VolK6FBH8kt0eL29j0oLx8AMqY+GwtUyti14FhDx5qPrEv7lagVi9R
	 ebx7ma0BXEWzibgutFZHB6h8qtWUFAbNvhvdsCUiNpyz0xvkqIWbyyhuquihtgfd+V
	 Kh2nvNO9rNSuw7eujEazKqffBt8/BPGSxCr9FmeNeJ9pudumtz7+rAQxx3TdhVzAL+
	 sZ2J9XCy4iAofnUCpWXuuXhVzu7C6B4WB1yfHFvzJJQqHlJI/URtOXK/AfzDV5ACXw
	 iilFQki/ani5mDrYPTEFBr38JasXrLPSEVB1p0Xtoheq2jURr0Ii7LWsxQvPRt1xY4
	 AGF/f3Zfs4GoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E101440B68;
	Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47CB5355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3903240BAB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nO4PQBXkQR4w for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0978440B68
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380685;
 b=gOa5/jJPdEq9Iat8HoMgG1VHjYPCHodz48SW5CjoQEMdm0J2bM7nLX41bQS5h1SCJ7pg
 MIn2AB4pOZHaD85aEt9nUxeNnXIDWKygoxmnQ3jCraS4RylnrHS8pMdXGpSopLLzOOCvK
 x+HEFoMVjgGiPcgao5k28hQP+eIrNOAUnmThiqR/LKuAj7wjkPopujOBxWvo2s1lGWAA7
 Xqtn/HzEyVjWT4WiTk0fsvS3ZBdh0FHO0SnB0h4nA7wk+0UveTpYLXXmyninsDTqchggY
 an9bw0Gr/rFmSMTn/uEVy7lZAMCWZoSkkCeZMlCvEGKr4IQ9EAqzX9ceK8c/w3Gjpig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380685;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Y5HNRIAH4OH6GD9R2cx2Siny7DaN0EG6aBCN07sktQc=;
 b=aVNTCUBhwMKkCbDY8fbjl1u7eDfjwl2gsDUKyABDgB5zxfL0sDqRxBYjsq7xoZeaq5sM
 SAxWFTIFn35oKqFEmhn2oydzYH42+DPtVmkOMt4xp8TAPAJ3vlzFk54Ekoa5X4i/GzZZ8
 YxIAPB3s1jonu/19xwus59hIkTHswRSIWGFmsoMXQhXxcU69JBALGQ477QiyEZzJH8mcC
 +k/ukQMmEQfoFfRekGQ8+hGeiolKd4wU8XH1LpeAK5TEi5bh/YE40j+mUsxJMzBiFXIV/
 R1Vfk+7Yq7mExCqnuxk8Lktb0V5XGIt5cn6DQyjuSQvF1InvfJF+4QFeo4lBQGuf1Gg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bT6dsoUo; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bT6dsoUo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0978440B68
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380685; x=1821916685;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Y4Qf4imP3CRejqur0vrUaQIUIo7u0H035kimzOKfKac=;
 b=bT6dsoUojdFwxQ5yxjXGe47A1KYG1+0fN7MIHkJWlU19hjsZY2xf8o1/
 dynsO+MF2Fzwsk3RbRYjpt824fxWGkISP2W5h+Kke8C/7eSsp9xa7p1by
 GfU1rWYw0fdixAsBeqzQwq+uAnmct6qdOYmJlCIbGTRxm8LfK3zvi/Nje
 51lzchuY7OjPSJicKEBofvW7dPC/icd4DFLoWTb2bV/3T2wXbWeFXBROx
 c2q7C5dL8LV6y8mc8o2fms57Fm+G1H+6wfLSysCei3JKICZtzst854JpT
 9Me2lm+B1MzJsbkRLeaqjPCaP0hFbl6nSKcuqcb+UVaZ2GnBNFe4GAwan w==;
X-CSE-ConnectionGUID: VJ+4kl47QH6g2lPHMiGPtA==
X-CSE-MsgGUID: FqlyU+YgSO29foHJYIZdxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212804"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212804"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
X-CSE-ConnectionGUID: vMPtwIQ1TiS8iaT9x/oG5A==
X-CSE-MsgGUID: 3sIkbFV5Taq8QHwT3tDRCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731104"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:34 -0700
Subject: [PATCH iwl-net v3 02/15] ice: use reference counting and SRCU for
 PTP port access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-2-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=13895;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Y4Qf4imP3CRejqur0vrUaQIUIo7u0H035kimzOKfKac=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXBUxu9R0pVNl1n8OqWjmPG4jk919I/e6pL+k4KdLQ
 Rk7j6V3lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJGpcowMS9ZvdO2daNVQvWpt
 65+DUnOeG3Ie/1TC7/R37u9bSesEPRj+Geo/fLBT8kPc6bu9D378yhPSCXVcJ7rgXsDMWQ/XZk3
 bzw0A
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice adapter structure maintains a list of ports associated with the
adapter. This is used for supporting PTP, where the clock owner must handle
many operations that require access to the PTP port structures of the
associated PFs.

This is implemented using a linked list and a mutex. This sort of works,
but a few places within the code do not acquire the mutex when iterating
the list. This includes ice_ptp_flush_all_tx_tracker(),
ice_ptp_restart_all_phy(), and ice_ptp_prepare_rebuild_sec().

Fixing this is tricky, especially since it is not clear if we can simply
acquire the lock around the complete iterations.

The pattern of use for the port list is read-mostly with modifications only
happening during PF initialization when elements are inserted. This
typically only happens during early boot, though a PF could in principle be
removed or loaded at arbitrary times via bind and unbind operations.

The use of a mutex does mean the driver can sleep while holding it, but it
still creates complicates with lock ordering and prevents iterating the
list in any code path that *can't* sleep.

Instead, use SRCU primitives for the port linked list, along with a
reference count on the port. The kref reference counter ensures that a PF
will have a valid lifetime and not be removed until the reference is
released. Note that this change focuses solely on the port list and does
not make an effort to resolve access to ctrl_pf, which is currently being
investigated by another developer.

Use of sleepable RCU is required because we often iterate the PTP port list
and perform operations that might sleep. Attempts at implementing regular
RCU have thus far not proven to be acceptable.

The remove path first removes the port from the list, and we use
kref_get_unless_zero to ensure that such ports are skipped when iterating
the list. This ensures that once a port starts removing we will drop
references and no longer be able to acquire new ones. This avoids loop
iterations chaining together to indefinitely block removal.

The ice_ptp_release_port_srcu() function is used as the release function for
the kref_put() call. This uses wake_up_var() to wake the removing thread.
The waiting thread will block until the final reference has been removed,
then it will use synchronize_srcu() to ensure any outstanding SRCU critical
sections have had the necessary grace period.

This flow ensures that accesses to ports via the adapter port list will
remain valid until both the SRCU critical sections have ended and all the
references to the ports have been dropped. Strictly speaking, SRCU alone
might be sufficient for existing code paths, but the reference count allows
the option for passing a pointer to the port on to other functions if
necessary in the future.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  16 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  17 +++-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 121 ++++++++++++++++++++-------
 4 files changed, 116 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 4f695f32da3d..0b01c7f5cf0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -17,15 +17,19 @@ struct ice_pf;
 /**
  * struct ice_port_list - data used to store the list of adapter ports
  *
- * This structure contains data used to maintain a list of adapter ports
+ * This structure contains data used to maintain a list of adapter ports.
+ * Writers modifying the list *must* acquire the lock, and use SRCU safe list
+ * operations. Readers should use srcu_read_lock() on the provided domain.
  *
- * @ports: list of ports
- * @lock: protect access to the ports list
+ * @list: list of ports
+ * @lock: protect write access to the list
+ * @srcu: Sleepable RCU domain for this adapter
  */
 struct ice_port_list {
-	struct list_head ports;
-	/* To synchronize the ports list operations */
-	struct mutex lock;
+	struct list_head list;
+	/* To synchronize write operations on the port list */
+	spinlock_t lock;
+	struct srcu_struct srcu;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index c4b0da7ce20e..da2003ba3bb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -5,6 +5,8 @@
 #define _ICE_PTP_H_
 
 #include <linux/ptp_clock_kernel.h>
+#include <linux/rculist.h>
+#include <linux/kref.h>
 #include <linux/kthread.h>
 
 #include "ice_ptp_hw.h"
@@ -138,6 +140,7 @@ struct ice_ptp_tx {
  * and determine when the port's PHY offset is valid.
  *
  * @list_node: list member structure
+ * @ref: reference counter for use with adapter ports list
  * @tx: Tx timestamp tracking for this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
  * @ps_lock: mutex used to protect the overall PTP PHY start procedure
@@ -149,6 +152,7 @@ struct ice_ptp_tx {
  */
 struct ice_ptp_port {
 	struct list_head list_node;
+	struct kref ref;
 	struct ice_ptp_tx tx;
 	struct kthread_delayed_work ov_work;
 	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 2dc3629d6d0f..536923b6ae97 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
 #include "ice.h"
@@ -54,11 +55,18 @@ static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
 static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
+	int err;
 
 	adapter = kzalloc_obj(*adapter);
 	if (!adapter)
 		return NULL;
 
+	err = init_srcu_struct(&adapter->ports.srcu);
+	if (err) {
+		kfree(adapter);
+		return NULL;
+	}
+
 	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
@@ -66,18 +74,19 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 		mutex_init(&adapter->cpi_phy_lock[i]);
 	refcount_set(&adapter->refcount, 1);
 
-	mutex_init(&adapter->ports.lock);
-	INIT_LIST_HEAD(&adapter->ports.ports);
+	spin_lock_init(&adapter->ports.lock);
+	INIT_LIST_HEAD(&adapter->ports.list);
 
 	return adapter;
 }
 
 static void ice_adapter_free(struct ice_adapter *adapter)
 {
-	WARN_ON(!list_empty(&adapter->ports.ports));
+	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
-	mutex_destroy(&adapter->ports.lock);
+
+	cleanup_srcu_struct(&adapter->ports.srcu);
 
 	kfree(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fe21cee4f9de..94a66e9d8c05 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/rculist.h>
+#include <linux/srcu.h>
+#include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
@@ -673,20 +676,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	pf->ptp.tx_hwtstamp_good += tstamp_good;
 }
 
+static void ice_ptp_release_port_srcu(struct kref *ref)
+{
+	wake_up_var(ref);
+}
+
 static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
 	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	mutex_lock(&pf->adapter->ports.lock);
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
 		struct ice_ptp_tx *tx = &port->tx;
 
-		if (!tx || !tx->init)
+		if (!tx->init)
+			continue;
+
+		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
 		ice_ptp_process_tx_tstamp(tx);
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
-	mutex_unlock(&pf->adapter->ports.lock);
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -806,10 +822,19 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 static void
 ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
 	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
+	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -1424,16 +1449,22 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
  */
 static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
-	struct list_head *entry;
+	struct ice_port_list *ports = &pf->adapter->ports;
+	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
 
 		if (port->link_up)
 			ice_ptp_port_phy_restart(port);
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -2694,19 +2725,28 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
 
 static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
+	bool have_tstamps = false;
 	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	scoped_guard(mutex, &pf->adapter->ports.lock) {
-		list_for_each_entry(port, &pf->adapter->ports.ports,
-				    list_node) {
-			struct ice_ptp_tx *tx = &port->tx;
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
 
-			if (ice_port_has_timestamps(tx))
-				return true;
-		}
+		if (ice_port_has_timestamps(&port->tx))
+			have_tstamps = true;
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
+
+		if (have_tstamps)
+			break;
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 
-	return false;
+	return have_tstamps;
 }
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
@@ -2890,14 +2930,18 @@ void ice_ptp_queue_work(struct ice_pf *pf)
 static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 					enum ice_reset_req reset_type)
 {
-	struct list_head *entry;
+	struct ice_port_list *ports = &pf->adapter->ports;
+	struct ice_ptp_port *port;
+	int srcu_idx;
 
-	list_for_each(entry, &pf->adapter->ports.ports) {
-		struct ice_ptp_port *port = list_entry(entry,
-						       struct ice_ptp_port,
-						       list_node);
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
 		struct ice_pf *peer_pf = ptp_port_to_pf(port);
 
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+
 		if (!ice_is_primary(&peer_pf->hw)) {
 			if (rebuild) {
 				/* TODO: When implementing rebuild=true:
@@ -2909,7 +2953,10 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
 			}
 		}
+
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
 	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
 /**
@@ -3084,11 +3131,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
-	mutex_lock(&pf->adapter->ports.lock);
+	kref_init(&ptp->port.ref);
 
-	list_add(&ptp->port.list_node,
-		 &pf->adapter->ports.ports);
-	mutex_unlock(&pf->adapter->ports.lock);
+	spin_lock(&pf->adapter->ports.lock);
+	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
+	spin_unlock(&pf->adapter->ports.lock);
 
 	/* Seed the per-PHY Tx reference clock usage map for this port.
 	 * Only meaningful on E825 (other MAC types don't expose tx-clk
@@ -3110,13 +3157,23 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 
 static void ice_ptp_cleanup_pf(struct ice_pf *pf)
 {
+	struct ice_port_list *ports = &pf->adapter->ports;
 	struct ice_ptp *ptp = &pf->ptp;
+	struct kref *ref;
 
-	if (pf->hw.mac_type != ICE_MAC_UNKNOWN) {
-		mutex_lock(&pf->adapter->ports.lock);
-		list_del(&ptp->port.list_node);
-		mutex_unlock(&pf->adapter->ports.lock);
-	}
+	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
+		return;
+
+	spin_lock(&ports->lock);
+	list_del_rcu(&ptp->port.list_node);
+	spin_unlock(&ports->lock);
+
+	ref = &ptp->port.ref;
+	kref_put(ref, ice_ptp_release_port_srcu);
+
+	wait_var_event(ref, !kref_read(ref));
+
+	synchronize_srcu(&ports->srcu);
 }
 
 /**

-- 
2.56.0.rc0.395.gd1f3524e15dc

