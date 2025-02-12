Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05934C02198
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Feb 2025 17:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A963460EA9;
	Wed, 12 Feb 2025 17:51:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUqz-rwtBbEG; Wed, 12 Feb 2025 17:51:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C54A2610E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739382687;
	bh=pT0STmcwRqpl9mELiz4I9jtqUQwxVABfWRw/ZixL4BE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IKtebBgvSoiAEo2eBjol0Vz1CW0eY1os5bIC8eOZxCNPuFKsMVqUPoZksn+E13s3R
	 muj7AcIHEOvLplSEIB0h5ueU+DrUD1XS5Dcb350/XXSwTPvrar5qx7jjb+p2S/R5aK
	 8MRFQH1nlwVq6DG4PlJv5F7I387kppT7fd9l+P7v4hhTm+R/ELu48JUDXmeO9dYk3x
	 UrVVHludbIQIhA84lC79CqZAeVwHHiwbIMCJXx4jLG1lHosYoF7AY+/CyP8SypHMIs
	 JOLSws00/sMznSyq4zaH5PvVDKJUpSYA8+O2iXM2PQmO5bG7dc5W1ImpdVQ1FrXU20
	 LKPr95GJs/mnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C54A2610E0;
	Wed, 12 Feb 2025 17:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 386C2C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Feb 2025 17:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F761610E0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Feb 2025 17:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMZ825ym_-yq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Feb 2025 17:51:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0609A60EA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0609A60EA9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0609A60EA9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Feb 2025 17:51:24 +0000 (UTC)
X-CSE-ConnectionGUID: aEN1TeeWStmgvBsCFUm9ag==
X-CSE-MsgGUID: 1HmeLrnbTOuU+JhIVEyM2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62523022"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; d="scan'208";a="62523022"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2025 09:51:25 -0800
X-CSE-ConnectionGUID: 2PZ+FoFrSx+6LFgxaF7fhw==
X-CSE-MsgGUID: tMoTrAyIQc2nfqSjXKGLeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="117835371"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 12 Feb 2025 09:51:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tiGtN-0015wv-23
 for intel-wired-lan@lists.osuosl.org; Wed, 12 Feb 2025 17:51:21 +0000
Date: Thu, 13 Feb 2025 01:50:52 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202502130145.Z3Ty3tEA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739382685; x=1770918685;
 h=date:from:to:subject:message-id;
 bh=C7QTJ4CkP8qJJ1oTQ0EacKwKaZOvVNRoEwIr4FMAjKU=;
 b=FoAVEZUeHrywHrVSslZayHFRW9vBIkE1BrfKCGcRn0pg69RMlR7i+sOK
 +a6MhYzJpZBfuXhhT2ITHPau6x0ycB04FsUcmbFlJRfFHvRZ1Srsfvyt8
 l5quPw5VXJkCK295zq2lsT74EQgdop9sdC5st84+BOjFGmhKQcBHwly+P
 pmJdV0uoKD4R/OJv89FtELRFG0ppqxNUwq9phhOQHMz6sFZ1IE1YbyRe2
 j211ahvBf1XCB6FUU+0KzC/wVIihsBN0Nj7lx2w0C62kuAEZymtjWxVzk
 PwGVQLSF94acwHAaBCy/McFuD8AqsjRxNaBJxl0tAwlRJVa+VmQFyhmOz
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FoAVEZUe
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 5a97b87b2375249e0c8dbc7fbcedcf06e4e3cfcf
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
branch HEAD: 5a97b87b2375249e0c8dbc7fbcedcf06e4e3cfcf  ixgbe: add PTP support for E610 device

elapsed time: 1443m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250212    gcc-13.2.0
arc                   randconfig-002-20250212    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250212    clang-18
arm                   randconfig-002-20250212    clang-16
arm                   randconfig-003-20250212    clang-21
arm                   randconfig-004-20250212    clang-16
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250212    gcc-14.2.0
arm64                 randconfig-002-20250212    gcc-14.2.0
arm64                 randconfig-003-20250212    clang-16
arm64                 randconfig-004-20250212    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250212    gcc-14.2.0
csky                  randconfig-002-20250212    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250212    clang-21
hexagon               randconfig-002-20250212    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250212    clang-19
i386        buildonly-randconfig-002-20250212    gcc-12
i386        buildonly-randconfig-003-20250212    gcc-12
i386        buildonly-randconfig-004-20250212    gcc-12
i386        buildonly-randconfig-005-20250212    gcc-12
i386        buildonly-randconfig-006-20250212    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250212    gcc-14.2.0
loongarch             randconfig-002-20250212    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250212    gcc-14.2.0
nios2                 randconfig-002-20250212    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250212    gcc-14.2.0
parisc                randconfig-002-20250212    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250212    gcc-14.2.0
powerpc               randconfig-002-20250212    clang-16
powerpc               randconfig-003-20250212    gcc-14.2.0
powerpc64             randconfig-001-20250212    clang-16
powerpc64             randconfig-002-20250212    gcc-14.2.0
powerpc64             randconfig-003-20250212    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250212    clang-21
riscv                 randconfig-002-20250212    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250212    clang-15
s390                  randconfig-002-20250212    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250212    gcc-14.2.0
sh                    randconfig-002-20250212    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250212    gcc-14.2.0
sparc                 randconfig-002-20250212    gcc-14.2.0
sparc64               randconfig-001-20250212    gcc-14.2.0
sparc64               randconfig-002-20250212    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250212    clang-16
um                    randconfig-002-20250212    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250212    gcc-11
x86_64      buildonly-randconfig-002-20250212    clang-19
x86_64      buildonly-randconfig-003-20250212    clang-19
x86_64      buildonly-randconfig-004-20250212    clang-19
x86_64      buildonly-randconfig-005-20250212    gcc-12
x86_64      buildonly-randconfig-006-20250212    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250212    gcc-14.2.0
xtensa                randconfig-002-20250212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
