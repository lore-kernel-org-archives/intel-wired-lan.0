Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86788C7619A
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Apr 2023 06:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 061254212A;
	Sat,  8 Apr 2023 06:32:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 061254212A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680935563;
	bh=Xef+6s3yfhmlcVuTHNd6QpyPjPA3X/tqZgCyY69XtPw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z5PDV/wv6jkhC+xS7IvWDSN8Eyc6tx/gO4uPSal2JPokWnD/fptxeSmpyR3731MMj
	 Iedk/2sl+oRlMPP8WuLTeTfwthfOPzcmy7FC5HHXbhQGYRygkgGPU/QCt3H4pNHRyP
	 DM3MY9MIyQW2194t2SgI5rntJtoSuwOxDlhSR1JP7gHDaTBmqIFJO7tD8PX77JwBHk
	 moU3IhH5ugQS2hRTTYPIvJmCGymslaw/sxrUG9TeCt6x13cUeAyW1dYpg2O5uwtXa/
	 R3//mwdR7c5b0oLeMZlB6jM796qYDRlpSCosgEsGSy8kGVyozFwBdj1Gaiby2M2ONd
	 12uMK4sb0tSbA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j52VrJ6-atpC; Sat,  8 Apr 2023 06:32:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4E4341F29;
	Sat,  8 Apr 2023 06:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4E4341F29
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 809A51C2E47
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 06:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B16E403E2
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 06:32:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B16E403E2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xvbYY-iQe40m for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Apr 2023 06:32:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EE15400A4
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EE15400A4
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Apr 2023 06:32:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="327209831"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; d="scan'208";a="327209831"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2023 23:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="933801847"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; d="scan'208";a="933801847"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2023 23:32:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pl27m-000TQP-1p;
 Sat, 08 Apr 2023 06:32:34 +0000
Date: Sat, 08 Apr 2023 14:31:48 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <64310a54.Rzdo2RVFW11Q+Wc7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680935557; x=1712471557;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=njBfehBrG3bbInmz6zyD84+qOP1OhCbkHmxqTbZDndE=;
 b=SrDxn70UHUBhGaz1kClJ6+wvtSSGVzDxt5wYfO2Y3sQp/flVnsT+toKY
 EjciuKa5Tumt39EbQHT3qGeXnsNTRJNXZa2C/oHJ/X5faCFNs/h3kQE3U
 iqFFWplre3ol7/jKJOxx6EMTYnrIMOF1XMh892CNlFMtXEUOEN9R8tQE2
 xHm2Qbv4lo4Qw9SgGgg8qOhR+isZDxDGtND5xA0GTawR4DTtcI6qhtZ2+
 OsASAUeECDo8CLZRebgdZHxvFRLpPpqxHMKMtpDNC1pTcHw9i3te9gEJX
 B1lnUXm2xvK6ubTCMFbS5CjbOUk+oR4QCnkammlzQoKgwHnidagxaQJSF
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SrDxn70U
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 93e20757812c3f70dfd3afaafae21708b36392db
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
branch HEAD: 93e20757812c3f70dfd3afaafae21708b36392db  iavf: remove active_cvlans and active_svlans bitmaps

elapsed time: 724m

configs tested: 164
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230406   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r035-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230403   clang
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r015-20230406   clang
arm64                randconfig-r016-20230406   clang
arm64                randconfig-r024-20230403   gcc  
arm64                randconfig-r036-20230403   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
hexagon              randconfig-r001-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r012-20230403   clang
hexagon              randconfig-r016-20230403   clang
hexagon              randconfig-r022-20230407   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230408   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230408   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r026-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r032-20230403   gcc  
loongarch            randconfig-r036-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230403   gcc  
m68k                 randconfig-r024-20230406   gcc  
microblaze           randconfig-r016-20230407   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r023-20230406   gcc  
microblaze           randconfig-r024-20230403   gcc  
microblaze           randconfig-r026-20230406   gcc  
microblaze           randconfig-r026-20230407   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230405   gcc  
mips                 randconfig-r023-20230407   clang
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230407   gcc  
nios2                randconfig-r034-20230403   gcc  
openrisc     buildonly-randconfig-r002-20230405   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc             randconfig-r013-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
openrisc             randconfig-r035-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc               randconfig-r014-20230403   gcc  
parisc               randconfig-r022-20230406   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230403   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r025-20230406   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv        buildonly-randconfig-r004-20230405   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r012-20230406   clang
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r025-20230407   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230408   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r012-20230403   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230408   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                   randconfig-r011-20230403   gcc  
sh                   randconfig-r013-20230407   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230403   gcc  
sparc                randconfig-r012-20230407   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64              randconfig-r024-20230403   gcc  
sparc64              randconfig-r026-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r023-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r022-20230403   gcc  
xtensa               randconfig-r024-20230407   gcc  
xtensa               randconfig-r033-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
