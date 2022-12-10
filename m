Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F7AC10F1B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Dec 2022 10:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 929D081AC4;
	Sat, 10 Dec 2022 10:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 929D081AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670668250;
	bh=h/sfaro/lVxMbWPeZ1DSM7ohIuKSw/zKcNmWkIxOKcI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bZka92r9LYxCoK3a0g73TJWwUU7BlaDJg22vbn38Hl58GBGiUgGszZfCI+kfL1RZl
	 diEOd9KyeW6fR5zgx7Llp/syncbAnvwsmbSHfVALITnv7oulEKUx9MfBgx/RyFhSer
	 DkZzF2myJPWXmVdMiTSDtYK5uUKhHbu04G8YnFEWeSAIa0+w3iKM6OEcFvD3irftND
	 tUohS2QGa3LO23x7UUnSMJCiQBqBnduGj3ZqXjyQOxho1JOhj1hWTHeUIu9NjyTbqt
	 K0dz/LDHrueIPztaqxtLG8O3MqtN4CsQGQHlY7h/0Jg29mtiQrJ0bBZJCPMKbBmQcg
	 FoE3F9sI3oGWA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-iM4es4lw8l; Sat, 10 Dec 2022 10:30:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9117A81AAC;
	Sat, 10 Dec 2022 10:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9117A81AAC
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E9ED11BF3AA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Dec 2022 10:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEE87415F8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Dec 2022 10:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEE87415F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5PRW_t9_dBq3 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Dec 2022 10:30:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 433874094E
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 433874094E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Dec 2022 10:30:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="305254658"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; d="scan'208";a="305254658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2022 02:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647658252"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; d="scan'208";a="647658252"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 10 Dec 2022 02:30:44 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p3x7z-0002N9-2Y;
 Sat, 10 Dec 2022 10:30:43 +0000
Date: Sat, 10 Dec 2022 18:30:01 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63945fa9.4ZUB8p7tiZtoDpLE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670668246; x=1702204246;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=aT3As767OT3myccy+mT8ee0vcb27JdL53A3ri5uqIvE=;
 b=TSGN+URxyw35goYpfAL1n69t1dvjNp6ZN2iF3IuBd1cAaMlQApm7sHuk
 UVHvsny1QK5gXsZwH4sheVlQyOviGmOhow707y6IygBBM5zySxlPaO8QT
 iDaTxncHpbAwu7UwiPF9xDBF2WReWSVvnGi2z+PFJ2AnqHEo0r7l5WuNh
 AdP5c2il16Z3eDtgydDsYUUNyMJ92PweTpBFPSUDKm9hO4XLTa2zY0/ys
 C3X1OicHdQiqPCNx9JFeP+KjvOPdDTfe+K98/RyDrQ0hGvnpRJHcWVQnM
 7uLIqnFsJcN5lJ0BGgFLezsfHg5yLHMrqP4I39MveIhyIx9pHZ1lJGrln
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TSGN+URx
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 631060abf9f21e8bf4c61a539be1e3883c555162
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 631060abf9f21e8bf4c61a539be1e3883c555162  igb: conditionalize I2C bit banging on external thermal sensor support

elapsed time: 721m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
um                           x86_64_defconfig
i386                                defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20221209
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                        randconfig-a013
arm                                 defconfig
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221209
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221209
x86_64                          rhel-8.3-rust
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
s390                                defconfig
arm64                            allyesconfig
s390                             allmodconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
s390                             allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a005
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
alpha                            allyesconfig
i386                          randconfig-a012
i386                             allyesconfig
i386                          randconfig-a016

clang tested configs:
arm                  randconfig-r046-20221209
hexagon              randconfig-r041-20221209
hexagon              randconfig-r045-20221209
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
