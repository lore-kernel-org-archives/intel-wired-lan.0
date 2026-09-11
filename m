Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F04C88E41
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 02:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11A3F8116F;
	Fri, 11 Sep 2026 02:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XIQnk_SclbIf; Fri, 11 Sep 2026 02:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1089D8114B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789092820;
	b=hZABYZEIW4h5h1qrvP6Q+L7bfW76FCFVWAnEKMGVosAZtLki74JDOUOWw2npu4x9Xttf
	 pXdgz5lzjlWFSHOxxud7oFeI+8nsBBPnlwa+pdk8ey0L8cx8aEHjwe52gPguwXo+JMxK3
	 0z+wzNhzAUlPMWGECzOVPheyAkmGf7wanSn1mfecPdT/NOd+kUWy4lIwrPXzDYm/CbsTI
	 YyOuR/vbedQwvtCyWmUqcDr0geaXpHr54i0STUjXtVkJG0iwUyXDdp67Gx3XLwrBmCf92
	 RuzAAMudn+5iYxLs7hFh6vQPGuSzwwfIqAqusKke9Ml9fAfGAdLyTukCAh1xn/GmPPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789092820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=l0A/kO79eyQM4wo57VKDE6PZGtIor8SpaXw7LSSF9yM=;
	b=Vuir1u2y193PR7TfvBVGTHGcQXnENDaQ1cZwvBzttr1YVCBb/qO82uTQM9wAd7kovbBB
	 OpsOckGDWsEURWjrE4S9SuF/uN+8dZ5mRgGGhe4PYlxlHcmfquNDb0fUpEGYIrMoC9TlB
	 otiQqfnEGhzhYAG2eMa3G83iAoQRDmY9EQMAiq1mp87JIpW0AwObLo82MZY5gb/fQ+gF8
	 efIPuIMZwDUWUHgiwvtt4jw0aPjTmgrBXW+GFuedlEt4jDCC1o+mrb+mXFYHTLmZLf60T
	 KyhV9ZxVcGyWoMFhwIhioqiXq/vMUjQK/N3PezLuFNlXxomI9KQ1l/jBlWtKAw32dOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789092820;
	bh=l0A/kO79eyQM4wo57VKDE6PZGtIor8SpaXw7LSSF9yM=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4rR7wrw/TQJcVoKI7c5XBWA/K3hs9otFdvE41l5reM8kyR+heHnA7ebHKiRt5MsmY
	 FWGmd75ofweikj9xS9NfZMT5/4qYAuVjA28fZVcNMH8CCmgrCh+Klwdz+B4gbDGptq
	 7QpP/IG+NCmduI0UNeRncA5bzVB2dZNGgQxzmeb6FG8SZz/o4MA75excuAMoV5n7De
	 DTxltG+usmrE8Kyb+osRY8S11+IulNLILLF32VWnBC6WJnCAYcAVe4aETsfrhlF7Za
	 mULjEz80hzQaODhWsZspURdtOvXOk3OL/g+BnzHttVa4zKfgfQMUM9sTTQOTHf9Dji
	 0d7MjdpaJP5eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1089D8114B;
	Fri, 11 Sep 2026 02:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F305362
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 02:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84CB5607EF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 02:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19En_EiMdmPv for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 02:13:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 40A4C607E5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789092817;
 b=Ll5kBVdo2dMxHAKSkOoDU8ZioDqQ/Q6uzNnZtTtk6rOfRdtE6QCnaGgCgVIPhZXCkL1w
 NL1guN5mohbl2yKwf+6F9THgskxG/aNxRHeN5hDttuB0u7mrN1vr3Q3yVWBN6+0W28aXa
 /kOKgo4/TMHvAcpx+wM9VZmebW3y+pIdRg6VYyqQaAI5jcE4P8d/dWosICbqgxNd5uxWI
 EJuw50Uw/6GjQjPKQSgvk0QHV59bcdqQs0CokAMUoLC5AxCqS3khVZAWYNI+/bbzydf7j
 cbIBpbqrZme+dEbOcmhm/fvWGHCfFXf774nMuwQSoj1I35gmRzxANL/GryOABenHs4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789092817;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=l0A/kO79eyQM4wo57VKDE6PZGtIor8SpaXw7LSSF9yM=;
 b=PW7Mm+MRohOQJsFHCoIWVO62LdD+UIUC4VUHEnayxWzCT0Eg2eHESX5AWeCEL8kgDXBa
 lP9Cz8DswrA2k5HpM9xurjnVRq8Fj4HlBT3AtL1kHYmNAjPirnI1WAk28Iv1bUm+UaGFY
 xLsU3XKSql1TEUVkYKFUoeKlxqPBBMalkNxfwVmwHbxmcAXWl8/gaAJElkf6A95xZfsVd
 EQdPW/f5cMhQ8NGnvfD9HdSTlIMWOYrFgiYY9Rj3QLN2sFpcTAp78YnxpwjRjRzhfZfaw
 o2pM9+RbdvvuIxcAMb4tmbOTqSbitwmKb9HaKGy9zVwUKRUxNPQmSYXp6s+VtTiWhFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gys4o7Ny; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gys4o7Ny
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40A4C607E5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789092817; x=1820628817; h=date:from:to:subject:message-id;
 bh=RdBPgtY9uUQUHx0wKBM7idZOYEB+5CSXfrYdGyuw1d8=;
 b=gys4o7NyIpb8dk2VJfhSdyZezXh9p729IyVA1SZFJ2K8MtOcm2VyJIgL
 kv4yMK0z5GhERX246VPWgYi/mFK12SUm9QBW4tfOM5UJqXPLo3a63IK4N
 kYhGOwwKqEsPxSm8JAbKIImp42ZBAhqhV3hFXdr2NYjdQVIzLo6zWT9Av
 0bqJkff5G2ZdTB1zJiQmdltAFuSf/JR+0qlnSB6g9649AcCOLySPvKJ8x
 2+WiCD30v9yh/NTkP1Bt46ko43OeWYC9LwmOCDwSJscwRxLsxa57BzZef
 vUK9kPRcZx1bMSGfYdPdyy4WoX/xMG2AA9Ve2egQfJLyNC73a1tjbHUy+ Q==;
