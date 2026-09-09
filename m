Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A52C79FB7
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Sep 2026 22:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56172606D9;
	Wed,  9 Sep 2026 22:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2duYh-IY7vEp; Wed,  9 Sep 2026 22:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6668060702
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788993099;
	b=Qu9IFsMfD5WhwUvM8k8RdQUTcQPkhygZf6rPpf5is5/91eMiAkZ/wurqDgTm6OFq5Lko
	 Ne7Z+o5KPXt2dIbqBkC5DFhw43/HpHhvxCKaVRXGJf+tytdqNyycsFwhg3c8R32Q1wB9p
	 OvB9xQ4aMXiDu7z1ytaMm5VPHd7BrXzsQuFZQ9t4mtb/NqedjAkoQSVRO5Rwo4QyspjYQ
	 xrcAORHlCEGx/Sosh1R3j7Femt6RjHnd9zDfx8TTZ7YujRKUeRqrahVTpzaD5jfP9Y/2i
	 NRazCVb4vhKQ22/w5OgEDUtdYCiHyHmkY4z4HHW3EVVDGDgKlwkDMDt6WsM/soNoYfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788993099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ixj4Od8oUSNm0ZEDHUjHx88Z7T/eddPmcQpXM8060io=;
	b=Heno1DLbKt/uo+YZpyGuEPlzPqEAsxphmkf98Fkmqa2SfDr06mfRQYWZ2a/aTE0efHVp
	 4yp7J9qFKpYqH8uWVVoDep+q9kQyqOdN03Y51DHoSv4hg4CANzSslSU3oK3f+TQqd4s1M
	 ugcu0aKFcHDHHbcwoKjPKSyrAIimgYleHNFP3zuKRR4f20FXtxKvtYTO2KQJtBD72WyvA
	 CPTAvmdxwIrSNq0bv5Edj9ivgX0PsBd+J3Hu67yeWo2urIkbtZfwt04jX6S8csxY7arqk
	 Z8PvFpsUy0XiAP8yW4bdS8998vVTS9ga/7jvDt6mVXMfJxFmoYGSyrP3qvkZT5yJ2TA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iv6P0mZl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788993099;
	bh=Ixj4Od8oUSNm0ZEDHUjHx88Z7T/eddPmcQpXM8060io=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=v6i/zcPM3r45DR/pko3uX+OGR7oyVuchaFDItsvGFUn7JV8Yg9Sb+4i9gBUKDqJLC
	 ecLpjzTcAMgkge5cAxhC3qfQ/XErIFOMkYFqYXm6vfJxPMaZNhHiD3etFzAN0yUOTJ
	 q018zQk20WfaJX7WWzcxmxKPgtf8OGhzOPklYtbEVzuoY84Bs8jlf+s2F8kAfHKfo4
	 wlXlq5QdbxiUEFq1XsZkO2zjdUX+7LZQc6dCb1WaXFP1mIIc8XsZ8h45dG1YpRfM0/
	 gFjoor0r9q7AcUylc50MegzMqHlgAfNJZr/WdbUbId4DwlGaB+0k0kAY/DlnwzA9Xh
	 jzQKaRkjNQjpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6668060702;
	Wed,  9 Sep 2026 22:31:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32ACA362
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 22:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2475F60702
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 22:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id keWJ8mh2OWoO for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Sep 2026 22:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C600606D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788993097;
 b=hVRgWxTJlhQT2DQ1mkA2KzvhHYSCSMzACdWmp3DBJYSzLk8QIr/RgaZp18Dcb6gTFuoj
 TWO2PyIRGLOPXkQBVWELUvpA6QJthnvdyK1BfL/XUyVAjy4NZRvRhU/ppdhBNfG3iwnEy
 /k4c9e3Ayf1keoB7SSzd7HPunmS6Vf5NGtSLbtH4wLBgvOt5/M2DsQiDXL/2Qb5VTjeOp
 zy8VQfky/zIIFgm/0EaDj4te0FRgR2N/Ugya3cbtQ6FeNJ7hKzpVrJavS0rRcLd+CMjSO
 lf0KvYhpYVsfepZZjYcl2DVrn1JTmX3zYKe/VtbjPjC6E03dYC3uhk3x8JmTdyEY+YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788993097;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=Ixj4Od8oUSNm0ZEDHUjHx88Z7T/eddPmcQpXM8060io=;
 b=J/RKmD+tIWcA1Noi8LOOgVeKD+7CezcxquvVaAwHFsr662UqGSSdDboZa8FMETGE8s+m
 TYBZ2E40YMBc3NEMirwmbQTUyGuSzcYqprWaGEzKtfvcO5eioiQB9D88NOxZjBVqUSQop
 lWJ/xQ1iH1f6j+xyGVJUomHCOvMb+0iVdtiMHbexIMKAzLgQYarne8jtttLKCLfowO0qJ
 doF93Qm5t4bK2juFkFkMNzVFdRxa1nnYS+TZ6k+y2CggXRqEtT0RT79z/dHlf9vyneD6D
 eusqZMQSBcti7mQ6qeGHo0Nh+rMVJlaWUO4rmLLQjqZPAsgr8/r77MuXMNwyynomlIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iv6P0mZl; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iv6P0mZl
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C600606D9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Sep 2026 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788993097; x=1820529097; h=date:from:to:subject:message-id;
 bh=624J3rI67P+Thme1nlapAn9yOlnvUZZm14vlO5gcko4=;
 b=iv6P0mZlAZ7BWb3y+44cqUq+yfvkjlbzagDSGFsEVXd9lMJfgU5PvCDL
 Vilr99xIYiWKSUfkQcBSB1oDtgzIpox3IRkJadhTeXSfWE+bB3c3O2PBK
 FyZVnvsMgZ5McH/0ikn4wpQEt1Etm1p7xBHTXy2aB/uImAGylvy3N8tKq
 vovzMT2/Xx4PE4S0wUTGqMMltwph9blFWV5Gj9UwW8wy43VeZeaF+dOyu
 Qn1ZcPnuhE4xXwpcSPLCxh2ydE4L/MTEGB211JvIus7reer82py9/GvTr
 Iwng4a3iCuaioI301o7cet6STLwpoqJLUB6wcN9BFngB0ASShsq/rh9ya Q==;
