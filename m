Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9666C9832A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 15:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C75E80E0C;
	Tue, 29 Sep 2026 15:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HxiDpkce3YTd; Tue, 29 Sep 2026 15:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BE0B8809F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694742;
	b=ppafc8VrkdGn0epqVkJGh5MpuKBWUKEVtVH7pNuLZA7jYkR1/ChlEPJ62CzSwvuU7aos
	 dewYuINeA8EAbtnBrcSvAFBbIAeLM1Nu7AhNI6sxjCxQccM18Eb1a9M8Ex+98uONcLfME
	 PgSbMcXWAES5PdmObd5sBQLIQmOwnDj8VIxhMjg++8RbgAz6YrA9zg82NUpHjxWM0SlBB
	 /LZ6Trx1VcH55WtuJKmiw4/MYP36pekvFvVBFmBlw6f/JRwZ7u+XfhSy1VlCK4eOuhzbK
	 F6eFm9F0Dz9dzXDOWEiAP8FjfRdN127Eb4dgVYybo9UJlHWJYLkYdcFRNsnMmcFxHIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LgpT/cK9n4R1IAgZOWgcbKQnZ07qF2pITQnYSKILbDM=;
	b=QRWVWciIc+yxtsK9W+y+LrU/YlcRNKz6k32jOWSp/5/lqZR+pv0YIgul9ALTyFNc6VJe
	 YMTI+t8VBAqJhc8KBfmxouGb26szJpFeKYhJNh1NrnJ5spbKggVsONSl87MXK8TMc/J//
	 iruBJf90k5IRZ7zY2rn2UtbSShSOxrBBhs/fnGIXYfEtJPtdFWJzdWomsqulOmx0twqdy
	 hgLWriOVhY2tXcg48qPLATtfT4f3KhqjdpzxxwrQGUSdeuxHRw49iZY5P+YsQ06hkKX5f
	 kk8hZdfq3SUyRTglHwKlik7NY3tRRABX58hFg+2RLNqF9SmZnE7XpyBJFxWe5GgyxLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BkQIjhn5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790694742;
	bh=LgpT/cK9n4R1IAgZOWgcbKQnZ07qF2pITQnYSKILbDM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6oiDdlvgVbo7htuySXGE9uJuhVrzd0b7TAGjifgNrj/SLQJVqJoxNONfa4WMcMxZY
	 nl4RYonZeedYC4bb7PLNqwp+0JrnGQADj2PrS4Rx99mjnkoW5vS8M7/tVxdGbjQcvg
	 sHofelPCGe0weFodv6oKniOZmBzbAJjw+DQz1uc99J7yUt/DKyWrlM60Stsg8ufbw0
	 /ahMNMsANloWN+0pDFYnxVk3xdqqwBZwGeo3EJuqM1TsnZHHtTpFI33sJwwdWgwLFK
	 hBbPS6i0g24IXqMKPrkzAr8dAkK6Q55l9vQ4HMOu12Sz4QYm84Fly6G3PTtky/AEkC
	 oFFJTxsE7Y2nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE0B8809F6;
	Tue, 29 Sep 2026 15:12:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1359A32A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 15:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEC5480DF4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 15:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PngJMqo7TivI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 15:12:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 14E6B80DC8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694738;
 b=DO3S0fP4bupCsGM2e3bdx9W/RquOs3JY5vRnSsfx5ejjCykN0tTOslBKV8vqL4k5Myl3
 pr5B8v7UMcGIvwjKbp3RTBII45WSUbFeoaDU+rTVRLYrO9rpOfYgoGWWGb2Aw0t9oBxdn
 HGcugCAPjBpUrtbGGYxVZ/8bdxtxxqJkCLddQTrNoh3HXKq2iZiuVUPrQCM0KhV0tzT6m
 I5KF4n1WzE9eBvEanhw9/o+XqqXwiZMZsJVcCyKzwhZRPlkH8j23etncNB3kJ2yvTxpBV
 PSHR4B6BM8Sy3WBN+EX2TPNVr5Y0CgAByML9cSkVuJf2YcL5Ckj8BCi9mV9GHL2DFvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694738;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=LgpT/cK9n4R1IAgZOWgcbKQnZ07qF2pITQnYSKILbDM=;
 b=GswYhhoAHEqLJADhz/QsCp3TYoM45PuiEgkfgKEdJ6n46EAJYZqGHpj6HrPOxaoDl46W
 J/GDk8Tze6lmYyFtjeWDT0Gbh1iwxqwotacuJKjyHRskZb68ysS/Ro67yZeWow2amL1/y
 563Gek+u96w27Bkx9RnETcJlBbxKBZLpDeqLhW2iJZLy/4NrEA2irHiEkNpHgeHSQZAks
 rhPWW+3JQxfy56FZnn86V17G9IlJUEZ/KwrtnRsf1MgpAOdPsNjt3M9Y7Z43h0xm4glfv
 mtIrgT0jzwZEEfLl2MMTo+PVrHrnaHxDHcJQisYhtFn+tXwgzTFa2RMlcjkRqme0FLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BkQIjhn5; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=arkadiusz.kubalewski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BkQIjhn5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14E6B80DC8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790694738; x=1822230738;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c+lNYvZkbKrTliPh2qCba4XLT8dP+5w78hwAwBmA9YU=;
 b=BkQIjhn5luemSZj0M6NSlZSyuZH/JHlT9ytV5wFC9e5OBH3BbqeBQ48p
 g/T/oJNPS3TUdVDFQ6OF2UYrX0pP7+adrD3XgI5wnRZKGqMPwvloUEFAG
 sb96H0n0jLh9tOmsCCvl0SAb2Mhs6/jam/pfzr4F6K7LOgB5myk8zEKY2
 d1X8sdP9Nipd9LJB/4AmEOGV5T9tx5Lu0Ta6JkYzHxPioIAI5bnB/oW2G
 tP2dkuymbnEisN0QRAZxqdcq1MPA4buJB8Feo6Q4uhohsGqCfL+ED9zzM
 2hF4ldkOcQapFLelq3ayTIvane3+9LBvja2H6ybGnA7kZUyiIxYfGNVh5 Q==;
