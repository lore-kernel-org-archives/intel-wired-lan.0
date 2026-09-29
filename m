Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C253ACA5FA7
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 18:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AF3C607A9;
	Tue, 29 Sep 2026 18:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UGULd9x5Wsfn; Tue, 29 Sep 2026 18:20:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 60190607BB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790706009;
	b=VcouaS8f2vH/FKdDyDJcOXYEAv5XQZobz+QJ8NP1jwxukmtEJRPBK93Bln8CKP/8AFBc
	 xuSRszunQVK3yWYTNh/9nu33vHdMUafq/RM0jI/4wmYXa53arTMQo9ZbzmUYTzb+L6Oqi
	 x6b/B8d4lXMJy5EzVDZs0BXPq0hQUj314kJasYjT4WpddLwmWKvzvvZJg8BF2CF8M/G7/
	 owk7nGjyU0qNzoACWMog7ZvBoa9By146wV5kfIf/pD4DDL2jAp+panLh/fYC9VNfctm3r
	 kqUuOc5dkTq998HROIm5/pUUaayvChXXY9wPxDE+V0AuJnuTQnGmGqy0HArdhHHXWhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790706009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qNm1OZKgcDwQLnsc3rZsiyEW6d0E4o2un7d8trmdP2c=;
	b=MB6+9jtdy1h5/C9Tye2kSqh4KdhtnyZsAmmeM1VnP+es/oN3Y2lz7HtAR9SP+3YZEwIv
	 lvN28eOAjGj2+8ujUpxN8qt6Fl+Iuav/ILdOFnUrLbAfXIlJUO/c3ldiwGSYqrd00Xz8P
	 mwwE4VTUqQJYob7FguLfEbM3aWeUXJo3228bAVfboME03kAQFXxWIsSrJnqyZqglfPFnW
	 vCrhveJHMBuyNQYHYUXzYfIws96tbrcdREO2lToXAtOFeb9PVD3UooKmDvR80KfZ1TbJR
	 UYo5GBNtW7aSZj2XYZSLTqxWkjaWYZvKsON1tEAAjVF1WcwFG7jYw5jF1Ejwvd53zwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PtHbyEql;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790706009;
	bh=qNm1OZKgcDwQLnsc3rZsiyEW6d0E4o2un7d8trmdP2c=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3NKI86ZjEM4ziGJdYqmojiZf2JiH78AOLZxcQWP210lnYEKkw39qh0doFa+J7PG+O
	 rw3zCoOIlMGkyekuOCGUln1fdE2+W3GjADe4QtePzE4I6SDWbk33KMedVaXsmiR/42
	 ip+GJCnslQv9rOR/Nxd0ca84C07G/UXyGgzPCixS2Eobt+x9Wv1GYzwf8aANlgmHGW
	 fyzwO1pww34n9ej4SODiI0hcNpMvOSUc2802bMXlXphT+H+ui2WWO4hwvu0mocNXVk
	 MO7iRsIL6hF0jQu3H/fA6VgoFjCwBkuPIhnps9/KjTK+f0V/wU+NrVvJ3DklvfOmfs
	 xXf5etNN/yARg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60190607BB;
	Tue, 29 Sep 2026 18:20:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF61B3D8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 18:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5EC36071A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 18:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJHguka2BAaa for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 18:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5CFB4607A9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790706006;
 b=HLG2eFVAJhcE5TEgBZaY2EUMgHVu0PinZGzxD2lzTCydZaETH1/rvfZUVfBLTAoXMOKu
 AzGt9ETqvvN0WCZwclNFk54QAPQECR2/S4BpURRqAtt60DkLiDtNBo1vfvg586AUwgKW9
 ps7pg6jugOkB18KsvvQ/ngljR3oWdHq7POMouEbp4Oq7NuIYqNdS1/hw+C+S8c2ev9zEd
 fDmhQHKKI+xkvZtPls9yLDirnkE/0htUnJdLvYVQRjs/nRSIjxtudS0zPPGATMkhulARS
 68OE/hNmp+B5FQKAs1EFDSadxOl645yeG1CUaUIoAYInGPJqTJuT+vHh9kOmoApF/fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790706006;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=qNm1OZKgcDwQLnsc3rZsiyEW6d0E4o2un7d8trmdP2c=;
 b=Oir/dBQKaUYdOokMAs0YUtBVKStaqgsXk8c/IePvfquEjM66+17IggstgZ3dfcy6jO7p
 oYvdCZCEC6pdhp11WROSJPfYdSf8eacAO+Xg4VTg3VJ2lWxj9Savk9pitZcDyi9x5cRtc
 QQeziyCU3WCQvXQyIvd6IN38oHKAEH07cMxdZ62FqHqEWdiIB4CekThRLz44Kg/Fyf1Uz
 kwcQiE4dWEHCBUOTxyHy50h4XRx/sYTs5HVgLFZlhoxfUzqJpXkCxcSs5mTGXKZQPUyr5
 wsFScdJN7i+oOsrXpLz2MPj/Inlt3H1qVGj6AaKTERTjCZdrIHEgEpXy25Be6FCkMkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PtHbyEql; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PtHbyEql
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CFB4607A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790706006; x=1822242006; h=date:from:to:subject:message-id;
 bh=QMqx3DVbZUQOCf39ExhW3EmoXkN5m9H6ZuqQR2GFsm0=;
 b=PtHbyEqlFU+wuw2MizY0cxg3GV7cH19C+mrWoIgZpuYXN/4xJ3/bNzL9
 WTWZJmYsYRgfqCV32bieHqX5APyZ5OfrV1iSXPtlCJ+TDbIzANS8xlxRE
 sMDvFoYUq5U0hBS7zd68HWC69ZWX9HSEgI5KXchMxUHKZlBtRtrnddIUq
 9rumv02xfQOh/JyM5XMSC9TNhQkZMAxC3Z2Xrd2qkZges4//uMVytz1Ra
 qH05pLl7dO88sIQyEkrRUGiUGWe6bRzye06X+DloD/rNj1cS+aCdGofA5
 gQSfWrQMWQA9rkBw7k7qyYR8ce3/W5Oem03vOODv3MqpDKJvAVemaSZCs g==;
