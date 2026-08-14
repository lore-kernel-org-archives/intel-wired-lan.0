Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50022C5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Aug 2026 01:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BDAD60AAE;
	Sat, 15 Aug 2026 01:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DM1ovMWuQ2WL; Sat, 15 Aug 2026 01:26:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3529360B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786757213;
	bh=255iZVJ63BxjrvOlI6Z8l93KT/dm8Ww9lnmOL+lZy9E=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ARW5L1X58EB+XF3x4lXP5FRofabCEGwx/3DnEAriPujpNLvMI9ie4l9DKdW4QSKww
	 +IHbqiDhwvX0KsqZex08uLXYXAsbQWKHe0KFV1Iz7hzdKSgCWj8bc0cpaesXm/id7i
	 HT2qfZ6Lshog8qtHRJ8y+JAgVBAncHTfvF0NhUucfuin7kY4Xr9g018BrUDYZIGRF4
	 TQoW4XoEAFHXdV1T2AeaZ24Yd+SZds4u2+UkGubK35gCJbkvukYzzpBoQSogyLaVDM
	 UVaDJrzCtPxTh6bpgS3eJPzgKLhpoWTBnW6F4GvHgLos83o6Aha8wp5aEkywswLrn1
	 ejyr3WkEJteWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3529360B1F;
	Sat, 15 Aug 2026 01:26:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C41852BB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C202E60B1F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJvJJcbzXa0X for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 01:26:50 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B78BF60AAE
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B78BF60AAE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JsOwj5+7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B78BF60AAE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786757211; x=1818293211;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YpwQUnVulG9JPuLMVdRLJcAsL52MULHCbieWy635i+E=;
 b=JsOwj5+7RKS6qZTQiIdczrA4dm9DlgyKEHjjs4hITFrG4lNVzqpl/3rx
 au+JVmWj+G2/2N8aNhFFqvb2cPrLQx18KrPiLDaeyzp/9fca8euKpOOs4
 vVxn32QHYOIatHjzDiT07agRUcdLp5SaOlaL6zmeSvepTb2R7L6g4oq8k
 JXFFbYfrOzafflzG+kD0l/bf5rs+h1skn1BUd03gJKBP66BIusw+evs9L
 Pmoe1wIVtam/WGGpNcpxk+go/oaeJTbAn9IAc7RRHx/Uz/k03xGLTEKNx
 2299SgK1ixS5gUMA8pkIwcTjk+btwbXbF5FbSLrWPHpYt7n0RcItwnovu A==;
X-CSE-ConnectionGUID: Oyp9OXybQ1C2qLZzk1ZqhA==
X-CSE-MsgGUID: IqgoWmY3SymURJu0vkbvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87194396"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="87194396"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 18:26:50 -0700
X-CSE-ConnectionGUID: kngVLNCwSeSMPGzIZqsrdw==
X-CSE-MsgGUID: z3gaX29YQhC+dN/q9xJ2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="287844776"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 18:26:50 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Fri, 14 Aug 2026 13:49:19 -0400
Message-ID: <20260814174919.4177289-4-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814174919.4177289-1-paul.greenwalt@intel.com>
References: <20260814174919.4177289-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Intel-wired-lan] [PATCH iwl-next 3/3] selftests: net: hw: add
 devlink info test
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

Add a selftest that verifies drivers properly report device information
through the devlink info interface. This test validates:

  - devlink dev info command succeeds
  - driver name is reported and matches ethtool output
  - at least one version or serial_number is reported

The output format matches what NIPA CI uses for device regression
tracking, helping maintainers identify pass/fail status changes due
to FW updates.

