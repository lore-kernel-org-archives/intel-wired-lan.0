Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831CFC3DA78
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Jan 2023 05:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EADCB41A58;
	Sat, 14 Jan 2023 05:27:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EADCB41A58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673674048;
	bh=q+HFNw1KU7r12wV8+VxygQVdW08EkzPMOineQq5TvMM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hgxmi8KxkhJEuFp1O2hZX/aSt6RTTwYw9wGyodUR0mjEU64rFlaA9U6uR70V3p5j/
	 ZLapF0iC/YGCLd9d17yYI8fW7SxQ7lnUYPNfSPGFaZ2vcunuFix0mrPXph0qQIhvsl
	 l7VqcNZx5w/LwtPYV3M8ebPWqiBSOworah+39MLfJof/mURyDnAYM7XP7CVggLiHv2
	 oCGufadjZkBvo6MHQXzIOOXYszsWv2QiMRXrfU80H2NtkwcQA5xvlAVRvWuyToxBZ9
	 pJ9UqyrBhtLXMwcYmi331LloWezEUPMAx4WzLJi7mr+oEFr/7hHGWcqKt3wDR8ubkQ
	 0A9oGhjPcMfvQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYOxcpVhDQnB; Sat, 14 Jan 2023 05:27:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DF6D41B71;
	Sat, 14 Jan 2023 05:27:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DF6D41B71
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 487B61BF575
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Jan 2023 05:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B39260AA0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Jan 2023 05:27:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B39260AA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BdqBysuxPoQ9 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Jan 2023 05:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECE9560A9D
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECE9560A9D
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Jan 2023 05:27:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351402524"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; d="scan'208";a="351402524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 21:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="660431439"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; d="scan'208";a="660431439"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
 by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2023 21:27:22 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pGZ4b-000BnW-0y;
 Sat, 14 Jan 2023 05:27:21 +0000
Date: Sat, 14 Jan 2023 13:26:49 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63c23d19.klzf+BeqmlUlz7Cb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673674043; x=1705210043;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ptecj1EFop21QUvubIpaAZ4pXqvbK0cWeRoVyv6DRsA=;
 b=O5KnQpESr5Va2L23wM1vz0DSY5C8MPuMaXMHzqCY5qvrmuwZ3iWUs137
 lZwKGRix3FeUoOzpA7pPzKQPwJG7JJhCgcdee8YY9/vfiV+xQ+yw/SQo2
 R0E2mdqTEKX5E0LDKwpF1K0NMXeNJfKbnyD0Kvbw/o2MXVMDTO/uAPDmp
 Hg5YXA3JimUP+H/NcZ52rMVqWsaYW0uDw5lcnwj1OXS2ezbHwyB7LkSvz
 J9OzM820TJW9tHymwRTlDnBxJcG8FPQe/eVmT3R9FLmMygkoRD5AmFKNf
 BeyWa6xVUgA/WZDAlSajXYubsc9pQK3XCHS9+W8txPLG37oU6vEba2BWf
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O5KnQpES
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 ea22f4319c3409d847d70eaaf149cc480a73220d
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
branch HEAD: ea22f4319c3409d847d70eaaf149cc480a73220d  ethtool: add netlink attr in rss get reply only if value is not null

elapsed time: 1397m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                                defconfig
i386                             allyesconfig
arc                  randconfig-r043-20230112
x86_64                        randconfig-a006
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-c001
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                           imxrt_defconfig
sh                          rsk7269_defconfig
sh                        sh7785lcr_defconfig
sparc                             allnoconfig
powerpc                    amigaone_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
arm                         axm55xx_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc64                          alldefconfig
sh                         ecovec24_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                           corgi_defconfig
mips                        vocore2_defconfig
m68k                       m5249evb_defconfig
mips                  decstation_64_defconfig
arc                      axs103_smp_defconfig
mips                       bmips_be_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20230113
s390                 randconfig-r044-20230113
hexagon              randconfig-r041-20230113
hexagon              randconfig-r045-20230113
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
