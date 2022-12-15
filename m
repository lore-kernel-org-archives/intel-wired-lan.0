Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB42C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Dec 2022 11:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A359E41854;
	Thu, 15 Dec 2022 11:58:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A359E41854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671105534;
	bh=8lsa2a/Gkxi5fm6Lrxq0IOP/0WkmhAcctC2+qIYFjlU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PrizI92Q3I+V+YjKTU4vzEcb9ytDO3Y8NM0f3FwWqyr5MXornAP/F5qXXNygi+HGF
	 nPfbIwVM9JAmuTIMwRH/K/e3nC/YJwCgaLN4HWOqKsR2S621ChjN/l4zYlOhzBxnMf
	 i+HUkVoPhcQtIADPMPknpACnHQfx5XyR9HcHuooHRsTjkT1tlSm/OMGZzQG7WofNXh
	 i/r+ePp42Q0VVdVavxDLYv4SKyQsRpbPANxrLVoJJJX6PF79hZJ9r7nIkVLo8Fawre
	 Htk9V+3lagYNf9FbX1LOlA1FX7p5L1vG22IrdOXVj5TMjxJh6ZomR7aqOKpbFsMfyS
	 vu27NHETDpDKQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AC46rw2eSao6; Thu, 15 Dec 2022 11:58:53 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CF6E418AC;
	Thu, 15 Dec 2022 11:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CF6E418AC
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1BD631BF308
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 11:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8EF040232
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 11:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8EF040232
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vVHsCvPqxkrz for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Dec 2022 11:58:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05810400C0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05810400C0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Dec 2022 11:58:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="299003341"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; d="scan'208";a="299003341"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2022 03:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="712887963"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; d="scan'208";a="712887963"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2022 03:58:49 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p5msy-0006FN-37;
 Thu, 15 Dec 2022 11:58:48 +0000
Date: Thu, 15 Dec 2022 19:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <639b0be8.lf4VqobVCYebPf6x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671105531; x=1702641531;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=gphuXYyNHfScX2Zsf3zrqgiBOZaCKK4W5fmL1Ow/DA0=;
 b=ZsJJateOofDlbbdgOiLHUD0zCas2nK2QhY3eicDUXBkCHP5Ml9iniYAb
 rgsR/Cq2MnnYFCa6effr+9lvFpe9b0Uujn7HS2fk51L4fWVFrDbNsl5bh
 f35ttqoLQqJNLUOsymHWm/knLwdzM6NtNanmNq62hiiL4T3iB1i2uFK0v
 06N95LJs4wd8C2a0xoBp/a+4oaDVGSlqxx19XL1zIVsvz5K8fqLhjkgiK
 /4vrrXP3iGZiSeHbVrUUiCteIftrTfeLepNsj1dXxMmVYdJ/3ZwGHiNCe
 TVhw7u1swKtTxNHTDfT5LR5CVExZ+1X8y4eMyJIovMLm+e8xVtOBacCg4
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZsJJateO
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 7ae9888d6e1ce4062d27367a28e46a26270a3e52
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
branch HEAD: 7ae9888d6e1ce4062d27367a28e46a26270a3e52  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

elapsed time: 1936m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
um                             i386_defconfig
s390                                defconfig
sh                               allmodconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
s390                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
nios2                            alldefconfig
s390                 randconfig-r044-20221214
x86_64                            allnoconfig
riscv             nommu_k210_sdcard_defconfig
m68k                       m5475evb_defconfig
arm                                 defconfig
i386                                defconfig
x86_64                              defconfig
arm                  randconfig-r046-20221213
arc                  randconfig-r043-20221214
arc                  randconfig-r043-20221213
riscv                randconfig-r042-20221214
arm                              allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-rust
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-bpf
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                         wii_defconfig
arm                          pxa3xx_defconfig
sh                                  defconfig
powerpc                     rainier_defconfig
sh                           se7705_defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
sh                           se7751_defconfig
arm64                            alldefconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
arc                         haps_hs_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          randconfig-c001
xtensa                         virt_defconfig
sparc                       sparc64_defconfig
mips                             allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015

clang tested configs:
s390                 randconfig-r044-20221213
arm                           spitz_defconfig
arm                  randconfig-r046-20221214
hexagon              randconfig-r041-20221213
hexagon              randconfig-r041-20221214
hexagon              randconfig-r045-20221214
hexagon              randconfig-r045-20221213
riscv                randconfig-r042-20221213
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                      pxa255-idp_defconfig
arm                          sp7021_defconfig
powerpc                      acadia_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