Example usage:

  sudo NETIF=eth0 ./tools/testing/selftests/drivers/net/hw/devlink_info.sh

  INFO: driver: idpf
  INFO: serial_number: 00-a0-c9-ff-ff-23-45-67
  TEST: devlink info                                                  [ OK ]

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Link: https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system#device-information
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
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
index 000000000000..b2ee880590c4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_info.sh
@@ -0,0 +1,119 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test devlink info support
+#
+# This test verifies that the driver properly reports device information
+# through the devlink info interface. The output format matches what
+# NIPA CI uses for regression tracking (see Device information section
+# at https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system).
+#
+# Validates:
+#   - devlink dev info command succeeds
+#   - driver name is reported and matches ethtool
+#   - at least one version or serial_number is reported
+#   - serial_number is logged if present
+#
+# Usage:
+#   NETIF=eth0 ./devlink_info.sh
+
+lib_dir=$(dirname "$0")/../../../net
+
+ALL_TESTS="devlink_info_test"
+source "$lib_dir"/lib.sh
+
+require_command devlink
+require_command jq
+require_command ethtool
+
+DL_HANDLE=""
+
+setup_prepare()
+{
+	# Try to get devlink handle from devlink port first
+	DL_HANDLE=$(devlink -j port show 2>/dev/null |
+		jq -r --arg netif "$NETIF" \
+			'.port | to_entries[] |
+			 select(.value.netdev == $netif) | .key' 2>/dev/null |
+		cut -d/ -f1-2)
+
+	# Fallback: get PCI address from ethtool and check if devlink device exists
+	if [ -z "$DL_HANDLE" ]; then
+		local bus_info
+		bus_info=$(ethtool -i "$NETIF" 2>/dev/null | awk '/^bus-info:/ {print $2}')
+		if [ -n "$bus_info" ]; then
+			DL_HANDLE="pci/$bus_info"
+			# Verify this devlink device exists
+			if ! devlink dev show "$DL_HANDLE" &>/dev/null; then
+				DL_HANDLE=""
+			fi
+		fi
+	fi
+
+	if [ -z "$DL_HANDLE" ]; then
+		echo "SKIP: Could not find devlink handle for $NETIF"
+		exit $ksft_skip
+	fi
+}
+
+info_get()
+{
+	local name
+
+	name=$1
+	cmd_jq "devlink dev info $DL_HANDLE -j" ".[][][\"$name\"]" "-e"
+}
+
+has_any_version()
+{
+	local info
+	info=$(devlink -j dev info $DL_HANDLE)
+
+	# Check if any version category exists and has at least one entry
+	echo "$info" | jq -e '.[][].versions | length > 0' > /dev/null 2>&1
+}
+
+devlink_info_test()
+{
+	RET=0
+
+	# Test devlink info command succeeds
+	devlink dev info $DL_HANDLE > /dev/null
+	check_err $? "devlink dev info failed for $DL_HANDLE"
+
+	# Test driver name is reported
+	local driver
+	driver=$(info_get "driver")
+	check_err $? "Failed to get driver name"
+
+	# Verify driver matches ethtool output
+	local expected_driver
+	expected_driver=$(ethtool -i "$NETIF" | awk '/^driver:/ {print $2}')
+	check_err $? "Failed to get driver from ethtool"
+	if [ -z "$expected_driver" ]; then
+		check_err 1 "Failed to get driver from ethtool"
+	fi
+	if [ "$driver" != "$expected_driver" ]; then
+		check_err 1 "Driver mismatch: devlink='$driver' ethtool='$expected_driver'"
+	else
+		log_info "driver: $driver"
+	fi
+
+	# Test at least one version OR serial_number is reported (needed for device tracking)
+	local serial
+	serial=$(info_get "serial_number" 2>/dev/null)
+	if [ -n "$serial" ]; then
+		log_info "serial_number: $serial"
+	fi
+
+	if ! has_any_version && [ -z "$serial" ]; then
+		check_err 1 "No versions or serial_number reported"
+	fi
+
+	log_test "devlink info"
+}
+
+setup_prepare
+tests_run
+
+exit $EXIT_STATUS
-- 
2.52.0