X-CSE-ConnectionGUID: pZw09SdFS6Gd7rkNkRP/Ew==
X-CSE-MsgGUID: ms14QEp2Tpejk3sO1KiOyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93419810"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93419810"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 19:13:35 -0700
X-CSE-ConnectionGUID: waK++2cVQYSA/p/9arrrMw==
X-CSE-MsgGUID: vo8tlavlT/iyyPlOxj7YCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="267510795"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
 by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2026 19:13:33 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4qlV-000000000qL-1F7S;
 Fri, 11 Sep 2026 02:13:23 +0000
Date: Fri, 11 Sep 2026 10:03:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD SUCCESS
 400c836aa8bd83d194ab660c1afb5ce0f96823ca
Message-ID: <202609111041.06dyRgiY-lkp@intel.com>
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
branch HEAD: 400c836aa8bd83d194ab660c1afb5ce0f96823ca  ice: drop pf == NULL check in ice_pf_state_is_nominal()

elapsed time: 1879m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                     allnoconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
arm                     allnoconfig    clang-17
arm                    allyesconfig    gcc-16.1.0
arm64                  allmodconfig    clang-24
arm64                   allnoconfig    gcc-16.1.0
csky                   allmodconfig    gcc-16.1.0
csky                    allnoconfig    gcc-16.1.0
hexagon                allmodconfig    clang-24
hexagon                 allnoconfig    clang-24
hexagon     randconfig-001-20260911    clang-17
hexagon     randconfig-002-20260911    clang-20
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-20
loongarch   randconfig-001-20260911    gcc-12.5.0
loongarch   randconfig-002-20260911    clang-22
m68k                   allmodconfig    gcc-16.1.0
m68k                    allnoconfig    gcc-16.1.0
m68k                   allyesconfig    gcc-16.1.0
microblaze              allnoconfig    gcc-16.1.0
microblaze             allyesconfig    gcc-16.1.0
mips                   allmodconfig    gcc-16.1.0
mips                    allnoconfig    gcc-16.1.0
mips                   allyesconfig    gcc-16.1.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260911    gcc-11.5.0
nios2       randconfig-002-20260911    gcc-11.5.0
openrisc               allmodconfig    gcc-16.1.0
openrisc                allnoconfig    gcc-16.1.0
openrisc                  defconfig    gcc-16.1.0
parisc                 allmodconfig    gcc-16.1.0
parisc                  allnoconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
parisc      randconfig-001-20260911    gcc-13.4.0
parisc      randconfig-002-20260911    gcc-11.5.0
powerpc                allmodconfig    gcc-16.1.0
powerpc                 allnoconfig    gcc-16.1.0
powerpc     randconfig-001-20260911    clang-21
powerpc     randconfig-002-20260911    clang-24
powerpc64   randconfig-001-20260911    gcc-8.5.0
powerpc64   randconfig-002-20260911    clang-24
riscv                  allmodconfig    clang-24
riscv                   allnoconfig    gcc-16.1.0
riscv                  allyesconfig    clang-24
riscv                     defconfig    clang-24
riscv       randconfig-001-20260911    clang-24
riscv       randconfig-002-20260911    clang-24
s390                   allmodconfig    clang-24
s390                    allnoconfig    clang-24
s390                   allyesconfig    gcc-16.1.0
s390                      defconfig    clang-18
s390        randconfig-001-20260911    gcc-13.4.0
s390        randconfig-002-20260911    gcc-15.2.0
sh                     allmodconfig    gcc-16.1.0
sh                      allnoconfig    gcc-16.1.0
sh                     allyesconfig    gcc-16.1.0
sh          randconfig-001-20260911    gcc-14.3.0
sh          randconfig-002-20260911    gcc-16.1.0
sparc                   allnoconfig    gcc-16.1.0
sparc                     defconfig    gcc-16.1.0
sparc       randconfig-001-20260911    gcc-8.5.0
sparc       randconfig-002-20260911    gcc-13.4.0
sparc64                allmodconfig    clang-20
sparc64     randconfig-001-20260911    clang-21
sparc64     randconfig-002-20260911    gcc-9.5.0
um                     allmodconfig    clang-17
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-14
um          randconfig-001-20260911    gcc-14
um          randconfig-002-20260911    clang-24
x86_64                 allmodconfig    clang-22
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-22
x86_64      randconfig-002-20260911    gcc-12
x86_64      randconfig-005-20260911    gcc-14
x86_64                rhel-9.4-rust    clang-22
xtensa                  allnoconfig    gcc-16.1.0
xtensa                 allyesconfig    gcc-16.1.0
xtensa      randconfig-001-20260911    gcc-8.5.0
xtensa      randconfig-002-20260911    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
