Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375A3C43334
	for <intel-wired-lan@archiver.kernel.org>; Fri, 22 Jul 2022 04:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A574A41836;
	Fri, 22 Jul 2022 04:31:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A574A41836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658464284;
	bh=X4FSfFEKT57y4I+Ki0f1ThkN/o5G4qQ/zDnoJ0MtEms=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KUzEKCGsuSM1wCuPjqigEdZdHTuHlgRk3R2UhCrcO4b4QJ5IYzWh3MdcaBvWkyl3H
	 AyBURJIrUqGyRsptMqP85rRBWtpa33e4aK8KTkHuHI/zchaMTlUW2h30nc8gIXY93j
	 Sr6SkE3w2QInDi/XQgIE2nhX5n3C2Cu1gyrHFhEys2UwP75+KmVTQs+qcSuPZnTjUV
	 Pt1zLbTxme4uAo64BH6zKKgLUHs5ha51X0Y/OBsPjO7O7U6A53gn6K0x8AhLqhmdiB
	 KJ+Ew7A0TZ4YlxgPz811HCmtJL7pPVhE1suCHgsRzYEP3oTDsU3SJoLR2ow50C4mNw
	 hgsRT2bq8SYIA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3LeEeSdqyTcn; Fri, 22 Jul 2022 04:31:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5088541837;
	Fri, 22 Jul 2022 04:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5088541837
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 35F871BF3EB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 Jul 2022 04:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CD6E404E5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 Jul 2022 04:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CD6E404E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rrk-8THiypQ0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 22 Jul 2022 04:31:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4D2C4013A
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4D2C4013A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 Jul 2022 04:31:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267008943"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; d="scan'208";a="267008943"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2022 21:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; d="scan'208";a="574023655"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 21:31:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oEkJm-0000xk-2w;
 Fri, 22 Jul 2022 04:31:14 +0000
Date: Fri, 22 Jul 2022 12:30:39 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62da27ef.BeiEan0L1/2pS0Rr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658464278; x=1690000278;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ydSwkCT4KgANxbAyuQnQltn2eNV9/sn5igJGEyeuKOg=;
 b=Kn9Ldw4OqU7vYm8X6exWDThzQMLIR9IFDhBeVL3ObgYgEEhwMY0nUnZ1
 MNcxwP2hGlZtD9F9XyGwkoux9dtSIosGkz8W0H3ktrfYHVluzsubFvoa/
 t06Y2ftxzxJPdmOijWE90e6Mkzz4hzGdgF1K7MH+ID67tpUtvMN+GFnKG
 luHcZnUVbFv3517cOcHYS9upDwLxYVt0W+P0noID+tLoKQb3AbmwPmnQu
 vchUZheAO1tqVNUqYNY86OJXLfJLCifAx/IzNV8ZDgb/Nj5Fd09Ozb2Go
 hdNOhHbOok2P8CbsX9pAhVz45yP35a8Qhmg7DwPt8BzETabqrO/RqKHwn
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Kn9Ldw4O
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 5588d628027092e66195097bdf6835ddf64418b3
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
branch HEAD: 5588d628027092e66195097bdf6835ddf64418b3  net/cdc_ncm: Increase NTB max RX/TX values to 64kb

elapsed time: 880m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                               j2_defconfig
arc                          axs101_defconfig
alpha                               defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                        mvme147_defconfig
mips                     loongson1b_defconfig
arm                         at91_dt_defconfig
m68k                                defconfig
s390                          debug_defconfig
nios2                         10m50_defconfig
sh                               alldefconfig
powerpc                     tqm8555_defconfig
arm                             pxa_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                        oxnas_v6_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                              debian-10.3
arm                  randconfig-c002-20220721
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                malta_qemu_32r6_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
x86_64                           allyesconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
