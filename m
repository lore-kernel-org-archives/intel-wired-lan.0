Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F254BC79FB9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 12:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A611B60607;
	Thu, 10 Sep 2026 12:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DgEusfC6eOo9; Thu, 10 Sep 2026 12:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3E4E060751
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789045032;
	b=jdVnbdI6gglY9C/RaHNLJ9R8NKFvR/AfKBxfo63/C3a5WBAj6EdT+tKFlxtsJZzbkZra
	 5zwj3LiNgFOExmwVR1BIjshEWHUgLoQMayj7CG0Iwg/3HGbSK9el1FlcSm8VCDBH8/DNe
	 Br6AnNvv3Nrl/yiANtMzfeoXkYmxMc8qj86zlaGZo6KNprLtIBf9C5x6ubL/+iTm4BHh2
	 KxxFxtuTZEq5TX8FTUArlAaZB03EHZ+fHkTMxnJCXioO37SRXX4GgGFOMUl0nm3GVe+ig
	 pNINNlCl9si29SXqWm14Hqi/sXmpAPi/BmLDCJk4+lRZwMmL98Spc/qR/QI9CucrpuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789045032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cCebhV4yF0/r8HLMHKKW9E0SW60BVP7LrsYWv44F6II=;
	b=YtmJwDD9CfRXGjDznibkdxljcrur8csw7RxEGkfMfJ3wj1ti+y+IdtkK4A0tfZoiu9pS
	 kaOix2ugqiF+wkSmHef+JNIFY1IeqqYjERG8dvs7Aqh7pIyxXdi/JBnXx2PWQGBC9sCmG
	 IpZnb+CZUwFI0ez7d1kBwQVvDhV/jSKvyHS0pXuXSgghzsXb8ELgbh4/dsYNhnLIomEWK
	 Kiv5oqLtUlFLkuzjKW446Q4JuqPttZBNpasnGTPLMrm2YL9/fKXoxoVcknrxShuuBgu8P
	 ko+eayA45jI1cUUCJYPWlxeXSaWKTZ0MhvqCORdBh9JlkyLfNZZLiTrWTEDHETqKXeg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GangSAti;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789045032;
	bh=cCebhV4yF0/r8HLMHKKW9E0SW60BVP7LrsYWv44F6II=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bYX1vMpIGbwGrq1PBaUpW4WOcR2CqY78N9mRZ76jtf5ObFb+AvLweQxtm6lfxNBp5
	 WdlUscTgjC8kbH/4QE10mw5I6NsAMdj67IbcxH3/kRSuZuke3TmuNNDCCPdzrUt91B
	 TCk4PjTPQmVgiyT/MZNWONcO4B1Q8wMGVXowghp2zQRN2+Q6MiET6GrzJqre2hMgzp
	 eDfp4IcV+sZEprEku21+FAW8xpzAAxtUvDfZ87cASSP8XCP4rsLVgtBbSDsXlsbEAR
	 TEH1lwsG0tJ4OoH6meKJNN5zx/sPwrDwsruF86wGNnegdO0DIcOZUx4WhAX5IepkCg
	 FHlkycunab9EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E4E060751;
	Thu, 10 Sep 2026 12:57:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B5AD268
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 12:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26C4C60751
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 12:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WPOVlOQWWfz for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 12:57:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1D82760607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789045029;
 b=SaXaGZns7iAGD+hVIArsCH/kQOBjdbnypdQz1T6GHYWsVrBIgZy5wbiTBXacck/BE7IC
 EOhkBzsucpu+xP72IhO/gO42sEvJzweYbJ2zwSKnYkzhCXSELpA1gVJTLZgu8CsvW6XHx
 W0yKLUyG/J8Ail0j1mBMMhB0wZLbo+usYoGQ04V9YqdrYL03EwIJuGTKF2t6Kh8OBGm74
 0T/3iCHvbW+WlhLhxBWQ9Y2pUTj0qMyRnzQlT7EudrKq29LSP2JfZFGd9fBAN8MM+SOXL
 Oa6P3KvYCTWhRTsaIQ6ZRXzy5lm4CYsBBY07hfxcOWxjAdREYcipv4iIYz4q3yVpaNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789045029;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:Received:
 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=cCebhV4yF0/r8HLMHKKW9E0SW60BVP7LrsYWv44F6II=;
 b=eKN03ltzoP9armzPQUAdfx9DUJ1a0EA4O9MxiWVk37DTe+m62hVAJU+i+Vz6BeXMOxvi
 sDcxvl8pek63jdBOhvU2AJH5krOYu7kQVpt+BXeG2siRLvpBPLPnPd+SJVS0psBdx1R8M
 FnIqfCzqZ7lDm7UW70PKDcmh3O74qmcSgXafpuOxeJmcAVHrWR+J3QrQUTaIzjG+05C8B
 Wi/j4NbA5VPP+X9lpbMji9HOq2oRwsJsZXo7TqHV5JqOk4nBB90Ja8yB3knzVtKnwSK7W
 4vzPJ7i14Y5QP5Aq+jJcVGf9jXnSdlWujcy85cIHNh82any1DquPyv0kE/0lx+vyKIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GangSAti; 
 arc=none smtp.remote-ip=192.198.163.4
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 12:57:09 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GangSAti
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D82760607
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789045029; x=1820581029;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oLpPNk/HL1Lg3ftMGknmbBgpOinSLmnp8kpfUF+gnkU=;
 b=GangSAtie4wcFFc2d/X4u8bT/bWJZTyxfT8Q9FnydNBGVQX7dmQhLhDX
 FVYRRxHAm8p5ynPRg5koJ9cbeA+7H+G4jvH1a5XQZDjEGjWG0mrhFndF8
 7kcpmasCFeeZUs5bwAF0fAK0hCkHFsZvq0YwIRMe06u/L2kmuicl4iUpI
 +DXTayu3BmY+jqnYKMUG/1X7wgb5v8G9Jv84u/OZOXOcSXE8NWpyvzuXn
 zdManwsHBUvQp0V/76ydu/yAOT1WBTktqGO6d1M3HjMOsK3S+lj25hneJ
 yNBuB9/MXPIleWhegsy0RXMB3/+/2Syeh3d05xryccwoaeyXSmBTEnikx g==;
