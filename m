Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D0C624DA
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 16:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D0B860B9D;
	Thu,  3 Sep 2026 16:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJmT7QiD6QW2; Thu,  3 Sep 2026 16:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C4BA60B9F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451406;
	b=Mc7BwM4blmK45GmtEfvxiendaqptxE2mupmShhSbRPGAX9Td9XFzgh+xAuwbijLWMLmV
	 H6Ms26MXrXb0LP4Am6yahIigmLxsjPMWcbS6yGKj6VBTLlIQPqxJJRwMhEs3omjemTaej
	 GMhwVFMCSRbORIthhq3A4c9wwfswq6v9kPCayAE4/jVNE3vbL0OH4Smc0oxt3PTRYJFMQ
	 66Oneb7XdOeIKTqOF8D9ngwBAeKDQPYIFDBs4BrNqVxUzte1DTOxTFFUgtpNCl9aV40cE
	 tgIQ4sVhDvfC0vhrHhEfTgYdmFJtCT5LzIs3Xyq+1/xx5+xth9Dc2+7u7Yg3xdpIkhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pk3URmsK4o2hPa2IX/FXCls5vyxXiExddQD20KUO4Jw=;
	b=DSfxMk5NvrLe/p9ckzqyLYeb9Z2/fMdNRFLki8yzblWrlpxcsx4af2zCiSBKh5uebE6V
	 uMFtfARPGlXu2hheF6l0cKvWgCHQImN8V0UiBp/KjTGm0konsOqyLryhzFNPkpVALPYjN
	 GRrnKwiCwF23q4JRwUL78b4Jmfaxp7eoU87YtWpq+qZtQKBd5A9wcOmOAnRixpU99ltlP
	 JnA5VRMPdO43oKyVIFWuSMPf4Bj0IKotsSP1X/gAYANSwPcJMlFfVN12sG/mF9IzfpD3q
	 2PylF6k4yvK2ZPDRqsNHicnm1/DAZKkvHObNQuCezWrjPZG9qwGwXMt9XUqJCZOyzUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451406;
	bh=pk3URmsK4o2hPa2IX/FXCls5vyxXiExddQD20KUO4Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZGr29/p3e8dDxWV9U7P6bc1y7EeN+aeC3H5a3xKlPiej4cvA0ndQIWVvlYGUIf8mU
	 JE6H75MbK5u9lpQpmRfObX/yLe9E5dNSJw3MRbUydFlg1N1bnSmrRX9JwAALCO0ezm
	 NMBnq774Ag913VzBEcrma9oa8REvcI0h6nAlfC+fpN/oQcX8Mp3BtFMj+Q7oowS3mp
	 k2MEDJAyT7wBnjVGuYD9OlCoxrJy4OlzDFzgiDDbl26LvlXFZlep1E+BTYxBDMi0Jt
	 1d/5nl5R9s/+95LhXvdq94URWnNMHWOSKKe4pQp+7/GluETGL2pskGFHH1QT5krXbA
	 /86t/aYkIL2Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C4BA60B9F;
	Thu,  3 Sep 2026 16:03:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C957279
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72E8C80EC0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eeCELywAIWOf for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 16:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 58F5280EAB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451402;
 b=PcNm53585ifkH97oxfAtZTyam6XraoMox6CX41q5QbzCt53HSiL2EWsCbinqbo5uILoh
 LdpGyDxIN+jwnYdDFNnWXWtHlANAKa9hMp1Xjc5RqNbnuP0yg49ZomgcoR1asNcMNDIxf
 Ym4Hv84qfRwqSyzoYJDxs+ey0rrY6Tw+HQgrTov0QC75njASUbUL8g+UfjCPGwz0d8ryR
 +Rn09lEG47GyP7XwbVYT6ETuhWxGR/DNAcTkViE3NFSCvvqYN3ECvMyqyeTHrK3KCrFDU
 PupO0gJgOgsypkrtoS7LtGlOYuB2bB/adQDvaqLUognctZF0nqslt5BhAx/WrnnYwTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451402;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=pk3URmsK4o2hPa2IX/FXCls5vyxXiExddQD20KUO4Jw=;
 b=oOh/PidfcK8KKY4VGTMHRbmVDHG5Y6q3YG1iB9UeqHb9UIoRW0Yv9CfgAvwrA2R33nVk
 w07CjJKSYZIKo4Yj0+LIjk1Hg/ox2QQ0jMrRN5UobAmOOe0n1ygIWw1qWSkNvSp1/njNH
 rFdibjHdzYs65Y2re9o+Gq/cJhODSWHCO5VGBkFl/rzoILRxpTJWMYzZml5mIotqje5Bl
 0woxPpnMwLJs+Z85mT0fDhB+HEnILJ91G8iSg/ROsssZs7tGu8Z9+mnlfcdlwnVO2BNKd
 +kilVW8PUL6+64hasP9AWFTVLPPUNURKiO7rSNVKJoDN+l1AWYtuwwOT2WV4dtrBgqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lcq3pPRq; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lcq3pPRq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58F5280EAB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788451403; x=1819987403;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gkTHjouemw6WflaOrFioDQI8V9Aavzjc3JNQ1e0rkLE=;
 b=lcq3pPRqaB2vEwIp6ndiPn4q3wqj8ydg9/HnPcIRLsaHwPmtzY9JTbL5
 w2aec3ZhcHa0/LdGNY8DA63iL7HIJGNVFVALUjBhuly8b6OLEj0wenUZ4
 gAVHAiggRxZYTXqjGfS9ewDULNKdSs3dreD6GjZiSwhbZLqrSDTMw0lEb
 ngYDxHwsKRwUfcDfDlCeAJrJlw+Pu/0ljHx4MQXVcXT2/4pG+yw0H7I9n
 4SqFjY0DKeraNNT5oSUgKes41ZfFqTLf2ZUtJdppacQBcUS/tpVgdNpWw
 CTRwkyMP23UJh1lMWm7Nt/y5ecCGZ2d3XQOYT838IH1n9uraAyjveMN6l A==;
