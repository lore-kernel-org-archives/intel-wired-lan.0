Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698A2C4332F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Dec 2022 11:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0429761133;
	Fri, 16 Dec 2022 11:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0429761133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671188800;
	bh=xmKFl28gZdW8BIqOPzdcIBdUbjC0Ra5M8liaiGh8mrE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cVSEDPxfqCPmrtmxRnj/hUsh9GKiaXGumNQPRD9IbhqJBpFbDX+zikEE5ZBZer1OZ
	 b3ZYp3+iR1PGMBvsdgN5QNU//fK7V1i7cpUmvVtNCJPQAmOE8NqTgFAvDdY7Kyogd9
	 zr4zfauOyK+Y6XSOQbrSaTrkY4JPYk6oZKvTGdU9VjhjCuANkdosMY7GM/AiSQH4LV
	 5ArcayeCtP8S5gmh41Rz2bMBidwmPlcwT1eS5HvHazZnvgwuHnVwpJPlUXBuei/x0C
	 uDdCPMmR2Y00MmuZWinOKeFZqCg1JjD6vmbmZF3CNUfN3e2TaHXwpO8jHuukOlODgW
	 NiWsOBzizUvFg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8y8_mmJ2eM3; Fri, 16 Dec 2022 11:06:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EEB26112F;
	Fri, 16 Dec 2022 11:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EEB26112F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1F2231BF2EC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0B0E41A3C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0B0E41A3C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUKiRD7hoCEx for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Dec 2022 11:06:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF40441A1C
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF40441A1C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Dec 2022 11:06:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="306621446"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; d="scan'208";a="306621446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 03:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="978575376"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; d="scan'208";a="978575376"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2022 03:06:29 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p68Xs-000780-2G;
 Fri, 16 Dec 2022 11:06:28 +0000
Date: Fri, 16 Dec 2022 19:05:33 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <639c50fd.dblO71PIj/ABEP+p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671188791; x=1702724791;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=qc9nmasHlEHiqXAJmJ7hhwNg1LWs39hmGTVrmleD23U=;
 b=O/F+ISzeCvUNjrxYJ79MEchzbuiTDaxGFjzWJe7a0eyBU5HNeTFBIXUp
 v3yeYFbwQLYgUXS4o03NfQ23RkhmLIWBMHUwYidmAEaJhvBonHAcKKqpy
 WtHbgu8ehrGws10rxaJZoDeilvO2vMu/g66nUgYxmrtxWpqGrqCoBcQJQ
 jLCPJFkQKcdeiX39ojZIJZiyVz4Y5j7FcrcUUCrejJ5ykAEoF3JMdLtdT
 gn60GwBnBsfnHlB8KKw0nNI+yQHN04Fc31k9+bG6Zyd4abdZi6wqxk2kk
 mwK0eUbePUN2m/itj4V60Kiah7ru7j+2EDuyQHTXW8yS6rnkZv+IhhHhN
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=O/F+ISze
Subject: [Intel-wired-lan] [tnguy-net-queue:1GbE] BUILD SUCCESS
 72abeedd83982c1bc6023f631e412db78374d9b4
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 1GbE
branch HEAD: 72abeedd83982c1bc6023f631e412db78374d9b4  igc: Set Qbv start_time and end_time to end_time if not being configured in GCL

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20221215
arm                  randconfig-r046-20221215
s390                                defconfig
s390                             allmodconfig
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a016
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a005
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                            allnoconfig

clang tested configs:
hexagon              randconfig-r041-20221215
hexagon              randconfig-r045-20221215
riscv                randconfig-r042-20221215
s390                 randconfig-r044-20221215
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
