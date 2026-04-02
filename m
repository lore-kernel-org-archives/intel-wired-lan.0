Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1386D6AB17
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Apr 2026 23:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99E8080D3D;
	Thu,  2 Apr 2026 23:10:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBCrAwjsurGK; Thu,  2 Apr 2026 23:10:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA35380D8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775171410;
	bh=QAyietkVI9v0rZAOsPNRIUqn+MkErFk+Sp8Snf/iy4k=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=MjlhkGewnPyzQGptV3DmKT3coG4UG6ytU5chOpzff4G3vmJhPX8wEtaJfqO8owtOz
	 DRqiZJbgRRMCPkawOS+YuGwUVVlkdtf8zf9ZiezPDHq+CDe4t8RacqOHlnjt+YSb7B
	 5y74xyXvcXQs0Z85va33kTQLFz4B6it+v+u+1lpbuejzbFrKCPdGNXCngKKDLAvjKC
	 sIvPha5p4xK5Rg+tn0raXxzQs0Jz84aU2QlhHKcCTUBeszgW3E9+2hyWSsuVpJjRDD
	 WBPU04O+d8jHQ7J4kZF5yiFULTZJX4A8NKoU8nEPnqdL06GaByfmSp6o2OmUSE4Y/9
	 85Lp28002LR6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA35380D8A;
	Thu,  2 Apr 2026 23:10:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D06352A2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8EF5606CA
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m51ylQ4u69Iq for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Apr 2026 23:10:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 58AF5605CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58AF5605CE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58AF5605CE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Apr 2026 23:10:07 +0000 (UTC)
X-CSE-ConnectionGUID: anLB1yMtQXWUmmvM00NUxQ==
X-CSE-MsgGUID: eD/2UKwXRdm6ehvvgiGbtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76123031"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="76123031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 16:10:07 -0700
X-CSE-ConnectionGUID: JfEn535nSMOtI70bJozDzw==
X-CSE-MsgGUID: i3FZBnqFTHapB6h/2FCjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="227044401"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by orviesa008.jf.intel.com with ESMTP; 02 Apr 2026 16:10:03 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Fri,  3 Apr 2026 01:06:18 +0200
Message-Id: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775171408; x=1806707408;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ajZW05UQdtaVy0CBuJYX5951jU8a/swEG1qZqdkSpeY=;
 b=IZ7r6ee1CvvlxzWHRk+SikEQqStW1kPDKsv06jjb6M8GnXey3EGFNB96
 kPrlUTWZEOUkQ+D3m4p9q1sEE2chg5KLcSPvuPz8SUruujL8qeSVqMhuY
 4ehItWS4GRX7bZ1uzTH1Xv6qIaPvkDc63QeE2QeUwgRXFnKZvfWohVhRg
 jZXAFRHiKNp+4h5A0swBb87IRAEQ8+zrNbi0lPthhhQ6IxKhlljpToSfY
 QLXbRkaWBCO7HJhKRqJ8+xElogX1pVHgYHCXbaRScyHptEBDvFqhTmR1l
 yPCRwgJi3hLRqS/awF4+C8i/jGeCKQV4fUq53I0t/Zg1KmWtdSr4cnOVH
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IZ7r6ee1
Subject: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL
 type and full TX reference clock control for E825
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 jiri@resnulli.us, edumazet@google.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 andrew+netdev@lunn.ch, intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 Prathosh.Satish@microchip.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback of DPLL subsystem changes is
welcomed. In the past possible approaches were discussed in [1].

This series adds TX reference clock support for E825 devices and exposes
TX clock selection and synchronization status via the Linux DPLL
subsystem.
E825 hardware contains a dedicated Tx clock (TXC) domain that is
distinct
from PPS and EEC. TX reference clock selection is device‑wide, shared
across ports, and mediated by firmware as part of the link bring‑up
process. As a result, TX clock selection intent may differ from the
effective hardware configuration, and software must verify the outcome
after link‑up.
To support this, the series introduces TXC support incrementally across
the DPLL core and the ice driver:

