Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A1EC6FA84
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 Aug 2022 09:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77C39400AF;
	Wed, 31 Aug 2022 09:20:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77C39400AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661937607;
	bh=l07TxNAq2g0JD5DOP4vlj4HZvtnqelO5BUzQBjBYJW0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cegDHkNYmXJp+DzJmO/jg7i7sKyjiUhqHExKKuE/3Uob8AegZeU9SpCTjYjFpOP6b
	 C3QN0oti4ajzmJ+6gKP1BQ4a79vaPcYOqVyvmBrOizKAsm9h7BJov5Bk01VH/OwTSp
	 /D9YXhJ7ZIA+c/iPwHDAmAmJJtVXvu4t65o54imWhoJHm/OJYWAvpePkZpg0WokZ3o
	 mYoozpft94xYxnzHp1+tf8ESztBriWtXWZX5QZSsstPH8HQfXLLhTqzJky76EiAY6N
	 xHN910rdw/OMrCXcsDX7U3XHu91ZZKzKSRWmYNjs/rRjafKVVzMGAbowUf6mQsSwrq
	 CF+1VFG2oeV9w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Xn2n8c_ai_p; Wed, 31 Aug 2022 09:20:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8136C4014C;
	Wed, 31 Aug 2022 09:20:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8136C4014C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 512131BF388
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Aug 2022 09:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B18E4014C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Aug 2022 09:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B18E4014C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id utqwAVCnqi7o for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 Aug 2022 09:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C31F400AF
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C31F400AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Aug 2022 09:20:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296194498"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; d="scan'208";a="296194498"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2022 02:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; d="scan'208";a="787810330"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 31 Aug 2022 02:20:01 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oTJtA-00009y-36;
 Wed, 31 Aug 2022 09:20:00 +0000
Date: Wed, 31 Aug 2022 17:19:56 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <630f27bc.qXjSsIUQVQ1ANWYI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661937604; x=1693473604;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=r/z/sZwdOKEBgQfX/LZ7GE5NA/Ugzewn7yx/1yOXZXc=;
 b=SeCam/sMQTQy1Ipo8wRbLVq7tLpgidZXwfTrAGm4juoYJIJyyFt3p8Zf
 /FkHU6fkDUjG514O5919vvSyNnDZ6ZMWrl59qedqFPB2BaBcNjKXTr40r
 CRV54+1aBm1wardo/nFdtsDGYNayYFhxFHrmG2Q4QuUPPvWYyKpJ+wE/j
 0G3oGChX4J57O3eBAzD5Oy15qHJdaU92CFkjn9IojKj9Ja4Cb7nlc/VDX
 cKpQKynknMa3qdp9MlHVeuroCymhRI6N8ToCaZ5YXqAFMi0ad9zJ2oNEs
 nzi27K6yH26tmbWSVM7bg6Z8/zxfbvE3Mufwu2tryLL1MgPDXPukv9KCq
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SeCam/sM
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 84886a750a505de11a7a066a7ac3bf82a6f72644
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
branch HEAD: 84886a750a505de11a7a066a7ac3bf82a6f72644  drivers/net/ethernet/e1000e: check return value of e1e_rphy()

elapsed time: 724m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a014
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
