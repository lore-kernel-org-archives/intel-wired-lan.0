Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D725C624D3
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Sep 2026 18:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E543A40D07;
	Wed,  2 Sep 2026 18:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6JQGMA7rgKd; Wed,  2 Sep 2026 18:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D2CF340D01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788374810;
	b=PEMX84QceH/IXcFFHndQe+sf5fdXnrKEBwXrxrODtnN+McqNLrGKPAQFY82iDWc++QoG
	 9HZHiEL+azO0aFed6A0Mtzweawlo2gPopPfVyhV5PHrskuYPj9bXpoG6z+P7Nae5vZXGU
	 8dqWWOe/aILgoTXLD+73C2/C26ODak2EN8+/FZ/d8TY58ORxfhJvOwZPmJhzc0jVEE2DB
	 IEa152uHW/oXI89A3qZaXjVTvFrYmFeClTSSXgu7TVXyOVTzLSgd0B4z97n+3xe3HbeHa
	 6Oeebk2lHQhVVrvUB/idfF2PtrqExlL2YQkhJyVtHTqanSW9jUQ8PBp8n9gdqas+kBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788374810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZnnNMCGxQss+tkGKtQHdCUq39wS5utNeSBAv9DhBawA=;
	b=Gst7mX+tyH1eIdLXQptueHAbb6tX3i0G84gVtqnN+t0JYuPqgaNtmBExgFLh5FFki8Qy
	 Ma5tvWLro1JASuI1qsFcQ5Kpi8hfJ48hCRVF23plkPYzMtTXQFfvutsELTRLi1nW5QduL
	 t15/pnncZ7CaV4eSgyfk3LSgaoZcuhNOOCJXwqr4gqhCT8P9mNk6dkuqZ7PROvLVUyFkm
	 UaD+uay7iqwJw1LXQuSKGD3Ijh5t/3Aw0ob3t0xg79Leud7QqG6ELEHfgPiA2cr2xMAO1
	 2mXehppC8d3TebrUfbhcZJsfd0RtjChOtxeH/+MZgf8KjEgQOv+KftljwvxJZjIqj2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788374810;
	bh=ZnnNMCGxQss+tkGKtQHdCUq39wS5utNeSBAv9DhBawA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xg0or99V6DzmZCPuyxIRiP52nAGF4484ZeTIsaUi+H4mwtdlwT+kcMRwalLDj8NyB
	 01SjbA5OyfLchvdi0HROrnvsC4udH8cWISRoSTkFH+i20icQoHCgR/6OSfsC5RA2nJ
	 Prqs+81UOI4SDy9Guo4x7cP9Z5d8YhD4mmwmIUaxeFavLkwkJzcvbqFP4J2GHMzWPP
	 bt7fnaZ8pt8wJ5hwYNJx+3o8ST8wyhpcb4+FLoiciKRth0KEs5WXlYLjQt2tqpxdyV
	 4sDRy2qYMqg1x6cOjVjMyTu++zDzVqF2Zr9bygfGPqSDmH7Rdio8Nau8Y+uxL05gvt
	 S5nuNEj+As0IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2CF340D01;
	Wed,  2 Sep 2026 18:46:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26A2F334
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C4F0607FF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gACdbSRXfU5 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Sep 2026 18:46:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 287C3606B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788374809;
 b=sdp6+SRxp6hWf7Va2rPICOOyG4aqsG8X+xP2lIZG98FSej2M0vCbp8T09C9TQDQcMz92
 m7UpP1Fdkie6/9ge3sJ/DJaP9fSi0s91mUOA/XgNNgiZOsBY3kjlbHPQX+EUQZMVwWTrR
 mvLf/xcRPJkPC0hiKNunMuu7SK+/U4+r+/LhnUjoLo3z3/Rsvl908/lkjURXcpmX4JJ8o
 j+HXLdgv1Omf88TF84SOHW8U7wfCIlumcdB+2qodgU007YYDWUVKP2hoHh1RrkYxA3Y4+
 yYbWK1TZl/Bz/OJpXSRwlsr+iUYnXTpBj8IEsPBoKbHPcEmsDmY4RB9jW5s4U/TNqFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788374809;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=ZnnNMCGxQss+tkGKtQHdCUq39wS5utNeSBAv9DhBawA=;
 b=ploblqrNJU4AKk36T3Zrd7wO26lde2WqL/SQ86byWw/aH3Gukwk6QpLo9TrUC04W7lgk
 cKB2B8hBnZDmY6SIXeGWqANGzek2jbTPyN/+UeJN6IMrTTWyuvvkVIuZuJrf2gxcEJStO
 GAnxmKokGxmEjytLhOV2Vf/WU0gAchhjHhwGq7qHh/D89VCx3OkNrevaRbzsy/IM3mB5H
 o2lziFyZSO2O3Wf26OwAd5k8vi0eKb6jE3w7MQy0jzGGtqo8y2UO8kcvsQNOQYvz88sPr
 TljgvXgBIhEKngu/zs+HI94nYgTi0qAry+2AgapYzkCj8PZbP6syuQYDDzTci69FMPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="e9/VkUOq"; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e9/VkUOq
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 287C3606B0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Sep 2026 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788374809; x=1819910809; h=date:from:to:subject:message-id;
 bh=Ly3rxslt5uiQlgpuSHp6WGh9FxHhOq8b2YvnHLfk/3E=;
 b=e9/VkUOqTbbej0F13DGDQ1NuQwWA1PiMaSaZTnYNql0ONKqGxHh0s8rv
 y67xVIno+XLl1P80EteSqMQx6gEqtrh5fXLVLoN1SMgn2x2BEwaw3kQYG
 cv1btQPnYoNdNCStwCaKzZY7bIujUXSg/T86LC2YWVMqwZJUe7ezenJFu
 FfX29sJEnzy1XVcCle1CCRv/U7a2HCAQ2MDA658YVH2CgIJEDPBhdbz0z
 C+S4tUsIRsHoq3fJKAoF0IIAbGunrUrkeFQ8+Q6d2C9FUbmG1dj/dS1mP
 dMeTX/SFgfWYozJyrAo1esoqzguOl0rc6mbVwFF2fBruYJXKaUfxWvTrt Q==;
X-CSE-ConnectionGUID: pH0zABIJTLqsKKOYsE6GJQ==
X-CSE-MsgGUID: Z9r1jQOzSSe03XpmIs1RpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92711532"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="92711532"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 11:46:48 -0700
X-CSE-ConnectionGUID: ksZ2m8kJR5CwhrzOuAWpfg==
X-CSE-MsgGUID: Cr+g9PUiSMq4oX4uqE8s2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="267733510"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 02 Sep 2026 11:46:48 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1pyv-0000000039m-0kzI;
 Wed, 02 Sep 2026 18:46:45 +0000
Date: Thu, 03 Sep 2026 02:45:44 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:40GbE] BUILD SUCCESS
 907bd786209ed8c735db94889386aa48d2409d6a
Message-ID: <202609030238.8uW08DZ2-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 40GbE
branch HEAD: 907bd786209ed8c735db94889386aa48d2409d6a  i40e: Avoid repeating RX filter warning

elapsed time: 1068m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
