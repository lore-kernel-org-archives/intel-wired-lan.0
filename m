Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA0D58CBF
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Mar 2026 22:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A47A0608B2;
	Mon, 23 Mar 2026 22:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iFrRFpokuDTJ; Mon, 23 Mar 2026 22:25:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9361608B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774304711;
	bh=k2Rd02QUz4jCc3IJrzZ/9mayI8nFj2UxQ4gheAl/IxI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=4+OGI6nsFQbosIxt/PQ/bVc196qPTVWvJGBMYooMf7cxVVhaVDB9FKb3Hi+A6dC4z
	 S83BGQE8OqPARnpXgak2J5DtXpruYfFa3XS1M23qDVdYhmcGG7BrCkwOdJujJgBCrC
	 oZ7IxeEMaz3rtJxumo+jjcDopk7/8P8B6HMzSVqEKSEXZN5yzmnbik8l8ijUbDF/ib
	 6kY5NfBp4eK60kbCVij/8AxY89Y98EX1eQNaJfvxOjk79AX1D6o37U64JXGvEkFRSj
	 YyG9uzAw61vxH8luzkZe5qN8wrMjnHctNYeCZJRbrA36nydk7R53f109AUIzsyC/vr
	 MDVy/N/kd5R2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9361608B3;
	Mon, 23 Mar 2026 22:25:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B39931D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 22:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CD7940D35
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 22:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-IvJVXVS8vM for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Mar 2026 22:25:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=grzegorz.nitka@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2BA7C40D20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BA7C40D20
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BA7C40D20
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Mar 2026 22:25:08 +0000 (UTC)
X-CSE-ConnectionGUID: oe2UfhtvRW++quCpDh8PAA==
X-CSE-MsgGUID: uYS+IQ1wRp6789fhLRI6Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75221814"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75221814"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 15:25:08 -0700
X-CSE-ConnectionGUID: gKe+7TSoSy2oArqP4LvONQ==
X-CSE-MsgGUID: +0z0P1H4SUGh0RXQiFStcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="247207235"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
 by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 15:25:03 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Date: Mon, 23 Mar 2026 23:21:25 +0100
Message-Id: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774304709; x=1805840709;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sjFyRv66DAaBXLmXzPIDUVSo3fvSMJQ1La8ROeyuq+c=;
 b=VxbsGxw3uOST+zVNGi7OU4EZ5VXKI1zalpVuVLnwmIW4yT+DS6tIPiaN
 9rhVMdH+03w+GPuBWf79gvEX3qRk8g29QDMOpataMPQhGwj+GETF7Cno9
 VGxcxP+2uN4PU1QrcVv/RO62GFfU7ml5L4VVBxjiO3ADdDu9xGFx2DZwq
 MStKUad+k9nKU31ZFPzzAFuQuCSJ9OUyv1tzjWKKQkmbYCwgHdjsF+2CE
 bfKOGkyUnqgoEyDG0JuIsUw6YcrPqLA4635x3jja5cKE9cpis99EEQO/v
 RufZsvPhlkfMMDMAkE8vFnIC8fA+THzgE0cGMdLrCSAxOXtST0f21OWw3
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VxbsGxw3
Subject: [Intel-wired-lan] [PATCH v3 net-next 0/8] dpll/ice: Add TXC DPLL
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

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback of DPLL subsystem changes is
welcomed. In the past possible approaches were discussed in [1].

This series extends the DPLL subsystem and the ICE driver to fully
support transmit‑clock (TXC) reference selection on Intel E825‑class
hardware. These devices expose a dedicated TX reference clock domain
separate from PPS and SyncE/EEC, and they allow switching between
multiple PHY‑sourced references (TXC0, EREF0, SyncE). Until now
the kernel lacked a DPLL type to represent TXC‑class devices, and
the ICE driver had no way to control or report the active TX reference.
The series introduces: 

Subsystem‑wide improvements:

- A new DPLL type (DPLL_TYPE_TXC) to represent devices that generate a TX
SERDES reference clock.
- Improvements to pin registration for fwnode‑identified pins.
- Addition of a notification source identifier (src_id) for more accurate
pin event routing in both netlink and internal notifiers.

Hardware/driver support:

- ZL3073x: allow control of the SyncE_Ref pin state.
- ICE/E825: full TXC DPLL instance with dedicated pins (EXT_EREF0 and
SyncE) and proper integration into the notifier/mux logic.
-A new CPI (Converged PHY Interface) subsystem implementing the low‑level
command protocol required by E825 PHY clocking control.
- Extension of the Restart AN AQ command with a TX reference clock
selector.
- Complete support for selecting, enabling, disabling, and tracking the
active TX reference clock for E825 devices, including peer‑PHY routing
and safe clean‑up of unused clock sources.

This enables proper userspace‑driven clock control via the DPLL API and
is a prerequisite for advanced SyncE deployments, link recovery modes, and
multi‑clock orchestration on E825 NICs.

Patch summary:

dpll: add new DPLL type for transmit clock (TXC) usage
Introduces DPLL_TYPE_TXC and publishes it through netlink.

dpll: allow registering FW‑identified pin with a different DPLL
Relax the (module, clock_id) matching rules when fwnode pins are
involved.

dpll: extend pin notifier and netlink events with notification source ID
Adds src_id to pin notification paths and updates all callers.

dpll: zl3073x: allow SyncE_Ref pin state change
Advertise hardware support for state toggling.

ice: add TX clock (TXC) DPLL interface for E825 devices
Introduces the ICE TXC DPLL, its pins, and relations to existing PHY
fwnode pins.

ice: implement CPI support for E825C
Adds the CPI command engine used for PHY‑side clock control.

ice: add Tx reference clock index handling to AN restart command
Wires the refclk field into the AQ Restart AN command.

ice: add TX reference clock (tx_clk) control for E825 devices
Implements full clock‑selection logic, state tracking, cleanup, and
DPLL pin ops integration.


Testing was performed on E825C hardware in multi‑port configurations,
verifying TXC pin exposure, SyncE/EREF0 switching via DPLL netlink, and
link recovery across all combinations.

[1] https://lore.kernel.org/netdev/20250905160333.715c34ac@kernel.org/

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
  ice: add TX clock (TXC) DPLL interface for E825 devices
  ice: implement CPI support for E825C
  ice: add Tx reference clock index handling to AN restart command
  ice: add TX reference clock (tx_clk) control for E825 devices

 Documentation/netlink/specs/dpll.yaml         |   3 +
 drivers/dpll/dpll_core.c                      |  32 +-
 drivers/dpll/dpll_core.h                      |   2 +-
 drivers/dpll/dpll_netlink.c                   |  10 +-
 drivers/dpll/dpll_netlink.h                   |   4 +-
 drivers/dpll/dpll_nl.c                        |   2 +-
 drivers/dpll/zl3073x/prop.c                   |   9 +
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 347 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  69 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 327 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  22 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  34 ++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 237 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  41 +++
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 25 files changed, 1163 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
-- 
2.39.3

