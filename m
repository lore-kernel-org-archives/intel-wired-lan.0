Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A7606A888
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ysLwyxkf;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FD58bKPE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EDF58143F;
	Thu, 12 Nov 2026 12:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9c1SkGme4q4; Thu, 12 Nov 2026 12:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2005C81463
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794487583;
	b=YnkHorhowbp6I8gAL56O0y5PzCRRi0Hb1bMCC/CBZ1Msm7jQunVqg5OgPX5msS0sus5v
	 au4NMXgSIzkfds7MGTGE+XPXRdEx7H9Eyex9ptEiSOce4/Z4YhHM2LqZw2l0fhEaxVPix
	 ioC+M33/b6MipJsGJBis9VEkuRdbFkkCnDff6CGKY7ZmCcNrgHGamN2TcLWok/cUqGq40
	 VpSXPSHyeEYw8fJRNEGMHZY6DTOwuvDmxU0ICMWPlEw3hmMUH1OGCr9qIKn2uQZxdhF2/
	 m6DYGV5j9ay04ku1sRqPtdFtoLnvaAQlx3iYapkm0cnQSgTCiIgWzMRbB4qZqrflWyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794487583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BCbqHSN4ytJnUUz45iYyO0qwAFVm2tdsQvzhZVwEKeM=;
	b=hrcIT6+UVB2bv5GJvq8b8UKQ6/rL/doJ2n8rBg9OUyuxzg64tWsBfOWAiRQ2RKW/ue+F
	 wtonMAZs6IEMQGteC00L0PLmOh3L2y3xakFcvIlM/wcHYshGL4GULjnSzrpPm33sA78kr
	 iARXYjW+pwvPVhHnguNqPupllPusLVRiW9YMe1ilmzb5EUwRfe3AeEOYeOP58I1gmMT77
	 kQXiuj08ecS+f8ph9Yi5xAxp4Zwpn6Sn72jyExLixG5WQku3JwGrOVvENfXr98iwrro4q
	 OthYp67Z1sp6qyYuU7q4mn+5jU0m0s6hiDYfheTEVI5drFyEq0rJMiQlhOkkHOUQrsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794487583;
	bh=BCbqHSN4ytJnUUz45iYyO0qwAFVm2tdsQvzhZVwEKeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ysLwyxkf4s9PkOmpcp5lpAjQP/mKgLsE8dt5x/I1VI5d1IPtgJv4XlrmxlmpdyJlC
	 mYQcEdy6m4CYZecxAAw5ktVjWZp2UCx5qHqV5f1Ddg20QDe7TGBtmZO1LDS3isnCIw
	 kdQfDfkCSTW1qEch+Fp9b4OlrVAk2suY9xs78S0JqFvNw6vdQhRYLTJTV39bLK8dHM
	 shwzK3jymGWLAb5BepkBJdyY/gsRP/n6exHuoZ9xYH2NuyG+uFnpDrrE13g4zdmfrM
	 H8h0sQXysQT3dErN+7le/LRDTHkFDSt8TMaxPdZ58azqF8Yr1OIs0aHk0tmVzBOQ45
	 M3ZHJ8f9MTqXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2005C81463;
	Thu, 12 Nov 2026 12:46:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5679235
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1F5140185
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DTKGcXNYJOz0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 12:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1C8934016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FD58bKPE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C8934016D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794487581; x=1826023581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Mqlh4h/eq/hcGdCuMlDfTwLoaMEbQFwexQ/PNC87B8=;
 b=FD58bKPE52szPZ+QThiUTNvY4qyB20YbaLjIsT0STaeZC7UeBky/9Wl+
 L9RYgow1nkdPpe+Z2w4wYvgB2S0Uh14h8H1hulhBUPGX2vXPL+WwDZrM4
 ScfhwfPsDjBrNsrqj/WczVzb5lfbJWJ9JzxgECZJcWOCfGLqivNS7S8h0
 aTbdWpgDAtTWk/vx/PNqaKPknzKllgo42cgY7HEyW+XzqLQ54V57cWnKq
 8j1Zf2g2XhRnOn0n0S7Q5uVSIVcj29/WpLnZg8dKtMsU7vi0uPbtjRBaN
 pUcuuFSszFSqDYoq5hw5tlJmSiB4b+UjmOQNcvlJZ8tw5kqAUiK7Q0+UU g==;
X-CSE-ConnectionGUID: Ek/aAn+wTjezWTGjxZeXGA==
X-CSE-MsgGUID: 71cHQTAaR6Kx+8Y4ooHQXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3172834"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3172834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:46:19 -0800
X-CSE-ConnectionGUID: GLq1omp8SVO9VSPazxLATQ==
X-CSE-MsgGUID: AG66Z7SxQRy8L5tKISVr0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8833278"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
 by orviesa009.jf.intel.com with ESMTP; 12 Nov 2026 04:46:16 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, sreedevi.joshi@intel.com,
 namangulati@google.com, Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next v3 1/2] idpf: add direct access to discipline the
 main timer
