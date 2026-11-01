Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70032606A324
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Nov 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nKQz8ScK;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fovW9W65
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49CCE6065A;
	Sun,  1 Nov 2026 18:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_dWu7PU2Kq0; Sun,  1 Nov 2026 18:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 110C260619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793556594;
	b=VNddkc1KJ/IAH0OZcAtVPA+ZZveyIc0URJ0mwl9zjo8SS0jLrj4VV77EYRYz1wWXtoAC
	 K33AWG1Dz5+D3fRAWyXYh6IdeasuNN5luzwoFMjRRdq5TTGaSyjt7/uHX3u8jLFesoKr+
	 ddNim4Ymmc7KwvFJgi8oIpL9cqF8UO+MVmQRR5rguUV196x0OCgamWdaBkWFjbihSa2Mi
	 d+iFeI3nNV8fzySGdRzorupg1E0uIrAApHjitzDlyG9cVRE7q+FznSIGI30XyMH1B3NX7
	 3/soL2ov66p2VN9xtR7sGNfDUZPZ9OdU/CIbOC2JlRejrPKyd3LQe3MkfVpwIU0Wpbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793556594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JzgNYUeQpVWlWfLoD/d6lzaSWFQV2atgXPL0whU0/Ps=;
	b=VShyw6PsWzgJKWiZnxrYY27e0npxkfMZamy8F2xcz8dj+dJlJa5a2sqojTaA8Hqa7qKH
	 bi9B8l5IwxLGJn5vEoIltN4vn1Qt0pUU9Y9nLJQ1uvaWwrlkF2y4sLNcTb8YDPTQeRjT6
	 fEFljS1fg+bgwk5p20vPRzmX4qtw+0B2qhwOQQxZtsRT/1iDbDJjg/ahYkLprHnFE26K7
	 hClu1MZTGLRJpAD7DiCd1BkTVu6DtMz+ppICGiM3TYvXA5vWt//rWqjRHZKvF0VSrVY6+
	 R80F+AWI8RPaZEe7A+6WeSD9pnIiY5ONiVa/PO9yVxSvvz7XSNaVWrY7buhZEnbaKNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793556594;
	bh=JzgNYUeQpVWlWfLoD/d6lzaSWFQV2atgXPL0whU0/Ps=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nKQz8ScK6dVA3G3gniJyi5XJOSn/aFUw9npIkN3qBl2BePNVtek4inN3NI6uhheHO
	 dwKmzGE3aJg7cgII3q2Ip0f590dHoIkPeJ38k0mgU9uPRicsF3mG8tgCFnPHPp3Ckr
	 Nxh3qLkKXuUxKwfWWKkoWYSJLDdDB+WND+ZmsLxhVwjTjKQLU8SHmimAI33iGThHs/
	 jx+CyQJaaEBfuyhfOBSWQoSQfPhtTayshxLDsBQsocGQt1lYAC2Js9a9clDfQs1oGa
	 iZJXluIOAhIC01s0XsxYnhm7lW+MFR2i/hF/5kAyQv6nkfMGS/f4X2B51mzSCS7vWu
	 MF96nOpfwp7kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 110C260619;
	Sun,  1 Nov 2026 18:09:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33F1DEF5
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 18:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25D7480CBF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 18:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YeTHF07sTYfZ for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Nov 2026 18:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EDBE580CEA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793556591;
 b=mrcUrD7qo8GzNvZmWCK6x0Oj+gUEW46OdHZcxnG7Guj2LZvU9sDwgYNQj/gZORB//M+t
 ngzy4fUgI0kELygdvXzvn3iRm7aFJlW5hwlyCH4xoi9ICPlKsqHi/KAk/sRM+3UIMduu4
 W/PXFca523rjJ7ydGAb3e6WrNIjQKELLiAs6VtoHOmjamnRdfcbfY31feOz31V2H9sW8i
 HuWu5kPJjq/vCKHEy8QZutxlwp41zE/MLdjSMOKA6Vtk+nft8B8/NGcOW/NlV09qKr1kn
 Zq6rDpF0VMHs4J9JSkvzgvRa5od8yMPza+jXDuARIsaQi7stRyJ39OzPTqk51JCJZBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793556591;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=JzgNYUeQpVWlWfLoD/d6lzaSWFQV2atgXPL0whU0/Ps=;
 b=T3vv/Yo4clDoUCpgLESYauOubwaTDXSQmu/L0xAnaHNs+ddJQqzbJ1jH0Hhb22qamb6R
 8fLy9924tf9qUn7V4OJg9n8LkSLlXonfe3UyZQGsODoor8AWZx47d30eDju7D1yolDaWs
 RuLWa/e0H1OvNmEmFGUdpl6cDCCqwl06JXpcj94+d2Ez9Rp6APYSP+W8240PkXYJ9RF2K
 QxByCA122FS2mXFOBTeuZ0bRZh9fk4VEbnh2o9Cgm+w3kaTX+sxVrXXKhFiHIltR5t1ME
 MWLZXZluoPMrETVVytylkqw6sR/Q/s7Vm6s+cNViDAGdxRIbZQDk13XVPo16uRZXIUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fovW9W65; 
 arc=none smtp.remote-ip=198.175.65.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fovW9W65
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDBE580CEA
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793556591; x=1825092591; h=date:from:to:subject:message-id;
 bh=jLSLv8pQMv7efyf2whYBL9IhvIVjjPx5aBTA26rbuMI=;
 b=fovW9W65uD92s+0yXRPBt4XML79sJZ/CaOkIeYaINabiwktVroCcoZ5I
 mkB15DqXG/WBJrd1hIQp8L7waOYK1R4JzCQbVwz25KlGcEvJMmZUBNlJJ
 JvQ7YblZmzDMc4jbUYYAY81MP/cRSqwIc0TX6FhbzvLxuGHPp5AH3ZfVr
 cbqiaaJdovFtJB4JALeMEFuYcAL4XaGXhN0VhBAgqSNSs3mYUoO0vEX/K
 I939toJdsqKPGxSoNWzARmvKOspe472yddAunPq/P2d/rI+HyxLrCKmLr
 4KAv7BNAWza99fjLPb6XtMcug4BwXHn1uqR/ll5DcBXnPyYA8vHYgXRdH Q==;