X-CSE-ConnectionGUID: rENqh2ZVSi2eXS2DZxqhqA==
X-CSE-MsgGUID: MElo+lZGQ8OlothKCpWQOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102791896"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="102791896"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 08:12:16 -0700
X-CSE-ConnectionGUID: hMUrOWFWQjeCCjD4zMgkIA==
X-CSE-MsgGUID: ZEUYZkIHRt2SF7uMBL6+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274944559"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
 by fmviesa007.fm.intel.com with ESMTP; 29 Sep 2026 08:12:13 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
 aleksandr.loktionov@intel.com, horms@kernel.org, grzegorz.nitka@intel.com,
 vgrinber@redhat.com, zoltan.fodor@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [iwl-next v16] ice: add support for unmanaged DPLL on E830 NIC
Date: Tue, 29 Sep 2026 17:05:05 +0200
Message-ID: <20260929150505.3306226-1-arkadiusz.kubalewski@intel.com>
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

v16:
- Fix build with CONFIG_PTP_1588_CLOCK=n, reported by the kernel test
  robot. ice_main.c called ice_cgu_get_num_pins(), which is only built
  together with PTP support, leaving ice.ko with an undefined symbol.
  Move the unmanaged dpll detection into ice_dpll.c behind a new
  ice_dpll_is_unmanaged(), which is stubbed out in that configuration.

v15:
- Do not drop a lock status event that arrives before the dpll device is
  registered. Firmware reports each transition only once, so the state is
  now always recorded and the pending notification is emitted by
  ice_dpll_init_unmanaged() once the device exists.
- Initialize pf->dplls.lock once per pf in ice_init_dev(), so an event
  delivered by the still-running service task cannot find a destroyed
  mutex after a devlink reload.
- Seed the initial lock state with pf->dplls.lock held across the
  firmware read, so a concurrent event is not overwritten by the older
  value the read returned.
- Drop the now redundant notify parameter of
  ice_dpll_lock_state_set_unmanaged() and factor the state decoding out
  into ice_dpll_health_lock_status().
- Publish each unmanaged pin count only after its array is allocated, and
  clear both counts on teardown, so a non-zero count never pairs with a
  NULL array.

v14:
- Close TOCTOU race between health-event gate and unmanaged dpll teardown.
- Initialize health_notify_rwsem once per pf in ice_init_dev(), not on
  every devlink reload.
