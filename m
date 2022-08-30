Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F89ECAAA1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Aug 2022 13:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E4EA416C3;
	Tue, 30 Aug 2022 13:43:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E4EA416C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661867006;
	bh=4ch3ZH/VIHclAKpgYWBUAHz9bLJYVVOyrnHooGnIPz8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rTjd3dsMxEnUx8qfVeMh4ZY66NAD1UKWtpRoaZNK+85kuH1u1p7XIzLABDmoHS1IO
	 5bZ8w66nMH8qPFGUhemkkqvgRb3jPQEZqOBAoFOmLxcO5MTz13ez8d03lrdWipwPYg
	 /ql6jHYXX0VWaTJStq3ft2zgxgt7Ec7Oz07bh77I+5w1zQMyeVv3GaOug/bt+5TNr2
	 vTFNJ0q9+m7wL5DVKWZzI8EB0y3IwDgob8r1h/dM44NtCTB0BQqph4+l7c+0hsCc/z
	 YSidbyA1jlrBjiluM0yY6AYC76ddrCa8D/SVhmMafmcyNcUreBPKzSw+qkTS8MKI8g
	 prdwxQaSW468g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lU21w1k9nsLj; Tue, 30 Aug 2022 13:43:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F44E416B9;
	Tue, 30 Aug 2022 13:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F44E416B9
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7D6271BF5B5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Aug 2022 13:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6170C403BE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Aug 2022 13:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6170C403BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TniqJN8mnbJt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Aug 2022 13:43:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECAA2401A4
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECAA2401A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Aug 2022 13:43:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296453363"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; d="scan'208";a="296453363"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2022 06:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; d="scan'208";a="680039012"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2022 06:43:19 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oT1WR-0000Id-18;
 Tue, 30 Aug 2022 13:43:19 +0000
Date: Tue, 30 Aug 2022 21:42:35 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <630e13cb.zu624HkBYLK0F5S5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661867001; x=1693403001;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=JF5ViQjOf4JUGQXMZVvV7dpMVJPtc2E4ztxQ+wUgVp8=;
 b=PLKm2IiWTaPTW+si+aQvPs0qVz14oT4dcDAd4PdFAb1J9euEuILrf2YS
 F/nNhnEAWdbqobs1lXqJ/Q4AFgdrlruwtAsPwXaF2EjZ6IxU/nzzTKGCM
 2qO4gAVeIIBJVYo2tzRh+rA+8cxOJxuZsEJ+iJhUryUjl9eIHiW0faoda
 AZ1d4GHOhnfAZ25cD+TEFV3XJ5TUc4oVRMhvlWBgErjh+pdAK2BDAhuvk
 cvYIRUE3blWYPXtmO3T8KD3EN/mCya1F8G6pfuPActLoyp3aBUx2TWPml
 YKgEgrEZJp2fIbV7JJ5OLTpaMzysvKeF0vzzCawsadysOFhK8gSmJKGxN
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PLKm2IiW
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 428f07f06f150f8ea8d064ba9bbdc91ccc4d78f3
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
branch HEAD: 428f07f06f150f8ea8d064ba9bbdc91ccc4d78f3  ice: Remove second GNSS TTY device

elapsed time: 895m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220829
i386                 randconfig-a004-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
powerpc                           allnoconfig
i386                 randconfig-a002-20220829
i386                 randconfig-a006-20220829
powerpc                          allmodconfig
mips                             allyesconfig
i386                 randconfig-a005-20220829
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64               randconfig-a003-20220829
alpha                            allyesconfig
x86_64               randconfig-a002-20220829
i386                                defconfig
x86_64               randconfig-a001-20220829
m68k                             allyesconfig
x86_64               randconfig-a005-20220829
x86_64               randconfig-a006-20220829
x86_64               randconfig-a004-20220829
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
arc                     haps_hs_smp_defconfig
csky                              allnoconfig
x86_64                           allyesconfig
sh                         ecovec24_defconfig
i386                             allyesconfig
arm                                 defconfig
sh                          sdk7780_defconfig
powerpc                     ep8248e_defconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
sh                          rsk7264_defconfig
sh                        sh7757lcr_defconfig
ia64                             allmodconfig
s390                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220829
hexagon              randconfig-r045-20220829
s390                 randconfig-r044-20220829
riscv                randconfig-r042-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a016-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829
arm                                 defconfig
arm                       netwinder_defconfig
arm                      pxa255-idp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
