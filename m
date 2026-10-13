Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB231CC6B08
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E7306075D;
	Tue, 13 Oct 2026 09:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiYHVct_7ThE; Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4A2360693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882763;
	b=I4OPaEB+NBT7FVf3yQssVjzrxSeLTpasxAd8uqdaBibs+8tZ0XEsJ5NhEyVuoIjovwCt
	 XfUJ6rqq3zZnL/B5Wfg+zeyWRfP+Gof2F8GZ+4euQ93sPrU0aUO0b30Ktgf5ZZsanqLkD
	 BJnxd/mT5ZzSy5opMSwuUeJ64QfFYhZ2MTCQHpqjuGkUm+7iFKRbxpSfDMIZUMH9xZRn7
	 Y+ynLmcuLNt6PxufA04g1i39Stj9j3BGxrts26IeKbQgdz2laSTFf9YeI+zYvJtKMHiPr
	 RiIlGNq2mkjrJpHVwN5srQ6+A0r8GoRGbjbnHUJ7Y5Ei98RbdDK2BHYnD6EURW/miwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L3sh8YR/G11lKwTUeMZ7gZhsqKQku4Hmg2aaGIwhnOQ=;
	b=k2RGtZX/lnge8ICiFKBpc0Aqnk8Mx26CMSY6S+g2QQ247h8V1cRKhyZvkzuXfvwPn8HV
	 dvb8z799xXwyg0HlX/nCWi5NTtdY5iqmflRty2/6Ey/IGR1YOguf1R/gCXsvsDfHT5xd+
	 oPu8b+XFcQLqc7chKfGMJAlhTfhbV6nuAK96HTB2PatBlE+R5jx1VbbzHpHMVZKqiYIBf
	 yDhQsxrtbvbPwRR10g7oDNM28OQ/mWxCOnrvO25WM5VDQJnksFEbb0Fa6tPjVayB4pBGA
	 nHBwtaPHCWzHzeNmZujrpm9QTqtlr+Oht+AKFkOkAbK5BpPVR4IhXUSrf3isPmIEh5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882763;
	bh=L3sh8YR/G11lKwTUeMZ7gZhsqKQku4Hmg2aaGIwhnOQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfS3DqFkPnu+mspn/dy2/OtqBV6Zig99xFkyaIOS01bwqdOB+tSym7AURj3L0cSAJ
	 wsPHLPN1KP1czRIkF+y+Ut9LaCoTa06kcNA2yqwHVGRh4y1/+Hm2nDxBN3wkZh1O7F
	 5NpqBIbCQbwo2XWYhbvQt3tqmMRQGT9Z7ycfXsykZRJ6LkWgeMOBZ931Pwh3r7tsqa
	 +BF7oM+W01jkACBtaCBNNgRZ+xpcYfnUpSvpwn6W9kEMwPNyC7Ed0Bz8hcFDgry6h5
	 qkbAQfbl/f/KsYl0uv1GELxjosF8xLN+9w7jZWU8Um4Ko10HB/Zbo9hByZZOgIU0d/
	 k/NdcpjtD05tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4A2360693;
	Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69D93235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BC7C401EC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMU7tMA3_XkD for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 13FA14005F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882760;
 b=KyVRbh0eKQPybJV4G1gnxr1EYqfiERB/cXb06DP1PPqEsksY7HSNhScwTn4uaznW4BAv
 qcoVgpazwCvaEA5RLlrNehNHKSFgGISO2q0SOM/TkehsoUD4SseUdUX5CWsFAWDizg2rp
 9LTRO55U2S/LlxrvDS/KhiLbNDdchmCCA4Z2k8ufHE/eiQfgAmuXE6ohU/bivU0XklD1v
 6RczrSXwuTM//xwaZNG4NjrMnDUVgRcxltZMJeeNusingJ+jWc1sPlc8a7KwP9u7OL1Vf
 NCS071GHUKU4GxNbJ21ffic7CrMPdxR14QMspzKFsdBLen5RQjliQ98WCG1MYProFvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882760;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=L3sh8YR/G11lKwTUeMZ7gZhsqKQku4Hmg2aaGIwhnOQ=;
 b=rkzH6kONSMvzHReizZmArBReiAZ8BlTkTfXg6FJH0ZEdi1sa9R5tfqii8PshNpqYq0Ch
 sNtS9QwWDQrDOCaD4wqYXsa9puRHYB2/XVdL+tZ+8xk++XrFDsF5n04t1UFEvuup+wmTm
 /6XSHc597YcqGBpk1iMGqq5gR9yMzkYASXW5MHkgeqV1uL2Eu/heOxxgx2yrLuqtogctq
 Svu6YoTUudq0ZO3OU+off5SibM21lsTyE26nvAUmL4y+KK2/jwg8mZfhG8koskU047xfY
 KhZ4TxpVXgvR3SpPXb/trBknX5CGahcdr6p9Fqzmy7tfKgSMWJOt3lMJjgFn2WkSVVw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e53CAR1O; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e53CAR1O
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13FA14005F
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882760; x=1823418760;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0i2Hh4AM9V3APBufUUDiB76OLPXupOUq6iMT4aEpVqQ=;
 b=e53CAR1OqiUawMsux8ql7QAQcXN+OvqPHWrR6ZcNjTJpQiOaqEcQ5OIj
 F2iLhxVKXtj2ofCpE+d/XSbSObe1H0vVdPjA3Qaxl8cZjE+QzmYLbXhzE
 gmeJyV6AjAommml1p3VmxkWPRB5tZL69l+JGfIZMow6hV+BS2gxz9CzDS
 9f4qaqhNDBGWvNv+jVpN8jz+cfg10HDtg06d1FwBxrgG/TcIZNzCtUAm9
 0jxW6Zd5w7EVuS0L5szZbahg0KQXWDtgEJ1syfncJJj+HTDLF88pDL9ee
 aFnwp6Xcbo4LxfJ6j5s4EJpW5TmDwHaUPtCzJ4Z8HxsKyWS4W1WbL4gvB Q==;