- Check hardware family before probing for unmanaged dpll support.
- Do not report dpll lock status changes through the firmware devlink
  health reporter, they are informational and not failures.
- Warn when the firmware health status code list is truncated.
- Document @unmanaged and @health_notify_rwsem.
- Document that unmanaged lock-state tracking is event-driven only and is
  not re-seeded after reset.
- Document the fixed embedded sync properties and the NULL pin private pf
  of the unmanaged pins.

v13:
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
 .../net/ethernet/intel/ice/devlink/health.c   |  14 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 182 ++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 439 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  24 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  19 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  34 ++
 9 files changed, 775 insertions(+), 35 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 0bca293cf9cb..b720763e25af 100644
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
+   {'board-label': 'MAC-PHY-CLK',
+    'capabilities': set(),
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
+   {'board-label': '1588-TIME_REF',
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
index 8e9a8a8178d4..04a72b61c24c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -236,7 +236,19 @@ void ice_process_health_status_event(struct ice_pf *pf, struct ice_rq_event_info
 		status_code = le16_to_cpu(health_info->health_status_code);
 		health_code = ice_get_health_status(status_code);
 
-		if (health_code) {
+		if (status_code == ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK &&
+		    pf->dplls.unmanaged) {
+			/* Firmware reports every unmanaged dpll lock state
+			 * transition with this code, re-locking included. It
+			 * is informational and not a failure, so it gets its
+			 * own path and deliberately does not reach
+			 * devlink_health_report(), which would bump
+			 * error_count and latch the shared firmware reporter
+			 * into DEVLINK_HEALTH_REPORTER_STATE_ERROR on every
+			 * normal state change.
+			 */
+			ice_dpll_lock_state_set_unmanaged(pf, health_info);
+		} else if (health_code) {
 			switch (le16_to_cpu(health_info->event_source)) {
 			case ICE_AQC_HEALTH_STATUS_GLOBAL:
 				pf->health_reporters.fw_status = *health_info;
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 42878abac9eb..848ac5834297 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1500,6 +1500,7 @@ struct ice_aqc_get_link_topo {
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575		0x21
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL30632_80032	0x24
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_SI5383_5384	0x25
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640		0x27
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_E822_PHY		0x30
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827		0x31
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX	0x47
@@ -2483,11 +2484,14 @@ enum ice_aqc_health_status {
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
@@ -2514,6 +2518,13 @@ struct ice_aqc_health_status_elem {
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
@@ -2677,6 +2688,7 @@ enum ice_adminq_opc {
 
 	/* System Diagnostic commands */
 	ice_aqc_opc_set_health_status_cfg		= 0xFF20,
+	ice_aqc_opc_get_supported_health_status_codes	= 0xFF21,
 	ice_aqc_opc_get_health_status			= 0xFF22,
 
 	/* FW Logging Commands */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2396ae66f868..6bde8f5186ba 100644
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
@@ -6317,6 +6340,165 @@ bool ice_is_fw_health_report_supported(struct ice_hw *hw)
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
+	const int buff_size = ICE_AQC_HEALTH_STATUS_CODE_NUM;
+	struct ice_aqc_health_status_supp_elem *buff;
+	u16 count;
+	int ret;
+
+	*supported = false;
+	buff = kzalloc_objs(*buff, buff_size);
+	if (!buff)
+		return -ENOMEM;
+	ret = ice_aq_get_health_status_supported(hw, buff, buff_size, &count);
+	if (ret)
+		goto free_buff;
+	/* Not expected to happen with current firmware, which cannot report
+	 * more codes than the driver buffer holds. Warn instead of silently
+	 * scanning a partial list, because a @code living past the cut would
+	 * be reported as unsupported and disable a feature for no visible
+	 * reason. If this ever fires, the buffer handling needs revisiting.
+	 */
+	if (count > buff_size)
+		dev_warn(ice_hw_to_dev(hw),
+			 "firmware reports %u supported health status codes, only %u can be read, code support detection may be incomplete\n",
+			 count, buff_size);
+	count = min_t(u16, count, buff_size);
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
+	const int buff_size = ICE_AQC_HEALTH_STATUS_CODE_NUM;
+	struct ice_aqc_health_status_elem *buff;
+	int ret, last_status = -1;
+	u16 count;
+
+	buff = kzalloc_objs(*buff, buff_size);
+	if (!buff)
+		return -ENOMEM;
+	ret = ice_aq_get_health_status(hw, buff, buff_size, &count);
+	if (ret)
+		goto free_buff;
+	/* Not expected to happen with current firmware, which cannot report
+	 * more records than the driver buffer holds. Warn instead of silently
+	 * scanning a partial list: the last match within a truncated window
+	 * is not necessarily the most recent record, and callers that use
+	 * this as a one-time state seed would then latch a wrong value with
+	 * nothing to correct it. If this ever fires, the buffer handling
+	 * needs revisiting.
+	 */
+	if (count > buff_size)
+		dev_warn(ice_hw_to_dev(hw),
+			 "firmware reports %u health status records, only %u can be read, the newest record for a code may be missed\n",
+			 count, buff_size);
+	count = min_t(u16, count, buff_size);
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
index b6ac2c4c6814..06be426de685 100644
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
@@ -1183,9 +1188,11 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
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
@@ -2601,9 +2608,14 @@ ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
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
@@ -3388,6 +3400,19 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
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
@@ -4050,8 +4075,10 @@ ice_dpll_deinit_direct_pins(struct ice_pf *pf, bool cgu,
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
@@ -4083,12 +4110,15 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
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
@@ -4097,7 +4127,8 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
 	return 0;
 
 unregister_first:
-	ice_dpll_unregister_pins(first, pins, ops, count);
+	if (first)
+		ice_dpll_unregister_pins(first, pins, ops, count);
 release_pins:
 	ice_dpll_release_pins(pins, count);
 	return ret;
@@ -4478,6 +4509,18 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
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
@@ -5152,6 +5231,8 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	default:
 		return -EINVAL;
 	}
+	if (!num_pins)
+		return -EINVAL;
 	if (num_pins != ice_cgu_get_num_pins(hw, input)) {
 		pf->dplls.generic = true;
 		return ice_dpll_init_info_pins_generic(pf, input);
@@ -5163,6 +5244,36 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
 		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
 		if (input) {
+			if (pf->dplls.unmanaged) {
+				pins[i].freq = ice_dpll_pin_freq_info(hw, i,
+								      input);
+				pins[i].state[0] = DPLL_PIN_STATE_CONNECTED;
+				/* Embedded sync is a fixed property of the
+				 * input on unmanaged E830 designs: the pin is
+				 * always esync capable and always has esync
+				 * enabled, so the values are hardcoded on
+				 * purpose. There is no AQ interface to query
+				 * or change them in unmanaged mode, and
+				 * nothing about this is runtime configurable,
+				 * so reporting the constant board property is
+				 * the accurate answer here.
+				 */
+				pins[i].status =
+					ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP;
+				pins[i].flags[0] = ICE_DPLL_IN_ESYNC_ENABLED;
+				/* skip priority, capabilities, phase range,
+				 * pin state AQ query and freq_supported -
+				 * not available for unmanaged DPLL
+				 *
+				 * pins[i].pf is intentionally left NULL: the
+				 * unmanaged pin ops
+				 * (ice_dpll_input_unmanaged_ops) take the pf
+				 * from the dpll private data instead, and no
+				 * callback registered for these pins reads
+				 * the pin private pf.
+				 */
+				continue;
+			}
 			ret = ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
 						      &de->input_prio[i]);
 			if (ret)
@@ -5176,6 +5287,23 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
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
+				 *
+				 * pins[i].pf is intentionally left NULL: the
+				 * unmanaged pin ops
+				 * (ice_dpll_output_unmanaged_ops) take the pf
+				 * from the dpll private data instead, and no
+				 * callback registered for these pins reads
+				 * the pin private pf.
+				 */
+				continue;
+			}
 			ret = ice_cgu_get_output_pin_state_caps(hw, i, &caps);
 			if (ret)
 				return ret;
@@ -5193,10 +5321,13 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
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
@@ -5437,8 +5568,10 @@ static void ice_dpll_deinit_info(struct ice_pf *pf)
 {
 	kfree(pf->dplls.inputs);
 	pf->dplls.inputs = NULL;
+	pf->dplls.num_inputs = 0;
 	kfree(pf->dplls.outputs);
 	pf->dplls.outputs = NULL;
+	pf->dplls.num_outputs = 0;
 	kfree(pf->dplls.eec.input_prio);
 	pf->dplls.eec.input_prio = NULL;
 	kfree(pf->dplls.pps.input_prio);
@@ -5503,6 +5636,123 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	return ret;
 }
 
+/**
+ * ice_dpll_health_lock_status - lock status reported by a health status record
+ * @buff: health status record, zeroed when firmware reported none
+ *
+ * Return: DPLL_LOCK_STATUS_LOCKED unless a loss-of-lock record says otherwise.
+ */
+static enum dpll_lock_status
+ice_dpll_health_lock_status(const struct ice_aqc_health_status_elem *buff)
+{
+	if (buff->health_status_code == 0 ||
+	    le32_to_cpu(buff->internal_data1) == ICE_DPLL_HEALTH_STATUS_LOCKED)
+		return DPLL_LOCK_STATUS_LOCKED;
+
+	return DPLL_LOCK_STATUS_UNLOCKED;
+}
+
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
+ * across resets (PFR/CORER/GLOBR/EMPR) or devlink reload, and health event
+ * delivery is likewise armed only once, from the ice_health_init() path.
+ * That is by design, not an omission: the unmanaged dpll is autonomous
+ * hardware whose lock state is independent of PF reset and driver state, so
+ * a reset does not invalidate what was last reported. Carrying the previous
+ * value forward is therefore the correct answer, and only a genuine
+ * transition - loss of lock, or its subsequent clearing - changes it, which
+ * firmware reports as an event. Absent such an event nothing has changed
+ * and there is nothing to converge to.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_lock_state_init_unmanaged(struct ice_pf *pf)
+{
+	u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
+	struct ice_aqc_health_status_elem buff;
+	struct ice_dpll *d = &pf->dplls.pps;
+	int ret;
+
+	mutex_lock(&pf->dplls.lock);
+	ret = ice_get_last_health_status_code(&pf->hw, &buff, code);
+	if (!ret) {
+		d->dpll_state = ice_dpll_health_lock_status(&buff);
+		d->prev_dpll_state = d->dpll_state;
+	}
+	mutex_unlock(&pf->dplls.lock);
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
+	u8 num_inputs, num_outputs;
+	int ret;
+
+	d->clock_id = ice_generate_clock_id(pf);
+	num_inputs = ice_cgu_get_num_pins(&pf->hw, true);
+	num_outputs = ice_cgu_get_num_pins(&pf->hw, false);
+	ret = ice_dpll_lock_state_init_unmanaged(pf);
+	if (ret)
+		return ret;
+	/* Publish each pin count only once its array exists, so that a
+	 * non-zero count never pairs with a NULL array.
+	 */
+	d->inputs = kzalloc_objs(*d->inputs, num_inputs);
+	if (!d->inputs)
+		return -ENOMEM;
+	d->num_inputs = num_inputs;
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
+	if (ret)
+		goto deinit_info;
+
+	d->outputs = kzalloc_objs(*d->outputs, num_outputs);
+	if (!d->outputs) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
+	d->num_outputs = num_outputs;
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
@@ -5613,6 +5863,43 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	return ret;
 }
 
+/**
+ * ice_dpll_lock_state_set_unmanaged - determine lock state from health status
+ * @pf: board private structure
+ * @buff: health status buffer
+ *
+ * Set unmanaged dpll lock state based on health status code and internal data.
+ * Firmware reports each transition only once, so the state is recorded even
+ * when the dpll device is not registered yet; the notification is then armed
+ * and ice_dpll_init_unmanaged() emits it.
+ * Context: Acquires and releases pf->dplls.lock (must release before notify
+ * if called). Holds pf->dplls.health_notify_rwsem for read across the whole
+ * function, including the out-of-lock notify call, so ice_dpll_deinit() can
+ * drain any in-flight caller before freeing the dpll device.
+ */
+void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				       const struct ice_aqc_health_status_elem *buff)
+{
+	struct ice_dpll *d = &pf->dplls.pps;
+	bool notify = false;
+
+	if (!ice_pf_src_tmr_owned(pf))
+		return;
+
+	down_read(&pf->dplls.health_notify_rwsem);
+	mutex_lock(&pf->dplls.lock);
+	d->dpll_state = ice_dpll_health_lock_status(buff);
+	if (test_bit(ICE_FLAG_DPLL, pf->flags) &&
+	    d->prev_dpll_state != d->dpll_state) {
+		d->prev_dpll_state = d->dpll_state;
+		notify = true;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (notify)
+		dpll_device_change_ntf(d->dpll);
+	up_read(&pf->dplls.health_notify_rwsem);
+}
+
 /**
  * ice_dpll_deinit - Disable the driver/HW support for dpll subsystem
  * the dpll device.
@@ -5623,7 +5910,7 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
  * handling them.
  *
  * Context: Call only if ICE_FLAG_DPLL was set. pf->dplls.lock lifetime is
- * managed by ice_init_features()/ice_deinit_features().
+ * managed by ice_init_dev()/ice_deinit_dev().
  */
 void ice_dpll_deinit(struct ice_pf *pf)
 {
@@ -5647,15 +5934,25 @@ void ice_dpll_deinit(struct ice_pf *pf)
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
@@ -5666,6 +5963,56 @@ void ice_dpll_deinit(struct ice_pf *pf)
 	ice_dpll_deinit_info(pf);
 }
 
+/**
+ * ice_dpll_init_unmanaged - initialize support for unmanaged dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls for unmanaged mode, register them and pins connected
+ * within Linux dpll subsystem. Allow userspace to obtain state of DPLL.
+ *
+ * Context: pf->dplls.lock and pf->dplls.health_notify_rwsem are initialized
+ * and destroyed by ice_init_dev()/ice_deinit_dev(), not by this function,
+ * which re-runs on every devlink reload while pf->dplls survives across
+ * reloads.
+ */
+static void ice_dpll_init_unmanaged(struct ice_pf *pf)
+{
+	struct ice_dpll *d = &pf->dplls.pps;
+	bool notify = false;
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
+	mutex_lock(&pf->dplls.lock);
+	if (d->prev_dpll_state != d->dpll_state) {
+		d->prev_dpll_state = d->dpll_state;
+		notify = true;
+	}
+	mutex_unlock(&pf->dplls.lock);
+	if (notify)
+		dpll_device_change_ntf(d->dpll);
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
@@ -5793,8 +6140,52 @@ static void ice_dpll_init_e810(struct ice_pf *pf)
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
 
+/**
+ * ice_dpll_is_unmanaged - check if device provides an unmanaged dpll
+ * @pf: board private structure
+ *
+ * Check the cheap, purely local conditions first and only ask firmware when
+ * they all hold, instead of doing an unconditional round trip on hardware
+ * that can never support this mode. ice_cgu_get_num_pins() also doubles as an
+ * E835 exclusion: E835 device IDs share ICE_MAC_E830 with true E830 parts but
+ * have no entry in ice_cgu_get_pin_desc()'s switch, so it returns 0 pins for
+ * them.
+ *
+ * Return: true if the device provides an unmanaged dpll, false otherwise.
+ */
+bool ice_dpll_is_unmanaged(struct ice_pf *pf)
+{
+	u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
+	bool unmanaged;
+
+	if (pf->hw.mac_type != ICE_MAC_E830 ||
+	    !ice_cgu_get_num_pins(&pf->hw, true) ||
+	    !ice_is_unmanaged_cgu_in_netlist(&pf->hw))
+		return false;
+	if (ice_is_health_status_code_supported(&pf->hw, code, &unmanaged))
+		return false;
+
+	return unmanaged;
+}
+
+/**
+ * ice_dpll_init - initialize support for dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls, register them and pins connected within Linux dpll
+ * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
+ * configuration requests.
+ *
+ * Context: pf->dplls.lock mutex is initialized/destroyed by
+ * ice_init_dev()/ice_deinit_dev(), not by this function.
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
index 3af2ca0de6cb..641b02b0296a 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -27,6 +27,7 @@
 #define ICE_CGU_R11_SYNCE_S_BYP_CLK	GENMASK(6, 1)
 
 #define ICE_CGU_BYPASS_MUX_OFFSET_E825C	3
+#define ICE_DPLL_IN_ESYNC_ENABLED	ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN
 
 /**
  * enum ice_dpll_pin_sw - enumerate ice software pin indices:
@@ -151,9 +152,14 @@ struct ice_dpll {
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
@@ -162,6 +168,9 @@ struct ice_dpll {
  *       -> pf->dplls.lock
  *         -> ctrl_pf->dplls.lock
  *
+ *     health_notify_rwsem (read)
+ *       -> pf->dplls.lock
+ *
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
@@ -172,6 +181,12 @@ struct ice_dpll {
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
@@ -200,17 +215,26 @@ struct ice_dplls {
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
+bool ice_dpll_is_unmanaged(struct ice_pf *pf);
 void ice_dpll_init(struct ice_pf *pf);
 void ice_dpll_deinit(struct ice_pf *pf);
+void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				       const struct ice_aqc_health_status_elem *buff);
 #else
+static inline bool ice_dpll_is_unmanaged(struct ice_pf *pf) { return false; }
 static inline void ice_dpll_init(struct ice_pf *pf) { }
 static inline void ice_dpll_deinit(struct ice_pf *pf) { }
+static inline void
+ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
+				  const struct ice_aqc_health_status_elem *buff) { }
 #endif
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a2ac57682d4b..475f07c1a367 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4774,6 +4774,9 @@ int ice_init_dev(struct ice_pf *pf)
 		return -EIO;
 	}
 
+	mutex_init(&pf->dplls.lock);
+	init_rwsem(&pf->dplls.health_notify_rwsem);
+
 	ice_start_service_task(pf);
 
 	return 0;
@@ -4783,6 +4786,8 @@ void ice_deinit_dev(struct ice_pf *pf)
 {
 	ice_service_task_stop(pf);
 
+	mutex_destroy(&pf->dplls.lock);
+
 	/* Service task is already stopped, so call reset directly. */
 	ice_reset(&pf->hw, ICE_RESET_PFR);
 	pci_wait_for_pending_transaction(pf->pdev);
@@ -4796,14 +4801,6 @@ static void ice_init_features(struct ice_pf *pf)
 	if (ice_is_safe_mode(pf))
 		return;
 
-	/* pf->dplls.lock guards TSPLL/CGU access shared between the DPLL
-	 * subsystem callbacks and the PTP periodic worker's TSPLL monitor.
-	 * Initialize it before ice_ptp_init() so the PTP kworker never sees
-	 * an uninitialized mutex, and destroy it in ice_deinit_features()
-	 * only after ice_ptp_release() has drained the kworker.
-	 */
-	mutex_init(&pf->dplls.lock);
-
 	/* initialize DDP driven features */
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		ice_ptp_init(pf);
@@ -4811,8 +4808,11 @@ static void ice_init_features(struct ice_pf *pf)
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
 
+	pf->dplls.unmanaged = ice_dpll_is_unmanaged(pf);
+
 	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
-	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
+	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK) ||
+	    pf->dplls.unmanaged)
 		ice_dpll_init(pf);
 
 	/* Note: Flow director init failure is non-fatal to load */
@@ -4848,7 +4848,6 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_ptp_release(pf);
 	if (test_bit(ICE_FLAG_DPLL, pf->flags))
 		ice_dpll_deinit(pf);
-	mutex_destroy(&pf->dplls.lock);
 	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		xa_destroy(&pf->eswitch.reprs);
 	ice_hwmon_exit(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 18ea69e272c6..3e08ad3e0bf4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -22,6 +22,10 @@ static struct dpll_pin_frequency ice_cgu_pin_freq_10_mhz[] = {
 	DPLL_PIN_FREQUENCY_10MHZ,
 };
 
+static struct dpll_pin_frequency ice_cgu_pin_freq_156_25mhz[] = {
+	DPLL_PIN_FREQUENCY_RANGE(156250000, 156250000),
+};
+
 static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] = {
 	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
 		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
@@ -133,6 +137,18 @@ static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] = {
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
+	  ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
+};
+
 /* Low level functions for interacting with and managing the device clock used
  * for the Precision Time Protocol.
  *
@@ -6032,6 +6048,24 @@ ice_cgu_get_pin_desc(struct ice_hw *hw, bool input, int *size)
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

base-commit: 837cf7243ceed6e72369a2ad66f778e22a4ed068
-- 
2.47.0

