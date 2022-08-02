Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF898C00140
	for <intel-wired-lan@archiver.kernel.org>; Tue,  2 Aug 2022 09:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35C7160087;
	Tue,  2 Aug 2022 09:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35C7160087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659431309;
	bh=EjdgDVdpVIl8w4/+qokj4eQSGCL/S7NDV4TmbxCD8B8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jkKBlDenXA7XfSZfQYppXG0EpAVFj6o9at5HUBcTcVUdXrv+S4EXuyFO2adD4+2Dz
	 3aM1XYDA0K+r8QpIV/ZplMwnv8XPM9OIPTFMyyF1BBb5ec6ltyrkeBUpO2PiZUEgPU
	 OQL/tGVLPloBcDYgkL0vCvYFUcMj3g0ny7vmBiSOzEwUjw0c8Vpd2nbcCnv83BS66W
	 Wz5wOHc9bVkyQGPkgABYaemUdmKpLMvUuduJjXqBb/fZmBo/ZWtS3G/gRCDZ1yylSa
	 dbrICXRgaxSCwHFuybZd45KavkdyjuS3Hdco3DosIMleptU/U2b9Ra3Uh/hA92TKc2
	 E2gzmOQx34R+g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swYwemQHQhdz; Tue,  2 Aug 2022 09:08:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 146FA600CB;
	Tue,  2 Aug 2022 09:08:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 146FA600CB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 229071BF57B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 09:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0DB2404BD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 09:08:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0DB2404BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9oAWNlREnxx for <intel-wired-lan@lists.osuosl.org>;
 Tue,  2 Aug 2022 09:08:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0B5D40139
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0B5D40139
 for <intel-wired-lan@lists.osuosl.org>; Tue,  2 Aug 2022 09:08:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289375807"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="289375807"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2022 02:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; d="scan'208";a="630629596"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 02 Aug 2022 02:08:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oInsp-000FtT-2K;
 Tue, 02 Aug 2022 09:08:11 +0000
Date: Tue, 02 Aug 2022 17:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62e8e940.oCZbsOiYexjVkcWP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1659431302; x=1690967302;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=khGd3JgzQg8490ubWW2a4Yu5pIaFey+AQARrvviPZgg=;
 b=N8JKUemvf3PtBDPNySxI0TMJp4hMsh5oAo0gdQrY4K3mT6ONDfNDINrC
 +huvY6HyRz7+KYCak7rnrNUd4j+Mo6KIwc/jkN/s+wzZR731Ao51ZTmtT
 pTNIVL4bF0dHt4vjwEmN1sfHWOMXpAdxYdpvAMPpD27IzN/Ubzh5kYVs9
 QVwbVLdolJ0dr6LKQKcUs5HG/VRkxk/8xp2FwOdMiYz7I1LxqHDamUdEz
 bFD8ZEnJ6DjBhl+g7xuG/E7X0ev968rXINQF4vyEtih2TCCnPUZ+4uYPJ
 ku9+Etro8HHV7Gp7WyyclLr+qyj6ZBb6Ayol6FV/hKXKoyCw6rOiRhyWd
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N8JKUemv
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 80ef928643c1558a0474389fcd680a5ccd6c86e6
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
branch HEAD: 80ef928643c1558a0474389fcd680a5ccd6c86e6  net: devlink: Fix missing mutex_unlock() call

elapsed time: 741m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
riscv                randconfig-r042-20220801
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a016-20220801
arm                                 defconfig
i386                             allyesconfig
i386                                defconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64               randconfig-a016-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                 randconfig-a013-20220801
i386                 randconfig-a012-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a014-20220801
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                           se7722_defconfig
nios2                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a004-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
