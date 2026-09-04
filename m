Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE30DC624D3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F6C681157;
	Fri,  4 Sep 2026 18:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Meh2sCqdBlif; Fri,  4 Sep 2026 18:12:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 831288114C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788545557;
	b=iBgY9f04fs3L7hUIhZanQKOBKELRAzbU73OAEVnoN8GIbcF+UAGYx7Qa2XaRv4t/pEnY
	 WZXvFHEy432ZdSONUDQZG+6RXs0htoWZSw0Kdk7Zu17y5RcFea99FMDO8ovuQsCCmMjGY
	 KIJRwq5bxY8YRY/+xhSgFIKg6ugchHOlIfvZBmI/s43kGgyIp87vhG34nxZvGj4VTOFT3
	 CaVqTBjt9SUM66UPUzw8b0tFrz1u4tTMf80L1O6LlVMGA0CpM6lqBGa57DQbw6iDsqYyS
	 AZvqahMThWQPzeldGWIbVJucD7IzBbuGOOsVjC4SwWaJ8zBjmAv54k/dEov1qZIysNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788545557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+LsAmrwUk58kk3dL2xo7eOhnb4EtITPbmzGqEjEgPCY=;
	b=eXIPhxI7nc1RA8tP1Oo75G1kc19gKIT2XVdKi0xvyqJ53FmltgdIGbSwfc11JuSP3Ko2
	 HsmAKrey1jeTqIb1SZ5uGpud4DhsxvNUVR5BOlBiW2B/gGYzoYEUTxZwBa7At+ohMqXok
	 7SGygtJ20WAovSnjNGyoJRfFRmZKkKR+0HKJVatPPZc5IHf7RnKLE4V+IyHF4ZmBiq1Nm
	 BDZ8lLsaSo7o8Q7v1+0mFMSgSpFivfmgT2ccEB5RcqRV15sHTt/QblV83JrfpCYO8MUoz
	 du7VfVrGqi5tm1yRxO4TPy82uEs9bnJleUXbtrwKZfAsnLlARkFh4nOLIVjHpQdrBhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788545557;
	bh=+LsAmrwUk58kk3dL2xo7eOhnb4EtITPbmzGqEjEgPCY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YHjxb2i8IM0ZeoMB0oJUQqRLa/8WIHuWitKcO3KaQ2+ZXODODrPebPPhA3ZukjeFZ
	 M764GOCU3rzmZtF/PX0Rt1BtsIROYs3CsYg4bbefIhJheIv3WRBUjqWmNpIR8Te724
	 CUYXFMUeAgVfvd7F9A4OWp8dxnNDZGm5TsXEiBenmownwSyfi009eBTcLwYfuOdpZJ
	 hKUJ+8uCy1xWvaw7l68MtB6QPpot+VczDxLV0D/yRIKJ9UbYtCAtfLjMIoCoI8fI9F
	 uLVt6s/4dZn5PToIiFQD7N8yYbYYULscgUS8fppGHlMHbE0/F2LT14m6dzH92JQ7yY
	 N+IRa+OleIuuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 831288114C;
	Fri,  4 Sep 2026 18:12:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C4BF29B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41BFD404ED
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5uk3rE-lIlg for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 18:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4834140143
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788545555;
 b=c4mkI3g63LF3QjURSCefzBCdSuZ7gjVQrYO34StQ0pa8qsFssx03JfSh/O5VKy0JtWsY
 Dh74OZYg8rxW0tCTEPG86pcI7NSrU6t3B0aAn7fC2jh3/4/sZnycSBOBkrAewKEbajNOw
 mEVUxnKvUvC7E9DgZU1EY6Mfq4lDZaDXMdG1RgdU9pgqWQp1gssUiVZBIbcM/uzQEdowj
 WMfMc3fJ0uN+Jf8Cvzi4MBHmZl6RCrHWYxkjO00Hla0YzOe/lFMK81tOIs9R7iGE3WGbO
 Z+kJz7lEdDIB4/cLumyz475rpuYPB9BPJYKHL2RZTQE512kJmnW8NdIJ5hqEodBt2dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788545555;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=+LsAmrwUk58kk3dL2xo7eOhnb4EtITPbmzGqEjEgPCY=;
 b=Amvszq4/RbRqJhTwgU8LRGadm/HVOCyuG4y6uNXqRZV0IKZGwRzK2NbnQG/c3KzD/nEE
 dNoSrycy9uVlNOUDJknw/8TjVGhrSqeIcf5EKKwbWDeoijYst9AnJPHmkqaAYqUZD4+IA
 5Jq3wzpZd0Y31QYUrbQ+dk5YoswAKm87FAEgojBptSYWJoVPt55TMIDWHXzBrkuqaohAT
 6O4ng54eZO4adtFSpZpnlPnxzoUuMIr/NTDwT/2F0H5efFEmZreCEsMDI5qIzKugG4DOR
 ph9B5K0pWxn6DhuLbWVv59iHN9hhnVXkNkbQfwtLkvzluDg1oxQ3/Rxiqj78y9Bnxsg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YMXEDjUv; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YMXEDjUv
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4834140143
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788545556; x=1820081556;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CCP1aLa16TX+XNs3QoYyKSeAWpz6nlqIaV1KDEBmgqs=;
 b=YMXEDjUvYp7bRTW/9aORaYAXgQavQrYB1EZ/0GE3HbVZWM5LQT/dfIIM
 HBSm5PX0Af+fCcKluzTi4aXB6qOX0kNlwo+Yl361fRBUV7KOBEHKhOgmT
 ibpgfz1lsyNI7l7yQ0q8Od72KgVY+7jc9kW0tzxJ7OuwAb/rHu3gU1ANi
 rFwcJfn/hy+llJeykvJBTnPMb5UT6A3GSDEYis9YX53v29UIsRjHotMzY
 tCtmxCFb8AXj25vgFpX94zbVSBwpMJlQ94/sMXx88uXqoz9vF8lrgkLW7
 Bc9vXEj+tEp5w+JJ50tVljoX3d5fKiE8cDG+DaiQ3FTPLWiO6R4fD2+cm w==;
