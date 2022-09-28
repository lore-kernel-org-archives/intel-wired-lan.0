Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B6BC32771
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Sep 2022 03:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB3ED414C2;
	Wed, 28 Sep 2022 03:21:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB3ED414C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664335296;
	bh=EfacS3u725xTQexeeYGGdNekfaai8zguK3pPTEp/fRo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=20AL72hBUndBqtAsKHvkVrgpI1zgK+as3IZCmrWOYHLhh35ftGp8m8pVoZXG/9riH
	 rvpUjrZRNUk/iymO66Dye7zAI6aYbpM0KUM21PQFq3apIJxvgOv2a3ecR/ns6AXt09
	 o7U9gKgSl4++7yFZhQ9FMk5jSO+K9g5f/lQj2SWDNL8mG+jdNZqPIiw3zxXuxgyMWo
	 By+H1/Z+EfnkmPq47bnDc1NemdG51d/Co8tR94kaiyALQfHcnuRJfGMq57W+ugNdSp
	 nkB8lcMhddkLFAZaO0zii9ypOaGuV0/cBT9UgRz4XMBqAUbTf2uG+TW4GNeEuXy0iU
	 sdeuAbB4Uu4zw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6zK0WYhjqx9s; Wed, 28 Sep 2022 03:21:34 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93AE9414C8;
	Wed, 28 Sep 2022 03:21:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93AE9414C8
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 6216D1BF20D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 03:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4742C414C8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 03:21:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4742C414C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6gZRwkzv8koV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Sep 2022 03:21:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCE2F414C2
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCE2F414C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 03:21:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288649248"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; d="scan'208";a="288649248"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2022 20:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599415116"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; d="scan'208";a="599415116"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 27 Sep 2022 20:21:04 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1odNd9-0001ua-2t;
 Wed, 28 Sep 2022 03:21:03 +0000
Date: Wed, 28 Sep 2022 11:21:03 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <6333bd9f.nq6bsn1d17hglRe/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664335291; x=1695871291;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=AyWq/lg9F4p/cT1W5cxtCpuFymzJVl4w6rA4d4dTvNo=;
 b=n+rfI/89XfwNnRIBmXdkN/LVQXsuJ8e259tyLFwGqbi32fkX7Ltl++7D
 0f6ViGflX3W/T2k4xsOxcNR96Dt3Vm2zwTcSvisCg08HLg7xIY8QtQCTX
 XxCuvrdxQNRxRZ9eUnuD3WEmLBEjTJ5Oajr5EKHeIZkPk9cAq1XQ77J78
 3fspECbaYEDbvWrbyIer0jq/HZR9d1IuV+pe0hySQqBfmbQMcQAH24Zoo
 17nD3tzisTRXkQpJetgWYIhoPyu9ysIFWFZkj+0SkP8rzc1yaDcynpd+i
 cSIPOP2SyFWqs0Crx4mJxAYFkCNv2rnAsTp8krCzUsxnU/eymyLAVt1fj
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=n+rfI/89
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 797666cd5af041ffb66642fff62f7389f08566a2
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
branch HEAD: 797666cd5af041ffb66642fff62f7389f08566a2  net: usb: qmi_wwan: Add new usb-id for Dell branded EM7455

elapsed time: 727m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
riscv                randconfig-r042-20220925
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                                 defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
alpha                               defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                              defconfig
arm                                 defconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
arm                              allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a002-20220926
x86_64               randconfig-a001-20220926
x86_64               randconfig-a004-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a003-20220926

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
