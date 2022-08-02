Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F51C00140
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Aug 2022 12:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA6CC40227;
	Tue,  2 Aug 2022 12:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA6CC40227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659443186;
	bh=Dlsj8JQG35nB4ZwviakurYK/HsMfiSvztDDwv3gampM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hMud6c3Q9RS4/mv3EMmjAGGhFeLMx6YLmVgaN7EZocNocVasm1ncMWkjKJQvtythE
	 TCEUbqNV6lRx0zxVGkCqGQ7agf6dXSXdeY9mUIcaQuKQqHnli/A6xVmW7URWFLK7Gw
	 CdmGbmbgxoDc6p9bL3ZqW0u9oUjES1mrBPR3lJlFvYO+yd/XKDFTO4RPmlAv70qRxX
	 K7xWpRKinc+XG1lC4kPvZMIlsy67Vtj3iKUUPaV7sOhE52EJYgq7jqhS7EFPa/0J9y
	 Jmmo4jlgKSyvVzKT1NsJ/O7AY6eMUyALzU+O2Wh7GrKjIJDDooou6qj7lsp8cU3Ozf
	 1MS7QrDZWMPYw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88nWC7QDbDSS; Tue,  2 Aug 2022 12:26:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2075405B1;
	Tue,  2 Aug 2022 12:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2075405B1
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B88551BF366
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 12:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E22E40227
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 12:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E22E40227
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iS8J8Mc5edBc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Aug 2022 12:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A66E405B1
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A66E405B1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 12:26:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="272439813"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="272439813"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2022 05:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="602409235"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 05:26:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oIqyX-000G2N-1p;
 Tue, 02 Aug 2022 12:26:17 +0000
Date: Tue, 02 Aug 2022 20:25:23 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62e917b3.XKpvs/si7hxcNFkv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659443181; x=1690979181;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=KqRE65d4cM5iHyMjB5/C+HliIK+BJfZxmekTDd+x3fs=;
 b=Vqv1qJSa9WNz8y7C/wqkh9phy6Wj7Yu4mw/KjXkjQakmxK0W/+AoRXw5
 Lx5LZzSL9FYjJN9tzKJCw1gPEHVoYCwvbJph1uZfQVqgtIvb+zQLKMlm5
 RHb0b3zzw5ZHyZGUwmKLXkawT2klskYDJ1n4genfmadT0IlvFG5YCQ68i
 5T+rN7Ll/NEogLqveoiic/cPzS16CHvClYmvRVqJz4Chf8dHyFdhEYI5E
 i/f01vsbeKZWN2kDLqL1/x3yaQRksaY+bUP1lMz+KtgyzE0t4NIK0cskn
 xEufAibfCiK9OdeS9R+T+Nn3wpCUeaKsXnR8T1Kd2DzuAWZFquCjvv4rp
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Vqv1qJSa
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 a41b17ff9dacd22f5f118ee53d82da0f3e52d5e3
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
branch HEAD: a41b17ff9dacd22f5f118ee53d82da0f3e52d5e3  dccp: put dccp_qpolicy_full() and dccp_qpolicy_push() in the same lock

elapsed time: 936m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64               randconfig-k001-20220801
x86_64               randconfig-a016-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
powerpc                   motionpro_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
mips                           xway_defconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
sh                           sh2007_defconfig
i386                             allyesconfig
i386                                defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                 randconfig-a016-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a012-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a014-20220801
i386                 randconfig-c001-20220801
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                       m5249evb_defconfig
nios2                            allyesconfig
mips                            ar7_defconfig
arm                            mps2_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                         cm_x300_defconfig
mips                    maltaup_xpa_defconfig

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a004-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
powerpc                      obs600_defconfig
powerpc                     akebono_defconfig
arm                   milbeaut_m10v_defconfig
mips                          ath25_defconfig
arm                       spear13xx_defconfig
hexagon                             defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