X-CSE-ConnectionGUID: lR/5yzrpS1GATrIjri/+OQ==
X-CSE-MsgGUID: tAUQnXRLRmCXLxq2Wam7Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76492960"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76492960"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:03:22 -0700
X-CSE-ConnectionGUID: jcVuRMqITdWPuhjrga2TWg==
X-CSE-MsgGUID: WkUPD88HROKXMO92/UKMnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293270218"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2026 09:03:21 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 4/4] selftests: net: hw: add devlink info test
Date: Thu,  3 Sep 2026 04:27:42 -0400
Message-ID: <20260903082742.43837-5-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260903082742.43837-1-paul.greenwalt@intel.com>
References: <20260903082742.43837-1-paul.greenwalt@intel.com>
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

Add a selftest that logs the device information a driver reports through
the devlink info interface: the driver name, serial numbers and every
reported version, in the format NIPA CI consumes for device regression
tracking. This helps maintainers identify pass/fail status changes
caused by FW updates.

Implementing devlink info is optional. devlink reports the driver name
for every registered instance, even when the driver does not implement
info_get, so a device that reports no versions and no serial number is
skipped rather than failed. Devices with no devlink instance are skipped
as well.

The devlink 'driver' attribute names the driver bound to the parent
device, which may legitimately differ from the netdev's ethtool driver -
mlx4 reports mlx4_core and mlx4_en, and DSA user ports report dsa - so a
difference is logged but not treated as a failure. ethtool is only used
for an optional fallback handle lookup and that comparison, so it is not
required to run the test.

NETIF is read from the environment or from drivers/net/net.config as
described in drivers/net/README.rst. net.config is sourced before
net/lib.sh so that it cannot clobber the framework's globals. The test
needs only a single local interface, so it sources net/lib.sh rather
than the forwarding library, which requires NUM_NETIFS and a configured
remote host.

Example usage:

  NETIF=eth0 ./tools/testing/selftests/drivers/net/hw/devlink_info.sh

  INFO: driver: idpf
  INFO: serial_number: 00-a0-c9-ff-ff-23-45-67
  INFO: fw.mgmt.api (running): 2.0
  TEST: devlink info                                                  [ OK ]

Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-information
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 160 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 78bb0169350b..edd353f27a39 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -19,6 +19,7 @@ TEST_GEN_FILES := \
 
 TEST_PROGS = \
 	csum.py \
+	devlink_info.sh \
 	devlink_rate_cross_esw.py \
 	devlink_rate_tc_bw.py \
 	devmem.py \