Date: Thu, 12 Nov 2026 13:34:52 +0100
Message-ID: <20261112123503.234508-3-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112123503.234508-1-przemyslaw.korba@intel.com>
References: <20261112123503.234508-1-przemyslaw.korba@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IDPF allows to access the clock through virtchnl messages, or directly,
through PCI BAR registers. Registers offsets are negotiated with the
Control Plane during driver initialization process.
Add support for direct operations to modify the clock.

Co-developed-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   9 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 270 +++++++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  78 +++--
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 115 ++++++--
 5 files changed, 388 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 61f5e8e4d20b..1518555d680c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -150,8 +150,13 @@ static void idpf_trigger_reset(struct idpf_adapter *adapter,
  */
 static void idpf_ptp_reg_init(const struct idpf_adapter *adapter)
 {
-	adapter->ptp->cmd.shtime_enable_mask = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
-	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
+	adapter->ptp->cmd = (struct idpf_ptp_cmd_mask) {
+		.shtime_enable	= PF_GLTSYN_CMD_SYNC_SHTIME_EN_M,
+		.exec_cmd	= PF_GLTSYN_CMD_SYNC_EXEC_CMD_M,
+		.init_time	= PF_GLTSYN_CMD_INIT_TIME_M,
+		.init_incval	= PF_GLTSYN_CMD_INIT_INCVAL_M,
+		.adj_time	= PF_GLTSYN_CMD_ADJ_TIME_M,
+	};
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h b/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
index cc9aa2b6a14a..b2d786584dbd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
@@ -56,6 +56,9 @@
 /* Timesync registers */
 #define PF_GLTSYN_CMD_SYNC_EXEC_CMD_M	GENMASK(1, 0)
 #define PF_GLTSYN_CMD_SYNC_SHTIME_EN_M	BIT(2)
+#define PF_GLTSYN_CMD_INIT_TIME_M	BIT(0)
+#define PF_GLTSYN_CMD_INIT_INCVAL_M	BIT(1)
+#define PF_GLTSYN_CMD_ADJ_TIME_M	BIT(2)
 
 /* Interrupts */
 #define PF_GLINT_BASE			0x08900000
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 9b15973d2f7e..df2da430ff28 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -23,6 +23,40 @@ idpf_ptp_get_access(const struct idpf_adapter *adapter, u32 direct, u32 mailbox)
 		return IDPF_PTP_NONE;
 }
 
+/**
+ * idpf_ptp_check_features_access - Validate dependent PTP access modes
+ * @adapter: Driver specific private structure
+ *
+ * Some operations reuse the register set of another one, so they cannot use
+ * the direct access on their own:
+ *  - adjusting the device clock and the cross timestamping both read the
+ *    device clock registers,
+ *  - setting the device clock time additionally drives the same shadow
+ *    registers and command interface as the clock adjustment.
+ * Downgrade such an operation to the mailbox access, or disable it, when the
+ * operation it depends on does not use the direct access.
+ */
+void idpf_ptp_check_features_access(const struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	if (ptp->get_dev_clk_time_access != IDPF_PTP_DIRECT) {
+		ptp->adj_dev_clk_time_access =
+			idpf_ptp_mb_access(ptp,
+					   VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB);
+		ptp->get_cross_tstamp_access =
+			idpf_ptp_mb_access(ptp,
+					   VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB);
+	}
+
+	if (ptp->adj_dev_clk_time_access == IDPF_PTP_DIRECT)
+		return;
+
+	ptp->set_dev_clk_time_access =
+		idpf_ptp_mb_access(ptp,
+				   VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB);
+}
+
 /**
  * idpf_ptp_get_features_access - Determine the access type of PTP features
  * @adapter: Driver specific private structure
@@ -69,6 +103,8 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 	ptp->tx_tstamp_access = idpf_ptp_get_access(adapter,
 						    direct,
 						    mailbox);
+
+	idpf_ptp_check_features_access(adapter);
 }
 
 /**
@@ -80,14 +116,39 @@ static void idpf_ptp_enable_shtime(struct idpf_adapter *adapter)
 	u32 shtime_enable, exec_cmd;
 
 	/* Get offsets */
-	shtime_enable = adapter->ptp->cmd.shtime_enable_mask;
-	exec_cmd = adapter->ptp->cmd.exec_cmd_mask;
+	shtime_enable = adapter->ptp->cmd.shtime_enable;
+	exec_cmd = adapter->ptp->cmd.exec_cmd;
 
 	/* Set the shtime en and the sync field */
 	writel(shtime_enable, adapter->ptp->dev_clk_regs.cmd_sync);
 	writel(exec_cmd | shtime_enable, adapter->ptp->dev_clk_regs.cmd_sync);
 }
 
