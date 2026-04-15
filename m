Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB290F43821
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 14:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 894586F74C;
	Wed, 15 Apr 2026 14:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnbI4ZRmUeo1; Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B622360A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776263327;
	bh=ZfNvl0Kunf0DdZLk/YTbsgC+1j2q8T2AlszBZI08EeM=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NRzl3BKr/YHPlAqIULugIgAJCSV1OpwCYQ2O8jx+tVuY4W6bf5ESXynJpgwLl3K52
	 ETsmb2mEHpYdzfIvrNj6+TAzif2Ji0lbuCC8l6xb97vO8HmT7eADpaDiTCb/TTbDIL
	 t27SbPOQxSMvtlwW4S8o7SmeVRXfndzHMRjaT6NfW+fsYby9MCtTsV2FeP0skwe5/0
	 EpeU/nf2WQXBWIPxxFbtEB5nZCfrNHWw27hoQ9DQENmvQELTICzu6MX2mIUg0B/+hH
	 1psag83uqewSFXaoGb0Fx6eEMUNiCKYYFoIueuFOe9Ir11hyK3HQatAALXTC3ocmSi
	 +fxN59EmtRcbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B622360A99;
	Wed, 15 Apr 2026 14:28:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C09B0375
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A94674B0ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IixoYCJvafrd for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 14:28:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C67AA4AF73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C67AA4AF73
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C67AA4AF73
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 14:28:44 +0000 (UTC)
X-CSE-ConnectionGUID: zbt6vZWKS9KwjrC+8s4Nfw==
X-CSE-MsgGUID: no0+SUdcSoCwNbAX6bTQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77423726"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77423726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 07:28:43 -0700
X-CSE-ConnectionGUID: 3CeTPOSiQZ6o5qn6eSGebw==
X-CSE-MsgGUID: HNKefGP3R3a9pY2lsv6PCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="234467814"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 15 Apr 2026 07:28:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Wed, 15 Apr 2026 16:28:35 +0200
Message-ID: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776263325; x=1807799325;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hGYpdPt5f7E7jW84kiyLG0thuZ8oo2TpL9uLwiLJ2N4=;
 b=CS23Bf8dqLFTshtEgaioP/FGn31MUZbaqGNCy8h01L8fyeJDgc/MxQOA
 vpW8Prbe6hhVjjxSfo6tznH+42hlaCbNeHCcvALUULYnsIWkIPRnq3CLr
 gYZX+ifJwOobBr5QUtbxkDHJkNyNyD0b+mdxFUZ34z6ac8HglsLNgto8X
 GcAzXWCFCgcTHiIlbt3JMEpM1/a2XWiE/T0w0quaijLwSsAzwCK901Uti
 CmwFUMX4oVE1DOefS4SWO3g1ZZuy9PDqliJ1yVFw3b6508Sla1fUgkoqB
 r0kJDlOPdLi20fihdenABFP2W7Xhhs9S76k3AKS1m/UxjciC+r20EAZ1o
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CS23Bf8d
Subject: [Intel-wired-lan] [PATCH iwl-net v3 0/6] ixgbe: six bug fixes
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

Six fixes for the ixgbe driver, covering a SWFW semaphore timeout
miscalculation, a security-relevant debugfs out-of-bounds, a broken
flow-control NVM-reset path, a false-success return in the cls_u32
nexthdr path, an adaptive-ITR u8 overflow, and wrong bit positions in
the UP-to-TC register normalisation.

Patches 1-3 fix issues that could result in functional regressions
(FW update failures, OOB MMIO, traffic stall after NVM update).
Patches 4-6 fix correctness bugs with user-visible effects.

Patch 3 guards against calling setup_fc() on 82599 backplane links:
on those interfaces setup_fc() resolves to prot_autoc_write() ->
ixgbe_reset_pipeline_82599(), which toggles IXGBE_AUTOC_AN_RESTART
and causes an infinite link-flap loop.  setup_fc() is now skipped for
ixgbe_media_type_backplane; fc_enable() is still called.  The failure-
path guard introduced in v2 (skip fc_enable when setup_fc fails) is
preserved.

Patch 5 reworks the ITR write-back to keep the mode flag
(IXGBE_ITR_ADAPTIVE_LATENCY, bit 7) and the usec delay in separate
operands until the final store, and clamps the delay to
[IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS] via
clamp_val().

Patch 6 corrects the Fixes: tag to 8b1c0b24d9af ("ixgbe: configure
minimal packet buffers to support TC") per Simon Horman.

Changes in v3:
 - cover: removed Patch 1 squash-history description (v1->v2 background
          no longer needed in the cover letter).
 - 1/6: add Reviewed-by: Simon Horman, Reviewed-by: Jacob Keller;
        no code change (Jacob suggested read_poll_timeout() but
        accepted as-is for net).
 - 2/6: add Reviewed-by: Simon Horman; no code change.
 - 3/6: add backplane-link guard in ixgbe_watchdog_update_link();
        skip setup_fc() when media type is ixgbe_media_type_backplane
        to prevent infinite link-flap on 82599 backplane interfaces.
 - 4/6: add Reviewed-by: Simon Horman; no code change.
 - 5/6: rework clamping -- use clamp_val() with mode and delay as
        separate operands; clamp to [IXGBE_ITR_ADAPTIVE_MIN_USECS,
        IXGBE_ITR_ADAPTIVE_MAX_USECS] instead of LATENCY-1.
 - 6/6: correct Fixes: tag to 8b1c0b24d9af; add Reviewed-by:
        Simon Horman.

Changes in v2:
 - 1/6: Squash two patches; fix commit msg ("200ms" -> "1s"); three
        explicit mac.type == comparisons instead of range check.
 - 2/6: Add Fixes: tag; reroute from iwl-next to iwl-net.
 - 3/6: Add Fixes: tag; reroute to iwl-net; skip fc_enable() when
        setup_fc() fails to avoid committing stale FC state.
 - 4/6: Add Fixes: tag; reroute from iwl-next to iwl-net.
 - 5/6: Add proper [N/M] patch numbering.
 - 6/6: Reroute to iwl-net; swap to (expr >> ..) & MASK operand order.

---

Aleksandr Loktionov (5):
  ixgbe: fix SWFW semaphore timeout for X550 family
  ixgbe: call ixgbe_setup_fc() before fc_enable() after NVM update
  ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
  ixgbe: fix ITR value overflow in adaptive interrupt throttling
  ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()

Paul Greenwalt (1):
  ixgbe: add bounds check for debugfs register access

 drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 18 ++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c    |  8 ++++++++
 3 files changed, 22 insertions(+), 8 deletions(-)
-- 
2.52.0