X-CSE-ConnectionGUID: MPy/q+PmTfiEOLpgGoOlig==
X-CSE-MsgGUID: Oglt8mLgSs6CWHOLRt7nig==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93258066"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="93258066"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 15:31:35 -0700
X-CSE-ConnectionGUID: uA2ensoSS9qwrQ+9OikEmA==
X-CSE-MsgGUID: VqlWKTPVR0+3X7Zrbs62HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="275224185"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 09 Sep 2026 15:31:35 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x4QpI-0000000010U-2xRz;
 Wed, 09 Sep 2026 22:31:32 +0000
Date: Thu, 10 Sep 2026 06:31:02 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:200GbE] BUILD SUCCESS
 b8bf9bfda5f62e11444e483c2b4aaff90c5cfc6b
Message-ID: <202609100658.UCjzGp3N-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 200GbE
branch HEAD: b8bf9bfda5f62e11444e483c2b4aaff90c5cfc6b  eth: ice: don't dereference pointers from TP_printk()

elapsed time: 1478m

configs tested: 50
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.1.0
alpha       allyesconfig    gcc-16.1.0
arc         allmodconfig    gcc-16.1.0
arc          allnoconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm          allnoconfig    clang-17
arm         allyesconfig    gcc-16.1.0
arm64       allmodconfig    clang-24
arm64        allnoconfig    gcc-16.1.0
csky        allmodconfig    gcc-16.1.0
csky         allnoconfig    gcc-16.1.0
hexagon     allmodconfig    clang-24
hexagon      allnoconfig    clang-24
i386         allnoconfig    gcc-14
loongarch   allmodconfig    clang-19
loongarch    allnoconfig    clang-20
m68k        allmodconfig    gcc-16.1.0
m68k         allnoconfig    gcc-16.1.0
m68k        allyesconfig    gcc-16.1.0
microblaze   allnoconfig    gcc-16.1.0
microblaze  allyesconfig    gcc-16.1.0
mips        allmodconfig    gcc-16.1.0
mips         allnoconfig    gcc-16.1.0
mips        allyesconfig    gcc-16.1.0
nios2       allmodconfig    gcc-11.5.0
nios2        allnoconfig    gcc-11.5.0
openrisc    allmodconfig    gcc-16.1.0
openrisc     allnoconfig    gcc-16.1.0
parisc      allmodconfig    gcc-16.1.0
parisc       allnoconfig    gcc-16.1.0
parisc      allyesconfig    gcc-16.1.0
powerpc     allmodconfig    gcc-16.1.0
powerpc      allnoconfig    gcc-16.1.0
riscv       allmodconfig    clang-24
riscv        allnoconfig    gcc-16.1.0
riscv       allyesconfig    clang-24
s390        allmodconfig    clang-24
s390         allnoconfig    clang-24
s390        allyesconfig    gcc-16.1.0
sh          allmodconfig    gcc-16.1.0
sh           allnoconfig    gcc-16.1.0
sh          allyesconfig    gcc-16.1.0
sparc        allnoconfig    gcc-16.1.0
sparc64     allmodconfig    clang-20
um          allmodconfig    clang-17
um           allnoconfig    clang-17
um          allyesconfig    gcc-14
x86_64       allnoconfig    clang-22
xtensa       allnoconfig    gcc-16.1.0
xtensa      allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