+/**
+ * idpf_ptp_tmr_cmd - Prepare and trigger a timer sync command
+ * @adapter: Driver specific private structure
+ * @cmd: Command to be executed
+ *
+ * This function must be serialized with idpf_ptp_enable_shtime() which also
+ * manipulates cmd_sync register. The read_dev_clk_lock provides this
+ * serialization.
+ */
+static void idpf_ptp_tmr_cmd(struct idpf_adapter *adapter, u32 cmd)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	/* Lock is acquired by the caller to serialize shadow register setup
+	 * with the command trigger.
+	 */
+	lockdep_assert_held(&ptp->read_dev_clk_lock);
+
+	writel(cmd, ptp->dev_clk_regs.cmd);
+	writel(cmd, ptp->dev_clk_regs.phy_cmd);
+	writel(ptp->cmd.exec_cmd, ptp->dev_clk_regs.cmd_sync);
+	writel(0, ptp->dev_clk_regs.cmd);
+	writel(0, ptp->dev_clk_regs.phy_cmd);
+}
+
 /**
  * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
  * @adapter: Driver specific private structure
@@ -139,7 +200,7 @@ static int idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,
 	/* Read the system timestamp pre PHC read */
 	ptp_read_system_prets(sts);
 
-	err = idpf_ptp_get_dev_clk_time(adapter, &clk_time);
+	err = idpf_ptp_get_dev_clk_time_mb(adapter, &clk_time);
 	if (err)
 		return err;
 
@@ -223,7 +284,7 @@ static int idpf_ptp_get_sync_device_time_mailbox(struct idpf_adapter *adapter,
 	struct idpf_ptp_dev_timers cross_time;
 	int err;
 
-	err = idpf_ptp_get_cross_time(adapter, &cross_time);
+	err = idpf_ptp_get_cross_time_mb(adapter, &cross_time);
 	if (err)
 		return err;
 
@@ -413,6 +474,35 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 	return 0;
 }
 
