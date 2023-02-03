Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC55C05027
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Feb 2023 16:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 763E1402BC;
	Fri,  3 Feb 2023 16:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 763E1402BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675441038;
	bh=6Ip9hvzl+JowAn266Fjiv3y2LRAVuzEk+L++od4/BZg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3vE2ppTg6UU6ex+H2E8jQx1HYD1BacliicV6XGO6z8Zca4Q0FMZ/BU6BICBkAsSso
	 3Z2+j7Z0jV402NsCHDynNfNSdcrCW6Og/R/DB/YC9XV8CoycQ0vFoBS0f2mDP6tuju
	 PwGizK2DrsFBh2yxNnIn9N9okFn1N4+Z+Ksw+0oNt6SECqHMVwv1fBX+A8rWdVgoj7
	 zvWrFuCGEXmZrtLRb4ICQhWx5Bf0ZKo5A+wwjA3Y1jQTSUDZ9cdBanZwnDASj1pFCy
	 +bvCt2bD1Ebq+348Dj13f0vgePnqf1tuB1ydHgtaRevkjoOxGMIRnCfLucroft65fG
	 tTBjewvpUaRXw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iexluq4YFE0a; Fri,  3 Feb 2023 16:17:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FA80415CB;
	Fri,  3 Feb 2023 16:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FA80415CB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 16BF91BF976
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Feb 2023 16:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1E44415CB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Feb 2023 16:17:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1E44415CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fDoK8XQ_4DwX for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Feb 2023 16:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25E214168C
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25E214168C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Feb 2023 16:17:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="309118439"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; d="scan'208";a="309118439"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2023 08:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="774386916"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; d="scan'208";a="774386916"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2023 08:17:09 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pNykO-0000cs-0r;
 Fri, 03 Feb 2023 16:17:08 +0000
Date: Sat, 04 Feb 2023 00:16:25 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63dd3359.o3Qt/dJ+Nl3AvmTE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675441031; x=1706977031;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=n6RGCp4n3RL5wwUueF65jf9IlhtHNzuXGLzkZhPyN+M=;
 b=QZjOtImZe3+9VYzIquj35bFhFdi3FWZQmHR/RTHcbpHACktShdedI2ay
 v16QlqDAFz4ZnYjAd1IIzTwj+pqtbj2BJm5umElZP13Bd/KMt05mHdeqq
 rMeksKYC19bvtA4e0u5sUw6dB0KwId6uNPyD+aF5VziW17QMS50iFqHcI
 RbwumgE1nOylVLChUgvtOQEJkBu95ai89uvoT2RV3oL/jtjKf3cjjqP5D
 lE/s3FjJqDvKjTAw2F2i6I65d4nk0D9oIJ49koZyV3QZHsVKyRYF3Mkh9
 l2X5JTK8Y7Ds7Sm0juQMKtmKDpCj5Yz3aZabnj2uqd2bHAsrzvKN9NwJ5
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QZjOtImZ
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 a30ac50260021c6a44d374b987cee383f20c5895
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
branch HEAD: a30ac50260021c6a44d374b987cee383f20c5895  igb: Fix PPS input and output using 3rd and 4th SDP

elapsed time: 869m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
alpha                            allyesconfig
arc                                 defconfig
alpha                               defconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
ia64                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20230202
s390                 randconfig-r044-20230202
arc                  randconfig-r043-20230202
i386                             allyesconfig
i386                                defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
sh                            migor_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                  randconfig-r046-20230202
hexagon              randconfig-r045-20230202
hexagon              randconfig-r041-20230202
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
