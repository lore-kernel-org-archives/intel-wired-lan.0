Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDFDC636F9
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Dec 2022 19:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9FB660DF0;
	Mon,  5 Dec 2022 19:53:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9FB660DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670270002;
	bh=0AGI8oV4qyJsUtUJyIRkL4T+evJiYz9wUc5NX7yF4Pw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=3+DVCrd1uk7zZO/r+9X9Qza3b3UvkbUE70gF+u4Z65x41kuGj3uNMMKUxLQJdB+7D
	 QUlHRLtZPkT6pVC+8wF8RAIX1VasbLmvSh2ybEp00Su5y0gG55//58TPLXtN10tnVv
	 0jrbjabc3RVu/lJa3w9f8Cpr+6oIVjP5LsH0hBctXJZK6ZkEVSvkqnkFFRfmySato/
	 WWkh4tmyuD1UjXGY2OCsfmaJFaLeUWJ7PMsSxyFuS1z49bXuCSR2GCxqmxjT+zNJvM
	 THBb6rUlyrqv1djrWh4HOO/gytxsr35veLzsEr0jUJ2W+BEaiV8cepRDafFLEUi892
	 1RQi/hSTPbWlw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qHQVVnkbSiik; Mon,  5 Dec 2022 19:53:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B330560E06;
	Mon,  5 Dec 2022 19:53:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B330560E06
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 4883E1BF865
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Dec 2022 19:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8EB5607E1
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Dec 2022 19:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8EB5607E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5nGwRHeAsbOd for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Dec 2022 19:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 162DE60E06
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 162DE60E06
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Dec 2022 19:53:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317592367"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; d="scan'208";a="317592367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2022 11:53:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="709379280"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; d="scan'208";a="709379280"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.7])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2022 11:53:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Mon,  5 Dec 2022 11:52:41 -0800
Message-Id: <20221205195253.2475492-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.38.1.420.g319605f8f00e
In-Reply-To: <20221205195253.2475492-1-jacob.e.keller@intel.com>
References: <20221205195253.2475492-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670269983; x=1701805983;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f0MOR3hsxwDj70cS/H9yivlkiSvn7Xwcyhfsdr1W1ok=;
 b=LhbJcFHF9v3TnjUS/XHR/1TFedqY3gIHnsBrTVsYs0VsxKXrRyPJBbGp
 BFVVL+AU1UpnELRy7YID5D8o6tc7mizSjI8sixGBRspyK2kn6/lnVU+8O
 whyZ+ZMHffHA7baDrJ1d+TBk7Wkpdu9tsnGKW5+GbSlNSWk3BMwNVH8ii
 5YYwadOEbZDmtOk3BAtCz7uMdwAx6cZJZ0nwVC92zCbau98aY26B4qnOZ
 gw1c3m83vI8lW0Mts4VImcS2sqKQydDDJvhxKQ8Kpc6ivbeDsLSJ6KoIa
 xSGI3k7Q0wp3Yg8mY5tyvbLPElaTcVeVxyXaFUimDBZvhlKEJf+xCFfNx
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LhbJcFHF
Subject: [Intel-wired-lan] [PATCH net-next v3 03/15] ice: Reset TS memory
 for all quads
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
Cc: Karol Kolacinski <karol.kolacinski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Karol Kolacinski <karol.kolacinski@intel.com>

In E822 products, the owner PF should reset memory for all quads, not
only for the one where assigned lport is.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
No changes since v2.

 drivers/net/ethernet/intel/ice/ice_ptp.c    | 29 ++--------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 38 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 ++
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9539d2d37c5b..f93fa0273252 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1059,19 +1059,6 @@ static u64 ice_base_incval(struct ice_pf *pf)
 	return incval;
 }
 
