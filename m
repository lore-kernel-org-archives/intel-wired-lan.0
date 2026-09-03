Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48015C624A4
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 16:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F238440B0F;
	Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9h1bL0830NhD; Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1F71640B14
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788451401;
	b=cQHNfWS4aJDO9QBQ2nwDX+fGOW6qROIBCLaBfSXOmraNjJ3xL30cXA6S/CS4npCVs5xv
	 6UVOkY/S4tR7i38LfRc257k0jtvgCxIInbk6NVJlBFmZxI3lSpFNzNBRcqjBj5FwnhoQb
	 ELTz4BEIEqVqVCbmJPPKyMUto9XYzvZMUbp1kUeRNU1uhs8Wtk6zadlyvsg4G2iWPsl8c
	 LglIwoy9+mbr8MYLctFNFEyX68bD0qubuyt0LmUlRd2Wga0yaW7/SWGMBQu4r9/TTOEsC
	 K4T6qZJu6AQHba+j53FzniVmlexfjIg5/UTAv+KNDT8sOoH72hu9qB1C+PY7s1JVBEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788451401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1njU0IawZbfykAAnL5k089e4/pUgbi8YQe0Q3hnkXAc=;
	b=qS3q/T+wgJ7TVxq8O+NS6jaJiBOdLNSjR3nEL+OpS9AruqMaVxRltmOWfgj2HGYnGNJO
	 ghN3BU1GYLcpcNe//FvXUw727IjpkBJrgCJ/+wnB/n3CMxn88kjzmAgkl1Hhw4PZHJsoP
	 pn+mdYGMjaarEyU97vtoIXRhE2EE1anxWdsxgwSfMD34Q2MKLBhgZGnx1ZodR8hRWxb3S
	 dcXU4mHFYzQxq3sSMga0yeSQxTt3h2Yo7RJsCDbblcsmHbJ3BSeIoAUrfDG/3kRIW5kgB
	 8ZbLJwYIp/iAhjBDuPm8Kx6DV8MCStFsl51qALb45z7wRX8WxlQOqnm7HRb9EE1DDfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fA2y27VM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788451401;
	bh=1njU0IawZbfykAAnL5k089e4/pUgbi8YQe0Q3hnkXAc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dNFsnVRMlUcZU5LuM3X+lHD9cS9o6if9toAkI5MTzhClGwUOGp46F/ZTwhNq8k3fE
	 Zk6jwB86FIFNEV8NILn37SCzyQsANTczHXH4E3ApFSkxbHd04rAOU5LQfs37vKewmW
	 fIcQGKI+TRst2sUgw5Jk7N9kBsMt5OnISTx9t2gBE7WipjQmw7CkwjAtp1wgd0XSTy
	 PCuT0v/SSoxnaR9JNKHG0l13cg78K8tOE8OBdgdtbAGqLv2M2+DTuWYrqKj9KaDIG1
	 slwTHRHWxqUG4x4l48YFNw6KzJ4kPnV4pqj+tNANhlo64DpyTUIQc6nCQxxRJEbkoq
	 5V/4b/TGPE9vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F71640B14;
	Thu,  3 Sep 2026 16:03:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F1912FD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1099640B0F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQmzjzjh3pQw for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 16:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1900F40B0E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788451398;
 b=NqRfPv3yW4U2rEarohqAvEPyA8kwv2ufQ+8rcwM90MoI2sEf8voi1QSX9aO9vlk/9KUq
 XABBP9/TgNpLVPUCwkwQ7164qjnccVo//zVL49FQE7xpWc7uZe71MaKXWEwg4iilBhVbc
 0u34tEYOI9gp1AerKAZ2IhLAAe2bPKkqrYjjmbsSL2K9XRK+dL7L21FJlOOKd8XDD231V
 /oH10Ct6EieDxFOj3+FRWVb4xcBFFtKF1D0K16cD8w6/Nv8W208xvaIveNiNRlU/K/i3S
 W4OJi0XVSoj4HgMX4IQN7yAEHIaXaQPtCnx+XtOiOtEhZ5TSN3r3HRu+cqKSNzyIGAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788451398;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=1njU0IawZbfykAAnL5k089e4/pUgbi8YQe0Q3hnkXAc=;
 b=IqLGlABSf9qjTun4EZ9+RP8H0uTYWSF7+j/LTp4IK0ojezaOUyw/ot1Y85A808zimRwN
 GkZbkBTuIqwz6K4ea51gaEbjktEabktnDwR5gHXr+C0883UBnOp+0Um9fj93V/DCcWkVd
 joQ43AkD7whYe4z6xTz5GKtApzU9hP81HgVtbhoyVtQQlXEcUsOCWxCnY5G5qegKKj6Vd
 5bosCU9tok8eD7ppbp/KUQJ6tEL4Wh3t4hvawnN7pnOxHck6iTJT6IJxx3knmVtD5Hkul
 8OkuVzCCDOkS9PHN3kr8EcWeLz14byiKtxmKlPSN+RLH+dYlN+/WuTHqaCJQiW/KCMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fA2y27VM; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=paul.greenwalt@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fA2y27VM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1900F40B0E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788451398; x=1819987398;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vDlY+Xlg5D8S4Ln3/ypXgyPuNrs9C/6x2ALGSTk39GM=;
 b=fA2y27VMqNhfJndDQQVFR7r2OWljKKtZMFMT0eaOe7/CfRo4hPRCUmu5
 z4f9b1hiX1i9bZJ7ftmJbTEiF2KWWTzXOhe4nMHltjGY5YtZzqkzZfa0j
 yxq19r9gT8MlhH2dssFo6KUyHNzlPW1RIWwL45SYfpdVbAQ3MdQtfHYis
 Pz5qYF/Y4BbR5V6wiNQvpvL9UUpuYDlAb3e5aSfTp0Y4yM0x/OlQc9TGm
 5DsSOV8VdKNa7PNQGyOs0Hx56/w7W9EDKhGEBF0lmVGBFgFGyBy188589
 gacL6/MLmAkRviqVQUS6QSCl3Of+nlH9/JxFuyHovlHUP5eir/+nwMJgi g==;
