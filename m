Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B3BC43334
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Jul 2022 15:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 102C641925;
	Fri, 15 Jul 2022 15:18:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 102C641925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657898304;
	bh=bUNihLns+bOX6lG5r23Oud2lDsFrPxKRC6l/XIhxzrs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O5AKHVn+8CQ92FAUd66b2iXNyuGsqfUq7eqnw0bOT1xgSADEVR1tGXgvxGIGbfdvE
	 NJ6rgRCuDihpZ3w98kDSVELgCFkWvBzlAE647Q9U96hyq1t6O9eHlI9WikqUvDcsL9
	 6HlVZekYmpxf6IiUhsmh6uY2/GVPrUiWhtFXgEIUcfS34Mo/cY7qjqLBoQh6uS95lR
	 0ypclWx5nVo280OK+Qy4g+xIYmZ0Ov2cBVpny+6gs4sJPVv4WnCFa752ZvjsMNVcC9
	 skjGehbruRGllV/n84ydYlmHaq6eTOMmznph8B8/B8d5Hyn4W3c6uO2Tfpl4Tc8pgv
	 vw9jmSGVz5u5A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIXwDlqEdfcN; Fri, 15 Jul 2022 15:18:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBE2441977;
	Fri, 15 Jul 2022 15:18:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBE2441977
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A58CF1BF3E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Jul 2022 15:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F0DB42583
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Jul 2022 15:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F0DB42583
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W9JA8md5nqCO for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Jul 2022 15:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DF1E41902
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DF1E41902
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Jul 2022 15:18:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284577020"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; d="scan'208";a="284577020"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2022 08:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; d="scan'208";a="600526678"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
 by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2022 08:18:18 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1oCN57-000080-TA;
 Fri, 15 Jul 2022 15:18:17 +0000
Date: Fri, 15 Jul 2022 18:34:57 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62d142d1.9Wyeht2EESXoGmNt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657898300; x=1689434300;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=YzCElCl4CBccdavJV2F0WrDkLZ5AtM074sC3BYKDezE=;
 b=QFUsTGaZ6PHMeXKEfZo6AlciwmREsSwBVq0KRyjXd2UntockQVkHX83m
 Qn4rskYIZC+NhqEM9WLtAcwb8HOqH8tQQUUpMWmZ7i0J4TI1nzR9xSqGq
 6FSrNh9KIURPU7TMeBQcY+NArT2SMCU7mnzWOcVSU8YMSzBbQMIKaTm8y
 F6KInSlSzvmTdgYKUfmADmHPmD+Q5J/3/w1WNxa0if8cxxHPsyE1BxDgO
 1pdTWO5ZchTZnhU8tofk5lmHvuEWJuRiwuyfZRXA7C6SL7vZwOMmPFyYw
 HndvStg4bkpIcsBLjGzftJriGPwNYOpfgDOLvk8xhLhnFzg82CSr1jsae
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QFUsTGaZ
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 b126047f43f11f61f1dd64802979765d71795dae
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
branch HEAD: b126047f43f11f61f1dd64802979765d71795dae  Merge branch 'xen-netfront-xsa-403-follow-on'

elapsed time: 1426m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sparc                             allnoconfig
arm                           h3600_defconfig
mips                         cobalt_defconfig
sh                        sh7785lcr_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
powerpc                     pq2fads_defconfig
arm                             ezx_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                             allnoconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
x86_64                                  kexec
csky                              allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220715
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig

clang tested configs:
powerpc                 mpc836x_rdk_defconfig
s390                             alldefconfig
powerpc                   lite5200b_defconfig
powerpc                     ppa8548_defconfig
riscv                            alldefconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
