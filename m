Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FF1EB64DD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Jul 2023 20:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1068E61136;
	Tue, 25 Jul 2023 20:31:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1068E61136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690317097;
	bh=C/rcoUBA9knniezS5aa93mFohnfCAb8M8+c3ly1ia0o=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=9uFdSzHxopD+c7BC6GmjsOFnFw/Qs3pGPD39dJu3QEpd7vLBNFgionXlsLG72aW14
	 TuFNeuZzMY+H7hxrRvvCylNFBdqslJ9TRQdokmRR5qE7UF8wI1fslyCbLTeXkK+w4Q
	 ZJ/LHXv7bhhUHcYqK5otGc7Vyb4bRtoHQ8ldFdsC+lY+fa4ZANdlRwxcfZHdEM495I
	 8897W5jAQ0i6wf6vPyPBvaXgIl4rdK/s5g5AT1OSYRyKqUIguzuYg4WUfoShVttIv7
	 mOgPklIO6KZ6bspFABe3F9W/xCg0BiIuRxyLY1FuWki60VS5SyvzryqQoS5A9nazXp
	 LUi3ngBV76f+w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vk2r3kskRFQs; Tue, 25 Jul 2023 20:31:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCBDE6111C;
	Tue, 25 Jul 2023 20:31:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCBDE6111C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id F2F3E1BF4E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jul 2023 20:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8237610F2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jul 2023 20:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8237610F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Po8TKnNS-heg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Jul 2023 20:31:32 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CE636111C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Jul 2023 20:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CE636111C
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="365298488"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; d="scan'208";a="365298488"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2023 13:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761345711"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; d="scan'208";a="761345711"
Received: from jekeller-desk.amr.corp.intel.com (HELO
 jekeller-desk.jekeller.internal) ([10.166.241.1])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2023 13:31:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Tue, 25 Jul 2023 13:31:25 -0700
Message-ID: <20230725203125.508243-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0.1.g9857a21e0017.dirty
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690317092; x=1721853092;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=y7G2NR7HkElrmi8PzGL9WJrYrM1Gq/K0T80Hp6vbVK4=;
 b=Pj0vXRCUaxg4qTSQ5wZJMMaM+sAdOebI+uDxkZ6tmYqmg0rq3tXU74yi
 j+aVolWphowuFw3pKlU1GMkgRq/QFwny1vGLLo28mr3JqmOIAH/p1MZt6
 6qjZxbdgRxuilZaIcLgh6m56NUZ3Bpo8o0Sxl7prvnjrreEDkaunqFmuz
 aG/nys04fqPrRw3khYjJSjQ/gt2cF+ZnKjj7O0KiJHhK+DH4ixm5GgApG
 acg2DkCMMZ3zZq4pe0O8Vx2s28ntdQc+TFmNzjyOC3zAIXd06fshJIWid
 Kz9ixFNTtIh8CWF3xBlplW+H7CGm7NRqRhJlJmgkz9RWsO248Oy9tuH1V
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Pj0vXRCU
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: avoid executing commands on
 other ports when driving sync
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
Cc: siddaraju.dh@intel.com, Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The ice hardware has a synchronization mechanism used to drive the
simultaneous application of commands on both PHY ports and the source timer
in the MAC.

When issuing a sync via ice_ptp_exec_tmr_cmd(), the hardware will
simultaneously apply the commands programmed for the main timer and each
PHY port. Neither the main timer command register, nor the PHY port command
registers auto clear on command execution.

During the execution of a timer command intended for a single port on E822
devices, such as those used to configure a PHY during link up, the driver
is not correctly clearing the previous commands.

This results in unintentionally executing the last programmed command on
the main timer and other PHY ports whenever performing reconfiguration on
E822 ports after link up. This results in unintended side effects on other
timers, depending on what command was previously programmed.

To fix this, the driver must ensure that the main timer and all other PHY
ports are properly initialized to perform no action.

The enumeration for timer commands does not include an enumeration value
for doing nothing. Introduce ICE_PTP_NOP for this purpose. When writing a
timer command to hardware, leave the command bits set to zero which
indicates that no operation should be performed on that port.

Modify ice_ptp_one_port_cmd() to always initialize all ports. For all ports
other than the one being configured, write their timer command register to
ICE_PTP_NOP. This ensures that no side effect happens on the timer command.

To fix this for the PHY ports, modify ice_ptp_one_port_cmd() to always
initialize all other ports to ICE_PTP_NOP. This ensures that no side
effects happen on the other ports.

