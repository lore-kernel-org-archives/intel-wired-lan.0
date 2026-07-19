Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B60C4450A
	for <intel-wired-lan@archiver.kernel.org>; Sun, 19 Jul 2026 01:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9779780B3A;
	Sun, 19 Jul 2026 01:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZW8qWCgMGPz; Sun, 19 Jul 2026 01:15:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBAB880D96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784423734;
	bh=vOJrX5yfW892Vb9f33W09RKzOIbTPrv0EQfAFCKqDXM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yqOPApVFR4dTpSbzob8HXvApvrGyqj8tPVnvqO2S79pjYH00BpnIyntoLbkrRNzq/
	 pDM3Ij9Rg2ow1sqo+r3YVCWgz48gge79v0NhMsrpAvBuSpjH5aihjtJvhzWPb5ilP/
	 Xifxm2iJb0PHm4E9Cv0VUF50gfmH6dgyX8c4Fp91oDnKXre+cZvY4mzjawAWHYadOU
	 5jGrMR/WtB3q5Zc4+GXupRnm81+sCNwD5xCyGiSRqOq7xUlzmuYczTwmNwqJezXEav
	 meOSOGpw4xmXSdFUsIJCXm0fyKfHSBKAzsRuq6R1Dbn247Y01TPOedsryBBsdy/oO7
	 OZoHxJrj+CN+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBAB880D96;
	Sun, 19 Jul 2026 01:15:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8BB3320
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Jul 2026 01:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE3DD80D96
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Jul 2026 01:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDqks0tec1WV for <intel-wired-lan@lists.osuosl.org>;
 Sun, 19 Jul 2026 01:15:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A9C3380B3A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9C3380B3A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9C3380B3A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 19 Jul 2026 01:15:31 +0000 (UTC)
X-CSE-ConnectionGUID: YW0tN6eGSPeRg5Ys8Klz5w==
X-CSE-MsgGUID: irbXhHncQ5+eoU5dEhWMyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="96184337"
X-IronPort-AV: E=Sophos;i="6.25,171,1779174000"; d="scan'208";a="96184337"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2026 18:15:30 -0700
X-CSE-ConnectionGUID: YRZX3EmVSgui5DOWPJnMBw==
X-CSE-MsgGUID: uGNznfrdS/Gx3kxFkK5wOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,171,1779174000"; d="scan'208";a="252723696"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa006.fm.intel.com with ESMTP; 18 Jul 2026 18:15:29 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wlG7r-00000000VEk-3G0e;
 Sun, 19 Jul 2026 01:15:27 +0000
Date: Sun, 19 Jul 2026 09:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607190922.vOOKRsxD-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784423731; x=1815959731;
 h=date:from:to:subject:message-id;
 bh=0tBpYnRFnPcbBYdlcxpP97F9FLjp+wx+lw2KLRhtbCI=;
 b=kEjaOIWvUbBmxhAXsKs92Ji5l3VJyvTaXW8S7ZF5NrcYctpKkt9h7XTL
 IqbeFEMvkbYPEYb9iehPnKbZ4SlVWuUl3/QnmC0XdilFGqRQ4dRLQFMba
 d/dDOHePuSZZyAP5Yh4oks30sLkGiXfVhEu+ckOgpwvMjbyKPS9/VPans
 7GAMFlUXIzuxZZ81aPuEk/FicL1h+cveVZd1LaWrw2OrFKnAe3nIVsiAH
 xbVPLQLEAFzzRFqN4qg9sGF++Q/UiYO9rht9/XgysBBnSLX0yRDxZ0AmT
 fxEu9u5hPKC1i0HWR2pfIxzG0B3jLULg3NNMwAuFu9PA1LlBA6G2E4YRl
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kEjaOIWv
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 37991387fb6da8d811a0d61bc8df8206350f954f
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 37991387fb6da8d811a0d61bc8df8206350f954f  igc: Support ACPI-based MAC passthrough

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c:438:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1705m

configs tested: 16
configs skipped: 0

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch  randconfig-001-20260719    gcc-13.4.0
loongarch  randconfig-002-20260719    gcc-15.2.0
mips             omega2p_defconfig    clang-17
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
sh                       defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
