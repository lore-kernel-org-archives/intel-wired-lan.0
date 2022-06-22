Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6079C433EF
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jun 2022 04:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2086341C33;
	Wed, 22 Jun 2022 04:13:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2086341C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1655871221;
	bh=KIevjtJYlnA2Dq2AzB7OELrjuMd/r1QZGO7ARrETU2k=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=le926W068aqTL6CGDtixCA0597sqPXM67Hz7QK5rrx9mb3HOntV8MrlT/AOVgyyHq
	 3jq/7TeRTao3lCX7fl7n3Ibd+SUimk7MsMi1DEqll9+1Gh/jgekONQcs75JcW6FsNu
	 Cs9sDo9Wp0v24lUca92KXmjk3oBNoJoWzv/lkZjcfwL1cXYSy9o5t32b7xJVxbi5cv
	 U9iz/vvtorgHYW5JxBVpBk0Zsku8lzZihsirCNAp//O2FX+8/6s8GvcOfAkw5Ovs5B
	 RKboJ8GY8EDWZrCObdLBk07BA2n2yh6flbMRPSTES+T8YkmVNWUulgpFnzkV7l9MSY
	 ctsgSTAtaBTlQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2zoFDWR-VTo4; Wed, 22 Jun 2022 04:13:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD3D041C73;
	Wed, 22 Jun 2022 04:13:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD3D041C73
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 3DEA31BF41B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jun 2022 04:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A76841C73
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jun 2022 04:13:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A76841C73
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwcV0kg7KpMW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jun 2022 04:13:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E10C41C33
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E10C41C33
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jun 2022 04:13:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344298843"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="344298843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 21:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="538293323"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 21 Jun 2022 21:13:30 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o3rkA-0000op-67;
 Wed, 22 Jun 2022 04:13:30 +0000
Date: Wed, 22 Jun 2022 12:13:22 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62b296e2.Kqju+3YKe4KE2yMV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655871215; x=1687407215;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=yUmsiyjDUFnrdvD5i7AGxcFvzW5vl5ACRxc0JB3UvGY=;
 b=JQaWTJjzXf0e6NUyY4HBVWOzmdENyFQ3JW50m7tPDQOOVDPUcJPSZqZo
 FakIM5kskg9AoSeFYD6dAnPW1YhbpKeph2yxa3baQPtaY96la+TUU5JsB
 JCAldkz8Stmra0EzMzQo3f8DI3AKEovM+vM2gFqHCt7ObQ8+URsvtzgkv
 CpIucq7nPir3TIeHSkxyQ0NUfbl/oi0QCaevR2uqqEPJxRrywXH4ZH/J8
 sJFbaNyPYRdF2Dde7l25BWC+VPbGz9WNQwNmJ4P4GagWlnrwFvUMTOJw9
 9wz72NaMUDaFmx3N7fuVi8Hi5AllTNCdzuJlv8FzPkN7J4jaWK3M2MHkA
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JQaWTJjz
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 8720bd951b8e8515ffd995c7631790fdabaa9265
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 8720bd951b8e8515ffd995c7631790fdabaa9265  Merge branch 'net-dsa-microchip-common-spi-probe-for-the-ksz-series-switches-part-1'

elapsed time: 878m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                      integrator_defconfig
xtensa                  nommu_kc705_defconfig
um                             i386_defconfig
arm                         vf610m4_defconfig
powerpc                      pasemi_defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220622
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
mips                      maltaaprp_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