- add a new DPLL type (TXC) to represent transmit clock generators;
- relax DPLL pin registration rules for firmware‑described shared pins
  and extend pin notifications with a source identifier;
- allow dynamic state control of SyncE reference pins where hardware
  supports it;
- add CPI infrastructure for PHY‑side TX clock control on E825C;
- introduce a TXC DPLL device and TX reference clock pins (EXT_EREF0 and
  SYNCE) in the ice driver;
- extend the Restart Auto‑Negotiation command to carry a TX reference
  clock index;
- implement hardware‑backed TX reference clock switching, post‑link
- verification, and TX synchronization reporting.

TXCLK pins report TX reference topology only. Actual synchronization
success is reported via the TXC DPLL lock status, which is updated after
hardware verification: external Tx references report LOCKED, while the
internal ENET/TXCO source reports UNLOCKED.
This provides reliable TX reference selection and observability on E825
devices using standard DPLL interfaces, without conflating user intent
with effective hardware behavior.

[1] https://lore.kernel.org/netdev/20250905160333.715c34ac@kernel.org/

Changes in v5:
 - rebased
 - reworded cover letter
 - replace 'ntfy_src' new argument name with 'src_clk_id' and use it
   consistently in DPLL notification calls (patch 3/8)
 - reworded commit message (patch 5/8)
 - use FIELD_PREP/GENMSK macros instead of struct bitfields (patch 6/8)
 - reworded commit message (patch 5/8, patch 8/8)
 - refactor the code to avoid sleeping while DPLL mutex is held (using
   work_queue, patch 8/8)
 - added TXCLK pins and TXC DPLL notifications (patch 8/8)
 - removed 'unused clock disable' mechanism from the scope of this series

Changes in v4:
 - rebased
 - edited, shortened the commit message in 3/8 patch
 - moved ice_get_ctrl_pf to the header file (patch 8/8) and
   removed duplicated static definitions from ice_ptp and ice_txlck
   modules
 - add NULL/invalid pointer checker for returned pointer from
   ice_get_ctrl_pf (patch 8/8)
 - edited error message in case AN restart failure (patch 8/8)

Changes in v3:
- improved commit message (patch 1/8, AI review comment)
- improved deinitialization path in ice_dpll_deinit_txclk_pins to
  avoid potential NULL dereference. NULL checking moved to
  ice_dpll_unregister_pins (patch 5/8, found by AI review)
- removed redundant semicolon (patch 6/8)

Changes in v2:
- rebased
- added autogenerated DPLL files (patch 1/8)
- fixed checkpatch 'parenthesis alignment' warning (patch 2/8)
- fixed error path in ice_dpll_init_txclk_pins (AI warning, patch 5/8)
- fixed kdoc warnings (patch 6/8, patch 8/8)

Grzegorz Nitka (8):
  dpll: add new DPLL type for transmit clock (TXC) usage
  dpll: allow registering FW-identified pin with a different DPLL
  dpll: extend pin notifier and netlink events with notification source
    ID
  dpll: zl3073x: allow SyncE_Ref pin state change
  ice: introduce TXC DPLL device and TX ref clock pin framework for E825
  ice: implement CPI support for E825C
  ice: add Tx reference clock index handling to AN restart command
  ice: implement E825 TX ref clock control and TXC hardware sync status

 Documentation/netlink/specs/dpll.yaml         |   3 +
 drivers/dpll/dpll_core.c                      |  32 +-
 drivers/dpll/dpll_core.h                      |   3 +-
 drivers/dpll/dpll_netlink.c                   |  10 +-
 drivers/dpll/dpll_netlink.h                   |   4 +-
 drivers/dpll/dpll_nl.c                        |   2 +-
 drivers/dpll/zl3073x/prop.c                   |   9 +
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 337 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  61 +++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 380 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  10 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  26 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  34 ++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 241 +++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  38 ++
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 26 files changed, 1215 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: f35340f2d653f1003602878403c901396ab03c17
-- 
2.39.3