X-CSE-ConnectionGUID: CveU5QCiQYmnnEJr5hhKaA==
X-CSE-MsgGUID: qM8zy6UMQSq3uE+3RgoK/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90332226"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90332226"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 11:20:05 -0700
X-CSE-ConnectionGUID: O+3LvL9pSzOGxaimXXpc3A==
X-CSE-MsgGUID: rcp3WhXLRnW1Ooo6F4VpZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="280202486"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2026 11:20:04 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xBcQr-00000000Pev-2VSS;
 Tue, 29 Sep 2026 18:20:01 +0000
Date: Wed, 30 Sep 2026 02:19:58 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 3128bdeae43d69858c6e9df471e4819b4208a7b7
Message-ID: <202609300254.0aP6mwMZ-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 3128bdeae43d69858c6e9df471e4819b4208a7b7  ice: restore double VLAN port parameters on devlink reload

elapsed time: 975m

configs tested: 237
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2107-20260929    gcc-15.2.0 cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260929    clang-17
arc                   randconfig-1001-20260929    clang-17
arc                  randconfig-r2100-20260929    clang-24   cocci
arc                  randconfig-r2103-20260929    clang-22   cocci
arc                  randconfig-r2309-20260929    clang-24   sparse
arc                            tb10x_defconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260929    clang-17
arm                   randconfig-1001-20260929    clang-17
arm                   randconfig-1002-20260929    clang-17
arm                   randconfig-1003-20260929    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260929    clang-24
arm64                 randconfig-1001-20260929    clang-24
arm64                 randconfig-1002-20260929    clang-24
arm64                 randconfig-1003-20260929    clang-24
arm64                randconfig-r2102-20260929    clang-24   cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260929    clang-24
csky                  randconfig-1001-20260929    clang-24
csky                 randconfig-r2105-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2107-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2309-20260929    gcc-11.5.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260929    gcc-8.5.0
hexagon               randconfig-1001-20260929    gcc-8.5.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260929    clang-22
i386        buildonly-randconfig-1001-20260929    clang-22
i386        buildonly-randconfig-1002-20260929    clang-22
i386        buildonly-randconfig-1003-20260929    clang-22
i386        buildonly-randconfig-1004-20260929    clang-22
i386        buildonly-randconfig-1005-20260929    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260929    gcc-13
i386                  randconfig-1001-20260929    gcc-13
i386                  randconfig-1002-20260929    gcc-13
i386                  randconfig-1003-20260929    gcc-13
i386                  randconfig-1004-20260929    gcc-13
i386                  randconfig-1005-20260929    gcc-13
i386                  randconfig-1006-20260929    gcc-13
i386                  randconfig-1007-20260929    gcc-14
i386                  randconfig-1008-20260929    gcc-14
i386                  randconfig-1009-20260929    gcc-14
i386                  randconfig-1010-20260929    gcc-14
i386                  randconfig-1011-20260929    gcc-14
i386                  randconfig-1012-20260929    gcc-14
i386                  randconfig-1013-20260929    gcc-14
i386                  randconfig-2100-20260929    clang-22   cocci
i386                  randconfig-2101-20260929    clang-22   cocci
i386                  randconfig-2102-20260929    clang-22   cocci
i386                  randconfig-2103-20260929    clang-22   cocci
i386                  randconfig-2200-20260929    gcc-14     smatch
i386                 randconfig-r2106-20260929    gcc-16.1.0 cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260929    gcc-8.5.0
loongarch             randconfig-1001-20260929    gcc-8.5.0
loongarch            randconfig-r2102-20260929    clang-24   cocci
loongarch            randconfig-r2107-20260929    clang-22   cocci
loongarch            randconfig-r2201-20260929    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2101-20260929    clang-24   cocci
m68k                 randconfig-r2104-20260929    clang-22   cocci
m68k                 randconfig-r2105-20260929    clang-22   cocci
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2306-20260929    clang-24   sparse
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                       loongson3_defconfig    gcc-16.1.0
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20260929    clang-22   cocci
mips                 randconfig-r2103-20260929    clang-24   cocci
mips                 randconfig-r2200-20260929    gcc-12.5.0 smatch
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260929    gcc-8.5.0
nios2                 randconfig-1001-20260929    gcc-8.5.0
nios2                randconfig-r2200-20260929    gcc-11.5.0 smatch
nios2                randconfig-r2306-20260929    gcc-11.5.0 sparse
nios2                randconfig-r2307-20260929    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260929    gcc-8.5.0
parisc                randconfig-1001-20260929    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20260929    gcc-8.5.0
powerpc               randconfig-1001-20260929    gcc-8.5.0
powerpc              randconfig-r2104-20260929    gcc-16.1.0 cocci
powerpc              randconfig-r2202-20260929    clang-24   smatch
powerpc64             randconfig-1000-20260929    gcc-8.5.0
powerpc64             randconfig-1001-20260929    gcc-8.5.0
powerpc64            randconfig-r2104-20260929    gcc-15.2.0 cocci
powerpc64            randconfig-r2106-20260929    gcc-15.2.0 cocci
powerpc64            randconfig-r2307-20260929    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260929    clang-24
riscv                 randconfig-1001-20260929    clang-24
riscv                 randconfig-2000-20260929    gcc-11.5.0
riscv                 randconfig-2001-20260929    gcc-11.5.0
riscv                randconfig-r2100-20260929    clang-24   cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260929    clang-24
s390                  randconfig-1001-20260929    clang-24
s390                  randconfig-2000-20260929    gcc-11.5.0
s390                  randconfig-2001-20260929    gcc-11.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20260929    clang-24
sh                    randconfig-1001-20260929    clang-24
sh                    randconfig-2000-20260929    gcc-11.5.0
sh                    randconfig-2001-20260929    gcc-11.5.0
sh                            se7343_defconfig    gcc-16.1.0
sh                         sh7785lcr_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260929    gcc-14
sparc                 randconfig-1001-20260929    gcc-14
sparc                 randconfig-2000-20260929    gcc-12.5.0
sparc                 randconfig-2001-20260929    gcc-12.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260929    gcc-14
sparc64               randconfig-1001-20260929    gcc-14
sparc64               randconfig-2000-20260929    gcc-12.5.0
sparc64               randconfig-2001-20260929    gcc-12.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260929    gcc-14
um                    randconfig-1001-20260929    gcc-14
um                    randconfig-2000-20260929    gcc-12.5.0
um                    randconfig-2001-20260929    gcc-12.5.0
um                   randconfig-r2201-20260929    gcc-14     smatch
um                   randconfig-r2202-20260929    clang-24   smatch
um                   randconfig-r2308-20260929    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260929    clang-22
x86_64      buildonly-randconfig-1001-20260929    clang-22
x86_64      buildonly-randconfig-1002-20260929    clang-22
x86_64      buildonly-randconfig-1003-20260929    clang-22
x86_64      buildonly-randconfig-1004-20260929    clang-22
x86_64      buildonly-randconfig-1005-20260929    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260929    clang-22
x86_64                randconfig-1001-20260929    clang-22
x86_64                randconfig-1002-20260929    clang-22
x86_64                randconfig-1003-20260929    clang-22
x86_64                randconfig-1004-20260929    clang-22
x86_64                randconfig-1005-20260929    clang-22
x86_64                randconfig-1006-20260929    gcc-13
x86_64                randconfig-1007-20260929    gcc-13
x86_64                randconfig-1008-20260929    gcc-13
x86_64                randconfig-1009-20260929    gcc-13
x86_64                randconfig-1010-20260929    gcc-13
x86_64                randconfig-1011-20260929    gcc-13
x86_64                randconfig-1012-20260929    clang-22
x86_64                randconfig-1013-20260929    clang-22
x86_64                randconfig-1014-20260929    clang-22
x86_64                randconfig-1015-20260929    clang-22
x86_64                randconfig-1016-20260929    clang-22
x86_64                randconfig-1017-20260929    clang-22
x86_64                randconfig-2100-20260929    clang-22   cocci
x86_64                randconfig-2101-20260929    clang-22   cocci
x86_64                randconfig-2102-20260929    clang-22   cocci
x86_64                randconfig-2103-20260929    clang-22   cocci
x86_64                randconfig-2200-20260929    clang-22   smatch
x86_64               randconfig-r2101-20260929    clang-24   cocci
x86_64               randconfig-r2102-20260929    clang-22   cocci
x86_64               randconfig-r2106-20260929    clang-22   cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260929    gcc-14
xtensa                randconfig-1001-20260929    gcc-14
xtensa                randconfig-2000-20260929    gcc-12.5.0
xtensa                randconfig-2001-20260929    gcc-12.5.0
xtensa               randconfig-r2101-20260929    clang-22   cocci
xtensa               randconfig-r2105-20260929    gcc-15.2.0 cocci
xtensa               randconfig-r2308-20260929    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
