Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A1606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5xh9P1mZ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwj1owHO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F39FF60716;
	Fri, 27 Nov 2026 16:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpCWcxhuN-Ig; Fri, 27 Nov 2026 16:50:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09B18607BC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798202;
	b=Eun0mSTeg/aWfiWCmulUtsVbFi4hKG9fvvNwPzz15I8nwtV9vKuWkBmTuwYbyfdv4mGu
	 Fh3t8ejRwfOuPWwMJLaBU1J/PZWMnv87Zp4IssQ5ySKfII+XicyCgVFZbi9jU7i2YJnx1
	 JyUqyBjtVLdZ2iA1Su6ik04ECGbVtJUWwW2sTMRvq+wD8nRDoK8nVv/nzryPQyL1NHFva
	 +hxlgR8wXpQ3JhUesba77vI39Xr790bb0Ia6o08I9/bceqEkDO9PEiZwioZ9zaM47LPol
	 vJG9nFqgQdMgzjKOsbzJ1sbgxop8JOOBpjgiM8MUk/TsQLnwluAiUSeh3VWoZSITP0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sWEq/5LG1M894HGeNc8HP+d7P1NzCsfNtrTdK6WMVYc=;
	b=WzD1+bKn4JuoWjcdA+UvlFbK8lo+tpvZeaehb6ameUuHmh0oCaw6nR/95ErhlIUgM9MM
	 4xRuBvDZbv2+ygMkztNCyJNlAwTTqcsHI7MfSq0o7mM64t/HeX/bz2lGfFgCd0pTyon4v
	 pW7sWDVj+HitWNvOBgiTmROaskmj8AZ9piTncuSpp3MjcgH3yJvlznIu46OgHDUBEQbvU
	 mVZaIrox2g+j6wWEpxwRjJUDruQmhPQ4WUJBAQMrStj08wEP8ZS3Uy67kWI/QnCoVmGY5
	 J2xBDdNhOnJrV/MBVSvf8MF/iMerqhinf8I6WUAqexq8LZKDAPRzAF7Wg46jJzjcgBQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwj1owHO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795798202;
	bh=sWEq/5LG1M894HGeNc8HP+d7P1NzCsfNtrTdK6WMVYc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5xh9P1mZrvzsX3bcjP+tEezvn9rvytZ4u4feilcdr/qkKDGi0mGp6FcWaoIaC+Vex
	 +b9P9Vn+E5n6hGAP9ILkWVNw5GMxfTbDOKY2MDlugpZMIk0I3oSiOsgFHBo0MZ+jta
	 Rg2gJoWmekkYkUGeRTliYxXISF7+7CRn/rBbYsrYgrX0VcCyeFBTdMMhSVYEBz8UE8
	 gpd2Q0OXWI24liu6nGlXXnRJ0XiatZlSKycOFGhy8y5YWAB+y+EnxatcLTgF6Q4JVw
	 NPnfP/DoDbJnax+l1r/7uHQRcpNLv0CAYNjfUWDnwy8IuXgEpyX3DpTv8zIuJmk7Ai
	 ppVp5V2zwxQsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09B18607BC;
	Fri, 27 Nov 2026 16:50:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8A9226D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF808607BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yN3oJz6_hdO8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 16:49:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E43360716
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gwj1owHO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E43360716
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795798199; x=1827334199;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dsid8W/5umnJUa99lU04mk8KU5lmoHnFDi7tRgQ+kkI=;
 b=gwj1owHOS3fweujcn9Bhd8tLF3cW35qP7IayVmJcQH/Myl263SvFDI5/
 YRU8IWb5oPZZR80HhBMlpBn+A7xmQepGxomVF9rCxjQ47ZdNfbG1UOYGu
 VUN7QySWqvS1WcqpuYbPgJ5V/5HTz+WWQukN63bxVx4vJbEl8cgj7PfWz
 J/w/Gb3cCADKFwttm/8tBTnmLSSjMsJB05I1WFGn2R9uWpunndHoG1mgX
 FJbaoP3bwBeSwthPrCrfnEdo6hyKplVbFgIpND5Ltmrnvy7+dRRfH8ehz
 ER2EdbrT5nEpSlh2jiCSuVmWy+8/Yu01ljzDGYQyKnF5S25zIL26xsumK g==;
X-CSE-ConnectionGUID: HCpS3CkgRAm1O6r8pPTzjA==
X-CSE-MsgGUID: B6XuWvz4QxWG4ZoABnAGXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4711567"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4711567"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:49:58 -0800
X-CSE-ConnectionGUID: fTdmgFPbTEK2fKc9RRK06Q==
X-CSE-MsgGUID: s19vRsVeQeq8zmqMpoje/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12567836"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 27 Nov 2026 08:49:57 -0800
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 9732C312F6;
 Fri, 27 Nov 2026 16:49:55 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH linux-firmware] ice: update DDP package to 1.3.59.0
Date: Fri, 27 Nov 2026 17:49:52 +0100
Message-ID: <20261127164952.282833-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Highlights of changes since 1.3.43.0:
* Add switch profiles for ICMP/ICMPv6
* Minor fix for FDIR rejecting certain rules

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 WHENCE                                        |   4 ++--
 .../{ice-1.3.43.0.pkg => ice-1.3.59.0.pkg}    | Bin 1352580 -> 1360772 bytes
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename intel/ice/ddp/{ice-1.3.43.0.pkg => ice-1.3.59.0.pkg} (96%)

diff --git a/WHENCE b/WHENCE
index 37db426bfbab..2b1d11390a3e 100644
--- a/WHENCE
+++ b/WHENCE
@@ -7617,8 +7617,8 @@ SPDX-License-Identifier: LicenseRef-LICENSE.amlogic_vdec
 
 Driver: ice - Intel(R) Ethernet Connection E800 Series
 
-File: intel/ice/ddp/ice-1.3.43.0.pkg
-Link: intel/ice/ddp/ice.pkg -> ice-1.3.43.0.pkg
+File: intel/ice/ddp/ice-1.3.59.0.pkg
+Link: intel/ice/ddp/ice.pkg -> ice-1.3.59.0.pkg
 File: intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg
 
 License: Redistributable. See LICENSE.ice for details
diff --git a/intel/ice/ddp/ice-1.3.43.0.pkg b/intel/ice/ddp/ice-1.3.59.0.pkg
similarity index 96%
rename from intel/ice/ddp/ice-1.3.43.0.pkg
rename to intel/ice/ddp/ice-1.3.59.0.pkg
index 8a9cf0577571121aace49873f0295a7e9ba3d3bf..a0ef874000e4db6486b2c027f9e0a37277b01f33 100644
GIT binary patch
delta 6521
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
E0UwotX#fBK

delta 21591
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
D((WZQ

-- 
2.56.1

