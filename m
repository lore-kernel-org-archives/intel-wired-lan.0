Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7493DC4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Nov 2022 19:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED67760F60;
	Thu, 10 Nov 2022 19:19:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED67760F60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668107952;
	bh=6IuAo2d6iGjgosjLE1Ky/fDLewOwjmGxk8aZUthM9hQ=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VN66BSbMBJjNURW3v1i4eN0doh5Fa9j6tqkRrZcj6I9rxwcTBNFy1XvXBEJZxCBdj
	 Jftpthj+iKcy1Z2KdEuedkl6Rc3O+IMBlJcjHMuQWO7D6ZVLxgVQnMytQ5caTPrBfK
	 0f5rl6dJk43grTGPUl29RTc7kWqAPUaA/wlv2leYH3zLHP+AuUsw/+GBwrjxNJc7xA
	 7ZsK1dtGW+ho52xrHnpJxJOn3MyorzG+1pn29PKCG51X3eOwV6bx0pZS82kwKbpUWM
	 1FzK5Ej2HUiy42x6vhFscVFWfHL1YCP7jdv6MSEDGFMXVOmBDeJ1oS9rST5XJoCVgz
	 hFd1RbXpihNIw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qewonx0PY5L; Thu, 10 Nov 2022 19:19:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5F8A605B3;
	Thu, 10 Nov 2022 19:19:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5F8A605B3
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 19E6D1BF392
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Nov 2022 19:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2AA440B8C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Nov 2022 19:19:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2AA440B8C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0LHRKWj3Pad for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Nov 2022 19:19:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F5F040B8A
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F5F040B8A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Nov 2022 19:19:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291139521"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; d="scan'208";a="291139521"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 11:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668534674"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; d="scan'208";a="668534674"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 10 Nov 2022 11:13:36 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1otCzX-00038V-1l;
 Thu, 10 Nov 2022 19:13:35 +0000
Date: Fri, 11 Nov 2022 03:13:29 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <636d4d59.cweQZ6b6JTB2v3Yk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668107948; x=1699643948;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=OQXBQJA2oefiZBYXASbM4IhQQlwiHhXrtb5jYHAJV5g=;
 b=UTm0iINNatXOlwC6gDnuqgT4pFlZfk4TDpIbzb39TiEvGENdKy1IRMX9
 BrNQMjG64g7qMMWfAXgKuiHPpq5ouznetyjf/OG2pVQnRUqyPnoBoLIMc
 uQItvZkXztpORYNyv99vn6p5WyVaw2UeUsVKg3TWw6HAgwd2MXBgoXQJl
 XwbUdrgmSkHBHRtuuun754Wy6utykYxZLtjwp0QqRylAmpapZD5FhO+aC
 eNmYnqvWNGNXjYyQrwmZVLl/BRVTsH8ULeZaaIDtCwuLpiMSv660dEpVT
 qhbfKGl0nEkv/St10rvOSsk2+5FQZrL6KFCIhc1R1FZKOEC0vG3W14rBK
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UTm0iINN
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 0e710a3ffd0caaf23b8791b041e8792f252f8e4f
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 0e710a3ffd0caaf23b8791b041e8792f252f8e4f  iavf: Fix VF driver counting VLAN 0 filters

elapsed time: 1111m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
um                             i386_defconfig
um                           x86_64_defconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
s390                             allmodconfig
x86_64                            allnoconfig
x86_64                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
powerpc              randconfig-c003-20221110
ia64                             allmodconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                      rts7751r2d1_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
