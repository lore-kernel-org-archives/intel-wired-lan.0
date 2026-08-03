Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E4C55179
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 11:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EEA160758;
	Mon,  3 Aug 2026 11:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vuAC1iv7WUnl; Mon,  3 Aug 2026 11:41:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C021860746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785757279;
	bh=1PU7LP4ywPLFQ0rnJO+hiwQ3XPGOXJCRktRUGQLIvXU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ufB+5xcMnWECmm00hEnUKGAudQ63LLIdNkVzk9K/p8gjVnv7evQyjQdJbzvtiymBI
	 0uMB3nUy6ap3c0PPayxgrBIE/asV56+izTtJDGFM9bwxmkwjXqSpt0TnO8Y7TKQEAC
	 9bTFF9MKYE4sApvBLqBuXYMT2Mj05G6Ycl2W/u/C7OT6xi7KPeotZu712xUsWkP4VG
	 IJdgPiExUfhn+/d7Qy3i0L6k6bQdRbGA4BMexDzUXBtSXzGl7TmcoM/WftfDbJ7uSf
	 fCxaEsAKPPr/ie/Gzp/U15OqtnDL1+19F4ZxPBWjuJ3lP9OlsQTnia7NwGQw7vftWo
	 tcDFSiMnONxBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C021860746;
	Mon,  3 Aug 2026 11:41:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41E5C350
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33BE580DA7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZLik5qEdLT1 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 11:41:18 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 587D080DA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 587D080DA2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 587D080DA2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 11:41:18 +0000 (UTC)
X-CSE-ConnectionGUID: KGKAHtiARymDvbOPeYzv5A==
X-CSE-MsgGUID: zQv6vLN5TYWCnIJByxsymA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="96878833"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="96878833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 04:41:17 -0700
X-CSE-ConnectionGUID: 1j6TNZkoRIGltW9gZIzNug==
X-CSE-MsgGUID: ukto2IKZS7WUUT64vEHI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="257299043"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa010.fm.intel.com with ESMTP; 03 Aug 2026 04:40:06 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  3 Aug 2026 13:35:04 +0200
Message-Id: <20260803113507.1858083-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785757278; x=1817293278;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J5J8BGB+qNHC0Yjk2zJKkVE6+rid+ufAR9hbEF2Mo/w=;
 b=hHKBHQiG6xEFKJKxR3h3SfqvpslFS1O6eTcneUmCA8pmyEQ3yJWtkr/K
 rVrQYnnR0vVlfHh6hzDLlomF9I9ehs3D92tFyyYINK+q+cmh/QaLZNLH8
 YU5sm4nQuHMrG0UVvWMgPU/rZ64Nh+VJb+xd43a9cUTDskZI4ysy4nicE
 t3443qVyL17kvVLfnOylYdcD/hD98YBowJFYxVW3kRr1IiOk0shlQKJ1Z
 CQoi3IgRgeTpCKOAgVLHEJNv1u774o54bXvEbmpYMod6DQLwb50v74hCz
 HTJr+84Eu1xyGZGCToupfC6ZsewLlUkBAAVnbQyoEMRsRH5fHHS0QOEZ6
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hHKBHQiG
Subject: [Intel-wired-lan] [PATCH v3 iwl-next 0/3] ice: expose TSPLL state
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

Changes in v3:
- Addressed Sashiko concerns from:
  https://sashiko.dev/#/patchset/20260731121216.1841413-1-grzegorz.nitka%40intel.com
  - Fix spurious TSPLL lock-status flapping from the DPLL set callback.
  - Serialize ice_ptp_tspll_monitor() with the DPLL set callback under
    pf->dplls.lock (mutex lifetime moved to ice_init_features()).

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

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 501 ++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c  |   9 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  82 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 122 ++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 7 files changed, 674 insertions(+), 61 deletions(-)


base-commit: 6e41d29c60deeb29a88debd2540dab757674834d
-- 
2.39.3

