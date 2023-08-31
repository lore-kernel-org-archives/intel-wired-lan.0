Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E5C83F29
	for <intel-wired-lan@archiver.kernel.org>; Thu, 31 Aug 2023 06:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE77641BDB;
	Thu, 31 Aug 2023 06:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE77641BDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693461616;
	bh=xnkMa6h2R3ZcTtxH5o0oXCSO4C6lLYoN6xL28KhC9FA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7c80Gf8nvD9sxvHuIpDRX2Cxe5iN5vlCXFsGhzJkH/uM42Vorhj2paxLCntyYYTEL
	 k6p4kkD/7gTJFGwzV1acea/hpjfRv85442WEHApuO2DigCF4bVSHkx3rXfbZkQciFM
	 Wa0hb2zUYC2DOXtR3y6TzQdH4nm7FeU7xvkRMg8cfz4ShKQ2aQuwXu0HRwNaQ+t02F
	 Pb08rc0T+vNUsiGsVTXkWoYuhxJAVwJZIHBi5FnvesxjFYAFZ0SsPViAg0B2vXHJow
	 I1NvR68acXqTrl6+A480Mrjm2GUEJEe04VRxMzdc3FDKT+Itx8BfWbCpmYMGV5F06n
	 zvDU6aPzuU1EQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nj4iL4eMuOb3; Thu, 31 Aug 2023 06:00:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DE4141BE9;
	Thu, 31 Aug 2023 06:00:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DE4141BE9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 568D41BF4E6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Aug 2023 06:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D05260B29
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Aug 2023 06:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D05260B29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTpGetoAUjEO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 31 Aug 2023 06:00:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F079660B26
 for <intel-wired-lan@lists.osuosl.org>; Thu, 31 Aug 2023 06:00:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F079660B26
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360811205"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; d="scan'208";a="360811205"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 23:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1070099696"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; d="scan'208";a="1070099696"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
 by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 23:00:11 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qbaiv-000AvS-2x
 for intel-wired-lan@lists.osuosl.org; Thu, 31 Aug 2023 06:00:09 +0000
Date: Thu, 31 Aug 2023 13:59:41 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202308311339.6POgofSB-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693461613; x=1724997613;
 h=date:from:to:subject:message-id;
 bh=fJwMrHicrjh4udrhnPdCsHj7CRIgi9J0C2wEZkClq/E=;
 b=VDEHuEpAi09euGk38dVxSJSvPo4LmGeWLPm+qqaaiPY+GzTCLspO4aYL
 S4YHjCeIuOI8wqnVKX93pJtV3oh3Cq35iVcPKfekxh/aQF+s+zLf6ogFd
 +iQK0Mizkzkpdv2Wt917czHhj/uesI6mD3L0E1/ykM9kELiXNXFeemDzb
 03H858yej5nOPWVYPZoG56xUU9iWMjK+AgeTCj25w4idddNMakyzrFyLx
 aDaKfzxS9XzPpydAEUVxw1Jw3TRGktXVu29SlB5tCuySQ/P/+UV4AWCgo
 GvYsVHmqYXULB/K1eiZVh8N1s/+i4FRw+d40QTIRW8qCzlX/wG23XAkUf
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VDEHuEpA
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 8983daa3e4ff444cd2c070217adfa0fd9a94a47c
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 8983daa3e4ff444cd2c070217adfa0fd9a94a47c  igb: clean up in all error paths when enabling SR-IOV

elapsed time: 1837m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r033-20230830   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230830   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230830   clang
arm                  randconfig-r013-20230830   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230830   gcc  
arm64                randconfig-r024-20230830   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230830   clang
hexagon               randconfig-002-20230830   clang
hexagon              randconfig-r014-20230830   clang
hexagon              randconfig-r016-20230830   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230830   clang
i386         buildonly-randconfig-002-20230830   clang
i386         buildonly-randconfig-003-20230830   clang
i386         buildonly-randconfig-004-20230830   clang
i386         buildonly-randconfig-005-20230830   clang
i386         buildonly-randconfig-006-20230830   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230830   clang
i386                  randconfig-002-20230830   clang
i386                  randconfig-003-20230830   clang
i386                  randconfig-004-20230830   clang
i386                  randconfig-005-20230830   clang
i386                  randconfig-006-20230830   clang
i386                  randconfig-011-20230830   gcc  
i386                  randconfig-012-20230830   gcc  
i386                  randconfig-013-20230830   gcc  
i386                  randconfig-014-20230830   gcc  
i386                  randconfig-015-20230830   gcc  
i386                  randconfig-016-20230830   gcc  
i386                 randconfig-r031-20230830   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230830   gcc  
loongarch            randconfig-r001-20230830   gcc  
loongarch            randconfig-r002-20230830   gcc  
loongarch            randconfig-r003-20230830   gcc  
loongarch            randconfig-r004-20230830   gcc  
loongarch            randconfig-r006-20230830   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230830   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r034-20230830   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230830   gcc  
nios2                randconfig-r025-20230830   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r021-20230830   gcc  
powerpc              randconfig-r022-20230830   gcc  
powerpc              randconfig-r026-20230830   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230830   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230830   gcc  
s390                 randconfig-r005-20230830   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r032-20230830   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230830   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230830   clang
x86_64       buildonly-randconfig-002-20230830   clang
x86_64       buildonly-randconfig-003-20230830   clang
x86_64       buildonly-randconfig-004-20230830   clang
x86_64       buildonly-randconfig-005-20230830   clang
x86_64       buildonly-randconfig-006-20230830   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230830   gcc  
x86_64                randconfig-002-20230830   gcc  
x86_64                randconfig-003-20230830   gcc  
x86_64                randconfig-004-20230830   gcc  
x86_64                randconfig-005-20230830   gcc  
x86_64                randconfig-006-20230830   gcc  
x86_64                randconfig-011-20230830   clang
x86_64                randconfig-012-20230830   clang
x86_64                randconfig-013-20230830   clang
x86_64                randconfig-014-20230830   clang
x86_64                randconfig-015-20230830   clang
x86_64                randconfig-016-20230830   clang
x86_64                randconfig-071-20230830   clang
x86_64                randconfig-072-20230830   clang
x86_64                randconfig-073-20230830   clang
x86_64                randconfig-074-20230830   clang
x86_64                randconfig-075-20230830   clang
x86_64                randconfig-076-20230830   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r015-20230830   gcc  
xtensa               randconfig-r036-20230830   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