Call ice_ptp_src_cmd() with a command value if ICE_PTP_NOP in
ice_sync_phy_timer_e822() and ice_start_phy_timer_e822().

With both of these changes, the driver should no longer execute a stale
command on the main timer or another PHY port when reconfiguring one of the
PHY ports after link up.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 55 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +-
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a38614d21ea8..bb70f8a811f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -131,6 +131,8 @@ static void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	case READ_TIME:
 		cmd_val |= GLTSYN_CMD_READ_TIME;
 		break;
+	case ICE_PTP_NOP:
+		break;
 	}
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
@@ -1226,18 +1228,18 @@ ice_ptp_read_port_capture(struct ice_hw *hw, u8 port, u64 *tx_ts, u64 *rx_ts)
 }
 
 /**
- * ice_ptp_one_port_cmd - Prepare a single PHY port for a timer command
+ * ice_ptp_write_port_cmd_e822 - Prepare a single PHY port for a timer command
  * @hw: pointer to HW struct
  * @port: Port to which cmd has to be sent
  * @cmd: Command to be sent to the port
  *
  * Prepare the requested port for an upcoming timer sync command.
  *
- * Note there is no equivalent of this operation on E810, as that device
- * always handles all external PHYs internally.
+ * Do not use this function directly. If you want to configure exactly one
+ * port, use ice_ptp_one_port_cmd() instead.
  */
 static int
-ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
+ice_ptp_write_port_cmd_e822(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 {
 	u32 cmd_val, val;
 	u8 tmr_idx;
@@ -1261,6 +1263,8 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 	case ADJ_TIME_AT_TIME:
 		cmd_val |= PHY_CMD_ADJ_TIME_AT_TIME;
 		break;
+	case ICE_PTP_NOP:
+		break;
 	}
 
 	/* Tx case */
@@ -1306,6 +1310,39 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 port, enum ice_ptp_tmr_cmd cmd)
 	return 0;
 }
 
+/**
+ * ice_ptp_one_port_cmd_e822 - Prepare one port for a timer command
+ * @hw: pointer to the HW struct
+ * @configured_port: the port to configure with configured_cmd
+ * @configured_cmd: timer command to prepare on the configured_port
+ *
+ * Prepare the configured_port for the configured_cmd, and prepare all other
+ * ports for ICE_PTP_NOP. This causes the configured_port to execute the
+ * desired command while all other ports perform no operation.
+ */
+static int
+ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
+		     enum ice_ptp_tmr_cmd configured_cmd)
+{
+	u8 port;
+
+	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+		enum ice_ptp_tmr_cmd cmd;
+		int err;
+
+		if (port == configured_port)
+			cmd = configured_cmd;
+		else
+			cmd = ICE_PTP_NOP;
+
+		err = ice_ptp_write_port_cmd_e822(hw, port, cmd);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_ptp_port_cmd_e822 - Prepare all ports for a timer command
  * @hw: pointer to the HW struct
@@ -1322,7 +1359,7 @@ ice_ptp_port_cmd_e822(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
 		int err;
 
-		err = ice_ptp_one_port_cmd(hw, port, cmd);
+		err = ice_ptp_write_port_cmd_e822(hw, port, cmd);
 		if (err)
 			return err;
 	}
@@ -2252,6 +2289,9 @@ static int ice_sync_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		goto err_unlock;
 
+	/* Do not perform any action on the main timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	/* Issue the sync to activate the time adjustment */
 	ice_ptp_exec_tmr_cmd(hw);
 
@@ -2372,6 +2412,9 @@ int ice_start_phy_timer_e822(struct ice_hw *hw, u8 port)
 	if (err)
 		return err;
 
+	/* Do not perform any action on the main timer */
+	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
+
 	ice_ptp_exec_tmr_cmd(hw);
 
 	err = ice_read_phy_reg_e822(hw, port, P_REG_PS, &val);
@@ -2847,6 +2890,8 @@ static int ice_ptp_port_cmd_e810(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	case ADJ_TIME_AT_TIME:
 		cmd_val = GLTSYN_CMD_ADJ_INIT_TIME;
 		break;
+	case ICE_PTP_NOP:
+		return 0;
 	}
 
 	/* Read, modify, write */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3b68cb91bd81..096685237ca6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -9,7 +9,8 @@ enum ice_ptp_tmr_cmd {
 	INIT_INCVAL,
 	ADJ_TIME,
 	ADJ_TIME_AT_TIME,
-	READ_TIME
+	READ_TIME,
+	ICE_PTP_NOP,
 };
 
 enum ice_ptp_serdes {
-- 
2.41.0.1.g9857a21e0017.dirty

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