+/**
+ * idpf_ptp_set_dev_clk_time_direct- Set the time of the clock directly through
+ *				     BAR registers.
+ * @adapter: Driver specific private structure
+ * @dev_clk_time: Value expressed in nanoseconds to set
+ *
+ * Set the time of the device clock to provided value directly through BAR
+ * registers received during PTP capabilities negotiation.
+ */
+static void idpf_ptp_set_dev_clk_time_direct(struct idpf_adapter *adapter,
+					     u64 dev_clk_time)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	u32 dev_clk_time_l = lower_32_bits(dev_clk_time);
+	u32 dev_clk_time_h = upper_32_bits(dev_clk_time);
+
+	spin_lock(&ptp->read_dev_clk_lock);
+
+	writel(dev_clk_time_l, ptp->dev_clk_regs.dev_clk_ns_l);
+	writel(dev_clk_time_h, ptp->dev_clk_regs.dev_clk_ns_h);
+
+	writel(dev_clk_time_l, ptp->dev_clk_regs.phy_clk_ns_l);
+	writel(dev_clk_time_h, ptp->dev_clk_regs.phy_clk_ns_h);
+
+	idpf_ptp_tmr_cmd(adapter, ptp->cmd.init_time);
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+}
+
 /**
  * idpf_ptp_settime64 - Set the time of the clock
  * @info: the driver's PTP info structure
@@ -432,16 +522,23 @@ static int idpf_ptp_settime64(struct ptp_clock_info *info,
 	u64 ns;
 
 	access = adapter->ptp->set_dev_clk_time_access;
-	if (access != IDPF_PTP_MAILBOX)
-		return -EOPNOTSUPP;
-
 	ns = timespec64_to_ns(ts);
 
-	err = idpf_ptp_set_dev_clk_time(adapter, ns);
-	if (err) {
-		pci_err(adapter->pdev, "Failed to set the time, err: %pe\n",
-			ERR_PTR(err));
-		return err;
+	switch (access) {
+	case IDPF_PTP_MAILBOX:
+		err = idpf_ptp_set_dev_clk_time_mb(adapter, ns);
+		if (err) {
+			pci_err(adapter->pdev,
+				"Failed to set the time: %pe\n", ERR_PTR(err));
+			return err;
+		}
+		break;
+	case IDPF_PTP_DIRECT:
+		idpf_ptp_set_dev_clk_time_direct(adapter, ns);
+		break;
+	case IDPF_PTP_NONE:
+	default:
+		return -EOPNOTSUPP;
 	}
 
 	err = idpf_ptp_update_cached_phctime(adapter);
@@ -474,6 +571,38 @@ static int idpf_ptp_adjtime_nonatomic(struct ptp_clock_info *info, s64 delta)
 	return idpf_ptp_settime64(info, &now);
 }
 
+/**
+ * idpf_ptp_adj_dev_clk_time_direct - Adjust the time of the clock directly
+ *				      through BAR registers.
+ * @adapter: Driver specific private structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * Adjust the time of the clock directly through BAR registers received during
+ * PTP capabilities negotiation.
+ */
+static void idpf_ptp_adj_dev_clk_time_direct(struct idpf_adapter *adapter,
+					     s64 delta)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	/* The caller (idpf_ptp_adjtime) already verified delta fits in s32. */
+	u32 delta_ns = (s32)delta;
+
+	spin_lock(&ptp->read_dev_clk_lock);
+
+	/* For ADJ_TIME the SHADJ pair is a fixed point value: _L holds the
+	 * sub-nanosecond fraction, _H the 2's complement nanosecond part.
+	 */
+	writel(0, ptp->dev_clk_regs.shadj_l);
+	writel(delta_ns, ptp->dev_clk_regs.shadj_h);
+
+	writel(0, ptp->dev_clk_regs.phy_shadj_l);
+	writel(delta_ns, ptp->dev_clk_regs.phy_shadj_h);
+
+	idpf_ptp_tmr_cmd(adapter, ptp->cmd.adj_time);
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+}
+
 /**
  * idpf_ptp_adjtime - Adjust the time of the clock by the indicated delta
  * @info: the driver's PTP info structure
@@ -488,7 +617,7 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	int err;
 
 	access = adapter->ptp->adj_dev_clk_time_access;
-	if (access != IDPF_PTP_MAILBOX)
+	if (access == IDPF_PTP_NONE)
 		return -EOPNOTSUPP;
 
 	/* Hardware only supports atomic adjustments using signed 32-bit
@@ -498,11 +627,22 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	if (delta > S32_MAX || delta < S32_MIN)
 		return idpf_ptp_adjtime_nonatomic(info, delta);
 
-	err = idpf_ptp_adj_dev_clk_time(adapter, delta);
-	if (err) {
-		pci_err(adapter->pdev, "Failed to adjust the clock with delta %lld err: %pe\n",
-			delta, ERR_PTR(err));
-		return err;
+	switch (access) {
+	case IDPF_PTP_MAILBOX:
+		err = idpf_ptp_adj_dev_clk_time_mb(adapter, delta);
+		if (err) {
+			pci_err(adapter->pdev,
+				"Failed to adjust the clock with delta %lld err: %pe\n",
+				delta, ERR_PTR(err));
+			return err;
+		}
+		break;
+	case IDPF_PTP_DIRECT:
+		idpf_ptp_adj_dev_clk_time_direct(adapter, delta);
+		break;
+	case IDPF_PTP_NONE:
+	default:
+		return -EOPNOTSUPP;
 	}
 
 	err = idpf_ptp_update_cached_phctime(adapter);
@@ -513,6 +653,35 @@ static int idpf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	return 0;
 }
 
+/**
+ * idpf_ptp_adj_dev_clk_fine_direct - Adjust clock increment rate directly
+ *				      through BAR registers.
+ * @adapter: Driver specific private structure
+ * @incval: Source timer increment value per clock cycle
+ *
+ * Adjust clock increment rate directly through BAR registers received during
+ * PTP capabilities negotiation.
+ */
+static void idpf_ptp_adj_dev_clk_fine_direct(struct idpf_adapter *adapter,
+					     u64 incval)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	u32 incval_l = lower_32_bits(incval);
+	u32 incval_h = upper_32_bits(incval);
+
+	spin_lock(&ptp->read_dev_clk_lock);
+
+	writel(incval_l, ptp->dev_clk_regs.shadj_l);
+	writel(incval_h, ptp->dev_clk_regs.shadj_h);
+
+	writel(incval_l, ptp->dev_clk_regs.phy_shadj_l);
+	writel(incval_h, ptp->dev_clk_regs.phy_shadj_h);
+
+	idpf_ptp_tmr_cmd(adapter, ptp->cmd.init_incval);
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+}
+
 /**
  * idpf_ptp_adjfine - Adjust clock increment rate
  * @info: the driver's PTP info structure
@@ -531,16 +700,25 @@ static int idpf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	int err;
 
 	access = adapter->ptp->adj_dev_clk_time_access;
-	if (access != IDPF_PTP_MAILBOX)
-		return -EOPNOTSUPP;
-
 	incval = adapter->ptp->base_incval;
-
 	diff = adjust_by_scaled_ppm(incval, scaled_ppm);
-	err = idpf_ptp_adj_dev_clk_fine(adapter, diff);
-	if (err)
-		pci_err(adapter->pdev, "Failed to adjust clock increment rate for scaled ppm %ld %pe\n",
-			scaled_ppm, ERR_PTR(err));
+
+	switch (access) {
+	case IDPF_PTP_MAILBOX:
+		err = idpf_ptp_adj_dev_clk_fine_mb(adapter, diff);
+		if (err) {
+			pci_err(adapter->pdev,
+				"Failed to adjust clock increment rate\n");
+			return err;
+		}
+		break;
+	case IDPF_PTP_DIRECT:
+		idpf_ptp_adj_dev_clk_fine_direct(adapter, diff);
+		break;
+	case IDPF_PTP_NONE:
+	default:
+		return -EOPNOTSUPP;
+	}
 
 	return 0;
 }
@@ -767,7 +945,7 @@ void idpf_tstamp_task(struct work_struct *work)
 
 	vport = container_of(work, struct idpf_vport, tstamp_task);
 
-	idpf_ptp_get_tx_tstamp(vport);
+	idpf_ptp_get_tx_tstamp_mb(vport);
 }
 
 /**
@@ -938,6 +1116,7 @@ bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq)
  */
 int idpf_ptp_init(struct idpf_adapter *adapter)
 {
+	struct idpf_ptp *ptp;
 	struct timespec64 ts;
 	int err;
 
@@ -950,8 +1129,10 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 	if (!adapter->ptp)
 		return -ENOMEM;
 
+	ptp = adapter->ptp;
+
 	/* add a back pointer to adapter */
-	adapter->ptp->adapter = adapter;
+	ptp->adapter = adapter;
 
 	if (adapter->dev_ops.reg_ops.ptp_reg_init)
 		adapter->dev_ops.reg_ops.ptp_reg_init(adapter);
@@ -962,29 +1143,34 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 		goto free_ptp;
 	}
 