X-CSE-ConnectionGUID: kD8vW/NMTXC2wGqLA++WcQ==
X-CSE-MsgGUID: yURk5MIOSwKEQELuP8vCNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="12266"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="12266"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:56:06 -0700
X-CSE-ConnectionGUID: jju+FT70QV2YmFAzU3+lXA==
X-CSE-MsgGUID: ixHzq8C4Re6u/7U4gcIrZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="296596498"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
 by fmviesa001.fm.intel.com with ESMTP; 10 Sep 2026 05:56:02 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
 aleksandr.loktionov@intel.com, horms@kernel.org, grzegorz.nitka@intel.com,
 vgrinber@redhat.com, zoltan.fodor@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [iwl-next v13] ice: add support for unmanaged DPLL on E830 NIC
Date: Thu, 10 Sep 2026 14:49:05 +0200
Message-ID: <20260910124905.2890901-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hardware variants of E830 may support an unmanaged DPLL where the
configuration is hardcoded within the hardware and firmware, meaning
users cannot modify settings. However, users are able to check the DPLL
lock status and obtain configuration information through the Linux DPLL
and devlink health subsystem.

Availability of 'loss of lock' health status code determines if such
support is available, if true, register single DPLL device with 1 input
and 2 outputs and provide hardcoded/read only properties of a pin and
DPLL device. User is only allowed to check DPLL device status and receive
notifications on DPLL lock status change.

When present, the DPLL device locks to an external signal provided
through the PCIe/OCP pin. The expected input signal is 1PPS
(1 Pulse Per Second) embedded on a 10MHz reference clock.
The DPLL produces output:
- for MAC (Media Access Control) & PHY (Physical Layer) clocks,
- 1PPS for synchronization of onboard PHC (Precision Hardware Clock) timer.

v13:
- Close TOCTOU race between health-event gate and unmanaged dpll teardown.
- Initialize health_notify_rwsem once, not on every devlink reload.
- Check hardware family before probing for unmanaged dpll support.
- Log when health status code count is truncated.
- Document @unmanaged and @health_notify_rwsem.
- Clean up LOSS_OF_LOCK health status table entry.
- Document that unmanaged lock-state tracking is event-driven only.
- Fix double init/destroy of pf->dplls.lock in the unmanaged path.
- Fix UAF race between health-status notify and dpll teardown.
- Don't register phase-offset-monitor ops for unmanaged dpll.
- Reject zero pin count in ice_dpll_init_info_direct_pins().
- Gate unmanaged DPLL detection to E830 hardware.
- Use firmware-reported health_status_count instead of a fixed scan.
- Remove unused/duplicate unmanaged-DPLL helper code.
- Comment the default-locked semantics for unmanaged dpll.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 .../device_drivers/ethernet/intel/ice.rst     |  80 ++++
 .../net/ethernet/intel/ice/devlink/health.c   |   6 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 168 ++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 369 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  24 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |  33 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  34 ++
 9 files changed, 708 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 0bca293cf9cb..82b3ccc7027e 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -941,6 +941,86 @@ To see input signal on those PTP pins, you need to configure DPLL properly.
 Output signal is only visible on DPLL and to send it to the board SMA/U.FL pins,
 DPLL output pins have to be manually configured.
 
+Unmanaged DPLL Support
+----------------------
+Hardware variants of E830 may support an unmanaged DPLL:
+
+- Intel(R) Ethernet Network Adapter E830-XXVDA8F for OCP 3.0,
+
+- Intel(R) Ethernet Network Adapter E830-XXVDA4F.
+
+In the case of the unmanaged DPLL, the configuration is hardcoded within the
+hardware and firmware, meaning users cannot modify settings. However,
+users can check the DPLL lock status and obtain configuration information
+through the Linux DPLL subsystem.
+
+When present, the DPLL device locks to an external signal provided through the
+PCIe/OCP pin. The expected input signal is 1PPS (1 Pulse Per Second) embedded
+on a 10MHz reference clock.
+The DPLL produces output:
+
+- for MAC (Media Access Control) & PHY (Physical Layer) clocks,
+
+- 1PPS for synchronization of onboard PHC (Precision Hardware Clock) timer.
+
+Example output of querying the Linux DPLL subsystem can be found below.
+
+.. code-block:: console
+  :caption: Dumping the DPLL pins
+
+  $ <ynl> --spec Documentation/netlink/specs/dpll.yaml --dump pin-get
+  [{'board-label': '1588-TIME_SYNC',
+    'capabilities': set(),
+    'clock-id': 282574471561216,
+    'esync-frequency': 1,
+    'esync-frequency-supported': [{'frequency-max': 1, 'frequency-min': 1}],
+    'esync-pulse': 25,
+    'frequency': 10000000,
+    'id': 13,
+    'module-name': 'ice',
+    'parent-device': [{'direction': 'input',
+                       'parent-id': 6,
+                       'state': 'connected'}],
+    'phase-adjust-max': 0,
+    'phase-adjust-min': 0,
+    'type': 'ext'},
+    {'board-label': 'MAC-PHY-CLK',
+      'capabilities': set(),
+    'clock-id': 282574471561216,
+    'frequency': 156250000,
+    'id': 14,
+    'module-name': 'ice',
+    'parent-device': [{'direction': 'output',
+                       'parent-id': 6,
+                       'state': 'connected'}],
+    'phase-adjust-max': 0,
+    'phase-adjust-min': 0,
+    'type': 'synce-eth-port'},
+  {'board-label': '1588-TIME_REF',
+    'capabilities': set(),
+    'clock-id': 282574471561216,
+    'frequency': 1,
+    'id': 15,
+    'module-name': 'ice',
+    'parent-device': [{'direction': 'output',
+                       'parent-id': 6,
+                       'state': 'connected'}],
+    'phase-adjust-max': 0,
+    'phase-adjust-min': 0,
+    'type': 'int-oscillator'}]
+
+.. code-block:: console
+  :caption: Dumping the DPLL devices
+
+  $ <ynl> --spec Documentation/netlink/specs/dpll.yaml --dump device-get
+  [{'clock-id': 282574471561216,
+    'id': 6,
+    'lock-status': 'locked',
+    'mode': 'manual',
+    'mode-supported': ['manual'],
+    'module-name': 'ice',
+    'type': 'pps'}]
+
 GNSS module
 -----------
 Requires kernel compiled with CONFIG_GNSS=y or CONFIG_GNSS=m.
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index 8e9a8a8178d4..9e31c82e5fa5 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -101,6 +101,8 @@ static const struct ice_health_status ice_health_status_lookup[] = {
 		"Supplied MIB file is invalid. DCB reverted to default configuration.",
 		"Disable FW-LLDP and check DCBx system configuration.",
 		{ice_port_number_label, "MIB ID"}},
