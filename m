Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D392CCF2D4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 03:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F3D240623;
	Mon, 19 Oct 2026 03:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xI1aiDZWzyex; Mon, 19 Oct 2026 03:25:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1CA124062A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792380313;
	b=Mw9plDn1tGJ6yOgBmGVcOTgI8vkQpRS4pmuxImoFQ/sCa7II4C+CJKZZVqzRflfpyMAG
	 BpYQxZ0CL99SLORLWqKn3crPVBFeV+m+SB4FybUNNmOAdjxxcVqBxXIV012VRupMLBBes
	 T3um9/w2A3ft5zqtjxWvqywA37ylB+OwFN+KmkY5W+wO6dH7V5d0UWgEfjgP+b+IRlsR3
	 dM0RmFX8cGV4NcjG23jYa56UNJTCwYah3fU49dA3KFYaG1WCptvOQkma/5hOgi/I5fZFV
	 6UGP0AH11aMXh/2qedGsOWB9nz55AfNRkQ2bDcXaTykRv0m5o6v49TfUiy75xQyYNBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792380313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=51ddNOMgH0L1yJcZkaWEJVpHpKqqPukHWAcCekwwjyo=;
	b=Tc7g1nVvSR07y1dwXUouEbV89tzQt64CoB4HTVc+9ebzGj+3JzyiC/Ep742JGqZgWRon
	 qHN91xSbe+6SPtvy+YzpO+8b+N6HpO/9fApO4NsVU+OtFCCXlgRqEKH7pVeHeNzRTOoZW
	 0CL9Fqdlb44sMTEfFvNv/Ww4fbfAULh3gDGCVqiHdCxpJ0KDkxU2lb6aR9qwpAHvz34r+
	 aQ7VsEA0YbsjrhgXdSyXxXUx2USBjpjee8IXTChbcNJ8i8QZ+omeGKAm5hmAjSiA2eSJ5
	 a1X53KV2spME2dIfFajAY+EKf47wr0MhKBOsQHSLtbbDjWceUNU0Dt3X8bJv8Hl5KpQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="W/Nx1kYc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792380313;
	bh=51ddNOMgH0L1yJcZkaWEJVpHpKqqPukHWAcCekwwjyo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9ClYx4y+Hw7khN32G3an0brd9lspRXQvCApd3i5yMznYjc+PzdbUKqfHVK5/7UB70
	 z7IoXdItUJxNzFMJ2n68C0zhENg//2WKrxVDIGnw3uUA67PQqmysIpzMG5P6qrlxGy
	 8FtbTujWAARtvBrTEyTtjbhGqRRt/f15WDsvJib3Gh7ogMaBGyL24jpc10ys58vllv
	 0qtaQ6of2UkMxteRzAiN7+gdcCLycX9Z75dfjnRWUz7W80En+hk7YCTljR6dzwk7sQ
	 qtjURwI/WIObD/WyyytvAhZ5g4un7g6tNt0kJRRyIc1sXn86eJdbjyOwrvMt4LFkav
	 qmq4hApeo/KYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CA124062A;
	Mon, 19 Oct 2026 03:25:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF28F2A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A54274062A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrbPDfvQKviV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 03:25:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68EE040623
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792380310;
 b=lPTC+6GaihBTKSMqdW8IBdJ0wwH6u9W5FcZK5kBd4y94G3S6xIpGRG9HeYLa5uf0lROZ
 FLSy5yTAtqwSgFwnyjs0xQJFNljF6mNZCJZMM6pYJGbxqqOFlv+mpeD4yvvryigqoyRbE
 Sgafy4lf3jvdlxB7fcdMse2acqE6nduN+hgzYfIzLOkGGIX0pzYbvGXHawmD4S6GvVM+g
 y3BSX3ki2kYl/YhPEUS600+UeC9qIVzg5DhLOWzCqhYAQSlb/QoodDBr0rKAxs3c9E83n
 /jkCumqeh5YO3XCkXV0HwGrCZRw9RBbccJofsF7rRAfrOR5B6Zef3W4Oa7p6dknn+aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792380310;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=51ddNOMgH0L1yJcZkaWEJVpHpKqqPukHWAcCekwwjyo=;
 b=KaGmz8b7vZHNoMHRmkciNvsEpGMqCDHgd4THMq/iadYB4EU+QKLYADR/fBLxt0AXNoi+
 5TB84pxJRsrysotTSXHmIgrTSuIVkfmn/iP5Cf+l1t+xjqycgoas49fdE8BCNoK5rkH59
 uVxEdncIPpWiqkPZev5suIJbgG63dabJCT5PMF0uSwdxG9sJ2cRau/KHkAmovAX9kjT4R
 3cdv17TSyE0LH0lci/l7HoKNjeOSeEEO1m6QDqjRR/7j/iA577o/8ApN6T0oiDfWEp7JC
 bSIhB4OBY5TFgenTawWxSw45ff5a2PlOBCfq5y7Iyw8IoVozNgm6b75Z2jDlzGdit1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="W/Nx1kYc"; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=W/Nx1kYc
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68EE040623
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792380311; x=1823916311; h=date:from:to:subject:message-id;
 bh=NpeZ4E3klqxrg/XLSztoB04rHhxFtLO+wWEyTjkTREE=;
 b=W/Nx1kYcI8XxrPex0KUA8+iQTbJL1Dyqbx2lRhvVKuUW3axllxXfz9E6
 kF8G/le9jVr+Ucu/cStgJy5HyZazM4/lopzW8lbhNh5wPlXhBlPL1xaGB
 iGEOC+VGRY4D/W14y7ydhtiKfs32rzQmLS2ichp32hbC9LlBe/zfm/rSe
 JVJpOf957sAYljQDpbT8OEqxr4FbnoB7YFPVWKDyyyTUOGY7yyrm+Rdho
 J1/9yZeeDOv2rn5T5EyKaVBxQViyqDarIgsLY6swUVq+dUcFbBIETguFT
 036PmjiCQlpkMRQ1QmeAvMvm5fBzcxF2y/HImLwBO22ZuspSO7uab43Sn g==;
