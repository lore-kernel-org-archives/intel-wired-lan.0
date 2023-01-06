Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59640C3DA7A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Jan 2023 08:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5B338212C;
	Fri,  6 Jan 2023 08:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5B338212C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672992122;
	bh=NQguvLml3l5Y15xf24UDNwibeHsrCjDSbM0uPWTx9/8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oLYVmulagEhl+fcb/hTtcOPHxZtavB5cgEP+Yfxy/kCS+QPTTxTNw5R2J3iwwwS22
	 CeZ4+VbscjD6aVWYvWYSp/XC3wC7Dql35ij/LJc1cSvDvgR211sOasq23QRLllizP2
	 8OAOtE/MyqAdJ4Hu7kVsrXLXj7nt9pw/vmLV1IA3h8nARuHukviOoVlvipuqWCeO60
	 ent3pIHHiKILCdUX+dKtrgWxXlBTv7imK6Qw6qKx4GHf32i4ecBRhUy63PMuzuJBLr
	 hGqyVlditUgv+JE3gQkj45R26oDcsw3YICU0ztSzFFxBFJT+CFPtwnz3OjTgqvs7sJ
	 W26oSwxlhdP0A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBDMjbbxDrIT; Fri,  6 Jan 2023 08:02:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 991F78212E;
	Fri,  6 Jan 2023 08:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 991F78212E
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 394BE1BF359
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Jan 2023 08:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15ECA404B5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Jan 2023 08:02:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15ECA404B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ooHHKhUqNjdw for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Jan 2023 08:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BED9400B9
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BED9400B9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Jan 2023 08:01:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302131219"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; d="scan'208";a="302131219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2023 00:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="655888802"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; d="scan'208";a="655888802"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 06 Jan 2023 00:01:52 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pDhfk-00037v-0S;
 Fri, 06 Jan 2023 08:01:52 +0000
Date: Fri, 06 Jan 2023 16:01:01 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63b7d53d.8DBVtwwFYOfv8A18%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672992118; x=1704528118;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=GlX8e9t35WO8ep0sLkPkrpjPMWfsXnq118Rxv+JZOMo=;
 b=KKXKY8KCUlC3t9IbpqdyBmZqE/O4WZwdpllzE/yeUOZ6Irz1EmsR9GjP
 hVsAjspdmnLwJ3QIJC7I7iJjUGi3jW2tZtJlYtywMwQCqZkVPDerhJh4j
 67/5SbGZ94JUea6MOUxETydEVecAiULGzNQx0fyynko8GWsoZW+sw7bbn
 XEOiyL+XEwQL8lDyufHjxjSXHq7xax2dHNpSG7VEJBUTMWBIyS+uISv4Z
 MO4wSs2KkfL3xhQJ+g1l/BSvDpSxTqpmU3j34WjaKrLpm8L4M79YVOnCR
 XAE1aRSDlpyOYqkL6Gws0ixqxPWea8zubyod/xbGqiZjmfYvIf8fFc6jF
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KKXKY8KC
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 0471005efac9ac70bffd50532f8de07a28eac5aa
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
branch HEAD: 0471005efac9ac70bffd50532f8de07a28eac5aa  Merge branch 'add-support-for-qsgmii-mode-for-j721e-cpsw9g-to-am65-cpsw-driver'

elapsed time: 1183m

configs tested: 66
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
arc                                 defconfig
x86_64                            allnoconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230105
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
s390                 randconfig-r044-20230105
ia64                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allmodconfig
riscv                randconfig-r042-20230105
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
i386                                defconfig
sh                         microdev_defconfig
arm                         at91_dt_defconfig
xtensa                  audio_kc705_defconfig
parisc                           alldefconfig
powerpc                mpc7448_hpc2_defconfig
mips                    maltaup_xpa_defconfig
sh                        dreamcast_defconfig
m68k                                defconfig

clang tested configs:
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                     ep8248e_defconfig
arm                      tct_hammer_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8560_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
