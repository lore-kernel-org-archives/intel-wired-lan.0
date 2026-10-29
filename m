Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E8606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iONyyOHO;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UUUsFTT+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF7D40729;
	Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HF2EUglrs5RC; Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25A514072E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268165;
	b=a5lKODt0xgFfMHLAUzU/SXgQm1jsiPAB5i0lUJudzgl2Cqnh6NU7OaAMl6HonY/4GP/u
	 1HlEhKr47LssS5rPCnAOr/4xHWdQAHkxYQ0V6IeQFapeIoN2ZOId/iwBGiU4ARB1izL+E
	 Hx+IEMl7AaMj3g5pN42JXTMJ7CG6Yq3V9BOuWNvd/ymTIn7yzIu9uc2glRPSDPoNVCek4
	 o7kO6Q1V68cbW8Paznn8Z253fIwycrL6X3NaO4wUWtAx+BOowsKOZRlC6qNoHrgqMr9jB
	 lukj5hvrhV3nFsSZt504LkIpMt6NTeJE7geb3sgx2fTspdqM5W/b67Dh6hKqlZ7TWrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2V6N9I25g7wA3Lnt/px9sK+Zq36FFuA/h7LceqefWu0=;
	b=CiR0s1eaSWCzhkIuAr3o/sJWK1FdxF8llClxkIfZttgTo8BKvJYFQfyv+7rkJI97sScT
	 A17lUQVAK6iJHlzJcbZJepmDIt0Z9Z1uZNN4/r26W6YsUeVsgy/El5tR/VHULRWMMoDq3
	 2MQnHGELbhLEiM6gTD8R+wzUHgGdmSnmUcBOY8hF8wIMF2/CYnlgKnhsht1pQlOt1wwdJ
	 O5z2KKOHOCxbBEZd/Vv3SLik10bsoI/VfgwMlPDMTWs8MKAcHx9re1YcHCN78i3qb4ATM
	 NH5JmTyLeHvGqeaqxqHDVXeO3KVkT9IMgjYEV8pTg1YGPvuaRQ/Jd0vAR6igC6Xcm4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793268165;
	bh=2V6N9I25g7wA3Lnt/px9sK+Zq36FFuA/h7LceqefWu0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iONyyOHOwPPWLj1+LAkqHuRHlpYPBndgaD6lNBB33/dTsJUahSBBTT5PyrYForNW9
	 ImLPWQ1l9Jwc9J1UrkK1FkgXnAJGMyOcFH2t6JNvrp/CL4Dp8CNTjGIBwB9doEyL4Q
	 N+Me41DuZGAuwhD4OrWnWUsdLVXtiWKhIPI3TbKcG2BlwXUQvBeeJDLrrUCx2XkoHE
	 R5FKffdp5K/2yNiOkS4XBGsJYl7BC0J69Pj1YjZ90bezd1xsSpt6FrN4nz5vli43B9
	 GZANpHB/t8yfJL2lnD33rWMMggMUveDDemJaxIN7bZ+525raUO8gsHhr5rqIEXUfqm
	 02rX+qX+yNO8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25A514072E;
	Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93205972
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8502A606C2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKWNjzCjY2VO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 10:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3686D605CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268163;
 b=ZQoGzmjqrcpSsSL6IigL97tuWcA77J7OoZVJFeZ4L61PE42xy5vPWSIuunKM4DEaK6Pr
 8o3lw3q9FF5sLuNh8Jmd9R7qposqojAECYw6Kk2nKpVRU5E3VEgFt59VdklzrVqHQtsug
 wxOsq4aUUWKFTwl5jep+5FgC9mqkVyUWvJcgvgmt8RGBLYPp0QoOjN/ARsIf1BWqgG4cJ
 4dRpGuWkLtByTENSAH8Flecv1Q3PEq4elaxO132MH1mjY4JtWNsDxVW4fXXF6JbL3U6lg
 WpV+VPtF4Ix586I+8PPzlan9iaL78FV287uesdGfmcLo/xOcks2OZsh1k0wO3pd7Xtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268163;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=2V6N9I25g7wA3Lnt/px9sK+Zq36FFuA/h7LceqefWu0=;
 b=EL3qRcHKPYFtVRId8HRoY1seUC9wJWFVcGGUIXuxkKdKrjjCPMI0QoQ5AMUI6ResFuLp
 QAbBYg55pVdKYygNSWoJ5jVdaluHoR1Gk53jBfmvIiCtfbcN2oQNw0YS8RhmMk0YS0QL7
 ATdAQvAyOjf+RPrcW64O2FwYIrSWnavpCYRUFoCOPI6ogXRP9cwlq8o4hBaUyUOB8EEt5
 ivV63Cmb4Y1rAePh9TuUhhRFK+8nGEOfLU65X7ljN8boer9H1EVGxY2qG0DoPzQK2REDX
 o926HzIQ+oUgEFmtF96+YG9QaLB7Cq+BCHbAnQAvywZ60Kg0emPnRmzpx3K5zLv9cNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UUUsFTT+; 
 arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UUUsFTT+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3686D605CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793268163; x=1824804163;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ff5x/LQBh+nbQIaIMdfZm17mYbNt/oiwhJYlVhUfaPM=;
 b=UUUsFTT+erfQKGMm0scLV9do701+MNSDCv395Yb2yOmQfkPGWVMsLffy
 1KF2Mcxz8CrZj4Ns85ZP7lTDGAQBoxI1/dLfsfCnezsR+eJi5ir+BMHrh
 s3f71hW2eVMMR/wQKpd/0YVR47QAVx+wsp/xpUTV4Gz9xXCDiH/qlrOR2
 PLblys8nMzmQs2qTkBtN0PgXlN2df6mPBWjiHg7+BKhigpsJWaCJh/54h
 ltEHVPU5Ilogac87XaTBWTb2+jdfm8wPAhzdB0523CTRimoGNV4onXvyi
 9ZoHfSVf+QR7ZbC4bveXne13SMPmWFuSf1J+dYagmw/Wo5jcuxcXymckU w==;
X-CSE-ConnectionGUID: XS/MX0ZZRTWnubZiVGhXUg==
X-CSE-MsgGUID: 17qyrMOVSy6Y7RDAL7JMYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2017745"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2017745"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 03:02:40 -0700
X-CSE-ConnectionGUID: Rq1QzejmSxGScq2xvAvdLQ==
X-CSE-MsgGUID: 9Y8Af//kSz26Kngg1yJ1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6941115"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa011.fm.intel.com with ESMTP; 29 Oct 2026 03:02:39 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
 przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net 0/2] ice: iavf: fix USO for 32-bit systems
Date: Thu, 29 Oct 2026 11:01:57 +0100
Message-Id: <20261029100159.920118-1-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

That USO works on these two cards for 64-bit systems is just pure
luck. Currently, the computation of the UDP segmentation header is
performed using sizeof() a pointer instead of the sizeof() the UDP
header that the pointer points to. Since the UDP header happens to be
8 bytes long and a pointer is 8 bytes long on a 64-bit system, this
works on all those systems. But no such luck for anyone using a 32-bit
system as 8 bytes != 4 bytes. So fix this by using sizeof() the UDP
header that the pointer points to instead.

This was found by an LLM while implementing something else that used USO.

v1: https://lore.kernel.org/netdev/20261027121442.907414-1-magnus.karlsson@intel.com/
v1 -> v2:
- add missing prefixes on Fixes line (Eric)
- collected Reviewed-by tags from Eric and Maciej

Magnus Karlsson (2):
  ice: fix USO for 32-bit systems
  iavf: fix USO for 32-bit systems

 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.38.1

