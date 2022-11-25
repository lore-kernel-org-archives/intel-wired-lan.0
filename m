Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8280C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Nov 2022 03:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AC6A400A6;
	Fri, 25 Nov 2022 03:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AC6A400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669346638;
	bh=c4gMQOQfvqgKPCB5u+BDTxycO/kLGnwnXmzUKlnlRdg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U/B10u9wn/wBEKOXSsSVUESgpCv52zxf7LFitzNMlzlJVtcJTl1UNrNGrNxgZKsmM
	 9m1rAHRlE6qdKnWs+1tBh5HSX56nvqtKqaSgMqW60coEvG4kfhtXzjPdGu5RPa4x3a
	 L2tElOinhvL6PpuADFZX1FUc0HdbKwnViNDhJ3XzfzIdD1pJHVIDtcchxcMG5Xfw1n
	 3sMtXQgt28NMxDuwMR1AllkcZ3O7EN/RT8BURDqGLZnaZPUBoq/mYvZjKMlGurn6f/
	 p5z3vZ5To48g1UBC1l15b869OdqxOKGVuQ6eNkNtxqFi9pLgRz1cQLQzBtxUX7zOLw
	 +Ju+glUjff1+A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTRUjesWTcM3; Fri, 25 Nov 2022 03:23:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E05240102;
	Fri, 25 Nov 2022 03:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E05240102
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 64F571BF2B5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 03:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35F8F81410
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 03:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35F8F81410
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xcI1nYea5MG for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Nov 2022 03:23:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2AC8813F5
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2AC8813F5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Nov 2022 03:23:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316221802"
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; d="scan'208";a="316221802"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2022 19:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="673414781"
X-IronPort-AV: E=Sophos;i="5.96,192,1665471600"; d="scan'208";a="673414781"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 24 Nov 2022 19:23:52 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oyPJf-0004bT-1k;
 Fri, 25 Nov 2022 03:23:51 +0000
Date: Fri, 25 Nov 2022 11:23:31 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63803533.066cwDLurYrcn2RV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669346633; x=1700882633;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=cKfQ/RZWoFtGvdPYFSoHRvntudWzBu+kLFSfMCxPHCA=;
 b=BY0lNoZiHQ2DT3+ZTq56B4mIYoKMfCbY2vYYsBnajjaqt/BG7JcsyUqF
 SaVdkYSbfE7yJ7KZEKNfb/0BTSQA9rRD8rTA9PjPBCnbMzFwkh409nsEG
 UCkSeeS3kGkHXdBp1yZsYNO/MP7AH2yytgwkidSRX9AvHNYL6jpho+QaH
 /G5QbHfc4pZxv/D84PbGgyOSVfAalHk7wzYqm/MaE5pptZMJkaLJOxhp9
 VSIYnCP4JXcQEKqmgvBJ912ZbOWHTm3ZIGEXPlVGXuyYPDwi8eLMsa1ba
 RexMvYvRh+HpehMC7jkdeJQPiPNL6PyE5iYbBk3tbQbgHrwBA4SjRkVZr
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BY0lNoZi
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 60aeca6dc47493a681199f8f53fabd5b96adfa44
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 60aeca6dc47493a681199f8f53fabd5b96adfa44  ice: Use ICE_RLAN_BASE_S instead of magic number

elapsed time: 1953m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20221124
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                               rhel-8.3
i386                          randconfig-a005
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
riscv                randconfig-r042-20221124
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
