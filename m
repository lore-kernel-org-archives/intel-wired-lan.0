Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D17C54EBC
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Jan 2023 11:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBE69400A6;
	Tue, 10 Jan 2023 11:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBE69400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673350281;
	bh=DsrwHcGoDfzKZiMN5NcCCuIvKvPE1C/cCU6n/EDzY2E=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UsGPuISDTOXvJVyeTvlCVqISVtHDFdwVML2TbMnjWSrwQL5MJmkj9VPrauJbiwK6S
	 lutodNowyDi7XqozFphMBk8+qWD6mMU1xm/Jxg44heo2d/VFjDM4A7qH31Xv7Z0NhR
	 cSLLDQ2VokZ5IxgTg0dA/c/STTt2N0UioPX1p27yrLhINjG8tLUUnb08kRWdRJxsiN
	 pBZPIEtJ755f6TRCBFVBiu2t6dcu5/wAgZR4KF9kh0e3Q1oLQdg6EYb4ZkyNxueNg9
	 2CEQB2Gano0lF+XwDnBn5TGh0oq5Un+pH1ARDb7xRIA38Oo2bN7+TT/EBFP7N0hBwq
	 J1KkrIZKVLZGg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_yeB7kBWZ3F; Tue, 10 Jan 2023 11:31:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C415940132;
	Tue, 10 Jan 2023 11:31:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C415940132
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 4C73C1BF232
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Jan 2023 11:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24A8981A34
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Jan 2023 11:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24A8981A34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIcLTBJHofZl for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Jan 2023 11:31:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 382818149D
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 382818149D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Jan 2023 11:31:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="325128848"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; d="scan'208";a="325128848"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2023 03:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902342344"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; d="scan'208";a="902342344"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2023 03:31:12 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pFCqV-0007vd-15;
 Tue, 10 Jan 2023 11:31:11 +0000
Date: Tue, 10 Jan 2023 19:30:07 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63bd4c3f./Px8Yc8Q9QDyYXh2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673350274; x=1704886274;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ky05n5DAtjF+JqClrJaGIv+oaqMYGahVseDqT2tM9Ws=;
 b=bJW8ASrOu7Tpg2RtZaQmC1YdT3T5LgW20w1/1YE0faLR5qlnuhjq7p1e
 HqMrX3cXOMC1vPmlgi9R+1AsBG2R/cZlmHIWUPy2XHzKIregnbwB2WAeF
 8xW77WkcuUr97D6F5grBVUID/xCM5SHW0QgWfgT5qrg1rLbshmr+Kg9Vc
 l7GArQYxOHE4PtVhIOxIrIfmN9LIrJvsdXsqmbOkoCKP6nzKCKC2aDghw
 X2I7rXEJzm+ym7AY4LMed43/d9hetiAHEDCUlQO2Qa1juj7GRfzNheztl
 d7zn/GPKkTmcC2IBPWzr4BlwuBVefViy2xGRkyoqJoUluGuFJQxTGibDq
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bJW8ASrO
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 40543b3d9d2c13227ecd3aa90a713c201d1d7f09
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 40543b3d9d2c13227ecd3aa90a713c201d1d7f09  ice: Add check for kzalloc

elapsed time: 729m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
s390                                defconfig
m68k                             allyesconfig
s390                             allmodconfig
mips                             allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a014-20230109
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
ia64                             allmodconfig
i386                 randconfig-a012-20230109
powerpc                          allmodconfig
arm                                 defconfig
x86_64               randconfig-a011-20230109
i386                 randconfig-a016-20230109
x86_64               randconfig-a013-20230109
i386                 randconfig-a015-20230109
s390                             allyesconfig
x86_64               randconfig-a012-20230109
x86_64               randconfig-a014-20230109
arm                              allyesconfig
x86_64               randconfig-a016-20230109
arm64                            allyesconfig
x86_64               randconfig-a015-20230109
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109

clang tested configs:
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
x86_64                          rhel-8.3-rust
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a005-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a006-20230109
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
s390                 randconfig-r044-20230108

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
