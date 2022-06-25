Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71290C43334
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jun 2022 06:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0309D83F2B;
	Sat, 25 Jun 2022 06:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0309D83F2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656138662;
	bh=Vvsf2CZ0ro8GvhyiRIRKr8XUQavFUtQ3/V5RSrI5NLE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AB6Q2T7QBXS26JFlow4IFn6NEWbDOZjrrFKWGIK7KGzXgfR5UqC7SV73blvoLBs34
	 OnhneHpThortrkblRrBf6sD7MwjTcinFl5+1efUHP1dDzwuVGUu4OACOxXJoEGqsuz
	 LWg2pdEfZQxGEMmAOQ1h01bbPH5I9Y+gYXPGBiDR8uucWoBosdGYWmvIWjCXpRkCBk
	 Fv0cdDMYpBIswk/S0hZxywnX9hEFrfvGvyLjmnjbYi5qJp5tDKxfea1lj+N0kWaJN1
	 lIVchl4LwmN0QhELyf/qvpLLT80w8t7frVRFVT+70h9YyhCLK8vWsOOG3tqurzm5ik
	 x1J7pvX4OjZLw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xOW0WClAfmoQ; Sat, 25 Jun 2022 06:31:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0281883F31;
	Sat, 25 Jun 2022 06:31:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0281883F31
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id A0C1A1BF2C6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 06:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79EAD417CF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 06:30:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79EAD417CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHghA-CmE6dK for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jun 2022 06:30:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FA93417C3
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FA93417C3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jun 2022 06:30:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281890103"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; d="scan'208";a="281890103"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2022 23:30:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; d="scan'208";a="621960306"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 24 Jun 2022 23:30:56 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o4zJn-0005T4-DG;
 Sat, 25 Jun 2022 06:30:55 +0000
Date: Sat, 25 Jun 2022 14:30:43 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62b6ab93.f8mHvRk0bInY+32B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656138658; x=1687674658;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=owbO8Y69BdUzKSsHqiOsFterad0Eup/+s5EkhMvBCcg=;
 b=gqL3X/12ZA07gs/3hofVjlDCbIADyJxZjlrhfMBuo57Jx+FmErj1AJeN
 RFMC4yNqxkq9eMlvN5HJP9c5hiodd7zi1lU4Q5Mk/VivpZwN7/WWEtc8P
 0Uo8FjJ1WBOYCes5fdohl6pmNCsgiCmJL9z7llvR4zZtjnxNrgvnacOPu
 DA3jVCaXKWcdLt18P9TAkJhCHHO6cxRmEomqJfSSX6qfMJr88KVpgps0G
 ubzEDtZ2xJJknhGMRouEhnXnKwcW6re3R1haCVgbDydIlJy3uFzH+jpQ0
 zVOTJkJywmZqKRBxiuBfkdQ8BNig9HTPPaMhixVOWP1YdYgKdzZ4/s+uT
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gqL3X/12
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 b4cbd7a9339f396a991a9a056c4b57a35a4cbd96
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
branch HEAD: b4cbd7a9339f396a991a9a056c4b57a35a4cbd96  net: lan743x: Use correct variable in lan743x_sgmii_config()

elapsed time: 725m

configs tested: 42
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220624
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220624
hexagon              randconfig-r045-20220624
riscv                randconfig-r042-20220624
s390                 randconfig-r044-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
