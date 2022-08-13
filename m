Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24A1C25B0F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 13 Aug 2022 05:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EF7540355;
	Sat, 13 Aug 2022 05:38:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EF7540355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1660369096;
	bh=iI8up3G7spj7H5QmEWRxRma5xV67+qg9mZ7S1LPVqRk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1tkIQlIsAkqErii28UjrhSKg4fnM7Be1cVRPqMPTKK51ivV4opG+H0vDqioeV2Q/+
	 a3GkTFBUTkbqd3eLyjk0XJ5oJFW2OWmMgTjLYZ8UrPkdHfH3FdECMH22AHqo6IxuGV
	 8fdDG6RhoFJkQcy7Ztnnr5zYAXXPStBkO/p0olUnL7qjY2FiQLI6zhBK4UmoilGuBz
	 AbbXgXpgH1JTXbwl/n7xktvMEdUWgWNxgmMm5GdYleV1C/WPa/4Fic2e2N8hRbBOxj
	 VglLlr2sL9Aa1lrmw7bCv0OdnBD/19oLRPBDvfWeQ7LhQZfm9tcHz4tExsMeZgLylQ
	 e09xcnHoDk/Tg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t4ovYB3YBrgH; Sat, 13 Aug 2022 05:38:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D86B640386;
	Sat, 13 Aug 2022 05:38:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D86B640386
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C7EE11BF82F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Aug 2022 05:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D41460D6E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Aug 2022 05:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D41460D6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ne-fPWxuvLVd for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Aug 2022 05:38:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C40C60D4F
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C40C60D4F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Aug 2022 05:38:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="271502828"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; d="scan'208";a="271502828"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2022 22:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; d="scan'208";a="732441170"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 12 Aug 2022 22:38:09 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oMjqb-0001Lr-03;
 Sat, 13 Aug 2022 05:38:09 +0000
Date: Sat, 13 Aug 2022 13:37:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62f738b1.yrQmpLweUw8kD7P9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660369092; x=1691905092;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ykccb1dcgIKDdUoczB3LkcppJuRmF8r/e1onSPw0+QY=;
 b=kwxqDAa8ULGf/yBvQzYLXt8/6155TD44y9PDnU4z98dvd9MBV6VG0ziN
 lz9msmoLtkCCGC1pe1J5hIcAy7JhGuSwl2jEE5botP/L9iTZmDLDVjTgW
 fD/D7QGrNfgRJ27rO44AXvtMDpX7BB0UJyKLOZFAbEErUW92CzG2T3aLw
 nOeXywnZtqE5tGmeiHDw+R72yBlFUtDQLIarBdRMCMqqbYXuBXizzftJV
 a78jPshAvuSvP7iEaUyrG2kPKckpXfARd6vF4RG7wxazBU5iZREVdZoB8
 n/nrV+5MFSu/uQaHxIcONDhGU8zWrJfBs99EvFqX1ihwRF4elJecsfuI6
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kwxqDAa8
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 cbe9e51126305832cf407ee6bb556ce831488ffe
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: cbe9e51126305832cf407ee6bb556ce831488ffe  iavf: Fix deadlock in initialization

elapsed time: 720m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220812
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
sh                               allmodconfig
x86_64                        randconfig-a015
s390                 randconfig-r044-20220812
riscv                randconfig-r042-20220812
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arm64                            allyesconfig
arm                              allyesconfig
x86_64                              defconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220812
hexagon              randconfig-r041-20220812
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
