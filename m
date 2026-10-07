Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028D0CA6007
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 09:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A69B7605B1;
	Wed,  7 Oct 2026 09:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4ejEQBW6GPM; Wed,  7 Oct 2026 09:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2C166062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791364661;
	b=N1O0DdhPDGEXoyNCQpa6sK+FObP9poNuO0pFjMiCaxslgC4tQxK2m+GkKxBi0vb4/yEg
	 8FKTY7cNrsszZw+ar+/thWVdepVC9VUUh1RzLiBLUZ9pX6pCKCIT9EkBSU3dxkpkvkcgt
	 ft2dX3GKRUuNpLXKRcY222RFMubiLcdrJpXzMOZimNo6GvFi41S3tmZGSGYvDgMMSbhZp
	 Sl8sAJUJkq6MfCh0dl1FzDCghkYGllRhJmfdz9UUU8jptJC4V2DrljU0IMlSIrFA48EVT
	 YfVvGxLcnU8Kkc+tG/tMv5JnQfbPDHqrYELesdoYBA8XUPbgQdaLYk86u2T5/dly7+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791364661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oxJNH465Idar04pxvEigRP5AYvvYL9yUwGW8fJtliQw=;
	b=VdftY0xVz/fWgGu79oDP2GdyCw/HnY1Z/hkAc8EFCrlbtgrHi2DEwG/JHjHIRelBRs25
	 SgqIqVVHtmxrpx2YJKgnR3kTxVnC1rqDWYjFFhhsxlJm8U1A8dN4AzCSRgPRW6cpzi4qP
	 IkcM4oSAxodtfrHfrt335VfiBd1zwnYOLwUKRHmSFyianH0VabdLqm9xrQvrxOY6fRc3i
	 xUVBnk+cjz5y7unRz3K4FqTwVCYg9NerclpV1B4xvxw9rTLDZCHLvkFArgdXwHuvAbv6b
	 +BrYfdRkGzZWYe5kKweJDMwZXN28/Zy2d3w4avynCrgQxXIBg5aMSIxUKOVsaMtyPyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791364661;
	bh=oxJNH465Idar04pxvEigRP5AYvvYL9yUwGW8fJtliQw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=edve2lWNWTIiic8YG57cQfJEe7QCwXaAFnqVrcCcSdDhV5YjySdCeWJsbwVLagTAj
	 F3ynD8CxTX9kKAxJKJo2rDmDzsZ0SsJsjqN7Cb4cso1NH95G1xIplipBhw2Mx55YnV
	 +lh4HZJamd5VigsIh7bAjRYfBUsrP0pycpbdMQkAUPa9WgZ1KI+BmV66IQSo4/UK9Y
	 benn4HY/BGhwtbzSEgh3YuARHG7khlht1FRgkCROiIvVte/XYHfnLt5FyiwEUP6v1P
	 I+1S3CQk+YUSFt6rXfbw6d3kvcHAyrrtEQs2W2Sbs5bXhsekWXv3rEU5AFFVLPr+PY
	 ndIBriZWWqDmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2C166062C;
	Wed,  7 Oct 2026 09:17:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 500CC1D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 09:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37B7A80ED9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 09:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GJkksdv5Yay for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 09:16:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AFE2C80E33
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791364563;
 b=CuYBE85nuutqV4MyMOwKeL69TWEJ/R5yvuc5wC9y6md5xUqC8ijQvDQEfTlc0gP89o4Y
 jJOuHFjWnK0oKE3WPZ6cBRRJzHsdqsdnPb9YyngmXJIP/Ye4+D3DFModJ1GeaEpuiJk6Q
 oowj3VHbpUdTbQrqvWU8bUr5BsOiTfKQfgsPCpjK7c/wAT+1aO8+YkqKMV354lCzURsQO
 7rF0BmYrPTdAyWnHGd3ImwTtepjOHDemgmZbtYfS4n+49YDwH90VwXIUSPDMy90KDh0eH
 yK7C7momFPeUgaA+dVHS1dnp62R7ExODh9itqlE8ts3/HhLCXGeexGtiaHhdswEz5/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791364563;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Subject:Message-ID:User-Agent;
 bh=oxJNH465Idar04pxvEigRP5AYvvYL9yUwGW8fJtliQw=;
 b=dh3BLvjzTheq43RI/HQU454K93gdkmHEIfn61CHwQ54gxmues/fYPEs/dV/AKPE+TzhF
 sAD0+32x6Jt54lT6UdF9Rtbzbf2Phfd3mQ1Erh/+w8+8E9/FyqAfdZL9gzHCqy7bb7zOo
 OimcJSFCo7sbT2L4W5iNYgm7bWPewqaGwj+VtoRY3FVKn/Btcu2+5sppVc/QvPT0DXsXB
 uzW83UYCPK2YkIIeTMKXt46o3fTUZJWxE/B3CMiQp9LtIhDCJwvicrhIJq+hucOo5cL/Y
 MaatGGiqExLx+BtUrzjISfNucLU9vvcraIhF8Y75JixPbQDpHhpeqyPvyo4b8GI3iXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KY6TkkrL; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KY6TkkrL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFE2C80E33
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791364563; x=1822900563; h=date:from:to:subject:message-id;
 bh=Agbxmbpvg2qbKwRNYjWfzklU58oqJlZFM/hnBnqRexI=;
 b=KY6TkkrLBPevb6ilSRWqVb9d1MWShMHzWcXIkvU3ZsnpVrX7kdexAb+r
 VKxD+thcFRC7Hb+AwX5OAr1NgX1EzplrPO0t+mrZYn3XC88NaqdJDghwr
 E3flvqal0StvS0amudmq0eFzAX9HEMkARio1j9LtN3+qG23qIiBYXooCl
 hLdqCTy0bs/LhMCv7SkpWxNnpqThCpWnt4lMP48Pbp99kcEPXoeEfO/cH
 4aZ1z4RB5aeS8S/uWdShfZtzfLkWYo4dEP8JMIBrkaO4QnunaMXwH3zhZ
 f0VH6/2fxaHVtTaOrjjBdETPogEulEcDvSNBqt9ttXdAFF0UAC8F8OtTc Q==;
