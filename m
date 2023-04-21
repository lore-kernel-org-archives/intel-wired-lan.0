Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70345C7618E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Apr 2023 12:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07E45415E6;
	Fri, 21 Apr 2023 12:04:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07E45415E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1682078659;
	bh=Wu95njV5w2m4wo4jZhdeHGNmz2Cw8+VO1Ex9miSO7UM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B2RHAawq0C0RI5wZh8/Gy24pq4Oq6ooCivIGAGchjMb1eP2ZrJMerZbMHr2EdLYcb
	 yC8RQVioBDCnycej+Cb6QPvUNrQrZ9HM2q28wiNZ3IBtlsSDONn40DDZqvMaoxu9FK
	 4TVN34A5jnw9oo/f4gLAXKJSA7dosnbLN+7OE+7VQc6R1AKN3p1bDsOmCRvzEeA9Pg
	 nU7BAWPnsZf+tOlpTEozOOCGdTWvKRURRKivu6BU+5Z4AofpG/2Hcfhz1hUP6ihjaK
	 ctjF/C89APZuHDNRxCCMtP2VYkNJCkGwOyvkNSzVuJK4FhZZG7F57maosmU57kLJG4
	 gXJDs9xCcDCqQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3TTKQgrkE4X; Fri, 21 Apr 2023 12:04:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB02A415A4;
	Fri, 21 Apr 2023 12:04:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB02A415A4
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 977091C275D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Apr 2023 12:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6902861555
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Apr 2023 12:04:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6902861555
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TfmqdnwuU3op for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Apr 2023 12:04:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FD7560F4A
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FD7560F4A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Apr 2023 12:04:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334853753"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; d="scan'208";a="334853753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2023 05:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="866679313"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; d="scan'208";a="866679313"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 05:04:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pppUq-000gZE-2Q;
 Fri, 21 Apr 2023 12:04:12 +0000
Date: Fri, 21 Apr 2023 20:03:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <64427bac.wvQpXh7YQlkmyqFA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682078655; x=1713614655;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=tN3FRbBppvwrYsJij8IUuhUIOibhu7zvKNvtcedVqro=;
 b=WXxVw7qLZU4Mx5kSjQKZLGYkO9S2orlbXQRv1/KHqKDKK7rHR3xRIJiX
 WKXA+d6RKRL08qHx1PXutLz7J+yxfhrJDS6Y/PChkc0SSN2NPYz5akzxK
 lZdKG3sL75OKME34F1Il+uR7FTsG3/r+2QO5YFVDHaIAIqroQgfky8Wfz
 zoKQM4VsWsdODUsixbDkVvWTNJi2RyiFeARod7ARK4p/WaYSt2jd2Mw8+
 BEuHt+JrAia9za+L2VvdJDGKH7+vg1QUDTUWfeLwTkylNZO9FhxoO2xFP
 EfV6Klb4czr78q70xcXZh8w3uQL+SDSrYwbVdEg3UrObkZnk85a3w7alw
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WXxVw7qL
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 b488ae52ef9f74155ab358f8c68e74327b45e0e1
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: b488ae52ef9f74155ab358f8c68e74327b45e0e1  ice: sleep, don't busy-wait, in the SQ send retry loop

elapsed time: 725m

configs tested: 133
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230420   gcc  
alpha                randconfig-r034-20230420   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230420   gcc  
arc                  randconfig-r035-20230417   gcc  
arc                  randconfig-r043-20230419   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r001-20230417   clang
arm                  randconfig-r003-20230417   clang
arm                  randconfig-r013-20230417   gcc  
arm                  randconfig-r024-20230420   clang
arm                  randconfig-r035-20230416   gcc  
arm                  randconfig-r046-20230419   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r032-20230420   clang
arm64                randconfig-r033-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230420   gcc  
csky                 randconfig-r034-20230417   gcc  
hexagon              randconfig-r002-20230416   clang
hexagon              randconfig-r012-20230420   clang
hexagon              randconfig-r041-20230419   clang
hexagon              randconfig-r045-20230419   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230420   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230416   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230420   gcc  
loongarch            randconfig-r036-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230417   gcc  
m68k                 randconfig-r013-20230416   gcc  
m68k                 randconfig-r032-20230416   gcc  
m68k                 randconfig-r033-20230416   gcc  
microblaze           randconfig-r014-20230417   gcc  
microblaze           randconfig-r016-20230417   gcc  
microblaze           randconfig-r031-20230420   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230420   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230420   gcc  
nios2                randconfig-r022-20230420   gcc  
openrisc             randconfig-r002-20230417   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230416   gcc  
parisc               randconfig-r006-20230417   gcc  
parisc               randconfig-r031-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230420   gcc  
powerpc              randconfig-r034-20230416   clang
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230420   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230417   clang
riscv                randconfig-r033-20230420   clang
riscv                randconfig-r036-20230420   clang
riscv                randconfig-r042-20230419   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230420   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230417   gcc  
s390                 randconfig-r006-20230416   clang
s390                 randconfig-r044-20230419   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r006-20230420   gcc  
sh                   randconfig-r016-20230420   gcc  
sh                   randconfig-r026-20230420   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r004-20230420   gcc  
sparc64              randconfig-r003-20230416   gcc  
sparc64              randconfig-r011-20230416   gcc  
sparc64              randconfig-r035-20230420   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-r031-20230417   gcc  
x86_64               randconfig-r032-20230417   gcc  
x86_64               randconfig-r036-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230417   gcc  
xtensa               randconfig-r014-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
