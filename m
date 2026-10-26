Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B199606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VJzsD5j6;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i9lPnTab
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D2A6606CF;
	Mon, 26 Oct 2026 22:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMuYvM0sfb9E; Mon, 26 Oct 2026 22:37:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 609BA606EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793054241;
	b=qYXRk3zGT5WEcWHtRsXdWCSgphxsnSSefO31rr8dzTIru7840OeQ6C4RwgJofg2dSjO6
	 ZQPoz10JczwqllSdo2lu/VDPFdKhmXvy+dM2HQ+Yr7oGbFcxMNH2tP69T0dTkV8aO+zvU
	 vrP/8XF//ennCxe6BjqkQHioNG/MBi58QpunZ/ByGzwyE+jKRWRwZFjX3BgyYQIrFkZfA
	 L2xdZoD6WnPFOttwdFCDztCY7XqnFFtkuaJ+EFHyV4GtA6HVLuMdGctMVOX69VWVyBmyT
	 ObhgBQiFX7olUGhKfEAR7m5uuX+AnPVLLGba1A4SShrVXY4q/VZOkGOt5c23iKa6Y0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793054241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ziLvl4r9UEC9o424cFny8Uwli8fgBA/N848aL5WO9+Q=;
	b=ac3hoFOpsZRGFepXrevdKGo3ZoHICECdjnWaZUSJ26R6ME8vx3hOWlh3PXVau8dk3o1M
	 zOGnUWcKNA7YPTJgN96d5Ho6v1e08mkPhGyfldUzWoDiPsPjeg651ryZiVJPv7lWPyL7F
	 45inpXja3GoDACuhhYkEHC8TaT6mCDS+FPeZSPAUYUpf3ZaoFRSeLNqz1B7XKfTh4SsqK
	 f/1Cxtq/t9FJOCBhqNn06X0w5m7K8ZDg0UZsuV6ONSJeanX9Szsk5F6eqvM3CkRBP4njU
	 /6ITLnqGa2kIfwh2gL/6zbhlOS/30vmelmipWiR20fX6pUMa10IaXe0A63/3nnM4cyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793054241;
	bh=ziLvl4r9UEC9o424cFny8Uwli8fgBA/N848aL5WO9+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VJzsD5j6McYkeGrmBLN5aiODg1QwYi2vYfv2Q+ENcu6hKMIL1yphCe3RRTV3IIoK4
	 UJrTCXexKNktBynpOiPwr8nvjc3r1xW23jeoWDSUZRjguGfsKQHUwUM2MLJ21YziVE
	 K1oprG33C7j8nqw7uoUQlY2s81yloCNGKgtJ35cJziY7Ma174wsa5xlzOyTudGp3Nc
	 rdow3vkMJhibnLnDwqhx7ES1dJJjXfi5c1b7rFmV3J2jfcLQYWpTcv6lsrNUmhNSwA
	 sxooh6z3oq40KGoTfbd1ztrbJdXCQNPcFmlCkbhisYs6svkO5q9nhpOPcE6Pl0lz6G
	 g0GkcLk1kvuJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 609BA606EA;
	Mon, 26 Oct 2026 22:37:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D07D2F5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7378D40541
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1FiINxvHLnT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7358840523
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793054236;
 b=QbQt+lAPRmGkMm32JWgSpqWh2o/bacBQQG1nsN7jiOqbnKJOTVaomGlIiRoZPAU+4Oy9
 +4CNsDpyoQmnuragPXbeta1LjWMN32QZT377hgmPVyT86MLJ3i3CZWy9MBqgJpFHKQFyK
 MWirUS7p04FGxV6zywR6WEfreOW35dbh7FGjBTdiRA6dveroxp93gtBfJuwCnAk5BS7Uo
 5BcfhKhz79qKBc635HnHxu0Q92LpV0I6ygf8L5Un7V/OhezG4tqLPBwEYPfQDj0wVpNnb
 DVjE0tWkb21fPE8ZrbzcAW5e3Z9+9l0/83Hv0F6qutbmcMtdXKk+W0O0hk+NGM20hIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793054236;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ziLvl4r9UEC9o424cFny8Uwli8fgBA/N848aL5WO9+Q=;
 b=AajvwkF4bHdB+rRg6qdvTyANt2pBZfvK6i74ftItHZJEg0lxNXQCfef0I4no9NZ31Sne
 5Ey6QBcUNKGRDSlg4/Jo11nDhvX+qYSBmLg+BuqpMWRxtfp1WekowGCDGa5w6uvR7fdUy
 oWzb3w4z31hUr19KJ65SUsARpGsWtWp4Z5nlGFEqcP+Tytid4qTsznZiBGsP4iS2478+B
 7awkB7cNvFxX+F+r4LJ0INLzcJFVPQqGn0Nb0ye8HHwAvc+ziP8K/iu1fbIsUhPBQPawY
 E1b5HDptJ5M6Rono8vOXSJLsiKw1dt8j0N/TPo7VU9FZUqLenpc+IdCX9s7Ya463rpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i9lPnTab; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=i9lPnTab
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7358840523
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793054236; x=1824590236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3q64Ym+LP3Zav1gxf3ISQz418vUhxbYLtD72Y2ctufM=;
 b=i9lPnTabKu9ODlWb3/owlLQpsrgj6pgNC92YJQeKInv9Ui45YuNRcDii
 VO/H+1ZVoxlLpQasrdhiH+/i2NI3seOQ9e0nPKkEs5hNFsTeSggcwJNOR
 R6yhZG8ZXankoKcK2lNqYkDmekurfznSe0G2o3s3pZztTfCw5uvjv0G5N
 2O8NZYqOTzv4Eh//8dE3cQsvHeplCxlcCmKwIZnuvIx+fqI64F7bgBH6s
 ez3hZtHb7gxsyzvXm0Wwdd8Pu9SvwcrPYyewVL9RPhJUAuqQA34e3S9sn
 g2n4bl2TKMC6mvA3UteLKN5G1Kex+OhzLKotAJKf9vZEtyQJGHWdp7Kqn Q==;
