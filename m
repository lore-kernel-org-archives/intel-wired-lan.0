Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A76EC4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Dec 2022 11:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D87316080A;
	Fri, 16 Dec 2022 11:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D87316080A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671188795;
	bh=06PLSJ8YzaeVA6CADQSmrL2n0FXDSoGWqcNNFcX5haw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=herOIBbtWKUM90cwaXWgw8MOvSv+soW5FyL0TpsADAEZ3rTfKpPAmUZQznqK+lPuP
	 zqLBrBelqRSFlauRQHCm1rOA8ykptY2MbBwO2HIYLuuYRtkDTI2OcFwX/egUS15hf9
	 Y9ps0A3XBLwssqeWxNFad2qsrrIFr/YIvk8Q2yS+nei4dhDxyqb0XuisU3Q/sI6MvI
	 sMvbYn9IdMBXsOYtG2j+QIbSfoFCjg4m+InqFHnwV1mrxVnqi8E5g/A6Ku9oDM4grg
	 8/MfSVvCfE3vKgiQHiXxOceefM3lIv1AEMLQVJOj7bogtdbTlZRaeNifS6JTHsT6oW
	 m7hXAzT0YCBoQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Md_k46iUvR9d; Fri, 16 Dec 2022 11:06:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D044561121;
	Fri, 16 Dec 2022 11:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D044561121
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 162301BF2EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2B8C41A3A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2B8C41A3A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jjnGZvHMM9o for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Dec 2022 11:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DDB2419D9
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DDB2419D9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:06:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="306621449"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; d="scan'208";a="306621449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 03:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="978575374"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; d="scan'208";a="978575374"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2022 03:06:29 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p68Xs-00077u-2A;
 Fri, 16 Dec 2022 11:06:28 +0000
Date: Fri, 16 Dec 2022 19:05:38 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <639c5102.om29LOa0X+TgoZMk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671188791; x=1702724791;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=EkKGezWhxLD8V8vwr6etbzitLeT/tf0KcKqn7/TSAhQ=;
 b=BRMISJlEv2QITXIM3demQ375zivIBujSu0Yv2Jvlu0XUxmFQ3oCwNsUn
 oFsIJWwI9KR3eTmp7ySHTe4KXODZHARufdpIKwKTyyIYtqFhQVt5ZsRPj
 U97J4BhZLmWFowtEhfqj4AnKB4nM2VN8HCo8VEpDEv3x2Bkxn23Jtkvy7
 v+HilqDi6JkodPmCO3Ls20XoKGs9PUcFQk7BFp2tsrFhv00O7UWiRy9Hk
 ZhgjqcCZ4WQ0Qqmcem5T1/tsAiCxqyGAx3dvwo6Z44XUguAaF6bo2v92q
 pqjNdAtWfhR0rq0oghStF0rhIp675khdMxAU4z07mM37exp3VUzw1D6LU
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BRMISJlE
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 01f4643f6b67afa2ef3ca5879e556b873b9a14ac
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
branch HEAD: 01f4643f6b67afa2ef3ca5879e556b873b9a14ac  igc: Fix PPS delta between two synchronized end-points

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20221215
arm                  randconfig-r046-20221215
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
i386                          randconfig-a001
i386                          randconfig-a003
arm                                 defconfig
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                              defconfig
i386                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                            allnoconfig

clang tested configs:
hexagon              randconfig-r041-20221215
hexagon              randconfig-r045-20221215
riscv                randconfig-r042-20221215
s390                 randconfig-r044-20221215
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
