Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F297C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Dec 2022 05:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3133640327;
	Fri, 16 Dec 2022 05:45:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3133640327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671169525;
	bh=NKjSZGRSIho9nS2wln4tNCTC1/pXRaxeFKuHZrkqbYs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=6BDUl/w84p281KF5YG1Eg7DLJeRPP4hxziCYORbWOUHghKNIa26/ysIujXPI3vbmp
	 kH1tNTSpS9OgLsCJjaYNPV/SHNf0gGBjqvRJR98ZKGeWgU7XqHjpLEMNn0F/Py22NB
	 wrEUAz/8FBcuxoXzn6CEK/6P/c6wjHadj87iHV2yYD+1wudMZqFWsUd8kTozFXUp8Z
	 Frhpn8D/KibADZdLMLtSFsTieURcbkS2Kb1kIbUOFQ/2Vw8fqZEXGniu7s4nPQPDba
	 lkoOsC8Ppbhj7/+6RQVOFNl78zJ6LO+CefF6edIIAarzkyRofJZJU6JVjjre3cNhdo
	 zCcjSaYWFF/Tw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qjz1juPEdY4W; Fri, 16 Dec 2022 05:45:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38CF6404AB;
	Fri, 16 Dec 2022 05:45:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38CF6404AB
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 929631BF34B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 05:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69BCA82071
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 05:45:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69BCA82071
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fnmp8pK2vzkh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Dec 2022 05:45:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EBE082070
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EBE082070
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 05:45:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="383223772"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; d="scan'208";a="383223772"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2022 21:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718259308"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; d="scan'208";a="718259308"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 21:45:20 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p63X6-0006wp-0M;
 Fri, 16 Dec 2022 05:45:20 +0000
Date: Fri, 16 Dec 2022 13:44:53 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <639c05d5.ASLyhBZ/USLle9nL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671169522; x=1702705522;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=7dS6RB8LLLB7cbwXTUTJIcXnc6To+tGbWt80+tkeYHA=;
 b=LZ+kZEdWk8tD4reHu49LrgbfTpsudaraq/RAtDf1fQ3400yjaf0qYbZS
 ZUksb9PF8Ef3aKfmje0ddm7JXUpF2VDP9TrAzANdQcNMVbTsDQUQtAkE6
 FBOMXSJ/JhFugmF+MhoMPzcechWS8ZaaqcOdFlJa1Bj0xrDSa2EZJhQ6U
 Q2ZqRd09GrASvmsweTRmqnpTOwl7b6ooaUjVWuzmxtdhQ+CoEykaPJnwE
 iqNomCTo8mc8IEvjHjYMtOr4ChSkWUun3yaGpd1HCy6mSnuYCj+JOFkRt
 oj0B51aTG45ylLvJCDG9RZ9MO8GfAoGASWHTGbyJ5i/vC8xuJcLRF4PGE
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LZ+kZEdW
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 a7d82367daa6baa5e8399e6327e7f2f463534505
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
branch HEAD: a7d82367daa6baa5e8399e6327e7f2f463534505  net: dsa: mv88e6xxx: avoid reg_lock deadlock in mv88e6xxx_setup_port()

elapsed time: 876m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
i386                          randconfig-a003
arc                                 defconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a004
arc                  randconfig-r043-20221215
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
arm                  randconfig-r046-20221215
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
alpha                               defconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a012
i386                          randconfig-a016
s390                             allyesconfig
sh                               allmodconfig
s390                                defconfig
ia64                             allmodconfig
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20221215
hexagon              randconfig-r045-20221215
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
riscv                randconfig-r042-20221215
s390                 randconfig-r044-20221215
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
