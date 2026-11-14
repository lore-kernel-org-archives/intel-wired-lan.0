Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EB606A329
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Nov 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=q00ImTD2;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ICs3B6mL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F0F0606EA;
	Sat, 14 Nov 2026 07:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g9TygNokylCo; Sat, 14 Nov 2026 07:39:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 505A26066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794641944;
	b=IIsX8cI6sNtSqY0gRSynxNnlBjwRyU+d80IV3M+GSgvwYao+1qXw2uhv7J5cnI/gb03r
	 vPBpQdMQQj0a/ggHLSi+xbaKV/jBwJ6wa/tWhimaS8kgAkK4KqyRXOir6lykTw8jJJ0JD
	 2CmacEPFU4UTeEnWV1w0oeAPECfQf4WcEC7MRfD1Dr9lC2p+MQ/+UWGT0jBuxFcj/wSLM
	 Q9Od+2lviPTOKI/9RKYf+5QPfb+y1/ag4nlkf0ASFh8P7yOj1SoMUuJ+/QChAk1oz4IVW
	 4BdiPG/DdUgesjyB1ww/DO5yNv0Tjjqbla3MTIceA0tBk1Ottt9STWfv9A8UQ5tvcCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794641944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sG8ljjYvIx56RMW1dw/SKs+OmpKHw1xjYfXLnSHxan4=;
	b=JYZRsPaFnDJ6eUEzHdu1zEHF8SobhXDdzMK+/3poAmfYV7ac4FNnz0OVd7Le25iPDGeb
	 9GLeG4CDG3xoR5OP+DR+9xKtMvOIlyURlW8T/KkaUHjXnXfrgJzX5hbJ2QS2oQ8uaG0RU
	 W3qv/S9XTMwKUNz+89sDo3CtogAlFWr9Z/rockHXd8qVZoSg+PBvHmnbJsyaoxOjaBZtk
	 HnnRq6dHNGOYQaV3A51/YhFINg4yNi2w0R+9a3FBOFwIIgOPTa3p1BWSIaUd7RlFCqLy/
	 MJjUHU7FkFrykDv/6GWlODjBz4LaYGUtxAv0y4UhuXC+KCVTg0nuuzjsAdU4jDl+jmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794641944;
	bh=sG8ljjYvIx56RMW1dw/SKs+OmpKHw1xjYfXLnSHxan4=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q00ImTD2SrctK7tXYnmcDykSicUIKsbiB4kHAWLP2HXkyFwkVxo39wSi0wCANssCw
	 9raBLfaXrXttw+mWiyIOJfwCz/DRzMc1XA4xAbnkFU+aPcGYyyczjozBq5LIJ0SeCg
	 pSCF32S94ZPE5fWltWF5IEUmJOjY5WhOFsw/PBGMJpokK+HlhMBfPHrJewYrBiCo3d
	 Uk5b6kWP8yiEl2DR/51vpshnYbmUDaCTIqdEEFFeSYBpFhtuJUHxYLqZfMH0xc866H
	 BtD/+gZNNMMRi1pSqu5QsQ4a6Qp+FmSCzLlWtG48myXJxt52LjkytSQU0ADxTM80DP
	 zqCIiIH8NNfwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 505A26066D;
	Sat, 14 Nov 2026 07:39:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61C7F28C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 07:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 481D740E0A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 07:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lyHuZLo7Pn4y for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 07:39:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55F6840E09
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ICs3B6mL
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55F6840E09
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794641941; x=1826177941; h=date:from:to:subject:message-id;
 bh=ae1e3gILc1Wm/L7T80U/FBuUDdmhQ0J3lN23qKqAiLI=;
 b=ICs3B6mLxPYlFJM9fsqNBF40p6/cOneXW5y2sxOXdlR1rDmG3wYd1xKc
 i1OW1Pzi9VjWvXGldZMutAyFbsKB+mF/F9PsGcc8/UIB8hVCkc9xOAd68
 X4ZPtxFVGE+LGXaa0hKZP8r4XqPzHQZ0PJHzIqvnflCcfrQn4fDRZZyay
 EoMjDj9zjX7srmCQ8d1iH6hg0xrISPxxirSY4iFkdJJ/rL1iyVuZupFRj
 57+wROP4GbZa6Wcd4b09/jlnC6Jf33+HbHtGv4/sCQOzcLLrZrHUak0W0
 MxokQ1hdrzZyjEYeKwufOgeUC3f9JoJE4iIS5kfTLKjMxDaqF2X/fkdY8 Q==;
