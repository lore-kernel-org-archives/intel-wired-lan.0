Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33889C19F2D
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Aug 2022 04:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A16D881842;
	Tue,  9 Aug 2022 04:15:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A16D881842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660018547;
	bh=Ir+4vTqZIvcO/5FNRhhxi+Pr5+WQiA37mZXCQYiQqu4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jwO3SYkew/83BmQqUO6nd0K/uuWgLUgq1CnPjXBPA0G+WMNq4RjLj1VOh9qDhpgD/
	 ygNR2P0i72tsB7ZMmO8ev4+hFF0qxH5aIdix7e3pqFq7ncJG5zOe89NWNDfS3EkWVQ
	 5OmOWrPsAegEqOF28cj2C7CXhRhC1EJ/Hsxz4sCgKrOsxzCg7CyhcpEO/ui3rBnBcH
	 LecovqhoL8rih9awtgVjoUCUW/qiSNTdryDlZ06iPJ8VmSl0fD4q1RAQDk+hkMciGG
	 YhiPLDzu5knjXatGJmBGfCFrx8Qy4M1AefbsPijxfkG4wZOlsoZ/Q2BPzYzGaYwZDK
	 mLdrUdriVc8lg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uzJptPt5NolP; Tue,  9 Aug 2022 04:15:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B9848184F;
	Tue,  9 Aug 2022 04:15:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B9848184F
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2EE761BF2C4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 04:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 093F2404B4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 04:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 093F2404B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gI3q34030jbP for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Aug 2022 04:15:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7F75400E7
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7F75400E7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Aug 2022 04:15:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316677591"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; d="scan'208";a="316677591"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2022 21:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; d="scan'208";a="746902934"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2022 21:15:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oLGea-000Mjn-0i;
 Tue, 09 Aug 2022 04:15:40 +0000
Date: Tue, 09 Aug 2022 12:15:21 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62f1df59.MIsR2U6V9Ii2eI5i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660018543; x=1691554543;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=AQP6cLm31rmzas0CPp49H2dvfYYlC+VUaQIdeVN/lAU=;
 b=HZdydxTm03QN7PgUwYeb8/tsNu1vwC3tonou/sUMqPB6BaV1QPYV0+bR
 KuIKPWUIsym3lJ/6JU5/YyxY593x/1DCWthCQHgSe2+HZz+famZB3+Qs9
 5BmPRzDIAfzK68p1Mo624DrireKfB9EijfsHEZsIndhfUap+kKbfJh2MZ
 2o9rgDquuiX9jY5WGsq2dMGth0GLEiVO0qe7764Xzu/4WT/fQfKLywSki
 Sf+FbmsUWAxP176BmP4fJL3jgla05ig8M6uaGEuaRVWqRjSXN3olu242y
 W5JYZT/VQfBIcH1zlS+Grq/qFicFwQQPLsGSAzlB6QOkvyynkr/VDsEsh
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HZdydxTm
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 03faee4d7b7d96890f1452e4aa262d0acddc15bb
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
branch HEAD: 03faee4d7b7d96890f1452e4aa262d0acddc15bb  ice: Fix VF not able to send tagged traffic with no VLAN filters

elapsed time: 717m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220808
i386                                defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
m68k                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20220808
i386                 randconfig-a001-20220808
x86_64               randconfig-a006-20220808
x86_64               randconfig-a004-20220808
x86_64               randconfig-a001-20220808
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
x86_64               randconfig-a005-20220808
x86_64               randconfig-a002-20220808
i386                 randconfig-a002-20220808
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20220808
i386                 randconfig-a004-20220808
i386                 randconfig-a006-20220808
sh                               allmodconfig
i386                 randconfig-a005-20220808
ia64                             allmodconfig
mips                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                 randconfig-c001-20220808
sparc64                             defconfig
arm                           u8500_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                    klondike_defconfig
arm                             ezx_defconfig
parisc64                            defconfig
powerpc                 mpc837x_rdb_defconfig
arc                         haps_hs_defconfig
nios2                            alldefconfig

clang tested configs:
hexagon              randconfig-r041-20220808
s390                 randconfig-r044-20220808
hexagon              randconfig-r045-20220808
riscv                randconfig-r042-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a013-20220808
x86_64               randconfig-a013-20220808
i386                 randconfig-a012-20220808
x86_64               randconfig-a015-20220808
i386                 randconfig-a014-20220808
x86_64               randconfig-a016-20220808
i386                 randconfig-a016-20220808
x86_64               randconfig-a012-20220808
i386                 randconfig-a015-20220808
x86_64               randconfig-a011-20220808
x86_64               randconfig-a014-20220808
arm                       mainstone_defconfig
arm                   milbeaut_m10v_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