X-CSE-ConnectionGUID: AySFGzUKSSCSB69dfQ/2JQ==
X-CSE-MsgGUID: sFYI48FmQWOxtQ8hIanSaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481265"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:39 -0700
X-CSE-ConnectionGUID: LsBx3mAtS1GlQ715SJHoQQ==
X-CSE-MsgGUID: DMBJGhxvTriV4zVeLoODRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125344"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:38 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 1/7] ice: Protect the control PF pointer
 with RCU and a rwsem
Date: Tue, 13 Oct 2026 09:12:29 +0000
Message-ID: <20261013091235.1423979-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Mark adapter->ctrl_pf as __rcu and route every reader through
rcu_dereference_check(), publishing it with rcu_assign_pointer(). Readers
that can run in an RCU read-side critical section are wrapped
accordingly.

Add adapter->ctrl_pf_lock for the sleepable users which cannot sit in an
RCU read-side critical section, namely the PTP hardware semaphore in
ice_ptp_lock()/ice_ptp_unlock() and the TX reference clock paths in
ice_txclk.c. Pass the resolved control PF into ice_txclk_enable_peer()
so it is looked up once under that lock.

The pointer is still only ever published and never cleared, so there is
no functional change here. This only puts the annotations and the
locking in place for the lifetime handling that follows.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 25 +++++-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 82 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 23 ++++++
 drivers/net/ethernet/intel/ice/ice_txclk.c   | 20 +++--
 6 files changed, 119 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 99e65f7ad535..c7f3b444d16d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -40,6 +40,7 @@
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
+#include <linux/rcupdate.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tc_act/tc_mirred.h>
@@ -1149,26 +1150,44 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
  * ice_get_primary_hw - Get pointer to primary ice_hw structure
  * @pf: pointer to PF structure
  *