X-CSE-ConnectionGUID: oC3xwjlCSAusxyyEM/imQw==
X-CSE-MsgGUID: JtR8jt8+RBecoPzuedVu/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3525348"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3525348"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 23:39:00 -0800
X-CSE-ConnectionGUID: D018siqHSCizJstmvqyI/Q==
X-CSE-MsgGUID: F2M5fmlQTeycycWIMoGV8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9362428"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2026 23:38:59 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xS8Lg-0000000157E-3eY6;
 Sat, 14 Nov 2026 07:38:56 +0000
Date: Sat, 14 Nov 2026 15:37:58 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 1fcc5adeeda91622627c5c238985b60421ee9e70
Message-ID: <20261114153758.xQ0CkqYU-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 1fcc5adeeda91622627c5c238985b60421ee9e70  ice: use struct timecounter for E825 and E830

elapsed time: 1481m

configs tested: 384
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.2.0
alpha                    allyesconfig    gcc-16.2.0
alpha                       defconfig    gcc-16.2.0
alpha        randconfig-2000-20261112    gcc-13.5.0
alpha        randconfig-2000-20261113    gcc-8.5.0
alpha        randconfig-2001-20261112    gcc-8.5.0
alpha        randconfig-2001-20261113    gcc-8.5.0
alpha        randconfig-2200-20261112    gcc-15.3.0 smatch
alpha        randconfig-2200-20261113    gcc-8.5.0  smatch
arc                       allnoconfig    gcc-16.2.0
arc                         defconfig    gcc-16.2.0
arc          randconfig-1000-20261114    clang-24
arc          randconfig-1001-20261114    clang-24
arc          randconfig-2000-20261113    gcc-16.2.0
arc          randconfig-2001-20261113    gcc-10.5.0
arc          randconfig-2001-20261113    gcc-16.2.0
arc          randconfig-2002-20261113    gcc-16.2.0
arc          randconfig-2003-20261113    gcc-10.5.0
arc          randconfig-2003-20261113    gcc-16.2.0
arc          randconfig-2004-20261113    gcc-12.5.0
arc          randconfig-2004-20261113    gcc-16.2.0
arc          randconfig-2005-20261113    gcc-10.5.0
arc          randconfig-2005-20261113    gcc-16.2.0
arc          randconfig-2200-20261113    gcc-14.4.0 smatch
arc         randconfig-r2106-20261113    clang-22   cocci
arc         randconfig-r2109-20261113    clang-22   cocci
arc         randconfig-r2110-20261112    gcc-13.5.0 cocci
arm                       allnoconfig    gcc-16.2.0
arm             am200epdkit_defconfig    gcc-16.2.0
arm                         defconfig    gcc-16.2.0
arm          randconfig-1000-20261114    clang-24
arm          randconfig-1001-20261114    clang-24
arm          randconfig-1002-20261114    clang-24
arm          randconfig-1003-20261114    clang-24
arm          randconfig-2000-20261113    gcc-14.4.0
arm          randconfig-2001-20261113    gcc-12.5.0
arm          randconfig-2001-20261113    gcc-14.4.0
arm          randconfig-2002-20261113    gcc-14.4.0
arm          randconfig-2002-20261113    gcc-8.5.0
arm          randconfig-2200-20261113    clang-24   smatch
arm         randconfig-r2111-20261113    clang-22   cocci
arm         randconfig-r2304-20261113    clang-24   sparse
arm                   sama7_defconfig    gcc-16.2.0
arm                   stm32_defconfig    gcc-16.2.0
arm64                     allnoconfig    gcc-16.2.0
arm64                       defconfig    gcc-16.2.0
arm64        randconfig-2000-20261113    clang-24
arm64        randconfig-2000-20261113    gcc-14.4.0
arm64        randconfig-2001-20261113    gcc-14.4.0
arm64        randconfig-2001-20261113    gcc-8.5.0
arm64        randconfig-2002-20261113    gcc-14.4.0
arm64        randconfig-2002-20261113    gcc-15.3.0
arm64        randconfig-2200-20261113    gcc-8.5.0  smatch
arm64       randconfig-r2301-20261113    clang-24   sparse
arm64       randconfig-r2305-20261113    clang-24   sparse
arm64       randconfig-r2310-20261112    clang-21   sparse
csky                      allnoconfig    gcc-16.2.0
csky                        defconfig    gcc-16.2.0
csky         randconfig-2000-20261113    gcc-12.5.0
csky         randconfig-2001-20261113    gcc-12.5.0
csky         randconfig-2001-20261113    gcc-14.4.0
csky         randconfig-2200-20261112    gcc-11.5.0 smatch
csky         randconfig-2200-20261113    gcc-10.5.0 smatch
csky        randconfig-r2302-20261112    gcc-14.4.0 sparse
csky        randconfig-r2305-20261112    gcc-16.2.0 sparse
hexagon                  allmodconfig    gcc-16.2.0
hexagon                   allnoconfig    gcc-16.2.0
hexagon                     defconfig    gcc-16.2.0
hexagon      randconfig-1000-20261114    clang-24
hexagon      randconfig-1001-20261114    clang-24
hexagon      randconfig-2000-20261113    clang-24
hexagon      randconfig-2000-20261113    gcc-12.5.0
hexagon      randconfig-2001-20261113    clang-17
hexagon      randconfig-2001-20261113    gcc-12.5.0
hexagon      randconfig-2200-20261112    clang-22   smatch
hexagon      randconfig-2200-20261113    clang-17   smatch
hexagon     randconfig-r2301-20261112    clang-24   sparse
i386                     allmodconfig    clang-22
i386                      allnoconfig    gcc-16.2.0
i386                     allyesconfig    clang-22
i386                        defconfig    gcc-16.2.0
i386         randconfig-1007-20261114    clang-22
i386         randconfig-1008-20261114    clang-22
i386         randconfig-1009-20261114    clang-22
i386         randconfig-1010-20261114    clang-22
i386         randconfig-1011-20261114    clang-22
i386         randconfig-1012-20261114    clang-22
i386         randconfig-1013-20261114    clang-22
i386         randconfig-2000-20261113    gcc-12
i386         randconfig-2000-20261113    gcc-14
i386         randconfig-2001-20261113    gcc-12
i386         randconfig-2002-20261113    gcc-12
i386         randconfig-2002-20261113    gcc-14
i386         randconfig-2003-20261113    gcc-12
i386         randconfig-2003-20261113    gcc-14
i386         randconfig-2004-20261113    clang-22
i386         randconfig-2004-20261113    gcc-12
i386         randconfig-2005-20261113    gcc-12
i386         randconfig-2005-20261113    gcc-14
i386         randconfig-2100-20261112    gcc-14     cocci
i386         randconfig-2100-20261113    gcc-14     cocci
i386         randconfig-2101-20261112    gcc-14     cocci
i386         randconfig-2101-20261113    gcc-14     cocci
i386         randconfig-2102-20261112    clang-22   cocci
i386         randconfig-2102-20261113    gcc-14     cocci
i386         randconfig-2103-20261112    gcc-14     cocci
i386         randconfig-2103-20261113    gcc-14     cocci
i386         randconfig-2104-20261112    clang-22   cocci
i386         randconfig-2104-20261113    gcc-14     cocci
i386         randconfig-2105-20261112    clang-22   cocci
i386         randconfig-2105-20261113    gcc-14     cocci
i386         randconfig-2200-20261112    gcc-14     smatch
i386         randconfig-2200-20261113    clang-22   smatch
i386         randconfig-2300-20261113    gcc-14     sparse
i386         randconfig-2301-20261113    gcc-14     sparse
i386         randconfig-2302-20261113    gcc-14     sparse
i386        randconfig-r2107-20261113    clang-22   cocci
i386        randconfig-r2309-20261113    gcc-9.5.0  sparse
loongarch                 allnoconfig    gcc-16.2.0
loongarch                   defconfig    clang-24
loongarch    randconfig-1000-20261114    clang-24
loongarch    randconfig-1001-20261114    clang-24
loongarch    randconfig-2000-20261112    gcc-16.2.0
loongarch    randconfig-2000-20261113    gcc-8.5.0
loongarch    randconfig-2001-20261112    clang-20
loongarch    randconfig-2001-20261113    gcc-8.5.0
loongarch    randconfig-2200-20261112    clang-24   smatch
loongarch    randconfig-2200-20261113    gcc-16.2.0 smatch
loongarch   randconfig-r2100-20261113    gcc-14     cocci
m68k                      allnoconfig    gcc-16.2.0
m68k                 amcore_defconfig    gcc-16.2.0
m68k                        defconfig    clang-24
m68k               m5475evb_defconfig    gcc-16.2.0
m68k         randconfig-2000-20261112    gcc-16.2.0
m68k         randconfig-2000-20261113    gcc-8.5.0
m68k         randconfig-2001-20261112    gcc-10.5.0
m68k         randconfig-2001-20261113    gcc-8.5.0
m68k         randconfig-2200-20261112    gcc-14.4.0 smatch
m68k         randconfig-2200-20261113    gcc-15.3.0 smatch
m68k        randconfig-r2102-20261113    gcc-8.5.0  cocci
m68k        randconfig-r2309-20261112    gcc-13.5.0 sparse
microblaze                allnoconfig    gcc-16.2.0
microblaze                  defconfig    clang-24
microblaze   randconfig-2000-20261112    gcc-9.5.0
microblaze   randconfig-2000-20261113    gcc-8.5.0
microblaze   randconfig-2001-20261112    gcc-8.5.0
microblaze   randconfig-2001-20261113    gcc-8.5.0
microblaze   randconfig-2200-20261113    gcc-8.5.0  smatch
microblaze  randconfig-r2108-20261113    clang-22   cocci
microblaze  randconfig-r2109-20261112    gcc-15.3.0 cocci
microblaze  randconfig-r2110-20261113    clang-22   cocci
microblaze  randconfig-r2311-20261113    gcc-9.5.0  sparse
mips                     allmodconfig    gcc-16.2.0
mips                      allnoconfig    gcc-16.2.0
mips                  ath79_defconfig    gcc-16.2.0
mips         randconfig-2000-20261113    clang-18
mips         randconfig-2000-20261113    gcc-16.2.0
mips         randconfig-2001-20261113    clang-22
mips         randconfig-2001-20261113    gcc-16.2.0
mips         randconfig-2002-20261113    gcc-14.4.0
mips         randconfig-2002-20261113    gcc-16.2.0
mips         randconfig-2200-20261112    gcc-13.5.0 smatch
mips         randconfig-2200-20261113    clang-24   smatch
mips        randconfig-r2103-20261113    gcc-14     cocci
mips        randconfig-r2107-20261112    gcc-12.5.0 cocci
mips        randconfig-r2302-20261113    clang-24   sparse
mips        randconfig-r2308-20261113    gcc-9.5.0  sparse
mips        randconfig-r2310-20261113    gcc-9.5.0  sparse
nios2                    allmodconfig    clang-20
nios2                     allnoconfig    clang-24
nios2                       defconfig    clang-24
nios2        randconfig-1000-20261114    clang-24
nios2        randconfig-1001-20261114    clang-24
nios2        randconfig-2000-20261112    gcc-9.5.0
nios2        randconfig-2000-20261113    gcc-8.5.0
nios2        randconfig-2001-20261112    gcc-11.5.0
nios2        randconfig-2001-20261113    gcc-8.5.0
nios2        randconfig-2200-20261112    gcc-11.5.0 smatch
nios2        randconfig-2200-20261113    gcc-10.5.0 smatch
nios2       randconfig-r2307-20261112    gcc-11.5.0 sparse
openrisc                 alldefconfig    gcc-16.2.0
openrisc                 allmodconfig    clang-20
openrisc                  allnoconfig    clang-24
openrisc                    defconfig    gcc-16.2.0
openrisc          or1klitex_defconfig    gcc-16.2.0
openrisc     randconfig-2000-20261113    gcc-16.2.0
openrisc     randconfig-2001-20261113    gcc-14.4.0
openrisc     randconfig-2001-20261113    gcc-16.2.0
openrisc     randconfig-2002-20261113    gcc-16.2.0
openrisc     randconfig-2200-20261112    gcc-16.2.0 smatch
openrisc     randconfig-2200-20261113    gcc-14.4.0 smatch
openrisc    randconfig-r2104-20261113    gcc-15.3.0 cocci
openrisc    randconfig-r2105-20261113    gcc-14     cocci
openrisc    randconfig-r2304-20261112    gcc-12.5.0 sparse
openrisc    randconfig-r2311-20261112    gcc-13.5.0 sparse
parisc                   allmodconfig    gcc-16.2.0
parisc                    allnoconfig    clang-24
parisc                   allyesconfig    clang-17
parisc                      defconfig    gcc-16.2.0
parisc       randconfig-2000-20261112    gcc-11.5.0
parisc       randconfig-2000-20261113    gcc-8.5.0
parisc       randconfig-2001-20261112    gcc-9.5.0
parisc       randconfig-2001-20261113    gcc-8.5.0
parisc       randconfig-2200-20261112    gcc-8.5.0  smatch
parisc       randconfig-2200-20261113    gcc-16.2.0 smatch
parisc      randconfig-r2103-20261113    gcc-11.5.0 cocci
parisc      randconfig-r2111-20261112    gcc-13.5.0 cocci
parisc      randconfig-r2307-20261113    gcc-9.5.0  sparse
parisc64                    defconfig    clang-24
powerpc                  allmodconfig    gcc-16.2.0
powerpc                   allnoconfig    clang-24
powerpc      randconfig-2000-20261113    clang-17
powerpc      randconfig-2000-20261113    clang-24
powerpc      randconfig-2001-20261113    clang-24
powerpc      randconfig-2001-20261113    gcc-15.3.0
powerpc      randconfig-2002-20261113    clang-18
powerpc      randconfig-2002-20261113    clang-24
powerpc      randconfig-2200-20261112    clang-24   smatch
powerpc      randconfig-2200-20261113    clang-24   smatch
powerpc     randconfig-r2101-20261113    gcc-14     cocci
powerpc     randconfig-r2102-20261113    gcc-14     cocci
powerpc64    randconfig-2000-20261113    clang-24
powerpc64    randconfig-2000-20261113    gcc-8.5.0
powerpc64    randconfig-2001-20261113    clang-24
powerpc64    randconfig-2002-20261113    clang-24
powerpc64    randconfig-2002-20261113    gcc-15.3.0
powerpc64    randconfig-2200-20261112    gcc-16.2.0 smatch
powerpc64    randconfig-2200-20261113    gcc-10.5.0 smatch
powerpc64   randconfig-r2100-20261113    gcc-13.5.0 cocci
powerpc64   randconfig-r2303-20261113    clang-24   sparse
powerpc64   randconfig-r2308-20261112    clang-24   sparse
riscv                     allnoconfig    clang-24
riscv                       defconfig    gcc-16.2.0
riscv        randconfig-2000-20261112    gcc-8.5.0
riscv        randconfig-2000-20261113    gcc-11.5.0
riscv        randconfig-2001-20261112    clang-17
riscv        randconfig-2001-20261113    gcc-11.5.0
riscv        randconfig-2002-20261112    clang-24
riscv        randconfig-2002-20261113    gcc-11.5.0
riscv        randconfig-2003-20261112    clang-19
riscv        randconfig-2003-20261113    gcc-11.5.0
riscv        randconfig-2004-20261112    clang-20
riscv        randconfig-2004-20261113    gcc-11.5.0
riscv        randconfig-2005-20261112    gcc-10.5.0
riscv        randconfig-2005-20261113    gcc-11.5.0
riscv        randconfig-2200-20261112    clang-24   smatch
riscv        randconfig-2200-20261113    clang-17   smatch
riscv       randconfig-r2105-20261113    gcc-8.5.0  cocci
riscv       randconfig-r2108-20261112    clang-24   cocci
riscv       randconfig-r2306-20261113    gcc-9.5.0  sparse
s390                     allmodconfig    clang-17
s390                      allnoconfig    clang-24
s390                     allyesconfig    gcc-16.2.0
s390                        defconfig    gcc-16.2.0
s390         randconfig-2000-20261113    gcc-11.5.0
s390         randconfig-2000-20261113    gcc-13.5.0
s390         randconfig-2001-20261113    clang-18
s390         randconfig-2001-20261113    gcc-11.5.0
s390         randconfig-2002-20261113    gcc-11.5.0
s390         randconfig-2002-20261113    gcc-13.5.0
s390         randconfig-2003-20261113    gcc-11.5.0
s390         randconfig-2003-20261113    gcc-8.5.0
s390         randconfig-2004-20261113    clang-24
s390         randconfig-2004-20261113    gcc-11.5.0
s390         randconfig-2005-20261113    gcc-11.5.0
s390         randconfig-2200-20261112    clang-24   smatch
s390         randconfig-2200-20261113    clang-24   smatch
s390        randconfig-r2300-20261112    gcc-8.5.0  sparse
sh                       allmodconfig    gcc-16.2.0
sh                        allnoconfig    clang-24
sh                       allyesconfig    clang-17
sh           randconfig-2000-20261112    gcc-9.5.0
sh           randconfig-2000-20261113    gcc-14.4.0
sh           randconfig-2001-20261112    gcc-15.3.0
sh           randconfig-2001-20261113    gcc-14.4.0
sh           randconfig-2002-20261112    gcc-9.5.0
sh           randconfig-2002-20261113    gcc-14.4.0
sh           randconfig-2003-20261112    gcc-16.2.0
sh           randconfig-2003-20261113    gcc-14.4.0
sh           randconfig-2004-20261112    gcc-16.2.0
sh           randconfig-2004-20261113    gcc-14.4.0
sh           randconfig-2005-20261112    gcc-16.2.0
sh           randconfig-2005-20261113    gcc-14.4.0
sh           randconfig-2200-20261112    gcc-16.2.0 smatch
sh           randconfig-2200-20261113    gcc-14.4.0 smatch
sparc                     allnoconfig    clang-24
sparc                       defconfig    gcc-16.2.0
sparc        randconfig-2000-20261112    gcc-8.5.0
sparc        randconfig-2000-20261113    clang-24
sparc        randconfig-2001-20261112    gcc-11.5.0
sparc        randconfig-2001-20261113    clang-24
sparc        randconfig-2200-20261112    gcc-11.5.0 smatch
sparc        randconfig-2200-20261113    gcc-14.4.0 smatch
sparc       randconfig-r2101-20261113    gcc-16.2.0 cocci
sparc       randconfig-r2300-20261113    clang-24   sparse
sparc       randconfig-r2303-20261112    gcc-13.5.0 sparse
sparc64                  allmodconfig    clang-20
sparc64      randconfig-2000-20261112    clang-24
sparc64      randconfig-2000-20261113    clang-24
sparc64      randconfig-2001-20261112    gcc-8.5.0
sparc64      randconfig-2001-20261113    clang-24
sparc64      randconfig-2200-20261113    gcc-15.3.0 smatch
um                       allmodconfig    clang-17
um                        allnoconfig    clang-24
um                       allyesconfig    gcc-16.2.0
um           randconfig-2000-20261112    clang-24
um           randconfig-2000-20261113    clang-24
um           randconfig-2001-20261112    clang-24
um           randconfig-2001-20261113    clang-24
um           randconfig-2200-20261112    clang-20   smatch
um           randconfig-2200-20261113    clang-24   smatch
um          randconfig-r2104-20261113    gcc-14     cocci
x86_64                   allmodconfig    clang-22
x86_64                    allnoconfig    clang-24
x86_64                   allyesconfig    clang-22
x86_64                          kexec    clang-22
x86_64       randconfig-1000-20261114    gcc-14
x86_64       randconfig-1001-20261114    gcc-14
x86_64       randconfig-1002-20261114    gcc-14
x86_64       randconfig-1003-20261114    gcc-14
x86_64       randconfig-1004-20261114    gcc-14
x86_64       randconfig-1005-20261114    gcc-14
x86_64       randconfig-1006-20261114    gcc-14
x86_64       randconfig-1007-20261114    gcc-14
x86_64       randconfig-1008-20261114    gcc-14
x86_64       randconfig-1009-20261114    gcc-14
x86_64       randconfig-1010-20261114    gcc-14
x86_64       randconfig-1011-20261114    gcc-14
x86_64       randconfig-1012-20261114    clang-22
x86_64       randconfig-1013-20261114    clang-22
x86_64       randconfig-1014-20261114    clang-22
x86_64       randconfig-1015-20261114    clang-22
x86_64       randconfig-1016-20261114    clang-22
x86_64       randconfig-1017-20261114    clang-22
x86_64       randconfig-2000-20261112    gcc-14
x86_64       randconfig-2000-20261113    gcc-14
x86_64       randconfig-2001-20261112    gcc-14
x86_64       randconfig-2001-20261113    gcc-14
x86_64       randconfig-2002-20261112    clang-22
x86_64       randconfig-2002-20261113    gcc-14
x86_64       randconfig-2003-20261112    clang-22
x86_64       randconfig-2003-20261113    gcc-14
x86_64       randconfig-2004-20261112    clang-22
x86_64       randconfig-2004-20261113    gcc-14
x86_64       randconfig-2005-20261112    clang-22
x86_64       randconfig-2005-20261113    gcc-14
x86_64       randconfig-2100-20261112    clang-22   cocci
x86_64       randconfig-2100-20261113    clang-22   cocci
x86_64       randconfig-2101-20261112    gcc-14     cocci
x86_64       randconfig-2101-20261113    clang-22   cocci
x86_64       randconfig-2102-20261112    gcc-14     cocci
x86_64       randconfig-2102-20261113    clang-22   cocci
x86_64       randconfig-2103-20261112    gcc-12     cocci
x86_64       randconfig-2103-20261113    clang-22   cocci
x86_64       randconfig-2104-20261112    clang-22   cocci
x86_64       randconfig-2104-20261113    clang-22   cocci
x86_64       randconfig-2105-20261112    clang-22   cocci
x86_64       randconfig-2105-20261113    clang-22   cocci
x86_64       randconfig-2200-20261112    gcc-13     smatch
x86_64       randconfig-2200-20261113    clang-22   smatch
x86_64       randconfig-2300-20261113    gcc-14     sparse
x86_64       randconfig-2301-20261113    clang-22   sparse
x86_64       randconfig-2301-20261113    gcc-14     sparse
x86_64       randconfig-2302-20261113    gcc-14     sparse
x86_64      randconfig-r2306-20261112    clang-22   sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                   rhel-9.4-bpf    gcc-14
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                 rhel-9.4-kunit    gcc-14
x86_64                   rhel-9.4-ltp    clang-22
x86_64                   rhel-9.4-ltp    gcc-14
x86_64                  rhel-9.4-rust    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    clang-24
xtensa                   allyesconfig    clang-20
xtensa       randconfig-2000-20261113    gcc-12.5.0
xtensa       randconfig-2000-20261113    gcc-14.4.0
xtensa       randconfig-2001-20261113    gcc-12.5.0
xtensa       randconfig-2001-20261113    gcc-8.5.0
xtensa       randconfig-2200-20261113    gcc-12.5.0 smatch
xtensa      randconfig-r2106-20261112    gcc-14.4.0 cocci

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