-/**
- * ice_ptp_reset_ts_memory_quad - Reset timestamp memory for one quad
- * @pf: The PF private data structure
- * @quad: The quad (0-4)
- */
-static void ice_ptp_reset_ts_memory_quad(struct ice_pf *pf, int quad)
-{
-	struct ice_hw *hw = &pf->hw;
-
-	ice_write_quad_reg_e822(hw, quad, Q_REG_TS_CTRL, Q_REG_TS_CTRL_M);
-	ice_write_quad_reg_e822(hw, quad, Q_REG_TS_CTRL, ~(u32)Q_REG_TS_CTRL_M);
-}
-
 /**
  * ice_ptp_check_tx_fifo - Check whether Tx FIFO is in an OK state
  * @port: PTP port for which Tx FIFO is checked
@@ -1124,7 +1111,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 		dev_dbg(ice_pf_to_dev(pf),
 			"Port %d Tx FIFO still not empty; resetting quad %d\n",
 			port->port_num, quad);
-		ice_ptp_reset_ts_memory_quad(pf, quad);
+		ice_ptp_reset_ts_memory_quad_e822(hw, quad);
 		port->tx_fifo_busy_cnt = FIFO_OK;
 		return 0;
 	}
@@ -1370,18 +1357,6 @@ int ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	return ice_ptp_port_phy_restart(ptp_port);
 }
 
-/**
- * ice_ptp_reset_ts_memory - Reset timestamp memory for all quads
- * @pf: The PF private data structure
- */
-static void ice_ptp_reset_ts_memory(struct ice_pf *pf)
-{
-	int quad;
-
-	quad = pf->hw.port_info->lport / ICE_PORTS_PER_QUAD;
-	ice_ptp_reset_ts_memory_quad(pf, quad);
-}
-
 /**
  * ice_ptp_tx_ena_intr - Enable or disable the Tx timestamp interrupt
  * @pf: PF private structure
@@ -1397,7 +1372,7 @@ static int ice_ptp_tx_ena_intr(struct ice_pf *pf, bool ena, u32 threshold)
 	int quad;
 	u32 val;
 
-	ice_ptp_reset_ts_memory(pf);
+	ice_ptp_reset_ts_memory(hw);
 
 	for (quad = 0; quad < ICE_MAX_QUAD; quad++) {
 		err = ice_read_quad_reg_e822(hw, quad, Q_REG_TX_MEM_GBL_CFG,
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 242c4db65171..6c149b88c235 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -655,6 +655,32 @@ ice_clear_phy_tstamp_e822(struct ice_hw *hw, u8 quad, u8 idx)
 	return 0;
 }
 
+/**
+ * ice_ptp_reset_ts_memory_quad_e822 - Clear all timestamps from the quad block
+ * @hw: pointer to the HW struct
+ * @quad: the quad to read from
+ *
+ * Clear all timestamps from the PHY quad block that is shared between the
+ * internal PHYs on the E822 devices.
+ */
+void ice_ptp_reset_ts_memory_quad_e822(struct ice_hw *hw, u8 quad)
+{
+	ice_write_quad_reg_e822(hw, quad, Q_REG_TS_CTRL, Q_REG_TS_CTRL_M);
+	ice_write_quad_reg_e822(hw, quad, Q_REG_TS_CTRL, ~(u32)Q_REG_TS_CTRL_M);
+}
+
+/**
+ * ice_ptp_reset_ts_memory_e822 - Clear all timestamps from all quad blocks
+ * @hw: pointer to the HW struct
+ */
+static void ice_ptp_reset_ts_memory_e822(struct ice_hw *hw)
+{
+	unsigned int quad;
+
+	for (quad = 0; quad < ICE_MAX_QUAD; quad++)
+		ice_ptp_reset_ts_memory_quad_e822(hw, quad);
+}
+
 /**
  * ice_read_cgu_reg_e822 - Read a CGU register
  * @hw: pointer to the HW struct
@@ -3247,6 +3273,18 @@ bool ice_is_pca9575_present(struct ice_hw *hw)
 	return !status && handle;
 }
 
+/**
+ * ice_ptp_reset_ts_memory - Reset timestamp memory for all blocks
+ * @hw: pointer to the HW struct
+ */
+void ice_ptp_reset_ts_memory(struct ice_hw *hw)
+{
+	if (ice_is_e810(hw))
+		return;
+
+	ice_ptp_reset_ts_memory_e822(hw);
+}
+
 /**
  * ice_ptp_init_phc - Initialize PTP hardware clock
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index db4f57cb9ec9..b0cd73aaac6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -133,6 +133,7 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval);
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj);
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
+void ice_ptp_reset_ts_memory(struct ice_hw *hw);
 int ice_ptp_init_phc(struct ice_hw *hw);
 
 /* E822 family functions */
@@ -141,6 +142,7 @@ int ice_write_phy_reg_e822(struct ice_hw *hw, u8 port, u16 offset, u32 val);
 int ice_read_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 *val);
 int ice_write_quad_reg_e822(struct ice_hw *hw, u8 quad, u16 offset, u32 val);
 int ice_ptp_prep_port_adj_e822(struct ice_hw *hw, u8 port, s64 time);
+void ice_ptp_reset_ts_memory_quad_e822(struct ice_hw *hw, u8 quad);
 
 /**
  * ice_e822_time_ref - Get the current TIME_REF from capabilities
-- 
2.38.1.420.g319605f8f00e

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
