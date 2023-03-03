Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CEEC678D4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Mar 2023 06:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A548F60FE4;
	Fri,  3 Mar 2023 06:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A548F60FE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1677826498;
	bh=I1CZsqqw5/p6TxUlQmgR18Ots8HnZph62wqoX7bD/vs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2rd4PbPM4bEcwhOP0n32kjw3j3vegLqbFaXa/qjmcpHDCAH69Y7We1bYF8WK07Wk6
	 COaij2rdpiPPDhCMqIhhRNnb44CcqZdKCPYAtXfzsXN4XCsafzyU7/m4Tu089ojibf
	 KYor324B4CgH1WWoQ2j02LQwAZ1eKOj+RgNHpaNdFE//widQTklchzfpp3ankk4byy
	 gnaXugIp2CRdSv8AU8cnYGEFGHWMxu9aAmRc/QdJHNPn5vVesTCSlualKs+SkMYkQX
	 FhK2CfKz3usCdwuiaM6xXFHfK14pLm17pMkrFquvjiT02f4LpTscYb0QJw1qN9ck5w
	 +XcQf46QydnHw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K89STwZ4z9Rb; Fri,  3 Mar 2023 06:54:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90AF360B2A;
	Fri,  3 Mar 2023 06:54:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90AF360B2A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 543C31BF2FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Mar 2023 06:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E11160FE4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Mar 2023 06:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E11160FE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLG96lIm_p2K for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Mar 2023 06:54:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1C7A60F29
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1C7A60F29
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Mar 2023 06:54:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="336491306"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; d="scan'208";a="336491306"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2023 22:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="652693281"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; d="scan'208";a="652693281"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 02 Mar 2023 22:54:52 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pXzJb-0001H1-2p;
 Fri, 03 Mar 2023 06:54:51 +0000
Date: Fri, 03 Mar 2023 14:54:16 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <64019998.80huO6CmvGKMZkp6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677826494; x=1709362494;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=i6jTgnLWlphAarihDwP8YtwzmuPP2HR6gROGDWIpIUA=;
 b=K4B0Kjfz5x4VFG5qA2o02eCxm20F7BI90HTaZek73osnoPqu5M34gqSB
 53hEFn75wvaa3owWhCmul8ow4qUJLp+s7/HZgc6wWxo4r38neu2Yjfy2I
 9eaXS9ah58cIlBmxClgNxnGjR/5IrBhlTpEAgJfSOeTH4w+wJV7aZsYjb
 q704aJiP8TzIg9smI2Gliqtfed6YrFfuSEaOQALF/olGp2EjuNzPugT4e
 WIXTb1mpKhsEX0uyuYOCGKhoWvcuQsL3eEFqZJnOAxeHL3OatYDPmuKJX
 /KZxwWc3WzOEGuPhI4RftVYU0qfKWOOPjEOsYoiEBLrLkLrmXN8tI7jf0
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=K4B0Kjfz
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 5c1ebbfabcd61142a4551bfc0e51840f9bdae7af
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 5c1ebbfabcd61142a4551bfc0e51840f9bdae7af  net: use indirect calls helpers for sk_exit_memory_pressure()

elapsed time: 951m

configs tested: 135
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230302   gcc  
alpha                randconfig-r015-20230302   gcc  
alpha                randconfig-r015-20230303   gcc  
alpha                randconfig-r025-20230302   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230302   gcc  
arc                  randconfig-r031-20230302   gcc  
arc                  randconfig-r043-20230302   gcc  
arc                        vdk_hs38_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230303   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                        neponset_defconfig   clang
arm                  randconfig-r001-20230302   clang
arm                  randconfig-r013-20230303   clang
arm                  randconfig-r015-20230302   gcc  
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230303   gcc  
arm64                randconfig-r016-20230303   gcc  
arm64                randconfig-r025-20230302   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230302   gcc  
csky                 randconfig-r013-20230302   gcc  
csky                 randconfig-r014-20230302   gcc  
csky                 randconfig-r022-20230302   gcc  
csky                 randconfig-r035-20230302   gcc  
hexagon              randconfig-r002-20230302   clang
hexagon              randconfig-r032-20230302   clang
hexagon              randconfig-r033-20230302   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230303   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r016-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230302   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230303   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230302   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230303   gcc  
m68k                 randconfig-r016-20230302   gcc  
m68k                 randconfig-r026-20230302   gcc  
m68k                 randconfig-r035-20230302   gcc  
microblaze   buildonly-randconfig-r001-20230302   gcc  
microblaze           randconfig-r023-20230302   gcc  
microblaze           randconfig-r024-20230302   gcc  
microblaze           randconfig-r036-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           ip32_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r006-20230302   clang
mips                 randconfig-r031-20230302   clang
mips                   sb1250_swarm_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230302   gcc  
nios2                randconfig-r011-20230302   gcc  
nios2                randconfig-r012-20230302   gcc  
nios2                randconfig-r015-20230303   gcc  
openrisc             randconfig-r012-20230302   gcc  
openrisc             randconfig-r012-20230303   gcc  
openrisc             randconfig-r013-20230302   gcc  
openrisc             randconfig-r014-20230303   gcc  
parisc       buildonly-randconfig-r003-20230303   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230302   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r024-20230302   clang
powerpc              randconfig-r034-20230302   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230302   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230302   gcc  
riscv                randconfig-r034-20230302   gcc  
riscv                randconfig-r036-20230302   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230303   gcc  
s390         buildonly-randconfig-r006-20230302   clang
s390                                defconfig   gcc  
s390                 randconfig-r021-20230302   clang
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r026-20230302   gcc  
sh                   randconfig-r033-20230302   gcc  
sparc        buildonly-randconfig-r002-20230302   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230302   gcc  
sparc                randconfig-r011-20230302   gcc  
sparc64      buildonly-randconfig-r006-20230302   gcc  
sparc64              randconfig-r005-20230302   gcc  
sparc64              randconfig-r014-20230302   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230303   gcc  
xtensa               randconfig-r011-20230303   gcc  
xtensa               randconfig-r021-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
