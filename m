Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA63C04A68
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Jul 2022 07:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67FA6401C5;
	Wed, 27 Jul 2022 07:47:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67FA6401C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1658908025;
	bh=iH0ePaXF5rnodVHmEI6wHicbUdw2HDVuBcxW/LCdFI0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eXX1ZwVY+f3Vnw4TFuvnwe/UDJusGgnTgIqNhCu6CD9rJrO7a+XnmxlWR09D0ut0z
	 O3FTLzSUcQRWPSzpbNPy5uo6FdzpRzIYqpenTetISHCqA+nO6fQXm4sZHnuG/0ic4Q
	 Mg2OL74LOuTLsdIfIkFH90unQerXRTiXCHxgvxfYYwtZRZt9p4Q+iVxM1bSqNmomMD
	 OhjzMZ0qKkyvezsdNb+gQuYQpQ+o6ySlAeQ2a2HBXDNvY+SGY++Ium8Be+e6NIO7K8
	 T/r4JhFS12+IzB+QpWyOzzWaH1wS/ZdcBGZjRoUtDURP5mvH4bokRJE9shzAe8CDhf
	 v5LDQ2o2gpTww==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4rT2P8FxkJav; Wed, 27 Jul 2022 07:47:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AD9C40412;
	Wed, 27 Jul 2022 07:47:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AD9C40412
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 9D2A31BF3A0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Jul 2022 07:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 843BC60ACC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Jul 2022 07:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 843BC60ACC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JabdZZuWVC-s for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Jul 2022 07:47:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D97426080B
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D97426080B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Jul 2022 07:47:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="271210187"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; d="scan'208";a="271210187"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2022 00:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; d="scan'208";a="628278495"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2022 00:46:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oGbkw-0008Ui-2D;
 Wed, 27 Jul 2022 07:46:58 +0000
Date: Wed, 27 Jul 2022 15:46:55 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <62e0ed6f.O3OFjvAMijfBIeW3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658908020; x=1690444020;
 h=date:from:to:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=/OUSGGxR9RUizTOBHaA7YIi7NlTwE8VV+3QJjsTZrXs=;
 b=YlXBdUjfg4Cb9hHf2BpC1DiMix5++vsu9XGaDnSYOYwJkFFIKdTzEo/C
 L83e107sReSmnoC0eNqSJDFc/hzScVM/kdoPgyJjiiwIuTVxi3TYQKjLs
 9M+MFYRaRIeHnjZ/slwuCvFTQjowFwX44VtrKP3+VovAXf8kjDkdbaHIW
 ee2/1ucdas9ZlSX+neMiOwqiNP0unYiYiqhY1Kckd0MUdo9b/3JHUqXDE
 uXThtVT3xIY5Hep4A/Tsr+roqh3bGL2gEFFpB9GyA5aTuUcREBbOCo9xl
 8jgc8p58zF+FOyh5mthBMotLj4Uc7KQg7uycR/h/Cyv8bZ6583hrBbHVO
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YlXBdUjf
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 cd8efeeed16e8ecf30071583865f3f468db9e854
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
branch HEAD: cd8efeeed16e8ecf30071583865f3f468db9e854  ice: Add support for PPPoE hardware offload

elapsed time: 730m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220724
riscv                randconfig-r042-20220724
s390                 randconfig-r044-20220724
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
