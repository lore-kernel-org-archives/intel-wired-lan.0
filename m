Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E1C10F05
	for <intel-wired-lan@archiver.kernel.org>; Sat,  9 Dec 2023 22:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4214660B1B;
	Sat,  9 Dec 2023 22:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4214660B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702162685;
	bh=CkQoKtG1wE2FMDysFOAdTEonu8msQ/goHMZo+7z2P3Y=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RiFUrDPTe/mTZbYOc/qyF3SoOXGg8u2kmybe4AKN5WBuEVXUntKcTeg2+sQ5clq6O
	 +DU/cUf/UMg5JzABvhmDjtV3KZanBZRmC0uStAGCKkJx17zVpakXFkOujRPevomB6h
	 VUJg5f5bNHkQK4/+W8sKGENGiqthjGoXtjt6K3otMVdTr6XU7vncntfbiwD01Pn/WL
	 iFFODV76Iv1h4yzyYlszC6qoDjirK3yWWG1u3ggmmnCWKSVwax9fSf8CgRmSu+nhcd
	 ne4z5FS6A6yCkgQbfZ84D0I8uHWmM87qzFDh+oWFKEbknwFh+SKpruPeuUN8sjVrIg
	 DHVBj+mOXu6pw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ctgU60ywyPJ4; Sat,  9 Dec 2023 22:58:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4409E60B30;
	Sat,  9 Dec 2023 22:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4409E60B30
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id BEE641BF592
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Dec 2023 22:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B6A940305
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Dec 2023 22:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B6A940305
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJFxnrxU5Hi3 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  9 Dec 2023 22:58:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86A07402FD
 for <intel-wired-lan@lists.osuosl.org>; Sat,  9 Dec 2023 22:58:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86A07402FD
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="7887351"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="7887351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2023 14:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="945787758"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; d="scan'208";a="945787758"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 09 Dec 2023 14:57:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1rC6Gi-000G4U-2i
 for intel-wired-lan@lists.osuosl.org; Sat, 09 Dec 2023 22:57:56 +0000
Date: Sun, 10 Dec 2023 06:57:07 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202312100605.GwIIDLYa-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702162682; x=1733698682;
 h=date:from:to:subject:message-id;
 bh=ZaiPkzdYPTbmOXhaw0pA7TC+nLUhALtcqATLpvbg7I4=;
 b=IGHid8t//XyO8fqZEqVvxvjXlB1fNDq/Tsb0+GqxEjVKcDs0Vb+K48j4
 VKi2lZv3HxbxrQscN4mt0SW935LZKpr2RMGP0ymU+J8yEvCMyeItfi7VC
 nGyaomMmMQriWmvESr0evE8nlpYx8SYp9LwJ8WsnQTH2iuvs06YYf9cJJ
 k5Ca0vHmfeVzPjKdevPIWpKRVDsks5H1A+qKd46BI+Q8F808OmNplFcY3
 SC2wKBJh0G0VooL7h4qF6WxIl3POAWwvDJJ7oaSPBwZpoEnwDMK1JLC99
 tggp+l5bvhdsszXrIbqrOhUt33gzcBs9R1U9KLgn6fKmxRURo8UOzTgWj
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IGHid8t/
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 d11403826665ff11ca6a4d586816db73c3516734
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
branch HEAD: d11403826665ff11ca6a4d586816db73c3516734  ice: stop trashing VF VSI aggregator node ID information

elapsed time: 1527m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231210   gcc  
arc                   randconfig-002-20231210   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20231210   gcc  
arm                   randconfig-002-20231210   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                          ath79_defconfig   clang
mips                  cavium_octeon_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                          rm200_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      ppc44x_defconfig   clang
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
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
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
