Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0593C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Dec 2022 05:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80DD560B2D;
	Thu,  8 Dec 2022 05:44:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80DD560B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670478283;
	bh=m5zm9BKvKbZfro4jyS5qsTrTTiDuMMrwzM9lsddXSwU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2/uKbzQP69okWdOgV10QEMY6zKFud7FmVaPwmBb5DTR/XhO+tQDphT/Sl2Uxv3Kvo
	 kb7MzWJe6231ZP49CA6im5hZKwIPKRfHA43xxgnYPDUJzG170huqjl1yBSmaslZ/Z3
	 cP6QDdBfBmY70b/5UVXw6OBumzHePpdKIkUO4tRPzn2mm8KEIbLDrrYgucu3M1Lz85
	 gJ6UrMJgExkX3KrvJkIiKeplI7OeBNYSZY9M7KhKy+KXMdmdH6X10gIYo1/uXrWemA
	 wMyvFWP1IjdIbx1utmokh6yIv4pJMMlqqzxnedjta7/lyKqv6Mf931AdBiciYoPxc8
	 BKWrkYxpfB0kw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ufdpe7HSfKrW; Thu,  8 Dec 2022 05:44:42 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83CD060B33;
	Thu,  8 Dec 2022 05:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83CD060B33
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A12E31BF969
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 05:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8803881279
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 05:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8803881279
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNgAC6WR4V6H for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Dec 2022 05:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A97080FB7
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A97080FB7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 05:44:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381373414"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; d="scan'208";a="381373414"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2022 21:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710331787"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; d="scan'208";a="710331787"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2022 21:44:34 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p39hx-0000tB-1c;
 Thu, 08 Dec 2022 05:44:33 +0000
Date: Thu, 08 Dec 2022 13:43:49 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63917995.zvltL6YueG79WFmo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670478276; x=1702014276;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=sv/HxNJAqRm2b7f5LCzd3d8A4d30zTRCuHGv6EcuC2U=;
 b=BRjvkDaWYMsxrxAxCX8M8gMjk95T5jTSF4KdXwr36zMAxiBxb82QrK7G
 8i9MpdoYti1zRppF/jmv9akjpPqtiXJ9qPqsfBOsnktHj6ap1IbtwJGsu
 RvtEHdkzKCy2bEpaDRll9Aakb3EeojYsa/6it0z6bAtSfsfogIxNLQmWQ
 Jt6/v2g/Xbtrk0aYL4+UXm++ug49pJKcN+5MJ5l/icvHOwZpiKGmWJXnN
 B5sNb0Kl8dtrXoUrC95G9VLL+uSkwqV4k6KmcmjLn3TK+/Xxk9Dwt97Bx
 hBro5uebrBWBjXW5FbgdTbkiyCGPaSyQDINRIW4UwcwgiAa08ySE+2TT7
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BRjvkDaW
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 87a39882b5ab3127700ac4b9277608075f98eda2
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
branch HEAD: 87a39882b5ab3127700ac4b9277608075f98eda2  net: dsa: mv88e6xxx: accept phy-mode = "internal" for internal PHY ports

elapsed time: 869m

configs tested: 49
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
alpha                            allyesconfig
m68k                             allyesconfig
s390                             allyesconfig
um                             i386_defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                           allyesconfig
arm                                 defconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a001
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
