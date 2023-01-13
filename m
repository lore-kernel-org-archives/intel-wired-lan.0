Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94258C54EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Jan 2023 07:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15179400E7;
	Fri, 13 Jan 2023 07:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15179400E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673596399;
	bh=kURCsZQNM7a2VHdL2D3DBHBqTfK71RDqIeoDcfjrjig=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YfkbQbPoxhfAs6vBVFe6n5paRvplKrtcbCZiZGmai2tGkkHn9hpAbyV3e/b2HBXBW
	 1DyYZL57bxk0Cc5XPtOKlIq/EjcBMTZgj7pLiVFX4XZhG+aH2SXqiceuGfAgRrHxYu
	 2mRH4cCkP+rttax+QogyEAnJT3OWTBjbgyDT5ySJfebI7pPCKfC7kCxE+lR3Azq2Bv
	 ncM8M+DSi16OXv9UgoK/HS7Ls0BuKQhVzfNgf2ZaKuT+BM7m5CtXIo3mu360aTk44+
	 f1uliy/bJFePJ3/oRVe3UXyzUzzUs1xOQPU54vtGBXhbJYYnad3x4jrFQL+S2CdEE7
	 qgDubWwoIbD+Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qvzmPbsG3yT; Fri, 13 Jan 2023 07:53:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 191774012A;
	Fri, 13 Jan 2023 07:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 191774012A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id AE5431BF330
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 07:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9527D4012A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 07:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9527D4012A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CHdrrLWUEdcy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Jan 2023 07:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FE6F400E7
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FE6F400E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 07:53:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388436970"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; d="scan'208";a="388436970"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2023 23:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903504634"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; d="scan'208";a="903504634"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2023 23:53:13 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pGEsC-000Ats-2i;
 Fri, 13 Jan 2023 07:53:12 +0000
Date: Fri, 13 Jan 2023 15:52:29 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63c10dbd.wgFSiNuzvRdblro0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673596395; x=1705132395;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=y1uHNW96VBeO7huXfmHBeE/U7p/rYa0D1Y67EGxj/YI=;
 b=EkY4xXE9BKbyh1HWpo30AcBLZtoaGh1MGQDAqs0TFsRPQ9SyZ1mD2A/F
 nZWXhYX9QFGHPGWQz/wDHyjaOxC9Nj9C2mGbkKywLQdDMr5SmpowYLUI7
 3SibpbnpXLw2F49wmgqclLHmd7J0rmCNj7gxAu9OenQ3ckE3N9oVfWPpR
 2RJQQ/6jCqM3tnMmSzZ7Rn5mGb/JMWJQ/xoAFW0i1RqA6OxzD/IWefAG5
 MUfDaaclwFgJxMpTOff+s/NLEmtRObq2nK4G0a4nHkFBcWgmhX08CZSc7
 bJlia1sShZiXSRulqHAPJHzxZm4YNB38noZoVlyytd53KEZfj4jbA7oEs
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EkY4xXE9
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c20aabd571649b632197cfe392eacf46a24c4c6a
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
branch HEAD: c20aabd571649b632197cfe392eacf46a24c4c6a  ice: avoid bonding causing auxiliary plug/unplug under RTNL lock

elapsed time: 771m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                            allnoconfig
s390                             allyesconfig
arc                  randconfig-r043-20230112
s390                 randconfig-r044-20230112
riscv                randconfig-r042-20230112
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a001
arc                              allyesconfig
i386                          randconfig-a003
alpha                            allyesconfig
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                               allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
