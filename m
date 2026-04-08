Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FC91073CB4
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 13:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D69040EBE;
	Wed,  8 Apr 2026 13:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yz-rBeJIeO9T; Wed,  8 Apr 2026 13:11:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D06DA40EB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775653919;
	bh=CD5qVWFevM9JR+zvZfHN09AJOIckfXCJgVIsVxsDYFk=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0wDv5+Ch2S381HyOB2JsLaC8Gk+0KlMwdg2e6kUqkVB5fpVyvwqtV/LRXNNsfFlCI
	 Dnfx6e/Thc08fKyUz9GMeB7IUZJckq3OrMyxR97TtO0fSUwKQRFJIoRrN+yhUtwGuS
	 F8Cgx14+gRcmymVWAjKcPGTjfzItKdbC6w8ibjF2/4veLYoMrSyxd5uPuXdhcew6DP
	 LlTmeogbEPJ/2tro8jVeoOQhnjCnRMNTMS1WLrieaQfdMhTDTHK48ZSXZM5qbvAMFk
	 lDypBT5620CoCSke/WvyQcxq+/L/AMCjTzm9OGVqF6VB1R5DzSBV44ud35Y4uJ9wz2
	 bCKWb1bbH+02w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D06DA40EB4;
	Wed,  8 Apr 2026 13:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76F6F2C7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D1DA608B9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqwY-mTnX1l1 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 13:11:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8F35260856
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F35260856
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F35260856
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:11:57 +0000 (UTC)
X-CSE-ConnectionGUID: 1BTlEtFxRdi2ka8fv3TW/Q==
X-CSE-MsgGUID: 2MNcWf4AQb6VCsJdhiU4xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087223"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="102087223"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 06:11:57 -0700
X-CSE-ConnectionGUID: 8xNg/nTORjGkvOQPG9kPaA==
X-CSE-MsgGUID: RYZ4mSObT7myxSFQlZguuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228714940"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:11:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Wed,  8 Apr 2026 15:11:48 +0200
Message-ID: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775653918; x=1807189918;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xHT//3FdP0pzi+J3JCTY+FWqu5wZN0PFM98U8ARD2xs=;
 b=EOdgitGcy9eWV40I4OW1O1E7VGJHysThShucfzhUIx5DbR/8Js2uHkeu
 Hf/DEnKvW0sXBDdw2iwO4jYBk/n1nxJ0dM1K++B3J6J0ayAvcZk6dNW1p
 hF/0ZGEpOj6YDEzA7ji21mNbz69SDXlQP96ziWcsarg5K3ERWlRMZQ5d1
 +S51PDfH1eQ7jtweRkvEs3R1MUG7aZQmygiONPNiAxiMMXIBBq9Rq29/8
 5XvPW5OmENhS7fJM15kPM1e8dGEktfvcRKg5Gw9WrVYqfTbV96UEWBrgQ
 MWWkGQYEeXopcrsp/LWPt8vrYIz/UhYR3d01ZGl4gdwEMeTgHER2gMlbq
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EOdgitGc
Subject: [Intel-wired-lan] [PATCH iwl-net v2 0/6] ixgbe: six bug fixes
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

Patch 1 is a squash of two previously independent submissions:
  - "ixgbe: increase SWFW semaphore timeout for X550 FW updates"
    (Soumen Karmakar)
  - "ixgbe: extend 5 s SWFW semaphore timeout to all X550EM variants"
    (Marta Plantykow)

The commit message for patch 1 also fixes an error noted in review:
the previous description stated "200 ms" but the actual default is
1 s (200 iterations x 5 ms per poll).  Patch 1 also replaces the
">= X550 && <= x550em_a" range check with three explicit mac.type
comparisons per Tony Nguyen's request.

Patch 3 additionally handles the setup_fc() failure path that was
left unaddressed in the prior posting: fc_enable() is now skipped
when setup_fc() fails so the MDD-triggering stale state is not
committed to hardware.

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
