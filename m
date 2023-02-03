Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F1DC636D6
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Feb 2023 16:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2757D42AC4;
	Fri,  3 Feb 2023 16:24:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2757D42AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675441456;
	bh=JNE2UuNHPTEsa3L5k8yBjyBIr47Ge5sxKNTyYBoBDUE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AvFpoFbtMXdUMRu8lS7vKBZXwp7Hllw0YVrB8uxqG/AtTWUT9YGe8K9o1h2PQf2rV
	 h0RxJFSQHwapBGzhSBObrQfF8fCgSsJx7sx0XeAs/QBZ/0TDroUjyDZfyuFVRexTcH
	 kZhv69XFB69cy+Sk5YvLexKjWGN6hwRN6XEHF8ykEz2oVzw+NEG+uo3qeRSOzP7y5y
	 TWpNWeku6H0wks30Ab0gejfkbP9AUeveyIU2W217OMEz/14gW9PfJIdQ6Yr+BugLzD
	 DTqyf1Y6gV+KhY4zFT/CgB0lQdHUnMNzn80zFYuy9OCjXJtWtF7AD0UJCMyzLJsWsi
	 96FJNjylHImHA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJXPxbMT_ysJ; Fri,  3 Feb 2023 16:24:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02DE242AC5;
	Fri,  3 Feb 2023 16:24:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02DE242AC5
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 02DDF1BF283
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Feb 2023 16:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D00C042AC5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Feb 2023 16:24:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D00C042AC5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vs_-Sfav7ZYS for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Feb 2023 16:24:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C086E42AC4
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C086E42AC4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Feb 2023 16:24:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="327422358"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; d="scan'208";a="327422358"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2023 08:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="659133444"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; d="scan'208";a="659133444"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 03 Feb 2023 08:24:09 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pNyrA-0000dH-21;
 Fri, 03 Feb 2023 16:24:08 +0000
Date: Sat, 04 Feb 2023 00:23:17 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63dd34f5.CV/hovTi1lukq37/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675441451; x=1706977451;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=h4pGp0H2j5P28CDwQ3Fn0vy7BlH40PBxH7ycD3y+TGU=;
 b=mqbdBlndUFBwEWpr24awgbHU4I1kdAhiak4z4DPOCM3b2ZW0SDoBw79l
 xZ3ucz/QUdE1qw5PEuUEdqvLAvLcNawa0gECl4d99vKKSqsxnswiAMh2D
 isu6siOAeX8fN4YvY/F8M4/H1Tj5u9FGOkB2oyaIAbJwLg98VaXXwOaYw
 gzyacRXUerK58cqDNjvWIeZZR+FyfqrX8ROn3RK+GW8MZVw9sraq4ZoLK
 uKmn2dqciSJofWXjdj+QYdwCzBTvyaaI6ActAWLB2+ok32y68eujRU1AH
 HoNraYRpYOWXtTjpzZxGNRy35GCXHJhnPsnfzPJTfZgDorZ2X3bj3mHeE
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mqbdBlnd
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 82b4a9412b4de2f68679f1403f1d229390ace27e
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
branch HEAD: 82b4a9412b4de2f68679f1403f1d229390ace27e  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 950m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                  randconfig-r043-20230202
riscv                randconfig-r042-20230202
s390                 randconfig-r044-20230202
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
x86_64                          rhel-8.3-func
s390                                defconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
mips                             allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
sh                            migor_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
arm                  randconfig-r046-20230202
hexagon              randconfig-r041-20230202
hexagon              randconfig-r045-20230202
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