X-CSE-ConnectionGUID: SqhXqX8qRaW/nj08wb+m6Q==
X-CSE-MsgGUID: jg+mdn0pSuSu0IovSpk2iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76492942"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76492942"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:03:16 -0700
X-CSE-ConnectionGUID: ZAFSPah/RuWNEvum319h5A==
X-CSE-MsgGUID: Oj0ZGWZjRjKCGXIwGYIBfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="293270193"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.5.147])
 by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2026 09:03:16 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 0/4] idpf: add devlink info support with selftest
Date: Thu,  3 Sep 2026 04:27:38 -0400
Message-ID: <20260903082742.43837-1-paul.greenwalt@intel.com>
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

Patch 2 adds the devlink instance. It is registered once the virtchnl
handshake has completed rather than from idpf_probe(), so the instance
is not exposed to userspace while the adapter is still coming up.

Patch 3 implements .info_get and reports:
  - serial_number: PCI Device Serial Number, for NIPA CI identification
  - fw.mgmt.api (running): driver-device communication protocol version

This follows a phased approach and reports stable, readily-available
information. Firmware version support will be added in future patches as
it becomes available through virtchnl.

Patch 4 adds a hardware selftest that logs devlink info in the format
NIPA CI consumes.

v1 -> v2:
- Patch 1:
  - Reworked: instead of adding a second, redundant pci_set_drvdata(NULL)
    at idpf_probe()'s err_free label, move the clear into
    idpf_decfg_device() so it pairs with the set in idpf_cfg_device(),
    and drop the now-redundant explicit clear in idpf_remove().
- Patch 2 (new, split out of the old patch 2):
  - Register the devlink instance from idpf_init_hard_reset() once
    idpf_vc_core_init() has succeeded, instead of from idpf_probe().
    Registration is guarded by IDPF_DEVLINK_REGISTERED since
    idpf_init_hard_reset() also runs on every function and PCI reset.
  - Unregister only after the init/reset worker is quiesced, and only if
    registration actually happened.
- Patch 3:
  - Select NET_DEVLINK in Kconfig.
  - Omit serial_number when the device reports no PCI DSN, instead of
    reporting an all-zero serial number.
  - Pass the buffer size to the DSN helper rather than hardcoding it.
  - The version guard is no longer needed now that the instance is only
    registered after the virtchnl handshake has completed.
- Patch 4:
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

Paul Greenwalt (4):
  idpf: clear drvdata in idpf_decfg_device()
  idpf: add devlink support
  idpf: add devlink info support
  selftests: net: hw: add devlink info test

 Documentation/networking/devlink/idpf.rst     |  30 ++++
 Documentation/networking/devlink/index.rst    |   1 +
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   4 +-
 .../net/ethernet/intel/idpf/idpf_devlink.c    |  94 ++++++++++
 .../net/ethernet/intel/idpf/idpf_devlink.h    |  45 +++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   8 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  19 ++-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/devlink_info.sh  | 160 ++++++++++++++++++
 11 files changed, 359 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/networking/devlink/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devlink.h
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_info.sh

-- 
2.52.0

