Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8222EC43334
	for <intel-wired-lan@archiver.kernel.org>; Fri,  1 Jul 2022 09:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14C4383F16;
	Fri,  1 Jul 2022 09:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14C4383F16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1656668441;
	bh=kDASmEh7nzxmFakqC5ubco3p770rHkT2rxalQv0w/dE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L+lWcMw0un469a8jbDG9NPLUr9DtEr8tUgEL32+IYNEhW7UGOARTr/e4ltJhSPjL6
	 VSI+wx5INUrqSbWITr+U2NAV/oTKQcQ5x/VwXyarvydrLrzBEyx/PUnBQX6FreUDtf
	 PtbVpUBaWyt4IlsDmDMYXKI8mFBzy2AG26EBXr+09KnX/QdwfrkWBQeDOjRzTuwVEO
	 3mURuKsjMYWtx43w0Pr3jHaIc0qjIe3NG1t05z9FPLQ4ObTddvC/COfHSIRAm+JvZU
	 eoYYYzgEi8k8N5vfMrrQ4PogpzL6pjRpCCZQttYnAimbHsPGhlLgn3tVy/+K2JClUU
	 r6h50hajV0ncA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PsL6VpiX4iM; Fri,  1 Jul 2022 09:40:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1226B83F61;
	Fri,  1 Jul 2022 09:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1226B83F61
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7B22C1BF291
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 09:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53F1D40B6E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 09:40:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53F1D40B6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZ9DfxLcCH3z for <intel-wired-lan@lists.osuosl.org>;
 Fri,  1 Jul 2022 09:40:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A213404B7
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A213404B7
 for <intel-wired-lan@lists.osuosl.org>; Fri,  1 Jul 2022 09:40:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368928115"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="368928115"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 02:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="566267759"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 01 Jul 2022 02:40:36 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o7D8e-000Dnh-9Q;
 Fri, 01 Jul 2022 09:40:36 +0000
Date: Fri, 01 Jul 2022 17:40:19 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62bec103.8Us8Lo/9NebdCjHS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656668438; x=1688204438;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=5YJAWtZe1BJ2zoDAGtNEPptuMAQ0ksbKYHbmumQ+ENI=;
 b=UukK0XkuXcm9BBUwA7jgE6qKew+Spb9BpSM83NO/kV+bbh2JE0tiNi12
 VyWW8qOzCLGzygBdpQZpGfSdTY2ZUxSPmLV3Z5p48p4lD5EPwBNnKcXIS
 Do9UTM5N0n2RzBdlmsxFzhzfqWKLUYiKZQrrmIFSHFdMDhpQ5ZtLAliXz
 OpgFwGwiLlMCK0UwDekdF2vrQ02uCHyXXUMkDK2QlXJ9AqOUCIOjWcpEx
 6PkIZKKkIx9VqfE6SwbvrkA6jCmkypZWgcn/iU3MA7DOfXMx6+1pBD6hO
 qoezeGEfzk1oPh4D872caAXcDTYONRBiPmnpICKTZ9dtnsPsbj7uf4QYz
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UukK0Xku
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 afa646299a282c5e621242c2db8c95c0ccb57d0e
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
branch HEAD: afa646299a282c5e621242c2db8c95c0ccb57d0e  ice: Remove unnecessary NULL check before dev_put

elapsed time: 726m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
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
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220629
riscv                randconfig-r042-20220629
s390                 randconfig-r044-20220629
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
