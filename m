Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7429606A320
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=uUq5lheJ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iIJNQJqA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B101813C9;
	Sat, 21 Nov 2026 11:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x8TYHYxfOU1D; Sat, 21 Nov 2026 11:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 847CA813CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795261861;
	b=obC15JxUwyajeSn1tL20766E+foYLYRuAlgu6oPS64TljWDTRLktbyibQsHkPY7rpEYp
	 +El+LWzZ9lcRCSLmLWlMqj9xRNNqmI3XOnhBmsT/YnYVg4OjxbGyRsmqC0oiSTHdwjoOD
	 CuUD2t5chk3zwCzgBst1TrOpJmGrWSWh9LKhjPJdYmbryV6zf7Vo7s/k4DntCV+HqZp4/
	 UOizbHyAigc2m2mllAMJelZwmnejBmzaiekQXnFZ9mtLQCY/sNaHzjafOEH9ohB375zYs
	 R9k2wQYD0hf2OqXfvp+49Kqk/Rr7KxEvzpVBEhHvPRvOakbKF+8ciOO/4NgfuCuIkbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795261861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fEP5nBd6SVXPenWOFXPYDNpwgx+AdTi2GEf2davx59A=;
	b=hejlnpb67teSO/lP9EIKr6yU3VyH6rnAPcyFwDG6xRj+SiPiO1BZgdeTEJ6pVuAbq+/4
	 v8wNn1B7hoE+awc6dmNA48Cqi6ZR75zcdsq/zUOczxl/OVKKQYF+Jfo99vBHlFfJ8yOEA
	 7Sz8Yr2U+Znq2jrY504Olft33vhoyGYC/POvPsggRxIuCTUtuIkOXNAO6mJJvHaASs/jE
	 DBiSB3h6AjKuaeUTOKXzxLhNTptCVSRXk/9xkPbURtWqkyn8a7zqTmvQjSlmWp7rDvuZy
	 Q9L/A1OSthDLD2fuPZjm/L9fLal0r1ZuSXCL+kr9JlKeyO6QfOtNo6HMtgmnaUOYIuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795261861;
	bh=fEP5nBd6SVXPenWOFXPYDNpwgx+AdTi2GEf2davx59A=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uUq5lheJ/vGO5nt9LuRZGSumdGIx0NLpHDiWKIz2PMXBH3S8k7b39FZeq1ehyo84F
	 EvQPl6d8hS/m/qqPaXuUQhm8JXtdpW/2Y1pWx66ojwpe3tZoiH8eiSPqd4kLzZu0FZ
	 8CJb6BukrFBzabyTrm05WsaFcwVxowq8EAJmqc+Os0Z+IBPJxmbkeUCwfUgOcwMSEJ
	 rexTUfTfnemGoX0yKW8DFSqohlCdeOJUbbIW5iKpFxsP8RWEEWuLDfQBUqviBTvWTT
	 PVf4RjTd3mPNd37Jb93lLdxjBFTpTgOYaFj2YQM0UufnwMReWSvuwoNJSIm3tIjCzI
	 zTVkBt4x4DJZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 847CA813CF;
	Sat, 21 Nov 2026 11:51:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF03D1AB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 11:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0659407CD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 11:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D8Gp1Q9_5pWQ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 11:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DBE140764
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iIJNQJqA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DBE140764
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795261859; x=1826797859; h=date:from:to:subject:message-id;
 bh=OiIQeFIhqHsoQBq3CbtvMg5Dy5k+Y4b32L9qsWiJR9E=;
 b=iIJNQJqAsj66LY9PjT/i8R2ymzxxnMGq5I3cp0L89wEYMPV3icUkbYqG
 zIQPHJ92MHep7y0kcB7IYmVZAaq3tAYEkASKwj7ERfhfsGZFPUv40oTAT
 DdmFtlpCmgqOa9/o6p8+ejw9oos/fC/lSvWmPCZcWNUaVvak1Nx5x99O8
 a8cHRF8yscwOb+McnbRI7KsBuRQdaAcU/vCqdAvnaXW1x1dt12PpZoYFz
 v4pgpE2DJ06RxzUsbcPF/Vz8p9lY3RItz16nmiXV07dyJHUbqJ+bKCNYv
 VUl0rWK50tCIcjePvwZ0abMWhfPvGwQ6l/rU1MTFDzwrPXyMBpZJ0ABw8 Q==;