X-CSE-ConnectionGUID: SaUR3UL1QYi5gZo6d0wXuA==
X-CSE-MsgGUID: yqSe9bHUQHOByUeYQPTKOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="945753"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="945753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 20:25:10 -0700
X-CSE-ConnectionGUID: /G+8fG7yT7CduOckm7/9IA==
X-CSE-MsgGUID: 6zcZ8//ETc6zg7eV2SzFsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2849847"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 18 Oct 2026 20:25:08 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xIdzl-00000000LCF-3djZ;
 Mon, 19 Oct 2026 03:25:05 +0000
Date: Mon, 19 Oct 2026 11:24:27 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c36fa7ce2514d21f18388cc4e3c0f88a4f7ab40e
Message-ID: <202610191125.SCxnibwF-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: c36fa7ce2514d21f18388cc4e3c0f88a4f7ab40e  igc: Support ACPI-based MAC passthrough

elapsed time: 1296m

configs tested: 165
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261019    clang-21
arc                   randconfig-1001-20261019    clang-21
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261019    clang-21
arm                   randconfig-1001-20261019    clang-21
arm                   randconfig-1002-20261019    clang-21
arm                   randconfig-1003-20261019    clang-21
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261019    clang-24
arm64                 randconfig-1001-20261019    clang-24
arm64                 randconfig-1002-20261019    clang-24
arm64                 randconfig-1003-20261019    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261019    clang-24
csky                  randconfig-1001-20261019    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261019    clang-24
hexagon               randconfig-1001-20261019    clang-24
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261018    clang-22
i386        buildonly-randconfig-1001-20261018    clang-22
i386        buildonly-randconfig-1002-20261018    clang-22
i386        buildonly-randconfig-1003-20261018    clang-22
i386        buildonly-randconfig-1004-20261018    clang-22
i386        buildonly-randconfig-1005-20261018    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261019    clang-22
i386                  randconfig-1001-20261019    clang-22
i386                  randconfig-1002-20261019    clang-22
i386                  randconfig-1003-20261019    clang-22
i386                  randconfig-1004-20261019    clang-22
i386                  randconfig-1005-20261019    clang-22
i386                  randconfig-1006-20261019    clang-22
i386                  randconfig-1007-20261018    gcc-14
i386                  randconfig-1008-20261018    gcc-14
i386                  randconfig-1009-20261018    gcc-14
i386                  randconfig-1010-20261018    gcc-14
i386                  randconfig-1011-20261018    gcc-14
i386                  randconfig-1012-20261018    gcc-14
i386                  randconfig-1013-20261018    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261019    clang-24
loongarch             randconfig-1001-20261019    clang-24
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                             mac_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                        rbtx49xx_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261019    clang-24
nios2                 randconfig-1001-20261019    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261018    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261018    clang-24
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261018    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261018    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261018    clang-17
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261018    clang-17
sh                           rsk7264_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261019    clang-20
sparc                 randconfig-1001-20261019    clang-20
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261019    clang-20
sparc64               randconfig-1001-20261019    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261019    clang-20
um                    randconfig-1001-20261019    clang-20
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261018    clang-22
x86_64                randconfig-1001-20261018    clang-22
x86_64                randconfig-1002-20261018    clang-22
x86_64                randconfig-1003-20261018    clang-22
x86_64                randconfig-1004-20261018    clang-22
x86_64                randconfig-1005-20261018    clang-22
x86_64                randconfig-1006-20261018    clang-22
x86_64                randconfig-1007-20261018    clang-22
x86_64                randconfig-1008-20261018    clang-22
x86_64                randconfig-1009-20261018    clang-22
x86_64                randconfig-1010-20261018    clang-22
x86_64                randconfig-1011-20261018    clang-22
x86_64                randconfig-1012-20261019    gcc-14
x86_64                randconfig-1013-20261019    gcc-14
x86_64                randconfig-1014-20261019    gcc-14
x86_64                randconfig-1015-20261019    gcc-14
x86_64                randconfig-1016-20261019    gcc-14
x86_64                randconfig-1017-20261019    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261019    clang-20
xtensa                randconfig-1001-20261019    clang-20
xtensa               randconfig-r2202-20261018    gcc-10.5.0 smatch
xtensa                          virt_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
