Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BEEC04AA5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Aug 2022 09:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAC278343B;
	Thu, 25 Aug 2022 09:48:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAC278343B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661420906;
	bh=leWMCvgh0cIjAWNK+/EYnzkDLIt6t3kuPVIEiA9e7Bg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DtICEhLAE7nz9wRZi2pw043sbTC99MxkpOVfkNe1GBuwV3QJymyyAxfzxNKDvAzod
	 KDba4Ziek0OVSAyfPwDnEUWci4PT6Qxg+Siy6lcccVoJD3FjA4ZNbhZM1IcjJ5X/uC
	 T0GdTdXPXRi2mAlKyQBCQEJKKrAyghnQbT6tnBX/R7oqIDmrjUxWY0aAum91xFQlil
	 enzfPpa9Dmsg6sBAop9MgF5dZtC9Id4e39uMnTUAhuxlz3D0s3Wz+eVg+zzWr71h/S
	 XFyHqOuHpLJQ5SlGugwazMXyGHlp6sQZuhA5liw4vIcaI+J4iuduOr5HyRyv6M62KJ
	 Rx7NqUDxquNxQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vht_9xSrjx4G; Thu, 25 Aug 2022 09:48:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9ADF8343F;
	Thu, 25 Aug 2022 09:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9ADF8343F
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B14F61BF3DB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 09:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94C2240C25
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 09:48:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94C2240C25
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JiUogauksByf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Aug 2022 09:48:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99A8240C1A
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99A8240C1A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Aug 2022 09:48:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="358167415"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; d="scan'208";a="358167415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2022 02:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; d="scan'208";a="560967479"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 25 Aug 2022 02:48:19 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oR9TH-0001xA-0t;
 Thu, 25 Aug 2022 09:48:19 +0000
Date: Thu, 25 Aug 2022 17:47:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <63074540.6W80HOQIkl4J/sy4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661420901; x=1692956901;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=7J2JSrUZ6YkUia6Lua2ObxEGIUcRP1YguWcw3Q5Qk34=;
 b=cdVkTVfoltI1T5Oh7u6NuYiBm9WpHQVu/kVoCJbUjCh2FDzjtL7fQ2qN
 YjiW/bDjj0rH1C53dsfADl0jnlxMzAUtIeiXqNrcajBLdyZOj7D3fpRTZ
 ZTbro6hrIHwkX6Z/Wb96FOZkywQ2FjY2aVtTraSaBVi8bbRB6CfODzj2G
 lHGEWLG4clscQz6l5GJ0RzFKj668hvFy/Xw2vyALqTKexxvwY8UIKdZ+R
 swBUnKdqZd3oxXfFMBZLlWPRj/2TsVTT9H2bS/MOEOkAlBB1y8jhArxrl
 jpcfNYnUTbhMKphlSbWAAAJWLPnolwgT+eERdaiprkIDAqnqZDBWE9GcN
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cdVkTVfo
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 f38433459ca2ee2ff9223c3820793b23225aa503
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
branch HEAD: f38433459ca2ee2ff9223c3820793b23225aa503  ice: add helper function to check FW API version

elapsed time: 725m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                              defconfig
x86_64                        randconfig-a002
x86_64                           allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20220824
i386                          randconfig-a001
x86_64                        randconfig-a006
m68k                             allmodconfig
i386                          randconfig-a003
arc                              allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                 randconfig-r044-20220824
i386                          randconfig-a005
alpha                            allyesconfig
riscv                randconfig-r042-20220824
arm                                 defconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
loongarch                         allnoconfig
loongarch                           defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220824
i386                          randconfig-a002
hexagon              randconfig-r045-20220824
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
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
