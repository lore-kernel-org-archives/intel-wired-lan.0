Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E25C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Sat, 11 Feb 2023 10:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B06694037E;
	Sat, 11 Feb 2023 10:27:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B06694037E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676111232;
	bh=Cy0Ygj6SD9efyd8dkV2Tlmm3YNvAm+PL9fzWeRl58Sk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yG3B0Ctnzes2zXfRw2EJAUo3LR8M3VdVmLEt717u7p6vXKWOkRzEnsnSLr9Rtgo8H
	 YZZc0zGDKe30upPOZL0lZWNzlow7ZT4TxOXAmIUfMeR65aCJ0eZaPwf1f6ecRDtkj7
	 X5AYC512cKQtRs2BqPQ6qSSERPE9XCAGD2xgH56BBGteyjXyxw/xtMP/hMUeafGyI3
	 AveOA2Dw8rAsJryx+JS6J81dLNh+gnmhjQSa7lo+D9OpPb+0kf2VnxZTrWIiy95MFX
	 e0MBVBvzkVhf0+g90NDm4FXr3N0Bkrs+yeHHdPSMSTKLTqyRWjiqviWY5w6b83x9Wo
	 MjKqMglfFVsTA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CgqBI4WVvnuZ; Sat, 11 Feb 2023 10:27:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9596A4038E;
	Sat, 11 Feb 2023 10:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9596A4038E
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 999E91BF59A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Feb 2023 10:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 751494197C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Feb 2023 10:27:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 751494197C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbAlJ-gYpV5Z for <intel-wired-lan@lists.osuosl.org>;
 Sat, 11 Feb 2023 10:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A33F4092A
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A33F4092A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Feb 2023 10:27:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="416824872"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; d="scan'208";a="416824872"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2023 02:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997206951"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; d="scan'208";a="997206951"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2023 02:27:05 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pQn60-0006QH-24;
 Sat, 11 Feb 2023 10:27:04 +0000
Date: Sat, 11 Feb 2023 18:27:03 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63e76d77.pXhxoRnAMRq96pOn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676111227; x=1707647227;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=4OU0apuviuEWqyrxbuNHzjLqNXxMUMBYS8jeBfxh9RE=;
 b=ayv7wSD/IVjrsfVUq5IJGucty63Jkyo+bkq4OxcXoczQxPo2yUmc9jTV
 h8k3LiRR/l0WUvCMH1DBMTHAMWgqeCabrHoFyD0JLb1Y5of/L9v76ovit
 k3llVho+8zFQLIQRSgdnrPRm2vAWaWFEYGMTWN8o9ZtX7uUw6tmX3m/zD
 bTIZhvZKW+qgA73Od+mk60tBIUqB/xm0Go+IZNxwiCTBxFyXrsLle1D+M
 Ki64N1lcpTiY4ZSDmNuOqZ5QWpEu8Bp6ee08jYo5blAuCeMrk579XkPo4
 iJOUhPsOlYXqzrvp2sgtMLCihVZdBTwgL+YneCJkzroLQ+1Zyz7l7qR67
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ayv7wSD/
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 ec76d0c2da5c6dfb6a33f1545cc15997013923da
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
branch HEAD: ec76d0c2da5c6dfb6a33f1545cc15997013923da  vmxnet3: move rss code block under eop descriptor

elapsed time: 1585m

configs tested: 114
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                               allnoconfig
arc                              allyesconfig
arc                      axs103_smp_defconfig
arc                                 defconfig
arc                 nsimosci_hs_smp_defconfig
arc                  randconfig-r043-20230210
arm                              allmodconfig
arm                              allyesconfig
arm                       aspeed_g5_defconfig
arm                                 defconfig
arm                          exynos_defconfig
arm                      integrator_defconfig
arm                      jornada720_defconfig
arm                  randconfig-r046-20230210
arm                         vf610m4_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                         debian-10.3-func
i386                   debian-10.3-kselftests
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                          atari_defconfig
m68k                                defconfig
m68k                          hp300_defconfig
m68k                          multi_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                       bmips_be_defconfig
nios2                               defconfig
openrisc                       virt_defconfig
parisc                              defconfig
parisc                generic-64bit_defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                  iss476-smp_defconfig
powerpc                 linkstation_defconfig
powerpc                   motionpro_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  storcenter_defconfig
powerpc                     tqm8555_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv             nommu_k210_sdcard_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                ecovec24-romimage_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7724_defconfig
sh                        sh7757lcr_defconfig
sparc                               defconfig
um                               alldefconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
xtensa                generic_kc705_defconfig

clang tested configs:
arm                       cns3420vb_defconfig
arm                         lpc32xx_defconfig
hexagon              randconfig-r041-20230210
hexagon              randconfig-r045-20230210
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                           ip22_defconfig
powerpc                          allmodconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                randconfig-r042-20230210
s390                 randconfig-r044-20230210
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