+	{ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK, "Local DPLL lock status changed.",
+		NULL, {"DPLL Lock Status"}},
 };
 
 static int ice_health_status_lookup_compare(const void *a, const void *b)
@@ -242,6 +244,10 @@ void ice_process_health_status_event(struct ice_pf *pf, struct ice_rq_event_info
 				pf->health_reporters.fw_status = *health_info;
 				devlink_health_report(pf->health_reporters.fw,
 						      "FW syndrome reported", NULL);
+				if (status_code == ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK &&
+				    test_bit(ICE_FLAG_DPLL, pf->flags) &&
+				    pf->dplls.unmanaged)
+					ice_dpll_lock_state_set_unmanaged(pf, health_info, true);
 				break;
 			case ICE_AQC_HEALTH_STATUS_PF:
 			case ICE_AQC_HEALTH_STATUS_PORT:
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 77ac8382f490..3c013c1b9b63 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1505,6 +1505,7 @@ struct ice_aqc_get_link_topo {
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575		0x21
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL30632_80032	0x24
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_SI5383_5384	0x25
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640		0x27
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_E822_PHY		0x30
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827		0x31
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX	0x47
@@ -2856,11 +2857,14 @@ enum ice_aqc_health_status {
 	ICE_AQC_HEALTH_STATUS_ERR_BMC_RESET			= 0x50B,
 	ICE_AQC_HEALTH_STATUS_ERR_LAST_MNG_FAIL			= 0x50C,
 	ICE_AQC_HEALTH_STATUS_ERR_RESOURCE_ALLOC_FAIL		= 0x50D,
+	ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK			= 0x601,
 	ICE_AQC_HEALTH_STATUS_ERR_FW_LOOP			= 0x1000,
 	ICE_AQC_HEALTH_STATUS_ERR_FW_PFR_FAIL			= 0x1001,
 	ICE_AQC_HEALTH_STATUS_ERR_LAST_FAIL_AQ			= 0x1002,
 };
 
+#define ICE_AQC_HEALTH_STATUS_CODE_NUM				64
+
 /* Get Health Status (indirect 0xFF22) */
 struct ice_aqc_get_health_status {
 	__le16 health_status_count;
@@ -2887,6 +2891,13 @@ struct ice_aqc_health_status_elem {
 	__le32 internal_data2;
 };
 
+/* Get Health Status response buffer entry, (0xFF21)
+ * repeated per reported health status
+ */
+struct ice_aqc_health_status_supp_elem {
+	__le16 health_status_code;
+};
+
 /* Admin Queue command opcodes */
 enum ice_adminq_opc {
 	/* AQ commands */
@@ -3066,6 +3077,7 @@ enum ice_adminq_opc {
 
 	/* System Diagnostic commands */
 	ice_aqc_opc_set_health_status_cfg		= 0xFF20,
+	ice_aqc_opc_get_supported_health_status_codes	= 0xFF21,
 	ice_aqc_opc_get_health_status			= 0xFF22,
 
 	/* FW Logging Commands */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index da8a6f592b6f..433b52bc4498 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3053,6 +3053,29 @@ bool ice_is_cgu_in_netlist(struct ice_hw *hw)
 	return false;
 }
 
+/**
+ * ice_is_unmanaged_cgu_in_netlist - check for unmanaged CGU presence
+ * @hw: pointer to the hw struct
+ *
+ * Check if the unmanaged Clock Generation Unit (CGU) device is present in the netlist.
+ * Save the CGU part number in the hw structure for later use.
+ * Return:
+ * * true - unmanaged cgu is present
+ * * false - unmanaged cgu is not present
+ */
+bool ice_is_unmanaged_cgu_in_netlist(struct ice_hw *hw)
+{
+	if (!ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
+				   ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
+				   ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640,
+				   NULL)) {
+		hw->cgu_part_number = ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * ice_is_gps_in_netlist
  * @hw: pointer to the hw struct
@@ -6317,6 +6340,151 @@ bool ice_is_fw_health_report_supported(struct ice_hw *hw)
 				     ICE_FW_API_HEALTH_REPORT_PATCH);
 }
 
+/**
+ * ice_aq_get_health_status_supported - get supported health status codes
+ * @hw: pointer to the HW struct
+ * @buff: pointer to buffer where health status elements will be stored
+ * @num: number of health status elements buffer can hold
+ * @count: on success, set to the number of elements firmware reported
+ *
+ * Return:
+ * * 0 - success,
+ * * negative - AQ error code.
+ */
+static int
+ice_aq_get_health_status_supported(struct ice_hw *hw,
+				   struct ice_aqc_health_status_supp_elem *buff,
+				   int num, u16 *count)
+{
+	u16 code = ice_aqc_opc_get_supported_health_status_codes;
+	const struct ice_aqc_get_health_status *cmd;
+	struct libie_aq_desc desc;
+	int ret;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, code);
+
+	ret = ice_aq_send_cmd(hw, &desc, buff, num * sizeof(*buff), NULL);
+	if (!ret) {
+		cmd = libie_aq_raw(&desc);
+		*count = le16_to_cpu(cmd->health_status_count);
+	}
+
+	return ret;
+}
+
+/**
+ * ice_aq_get_health_status - get current health status array from the firmware
+ * @hw: pointer to the HW struct
+ * @buff: pointer to buffer where health status elements will be stored
+ * @num: number of health status elements buffer can hold
+ * @count: on success, set to the number of elements firmware reported
+ *
+ * Return:
+ * * 0 - success,
+ * * negative - AQ error code.
+ */
+static int
+ice_aq_get_health_status(struct ice_hw *hw,
+			 struct ice_aqc_health_status_elem *buff, int num,
+			 u16 *count)
+{
+	const struct ice_aqc_get_health_status *cmd;
+	struct libie_aq_desc desc;
+	int ret;
+
+	ice_fill_dflt_direct_cmd_desc(&desc,
+				      ice_aqc_opc_get_health_status);
+
+	ret = ice_aq_send_cmd(hw, &desc, buff, num * sizeof(*buff), NULL);
+	if (!ret) {
+		cmd = libie_aq_raw(&desc);
+		*count = le16_to_cpu(cmd->health_status_count);
+	}
+
+	return ret;
+}
+
+/**
+ * ice_is_health_status_code_supported - check if health status code is supported
+ * @hw: pointer to the hardware structure
+ * @code: health status code to check
+ * @supported: pointer to boolean result
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
+					bool *supported)
+{
+	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
+	struct ice_aqc_health_status_supp_elem *buff;
+	u16 count;
+	int ret;
+
+	*supported = false;
+	buff = kzalloc_objs(*buff, BUFF_SIZE);
+	if (!buff)
+		return -ENOMEM;
+	ret = ice_aq_get_health_status_supported(hw, buff, BUFF_SIZE, &count);
+	if (ret)
+		goto free_buff;
+	if (count > BUFF_SIZE)
+		dev_dbg(ice_hw_to_dev(hw),
+			"health status supported-code count %u truncated to %u\n",
+			count, BUFF_SIZE);
+	count = min_t(u16, count, BUFF_SIZE);
+	for (int i = 0; i < count; i++)
+		if (le16_to_cpu(buff[i].health_status_code) == code) {
+			*supported = true;
+			break;
+		}
+
+free_buff:
+	kfree(buff);
+	return ret;
+}
+
+/**
+ * ice_get_last_health_status_code - get last health status for given code
+ * @hw: pointer to the hardware structure
+ * @out: pointer to the health status struct to be filled
+ * @code: health status code to check
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int ice_get_last_health_status_code(struct ice_hw *hw,
+				    struct ice_aqc_health_status_elem *out,
+				    u16 code)
+{
+	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
+	struct ice_aqc_health_status_elem *buff;
+	int ret, last_status = -1;
+	u16 count;
+
+	buff = kzalloc_objs(*buff, BUFF_SIZE);
+	if (!buff)
+		return -ENOMEM;
+	ret = ice_aq_get_health_status(hw, buff, BUFF_SIZE, &count);
+	if (ret)
+		goto free_buff;
+	if (count > BUFF_SIZE)
+		dev_dbg(ice_hw_to_dev(hw),
+			"health status code count %u truncated to %u\n",
+			count, BUFF_SIZE);
+	count = min_t(u16, count, BUFF_SIZE);
+	for (int i = 0; i < count; i++)
+		if (le16_to_cpu(buff[i].health_status_code) == code)
+			last_status = i;
+
+	if (last_status >= 0)
+		memcpy(out, &buff[last_status], sizeof(*out));
+	else
+		memset(out, 0, sizeof(*out));
+
+free_buff:
+	kfree(buff);
+	return ret;
+}
+
 /**
  * ice_aq_set_health_status_cfg - Configure FW health events
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index d1d674ca644f..4ca3f5edcb92 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -162,6 +162,7 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 bool ice_is_phy_rclk_in_netlist(struct ice_hw *hw);
 bool ice_is_clock_mux_in_netlist(struct ice_hw *hw);
 bool ice_is_cgu_in_netlist(struct ice_hw *hw);
+bool ice_is_unmanaged_cgu_in_netlist(struct ice_hw *hw);
 bool ice_is_gps_in_netlist(struct ice_hw *hw);
 int
 ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
@@ -188,6 +189,11 @@ ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
 bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
 bool ice_is_fw_health_report_supported(struct ice_hw *hw);
+int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
+					bool *supported);
+int ice_get_last_health_status_code(struct ice_hw *hw,
+				    struct ice_aqc_health_status_elem *out,
+				    u16 code);
 int ice_aq_set_health_status_cfg(struct ice_hw *hw, u8 event_source);
 int ice_aq_get_phy_equalization(struct ice_hw *hw, u16 data_in, u16 op_code,
 				u8 serdes_num, int *output);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 759aee5628c3..f8c511bcc983 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -19,6 +19,7 @@
 #define ICE_DPLL_SW_PIN_INPUT_BASE_SFP		4
 #define ICE_DPLL_SW_PIN_INPUT_BASE_QSFP		6
 #define ICE_DPLL_SW_PIN_OUTPUT_BASE		0
+#define ICE_DPLL_HEALTH_STATUS_LOCKED		1
 
 #define E825_RCLK_PARENT_0_PIN_IDX		0
 #define E825_RCLK_PARENT_1_PIN_IDX		1
@@ -115,6 +116,10 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
  *+----------------+-------------+------------+------------+
  */
 
+static const struct dpll_pin_frequency ice_esync_range_unmanaged[] = {
+	DPLL_PIN_FREQUENCY_1PPS,
+};
+
 /**
  * ice_dpll_is_sw_pin - check if given pin shall be controlled by SW
  * @pf: private board structure
@@ -1180,9 +1185,11 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
 		return -EBUSY;
 
 	mutex_lock(&pf->dplls.lock);
-	ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
-	if (ret)
-		goto unlock;
+	if (!pf->dplls.unmanaged) {
+		ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
+		if (ret)
+			goto unlock;
+	}
 	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT ||
 	    pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
 		*state = p->state[d->dpll_idx];
@@ -2596,9 +2603,14 @@ ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
 		mutex_unlock(&pf->dplls.lock);
 		return -EOPNOTSUPP;
 	}
-	esync->range = ice_esync_range;
-	esync->range_num = ARRAY_SIZE(ice_esync_range);
-	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
+	if (pf->dplls.unmanaged) {
+		esync->range = ice_esync_range_unmanaged;
+		esync->range_num = ARRAY_SIZE(ice_esync_range_unmanaged);
+	} else {
+		esync->range = ice_esync_range;
+		esync->range_num = ARRAY_SIZE(ice_esync_range);
+	}
+	if (p->flags[0] & ICE_DPLL_IN_ESYNC_ENABLED) {
 		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
 		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
 	} else {
@@ -3353,6 +3365,19 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 	.esync_get = ice_dpll_output_esync_get,
 };
 
+static const struct dpll_pin_ops ice_dpll_input_unmanaged_ops = {
+	.frequency_get = ice_dpll_input_frequency_get,
+	.direction_get = ice_dpll_input_direction,
+	.state_on_dpll_get = ice_dpll_input_state_get,
+	.esync_get = ice_dpll_input_esync_get,
+};
+
+static const struct dpll_pin_ops ice_dpll_output_unmanaged_ops = {
+	.frequency_get = ice_dpll_output_frequency_get,
+	.direction_get = ice_dpll_output_direction,
+	.state_on_dpll_get = ice_dpll_output_state_get,
+};
+
 static const struct dpll_device_ops ice_dpll_ops = {
 	.lock_status_get = ice_dpll_lock_status_get,
 	.mode_get = ice_dpll_mode_get,
@@ -4046,8 +4071,10 @@ ice_dpll_deinit_direct_pins(struct ice_pf *pf, bool cgu,
 			    struct dpll_device *second)
 {
 	if (cgu) {
-		ice_dpll_unregister_pins(first, pins, ops, count);
-		ice_dpll_unregister_pins(second, pins, ops, count);
+		if (first)
+			ice_dpll_unregister_pins(first, pins, ops, count);
+		if (second)
+			ice_dpll_unregister_pins(second, pins, ops, count);
 	}
 	ice_dpll_release_pins(pins, count);
 }
@@ -4079,12 +4106,15 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
 	int ret;
 
 	ret = ice_dpll_get_pins(pf, pins, start_idx, count, pf->dplls.clock_id);
-	if (ret)
+	if (!cgu || ret)
 		return ret;
-	if (cgu) {
+
+	if (first) {
 		ret = ice_dpll_register_pins(first, pins, ops, count);
 		if (ret)
 			goto release_pins;
+	}
+	if (second) {
 		ret = ice_dpll_register_pins(second, pins, ops, count);
 		if (ret)
 			goto unregister_first;
@@ -4093,7 +4123,8 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
 	return 0;
 
 unregister_first:
-	ice_dpll_unregister_pins(first, pins, ops, count);
+	if (first)
+		ice_dpll_unregister_pins(first, pins, ops, count);
 release_pins:
 	ice_dpll_release_pins(pins, count);
 	return ret;
@@ -4474,6 +4505,18 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 	struct ice_dpll *de = &d->eec;
 	struct ice_dpll *dp = &d->pps;
 
+	if (d->unmanaged) {
+		ice_dpll_unregister_pins(dp->dpll, inputs,
+					 &ice_dpll_input_unmanaged_ops,
+					 num_inputs);
+		ice_dpll_unregister_pins(dp->dpll, outputs,
+					 &ice_dpll_output_unmanaged_ops,
+					 num_outputs);
+		ice_dpll_release_pins(inputs, num_inputs);
+		ice_dpll_release_pins(outputs, num_outputs);
+		return;
+	}
+
 	ice_dpll_deinit_rclk_pin(pf);
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		if (ice_pf_src_tmr_owned(pf) &&
@@ -4798,23 +4841,29 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 	const struct dpll_pin_ops *input_ops;
 	int ret, count;
 
-	input_ops = &ice_dpll_input_ops;
-	output_ops = &ice_dpll_output_ops;
+	if (!pf->dplls.unmanaged) {
+		input_ops = &ice_dpll_input_ops;
+		output_ops = &ice_dpll_output_ops;
+	} else {
+		input_ops = &ice_dpll_input_unmanaged_ops;
+		output_ops = &ice_dpll_output_unmanaged_ops;
+	}
 
 	ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.inputs, 0,
 					pf->dplls.num_inputs, input_ops,
-					pf->dplls.eec.dpll,
-					pf->dplls.pps.dpll);
+					pf->dplls.eec.dpll, pf->dplls.pps.dpll);
 	if (ret)
 		return ret;
 	count = pf->dplls.num_inputs;
-	if (cgu) {
+	if (cgu || pf->dplls.unmanaged) {
 		ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.outputs,
 						count, pf->dplls.num_outputs,
 						output_ops, pf->dplls.eec.dpll,
 						pf->dplls.pps.dpll);
 		if (ret)
 			goto deinit_inputs;
+		if (pf->dplls.unmanaged)
+			return 0;
 		count += pf->dplls.num_outputs;
 		if (!pf->dplls.generic) {
 			ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.sma,
@@ -4890,6 +4939,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 	if (cgu || pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
 		dpll_device_unregister(d->dpll, d->ops, d);
 	dpll_device_put(d->dpll, &d->tracker);
+	d->dpll = NULL;
 }
 
 /**
@@ -4922,12 +4972,14 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		return ret;
 	}
 	d->pf = pf;
-	if (cgu || pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
+	if (cgu || pf->dplls.unmanaged ||
+	    pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		const struct dpll_device_ops *ops = &ice_dpll_ops;
 
-		if (type == DPLL_TYPE_PPS && ice_dpll_is_pps_phase_monitor(pf))
+		if (type == DPLL_TYPE_PPS && !pf->dplls.unmanaged &&
+		    ice_dpll_is_pps_phase_monitor(pf))
 			ops =  &ice_dpll_pom_ops;
-		if (cgu)
+		if (cgu && !pf->dplls.unmanaged)
 			ice_dpll_update_state(pf, d, true);
 		ret = dpll_device_register(d->dpll, type, ops, d);
 		if (ret) {
@@ -4956,6 +5008,33 @@ static void ice_dpll_deinit_worker(struct ice_pf *pf)
 	d->kworker = NULL;
 }
 
+/**
+ * ice_dpll_pin_freq_info - find pin frequency from supported ones
+ * @hw: pointer to the hardware structure
+ * @pin_idx: pin index
+ * @input: if input pin
+ *
+ * This function searches through the array of supported frequencies for a
+ * DPLL pin and returns single frequency pin is capable, if pin support only
+ * one frequency. Shall be used only for dpll with driver hardcoded frequency.
+ *
+ * Return:
+ * * 0 - failure, pin uses multiple frequencies,
+ * * frequency - success.
+ */
+static u64 ice_dpll_pin_freq_info(struct ice_hw *hw, u8 pin_idx, bool input)
+{
+	struct dpll_pin_frequency *freqs;
+	u8 freq_num;
+
+	/* Get supported frequencies for this pin */
+	freqs = ice_cgu_get_pin_freq_supp(hw, pin_idx, input, &freq_num);
+	if (!freqs || freq_num != 1 || freqs[0].min != freqs[0].max)
+		return 0;
+
+	return freqs[0].min;
+}
+
 /**
  * ice_dpll_init_worker - Initialize DPLLs periodic worker
  * @pf: board private structure
@@ -5104,6 +5183,8 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	default:
 		return -EINVAL;
 	}
+	if (!num_pins)
+		return -EINVAL;
 	if (num_pins != ice_cgu_get_num_pins(hw, input)) {
 		pf->dplls.generic = true;
 		return ice_dpll_init_info_pins_generic(pf, input);
@@ -5115,6 +5196,19 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
 		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
 		if (input) {
+			if (pf->dplls.unmanaged) {
+				pins[i].freq = ice_dpll_pin_freq_info(hw, i,
+								      input);
+				pins[i].state[0] = DPLL_PIN_STATE_CONNECTED;
+				pins[i].status =
+					ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP;
+				pins[i].flags[0] = ICE_DPLL_IN_ESYNC_ENABLED;
+				/* skip priority, capabilities, phase range,
+				 * pin state AQ query and freq_supported -
+				 * not available for unmanaged DPLL
+				 */
+				continue;
+			}
 			ret = ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
 						      &de->input_prio[i]);
 			if (ret)