-	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
+	/* Do not initialize the PTP if the device clock time cannot be read. */
+	if (ptp->get_dev_clk_time_access == IDPF_PTP_NONE) {
+		err = -EIO;
+		goto free_ptp;
+	}
+
+	spin_lock_init(&ptp->read_dev_clk_lock);
 
 	err = idpf_ptp_create_clock(adapter);
 	if (err)
 		goto free_ptp;
-
-	if (adapter->ptp->get_dev_clk_time_access != IDPF_PTP_NONE)
-		ptp_schedule_worker(adapter->ptp->clock, 0);
+	ptp_schedule_worker(ptp->clock, 0);
 
 	/* Write the default increment time value if the clock adjustments
 	 * are enabled.
 	 */
-	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
-		err = idpf_ptp_adj_dev_clk_fine(adapter,
-						adapter->ptp->base_incval);
+	if (ptp->adj_dev_clk_time_access == IDPF_PTP_MAILBOX) {
+		err = idpf_ptp_adj_dev_clk_fine_mb(adapter, ptp->base_incval);
 		if (err)
 			goto remove_clock;
+	} else if (ptp->adj_dev_clk_time_access == IDPF_PTP_DIRECT) {
+		idpf_ptp_adj_dev_clk_fine_direct(adapter, ptp->base_incval);
 	}
 
 	/* Write the initial time value if the set time operation is enabled */
-	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
+	if (ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
 		ts = ktime_to_timespec64(ktime_get_real());
-		err = idpf_ptp_settime64(&adapter->ptp->info, &ts);
+		err = idpf_ptp_settime64(&ptp->info, &ts);
 		if (err)
 			goto remove_clock;
 	}
@@ -994,14 +1180,14 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 	return 0;
 
 remove_clock:
-	if (adapter->ptp->get_dev_clk_time_access != IDPF_PTP_NONE)
-		ptp_cancel_worker_sync(adapter->ptp->clock);
+	if (ptp->get_dev_clk_time_access != IDPF_PTP_NONE)
+		ptp_cancel_worker_sync(ptp->clock);
 
-	ptp_clock_unregister(adapter->ptp->clock);
-	adapter->ptp->clock = NULL;
+	ptp_clock_unregister(ptp->clock);
+	ptp->clock = NULL;
 
 free_ptp:
-	kfree(adapter->ptp);
+	kfree(ptp);
 	adapter->ptp = NULL;
 
 	return err;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index 785da03e4cf5..0a2f08b17033 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -7,13 +7,19 @@
 #include <linux/ptp_clock_kernel.h>
 
 /**
- * struct idpf_ptp_cmd - PTP command masks
- * @exec_cmd_mask: mask to trigger command execution
- * @shtime_enable_mask: mask to enable shadow time
+ * struct idpf_ptp_cmd_mask - PTP command masks
+ * @exec_cmd: mask to trigger command execution
+ * @shtime_enable: mask to enable shadow time
+ * @init_time: initialize the device clock timer
+ * @init_incval: initialize increment value
+ * @adj_time: adjust the device clock timer
  */
