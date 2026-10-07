Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F57CA5FF1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09777406D1;
	Wed,  7 Oct 2026 13:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YD9JSpoo0gb; Wed,  7 Oct 2026 13:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D1ED840689
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379024;
	b=A333e1d4ajhXRuk4Z+UYxD6Us1wbl6G5VBCjIkNUXIdtkzcIuHmJBVF5JlM9nwOzMTUL
	 0urNNrkenu0rBjZjHoDCMqTt45mIR5nFyZK9hA/8uJILThIU0jV9vFLgVs4MtcwzHFYr5
	 Uuli2C/62gu/MoNfo5iOG8+kGH1Y9W8m8+ex3ruJkqfJ5yi2xOOj1fQ6g61mn103NDDxK
	 meUXFFMGuvHUOAEsQ4n5a6SYgI+CoJ7ci39f/KlPK/XI3UcZBOVpB2n0sS3/FWeO9Gjaw
	 KxK+uO2LvY8IIIIwkDyvDGGgkxP2Ze5iNdQPXaSXmxAr4KDllHuFn4Rv7YcjEDMVPxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YgZwOj28VQnDEU6GI5rCkdAR11FCBfa1XiFAcMxRsWA=;
	b=Bzp7PPZxG7ZLUj9EzKrc4+4LK5f2HPrMd2Sc1zY1STIGFKceOIyRsIPpgaDefL5nht1S
	 0Ohf74CMQ9Dr/eI9IVU6QQbu7IGXo/EfxrpvpxYcb7brZwCloeJ1IoixAuodNeTAMhP9P
	 BRNV9Us1EdQtig3ju1YPBTaXK9DIYwyVbXyK8JV3PsKqGTHXwYh0edFcM3UQGf2uCRb3a
	 Har5rHCl6D2l/wuLAHr0tzONMmp22UD0Vps5A7pIaTFYijcLlbxO4FzitJelQycjMUPAo
	 v8LcOwC9/gPgDDk2ATCT1Lzl8FJPw1B56BHSG5drKp23hn8gYP2WlInImv05NnCu3HQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379024;
	bh=YgZwOj28VQnDEU6GI5rCkdAR11FCBfa1XiFAcMxRsWA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FO8rfAk7yCb4CBjTm55Y4/wpxu7oQN3nOU6MD/vxDHOVcDZcqCPTkj3y4NAqj9GS5
	 C/2xzyDYCL1mOK+eWx4KvWWoIU67IT7qKLbCrnqlv51K8c9qhquCimuNbjvMTITOV4
	 ULKANIUA6iKcIvDrdjMi7bTLZlx0T1pocwJS+5zBno9j3QtDanENkQFyoRJ1PQJ+NA
	 BHQ+h9NSYCbR7eD8KBrfmli5jyEqVDkRcHCGIfhkF6vxfDlCDtqwxisDiE/ZjmKnKD
	 iwUlP5LA48Igcbx+KxvXCcQ4ppnzulEVaggZgbQRHxu4/hJglQvg3/5XRgAGx3SWWE
	 3jzIWl9T5YDXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1ED840689;
	Wed,  7 Oct 2026 13:17:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 80AA3338
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71E9C80EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70VWxG8EArrX for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 45D8C80EEF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377302;
 b=mC6UpC9goIQG3kP6ZN9US2iRitdEh38Nw4jMKICiQIq/Af+aWC4E7lZrfPwR+P/UmlSL
 +BlJquN0M2iPeat2KnXw2T3o7KQElTub2F3n67IhvUsAMFYoo3WBgJ9FGNUEHXx93rZNr
 8CckoSvn9V6j3wzC5bgd49gxS5ZZetwCsnIWhAVHjzl1rF0EWlRogfq0/57FhlKNl9wRz
 QGIS0InjlXElQ8mjA7xfzS6SOQClPEJxa4UKXgh3Zm+7XPcIBkH0piI66I00WHUqc1lWY
 P7H+y86WeRppg/CGEfbwMvazM1wXshzj7dk5v8gaW9cQvEOUg06Wxzu/scchlPzejlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377302;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YgZwOj28VQnDEU6GI5rCkdAR11FCBfa1XiFAcMxRsWA=;
 b=hiP+cuNpA4vgs1fk9Y9fv9RaI+LTsIzhF6WnZhbX9ts3FYYur56CjPjoSx+54LaOkWwV
 1E0F+8IZ2fXljihvYpQyX6E9LiJxamAd72M6WIv3PkUrAF8UFjBeYFY8HJwzVj8sxAwHW
 AeEclZTGiiA62ll+oSo3pAMpmxaaCdj4nUD0ZnKXDfUMUWgfVmsk/kX+IpROYP5xMesxo
 s8tAwgXzLr04JgtKXvXMp6MRYfvJGhmDH/aDmWfV5eNJ9NbryLB4gVVxeS8zd/t5ukOvq
 2sXnb1+ieoWh75DkUAoGhAssK+u7dv1mkL4GFN8fwwcVFNU/bs9KLMWW5tynX7aqNlQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=c74Otjd2; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=c74Otjd2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45D8C80EEF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377302; x=1822913302;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FTIdxJ6DJkI3/5JTxOvk7sWGQ/zU0Sy3a4m5pBwi8YI=;
 b=c74Otjd2AqEUZa5gzO2GKdqI4NNVqApaWL9LZ9qtvbigEendgrwFFUJb
 u4F/caVXKINqJTTABLCWNMCDKVNcOVUQ1blRq0vnZL6+MxP5ECv5UKI9C
 qhjg35IicFLETILFqgCMm4icXIi21mNNEe/ox0WXjaU6Ba0kuNghDHQKH
 b+7lGEFqhi9+ZIDKHk/d34gvtQboJgUdjDtlE83qNqaSflTIf3wlx4PU2
 pfrWSnRlx9UazF0jW2p9FabZoHJW5891lFJMrcFMpbus3ooemicYWU7Iq
 jO5+es2AZnI+1Yyn6WK3krbTEV2ersyWMp3Wzr+L3NlNOL2B1QBT47+8f w==;