@@ -5128,6 +5222,16 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 			if (ice_dpll_is_sw_pin(pf, i, true))
 				pins[i].hidden = true;
 		} else {
+			if (pf->dplls.unmanaged) {
+				pins[i].freq = ice_dpll_pin_freq_info(hw, i,
+								      input);
+				pins[i].state[0] = DPLL_PIN_STATE_CONNECTED;
+				/* skip output state caps, phase range,
+				 * pin state AQ query and freq_supported -
+				 * not available for unmanaged DPLL
+				 */
+				continue;
+			}
 			ret = ice_cgu_get_output_pin_state_caps(hw, i, &caps);
 			if (ret)
 				return ret;
@@ -5145,10 +5249,13 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 		pins[i].prop.freq_supported_num = freq_supp_num;
 		pins[i].pf = pf;
 	}
-	if (input)
+	if (input && !pf->dplls.unmanaged) {
 		ret = ice_dpll_init_ref_sync_inputs(pf);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -5443,6 +5550,92 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	return ret;
 }
 
+/**
+ * ice_dpll_lock_state_init_unmanaged - initialize lock state for unmanaged dpll
+ * @pf: board private structure
+ *
+ * Initialize the lock state for unmanaged DPLL by checking health status.
+ * For unmanaged DPLL, we rely on hardware autonomous operation.
+ *
+ * This is the only place lock state is read back from firmware; after this
+ * one-time probe, state is updated exclusively by incoming
+ * ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK health-status events, handled via
+ * ice_process_health_status_event() -> ice_dpll_lock_state_set_unmanaged().
+ * There is intentionally no periodic re-poll and no re-arm of this state
+ * across resets (PFR/CORER/GLOBR/EMPR) or devlink reload: unmanaged mode is
+ * event-driven by design, matching hardware autonomous operation, and a
+ * missed event during a reset window is expected to be superseded by the
+ * next real lock-state transition once the device comes back up.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_lock_state_init_unmanaged(struct ice_pf *pf)
+{
+	u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
+	struct ice_aqc_health_status_elem buff;
+	int ret;
+
+	ret = ice_get_last_health_status_code(&pf->hw, &buff, code);
+	if (ret)
+		return ret;
+	ice_dpll_lock_state_set_unmanaged(pf, &buff, false);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_init_info_unmanaged - init dpll information for unmanaged dpll
+ * @pf: board private structure
+ *
+ * Acquire (from HW) and set basic dpll information (on pf->dplls struct).
+ * For unmanaged dpll mode.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_init_info_unmanaged(struct ice_pf *pf)
+{
+	struct ice_dplls *d = &pf->dplls;
+	int ret;
+
+	d->clock_id = ice_generate_clock_id(pf);
+	d->num_inputs = ice_cgu_get_num_pins(&pf->hw, true);
+	d->num_outputs = ice_cgu_get_num_pins(&pf->hw, false);
+	ret = ice_dpll_lock_state_init_unmanaged(pf);
+	if (ret)
+		return ret;
+	d->inputs = kzalloc_objs(*d->inputs, d->num_inputs);
+	if (!d->inputs)
+		return -ENOMEM;
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
+	if (ret)
+		goto deinit_info;
+
+	d->outputs = kzalloc_objs(*d->outputs, d->num_outputs);
+	if (!d->outputs) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_OUTPUT);
+	if (ret)
+		goto deinit_info;
+
+	d->pps.mode = DPLL_MODE_MANUAL;
+	dev_dbg(ice_pf_to_dev(pf), "%s - success, inputs:%u, outputs:%u\n",
+		__func__, d->num_inputs, d->num_outputs);
+	return 0;
+deinit_info:
+	dev_err(ice_pf_to_dev(pf), "%s - fail: d->inputs:%p, d->outputs:%p\n",
+		__func__, d->inputs, d->outputs);
+	ice_dpll_deinit_info(pf);
+	return ret;
+}
+
 /**
  * ice_dpll_init_info - prepare pf's dpll information structure
  * @pf: board private structure
@@ -5553,6 +5746,69 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	return ret;
 }
 
+/**
+ * ice_dpll_lock_state_set_unmanaged - determine lock state from health status
+ * @pf: board private structure
+ * @buff: health status buffer
+ * @notify: if true, notify dpll device
+ *
+ * Set unmanaged dpll lock state based on health status code and internal data.
+ * Context: Acquires and releases pf->dplls.lock (must release before notify
+ * if called). Holds pf->dplls.health_notify_rwsem for read across the whole
+ * function, including the out-of-lock notify call, so ice_dpll_deinit() can
+ * drain any in-flight caller before freeing the dpll device.
+ */
+void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				       const struct ice_aqc_health_status_elem *buff,
+				       bool notify)
+{
+	u32 internal_data = le32_to_cpu(buff->internal_data1);
+	struct ice_dpll *d = &pf->dplls.pps;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+
+	down_read(&pf->dplls.health_notify_rwsem);
+	mutex_lock(&pf->dplls.lock);
+	/* notify is only true for the devlink health-event path, which can
+	 * race with teardown. ice_dpll_deinit() clears ICE_FLAG_DPLL under
+	 * this same lock as its first step, before draining the write side
+	 * of health_notify_rwsem and before pins/dpll are freed. Re-checking
+	 * the flag here, after down_read() above, guarantees an event
+	 * racing with teardown either observes the flag still set (and is
+	 * then safely waited for by the drain before anything is freed) or
+	 * observes it cleared and bails out before touching d->dpll. The
+	 * probe-time caller (notify == false) runs before ICE_FLAG_DPLL is
+	 * ever set and does not need this check.
+	 */
+	if (notify && !test_bit(ICE_FLAG_DPLL, pf->flags)) {
+		mutex_unlock(&pf->dplls.lock);
+		up_read(&pf->dplls.health_notify_rwsem);
+		return;
+	}
+	/* Unmanaged dpll starts out locked (hardware autonomous operation);
+	 * health_status_code == 0 means no matching loss-of-lock health
+	 * status record was found. If loss of lock has never been
+	 * reported, means the dpll is locked. It only becomes unlocked
+	 * once a matching record is found with internal_data1 reporting
+	 * that.
+	 */
+	if (buff->health_status_code == 0 ||
+	    internal_data == ICE_DPLL_HEALTH_STATUS_LOCKED)
+		d->dpll_state = DPLL_LOCK_STATUS_LOCKED;
+	else
+		d->dpll_state = DPLL_LOCK_STATUS_UNLOCKED;
+
+	if (d->prev_dpll_state == d->dpll_state)
+		notify = false;
+	else
+		d->prev_dpll_state = d->dpll_state;
+	mutex_unlock(&pf->dplls.lock);
+	if (notify && d->dpll)
+		dpll_device_change_ntf(d->dpll);
+	up_read(&pf->dplls.health_notify_rwsem);
+}
+
 /**
  * ice_dpll_deinit - Disable the driver/HW support for dpll subsystem
  * the dpll device.
@@ -5587,15 +5843,25 @@ void ice_dpll_deinit(struct ice_pf *pf)
 		up_write(&pf->dplls.txclk_notify_rwsem);
 	}
 
+	/* Wait for in-flight ice_dpll_lock_state_set_unmanaged() readers,
+	 * e.g. a devlink health event handler racing with teardown, before
+	 * the pps dpll device and pins are freed below.
+	 */
+	if (pf->dplls.unmanaged) {
+		down_write(&pf->dplls.health_notify_rwsem);
+		up_write(&pf->dplls.health_notify_rwsem);
+	}
+
 	if (pf->dplls.kworker)
 		ice_dpll_deinit_worker(pf);
 
 	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
 		cancel_work_sync(&pf->dplls.txclk_work);
 