X-CSE-ConnectionGUID: vrjQhYJ7REmM0GEofHpa+Q==
X-CSE-MsgGUID: Y85+BcjfSP+vqXkACNTQgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99385434"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="99385434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 11:12:34 -0700
X-CSE-ConnectionGUID: hWDnpN8/SgWwEQdbDjQC8g==
X-CSE-MsgGUID: 5WWbPWz1RJij01QGOIQCHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="269577544"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by orviesa008.jf.intel.com with ESMTP; 04 Sep 2026 11:12:34 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v3 0/3] idpf: add devlink info support with selftest
Date: Fri,  4 Sep 2026 06:37:11 -0400
Message-ID: <20260904103714.978256-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.52.0
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

Add initial devlink support for idpf and a matching selftest.

Patch 1 consolidates the drvdata clear into idpf_decfg_device(), the
declared inverse of idpf_cfg_device() which sets it.

Patch 2 adds the devlink instance and implements .info_get, reporting:
  - serial_number: PCI Device Serial Number, for NIPA CI identification
  - fw.mgmt.api (running): driver-device communication protocol version

This follows a phased approach and reports stable, readily-available
information. Firmware version support will be added in future patches as
it becomes available through virtchnl.

Patch 3 adds a hardware selftest that logs devlink info in the format
NIPA CI consumes.

The changes in both revisions below address findings from Sashiko AI
review of the series, together with direct review comments on v2.

v2 -> v3:
- Patch 1:
  - Drop the comment above pci_set_drvdata().
- Patch 2 (was patches 2 and 3 in v2, now squashed):
  - Register the instance in idpf_probe() rather than from the reset
    worker, so it stays available for the whole time the driver is
    bound, including when the virtchnl handshake never succeeds. This
    drops the IDPF_DEVLINK_REGISTERED flag added in v2 and no longer
    touches idpf.h or idpf_lib.c.
  - Omit the virtchnl version until it has been negotiated, as the
    instance is now registered before the handshake runs.
  - Read the version fields with READ_ONCE().
  - Include linux/pci.h and linux/unaligned.h directly.
  - Fix the SPDX identifier and copyright style in idpf_devlink.h.
- Patch 3:
  - Report skips through log_test_skip() so that a ksft result line is
    emitted for every exit path.
  - Do not fail when the driver name is absent; whether it appears in
    the JSON depends on the installed iproute2 rather than the kernel.

v1 -> v2:
- Patch 1:
  - Move the drvdata clear into idpf_decfg_device() so it pairs with the
    set in idpf_cfg_device(), instead of adding a second, redundant
    pci_set_drvdata(NULL) at idpf_probe()'s err_free label.
- Patch 2:
  - Select NET_DEVLINK in Kconfig.
  - Omit serial_number when the device reports no PCI DSN, instead of
    reporting an all-zero serial number.
  - Pass the buffer size to the DSN helper rather than hardcoding it.
- Patch 3:
  - Read NETIF from drivers/net/net.config as documented in
    drivers/net/README.rst, in addition to the environment.
  - Skip, rather than fail, devices that report no versions and no serial
    number; implementing devlink info is optional and devlink reports a
    driver name even when info_get is absent.
  - Count and log board.serial_number.
  - Treat a devlink/ethtool driver name difference as informational; it
    is legitimate for e.g. mlx4 and DSA user ports.
  - Do not require ethtool; it is only used for an optional fallback
    handle lookup and the driver name comparison.
  - Query devlink dev info once and validate a single snapshot.
  - Log the reported versions.

Paul Greenwalt (3):
  idpf: clear drvdata in idpf_decfg_device()
  idpf: add devlink support
  selftests: net: hw: add devlink info test

 Documentation/networking/devlink/idpf.rst     |  30 ++++
 Documentation/networking/devlink/index.rst    |   1 +
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 .../net/ethernet/intel/idpf/idpf_devlink.c    |  98 +++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    |  45 +++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  16 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 158 ++++++++++++++++++
 9 files changed, 347 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/networking/devlink/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

-- 
2.52.0

