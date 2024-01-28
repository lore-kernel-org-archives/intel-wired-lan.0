Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E633C47258
	for <intel-wired-lan@archiver.kernel.org>; Sun, 28 Jan 2024 14:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9FE182404;
	Sun, 28 Jan 2024 14:26:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9FE182404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706451997;
	bh=z54z3EjmkXFEXjAjL2iStELQAFRgPwfH7YjuGWMJByc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uWJ/epHdHVn53Rzq5pxzTfb7yQbUtDRhcbYlcwNz+JNFQeUsghPJ7YHIiUt+3Jm0A
	 ygTmQBqUlWI93ZSIp8iLPaDsTPw0S7azZiENSKCE+MebzhT/X+MZQfr7bQwpik+oag
	 GzV+DAoS8Gd8lvQBH6kTnNdpiY88E/8LpGvnRguF1V9hSvwFIgQTFsOCOAWhSWTzlL
	 uVX1vmH0+u+oxyhANmTvyPBJerFBXsTevvlwuP3VGHDD3+08MsM7iOHxmg9XzqMmI5
	 2EtrUYKaAkAhDZCLqJ9jo7kwQi7J8WHsicrvGo5L2Vch5s1jV3zlkj9XqIO8da7Iqd
	 cGm4sb75X+v0g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DEkS76F1urw6; Sun, 28 Jan 2024 14:26:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDC7B82416;
	Sun, 28 Jan 2024 14:26:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDC7B82416
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 97FE41BF57C
 for <intel-wired-lan@lists.osuosl.org>; Sun, 28 Jan 2024 14:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69F82413D3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 28 Jan 2024 14:26:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69F82413D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZl5xKaLk5oo for <intel-wired-lan@lists.osuosl.org>;
 Sun, 28 Jan 2024 14:26:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66B1F4139E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 28 Jan 2024 14:26:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66B1F4139E
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2606622"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2606622"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 06:26:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="29277378"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 28 Jan 2024 06:26:30 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1rU679-0003Sh-15
 for intel-wired-lan@lists.osuosl.org; Sun, 28 Jan 2024 14:26:27 +0000
Date: Sun, 28 Jan 2024 22:25:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202401282231.NfqIlHNX-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706451992; x=1737987992;
 h=date:from:to:subject:message-id;
 bh=vFzdALwhsFAN3Ob7ucQKF2706j5abEpW4j5W/7y+t1o=;
 b=YtY/k7/5MYMuC/+U0dFc89mp4N1p+p2ZqOXstqNW5Ax6Xufg/i/jQ4u0
 3SFTLsXgjOZZ7OHsZ+XOW/XMEetDjeZLkYhl5qvi3MZT41uhgvTK4/FN7
 6JHyn7dYueBWPZ8JZgnRg2tYSRjbEvfa9Nu8LWyyvdjptIHxxOK9fkJpE
 TZPHYiIxqwNAgc4p4b/EphdTqY0CDsAF46fv5GXr3uQ2LQxivEtYvBCR7
 8QAYOhcYqzJooZX7gD1BbbpXQ3+ZVhRIlyv1fc+i3E4OuhLnekbXgZX2G
 DfsO1BwBV1z4tQZq+3gCDfY3W9XWIsMRxo3l7+4kfcl8eOd5HqmzFGxMS
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YtY/k7/5
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 518a33af540d98b9999c2c662a5e1ed7ead72b38
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 518a33af540d98b9999c2c662a5e1ed7ead72b38  ice: Remove and readd netdev during devlink reload

elapsed time: 2592m

configs tested: 92
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                   randconfig-001-20240128   clang
arm                   randconfig-002-20240128   clang
arm                   randconfig-003-20240128   clang
arm                   randconfig-004-20240128   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240128   clang
arm64                 randconfig-002-20240128   clang
arm64                 randconfig-003-20240128   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386         buildonly-randconfig-001-20240127   gcc  
i386         buildonly-randconfig-002-20240127   gcc  
i386         buildonly-randconfig-003-20240127   gcc  
i386         buildonly-randconfig-004-20240127   gcc  
i386         buildonly-randconfig-005-20240127   gcc  
i386         buildonly-randconfig-006-20240127   gcc  
i386                  randconfig-001-20240127   gcc  
i386                  randconfig-002-20240127   gcc  
i386                  randconfig-003-20240127   gcc  
i386                  randconfig-004-20240127   gcc  
i386                  randconfig-005-20240127   gcc  
i386                  randconfig-006-20240127   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
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
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-001-20240128   clang
x86_64       buildonly-randconfig-002-20240128   clang
x86_64       buildonly-randconfig-003-20240128   clang
x86_64       buildonly-randconfig-004-20240128   clang
x86_64       buildonly-randconfig-005-20240128   clang
x86_64                              defconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
