Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B142C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Dec 2022 12:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A38E81E93;
	Fri,  9 Dec 2022 12:07:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A38E81E93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670587637;
	bh=hwLfZCFECEBZDBsGm8heKvRx5j/SN5eEqg0WDByIE7Q=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f1ZTHO45giJmpvfF3CoODGX3pUaPo2KfguTkOGkIsuLpkXWohWBE1lVVs4U9Fj1oy
	 TCsmcwmwAv13tLr7fjdC7CmArxNY9be/T8D82pBqwoG7uBQO6OdMBK6wbDZ1/Mgwgl
	 NJsdq0rEg62tGKyYeYR15gmim32JaUzATh2kVw3DSeOU3poU3Pfc/kPwrmJ4q3p0ad
	 5iVWNLHKTMqotFpRvUj7sbHlVjXTcRfkNE1nF+AV151WBPn1HGyYjfM0f7w9GL+9KL
	 ooMTcQtoOW9E2eCzKNWC3EFfWsiT8+R0E9dbtgRxuGMjJlJPia7H2VXYqbTTOKwsVP
	 B0SIaAPvyhBow==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TlAy3Vmvy3a; Fri,  9 Dec 2022 12:07:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8380681EC2;
	Fri,  9 Dec 2022 12:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8380681EC2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7031B1BF333
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Dec 2022 12:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AEC540CC8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Dec 2022 12:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AEC540CC8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gs34QpWIuJj8 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Dec 2022 12:07:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 420074020B
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 420074020B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Dec 2022 12:07:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="297125278"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="297125278"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2022 04:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="892652943"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; d="scan'208";a="892652943"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2022 04:07:11 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p3c9n-0001p5-0P;
 Fri, 09 Dec 2022 12:07:11 +0000
Date: Fri, 09 Dec 2022 20:06:35 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <639324cb.bSoCbiFQrp/yunEW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670587633; x=1702123633;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=SFiWdAOjuEFJFlpqSxL0ObapQvI14Hw7K14yK5b1ze8=;
 b=EksxN825t0H+tYxEiHrAskqU/RwI+lrXYilBZm7jjQkvs+3PzFU4MmE6
 Bb8huMZraCV2H0/J//Ytg706ZShhekd8umd2/W+PqElyjcYVF/4rGMiGc
 iCzfDico8EvIJRMmGthRTMK1YVQImisiK6rG5DbMIpFjCtugQOoosJvUN
 ePFqTxDRGENoX8SlvQk0XDldGObvV3tagUaFfAMhAxgsnCJLYOTTQ8c8T
 ZIvdUS9AS8c2ZDrBGP3LXMZBZpu/lqM5ODsdopb57sJzFKBCTR05PKE7E
 CDtg/hqkmsU6IqeGf0tuaDrwjjpJwVW8jjFcw+WirQCX0hpgAE/fQwS2m
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EksxN825
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 ff36c447e2330625066d193a25a8f94c1408d9d9
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
branch HEAD: ff36c447e2330625066d193a25a8f94c1408d9d9  Merge branch 'mlx4-better-big-tcp-support'

elapsed time: 810m

configs tested: 49
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
arm64                            allyesconfig
arm                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                              allyesconfig
mips                             allyesconfig
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a016
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