X-CSE-ConnectionGUID: jKu+D5zpScuBJlyDQzcnAA==
X-CSE-MsgGUID: AZ+f2qxCRlKtGr5X7HbuUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2127316"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2127316"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 10:09:49 -0800
X-CSE-ConnectionGUID: 6aSTp3KKTNWIkAJiyKFaQQ==
X-CSE-MsgGUID: e1Ox1pQDSGK3OCbR6wTjtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="6243755"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 01 Nov 2026 10:09:47 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xNa01-00000000ew1-1u5w;
 Sun, 01 Nov 2026 18:09:45 +0000
Date: Mon, 02 Nov 2026 02:09:15 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:10GbE] BUILD SUCCESS
 dc4dd12f80e499dc034710cd8195489abcf0b059
Message-ID: <20261102020915.9DAVFzsm-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: dc4dd12f80e499dc034710cd8195489abcf0b059  net/packet: check TX_RING fragments before memory accounting

elapsed time: 3852m

configs tested: 282
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261031    gcc-9.5.0
arc                   randconfig-1000-20261101    clang-22
arc                   randconfig-1001-20261031    gcc-9.5.0
arc                   randconfig-1001-20261101    clang-22
arc                            tb10x_defconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                           collie_defconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                           gemini_defconfig    gcc-16.2.0
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                         mvebu_v5_defconfig    clang-17
arm                           pxa168_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261031    gcc-9.5.0
arm                   randconfig-1000-20261101    clang-22
arm                   randconfig-1001-20261031    gcc-9.5.0
arm                   randconfig-1001-20261101    clang-22
arm                   randconfig-1002-20261031    gcc-9.5.0
arm                   randconfig-1002-20261101    clang-22
arm                   randconfig-1003-20261031    gcc-9.5.0
arm                   randconfig-1003-20261101    clang-22
arm                              rpc_defconfig    gcc-16.2.0
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261031    clang-24
arm64                 randconfig-1000-20261101    clang-22
arm64                 randconfig-1001-20261031    clang-24
arm64                 randconfig-1001-20261101    clang-22
arm64                 randconfig-1002-20261031    clang-24
arm64                 randconfig-1002-20261101    clang-22
arm64                 randconfig-1003-20261031    clang-24
arm64                 randconfig-1003-20261101    clang-22
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261031    clang-24
csky                  randconfig-1000-20261101    clang-22
csky                  randconfig-1001-20261031    clang-24
csky                  randconfig-1001-20261101    clang-22
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261031    gcc-11.5.0
hexagon               randconfig-1000-20261101    gcc-16.2.0
hexagon               randconfig-1001-20261031    gcc-11.5.0
hexagon               randconfig-1001-20261101    gcc-16.2.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261031    clang-22
i386        buildonly-randconfig-1000-20261101    gcc-14
i386        buildonly-randconfig-1001-20261031    clang-22
i386        buildonly-randconfig-1001-20261101    gcc-14
i386        buildonly-randconfig-1002-20261031    clang-22
i386        buildonly-randconfig-1002-20261101    gcc-14
i386        buildonly-randconfig-1003-20261031    clang-22
i386        buildonly-randconfig-1003-20261101    gcc-14
i386        buildonly-randconfig-1004-20261031    clang-22
i386        buildonly-randconfig-1004-20261101    gcc-14
i386        buildonly-randconfig-1005-20261031    clang-22
i386        buildonly-randconfig-1005-20261101    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261031    clang-22
i386                  randconfig-1000-20261101    gcc-14
i386                  randconfig-1001-20261031    clang-22
i386                  randconfig-1001-20261101    gcc-14
i386                  randconfig-1002-20261031    clang-22
i386                  randconfig-1002-20261101    gcc-14
i386                  randconfig-1003-20261031    clang-22
i386                  randconfig-1003-20261101    gcc-14
i386                  randconfig-1004-20261031    clang-22
i386                  randconfig-1004-20261101    gcc-14
i386                  randconfig-1005-20261031    clang-22
i386                  randconfig-1005-20261101    gcc-14
i386                  randconfig-1006-20261031    clang-22
i386                  randconfig-1006-20261101    gcc-14
i386                  randconfig-1007-20261031    gcc-14
i386                  randconfig-1007-20261101    clang-22
i386                  randconfig-1008-20261031    gcc-14
i386                  randconfig-1008-20261101    clang-22
i386                  randconfig-1009-20261031    gcc-14
i386                  randconfig-1009-20261101    clang-22
i386                  randconfig-1010-20261031    gcc-14
i386                  randconfig-1010-20261101    clang-22
i386                  randconfig-1011-20261031    gcc-14
i386                  randconfig-1011-20261101    clang-22
i386                  randconfig-1012-20261031    gcc-14
i386                  randconfig-1012-20261101    clang-22
i386                  randconfig-1013-20261031    gcc-14
i386                  randconfig-1013-20261101    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261031    gcc-11.5.0
loongarch             randconfig-1000-20261101    gcc-16.2.0
loongarch             randconfig-1001-20261031    gcc-11.5.0
loongarch             randconfig-1001-20261101    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                          amcore_defconfig    gcc-16.2.0
m68k                           amiga_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-17
m68k                         m5307c3_defconfig    clang-17
m68k                       m54418evb_defconfig    clang-17
m68k                            virt_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          bigsur_defconfig    gcc-16.2.0
mips                  decstation_r4k_defconfig    gcc-16.2.0
mips                      loongson2k_defconfig    gcc-16.2.0
mips                       maltaaprp_defconfig    clang-17
mips                         maltaup_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261031    gcc-11.5.0
nios2                 randconfig-1000-20261101    gcc-16.2.0
nios2                 randconfig-1001-20261031    gcc-11.5.0
nios2                 randconfig-1001-20261101    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261031    gcc-13.5.0
parisc                randconfig-1000-20261101    gcc-8.5.0
parisc                randconfig-1001-20261031    gcc-13.5.0
parisc                randconfig-1001-20261101    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.2.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.2.0
powerpc                           g5_defconfig    gcc-16.2.0
powerpc                     ge_imp3a_defconfig    gcc-16.2.0
powerpc                        holly_defconfig    clang-17
powerpc                       pcm030_defconfig    clang-17
powerpc               randconfig-1000-20261031    gcc-13.5.0
powerpc               randconfig-1000-20261101    gcc-8.5.0
powerpc               randconfig-1001-20261031    gcc-13.5.0
powerpc               randconfig-1001-20261101    gcc-8.5.0
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261031    gcc-13.5.0
powerpc64             randconfig-1000-20261101    gcc-8.5.0
powerpc64             randconfig-1001-20261031    gcc-13.5.0
powerpc64             randconfig-1001-20261101    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261031    gcc-8.5.0
riscv                 randconfig-1000-20261101    gcc-8.5.0
riscv                 randconfig-1001-20261031    gcc-8.5.0
riscv                 randconfig-1001-20261101    gcc-8.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261031    gcc-8.5.0
s390                  randconfig-1000-20261101    gcc-8.5.0
s390                  randconfig-1001-20261031    gcc-8.5.0
s390                  randconfig-1001-20261101    gcc-8.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                          ecovec24_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261031    gcc-8.5.0
sh                    randconfig-1000-20261101    gcc-8.5.0
sh                    randconfig-1001-20261031    gcc-8.5.0
sh                    randconfig-1001-20261101    gcc-8.5.0
sh                           urquell_defconfig    clang-17
sh                           urquell_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261031    gcc-11.5.0
sparc                 randconfig-1000-20261101    gcc-8.5.0
sparc                 randconfig-1001-20261031    gcc-11.5.0
sparc                 randconfig-1001-20261101    gcc-8.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261031    gcc-11.5.0
sparc64               randconfig-1000-20261101    gcc-8.5.0
sparc64               randconfig-1001-20261031    gcc-11.5.0
sparc64               randconfig-1001-20261101    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261031    gcc-11.5.0
um                    randconfig-1000-20261101    gcc-8.5.0
um                    randconfig-1001-20261031    gcc-11.5.0
um                    randconfig-1001-20261101    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261031    clang-22
x86_64      buildonly-randconfig-1000-20261101    clang-22
x86_64      buildonly-randconfig-1001-20261031    clang-22
x86_64      buildonly-randconfig-1001-20261101    clang-22
x86_64      buildonly-randconfig-1002-20261031    clang-22
x86_64      buildonly-randconfig-1002-20261101    clang-22
x86_64      buildonly-randconfig-1003-20261031    clang-22
x86_64      buildonly-randconfig-1003-20261101    clang-22
x86_64      buildonly-randconfig-1004-20261031    clang-22
x86_64      buildonly-randconfig-1004-20261101    clang-22
x86_64      buildonly-randconfig-1005-20261031    clang-22
x86_64      buildonly-randconfig-1005-20261101    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261031    gcc-14
x86_64                randconfig-1000-20261101    gcc-14
x86_64                randconfig-1001-20261031    gcc-14
x86_64                randconfig-1001-20261101    gcc-14
x86_64                randconfig-1002-20261031    gcc-14
x86_64                randconfig-1002-20261101    gcc-14
x86_64                randconfig-1003-20261031    gcc-14
x86_64                randconfig-1003-20261101    gcc-14
x86_64                randconfig-1004-20261031    gcc-14
x86_64                randconfig-1004-20261101    gcc-14
x86_64                randconfig-1005-20261031    gcc-14
x86_64                randconfig-1005-20261101    gcc-14
x86_64                randconfig-1006-20261031    clang-22
x86_64                randconfig-1006-20261101    clang-22
x86_64                randconfig-1007-20261031    clang-22
x86_64                randconfig-1007-20261101    clang-22
x86_64                randconfig-1008-20261031    clang-22
x86_64                randconfig-1008-20261101    clang-22
x86_64                randconfig-1009-20261031    clang-22
x86_64                randconfig-1009-20261101    clang-22
x86_64                randconfig-1010-20261031    clang-22
x86_64                randconfig-1010-20261101    clang-22
x86_64                randconfig-1011-20261031    clang-22
x86_64                randconfig-1011-20261101    clang-22
x86_64                randconfig-1012-20261031    gcc-14
x86_64                randconfig-1012-20261101    gcc-14
x86_64                randconfig-1013-20261031    gcc-14
x86_64                randconfig-1013-20261101    gcc-14
x86_64                randconfig-1014-20261031    gcc-14
x86_64                randconfig-1014-20261101    gcc-14
x86_64                randconfig-1015-20261031    gcc-14
x86_64                randconfig-1015-20261101    gcc-14
x86_64                randconfig-1016-20261031    gcc-14
x86_64                randconfig-1016-20261101    gcc-14
x86_64                randconfig-1017-20261031    gcc-14
x86_64                randconfig-1017-20261101    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261031    gcc-11.5.0
xtensa                randconfig-1000-20261101    gcc-8.5.0
xtensa                randconfig-1001-20261031    gcc-11.5.0
xtensa                randconfig-1001-20261101    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
