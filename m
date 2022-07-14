Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5863AC433EF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 14 Jul 2022 01:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B49C683E6A;
	Thu, 14 Jul 2022 01:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B49C683E6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657761279;
	bh=vxoo//NsF14EwSDLXmaqk+XBIO5CEcFoGHNKhXbYG+c=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2TigcE8zl4gIUvAldsL9gx+KSD2n/VxcrhkLV7Q2fi6Z4ww8TnC/pbGnvinY5tXUd
	 ifxZIg5aJ0pnXho7+cRfgDpic2pRDZNuslMfd7Mj3JWdqW4wLKg2PfQ9PT9szwQGVb
	 vVJ0CUnfzLeoXPyGN2lhfObbRfabEzzb4nx0C8g2H2uEfcCvINaC22meom3+1+C9Dd
	 5hPTJmmJ8/OeL5UH1j0xiFTwyImKG59WyNhRuB8ZRGcaxcm/N0fS3gmEuODFZ94bbN
	 loAfix5a2FENgyDHiY9SQh4jKl+dV0F2zhmPaTgf8cXV6xR6GrX3i8EmviPVb1nYXK
	 4yn06jKlcEipw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YY21O-MBYBxs; Thu, 14 Jul 2022 01:14:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9860983E72;
	Thu, 14 Jul 2022 01:14:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9860983E72
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id DDD561BF3E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Jul 2022 01:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCBB383E72
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Jul 2022 01:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCBB383E72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXDSXVO1TDPY for <intel-wired-lan@lists.osuosl.org>;
 Thu, 14 Jul 2022 01:14:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A08E583E6A
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A08E583E6A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Jul 2022 01:14:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371697128"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; d="scan'208";a="371697128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2022 18:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; d="scan'208";a="623201413"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
 by orsmga008.jf.intel.com with ESMTP; 13 Jul 2022 18:14:32 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1oBnR1-00042N-PA;
 Thu, 14 Jul 2022 01:14:31 +0000
Date: Thu, 14 Jul 2022 09:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62cf6dbf.Ivpax9LiyG8Jtv3D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657761275; x=1689297275;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ll8mMrctBXC0OZcNhtcWi962PrUrGOrR2Nyz+41Jkro=;
 b=lbyUWjJjgG2VMY1qCX6evZR57DrGkc+G4HzBSSgFIptDrYOe7QAtEBBR
 A9J5S9yieWczcBEKLF5ISTYsX6z5vZ/qXf2okZ4XTKezhchfMcCGQB/eI
 EV3edIIrqI+QLZk9uGkOdPUah4TxK/b82UBsinDht2kaOfSqp2G7QKCRT
 ZLv3uCQUXDIhY8N+tHdMjnNkB0lxKdtcU5OIRmiRRDDx48dR96g6vKCwO
 eufTgCbSaLXf8uyx1hK0EaT4IfCJgbFDbSr/oXxjlz2M1Gdp2JSyDsqg9
 ckB6iSMeG7xNUBIJ2Hlfybt34KWvFCwtigHcS15Z5oSKHMj8D6B4SOOum
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lbyUWjJj
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 835a53836d412f5a5b9cd86d5e281c0b6dce1569
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
branch HEAD: 835a53836d412f5a5b9cd86d5e281c0b6dce1569  ice: Implement FCS/CRC and VLAN stripping co-existence policy

elapsed time: 1587m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220712
arc                  randconfig-r043-20220712
riscv                randconfig-r042-20220712
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220712
hexagon              randconfig-r041-20220712

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
