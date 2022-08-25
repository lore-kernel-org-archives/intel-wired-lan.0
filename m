Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C0C3F6B0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Aug 2022 08:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EF8060B9F;
	Thu, 25 Aug 2022 08:43:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EF8060B9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661417004;
	bh=vvWrfWoUGh3brISipiEfYLt7ErN8xXOvuSd58F/JbNY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rxys3/QKF4AhXR+W0Ji343Yz/sEdEJ0gWvN3dUvTtKbGCY+V7Os99xct/a3DcJu+B
	 dQUwZAsF6ukCO8MvybyyTxqNCkWjAPd21spLuyNNcEw4ttS+9eiS+PhDJI+dWVVBy5
	 YcOSitPeP7aaqkOzUDu/3OUtxO2y79HnbpPH9sJaxEmjSM82qCPGIKamsihzUBdSrT
	 IGJ074IKU6XzmUaN7G6MJCRmwok1w05x/t5C4JkRs0ZAWIAAtNnt0OYLcRKomqMVDH
	 EN/WG2IAnMEW/sAOKgXy2rrqJZGPZo6E2HwVxMlRQ6L+6C25br2YWq6/KiAZzducZ3
	 F9DDpi8WtPsww==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLrhS-vWrZoj; Thu, 25 Aug 2022 08:43:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7453060C23;
	Thu, 25 Aug 2022 08:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7453060C23
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 482BD1BF37C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 08:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A1344017E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 08:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A1344017E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AgeUhxUlVuVd for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Aug 2022 08:43:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8764B40C0D
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8764B40C0D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 08:43:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="320260978"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; d="scan'208";a="320260978"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2022 01:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; d="scan'208";a="678376757"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2022 01:43:19 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oR8SM-0001vM-1o;
 Thu, 25 Aug 2022 08:43:18 +0000
Date: Thu, 25 Aug 2022 16:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <630735fe.Jk+f2AGXn3seMW7v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661417000; x=1692953000;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=5ptp6pU+MgvNn7W0dYLh9ZA3fJf5Z1EK88fj1/Bc/KA=;
 b=VchYnEztBfU33cfiBhmFDogOOhKCpxme+xsH2Vqf2iSW+A8wNXjvr+vU
 DkBtRoqSb5KhBAG/H4sH0xOlNd4h/04Ql6ysiADutvQE6bDpzwUhBcqzv
 SWWjkjd5NygnT8xVqZaU/MqrgreR6DXETo0JMIbwca6LpLWSNVnWEVYpF
 o/vhu6/dNcKPMPU/RUCQfqrh6zJBiTQtxaG0aylrO7VLLWTU3ECyl6X2P
 CK8csaQOFbNQRR+EvU7nOPs3tFyVBxKhCGK3aHqs5PCiEuX/C9J6iOEyP
 G5JrEBRP8yTKpJ6EsNm5/icEorypYvbEXt7rENL3c1q8OdlcAG+y2XXoi
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VchYnEzt
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 bfeee83eebb9c72193418ca4e50f0c0c39490e53
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
branch HEAD: bfeee83eebb9c72193418ca4e50f0c0c39490e53  ice: Add set_termios tty operations handle to GNSS

elapsed time: 733m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20220824
i386                          randconfig-a001
i386                          randconfig-a003
s390                 randconfig-r044-20220824
i386                          randconfig-a005
x86_64                        randconfig-a013
m68k                             allmodconfig
x86_64                        randconfig-a011
arc                  randconfig-r043-20220824
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a014
arm                                 defconfig
m68k                             allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a015
i386                          randconfig-a016
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
sh                          rsk7269_defconfig
m68k                                defconfig
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-c001
ia64                          tiger_defconfig
sh                           se7721_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
ia64                                defconfig
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig
um                                  defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
arm64                               defconfig
arm                              allmodconfig
mips                             allmodconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
ia64                             allmodconfig
mips                        bcm47xx_defconfig
powerpc                      arches_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
m68k                        stmark2_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220824
i386                          randconfig-a002
hexagon              randconfig-r045-20220824
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                      pxa255-idp_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-k001
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220823
s390                 randconfig-r044-20220823

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