X-CSE-ConnectionGUID: galTlijSTKeK+K+Y8Pz9ow==
X-CSE-MsgGUID: wHs6POi7Q6+ZCiM+ZgyKVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117264"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="117264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:16:02 -0700
X-CSE-ConnectionGUID: UjhBZDy4QvWCdqTCNLAKNA==
X-CSE-MsgGUID: 6D0jGAmSTLWaQLG+h1wDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="277516187"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 07 Oct 2026 02:16:02 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xENkl-000000002k0-1Emj;
 Wed, 07 Oct 2026 09:15:59 +0000
Date: Wed, 07 Oct 2026 17:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:main] BUILD SUCCESS
 a5e7d8e446af9803e37a3b6a4d416fb41178348f
Message-ID: <202610071758.Q350V4gc-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git main
branch HEAD: a5e7d8e446af9803e37a3b6a4d416fb41178348f  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue

elapsed time: 1208m

configs tested: 618
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20261006    gcc-9.5.0  cocci
alpha                randconfig-r2103-20261006    gcc-8.5.0  cocci
alpha                randconfig-r2104-20261007    gcc-10.5.0 cocci
alpha                randconfig-r2200-20261006    gcc-14.3.0 smatch
alpha                randconfig-r2201-20261006    gcc-8.5.0  smatch
alpha                randconfig-r2202-20261007    gcc-8.5.0  smatch
alpha                randconfig-r2302-20261007    clang-24   sparse
alpha                randconfig-r2304-20261006    gcc-10.5.0 sparse
alpha                randconfig-r2305-20261007    clang-17   sparse
alpha                randconfig-r2306-20261007    clang-24   sparse
alpha                randconfig-r2307-20261006    clang-19   sparse
alpha                randconfig-r2308-20261006    clang-19   sparse
alpha                randconfig-r2309-20261006    clang-24   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                  nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261007    clang-24
arc                   randconfig-1001-20261007    clang-24
arc                  randconfig-r2100-20261007    clang-20   cocci
arc                  randconfig-r2102-20261007    gcc-10.5.0 cocci
arc                  randconfig-r2103-20261007    gcc-11.5.0 cocci
arc                  randconfig-r2105-20261006    gcc-14.3.0 cocci
arc                  randconfig-r2107-20261007    gcc-10.5.0 cocci
arc                  randconfig-r2107-20261007    gcc-8.5.0  cocci
arc                  randconfig-r2200-20261006    gcc-13.4.0 smatch
arc                  randconfig-r2201-20261006    gcc-11.5.0 smatch
arc                  randconfig-r2202-20261006    gcc-9.5.0  smatch
arc                  randconfig-r2202-20261007    gcc-8.5.0  smatch
arc                  randconfig-r2309-20261007    gcc-8.5.0  sparse
arm                               alldefconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      davinci_all_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                            omap1_defconfig    gcc-16.1.0
arm                           pxa168_defconfig    gcc-16.1.0
arm                           pxa3xx_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261007    clang-24
arm                   randconfig-1001-20261007    clang-24
arm                   randconfig-1002-20261007    clang-24
arm                   randconfig-1003-20261007    clang-24
arm                  randconfig-r2100-20261007    clang-17   cocci
arm                  randconfig-r2103-20261006    clang-24   cocci
arm                  randconfig-r2104-20261006    clang-24   cocci
arm                  randconfig-r2104-20261007    gcc-12.5.0 cocci
arm                  randconfig-r2104-20261007    gcc-8.5.0  cocci
arm                  randconfig-r2105-20261006    gcc-14.3.0 cocci
arm                  randconfig-r2105-20261007    gcc-16.1.0 cocci
arm                  randconfig-r2202-20261007    gcc-12.5.0 smatch
arm                  randconfig-r2300-20261006    clang-18   sparse
arm                  randconfig-r2302-20261006    gcc-13.4.0 sparse
arm                  randconfig-r2303-20261006    gcc-13.4.0 sparse
arm                  randconfig-r2304-20261007    clang-20   sparse
arm                  randconfig-r2305-20261006    gcc-8.5.0  sparse
arm                  randconfig-r2307-20261006    clang-22   sparse
arm                  randconfig-r2308-20261006    clang-22   sparse
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm                          wpcm450_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261007    gcc-13.4.0
arm64                 randconfig-1001-20261007    gcc-13.4.0
arm64                 randconfig-1002-20261007    gcc-13.4.0
arm64                 randconfig-1003-20261007    gcc-13.4.0
arm64                randconfig-r2100-20261007    gcc-10.5.0 cocci
arm64                randconfig-r2101-20261006    clang-24   cocci
arm64                randconfig-r2102-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2103-20261006    clang-24   cocci
arm64                randconfig-r2104-20261006    gcc-11.5.0 cocci
arm64                randconfig-r2104-20261006    gcc-14.3.0 cocci
arm64                randconfig-r2104-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2106-20261006    clang-17   cocci
arm64                randconfig-r2106-20261007    clang-22   cocci
arm64                randconfig-r2106-20261007    gcc-16.1.0 cocci
arm64                randconfig-r2107-20261007    gcc-8.5.0  cocci
arm64                randconfig-r2201-20261007    clang-24   smatch
arm64                randconfig-r2202-20261006    clang-17   smatch
arm64                randconfig-r2301-20261007    clang-17   sparse
arm64                randconfig-r2301-20261007    clang-24   sparse
arm64                randconfig-r2303-20261007    clang-17   sparse
arm64                randconfig-r2305-20261007    clang-20   sparse
arm64                randconfig-r2306-20261006    clang-22   sparse
arm64                randconfig-r2306-20261006    gcc-12.5.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261007    gcc-13.4.0
csky                  randconfig-1001-20261007    gcc-13.4.0
csky                 randconfig-r2102-20261007    gcc-8.5.0  cocci
csky                 randconfig-r2104-20261007    gcc-16.1.0 cocci
csky                 randconfig-r2106-20261006    gcc-8.5.0  cocci
csky                 randconfig-r2107-20261006    gcc-9.5.0  cocci
csky                 randconfig-r2201-20261006    gcc-9.5.0  smatch
csky                 randconfig-r2201-20261007    gcc-16.1.0 smatch
csky                 randconfig-r2202-20261006    gcc-16.1.0 smatch
csky                 randconfig-r2300-20261006    gcc-15.2.0 sparse
csky                 randconfig-r2301-20261007    gcc-8.5.0  sparse
csky                 randconfig-r2303-20261006    gcc-10.5.0 sparse
csky                 randconfig-r2304-20261006    gcc-8.5.0  sparse
csky                 randconfig-r2305-20261007    clang-24   sparse
csky                 randconfig-r2309-20261006    gcc-14.3.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261007    gcc-12.5.0
hexagon               randconfig-1001-20261007    gcc-12.5.0
hexagon              randconfig-r2100-20261006    gcc-8.5.0  cocci
hexagon              randconfig-r2101-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2102-20261007    clang-20   cocci
hexagon              randconfig-r2103-20261006    clang-24   cocci
hexagon              randconfig-r2103-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2104-20261006    gcc-9.5.0  cocci
hexagon              randconfig-r2106-20261006    gcc-11.5.0 cocci
hexagon              randconfig-r2106-20261007    gcc-8.5.0  cocci
hexagon              randconfig-r2107-20261007    clang-22   cocci
hexagon              randconfig-r2107-20261007    gcc-16.1.0 cocci
hexagon              randconfig-r2200-20261007    clang-24   smatch
hexagon              randconfig-r2201-20261007    clang-24   smatch
hexagon              randconfig-r2301-20261006    gcc-13.4.0 sparse
hexagon              randconfig-r2301-20261006    gcc-8.5.0  sparse
hexagon              randconfig-r2302-20261006    gcc-14.3.0 sparse
hexagon              randconfig-r2304-20261006    gcc-13.4.0 sparse
hexagon              randconfig-r2304-20261006    gcc-14     sparse
hexagon              randconfig-r2304-20261007    clang-17   sparse
hexagon              randconfig-r2305-20261006    clang-18   sparse
hexagon              randconfig-r2305-20261006    gcc-14.3.0 sparse
hexagon              randconfig-r2306-20261006    gcc-14.3.0 sparse
hexagon              randconfig-r2307-20261006    gcc-10.5.0 sparse
hexagon              randconfig-r2308-20261006    clang-24   sparse
hexagon              randconfig-r2309-20261006    gcc-14.3.0 sparse
hexagon              randconfig-r2309-20261007    clang-17   sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261007    gcc-14
i386        buildonly-randconfig-1001-20261007    gcc-14
i386        buildonly-randconfig-1002-20261007    gcc-14
i386        buildonly-randconfig-1003-20261007    gcc-14
i386        buildonly-randconfig-1004-20261007    gcc-14
i386        buildonly-randconfig-1005-20261007    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261007    clang-22
i386                  randconfig-1001-20261007    clang-22
i386                  randconfig-1002-20261007    clang-22
i386                  randconfig-1003-20261007    clang-22
i386                  randconfig-1004-20261007    clang-22
i386                  randconfig-1005-20261007    clang-22
i386                  randconfig-1006-20261007    clang-22
i386                  randconfig-1007-20261007    gcc-14
i386                  randconfig-1008-20261007    gcc-14
i386                  randconfig-1009-20261007    gcc-14
i386                  randconfig-1010-20261007    gcc-14
i386                  randconfig-1011-20261007    gcc-14
i386                  randconfig-1012-20261007    gcc-14
i386                  randconfig-1013-20261007    gcc-14
i386                  randconfig-2100-20261006    clang-22   cocci
i386                  randconfig-2100-20261007    clang-22   cocci
i386                  randconfig-2101-20261006    clang-22   cocci
i386                  randconfig-2101-20261007    clang-22   cocci
i386                  randconfig-2102-20261006    clang-22   cocci
i386                  randconfig-2102-20261007    clang-22   cocci
i386                  randconfig-2103-20261006    clang-22   cocci
i386                  randconfig-2103-20261007    clang-22   cocci
i386                  randconfig-2200-20261006    gcc-13     smatch
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                  randconfig-2300-20261006    gcc-14     sparse
i386                  randconfig-2300-20261007    clang-22   sparse
i386                  randconfig-2301-20261006    gcc-14     sparse
i386                  randconfig-2301-20261007    clang-22   sparse
i386                  randconfig-2302-20261006    gcc-14     sparse
i386                  randconfig-2302-20261007    clang-22   sparse
i386                 randconfig-r2100-20261006    clang-24   cocci
i386                 randconfig-r2101-20261006    clang-24   cocci
i386                 randconfig-r2105-20261006    clang-17   cocci
i386                 randconfig-r2106-20261007    gcc-12.5.0 cocci
i386                 randconfig-r2106-20261007    gcc-8.5.0  cocci
i386                 randconfig-r2202-20261006    gcc-14     smatch
i386                 randconfig-r2300-20261006    gcc-14     sparse
i386                 randconfig-r2300-20261007    gcc-16.1.0 sparse
i386                 randconfig-r2300-20261007    gcc-8.5.0  sparse
i386                 randconfig-r2302-20261007    clang-20   sparse
i386                 randconfig-r2305-20261006    gcc-13.4.0 sparse
i386                 randconfig-r2307-20261007    clang-17   sparse
i386                 randconfig-r2307-20261007    gcc-13.4.0 sparse
i386                 randconfig-r2307-20261007    gcc-8.5.0  sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    gcc-16.1.0
loongarch             randconfig-1000-20261007    gcc-12.5.0
loongarch             randconfig-1001-20261007    gcc-12.5.0
loongarch            randconfig-r2101-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2102-20261006    gcc-13     cocci
loongarch            randconfig-r2104-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2106-20261006    gcc-16.1.0 cocci
loongarch            randconfig-r2106-20261006    gcc-8.5.0  cocci
loongarch            randconfig-r2200-20261006    clang-18   smatch
loongarch            randconfig-r2201-20261006    gcc-13.4.0 smatch
loongarch            randconfig-r2300-20261007    clang-17   sparse
loongarch            randconfig-r2301-20261006    gcc-10.5.0 sparse
loongarch            randconfig-r2301-20261007    gcc-16.1.0 sparse
loongarch            randconfig-r2302-20261006    gcc-10.5.0 sparse
loongarch            randconfig-r2304-20261007    gcc-16.1.0 sparse
loongarch            randconfig-r2305-20261006    clang-24   sparse
loongarch            randconfig-r2305-20261007    gcc-8.5.0  sparse
loongarch            randconfig-r2307-20261006    gcc-14.3.0 sparse
loongarch            randconfig-r2307-20261007    clang-24   sparse
loongarch            randconfig-r2309-20261006    clang-22   sparse
loongarch            randconfig-r2309-20261007    clang-17   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.1.0
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                        m5282evb_defconfig    gcc-16.1.0
m68k                         mvme147_defconfig    gcc-16.1.0
m68k                 randconfig-r2100-20261007    gcc-11.5.0 cocci
m68k                 randconfig-r2101-20261006    gcc-10.5.0 cocci
m68k                 randconfig-r2103-20261006    gcc-9.5.0  cocci
m68k                 randconfig-r2105-20261006    gcc-9.5.0  cocci
m68k                 randconfig-r2106-20261007    gcc-10.5.0 cocci
m68k                 randconfig-r2107-20261006    gcc-8.5.0  cocci
m68k                 randconfig-r2200-20261006    gcc-10.5.0 smatch
m68k                 randconfig-r2202-20261006    gcc-8.5.0  smatch
m68k                 randconfig-r2300-20261006    gcc-13.4.0 sparse
m68k                 randconfig-r2301-20261006    gcc-14.3.0 sparse
m68k                 randconfig-r2303-20261007    gcc-8.5.0  sparse
m68k                 randconfig-r2304-20261006    clang-18   sparse
m68k                 randconfig-r2304-20261006    gcc-15.2.0 sparse
m68k                 randconfig-r2305-20261006    gcc-15.2.0 sparse
m68k                 randconfig-r2307-20261006    clang-19   sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261006    clang-24   cocci
microblaze           randconfig-r2104-20261006    gcc-11.5.0 cocci
microblaze           randconfig-r2104-20261007    gcc-10.5.0 cocci
microblaze           randconfig-r2107-20261006    clang-17   cocci
microblaze           randconfig-r2107-20261006    gcc-11.5.0 cocci
microblaze           randconfig-r2200-20261006    gcc-14.3.0 smatch
microblaze           randconfig-r2200-20261007    gcc-8.5.0  smatch
microblaze           randconfig-r2301-20261006    gcc-10.5.0 sparse
microblaze           randconfig-r2302-20261006    gcc-13.4.0 sparse
microblaze           randconfig-r2303-20261006    gcc-15.2.0 sparse
microblaze           randconfig-r2303-20261007    gcc-16.1.0 sparse
microblaze           randconfig-r2306-20261006    clang-24   sparse
microblaze           randconfig-r2306-20261007    gcc-13.4.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                          bigsur_defconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                            jazz_defconfig    gcc-16.1.0
mips                   maltasmvp_eva_defconfig    gcc-16.1.0
mips                 randconfig-r2102-20261006    clang-24   cocci
mips                 randconfig-r2105-20261006    gcc-16.1.0 cocci
mips                 randconfig-r2107-20261006    gcc-11.5.0 cocci
mips                 randconfig-r2202-20261006    gcc-13.4.0 smatch
mips                 randconfig-r2302-20261006    clang-24   sparse
mips                 randconfig-r2303-20261006    gcc-8.5.0  sparse
mips                 randconfig-r2304-20261006    gcc-13.4.0 sparse
mips                 randconfig-r2305-20261006    gcc-10.5.0 sparse
mips                 randconfig-r2306-20261007    clang-17   sparse
mips                 randconfig-r2308-20261006    clang-24   sparse
mips                 randconfig-r2308-20261007    gcc-8.5.0  sparse
mips                 randconfig-r2309-20261006    clang-20   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261007    gcc-12.5.0
nios2                 randconfig-1001-20261007    gcc-12.5.0
nios2                randconfig-r2100-20261006    gcc-10.5.0 cocci
nios2                randconfig-r2100-20261006    gcc-14.3.0 cocci
nios2                randconfig-r2101-20261007    gcc-11.5.0 cocci
nios2                randconfig-r2102-20261006    gcc-10.5.0 cocci
nios2                randconfig-r2105-20261007    gcc-10.5.0 cocci
nios2                randconfig-r2106-20261006    gcc-11.5.0 cocci
nios2                randconfig-r2106-20261006    gcc-14.3.0 cocci
nios2                randconfig-r2107-20261006    gcc-11.5.0 cocci
nios2                randconfig-r2201-20261006    gcc-8.5.0  smatch
nios2                randconfig-r2202-20261006    gcc-8.5.0  smatch
nios2                randconfig-r2300-20261006    gcc-10.5.0 sparse
nios2                randconfig-r2301-20261006    clang-18   sparse
nios2                randconfig-r2304-20261006    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261007    gcc-10.5.0 cocci
openrisc             randconfig-r2103-20261006    gcc-10.5.0 cocci
openrisc             randconfig-r2103-20261006    gcc-14.3.0 cocci
openrisc             randconfig-r2104-20261006    gcc-8.5.0  cocci
openrisc             randconfig-r2107-20261007    gcc-12.5.0 cocci
openrisc             randconfig-r2200-20261006    gcc-13.4.0 smatch
openrisc             randconfig-r2200-20261007    gcc-12.5.0 smatch
openrisc             randconfig-r2302-20261007    gcc-16.1.0 sparse
openrisc             randconfig-r2303-20261007    clang-20   sparse
openrisc             randconfig-r2305-20261006    gcc-14     sparse
openrisc             randconfig-r2307-20261006    gcc-14.3.0 sparse
openrisc             randconfig-r2308-20261007    gcc-11.5.0 sparse
openrisc             randconfig-r2309-20261006    gcc-10.5.0 sparse
openrisc             randconfig-r2309-20261006    gcc-12.5.0 sparse
openrisc             randconfig-r2309-20261007    gcc-13.4.0 sparse
openrisc                        virt_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-32bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261007    gcc-15.2.0
parisc                randconfig-1001-20261007    gcc-15.2.0
parisc               randconfig-r2100-20261007    gcc-8.5.0  cocci
parisc               randconfig-r2101-20261006    gcc-8.5.0  cocci
parisc               randconfig-r2104-20261006    clang-17   cocci
parisc               randconfig-r2106-20261006    gcc-8.5.0  cocci
parisc               randconfig-r2106-20261007    gcc-10.5.0 cocci
parisc               randconfig-r2107-20261006    gcc-14.3.0 cocci
parisc               randconfig-r2107-20261006    gcc-16.1.0 cocci
parisc               randconfig-r2201-20261006    gcc-8.5.0  smatch
parisc               randconfig-r2201-20261007    gcc-8.5.0  smatch
parisc               randconfig-r2303-20261006    gcc-14     sparse
parisc               randconfig-r2305-20261006    gcc-8.5.0  sparse
parisc               randconfig-r2305-20261007    gcc-16.1.0 sparse
parisc               randconfig-r2306-20261007    gcc-11.5.0 sparse
parisc               randconfig-r2309-20261007    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    gcc-16.1.0
powerpc                     ge_imp3a_defconfig    gcc-16.1.0
powerpc                         icon_defconfig    gcc-16.1.0
powerpc                    motionpro_defconfig    gcc-16.1.0
powerpc                  mpc8313_rdb_defconfig    gcc-16.1.0
powerpc                       pmac32_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261007    gcc-15.2.0
powerpc               randconfig-1001-20261007    gcc-15.2.0
powerpc              randconfig-r2100-20261006    clang-17   cocci
powerpc              randconfig-r2100-20261006    clang-24   cocci
powerpc              randconfig-r2101-20261007    gcc-8.5.0  cocci
powerpc              randconfig-r2104-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2105-20261006    gcc-16.1.0 cocci
powerpc              randconfig-r2300-20261006    gcc-14.3.0 sparse
powerpc              randconfig-r2302-20261006    gcc-15.2.0 sparse
powerpc              randconfig-r2303-20261006    gcc-13.4.0 sparse
powerpc              randconfig-r2303-20261006    gcc-14.3.0 sparse
powerpc              randconfig-r2306-20261007    clang-17   sparse
powerpc              randconfig-r2307-20261007    gcc-11.5.0 sparse
powerpc              randconfig-r2308-20261006    gcc-12.5.0 sparse
powerpc              randconfig-r2308-20261007    gcc-13.4.0 sparse
powerpc                      stx_gp3_defconfig    gcc-16.1.0
powerpc                  xes_mpc85xx_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261007    gcc-15.2.0
powerpc64             randconfig-1001-20261007    gcc-15.2.0
powerpc64            randconfig-r2101-20261006    clang-24   cocci
powerpc64            randconfig-r2102-20261006    clang-24   cocci
powerpc64            randconfig-r2102-20261006    gcc-9.5.0  cocci
powerpc64            randconfig-r2103-20261006    gcc-8.5.0  cocci
powerpc64            randconfig-r2103-20261007    gcc-10.5.0 cocci
powerpc64            randconfig-r2105-20261006    gcc-11.5.0 cocci
powerpc64            randconfig-r2200-20261007    clang-24   smatch
powerpc64            randconfig-r2201-20261007    clang-24   smatch
powerpc64            randconfig-r2202-20261007    gcc-10.5.0 smatch
powerpc64            randconfig-r2301-20261006    gcc-15.2.0 sparse
powerpc64            randconfig-r2303-20261006    clang-24   sparse
powerpc64            randconfig-r2303-20261007    clang-24   sparse
powerpc64            randconfig-r2305-20261006    gcc-10.5.0 sparse
powerpc64            randconfig-r2306-20261007    gcc-8.5.0  sparse
powerpc64            randconfig-r2307-20261006    clang-24   sparse
powerpc64            randconfig-r2309-20261006    gcc-14.3.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261007    clang-24
riscv                 randconfig-1001-20261007    clang-24
riscv                 randconfig-2000-20261006    gcc-16.1.0
riscv                 randconfig-2000-20261007    gcc-12.5.0
riscv                 randconfig-2001-20261006    gcc-16.1.0
riscv                 randconfig-2001-20261007    gcc-12.5.0
riscv                randconfig-r2100-20261006    gcc-13     cocci
riscv                randconfig-r2101-20261006    gcc-14.3.0 cocci
riscv                randconfig-r2101-20261007    clang-17   cocci
riscv                randconfig-r2105-20261006    gcc-8.5.0  cocci
riscv                randconfig-r2105-20261007    gcc-8.5.0  cocci
riscv                randconfig-r2201-20261007    clang-24   smatch
riscv                randconfig-r2301-20261006    gcc-13.4.0 sparse
riscv                randconfig-r2302-20261006    gcc-14     sparse
riscv                randconfig-r2303-20261006    clang-18   sparse
riscv                randconfig-r2304-20261006    gcc-10.5.0 sparse
riscv                randconfig-r2304-20261007    gcc-8.5.0  sparse
riscv                randconfig-r2307-20261006    gcc-12.5.0 sparse
riscv                randconfig-r2308-20261006    gcc-14.3.0 sparse
riscv                randconfig-r2308-20261007    clang-17   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261007    clang-24
s390                  randconfig-1001-20261007    clang-24
s390                  randconfig-2000-20261006    gcc-16.1.0
s390                  randconfig-2000-20261007    gcc-12.5.0
s390                  randconfig-2001-20261006    gcc-16.1.0
s390                  randconfig-2001-20261007    gcc-12.5.0
s390                 randconfig-r2101-20261006    gcc-13     cocci
s390                 randconfig-r2101-20261007    clang-20   cocci
s390                 randconfig-r2102-20261006    gcc-8.5.0  cocci
s390                 randconfig-r2302-20261007    gcc-8.5.0  sparse
s390                 randconfig-r2306-20261006    clang-19   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.1.0
sh                           lboxre2_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261007    clang-24
sh                    randconfig-1001-20261007    clang-24
sh                    randconfig-2000-20261006    gcc-16.1.0
sh                    randconfig-2000-20261007    gcc-12.5.0
sh                    randconfig-2001-20261006    gcc-16.1.0
sh                    randconfig-2001-20261007    gcc-12.5.0
sh                   randconfig-r2102-20261006    gcc-15.2.0 cocci
sh                   randconfig-r2102-20261006    gcc-8.5.0  cocci
sh                   randconfig-r2105-20261006    gcc-11.5.0 cocci
sh                   randconfig-r2105-20261007    clang-22   cocci
sh                   randconfig-r2105-20261007    gcc-10.5.0 cocci
sh                   randconfig-r2107-20261006    gcc-14.3.0 cocci
sh                   randconfig-r2200-20261006    gcc-16.1.0 smatch
sh                   randconfig-r2201-20261006    gcc-16.1.0 smatch
sh                   randconfig-r2300-20261006    gcc-13.4.0 sparse
sh                   randconfig-r2302-20261006    gcc-8.5.0  sparse
sh                   randconfig-r2306-20261006    clang-19   sparse
sh                   randconfig-r2306-20261006    clang-24   sparse
sh                   randconfig-r2308-20261006    clang-19   sparse
sh                   randconfig-r2308-20261006    clang-20   sparse
sh                           rsk7264_defconfig    gcc-16.1.0
sh                           sdk7780_defconfig    gcc-16.1.0
sh                            se7712_defconfig    gcc-16.1.0
sh                    secureedge5410_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261007    clang-17
sparc                 randconfig-1001-20261007    clang-17
sparc                 randconfig-2000-20261006    clang-24
sparc                 randconfig-2000-20261007    clang-24
sparc                 randconfig-2001-20261006    clang-24
sparc                 randconfig-2001-20261007    clang-24
sparc                randconfig-r2100-20261006    clang-24   cocci
sparc                randconfig-r2102-20261006    gcc-14.3.0 cocci
sparc                randconfig-r2103-20261007    clang-17   cocci
sparc                randconfig-r2104-20261006    gcc-14.3.0 cocci
sparc                randconfig-r2105-20261007    gcc-12.5.0 cocci
sparc                randconfig-r2107-20261006    gcc-16.1.0 cocci
sparc                randconfig-r2300-20261006    clang-24   sparse
sparc                randconfig-r2300-20261006    gcc-8.5.0  sparse
sparc                randconfig-r2301-20261006    gcc-14     sparse
sparc                randconfig-r2301-20261007    clang-20   sparse
sparc                randconfig-r2302-20261006    gcc-10.5.0 sparse
sparc                randconfig-r2302-20261006    gcc-8.5.0  sparse
sparc                randconfig-r2303-20261006    gcc-10.5.0 sparse
sparc                randconfig-r2304-20261006    gcc-14.3.0 sparse
sparc                randconfig-r2306-20261006    clang-20   sparse
sparc                randconfig-r2309-20261006    clang-24   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261007    clang-17
sparc64               randconfig-1001-20261007    clang-17
sparc64               randconfig-2000-20261006    clang-24
sparc64               randconfig-2000-20261007    clang-24
sparc64               randconfig-2001-20261006    clang-24
sparc64               randconfig-2001-20261007    clang-24
sparc64              randconfig-r2100-20261006    gcc-9.5.0  cocci
sparc64              randconfig-r2100-20261007    gcc-8.5.0  cocci
sparc64              randconfig-r2102-20261007    gcc-11.5.0 cocci
sparc64              randconfig-r2103-20261006    clang-24   cocci
sparc64              randconfig-r2103-20261007    clang-20   cocci
sparc64              randconfig-r2106-20261006    gcc-11.5.0 cocci
sparc64              randconfig-r2106-20261006    gcc-14.3.0 cocci
sparc64              randconfig-r2106-20261006    gcc-9.5.0  cocci
sparc64              randconfig-r2201-20261007    gcc-16.1.0 smatch
sparc64              randconfig-r2300-20261007    clang-20   sparse
sparc64              randconfig-r2301-20261006    gcc-8.5.0  sparse
sparc64              randconfig-r2302-20261006    clang-18   sparse
sparc64              randconfig-r2304-20261007    clang-24   sparse
sparc64              randconfig-r2306-20261006    gcc-14.3.0 sparse
sparc64              randconfig-r2307-20261006    gcc-14.3.0 sparse
sparc64              randconfig-r2308-20261006    gcc-10.5.0 sparse
sparc64              randconfig-r2309-20261007    gcc-11.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261007    clang-17
um                    randconfig-1001-20261007    clang-17
um                    randconfig-2000-20261006    clang-24
um                    randconfig-2000-20261007    clang-24
um                    randconfig-2001-20261006    clang-24
um                    randconfig-2001-20261007    clang-24
um                   randconfig-r2103-20261006    gcc-13     cocci
um                   randconfig-r2105-20261006    clang-17   cocci
um                   randconfig-r2105-20261006    gcc-11.5.0 cocci
um                   randconfig-r2105-20261006    gcc-8.5.0  cocci
um                   randconfig-r2107-20261006    gcc-16.1.0 cocci
um                   randconfig-r2107-20261006    gcc-8.5.0  cocci
um                   randconfig-r2202-20261007    clang-24   smatch
um                   randconfig-r2300-20261006    gcc-8.5.0  sparse
um                   randconfig-r2300-20261007    clang-24   sparse
um                   randconfig-r2301-20261006    clang-24   sparse
um                   randconfig-r2309-20261006    clang-19   sparse
um                            x86_64_defconfig    gcc-14
um                            x86_64_defconfig    gcc-16.1.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261006    gcc-14
x86_64      buildonly-randconfig-1000-20261007    gcc-14
x86_64      buildonly-randconfig-1001-20261006    gcc-14
x86_64      buildonly-randconfig-1001-20261007    gcc-14
x86_64      buildonly-randconfig-1002-20261006    gcc-14
x86_64      buildonly-randconfig-1002-20261007    gcc-14
x86_64      buildonly-randconfig-1003-20261006    gcc-14
x86_64      buildonly-randconfig-1003-20261007    gcc-14
x86_64      buildonly-randconfig-1004-20261006    gcc-14
x86_64      buildonly-randconfig-1004-20261007    gcc-14
x86_64      buildonly-randconfig-1005-20261006    gcc-14
x86_64      buildonly-randconfig-1005-20261007    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261007    clang-22
x86_64                randconfig-1001-20261007    clang-22
x86_64                randconfig-1002-20261007    clang-22
x86_64                randconfig-1003-20261007    clang-22
x86_64                randconfig-1004-20261007    clang-22
x86_64                randconfig-1005-20261007    clang-22
x86_64                randconfig-1006-20261006    gcc-14
x86_64                randconfig-1006-20261007    clang-22
x86_64                randconfig-1007-20261006    gcc-14
x86_64                randconfig-1007-20261007    clang-22
x86_64                randconfig-1008-20261006    gcc-14
x86_64                randconfig-1008-20261007    clang-22
x86_64                randconfig-1009-20261006    gcc-14
x86_64                randconfig-1009-20261007    clang-22
x86_64                randconfig-1010-20261006    gcc-14
x86_64                randconfig-1010-20261007    clang-22
x86_64                randconfig-1011-20261006    gcc-14
x86_64                randconfig-1011-20261007    clang-22
x86_64                randconfig-1012-20261007    gcc-12
x86_64                randconfig-1013-20261007    gcc-12
x86_64                randconfig-1014-20261007    gcc-12
x86_64                randconfig-1015-20261007    gcc-12
x86_64                randconfig-1016-20261007    gcc-12
x86_64                randconfig-1017-20261007    gcc-12
x86_64                randconfig-2100-20261006    clang-22   cocci
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2101-20261006    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2102-20261006    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2103-20261006    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2200-20261006    clang-22   smatch
x86_64                randconfig-2200-20261007    gcc-14     smatch
x86_64                randconfig-2300-20261006    gcc-14     sparse
x86_64                randconfig-2300-20261007    clang-22   sparse
x86_64                randconfig-2301-20261006    gcc-14     sparse
x86_64                randconfig-2301-20261007    clang-22   sparse
x86_64                randconfig-2302-20261006    gcc-14     sparse
x86_64                randconfig-2302-20261007    clang-22   sparse
x86_64               randconfig-r2100-20261006    gcc-8.5.0  cocci
x86_64               randconfig-r2101-20261006    gcc-8.5.0  cocci
x86_64               randconfig-r2104-20261007    clang-22   cocci
x86_64               randconfig-r2107-20261007    gcc-10.5.0 cocci
x86_64               randconfig-r2200-20261006    clang-22   smatch
x86_64               randconfig-r2201-20261006    gcc-12     smatch
x86_64               randconfig-r2202-20261006    gcc-14     smatch
x86_64               randconfig-r2304-20261006    gcc-8.5.0  sparse
x86_64               randconfig-r2305-20261006    gcc-13.4.0 sparse
x86_64               randconfig-r2307-20261006    clang-20   sparse
x86_64               randconfig-r2308-20261007    clang-24   sparse
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
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261007    clang-17
xtensa                randconfig-1001-20261007    clang-17
xtensa                randconfig-2000-20261006    clang-24
xtensa                randconfig-2000-20261007    clang-24
xtensa                randconfig-2001-20261006    clang-24
xtensa                randconfig-2001-20261007    clang-24
xtensa               randconfig-r2102-20261006    gcc-8.5.0  cocci
xtensa               randconfig-r2102-20261007    clang-17   cocci
xtensa               randconfig-r2103-20261007    gcc-8.5.0  cocci
xtensa               randconfig-r2202-20261006    gcc-9.5.0  smatch
xtensa               randconfig-r2302-20261007    clang-17   sparse
xtensa               randconfig-r2306-20261006    gcc-10.5.0 sparse
xtensa               randconfig-r2306-20261006    gcc-14.3.0 sparse
xtensa               randconfig-r2307-20261006    clang-24   sparse
xtensa               randconfig-r2307-20261007    clang-17   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
