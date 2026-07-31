Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD12CC54F54
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 12:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7521D60B31;
	Fri, 31 Jul 2026 12:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CAr_oGxigjrs; Fri, 31 Jul 2026 12:17:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE9C160B2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785500237;
	bh=AlEUlpXwASb0MspfNLaBpLsaA1aFKUbWNLoQT8LPvfA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=4Jc1NPS7KZYkQTVU+xSQNNrX07LEruN9YNHNl+23yaLAU3zJpg5FyPSGZaXi6JHtc
	 QDomIjNVcgagHRpVMK+Djn/ukOClIhfOLk2vkmNe1JfeRnTWg0t7oLpEPSH4/aB/D7
	 Kg903klRb9ssg3ZVxUj8nls5YEemYLnplCiN/IjdocT5N3JOt7H/WWRsTE/svnArYk
	 WrvT+cVQKMimBxUiFgiP3d8dcGKPpSnpo3frcvsKBBkljsn7bsR6skt6KvBu8uCN1e
	 kEeCTMaS/zPkK0JkHfMaJNohrPUHQqt0v1HIWWYGo7vSqgN4d7VBEEVE9UJGViI7CP
	 z+Vz/On8I54HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE9C160B2C;
	Fri, 31 Jul 2026 12:17:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3015536E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F94340463
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0G-mic53NMib for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 12:17:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4829D40467
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4829D40467
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4829D40467
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 12:17:15 +0000 (UTC)
X-CSE-ConnectionGUID: w3S3M5FeTaa4BQX4bt5nCA==
X-CSE-MsgGUID: 2mVD9R/UQieFghV2G14Y8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="73662866"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="73662866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 05:17:14 -0700
X-CSE-ConnectionGUID: 2z4qQXnHR0GHDmW/q5u9EQ==
X-CSE-MsgGUID: d6BkuRy0QlK1snsQin/BRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; d="scan'208";a="298765972"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa001.jf.intel.com with ESMTP; 31 Jul 2026 05:17:12 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 31 Jul 2026 14:12:13 +0200
Message-Id: <20260731121216.1841413-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785500236; x=1817036236;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rf1mFh7h5zJUZKuy5tZZW2jUDW4ugjsSwKQ7RQgLP5s=;
 b=eA99R1mRZILE+DDAYeQ3z0+MKXgMKifUyBIS1WZvsFwQ3RWXob4tz7xr
 TIyRa2bW1FzZoq/GQo7nhz2BPMdWDrXtDB9WQ7swxTl0pPLISCSYwaASd
 qXWdQoXcb5S0uUs76rLlNHSv4bal5LMpP0x6YoKLzwG9YkHCqCVGkQ77g
 omPS6o8RTBopLzlBlEXAEBPjfVCU3ZlzxbDHqzpXQufawIwYXPbL3kwtD
 3QTzBIKG4aPxeccgQLp+xQ9EQK+BW/hHrbSYtaGILTO/7Z63o+UFTK4zF
 n5Wru3fX6dztc6qSrXgQEk9tjXoJiOpsQlls8X2PO6YvdKImCvVzbOZQY
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eA99R1mR
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 0/3] ice: expose TSPLL state
 on E825 through dpll subsystem
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
Cc: przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On E825 devices that own the source timer, the TSPLL can lose lock when
the TCXO or TIME_REF signal is disrupted. This series adds monitoring
and recovery for that condition, then surfaces the lock status and clock
source selection through the dpll subsystem. It also fixes the clock_id
generation for E825 generic DPLL devices so userspace can unambiguously
map each DPLL device to its owning interface.

Patch 1 adds TSPLL lock monitoring to ice_ptp_periodic_work(). Placing it
there ensures recovery runs regardless of whether DPLL init succeeded or
CONFIG_DPLL is enabled. Lock state is cached in pf->ptp.tspll_locked via
WRITE_ONCE()/READ_ONCE() for consumption by the DPLL worker.

Patch 2 registers the TSPLL as a DPLL_TYPE_GENERIC device for E825 owner
PFs, with a fwnode-backed "time_ref" input pin. The pin state_on_dpll_set
callback switches the clock source between TIME_REF and TCXO. Lock status
is read from pf->ptp.tspll_locked; UNLOCKED is reported unconditionally
when the clock source is TCXO to reflect the free-running oscillator state.

Patch 3 changes the clock_id generation for E825 TX-CLK and TSPLL DPLLs.
Previously they used the board-level PCIe DSN, which is identical for
all interfaces sharing the same NAC/quad, so userspace could not tell
them apart. The new scheme derives the clock_id from the permanent port
MAC (with a dedicated tag bit distinguishing TSPLL from TX-CLK), while
other DPLL objects (EEC/PPS and non-E825 paths) keep the board-level
DSN-derived clock_id.

Changes in v2:
- rebased
- Patch 2: Fix TOCTOU race between DPLL state_on_dpll_set and PTP
  TSPLL monitor by serializing both paths on pf->dplls.lock. Lift
  pf->dplls.lock lifetime to ice_init_features()/ice_deinit_features()
  so ice_ptp_tspll_monitor() can take it unconditionally. Remove the
  now-redundant ICE_FLAG_DPLL gate in the monitor. Update kernel-doc
  Context: notes to reflect the new lifetime. (Addresses review from
  https://sashiko.dev/#/patchset/20260728091314.1420656-1-grzegorz.nitka%40intel.com)

Grzegorz Nitka (3):
  ice: monitor TSPLL lock from PTP periodic worker
  ice: add TSPLL DPLL device and TIME_REF pin for E825
  ice: use per-interface clock_id for E825 generic DPLLs

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 497 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  79 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 122 ++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 7 files changed, 667 insertions(+), 61 deletions(-)


base-commit: 6e41d29c60deeb29a88debd2540dab757674834d
-- 
2.39.3