diff --git a/tools/testing/selftests/drivers/net/hw/devlink_info.sh b/tools/testing/selftests/drivers/net/hw/devlink_info.sh
new file mode 100755
index 000000000000..1a23e7d3c5af
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_info.sh
@@ -0,0 +1,160 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test devlink info support
+#
+# This test logs the device information a driver reports through the devlink
+# info interface, in the format NIPA CI consumes for regression tracking (see
+# the Device information section at
+# https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system).
+#
+# Implementing devlink info is optional, so a device whose driver reports no
+# versions and no serial number is skipped rather than failed.
+#
+# Usage:
+#   NETIF=eth0 ./devlink_info.sh
+
+ALL_TESTS="devlink_info_test"
+
+lib_dir=$(dirname "$0")
+
+# NETIF may also be provided through drivers/net/net.config, as documented in
+# drivers/net/README.rst. Source it before lib.sh so that a stray assignment
+# cannot clobber the framework's globals.
+if [[ -z "$NETIF" && -f "$lib_dir/../net.config" ]]; then
+	source "$lib_dir/../net.config"
+fi
+
+source "$lib_dir"/../../../net/lib.sh
+
+require_command devlink
+require_command jq
+
+DL_HANDLE=
+DL_INFO=
+
+setup_prepare()
+{
+	local err
+
+	if [[ -z "$NETIF" ]]; then
+		echo "SKIP: NETIF is not configured"
+		exit "$ksft_skip"
+	fi
+
+	# Try to get the devlink handle from the devlink port first.
+	DL_HANDLE=$(devlink -j port show 2>/dev/null |
+		jq -r --arg netif "$NETIF" \
+			'.port | to_entries[] |
+			 select(.value.netdev == $netif) | .key' 2>/dev/null |
+		head -n 1 |
+		cut -d/ -f1-2)
+
+	# Fall back to the PCI address reported by ethtool. Devices on other
+	# buses are only found through the devlink port lookup above.
+	if [[ -z "$DL_HANDLE" ]] && command -v ethtool >/dev/null; then
+		local bus_info
+
+		bus_info=$(ethtool -i "$NETIF" 2>/dev/null |
+			awk '/^bus-info:/ {print $2}')
+		if [[ -n "$bus_info" ]] &&
+		   devlink dev show "pci/$bus_info" &>/dev/null; then
+			DL_HANDLE="pci/$bus_info"
+		fi
+	fi
+
+	if [[ -z "$DL_HANDLE" ]]; then
+		echo "SKIP: could not find devlink handle for $NETIF"
+		exit "$ksft_skip"
+	fi
+
+	# Query once so that a single snapshot is validated throughout.
+	DL_INFO=$(devlink -j dev info "$DL_HANDLE" 2>/dev/null)
+	err=$?
+	if ((err)); then
+		echo "SKIP: devlink dev info failed for $DL_HANDLE"
+		exit "$ksft_skip"
+	fi
+}
+
+# jq's "// empty" maps a missing or null field to no output, so callers get an
+# empty string rather than the literal text "null".
+info_get()
+{
+	local name=$1
+
+	jq -r --arg name "$name" '.[][][$name] // empty' <<<"$DL_INFO"
+}
+
+log_versions()
+{
+	local versions line
+
+	versions=$(jq -r '.[][].versions // {} | to_entries[] | .key as $type |
+			  .value | to_entries[] |
+			  "\(.key) (\($type)): \(.value)"' <<<"$DL_INFO" \
+			  2>/dev/null)
+
+	while IFS= read -r line; do
+		[[ -n "$line" ]] && log_info "$line"
+	done <<<"$versions"
+}
+
+has_any_version()
+{
+	jq -e '.[][].versions // {} | [.[] | to_entries[]] | length > 0' \
+		<<<"$DL_INFO" &>/dev/null
+}
+
+devlink_info_test()
+{
+	RET=0
+
+	local driver serial board_serial
+
+	driver=$(info_get "driver")
+	serial=$(info_get "serial_number")
+	board_serial=$(info_get "board.serial_number")
+
+	# devlink reports the driver name for every registered instance, even
+	# when the driver does not implement info_get. Everything else is
+	# optional, so a device with nothing further to report is not a
+	# failure.
+	if ! has_any_version && [[ -z "$serial" && -z "$board_serial" ]]; then
+		log_test_skip "devlink info" "no info reported for $DL_HANDLE"
+		return
+	fi
+
+	if [[ -z "$driver" ]]; then
+		check_err 1 "no driver name reported"
+	else
+		log_info "driver: $driver"
+	fi
+
+	# devlink names the driver bound to the parent device, which can
+	# legitimately differ from the netdev's ethtool driver, so report a
+	# difference without failing.
+	if command -v ethtool >/dev/null; then
+		local ethtool_driver
+
+		ethtool_driver=$(ethtool -i "$NETIF" 2>/dev/null |
+			awk '/^driver:/ {print $2}')
+		if [[ -n "$driver" && -n "$ethtool_driver" &&
+		      "$driver" != "$ethtool_driver" ]]; then
+			log_info "driver mismatch: devlink='$driver' ethtool='$ethtool_driver'"
+		fi
+	fi
+
+	[[ -n "$serial" ]] && log_info "serial_number: $serial"
+	[[ -n "$board_serial" ]] && log_info "board.serial_number: $board_serial"
+
+	log_versions
+
+	log_test "devlink info"
+}
+
+setup_prepare
+
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.52.0