X-CSE-ConnectionGUID: CF7WzwkGQeGZxrDeWRStrg==
X-CSE-MsgGUID: 9fw2+ESFSz6k499I2Ja9Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4043292"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4043292"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2026 03:50:58 -0800
X-CSE-ConnectionGUID: svfab3aoTCCTT1+DQf6fRA==
X-CSE-MsgGUID: 0dXpDwGVTRS564FKk9D+lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="11229684"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2026 03:50:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xUjcM-00000001JyW-1o2D;
 Sat, 21 Nov 2026 11:50:54 +0000
Date: Sat, 21 Nov 2026 19:50:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 bf9edda440e747a4a9b351656a395f0b77cc1fef
Message-ID: <20261121195044.xDwLvtwf-lkp@intel.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: bf9edda440e747a4a9b351656a395f0b77cc1fef  igc: Disable PTM after the last device reset on remove

elapsed time: 1839m

configs tested: 257
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.2.0
alpha                       defconfig    gcc-16.2.0
alpha        randconfig-2000-20261120    gcc-13.5.0
alpha        randconfig-2000-20261120    gcc-15.3.0
alpha        randconfig-2001-20261120    gcc-15.3.0
alpha        randconfig-2200-20261120    gcc-15.3.0 smatch
alpha       randconfig-r2105-20261120    gcc-13.5.0 cocci
alpha       randconfig-r2306-20261120    gcc-11.5.0 sparse
alpha       randconfig-r2308-20261120    gcc-10.5.0 sparse
alpha       randconfig-r2310-20261120    gcc-12.5.0 sparse
arc                       allnoconfig    gcc-16.2.0
arc                         defconfig    gcc-16.2.0
arc          randconfig-2000-20261120    gcc-11.5.0
arc          randconfig-2000-20261120    gcc-9.5.0
arc          randconfig-2001-20261120    gcc-11.5.0
arc          randconfig-2002-20261120    gcc-11.5.0
arc          randconfig-2002-20261120    gcc-8.5.0
arc          randconfig-2003-20261120    gcc-11.5.0
arc          randconfig-2003-20261120    gcc-8.5.0
arc          randconfig-2004-20261120    gcc-11.5.0
arc          randconfig-2004-20261120    gcc-9.5.0
arc          randconfig-2005-20261120    gcc-11.5.0
arc          randconfig-2200-20261120    gcc-15.3.0 smatch
arc         randconfig-r2104-20261120    gcc-13.5.0 cocci
arc         randconfig-r2304-20261120    clang-24   sparse
arc         randconfig-r2306-20261120    gcc-10.5.0 sparse
arm                       allnoconfig    gcc-16.2.0
arm                         defconfig    gcc-16.2.0
arm                keystone_defconfig    gcc-16.2.0
arm          randconfig-2000-20261120    gcc-11.5.0
arm          randconfig-2000-20261120    gcc-8.5.0
arm          randconfig-2001-20261120    gcc-8.5.0
arm          randconfig-2002-20261120    clang-24
arm          randconfig-2002-20261120    gcc-8.5.0
arm          randconfig-2200-20261120    clang-17   smatch
arm         randconfig-r2104-20261120    clang-17   cocci
arm         randconfig-r2310-20261120    gcc-10.5.0 sparse
arm64                     allnoconfig    gcc-16.2.0
arm64                       defconfig    gcc-16.2.0
arm64        randconfig-2000-20261120    clang-24
arm64        randconfig-2000-20261120    gcc-8.5.0
arm64        randconfig-2001-20261120    gcc-8.5.0
arm64        randconfig-2002-20261120    gcc-14.4.0
arm64        randconfig-2002-20261120    gcc-8.5.0
arm64        randconfig-2200-20261120    clang-17   smatch
arm64       randconfig-r2107-20261120    gcc-13.5.0 cocci
arm64       randconfig-r2300-20261120    clang-24   sparse
csky                      allnoconfig    gcc-16.2.0
csky                        defconfig    gcc-16.2.0
csky         randconfig-2000-20261120    gcc-13.5.0
csky         randconfig-2001-20261120    gcc-16.2.0
csky         randconfig-2200-20261120    gcc-15.3.0 smatch
hexagon                   allnoconfig    gcc-16.2.0
hexagon                     defconfig    gcc-16.2.0
hexagon      randconfig-2000-20261120    clang-24
hexagon      randconfig-2001-20261120    clang-24
hexagon      randconfig-2200-20261120    clang-17   smatch
i386                      allnoconfig    gcc-16.2.0
i386                        defconfig    gcc-16.2.0
i386         randconfig-2000-20261120    clang-22
i386         randconfig-2000-20261120    gcc-14
i386         randconfig-2001-20261120    clang-22
i386         randconfig-2001-20261120    gcc-14
i386         randconfig-2002-20261120    clang-22
i386         randconfig-2003-20261120    clang-22
i386         randconfig-2004-20261120    clang-22
i386         randconfig-2005-20261120    clang-22
i386         randconfig-2100-20261120    clang-22   cocci
i386         randconfig-2100-20261120    gcc-14     cocci
i386         randconfig-2101-20261120    gcc-14     cocci
i386         randconfig-2102-20261120    gcc-14     cocci
i386         randconfig-2103-20261120    clang-22   cocci
i386         randconfig-2103-20261120    gcc-14     cocci
i386         randconfig-2104-20261120    gcc-14     cocci
i386         randconfig-2105-20261120    gcc-12     cocci
i386         randconfig-2105-20261120    gcc-14     cocci
i386         randconfig-2200-20261120    clang-22   smatch
i386         randconfig-2300-20261120    clang-22   sparse
i386         randconfig-2301-20261120    clang-22   sparse
i386         randconfig-2302-20261120    clang-22   sparse
loongarch                 allnoconfig    gcc-16.2.0
loongarch                   defconfig    clang-24
loongarch    randconfig-2000-20261120    clang-24
loongarch    randconfig-2001-20261120    clang-24
loongarch    randconfig-2200-20261120    clang-18   smatch
loongarch   randconfig-r2110-20261120    gcc-13.5.0 cocci
loongarch   randconfig-r2111-20261120    gcc-13.5.0 cocci
m68k                      allnoconfig    gcc-16.2.0
m68k                        defconfig    clang-24
m68k                mvme147_defconfig    gcc-16.2.0
m68k         randconfig-2000-20261120    gcc-12.5.0
m68k         randconfig-2000-20261120    gcc-15.3.0
m68k         randconfig-2001-20261120    gcc-15.3.0
m68k         randconfig-2001-20261120    gcc-8.5.0
m68k         randconfig-2200-20261120    gcc-14.4.0 smatch
m68k        randconfig-r2108-20261120    gcc-13.5.0 cocci
m68k        randconfig-r2308-20261120    gcc-8.5.0  sparse
microblaze                allnoconfig    gcc-16.2.0
microblaze                  defconfig    clang-24
microblaze   randconfig-2000-20261120    gcc-15.3.0
microblaze   randconfig-2000-20261120    gcc-9.5.0
microblaze   randconfig-2001-20261120    gcc-15.3.0
microblaze   randconfig-2001-20261120    gcc-8.5.0
microblaze   randconfig-2200-20261120    gcc-11.5.0 smatch
microblaze  randconfig-r2105-20261120    gcc-8.5.0  cocci
mips                      allnoconfig    gcc-16.2.0
mips          decstation_64_defconfig    gcc-16.2.0
mips              malta_kvm_defconfig    gcc-16.2.0
mips         randconfig-2000-20261120    gcc-15.3.0
mips         randconfig-2000-20261120    gcc-9.5.0
mips         randconfig-2001-20261120    clang-19
mips         randconfig-2001-20261120    gcc-9.5.0
mips         randconfig-2002-20261120    gcc-11.5.0
mips         randconfig-2002-20261120    gcc-9.5.0
mips         randconfig-2200-20261120    clang-24   smatch
mips        randconfig-r2302-20261120    clang-24   sparse
mips        randconfig-r2307-20261120    clang-24   sparse
nios2                     allnoconfig    clang-24
nios2                       defconfig    clang-24
nios2        randconfig-2000-20261120    clang-24
nios2        randconfig-2001-20261120    clang-24
nios2        randconfig-2200-20261120    gcc-11.5.0 smatch
nios2       randconfig-r2100-20261120    gcc-11.5.0 cocci
openrisc                  allnoconfig    clang-24
openrisc          or1klitex_defconfig    gcc-16.2.0
openrisc     randconfig-2000-20261120    gcc-9.5.0
openrisc     randconfig-2001-20261120    gcc-11.5.0
openrisc     randconfig-2001-20261120    gcc-9.5.0
openrisc     randconfig-2002-20261120    gcc-9.5.0
openrisc     randconfig-2200-20261120    gcc-11.5.0 smatch
openrisc    randconfig-r2102-20261120    gcc-13.5.0 cocci
openrisc    randconfig-r2305-20261120    clang-24   sparse
openrisc    randconfig-r2309-20261120    gcc-10.5.0 sparse
parisc                    allnoconfig    clang-24
parisc       randconfig-1000-20261121    gcc-10.5.0
parisc       randconfig-1001-20261121    gcc-10.5.0
parisc       randconfig-2000-20261120    clang-24
parisc       randconfig-2001-20261120    clang-24
parisc       randconfig-2200-20261120    gcc-8.5.0  smatch
parisc      randconfig-r2103-20261120    gcc-13.5.0 cocci
parisc      randconfig-r2109-20261120    gcc-13.5.0 cocci
parisc64                    defconfig    clang-24
powerpc                   allnoconfig    clang-24
powerpc              arches_defconfig    gcc-16.2.0
powerpc             mpc83xx_defconfig    gcc-16.2.0
powerpc      randconfig-1000-20261121    gcc-10.5.0
powerpc      randconfig-1001-20261121    gcc-10.5.0
powerpc      randconfig-2000-20261120    clang-24
powerpc      randconfig-2001-20261120    clang-24
powerpc      randconfig-2002-20261120    clang-24
powerpc      randconfig-2200-20261120    clang-17   smatch
powerpc64    randconfig-1000-20261121    gcc-10.5.0
powerpc64    randconfig-1001-20261121    gcc-10.5.0
powerpc64    randconfig-2000-20261120    clang-24
powerpc64    randconfig-2001-20261120    clang-24
powerpc64    randconfig-2002-20261120    clang-24
powerpc64    randconfig-2200-20261120    gcc-16.2.0 smatch
powerpc64   randconfig-r2101-20261120    gcc-13.5.0 cocci
riscv                     allnoconfig    clang-24
riscv        randconfig-2000-20261120    clang-24
riscv        randconfig-2001-20261120    clang-24
riscv        randconfig-2001-20261120    gcc-10.5.0
riscv        randconfig-2002-20261120    clang-24
riscv        randconfig-2002-20261120    gcc-8.5.0
riscv        randconfig-2003-20261120    clang-24
riscv        randconfig-2004-20261120    clang-20
riscv        randconfig-2004-20261120    clang-24
riscv        randconfig-2005-20261120    clang-24
riscv        randconfig-2005-20261120    gcc-10.5.0
riscv        randconfig-2200-20261120    gcc-8.5.0  smatch
riscv       randconfig-r2309-20261120    gcc-10.5.0 sparse
s390                      allnoconfig    clang-24
s390         randconfig-2000-20261120    clang-24
s390         randconfig-2000-20261120    gcc-8.5.0
s390         randconfig-2001-20261120    clang-24
s390         randconfig-2002-20261120    clang-24
s390         randconfig-2003-20261120    clang-24
s390         randconfig-2004-20261120    clang-24
s390         randconfig-2004-20261120    gcc-16.2.0
s390         randconfig-2005-20261120    clang-24
s390         randconfig-2200-20261120    clang-17   smatch
sh                       alldefconfig    gcc-16.2.0
sh                        allnoconfig    clang-24
sh                          defconfig    gcc-14
sh           randconfig-2000-20261120    gcc-11.5.0
sh           randconfig-2000-20261120    gcc-16.2.0
sh           randconfig-2001-20261120    gcc-11.5.0
sh           randconfig-2001-20261120    gcc-16.2.0
sh           randconfig-2002-20261120    gcc-11.5.0
sh           randconfig-2002-20261120    gcc-16.2.0
sh           randconfig-2003-20261120    gcc-11.5.0
sh           randconfig-2004-20261120    gcc-11.5.0
sh           randconfig-2004-20261120    gcc-16.2.0
sh           randconfig-2005-20261120    gcc-11.5.0
sh           randconfig-2005-20261120    gcc-15.3.0
sh           randconfig-2200-20261120    gcc-11.5.0 smatch
sh          randconfig-r2100-20261120    gcc-13.5.0 cocci
sparc                     allnoconfig    clang-24
sparc        randconfig-2000-20261120    gcc-16.2.0
sparc        randconfig-2000-20261120    gcc-8.5.0
sparc        randconfig-2001-20261120    gcc-8.5.0
sparc        randconfig-2200-20261120    gcc-11.5.0 smatch
sparc       randconfig-r2102-20261120    gcc-13.5.0 cocci
sparc       randconfig-r2311-20261120    gcc-8.5.0  sparse
sparc64                     defconfig    gcc-14
sparc64      randconfig-2000-20261120    gcc-8.5.0
sparc64      randconfig-2001-20261120    gcc-8.5.0
sparc64      randconfig-2200-20261120    gcc-14.4.0 smatch
sparc64     randconfig-r2106-20261120    gcc-13.5.0 cocci
sparc64     randconfig-r2311-20261120    gcc-10.5.0 sparse
um                        allnoconfig    clang-24
um                          defconfig    gcc-14
um                     i386_defconfig    gcc-14
um           randconfig-2000-20261120    clang-24
um           randconfig-2000-20261120    gcc-8.5.0
um           randconfig-2001-20261120    gcc-14
um           randconfig-2001-20261120    gcc-8.5.0
um           randconfig-2200-20261120    clang-24   smatch
um          randconfig-r2301-20261120    clang-24   sparse
um          randconfig-r2303-20261120    clang-24   sparse
um                   x86_64_defconfig    gcc-14
x86_64                    allnoconfig    clang-24
x86_64                      defconfig    gcc-14
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261120    clang-22
x86_64       randconfig-2000-20261120    gcc-14
x86_64       randconfig-2001-20261120    clang-22
x86_64       randconfig-2001-20261120    gcc-14
x86_64       randconfig-2002-20261120    clang-22
x86_64       randconfig-2003-20261120    clang-22
x86_64       randconfig-2004-20261120    clang-22
x86_64       randconfig-2005-20261120    clang-22
x86_64       randconfig-2005-20261120    gcc-14
x86_64       randconfig-2100-20261120    gcc-14     cocci
x86_64       randconfig-2101-20261120    gcc-14     cocci
x86_64       randconfig-2102-20261120    gcc-14     cocci
x86_64       randconfig-2103-20261120    clang-22   cocci
x86_64       randconfig-2104-20261120    clang-22   cocci
x86_64       randconfig-2105-20261120    clang-22   cocci
x86_64       randconfig-2200-20261120    clang-22   smatch
x86_64       randconfig-2300-20261120    clang-22   sparse
x86_64       randconfig-2301-20261120    clang-22   sparse
x86_64       randconfig-2302-20261120    clang-22   sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    clang-24
xtensa       randconfig-2000-20261120    gcc-15.3.0
xtensa       randconfig-2001-20261120    gcc-8.5.0
xtensa       randconfig-2200-20261120    gcc-9.5.0  smatch
xtensa      randconfig-r2101-20261120    gcc-16.2.0 cocci
xtensa      randconfig-r2103-20261120    gcc-8.5.0  cocci
xtensa      randconfig-r2307-20261120    gcc-10.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
