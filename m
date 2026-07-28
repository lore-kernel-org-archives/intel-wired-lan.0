Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F148C54EFC
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4DF881326;
	Tue, 28 Jul 2026 09:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUF6jgpmwgTS; Tue, 28 Jul 2026 09:18:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F6A18131C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785230303;
	bh=UtpYFD5P1Jv/mn1CkBg6sVi07EREEvWmatU4rt9gT9k=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=2ebyb15RvRcnnEPQ8nRpys91WxovW66aZAhYg4C0w5Uy/Zaxyxk72x5ODNhnuvGrp
	 ETBgji8TTMkIpYbCYZ5g5K5apnSxgLkbQX7icr1V2Ls9EkLoGXMQhLo9PFUZcrZ4LA
	 N2zDvFpov5HnGejtgi7AE3XpQxv6Djgufwdc8u4CdfC+SoWOJeMFfpf1OW2kkZrgEY
	 qTqOpogzEHDQo0xjczd6YA4waDn0B7B7EZVB2jcRKqJm3CJ7MzQM4sdW/Z9xbeidME
	 lOdvjcc6mB9fSZ0Y+NZpKODwcIcasIfXBsRpDm5iaFPKvIngaeQUxnhhtQ6b3WGIQP
	 AcJGnCLZGC1GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F6A18131C;
	Tue, 28 Jul 2026 09:18:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C2D788
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 09:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB8644092B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 09:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvGFto5vzk6X for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 09:18:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5249D40929
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5249D40929
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5249D40929
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 09:18:21 +0000 (UTC)
X-CSE-ConnectionGUID: 4IDdvuw5TWm8Lsqn+THeWw==
X-CSE-MsgGUID: oh79ql4aRy2N3sFE0G2a6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85677235"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85677235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 02:18:20 -0700
X-CSE-ConnectionGUID: 0/6CBofXSVGzYMsPPqvEsA==
X-CSE-MsgGUID: DM08+b4SRJGVolx4ShI3hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="258378411"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 02:18:17 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 28 Jul 2026 11:13:11 +0200
Message-Id: <20260728091314.1420656-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785230301; x=1816766301;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SWxZG5+sOL0eaYnnUUqJ1958bHVxM3Dc0x29DZMl+zk=;
 b=ewXu2k6foc9E8KdtjP167I1/CZoaVccMqFqYLksTvQwUfqD2DexOdS1A
 TtFBN+q0ntPX1cOF0zG/VuZIR9lhupwel4k+CnyIqDdAEaV6Czs9jAue0
 Obkkr1INnm3CtSWcDYE0+l2kwRaYflK5mA7c4g2PicAnBsxfgkcy4Znc3
 p6Ds3Jo3uPHkeEITxtpIhDsWhCSpW6bwdep4Dj1xaKkFi5mUYeXio8Wp4
 gFiqOvRIqKT1O5DthrvLFLPflWPFFNg3jrNE3y2sc91K4j1g6XXksdfKt
 4xN4HfiJbUUJNQxqHFuwif9WsC5axojUaFtFKQjwAMywpx4OW41CUxkLf
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ewXu2k6f
Subject: [Intel-wired-lan] [PATCH iwl-next 0/3] ice: expose TSPLL state on
 E825 through dpll subsystem
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

Grzegorz Nitka (3):
  ice: monitor TSPLL lock from PTP periodic worker
  ice: add TSPLL DPLL device and TIME_REF pin for E825
  ice: use per-interface clock_id for E825 generic DPLLs

 drivers/net/ethernet/intel/ice/ice_dpll.c  | 479 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  80 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.h   |  11 +
 drivers/net/ethernet/intel/ice/ice_tspll.c | 122 +++++-
 drivers/net/ethernet/intel/ice/ice_tspll.h |   6 +
 6 files changed, 657 insertions(+), 45 deletions(-)


base-commit: d621cef13189b54ee67019d170a6d8ec727785aa
-- 
2.39.3

