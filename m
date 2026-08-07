Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70256C2A09B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 17:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E80D6064F;
	Fri,  7 Aug 2026 17:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7EX2pOxQvDZ5; Fri,  7 Aug 2026 17:56:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 581EE60614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786125370;
	bh=GDXoF9CinyPJhdEEKmaaI5VC+HQIgkKj7FttjEW4yD0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QCQIMvWFursRBzn4vRDDEdGIAnlPvfHJW0Fd9gWDU6wZUo6RqL5av0UiTjnga4Vp8
	 zMPdLFBbRiFKT5orMhww4UmUje9DdZBCLzrf6B5k9N5oLUEhY5NigihIw+GQpdZUUd
	 WGKE5gHi/b1XtVJ4msHSFTNrIkTh8e3LyvdhqUK70+iXIbGhazQNXnKd2TOQwpOMc7
	 cf+/RrK/v+/cI9KDpP54lyPv+h5lgePJOdAX5JmQzXwJyUa7VGLPsrxhwElw8RnzKW
	 mC4Vs7L07yxZam3JY8tBLck32WDP3ZaJDTgkRvLiUDT/cGUuBcbDXsg35hkf8GeUjA
	 xEOI2LaPT1nqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 581EE60614;
	Fri,  7 Aug 2026 17:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79DBB1AF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 17:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 622624068B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 17:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6h2kY2taglQF for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 17:56:08 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EA51D407A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA51D407A1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA51D407A1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 17:56:07 +0000 (UTC)
X-CSE-ConnectionGUID: BbVRgc3NRtiArOpsGTvt8Q==
X-CSE-MsgGUID: uLzoUJ23R5ye3je7W3ilUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104272175"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104272175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 10:56:07 -0700
X-CSE-ConnectionGUID: gokCfQ/YQfqhUhOMdGkwCA==
X-CSE-MsgGUID: 2baFxMSKS76VE6VW96+Gsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="264446118"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 07 Aug 2026 10:56:04 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wsOna-00000000Iqe-37GE;
 Fri, 07 Aug 2026 17:56:02 +0000
Date: Sat, 08 Aug 2026 01:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608080142.6VGAiJLA-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786125368; x=1817661368;
 h=date:from:to:subject:message-id;
 bh=h2uSR3r2/mMJBIzZVx1c8UhQ4lVYfV4yQ9BGf+X8HZQ=;
 b=Z+NGE44LtxPn5HVHLfD46ra3ttTDItHb2pK/2wjiW4QFkDukXd0vcFhp
 Wm9HXaHIjHlODdrtQ/mnfKXaw6W/FSARkmtbpob2S940c2vp0EpZHa3q7
 HEKkZA2FkvEeurGqOWbDqSwBx0iln7ialLh20QjNTgj5lJcwvEuYqdmm0
 /IpHsoVPekzLGTlqeCpT+5A9xTEGeR0a4b3yl8HgZxXoZkcGor01seKlc
 tre38MX5Msugg9bj0Lt6hLYDKe0E55SGR/vac9wDY5eYbPwO/JAGiZ5MK
 d2y+nYUhLjAWkFN18YS6INp4g99qjhgU7M+KV6n7Za7BVCxSLAiEp5VTq
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Z+NGE44L
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 6da7adaa29975305bcae253c620c9f5c710c9e21
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
branch HEAD: 6da7adaa29975305bcae253c620c9f5c710c9e21  i40e: xsk: use xdp_build_skb_from_zc() for XDP_PASS

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1616:1: internal compiler error: in final_scan_insn_1, at final.cc:2823
    drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c:438:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1586m

configs tested: 63
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260807    gcc-8.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-001-20260807    clang-17
arm                  randconfig-002-20260807    gcc-12.5.0
arm                  randconfig-003-20260807    gcc-10.5.0
arm                  randconfig-004-20260807    gcc-16.1.0
arm64                randconfig-001-20260807    clang-24
arm64                randconfig-003-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-14.3.0
hexagon              randconfig-001-20260807    clang-24
hexagon              randconfig-002-20260807    clang-24
i386                            allmodconfig    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-24
loongarch            randconfig-002-20260807    clang-18
mips                       qi_lb60_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    gcc-8.5.0
nios2                randconfig-002-20260807    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260807    gcc-9.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-001-20260807    clang-24
powerpc              randconfig-002-20260807    clang-24
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-14.3.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260807    gcc-10.5.0
s390                 randconfig-001-20260807    gcc-9.5.0
s390                 randconfig-002-20260807    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260807    gcc-16.1.0
sh                   randconfig-002-20260807    gcc-16.1.0
sparc                randconfig-001-20260807    gcc-15.2.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc64              randconfig-001-20260807    clang-20
sparc64              randconfig-002-20260807    clang-20
um                   randconfig-001-20260807    gcc-14
um                   randconfig-002-20260807    clang-24
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-002-20260807    gcc-14
x86_64     buildonly-randconfig-003-20260807    gcc-14
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64               randconfig-001-20260807    clang-22
x86_64               randconfig-002-20260807    gcc-14
x86_64               randconfig-003-20260807    clang-22
x86_64               randconfig-004-20260807    clang-22
x86_64               randconfig-005-20260807    clang-22
x86_64               randconfig-006-20260807    gcc-14
xtensa               randconfig-001-20260807    gcc-8.5.0
xtensa               randconfig-002-20260807    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
