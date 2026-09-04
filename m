Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B89CC79F87
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 18:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58FFE8114C;
	Fri,  4 Sep 2026 18:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8CJwNsw5s8T; Fri,  4 Sep 2026 18:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 49EEF8115C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788545562;
	b=YzlJUAxJfaXr1mPBZEONjU2kpeapybVc8rHws1Zmya90/MbfSEBG/g45gxvPxgJm7oyI
	 VSfWmF+R+c8asrY+HIqHGIeqPtwjm+iC6syvH0neELsq2icEC5y2T+6rXsWBlfHtPi5i2
	 fnOat68BXl1ngXaCIbLM4XrYU+KVLyoqb0jpWsCOAgYQ1NLMyxDvbx3+pEh344iMDOUQp
	 +O1KoeAYK77lcQS+XqQZ+Yn6u2tFcQXYqjbJhTBNCfYtF91fhvezrJmOyHhQQTmPI/B1c
	 t/oqkD3l3Pcox34xUiX9nlVt+VTOfmUg5IYOHc3S7mosPNOsyhsT4CUwVdlFjEBSwCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788545562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=86X2LJWgXDDnh5tB63KEqi6VB1eOXzHmxO/FyeCZmck=;
	b=Ad3R+CeyeveQfk2pqI9dKkheeeJhpo3ANG327JB1Gwqq22eKynSWQ4ant0HyDlODnvNa
	 wKIMI4RKEZmS0qbY7xA+NEf54H64RMijnXXcqjyFKS7IZ0ECQnAmXE+lUlYmsK1f9DJxw
	 IetjlawU4UPrl/9vLj6gGpeEqqZdVGDfhgJ78ShU6FOJy7ASJfISv5lybLdVUOzhxtoU9
	 rKCACyvzlUFgzcmp5itZ2fh5xLwEE/8J2xMMI/o0y3lE6TkCLkrAmSEe9AarsS17XzKZ1
	 TJcCfLXdbkiEmPaUgCbQwIXHVzTrWZFjzKnL3lVyUnIcdtkVHKJKEyW8YVFPkuxDY5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788545562;
	bh=86X2LJWgXDDnh5tB63KEqi6VB1eOXzHmxO/FyeCZmck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1P9ocK4eGI52jzosgA+z+ju3Jq9T1ptgCWcaH4Y5lYPLmwnlvJ0uGn7DX6WITF//O
	 4SUqi2oTeHOQSAGN132xjfDdJlOCB0e0pGNdQC4FKgMWpBJKpx8B83/RNovpsnLLYO
	 kjOYZS9LvcyFqib9+sRW+GxmFzXtV/RmX9JFbFd3fPgG3BLA0cqbCmmmuPKpofIP0K
	 DjQWXPhxXCV/AHeANluMx067wBcKmWVhCl3zHfxa/Q5536fmxNlmI/0nyuJoK/L4zc
	 sjoow8FkJydzL3HOFRnByHESOsioA7hTQ+R+rd/Cu2XnjvpyNKfRrJ/Fyf5Q/KDGQK
	 COtzO1flgcguA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49EEF8115C;
	Fri,  4 Sep 2026 18:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46132463
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C65D40143
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5O98wnLt-pfv for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 18:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B894F404ED
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788545558;
 b=fEmjwUA/46+MET8MVXWjLtinuEDYJPp/WpTEkhQlfbSNLDyaChyAbLsUV8lTbZovdHfT
 XW9r7PInFsekDoPzRiuwuclnk7y1SZxN/FYKu8atRKTvibHTh/Bf/mQ3y0jbA9D8wdKcA
 9mG7ynyHWkpa29rB1XcBoDW+Ibw7So2tStOR4/0XDIMcjJny3CYCqml53wDkeQM2bjYnE
 sxGYh/iB4IBuiAXHUH/ZzAfPRCABXfIAsMz78Qfqrc4oAoQyClaW9EcxtdvFkCBBugxAs
 MOOI6owRBtQ+oTsXfb6UYwPA1XavvgFj52GbD3kZ+dSB4dHDFMg+AwnuYUGJwSaQa0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788545558;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=86X2LJWgXDDnh5tB63KEqi6VB1eOXzHmxO/FyeCZmck=;
 b=CN7/y5D60I+4sx/scIccfFYh7DXZj1tTM0v9unoMo5Nn47eQPAxT5dOUIoCdGtYaTeAE
 4g8V1OGEztMEfE2qKc69nW1XI5/QOVExVGHOHlqNPdCXsGcA+2rK0g5UAhN6FiaZK8+k6
 lYcYuu7GBdjkIjWPSgqryc/lUV8sYqGwkaiGTG2z+ZvO+nCGkT3RE6kq5XgZfT6mDRI6C
 xLbBWkAvgbola9nVDLfaplekLoFDqqjZdfHJG/1+5/E4N8wMRvJ04m1HjNCZ1UcKeV5Lp
 Eqm2UGxqoUvNKtWX1A05AxIUaiHw8OXnCtjKz0Gy3FDJw1FyKH4tX4n5MnGOfSPRk6g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eatKBhG9; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eatKBhG9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B894F404ED
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788545558; x=1820081558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PLNtNGBPOMpXrI4Qsal6HG6ABaucAPG5u+Pmymgvlu4=;
 b=eatKBhG9kxvHf20bHPLDTCd99w0ZzyMROiC7+mUknXKkx2cz19PUlr1e
 sDcp7uHBG0jDTPo2VGKxeuiq4T0lKoW69V34zedgQ8Z1FzX/cnyxPPPKA
 5Y747MsxQMXyMPQXe9gXZ8mzlUtM5nFJw6dVAN5l1J9k5WAP8XDmOkgS+
 giMEllBKh0iF5xY/CInuBKTJSi7myJ/k/EgJl7wyX3iOdeC8bc2EuWc7X
 ia691bbHGLBCHOBpSh9GlAtSgLgS7gJfxzBc/9VlFXDpsSqoGUZNtD3w1
 ANqGjtzEQ+5+iiWEKyIL5+yqBmrC5VaaXEQtLuEIpAhJdDrI50jLNv0K6 w==;