X-CSE-ConnectionGUID: V+kOHhpyST26S1n8+6dVAQ==
X-CSE-MsgGUID: 818NNzZcR7evTmio0DzkmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1616402"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1616402"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:37:14 -0700
X-CSE-ConnectionGUID: BSHqyWw8Q7GgJdCOVNX1QA==
X-CSE-MsgGUID: FKTD9qRmSHWXxZDQzKt7GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6217179"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 15:37:14 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org
Subject: [PATCH iwl-net v2 4/4] idpf: keep the mailbox alive for driver
 initiated resets
Date: Mon, 26 Oct 2026 15:19:08 -0700
Message-Id: <20261026221908.24690-5-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20261026221908.24690-1-emil.s.tantilov@intel.com>
References: <20261026221908.24690-1-emil.s.tantilov@intel.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

idpf_vc_event_task() shuts the transaction manager down before every
IDPF_HR_FUNC_RESET. That is only right when the reset was detected in
HW. Resets requested by idpf_tx_timeout() and idpf_idc_request_reset()
find the device still running, and idpf_init_hard_reset() now closes the
netdevs first, so the DISABLE_VPORT and DISABLE_QUEUES messages sent from
idpf_vport_stop() fail silently and the rings are freed while the queues
may still DMA into them. The device reset only follows later, and on a
VF not at all once IDPF_REMOVE_IN_PROG is set.

- Shut the manager down in idpf_service_task() when it detects a HW
  reset, and only while IDPF_HR_FUNC_RESET is pending, as that reset is
  what rebuilds it. This releases waiters the CP will never answer,
  which may hold RTNL, before idpf_detach_and_close() needs it, and
  leaves alone a manager the running reset has already rebuilt.

- Cap all transactions while a driver initiated reset runs at
  IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC, as idpf_shutdown() does, so an
  unresponsive CP cannot hold RTNL for the 60 s default per message.
  Restore the default once the new mailbox is up.

- Add IDPF_SHUTDOWN_IN_PROG for the shutdown only policies that were
  inferred from the shortened timeout: latching the timeout to 0 after
  the first expiry, and giving up on SW markers after the first missing
  one. Resets restore the timeout, so a late latch could carry into the
  next reset, and they should wait for every marker as a close does.
  IDPF_REMOVE_IN_PROG cannot be used as remove may wait on a running
  reset.

- Cancel serv_task in idpf_deinit_dflt_mbx() before the manager is
  freed. Its libie_ctlq_xn_shutdown() can now overlap the one in
  idpf_vc_core_deinit(), and the previous patch requires the manager to
  outlive every caller.

- Cancel serv_task in idpf_remove() before vc_event_task, as
  idpf_shutdown() does, so a reset cannot be queued after remove stopped
  waiting for one.