-	ice_dpll_deinit_pins(pf, cgu);
+	ice_dpll_deinit_pins(pf, cgu || pf->dplls.unmanaged);
 	if (!IS_ERR_OR_NULL(pf->dplls.pps.dpll))
-		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
+		ice_dpll_deinit_dpll(pf, &pf->dplls.pps,
+				     cgu || pf->dplls.unmanaged);
 	if (!IS_ERR_OR_NULL(pf->dplls.eec.dpll))
 		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
 	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
@@ -5606,6 +5872,47 @@ void ice_dpll_deinit(struct ice_pf *pf)
 	ice_dpll_deinit_info(pf);
 }
 
+/**
+ * ice_dpll_init_unmanaged - initialize support for unmanaged dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls for unmanaged mode, register them and pins connected
+ * within Linux dpll subsystem. Allow userspace to obtain state of DPLL.
+ *
+ * Context: pf->dplls.lock mutex and pf->dplls.health_notify_rwsem are
+ * initialized/destroyed by ice_init_features()/ice_deinit_features(), not by
+ * this function, since this function (and the whole DPLL subsystem) can be
+ * re-run on every devlink reload while pf and pf->dplls survive across
+ * reloads; re-initializing either one here would reset it out from under a
+ * reader/writer that is still using it.
+ */
+static void ice_dpll_init_unmanaged(struct ice_pf *pf)
+{
+	int err;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+	err = ice_dpll_init_info_unmanaged(pf);
+	if (err)
+		goto err_exit;
+	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, true, DPLL_TYPE_PPS);
+	if (err)
+		goto deinit_info;
+	err = ice_dpll_init_pins(pf, true);
+	if (err)
+		goto deinit_pps;
+	set_bit(ICE_FLAG_DPLL, pf->flags);
+
+	return;
+
+deinit_pps:
+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, true);
+deinit_info:
+	ice_dpll_deinit_info(pf);
+err_exit:
+	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
+}
+
 /**
  * ice_dpll_init_e825 - initialize support for dpll subsystem
  * @pf: board private structure
@@ -5733,8 +6040,24 @@ static void ice_dpll_init_e810(struct ice_pf *pf)
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
 
+/**
+ * ice_dpll_init - initialize support for dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls, register them and pins connected within Linux dpll
+ * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
+ * configuration requests.
+ *
+ * Context: pf->dplls.lock mutex is initialized/destroyed by
+ * ice_init_features()/ice_deinit_features(), not by this function.
+ */
 void ice_dpll_init(struct ice_pf *pf)
 {
+	if (pf->dplls.unmanaged) {
+		ice_dpll_init_unmanaged(pf);
+		return;
+	}
+
 	switch (pf->hw.mac_type) {
 	case ICE_MAC_GENERIC_3K_E825:
 		ice_dpll_init_e825(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index f7e6680d124c..4bf6a2d3a95e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -26,6 +26,7 @@
 #define ICE_CGU_R11_SYNCE_S_BYP_CLK	GENMASK(6, 1)
 
 #define ICE_CGU_BYPASS_MUX_OFFSET_E825C	3
+#define ICE_DPLL_IN_ESYNC_ENABLED	ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN
 
 /**
  * enum ice_dpll_pin_sw - enumerate ice software pin indices:
@@ -149,9 +150,14 @@ struct ice_dpll {
  * @output_phase_adj_max: max phase adjust value for an output pins
  * @periodic_counter: counter of periodic work executions
  * @generic: true when generic DPLL ops are used
+ * @unmanaged: true when dpll lock state is derived only from firmware
+ *             health-status events, with no ref-priority/state AQ
+ *             configuration support (E830 unmanaged CGU mode)
  * @txclk_work: deferred TX reference clock switch worker
  * @txclk_switch_requested: a TX ref clock switch is queued in @txclk_work
  * @txclk_notify_rwsem: drains in-flight TXCLK notifications on teardown
+ * @health_notify_rwsem: drains in-flight unmanaged dpll health-status
+ *                       notifications on teardown
  *
  * Locking:
  *   Acquisition order (top to bottom):
@@ -160,6 +166,9 @@ struct ice_dpll {
  *       -> pf->dplls.lock
  *         -> ctrl_pf->dplls.lock
  *
+ *     health_notify_rwsem (read)
+ *       -> pf->dplls.lock
+ *
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
@@ -170,6 +179,12 @@ struct ice_dpll {
  *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side
  *     standalone (not nested under any other lock) to drain in-flight
  *     readers before pins and the TXC DPLL device are freed.
+ *   - @health_notify_rwsem is held for read across
+ *     ice_dpll_lock_state_set_unmanaged(), including the out-of-lock
+ *     dpll_device_change_ntf() call. ice_dpll_deinit() clears
+ *     ICE_FLAG_DPLL first, then takes the write side standalone (not
+ *     nested under any other lock) to drain in-flight readers before
+ *     pins and the pps DPLL device are freed.
  */
 struct ice_dplls {
 	struct kthread_worker *kworker;
@@ -198,17 +213,26 @@ struct ice_dplls {
 	s32 output_phase_adj_max;
 	u32 periodic_counter;
 	bool generic;
+	bool unmanaged;
 	struct work_struct txclk_work;
 	bool txclk_switch_requested;
 	struct rw_semaphore txclk_notify_rwsem;
+	struct rw_semaphore health_notify_rwsem;
 };
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 void ice_dpll_init(struct ice_pf *pf);
 void ice_dpll_deinit(struct ice_pf *pf);
+void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				       const struct ice_aqc_health_status_elem *buff,
+				       bool notify);
 #else
 static inline void ice_dpll_init(struct ice_pf *pf) { }
 static inline void ice_dpll_deinit(struct ice_pf *pf) { }
+static inline void
+ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				  const struct ice_aqc_health_status_elem *buff,
+				  bool notify) { }
 #endif
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 880f95efc255..a35e3da63a0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4920,7 +4920,9 @@ void ice_deinit_dev(struct ice_pf *pf)
 
 static void ice_init_features(struct ice_pf *pf)
 {
+	u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
 	struct device *dev = ice_pf_to_dev(pf);
+	int err;
 
 	if (ice_is_safe_mode(pf))
 		return;
@@ -4933,6 +4935,15 @@ static void ice_init_features(struct ice_pf *pf)
 	 */
 	mutex_init(&pf->dplls.lock);
 
+	/* pf->dplls.health_notify_rwsem drains in-flight unmanaged dpll
+	 * health-status notifications on teardown. It must be initialized
+	 * exactly once here, not inside ice_dpll_init_unmanaged(), because
+	 * pf and pf->dplls survive devlink reload: re-initializing it on
+	 * every reload would reset it out from under a reader/writer still
+	 * using it from a previous load.
+	 */
+	init_rwsem(&pf->dplls.health_notify_rwsem);
+
 	/* initialize DDP driven features */
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		ice_ptp_init(pf);
@@ -4940,8 +4951,28 @@ static void ice_init_features(struct ice_pf *pf)
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
 
+	/* Initialize unmanaged DPLL detection. Check the cheap, purely local
+	 * conditions first and only issue the health-status-code AQ command
+	 * when they all hold, instead of doing an unconditional round trip
+	 * to firmware on hardware that can never support this mode.
+	 * ice_cgu_get_num_pins() also doubles as an E835 exclusion: E835
+	 * device IDs share ICE_MAC_E830 with true E830 parts but have no
+	 * entry in ice_cgu_get_pin_desc()'s switch, so it returns 0 pins
+	 * for them.
+	 */
+	pf->dplls.unmanaged = false;
+	if (pf->hw.mac_type == ICE_MAC_E830 &&
+	    ice_cgu_get_num_pins(&pf->hw, true) &&
+	    ice_is_unmanaged_cgu_in_netlist(&pf->hw)) {
+		err = ice_is_health_status_code_supported(&pf->hw, code,
+							  &pf->dplls.unmanaged);
+		if (err)
+			pf->dplls.unmanaged = false;
+	}
+
 	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
-	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
+	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK) ||
+	    pf->dplls.unmanaged)
 		ice_dpll_init(pf);
 
 	/* Note: Flow director init failure is non-fatal to load */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 881f002daa74..035d7a4a3c9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -20,6 +20,10 @@ static struct dpll_pin_frequency ice_cgu_pin_freq_10_mhz[] = {
 	DPLL_PIN_FREQUENCY_10MHZ,
 };
 
+static struct dpll_pin_frequency ice_cgu_pin_freq_156_25mhz[] = {
+	DPLL_PIN_FREQUENCY_RANGE(156250000, 156250000),
+};
+
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
 	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
@@ -131,6 +135,18 @@ static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] = {
 	{ "NONE",	   ZL_OUT5, 0, 0 },
 };
 