-struct idpf_ptp_cmd {
-	u32 exec_cmd_mask;
-	u32 shtime_enable_mask;
+struct idpf_ptp_cmd_mask {
+	u32 exec_cmd;
+	u32 shtime_enable;
+	u32 init_time;
+	u32 init_incval;
+	u32 adj_time;
 };
 
 /* struct idpf_ptp_dev_clk_regs - PTP device registers
@@ -183,7 +189,7 @@ struct idpf_ptp {
 	struct idpf_adapter *adapter;
 	u64 base_incval;
 	u64 max_adj;
-	struct idpf_ptp_cmd cmd;
+	struct idpf_ptp_cmd_mask cmd;
 	u64 cached_phc_time;
 	unsigned long cached_phc_jiffies;
 	struct idpf_ptp_dev_clk_regs dev_clk_regs;
@@ -212,6 +218,22 @@ idpf_ptp_info_to_adapter(const struct ptp_clock_info *info)
 	return ptp->adapter;
 }
 
+/**
+ * idpf_ptp_mb_access - Get the mailbox access type of the PTP feature
+ * @ptp: PTP specific structure
+ * @mailbox: Capability that indicates the mailbox access
+ *
+ * Used to downgrade a feature that cannot use the direct access.
+ *
+ * Return: mailbox access when the Control Plane advertises it, no access
+ * otherwise.
+ */
+static inline enum idpf_ptp_access
+idpf_ptp_mb_access(const struct idpf_ptp *ptp, u32 mailbox)
+{
+	return ptp->caps & mailbox ? IDPF_PTP_MAILBOX : IDPF_PTP_NONE;
+}
+
 /**
  * struct idpf_ptp_dev_timers - System time and device time values
  * @sys_time_ns: system time value expressed in nanoseconds
@@ -269,16 +291,17 @@ int idpf_ptp_init(struct idpf_adapter *adapter);
 void idpf_ptp_release(struct idpf_adapter *adapter);
 int idpf_ptp_get_caps(struct idpf_adapter *adapter);
 void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
+void idpf_ptp_check_features_access(const struct idpf_adapter *adapter);
 bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq);
-int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
-			      struct idpf_ptp_dev_timers *dev_clk_time);
-int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
-			    struct idpf_ptp_dev_timers *cross_time);
-int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time);
-int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval);
-int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta);
+int idpf_ptp_get_cross_time_mb(struct idpf_adapter *adapter,
+			       struct idpf_ptp_dev_timers *cross_time);
+int idpf_ptp_get_dev_clk_time_mb(struct idpf_adapter *adapter,
+				 struct idpf_ptp_dev_timers *dev_clk_time);
+int idpf_ptp_set_dev_clk_time_mb(struct idpf_adapter *adapter, u64 time);
+int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incval);
+int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adapter, s64 delta);
 int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
-int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
+int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport);
 int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 				struct kernel_hwtstamp_config *config);
 u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp);
@@ -302,6 +325,9 @@ static inline int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 static inline void
 idpf_ptp_get_features_access(const struct idpf_adapter *adapter) { }
 
+static inline void
+idpf_ptp_check_features_access(const struct idpf_adapter *adapter) { }
+
 static inline bool
 idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq)
 {
@@ -309,33 +335,33 @@ idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq)
 }
 
 static inline int
-idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
-			  struct idpf_ptp_dev_timers *dev_clk_time)
+idpf_ptp_get_dev_clk_time_mb(struct idpf_adapter *adapter,
+			     struct idpf_ptp_dev_timers *dev_clk_time)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline int
-idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
-			struct idpf_ptp_dev_timers *cross_time)
+idpf_ptp_get_cross_time_mb(struct idpf_adapter *adapter,
+			   struct idpf_ptp_dev_timers *cross_time)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter,
-					    u64 time)
+static inline int idpf_ptp_set_dev_clk_time_mb(struct idpf_adapter *adapter,
+					       u64 time)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter,
-					    u64 incval)
+static inline int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter,
+					       u64 incval)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter,
-					    s64 delta)
+static inline int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adapter,
+					       s64 delta)
 {
 	return -EOPNOTSUPP;
 }
@@ -345,7 +371,7 @@ static inline int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport)
 	return -EOPNOTSUPP;
 }
 
-static inline int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
+static inline int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 1422b30d09a3..ef71df2d51ef 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -5,6 +5,30 @@
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 
+/**
+ * idpf_ptp_regs_access - Get the access type usable with the mapped registers
+ * @ptp: PTP specific structure
+ * @regs: registers the direct access path needs
+ * @num_regs: number of entries in @regs
+ * @mailbox: capability that indicates the mailbox access
+ *
+ * Direct access is only usable when every offset received from the Control
+ * Plane was successfully translated to a BAR address.
+ *
+ * Return: direct access when all registers are mapped, mailbox access when
+ * advertised, no access otherwise.
+ */
+static enum idpf_ptp_access
+idpf_ptp_regs_access(const struct idpf_ptp *ptp, void __iomem * const *regs,
+		     u32 num_regs, u32 mailbox)
+{
+	for (u32 i = 0; i < num_regs; i++)
+		if (!regs[i])
+			return idpf_ptp_mb_access(ptp, mailbox);
+
+	return IDPF_PTP_DIRECT;
+}
+
 /**
  * idpf_ptp_get_caps - Send virtchnl get ptp capabilities message
  * @adapter: Driver specific private structure
@@ -19,7 +43,10 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		.caps = cpu_to_le32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME |
 				    VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
 				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
+				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
+				    VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |
 				    VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
+				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
 				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
 				    VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB)
 	};
@@ -35,6 +62,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	struct idpf_ptp_secondary_mbx *scnd_mbx;
 	struct idpf_ptp *ptp = adapter->ptp;
 	enum idpf_ptp_access access_type;
+	void __iomem *cross_cmd_sync;
 	u32 temp_offset;
 	size_t reply_sz;
 	int err;
@@ -90,6 +118,19 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	ptp->dev_clk_regs.cmd_sync =
 		libie_pci_get_mmio_addr(mmio, temp_offset);
 
+	/* Direct access is only usable when every register was mapped. */
+	void __iomem * const clk_regs[] = {
+		ptp->dev_clk_regs.dev_clk_ns_l,
+		ptp->dev_clk_regs.dev_clk_ns_h,
+		ptp->dev_clk_regs.phy_clk_ns_l,
+		ptp->dev_clk_regs.phy_clk_ns_h,
+		ptp->dev_clk_regs.cmd_sync,
+	};
+
+	ptp->get_dev_clk_time_access =
+		idpf_ptp_regs_access(ptp, clk_regs, ARRAY_SIZE(clk_regs),
+				     VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB);
+
 cross_tstamp:
 	access_type = ptp->get_cross_tstamp_access;
 	if (access_type != IDPF_PTP_DIRECT)
@@ -104,13 +145,31 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	ptp->dev_clk_regs.sys_time_ns_h =
 		libie_pci_get_mmio_addr(mmio, temp_offset);
 	temp_offset = le32_to_cpu(cross_tstamp_offsets.cmd_sync_trigger);
-	ptp->dev_clk_regs.cmd_sync =
-		libie_pci_get_mmio_addr(mmio, temp_offset);
+	cross_cmd_sync = libie_pci_get_mmio_addr(mmio, temp_offset);
+
+	/* The register is shared with the device clock access, so a failed
+	 * translation must not replace the address mapped above.
+	 */
+	if (cross_cmd_sync)
+		ptp->dev_clk_regs.cmd_sync = cross_cmd_sync;
+
+	/* Cross timestamping also samples the device clock registers. */
+	void __iomem * const cross_regs[] = {
+		ptp->dev_clk_regs.dev_clk_ns_l,
+		ptp->dev_clk_regs.dev_clk_ns_h,
+		ptp->dev_clk_regs.sys_time_ns_l,
+		ptp->dev_clk_regs.sys_time_ns_h,
+		cross_cmd_sync,
+	};
+
+	ptp->get_cross_tstamp_access =
+		idpf_ptp_regs_access(ptp, cross_regs, ARRAY_SIZE(cross_regs),
+				     VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB);
 
 discipline_clock:
 	access_type = ptp->adj_dev_clk_time_access;
 	if (access_type != IDPF_PTP_DIRECT)
-		goto free_resp;
+		goto check_features_access;
 
 	clk_adj_offsets = recv_ptp_caps_msg->clk_adj_offsets;
 
@@ -143,13 +202,35 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	ptp->dev_clk_regs.phy_shadj_h =
 		libie_pci_get_mmio_addr(mmio, temp_offset);
 
+	/* Both the main and the PHY timer are disciplined together. */
+	void __iomem * const adj_regs[] = {
+		ptp->dev_clk_regs.cmd,
+		ptp->dev_clk_regs.incval_l,
+		ptp->dev_clk_regs.incval_h,
+		ptp->dev_clk_regs.shadj_l,
+		ptp->dev_clk_regs.shadj_h,
+		ptp->dev_clk_regs.phy_cmd,
+		ptp->dev_clk_regs.phy_incval_l,
+		ptp->dev_clk_regs.phy_incval_h,
+		ptp->dev_clk_regs.phy_shadj_l,
+		ptp->dev_clk_regs.phy_shadj_h,
+	};
+
+	ptp->adj_dev_clk_time_access =
+		idpf_ptp_regs_access(ptp, adj_regs, ARRAY_SIZE(adj_regs),
+				     VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB);
+
+	/* Reconcile dependencies after address validation changed access modes. */
+check_features_access:
+	idpf_ptp_check_features_access(adapter);
+
 free_resp:
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
 	return err;
 }
 
 /**
- * idpf_ptp_get_dev_clk_time - Send virtchnl get device clk time message
+ * idpf_ptp_get_dev_clk_time_mb - Send virtchnl get device clk time message
  * @adapter: Driver specific private structure
  * @dev_clk_time: Pointer to the device clock structure where the value is set
  *
@@ -157,8 +238,8 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
  *
  * Return: 0 on success, -errno otherwise.
  */