A CP that answers slower than the cap can still have the disable
messages skipped, as before this change, so this narrows that window
rather than closing it.

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Assisted-by: LLM
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  5 ++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 42 +++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  4 ++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 15 ++++---
 4 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 98adaed4d3a2e..3d0216e89db80 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -86,6 +86,7 @@ enum idpf_state {
  * @IDPF_HR_DRV_LOAD: Set on driver load for a clean HW
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
  * @IDPF_REMOVE_IN_PROG: Driver remove or shutdown in progress
+ * @IDPF_SHUTDOWN_IN_PROG: Driver shutdown in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_FLAGS_NBITS: Must be last
@@ -95,6 +96,7 @@ enum idpf_flags {
 	IDPF_HR_DRV_LOAD,
 	IDPF_HR_RESET_IN_PROG,
 	IDPF_REMOVE_IN_PROG,
+	IDPF_SHUTDOWN_IN_PROG,
 	IDPF_MB_INTR_MODE,
 	IDPF_VC_CORE_INIT,
 	IDPF_FLAGS_NBITS,
@@ -643,7 +645,8 @@ struct idpf_edt_caps_ilog2 {
  * @arq: Receive control queue info
  * @xnm: Xn transaction manager
  * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
- *		      on shutdown and set to 0 once a shortened one timed out
+ *		      on shutdown and reset teardown, and set to 0 once a
+ *		      shortened one timed out on shutdown
  * @num_avail_msix: Available number of MSIX vectors
  * @num_msix_entries: Number of entries in MSIX table
  * @msix_entries: MSIX table
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 0cdbd81b13711..1f38d3e3a3f63 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1431,13 +1431,22 @@ void idpf_service_task(struct work_struct *work)
 	adapter = container_of(work, struct idpf_adapter, serv_task.work);
 
 	if (idpf_is_reset_detected(adapter) &&
-	    !idpf_is_reset_in_prog(adapter) &&
 	    !test_bit(IDPF_REMOVE_IN_PROG, adapter->flags)) {
-		dev_info(&adapter->pdev->dev, "HW reset detected\n");
-		set_bit(IDPF_HR_FUNC_RESET, adapter->flags);
-		queue_delayed_work(adapter->vc_event_wq,
-				   &adapter->vc_event_task,
-				   msecs_to_jiffies(10));
+		bool new_reset = !idpf_is_reset_in_prog(adapter);
+
+		if (new_reset) {
+			dev_info(&adapter->pdev->dev, "HW reset detected\n");
+			set_bit(IDPF_HR_FUNC_RESET, adapter->flags);
+		}
+
+		/* Release the waiters on a mailbox that a reset will rebuild */
+		if (adapter->xnm && test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
+			libie_ctlq_xn_shutdown(adapter->xnm);
+
+		if (new_reset)
+			queue_delayed_work(adapter->vc_event_wq,
+					   &adapter->vc_event_task,
+					   msecs_to_jiffies(10));
 	}
 
 	queue_delayed_work(adapter->serv_wq, &adapter->serv_task,
@@ -1930,6 +1939,11 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 	struct device *dev = &adapter->pdev->dev;
 	int err;
 
+	/* As in idpf_shutdown(), bound the teardown if the CP is unresponsive */
+	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
+		WRITE_ONCE(adapter->vc_xn_timeout_ms,
+			   IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
+
 	idpf_detach_and_close(adapter);
 	mutex_lock(&adapter->vport_ctrl_lock);
 
@@ -1968,6 +1982,8 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 		goto unlock_mutex;
 	}
 
+	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC);
+
 	/* Initialize the state machine, also allocate memory and request
 	 * resources
 	 */
@@ -2009,18 +2025,10 @@ void idpf_vc_event_task(struct work_struct *work)
 	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
-	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
-		goto func_reset;
-
-	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
-		goto drv_load;
-
-	return;
+	if (!test_bit(IDPF_HR_FUNC_RESET, adapter->flags) &&
+	    !test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
+		return;
 
-func_reset:
-	if (adapter->xnm)
-		libie_ctlq_xn_shutdown(adapter->xnm);
-drv_load:
 	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
 	idpf_init_hard_reset(adapter);
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 21be83dc82b1b..edbf55d4e490e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -125,6 +125,9 @@ static void idpf_remove(struct pci_dev *pdev)
 
 	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 
+	/* serv_task can still queue vc_event_task until it is cancelled */
+	cancel_delayed_work_sync(&adapter->serv_task);
+
 	/* Wait until vc_event_task is done to consider if any hard reset is
 	 * in progress else we may go ahead and release the resources but the
 	 * thread doing the hard reset might continue the init path and
@@ -198,6 +201,7 @@ static void idpf_shutdown(struct pci_dev *pdev)
 	 * destroy the vports while the mailbox is still up.
 	 */
 	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
+	set_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index eca954783454f..f45cdd227d482 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -196,8 +196,8 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * unmap and release the buffer.
  *
  * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
- * synchronous transaction with a shortened timeout times out, later ones
- * fail at once instead of waiting again.
+ * synchronous transaction with a shortened timeout times out on shutdown,
+ * later ones fail at once instead of waiting again.
  *
  * Return: 0 if the request was successful, -%EBUSY if reset is detected
  *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
@@ -236,7 +236,9 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 	idpf_mb_clean(xn_params->ctlq, false);
 
 	err = libie_ctlq_xn_send(xn_params);
-	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+	/* Resets restore the timeout, so only shutdown can latch it */
+	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC &&
+	    test_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags))
 		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
 
 	return err;
@@ -392,8 +394,7 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 	bool wait_all;
 
 	/* On shutdown, once one marker is missing, don't wait for the rest */
-	wait_all = READ_ONCE(qs->adapter->vc_xn_timeout_ms) >=
-		   IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
+	wait_all = !test_bit(IDPF_SHUTDOWN_IN_PROG, qs->adapter->flags);
 
 	for (u32 i = 0; i < qs->num; i++) {
 		switch (qs->qs[i].type) {
@@ -3027,6 +3028,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
 	idpf_mb_intr_rel_irq(adapter);
+	/* serv_task may be in libie_ctlq_xn_shutdown(), xnm must outlive it */
+	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
 
 	if (adapter->xnm) {
@@ -3287,7 +3290,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	/* Avoid transaction timeouts when called during reset */
+	/* Driver initiated resets may end up here with mailbox still up */
 	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	if (!remove_in_prog) {
 		libie_ctlq_xn_shutdown(adapter->xnm);
-- 
2.37.3

