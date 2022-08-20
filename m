Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B73BC25B08
	for <intel-wired-lan@archiver.kernel.org>; Sat, 20 Aug 2022 07:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF22F82EB5;
	Sat, 20 Aug 2022 07:24:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF22F82EB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660980276;
	bh=HtKT2gfp2MD5CNLc/o+DT9PgAbYmnVm/C4NwATcTAq8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ywnN6pLyAS2ZWp9Yq6GWc5lF+PHbAY2OlN0elcVjf3vE3JSvfNTH1EHqCXavpHVJf
	 hPMFemOMX/8BDDI1ro/cma8yhF4JlatnvZPYqGln+3mNb3pNEPwA2u8xF2l+tFQ8ww
	 o7DDK3V32E2nmbAg8hwyWH/g8qA/ehAfe0er6R+Ur5Pv54gLpxOpetDmiKav8fTu0m
	 DvtgWYb7rKxmS7TtbLUsrVz2lhxrHOfEk4e3KXgm+9bdovBi7cJhE7SYqXnHVQpbEc
	 EAICzR5NNVWBfnuwpifKs/UPeFe82cOIMk3ZQUXlf4cBVWNfZnsz/6NCWFJ8p53HR4
	 BEZIrJ2/GSg/Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckGLwLMjCvv1; Sat, 20 Aug 2022 07:24:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C22C482F39;
	Sat, 20 Aug 2022 07:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C22C482F39
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 04E2F1BF5B4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 20 Aug 2022 07:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2ACC82F39
 for <intel-wired-lan@lists.osuosl.org>; Sat, 20 Aug 2022 07:24:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2ACC82F39
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qa4Hcu3jOexL for <intel-wired-lan@lists.osuosl.org>;
 Sat, 20 Aug 2022 07:24:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C35A282EB5
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C35A282EB5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 20 Aug 2022 07:24:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="354886233"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; d="scan'208";a="354886233"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2022 00:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; d="scan'208";a="559187100"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 20 Aug 2022 00:24:31 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oPIqM-0002Jo-26;
 Sat, 20 Aug 2022 07:24:30 +0000
Date: Sat, 20 Aug 2022 15:24:18 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63008c22.0oiOvvMpm1kGmGKR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660980272; x=1692516272;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=sJRXkN58bslfeZS1fY7+rKGxXZISNW+EYm+8AKBcxMY=;
 b=asZ3smD1x2ADqqMZ1vZW9FAnTsZ9GlYYrCagJtJATgsfKjdCSMSxVS0j
 prDwTiVPzq0+umOza6hohTdmc7tAgOCh1FJoan1as0UbQn2i87RMeJQV/
 8U2X56O6tJtncDQZOfjWn/xhwvo/bDJ5Fb3CPZliMoxQTfpIohLypylV0
 RNo7tNiNIcm9KlJhOvAaWuqYWjLjQn3ozYJ7RnCDdSAA54jYPnzTqr+aW
 hFThkPhB3L3Rl0fAWtpq4ABzHac9/DdxCp2u7vvKJuJ0axdxAVwteeaUh
 3fgGx8oApfO20q3YddMvFgpz7F0E2mDUzMcE2BfOOruFcVwSEj+iTPJfL
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=asZ3smD1
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 61c5d3d2fa4bc08d309c52057684ae8fb0302c6c
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 61c5d3d2fa4bc08d309c52057684ae8fb0302c6c  ice: Fix crash by keep old cfg when update TCs more than queues

elapsed time: 728m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
i386                                defconfig
riscv                randconfig-r042-20220820
s390                 randconfig-r044-20220820
arc                  randconfig-r043-20220820
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
riscv             nommu_k210_sdcard_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                     ep8248e_defconfig
mips                         db1xxx_defconfig
s390                          debug_defconfig
powerpc                     rainier_defconfig
powerpc                 mpc834x_itx_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                           u8500_defconfig
ia64                        generic_defconfig
powerpc                  storcenter_defconfig
arc                    vdk_hs38_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                      rts7751r2d1_defconfig
mips                      fuloong2e_defconfig
powerpc                    klondike_defconfig
m68k                             alldefconfig
sh                           se7722_defconfig
arm                        spear6xx_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
xtensa                generic_kc705_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                        mini2440_defconfig
microblaze                          defconfig
powerpc                 linkstation_defconfig
arm                             ezx_defconfig
ia64                                defconfig
um                                  defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
m68k                            mac_defconfig
powerpc                     stx_gp3_defconfig
m68k                          amiga_defconfig
arm                        oxnas_v6_defconfig
mips                     decstation_defconfig
arm                            qcom_defconfig
powerpc                      ppc40x_defconfig
microblaze                      mmu_defconfig
arm                         cm_x300_defconfig
xtensa                          iss_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
sh                          sdk7780_defconfig
sh                         ecovec24_defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                        omega2p_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
powerpc                      ppc64e_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-k001
arm                       mainstone_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                     loongson1c_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