X-CSE-ConnectionGUID: miFFRriSRue4UROXHFnEBQ==
X-CSE-MsgGUID: frSQgnq1RW+pGsXW21Hdjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99385445"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="99385445"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 11:12:38 -0700
X-CSE-ConnectionGUID: w/ZzishxScGQlC1DBlwsoQ==
X-CSE-MsgGUID: VNOR31aXSwu9hLZ67QCcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="269577558"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by orviesa008.jf.intel.com with ESMTP; 04 Sep 2026 11:12:37 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v3 3/3] selftests: net: hw: add devlink info test
Date: Fri,  4 Sep 2026 06:37:14 -0400
Message-ID: <20260904103714.978256-4-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260904103714.978256-1-paul.greenwalt@intel.com>
References: <20260904103714.978256-1-paul.greenwalt@intel.com>
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

Every devlink info field is optional, so the test reports what a device
provides rather than requiring any particular field. devlink reports the
driver name for every registered instance, even when the driver does not
implement info_get, so a device that reports no versions and no serial
number is skipped, as are devices with no devlink instance. Whether the
driver name itself appears in the JSON depends on the installed
iproute2, so it is logged when present but not required.

The devlink 'driver' attribute names the driver bound to the parent
device, which may legitimately differ from the netdev's ethtool driver -
mlx4 reports mlx4_core and mlx4_en, and DSA user ports report dsa - so a
difference is logged rather than failed. ethtool is only used for an
optional fallback handle lookup and that comparison, so it is not
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
Assisted-by: Claude:claude-opus-5
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 158 ++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 78bb0169350b2..edd353f27a396 100644
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
index 0000000000000..7516297b27d80
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_info.sh
@@ -0,0 +1,158 @@
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
+		log_test_skip "devlink info" "NETIF is not configured"
+		exit "$EXIT_STATUS"
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
+		log_test_skip "devlink info" "no devlink handle for $NETIF"
+		exit "$EXIT_STATUS"
+	fi
+
+	# Query once so that a single snapshot is validated throughout.
+	DL_INFO=$(devlink -j dev info "$DL_HANDLE" 2>/dev/null)
+	err=$?
+	if ((err)); then
+		log_test_skip "devlink info" "devlink dev info failed for $DL_HANDLE"
+		exit "$EXIT_STATUS"
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
+	# Whether the driver name appears in the JSON depends on the installed
+	# iproute2, so report it when present but do not require it.
+	[[ -n "$driver" ]] && log_info "driver: $driver"
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