-int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
-			      struct idpf_ptp_dev_timers *dev_clk_time)
+int idpf_ptp_get_dev_clk_time_mb(struct idpf_adapter *adapter,
+				 struct idpf_ptp_dev_timers *dev_clk_time)
 {
 	struct virtchnl2_ptp_get_dev_clk_time *get_dev_clk_time_resp;
 	struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg;
@@ -191,7 +272,7 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 }
 
 /**
- * idpf_ptp_get_cross_time - Send virtchnl get cross time message
+ * idpf_ptp_get_cross_time_mb - Send virtchnl get cross time message
  * @adapter: Driver specific private structure
  * @cross_time: Pointer to the device clock structure where the value is set
  *
@@ -200,8 +281,8 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
-			    struct idpf_ptp_dev_timers *cross_time)
+int idpf_ptp_get_cross_time_mb(struct idpf_adapter *adapter,
+			       struct idpf_ptp_dev_timers *cross_time)
 {
 	struct virtchnl2_ptp_get_cross_time cross_time_send, *cross_time_recv;
 	struct libie_ctlq_xn_send_params xn_params = {
@@ -229,7 +310,7 @@ int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
 }
 
 /**
- * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
+ * idpf_ptp_set_dev_clk_time_mb - Send virtchnl set device time message
  * @adapter: Driver specific private structure
  * @time: New time value
  *
@@ -237,7 +318,7 @@ int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
+int idpf_ptp_set_dev_clk_time_mb(struct idpf_adapter *adapter, u64 time)
 {
 	struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg = {
 		.dev_time_ns = cpu_to_le64(time),
@@ -257,7 +338,7 @@ int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
 }
 
 /**
- * idpf_ptp_adj_dev_clk_time - Send virtchnl adj device clock time message
+ * idpf_ptp_adj_dev_clk_time_mb - Send virtchnl adj device clock time message
  * @adapter: Driver specific private structure
  * @delta: Offset in nanoseconds to adjust the time by
  *
@@ -265,7 +346,7 @@ int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
  *
  * Return: 0 on success, -errno otherwise.
  */
