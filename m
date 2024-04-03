Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD44ECD1288
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Apr 2024 10:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C70A416D2;
	Wed,  3 Apr 2024 10:24:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSUlUgeSkFOm; Wed,  3 Apr 2024 10:24:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFAF4416B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712139861;
	bh=dLGAzQzFjHhVTEtSu6k2mmVfqwrnykeQtGPwVy0DC4w=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=GpM5mkY66oIA974IgdMoLJsn9kM4PtSP9Mdv2iI3h1AMl4rZJQFVELKiNoZPl/qj3
	 ew+JfxnPBWu4bGsqpFcHptdErBqcJ/zWhlkLuJzw0a/HqhiNjeeKi+W7mnFGF8t2Dl
	 PHZ5c9QFt6JRrU7mFeMCmCATnnrseo7DmY2/VBahVNXlg1F/80sWW4uwkA9ge1Ymb3
	 VpV3iM6Gbs0G5v6U+gfdakmr3QvOdZM9MpdrtxpmK2bPDoqK4XF72UXibpw6mkC9FH
	 YTWqeyq+bn7t7e/Mvnt0sddQDDDwPKRIqeaJF5ygAP3ge0hf29qu2dKeRcMfAEJEwc
	 TrOUJY1s0W8PA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFAF4416B4;
	Wed,  3 Apr 2024 10:24:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CD8C61BF349
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Apr 2024 10:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B88CD416B4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Apr 2024 10:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnzVuXFkDbGC for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Apr 2024 10:24:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lukasz.plachno@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8E1EF40127
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E1EF40127
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E1EF40127
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Apr 2024 10:24:18 +0000 (UTC)
X-CSE-ConnectionGUID: xwatzdoOSSy8oZ0hNtCGbg==
X-CSE-MsgGUID: 4kT+zOgeRPWAIxT5zqAO3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7282810"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7282810"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 03:24:17 -0700
X-CSE-ConnectionGUID: H03ZWuT1Q0Kg7ULmUVF1Wg==
X-CSE-MsgGUID: B5q4JpETSvOkl2fpXzLGSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="18292405"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 03:24:15 -0700
Received: from lplachno-mobl.ger.corp.intel.com
 (lplachno-mobl.ger.corp.intel.com [10.245.83.30])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A6AA6369EC;
 Wed,  3 Apr 2024 11:24:13 +0100 (IST)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  3 Apr 2024 12:24:00 +0200
Message-Id: <20240403102402.20144-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712139858; x=1743675858;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bDyQv83waGmDhEPH2TjePdRLXfCa+ls3xnXd1RRn1IM=;
 b=HNcKVprsm2bK6twN0L3QZiXUP5dCBSPyBP4JnAJqEYE5tbSJ4/mWiEQo
 8UDgTh0n1F38RkiBdEI9bhC5IQLZH82s1sjvDzcoxQEj0NDK44+cE1Gfc
 XvMvEc5w/YvjbjIgBko3n/mqHgEBfro0VnP8/x508/LUI8O+gcObbo7BC
 QP4RGRe5OjKNGeDwyeDbBc/cW9nbBb/y1jR6iTEoNxMAx2ibnUWWTR2Nv
 H9ECTjvnPVCe3hqCKAj4b/EiZb8PrES+r0eLR0FfrEPM0ctoAQN3kcp4Q
 cYjjMeheyJjb31mqD9zj7htFmEin3YNo6O3nPuAmNVqESvLCvSi54e+Ck
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HNcKVprs
Subject: [Intel-wired-lan] [PATCH iwl-next v8 0/2] ice: Support flow
 director ether type filters
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: pmenzel@molgen.mpg.de, brett.creeley@amd.com, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, Lukasz Plachno <lukasz.plachno@intel.com>,
 horms@kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v8: Added check for vlan-etype when proto and vlan are specified,
    vlan-etype is required by HW
v7: removed 0 initialization of static const array (omitted by error in v6)
v6: removed ice_fdir_eth and reused ethhdr, removed 0 initialization
    of static const array
v5: added missing documentation for parameter introduced in V4,
    extended commit message for patch adding flow-type ether rules support
v4: added warning explaining that masks other than broadcast and unicast
    are not supported, added check for empty filters
v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 138 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 111 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 208 insertions(+), 47 deletions(-)


base-commit: b1f81b9a535b48b2c9ca460720a2bc73fd2001de
-- 
2.34.1