+ * The function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ * hw is embedded in struct ice_pf, so either mechanism protects its lifetime.
+ *
  * Return: A pointer to ice_hw structure with access to timesync
  * register space.
  */
 static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 {
-	if (!pf->adapter->ctrl_pf)
+	struct ice_pf *ctrl_pf;
+
+	ctrl_pf = rcu_dereference_check(pf->adapter->ctrl_pf,
+					lockdep_is_held(&pf->adapter->ctrl_pf_lock));
+
+	if (!ctrl_pf)
 		return &pf->hw;
 	else
-		return &pf->adapter->ctrl_pf->hw;
+		return &ctrl_pf->hw;
 }
 
 /**
  * ice_get_ctrl_pf - Get pointer to Control PF of the adapter
  * @pf: pointer to the current PF structure
  *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ *
  * Return: A pointer to ice_pf structure which is Control PF,
  * NULL if it's not initialized yet.
  */
 static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 {
-	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+	return !pf->adapter ? NULL :
+		rcu_dereference_check(pf->adapter->ctrl_pf,
+				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 }
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index fe62dd116e30..a702b13e4352 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -77,6 +77,7 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
+	init_rwsem(&adapter->ctrl_pf_lock);
 
 	mutex_init(&adapter->ps_lock);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 25cfb9f3b9a5..75a257c4fc88 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
@@ -41,6 +42,7 @@ struct ice_port_list {
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
+ * @ctrl_pf_lock: Protect control PF lifetime for sleepable users
  * @ctrl_pf: Control PF of the adapter
  * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
  * @ports: Ports list
@@ -60,7 +62,8 @@ struct ice_adapter {
 	/* For serializing PHY port start/stop sequences */
 	struct mutex ps_lock;
 
-	struct ice_pf *ctrl_pf;
+	struct rw_semaphore ctrl_pf_lock;
+	struct ice_pf __rcu *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c0c12e28e08f..58dc16b5762c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3,6 +3,7 @@
 
 #include <linux/rculist.h>
 #include <linux/srcu.h>
+#include <linux/rcupdate.h>
 #include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
@@ -58,6 +59,19 @@ static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
 	{  SDP3, {  3, -1 }, { 0, 0 }},
 };
 
+/**
+ * ice_get_ctrl_ptp - Get the PTP structure for the control PF
+ * @pf: The PF pointer to look up at
+ *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section or
+ * while holding adapter->ctrl_pf_lock.
+ *
+ * Return: Pointer to the PTP structure of the control PF, or NULL if not found
+ */
 static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
 {
 	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
@@ -206,39 +220,42 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
-	if (!ice_is_primary(hw))
-		hw = ice_get_primary_hw(pf);
-
-	tmr_idx = ice_get_ptp_src_clock_index(hw);
-	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
-	/* Read the system timestamp pre PHC read */
-	ptp_read_system_prets(sts);
-
-	if (hw->mac_type == ICE_MAC_E830) {
-		u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+	scoped_guard(rcu) {
+		if (!ice_is_primary(hw))
+			hw = ice_get_primary_hw(pf);
 
-		/* Read the system timestamp post PHC read */
-		ptp_read_system_postts(sts);
-
-		return clk_time;
-	}
+		tmr_idx = ice_get_ptp_src_clock_index(hw);
+		guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
+		/* Read the system timestamp pre PHC read */
+		ptp_read_system_prets(sts);
 
-	lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+		if (hw->mac_type == ICE_MAC_E830) {
+			u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
 
-	/* Read the system timestamp post PHC read */
-	ptp_read_system_postts(sts);
+			/* Read the system timestamp post PHC read */
+			ptp_read_system_postts(sts);
 
-	hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
-	lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			return clk_time;
+		}
 
-	if (lo2 < lo) {
-		/* if TIME_L rolled over read TIME_L again and update
-		 * system timestamps
-		 */
-		ptp_read_system_prets(sts);
 		lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		/* Read the system timestamp post PHC read */
 		ptp_read_system_postts(sts);
+
 		hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		if (lo2 < lo) {
+			/* if TIME_L rolled over read TIME_L again and update
+			 * system timestamps
+			 */
+			ptp_read_system_prets(sts);
+			lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			ptp_read_system_postts(sts);
+			hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		}
+
 	}
 
 	return ((u64)hi << 32) | lo;
@@ -3235,14 +3252,19 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
-	pf->adapter->ctrl_pf = pf;
+	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+
+	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
+	struct ice_ptp *ctrl_ptp;
 
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
+
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp) {
 		dev_info(ice_pf_to_dev(pf),
 			 "PTP unavailable: no controlling PF\n");
@@ -3307,11 +3329,15 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
  */
 int ice_ptp_clock_index(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
+	struct ice_ptp *ctrl_ptp;
 	struct ptp_clock *clock;
 
+	guard(rcu)();
+
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp)
 		return -1;
+
 	clock = ctrl_ptp->clock;
 
 	return clock ? ptp_clock_index(clock) : -1;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 6034408fde03..0c4a48b015fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include "ice_common.h"
@@ -335,6 +336,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -353,6 +356,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -2012,6 +2017,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
 	}
@@ -2187,8 +2194,13 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		/* cleanup.h advises against mixing goto with scoped helpers,
+		 * and this function unwinds the PTP semaphore with goto below.
+		 */
+		rcu_read_lock();
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+		rcu_read_unlock();
 	}
 	incval = (u64)hi << 32 | lo;
 
@@ -5318,6 +5330,9 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
  *
  * Software must clear the busy bit with a write to release the lock for other
  * functions when done.
+ *
+ * A successful call holds adapter->ctrl_pf_lock for read until
+ * ice_ptp_unlock() is called.
  */
 bool ice_ptp_lock(struct ice_hw *hw)
 {
@@ -5325,6 +5340,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	u32 hw_lock;
 	int i;
 
+	down_read(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -5342,6 +5359,9 @@ bool ice_ptp_lock(struct ice_hw *hw)
 		break;
 	}
 
+	if (hw_lock)
+		up_read(&pf->adapter->ctrl_pf_lock);
+
 	return !hw_lock;
 }
 
@@ -5356,10 +5376,13 @@ void ice_ptp_unlock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
 	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
+	up_read(&pf->adapter->ctrl_pf_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_txclk.c b/drivers/net/ethernet/intel/ice/ice_txclk.c
index 48459f971cbf..4a59ad729547 100644
--- a/drivers/net/ethernet/intel/ice/ice_txclk.c
+++ b/drivers/net/ethernet/intel/ice/ice_txclk.c
@@ -41,6 +41,7 @@ ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
 /**
  * ice_txclk_enable_peer - Enable required TX reference clock on peer PHY
  * @pf: pointer to the PF structure
+ * @ctrl_pf: control PF protected by adapter->ctrl_pf_lock
  * @clk: TX reference clock that must be enabled
  *
  * Some TX reference clocks on E825-class devices (SyncE and EREF0) must
@@ -54,13 +55,15 @@ ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
  *
  * Return: 0 on success or negative error code on failure.
  */
-static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
+static int ice_txclk_enable_peer(struct ice_pf *pf, struct ice_pf *ctrl_pf,
+				 enum ice_e825c_ref_clk clk)
 {
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	bool peer_clk_in_use;
 	u8 port_num, phy;
 	int err;
 
+	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+
 	if (clk == ICE_REF_CLK_ENET)
 		return 0;
 
@@ -118,12 +121,15 @@ static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
  */
 int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 {
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	struct ice_port_info *port_info;
+	struct ice_pf *ctrl_pf;
 	bool clk_in_use;
 	u8 port_num, phy;
 	int err;
 
+	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
+	ctrl_pf = ice_get_ctrl_pf(pf);
+
 	if (pf->ptp.port.tx_clk == clk)
 		return 0;
 
@@ -164,7 +170,7 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 	mutex_unlock(&ctrl_pf->dplls.lock);
 
 	if (!clk_in_use) {
-		err = ice_txclk_enable_peer(pf, clk);
+		err = ice_txclk_enable_peer(pf, ctrl_pf, clk);
 		if (err)
 			return err;
 	}
@@ -215,15 +221,18 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
 void ice_txclk_update_and_notify(struct ice_pf *pf)
 {
 	struct ice_ptp_port *ptp_port = &pf->ptp.port;
-	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 	struct dpll_pin *old_pin = NULL;
 	struct dpll_pin *new_pin = NULL;
+	struct ice_pf *ctrl_pf;
 	struct ice_hw *hw = &pf->hw;
 	enum ice_e825c_ref_clk clk;
 	bool notify_dpll = false;
 	int err;
 	u8 phy;
 
+	down_read(&pf->adapter->ctrl_pf_lock);
+	ctrl_pf = ice_get_ctrl_pf(pf);
+
 	phy = ptp_port->port_num / hw->ptp.ports_per_phy;
 
 	/* Hold txclk_notify_rwsem for read across the entire critical
@@ -351,4 +360,5 @@ void ice_txclk_update_and_notify(struct ice_pf *pf)
 
 out:
 	up_read(&pf->dplls.txclk_notify_rwsem);
+	up_read(&pf->adapter->ctrl_pf_lock);
 }
-- 
2.53.0

