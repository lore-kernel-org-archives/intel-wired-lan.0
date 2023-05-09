Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37191C77B75
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 May 2023 05:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2EA2611D9;
	Tue,  9 May 2023 05:38:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2EA2611D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1683610694;
	bh=8duKf7btOnZZty67k3yxkEVNZDcQudjoZuG8+I09hOw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z7OZpnzP9N0i/3F5EI70CyYHtQ+xF7OjwF0xfIPP3HF1XIrDKEZ6Lt55xjr3Osk8N
	 Qo7fhlr7kQkF+P6UE2GCmzeLb9tK7VY3uhhZYOZQVp6+BAAxf4neTtXXJGw43gDdGk
	 +rYax5yI5pq9iSVZvpxKkPqSS+gqQe16mAMJRrn0ux4OTd9HkZugPVd3DWlPhVI4r7
	 MiL0xPtZ1+OY4g/FjiiJ9e1RwkVXjKb+cQt4VVVGRu5sDi7RH1oHPCsKiiiBgJtIW6
	 dwGal2LLvOTUChAAC7+YwZZwx0Ba3SNclWbwXUSVh4a9YMORE40etLBjsAtqBfFoKT
	 o2qC0jXl7U3Xw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ha7BMbK1QULi; Tue,  9 May 2023 05:38:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C675C61485;
	Tue,  9 May 2023 05:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C675C61485
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 99ED01BF306
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 May 2023 05:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7180740340
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 May 2023 05:38:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7180740340
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YC1pDInqAAa8 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 May 2023 05:38:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD60341E4C
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD60341E4C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 May 2023 05:38:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348642456"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; d="scan'208";a="348642456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 22:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="701694325"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; d="scan'208";a="701694325"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 08 May 2023 22:38:06 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pwG2y-0001mZ-34
 for intel-wired-lan@lists.osuosl.org; Tue, 09 May 2023 05:38:00 +0000
Date: Tue, 09 May 2023 13:37:34 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <20230509053734.fLqM8%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683610691; x=1715146691;
 h=date:from:to:subject:message-id;
 bh=8tF2beSuxwDsDxnhevOAZHydxvCvm/cU6vpWylBJjHI=;
 b=Qq2m3+OOjXgwrs6+k1PYpNvL2VyTniueeMfcYICwzLzkmrHkpchCeAhS
 c+GoUp2Z56uUDkrhxgVh7yJVRDntwpo/Oie/BjDFmcZ4DJhZFVuAAzi03
 luyxZBTzODisxfR5+qRn5VSfRaqX2jYbRqA5GGCKNjAxk1xf6z/80aA+a
 XUb99k85D9KsrXTzJWR2JJtnL3ZDokRyUjLfCooiKnire114TDQdIH9q+
 8ApBmNvsrRKoT8Bwu1d6xgVZWgXmurqn7OecvM36qQTaanOyXkE6RRdmw
 4thvVAyFKmStCgQsrOyQl4RWCzAhbIODEViZzcPnbhmrxMYcUwFfXX4LW
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Qq2m3+OO
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 b3195b83109741d642f7929e9934bdb079cc0ef3
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: b3195b83109741d642f7929e9934bdb079cc0ef3  ice: add dynamic interrupt allocation

elapsed time: 722m

configs tested: 127
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230507   gcc  
alpha                randconfig-r016-20230508   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230507   gcc  
arc          buildonly-randconfig-r003-20230508   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230508   gcc  
arc                  randconfig-r011-20230507   gcc  
arc                  randconfig-r023-20230507   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230508   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230507   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r002-20230508   clang
hexagon      buildonly-randconfig-r006-20230508   clang
hexagon              randconfig-r002-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230507   gcc  
ia64                 randconfig-r014-20230508   gcc  
ia64                 randconfig-r021-20230507   gcc  
ia64                 randconfig-r022-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230508   gcc  
m68k                 randconfig-r016-20230507   gcc  
microblaze           randconfig-r002-20230507   gcc  
microblaze           randconfig-r013-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230508   gcc  
mips                 randconfig-r033-20230507   clang
mips                 randconfig-r034-20230507   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230508   gcc  
nios2                randconfig-r015-20230507   gcc  
nios2                randconfig-r015-20230508   gcc  
openrisc     buildonly-randconfig-r006-20230507   gcc  
openrisc             randconfig-r031-20230507   gcc  
openrisc             randconfig-r036-20230507   gcc  
parisc       buildonly-randconfig-r004-20230507   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230507   clang
riscv                               defconfig   gcc  
riscv                randconfig-r026-20230508   gcc  
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230508   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230507   gcc  
sh           buildonly-randconfig-r005-20230508   gcc  
sh                   randconfig-r014-20230507   gcc  
sh                   randconfig-r025-20230507   gcc  
sparc        buildonly-randconfig-r001-20230508   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230508   gcc  
sparc                randconfig-r024-20230507   gcc  
sparc64      buildonly-randconfig-r004-20230508   gcc  
sparc64              randconfig-r004-20230508   gcc  
sparc64              randconfig-r011-20230508   gcc  
sparc64              randconfig-r021-20230508   gcc  
sparc64              randconfig-r032-20230507   gcc  
sparc64              randconfig-r035-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64               randconfig-r023-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
