Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DEAF531EA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 03:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 751B761093;
	Tue, 14 Apr 2026 03:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjkS2hbFLHY6; Tue, 14 Apr 2026 03:16:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE7A061C0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776136588;
	bh=NJZZDOeKs+eYHOJLGcbaPOum6lHmyH5zse+nopGhTqI=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tS4H9tzb4ONayuDp+hv4/slzyIfJb5Vxl0FM2usq0bmIdzrm1+TcSxxxaqwLuJtWi
	 P2lMLmPvFC6P8Y+BGvBZT+e/TA/sq8DwzegK8MHeAC2aiuRIDxlvehLM3O8AFNj6kr
	 hkQBAmwKAfTh1mcwFFZmKDnXSXj+IcVXBiOMcTxgW93R81eBxyVS2XSoqJdB2P/eJ6
	 xGZhMb9jyy8V455HNupBC+QHE3YzvyRtm8G9eE7noL9UyVFDvRFLGX5XcmDdO4IPdR
	 yWO56SdlEYKfICDkzsKHZAQTDnrDJOxZB/STtQxBTEENgt7PieCvVIXT4UEjvCFWSO
	 XOzS+U3ofsyRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE7A061C0E;
	Tue, 14 Apr 2026 03:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39225283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 03:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AEC861C0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 03:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLYzd_wPvIzC for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 03:16:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 15B9961093
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15B9961093
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15B9961093
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 03:16:24 +0000 (UTC)
X-CSE-ConnectionGUID: MOWBZvw7Tj+rI0PUiJJHwg==
X-CSE-MsgGUID: MzMVW0ynTUm4cbMsZge76A==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87706563"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; d="scan'208";a="87706563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 20:16:24 -0700
X-CSE-ConnectionGUID: p1/4XYGlSN6pBnEUjOedkg==
X-CSE-MsgGUID: MJYetiEoTGqwlYG4dp6yxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; d="scan'208";a="226795510"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
 by fmviesa007.fm.intel.com with ESMTP; 13 Apr 2026 20:16:23 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jay.bhat@intel.com,
 ivan.d.barrera@intel.com, aleksandr.loktionov@intel.com,
 larysa.zaremba@intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-pci@vger.kernel.org, madhu.chittim@intel.com, decot@google.com,
 willemb@google.com, sheenamo@google.com, lukas@wunner.de
Date: Mon, 13 Apr 2026 20:16:29 -0700
Message-Id: <20260414031631.2107-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776136585; x=1807672585;
 h=from:to:cc:subject:date:message-id;
 bh=oKTYqYhLv/KKCwdvRpI6OjNnIIZ57VjTfvU9UFl192A=;
 b=ctbYPGaZihQb33jmClAiXzTDzWpI4+F9DxdNdkbdc0wBQbVwTME48DJ7
 uDIjOQYGTvlZbHMH/5VvguUTQgjuIC5wRRmHA8Aev0CzpNrBpS8MHWqNZ
 TNzE5Nq1ozFgg3GoRoVN3+sabisdc6r9vCfzZ4EpKrjOMOOBjNNbXvT0F
 DfWHRYIppI+0Rmdlgx0a1lggn+Hp7gNlP+kHYSDjtLRItETQZRRyNk8nc
 f+m33Pdnrv5LI7y+FlS9FHvCTA9s/egvNQ6u+qAX2UFKWBBBvwepfouEx
 gAC+L8C485hTTr/iftt0m3CWoSWZGymtSGF7h6Ky8u5yGT92lIgr74l8c
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ctbYPGaZ
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/2] Introduce IDPF PCI
 callbacks
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

This series implements PCI callbacks for the purpose of handling FLR and
PCI errors in the IDPF driver.

The first patch removes the conditional deinitialization of the mailbox in
the idpf_vc_core_deinit() function. Aside from being redundant, due to the
shutdown of the mailbox after a reset is detected, the check was also
preventing the driver from sending messages to stop and disable the vports
and queues on FW side, which is needed for the prepare phase of the FLR
handling.

The second patch implements the PCI callbacks. The logic here follows
the reset handling done in idpf_init_hard_reset(), but is split in
prepare and resume phases, where idpf_reset_prepare() stops all driver
operations and the resume callback attempt to recover following the
reset or the PCI error event.

Testing hints:
1. FLR via sysfs:
echo 1 > /sys/class/net/<ifname>/device/reset

Previously this would have been handled by idpf_init_hard_reset() as the
driver detects the reset. Now it will be done by the PCI err callbacks,
so this is the easiest way to test the reset_prepare/resume path.

2. PCI errors can be tested with aer-inject:
./aer-inject -s 83:00.0 examples/<error_type>

3. Stress testing can be done by combining various callbacks with the
reset from step 1:
echo 1 > /sys/class/net/<if>/device/reset& ethtool -L <if> combined 8
ethtool -L <if> combined 16& echo 1 > /sys/class/net/<if>/device/reset

Changelog:
v1->v2:
- Removed the call to pci_save_state() from idpf_pci_err_slot_reset(),
  as it is no longer needed after pci_restore_state(). Suggested by
  Lukas Wunner.

v1:
https://lore.kernel.org/netdev/20260411003959.30959-1-emil.s.tantilov@intel.com/

Emil Tantilov (2):
  idpf: remove conditonal MBX deinit from idpf_vc_core_deinit()
  idpf: implement pci error handlers

 drivers/net/ethernet/intel/idpf/idpf.h        |   3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 112 ++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  11 +-
 4 files changed, 127 insertions(+), 12 deletions(-)

-- 
2.37.3

