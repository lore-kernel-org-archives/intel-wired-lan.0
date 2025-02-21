Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809D1C021B2
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Feb 2025 00:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BA306076B;
	Fri, 21 Feb 2025 00:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10sLB1MpclY6; Fri, 21 Feb 2025 00:04:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6A6160767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740096290;
	bh=02UG6NiHl/xa+PDco2Qh8fPBNm0muRMhknrdPWpWT+o=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2sygYpm74lcgBH0ouSK5ciKdwo4Q0CJkhs935rESS0LWvodi8QPdbv5ub1EUwvDe1
	 sr0kCzE7jA4IPLEKpBkA+FxG7hJCmONqDiRaVE5pPLLtAanW6/Zkgg56wZlqJu+Amx
	 NsGFqqml3965GocRh+/gfPo3PRf/tCstqstA2oXu/M6F1s7CvEnH2BgeEy5VrZsWb5
	 vCkF8LJ7GIcSk4DozwRnVaatE8sYWMyHt29YRLhYhrEu5rYx5/F88Mckqz3Nzocf2e
	 36+vcd/QsXp/k1QAR41qrjTXaoqkUM8pSU0fcCInIAeYUHgBErKM0hkvFguZnGJ0ni
	 x6THxn8U2AwLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6A6160767;
	Fri, 21 Feb 2025 00:04:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69A0D194
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 00:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C48240572
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 00:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdqmkzjGFhuk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Feb 2025 00:04:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ED99E4026B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED99E4026B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED99E4026B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 00:04:47 +0000 (UTC)
X-CSE-ConnectionGUID: f5g3P71+Qpy7bNStbcwV3w==
X-CSE-MsgGUID: MIHywEQCRAORdcLGYYnILg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40760632"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="40760632"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 16:04:47 -0800
X-CSE-ConnectionGUID: HGi+AsruRG+GehAqXV/aVQ==
X-CSE-MsgGUID: E471+x6NSce2iOdMfKXzBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="120140460"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
 by orviesa003.jf.intel.com with ESMTP; 20 Feb 2025 16:04:46 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tlGWz-0004ta-37
 for intel-wired-lan@lists.osuosl.org; Fri, 21 Feb 2025 00:04:39 +0000
Date: Fri, 21 Feb 2025 08:04:28 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202502210822.xvxhk0qt-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740096288; x=1771632288;
 h=date:from:to:subject:message-id;
 bh=JyQ9GQ9PbLUDliVhNyi28B3QuYrIJIBoB5PRS0aA1cg=;
 b=VtrRfgPPC99TxAAqkEnNVngIFUYubDG7Z5ptf0phAMOpfO+4ErnL07pI
 UJ92s+tCR8Wnu/EUuEugiLZbYdPCvofUFdyVy9S50X2+kTrA1uHESiU/+
 znAQr3DYrMhWzMf0M7/RjCRVAD1uVILh43auLWNUC0I4OBdm9QiLTtLZE
 4A5smUYHeW2I1pY36iPoW++6Sv7Y6gga10LrhMVAnO18XeNpTty00H5SE
 zeHCvWVtazYdZOe4e84DkwkxWySx/nOc5n/hDGmyuzmZJz9yxrv+GkazG
 DGOum3eT+1vlvc1IjSHrCE1gWYgzN451jRQszWOrmRu/S8RevLMlkN2QG
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VtrRfgPP
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 76e04786735e2864bec8666e116cb1ba7bc4f578
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
branch HEAD: 76e04786735e2864bec8666e116cb1ba7bc4f578  ice: add ice driver PTP pin documentation

elapsed time: 1454m

configs tested: 74
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250220    gcc-13.2.0
arc                  randconfig-002-20250220    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250220    gcc-14.2.0
arm                  randconfig-002-20250220    gcc-14.2.0
arm                  randconfig-003-20250220    gcc-14.2.0
arm                  randconfig-004-20250220    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250220    gcc-14.2.0
arm64                randconfig-002-20250220    gcc-14.2.0
arm64                randconfig-003-20250220    clang-21
arm64                randconfig-004-20250220    gcc-14.2.0
csky                 randconfig-001-20250220    gcc-14.2.0
csky                 randconfig-002-20250220    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250220    clang-21
hexagon              randconfig-002-20250220    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250220    gcc-12
i386       buildonly-randconfig-002-20250220    gcc-12
i386       buildonly-randconfig-003-20250220    gcc-12
i386       buildonly-randconfig-004-20250220    clang-19
i386       buildonly-randconfig-005-20250220    clang-19
i386       buildonly-randconfig-006-20250220    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250220    gcc-14.2.0
loongarch            randconfig-002-20250220    gcc-14.2.0
nios2                randconfig-001-20250220    gcc-14.2.0
nios2                randconfig-002-20250220    gcc-14.2.0
parisc               randconfig-001-20250220    gcc-14.2.0
parisc               randconfig-002-20250220    gcc-14.2.0
powerpc              randconfig-001-20250220    gcc-14.2.0
powerpc              randconfig-002-20250220    clang-16
powerpc              randconfig-003-20250220    clang-21
powerpc64            randconfig-001-20250220    clang-16
powerpc64            randconfig-002-20250220    clang-18
powerpc64            randconfig-003-20250220    gcc-14.2.0
riscv                randconfig-001-20250220    gcc-14.2.0
riscv                randconfig-002-20250220    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250220    clang-19
s390                 randconfig-002-20250220    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250220    gcc-14.2.0
sh                   randconfig-002-20250220    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250220    gcc-14.2.0
sparc                randconfig-002-20250220    gcc-14.2.0
sparc64              randconfig-001-20250220    gcc-14.2.0
sparc64              randconfig-002-20250220    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250220    gcc-12
um                   randconfig-002-20250220    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250220    gcc-12
x86_64     buildonly-randconfig-002-20250220    gcc-12
x86_64     buildonly-randconfig-003-20250220    gcc-12
x86_64     buildonly-randconfig-004-20250220    gcc-12
x86_64     buildonly-randconfig-005-20250220    gcc-12
x86_64     buildonly-randconfig-006-20250220    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250220    gcc-14.2.0
xtensa               randconfig-002-20250220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