-int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
+int idpf_ptp_adj_dev_clk_time_mb(struct idpf_adapter *adapter, s64 delta)
 {
 	struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg = {
 		.delta = cpu_to_le64(delta),
@@ -285,7 +366,7 @@ int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
 }
 
 /**
- * idpf_ptp_adj_dev_clk_fine - Send virtchnl adj time message
+ * idpf_ptp_adj_dev_clk_fine_mb - Send virtchnl adj time message
  * @adapter: Driver specific private structure
  * @incval: Source timer increment value per clock cycle
  *
@@ -294,7 +375,7 @@ int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
  *
  * Return: 0 on success, -errno otherwise.
  */
-int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval)
+int idpf_ptp_adj_dev_clk_fine_mb(struct idpf_adapter *adapter, u64 incval)
 {
 	struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg = {
 		.incval = cpu_to_le64(incval),
@@ -612,7 +693,7 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
 }
 
 /**
- * idpf_ptp_get_tx_tstamp - Send virtchnl get Tx timestamp latches message
+ * idpf_ptp_get_tx_tstamp_mb - Send virtchnl get Tx timestamp latches message
  * @vport: Virtual port structure
  *
  * Send virtchnl get Tx tstamp message to read the value of the HW timestamp.
@@ -620,7 +701,7 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
  *
  * Return: 0 on success, -errno otherwise.
  */
-int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
+int idpf_ptp_get_tx_tstamp_mb(struct idpf_vport *vport)
 {
 	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_msg;
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
-- 
2.47.3