X-CSE-ConnectionGUID: 4+RPAHrITga/5Xleve4Oiw==
X-CSE-MsgGUID: hY8hFJHRQr6IHSdznA0DFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31576"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31576"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:22 -0700
X-CSE-ConnectionGUID: oUNegmBOTsW/UVQWtCoifg==
X-CSE-MsgGUID: mFKO0J9XScOXkp1SYG+dMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191692"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:21 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 1/7] ice: Protect the control PF pointer with RCU
 and a rwsem
Date: Wed,  7 Oct 2026 12:48:13 +0000
Message-ID: <20261007124819.1074675-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
References: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
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
index 38e97356bb40..b88c89db9387 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -41,6 +41,7 @@
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
+#include <linux/rcupdate.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tc_act/tc_mirred.h>
@@ -1142,26 +1143,44 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
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
index 06842c06c689..ece2e2ba2602 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3,6 +3,7 @@
 
 #include <linux/rculist.h>
 #include <linux/srcu.h>
+#include <linux/rcupdate.h>
 #include <linux/wait_bit.h>
 #include "ice.h"
 #include "ice_lib.h"
@@ -61,6 +62,19 @@ static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
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
@@ -209,39 +223,42 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
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
@@ -3312,14 +3329,19 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
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
@@ -3384,11 +3406,15 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
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
index c29cde331441..c84e37584fa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include "ice_common.h"
@@ -351,6 +352,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -369,6 +372,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -2028,6 +2033,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
 	}
@@ -2203,8 +2210,13 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
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
 
@@ -5334,6 +5346,9 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
  *
  * Software must clear the busy bit with a write to release the lock for other
  * functions when done.
+ *
+ * A successful call holds adapter->ctrl_pf_lock for read until
+ * ice_ptp_unlock() is called.
  */
 bool ice_ptp_lock(struct ice_hw *hw)
 {
@@ -5341,6 +5356,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	u32 hw_lock;
 	int i;
 
+	down_read(&pf->adapter->ctrl_pf_lock);
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -5358,6 +5375,9 @@ bool ice_ptp_lock(struct ice_hw *hw)
 		break;
 	}
 
+	if (hw_lock)
+		up_read(&pf->adapter->ctrl_pf_lock);
+
 	return !hw_lock;
 }
 
@@ -5372,10 +5392,13 @@ void ice_ptp_unlock(struct ice_hw *hw)
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
index 3bca4443f03a..7c667986d90c 100644
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
@@ -345,4 +354,5 @@ void ice_txclk_update_and_notify(struct ice_pf *pf)
 
 out:
 	up_read(&pf->dplls.txclk_notify_rwsem);
+	up_read(&pf->adapter->ctrl_pf_lock);
 }
-- 
2.53.0

