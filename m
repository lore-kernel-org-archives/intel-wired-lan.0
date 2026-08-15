Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0543EC5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Aug 2026 23:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 901D360649;
	Sat, 15 Aug 2026 23:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tkv_fgKHhWLa; Sat, 15 Aug 2026 23:58:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFDEF60612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786838296;
	bh=hnSJnY40BEfwJ/tZNpi2zWhHek9HEnxGHuoJ5hIPZbg=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B9iC3tDdHPIEhWsM4AAA0/IuAdByKLvLnScufxYzCIRWD2ltcCI676MoMb9TsepZA
	 Drt8sqxGx3sVNBj+q8si1cSYZOLmY2eM5aEBuIJnTHSzcvw5RfTAPQw6lvRFwHIiH1
	 bTtV8X30AuP9nocRlxOejnHDwFnwkEwmQTssi1EKh7j88BH1qlEX4O/hSsg7JVBU3f
	 V7RYJ/5XkEyzxtAK6l5uPK4MFVwtfHckgssFd6SHUK31jClfaq8c1RxoDQIvlhQHrV
	 ucL2VWdVpcL+lQGqvfFEdv+2s9L9FtLRbPBIygjkbw0yhxHo49t+eiY4zZWXI+oXE1
	 0f9BW+Y815D1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFDEF60612;
	Sat, 15 Aug 2026 23:58:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EAA3109
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 23:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74CFB60612
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 23:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azL0ddeWEuj3 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Aug 2026 23:58:14 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 850AC60607
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 850AC60607
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SRDV6Q+3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 850AC60607
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Aug 2026 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786838295; x=1818374295; h=date:from:to:subject:message-id;
 bh=ObF/VmhJ5I++/bM8DzU9KJumvO57AdV5wJPjcxvwHDU=;
 b=SRDV6Q+386+kSXjSWSgdSssv888IS8xh/snORuPl8bGaA/jGsOKqmE3f
 ov5b51DaMI936x9VRqLpJG9QcISxhDijnFk4WxRSQ1aUZbyZiG4lJQedE
 +EaFlDre/38krPJ2Z100jeKNvF3Oe+jTXL+zoHkxmoqdQuwnXPHRaZpS1
 P6S4Lco2VzUxzqeokM2crs/ZwqtvYqU57pFC6qKtbK8dFmMrq0gSrEzpW
 WoquzYMafMeQVJ3ZtwpOFNGUQ+7IkHJfOax+qMYrgoiTlmZMU44OkSdiH
 C3CNv3KGjvU1RgyL2XIBsMqc6iKoAVm92FSV332bBw6YVX811LBhMle4M g==;
X-CSE-ConnectionGUID: 7mQf6/gET1GNHWDSIMqdDg==
X-CSE-MsgGUID: 7WSNVov+SUSt5oN+iHPcXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87286821"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="87286821"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2026 16:58:14 -0700
X-CSE-ConnectionGUID: 9X3t8rYYReKBc+CMp2mhIA==
X-CSE-MsgGUID: vB9g2UCGR/+VPMcmztx5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="261910034"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 15 Aug 2026 16:58:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wvOGQ-00000000cX6-17WF;
 Sat, 15 Aug 2026 23:58:10 +0000
Date: Sun, 16 Aug 2026 07:57:42 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202608160730.tzR7inrR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 e6a5d573d24cd375e09d24f136523cb3cc85c9d3
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: e6a5d573d24cd375e09d24f136523cb3cc85c9d3  net: dsa: drop explicit NULL comparisons

elapsed time: 770m

configs tested: 18
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha              allnoconfig    gcc-16.1.0
alpha             allyesconfig    gcc-16.1.0
alpha                defconfig    gcc-16.1.0
arc               allmodconfig    gcc-16.1.0
arc               allyesconfig    gcc-16.1.0
arm           ixp4xx_defconfig    gcc-16.1.0
arm        versatile_defconfig    gcc-16.1.0
csky              allmodconfig    gcc-16.1.0
i386              allmodconfig    gcc-14
loongarch            defconfig    clang-24
m68k         stmark2_defconfig    gcc-16.1.0
nios2             allmodconfig    gcc-11.5.0
nios2              allnoconfig    gcc-11.5.0
parisc            allmodconfig    gcc-16.1.0
parisc            allyesconfig    gcc-16.1.0
parisc               defconfig    gcc-16.1.0
sh                   defconfig    gcc-16.1.0
x86_64            rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