+static const struct ice_cgu_pin_desc ice_e830_unmanaged_inputs[] = {
+	{ "1588-TIME_SYNC", 0, DPLL_PIN_TYPE_EXT,
+	  ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
+};
+
+static const struct ice_cgu_pin_desc ice_e830_unmanaged_outputs[] = {
+	{ "MAC-PHY-CLK", 0, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+	  ARRAY_SIZE(ice_cgu_pin_freq_156_25mhz), ice_cgu_pin_freq_156_25mhz },
+	{ "1588-TIME_REF", 1, DPLL_PIN_TYPE_INT_OSCILLATOR,
+	  ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz},
+};
+
 /* Low level functions for interacting with and managing the device clock used
  * for the Precision Time Protocol.
  *
@@ -6003,6 +6019,24 @@ ice_cgu_get_pin_desc(struct ice_hw *hw, bool input, int *size)
 	case ICE_DEV_ID_E823C_SGMII:
 		t = ice_cgu_get_pin_desc_e823(hw, input, size);
 		break;
+	case ICE_DEV_ID_E830CC_BACKPLANE:
+	case ICE_DEV_ID_E830CC_QSFP56:
+	case ICE_DEV_ID_E830CC_SFP:
+	case ICE_DEV_ID_E830CC_SFP_DD:
+	case ICE_DEV_ID_E830C_BACKPLANE:
+	case ICE_DEV_ID_E830C_QSFP:
+	case ICE_DEV_ID_E830C_SFP:
+	case ICE_DEV_ID_E830_XXV_BACKPLANE:
+	case ICE_DEV_ID_E830_XXV_QSFP:
+	case ICE_DEV_ID_E830_XXV_SFP:
+		if (input) {
+			t = ice_e830_unmanaged_inputs;
+			*size = ARRAY_SIZE(ice_e830_unmanaged_inputs);
+		} else {
+			t = ice_e830_unmanaged_outputs;
+			*size = ARRAY_SIZE(ice_e830_unmanaged_outputs);
+		}
+		break;
 	default:
 		break;
 	}

base-commit: 400c836aa8bd83d194ab660c1afb5ce0f96823ca
-- 
2.47.0

