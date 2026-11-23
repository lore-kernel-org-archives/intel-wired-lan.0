Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B840606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=H7od/gwD;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bT4vrT2e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED3B740500;
	Mon, 23 Nov 2026 18:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpU_CmlQumqr; Mon, 23 Nov 2026 18:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69BC140507
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459212;
	b=muRGXrXSTdOoXap3k3rUv7Z29A74EFRrG0IgZXHR8wkQczxb/Mzp3YztNMtVuUvPTi3v
	 VhHxwQO9zZMI+HQn2QM05dnDgaMAWczlg7oDiznKo37aPiSc5/+kbbzUH9piS4pUjZawR
	 14QyLQGQZwZhAhgjKijxDFBFt6064aWOp9AhrWDJVBgBxVbY5xPFLSvgdsKB2bogZ6XT9
	 3hH7p/tSVrWDsFIahRlFTubYAg2Gtn/AQT0U/wcOEVuOygYDT78HxpVsMTrZOWF9dndQn
	 A/VAiBZWipat/zHXZdIW7WkSYg6JkLO/Cjpoi/w3guAKczUsj1h8Jnb7PjGxULufEXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F+Kxp02zHHEX3/3+BfYexdSU4CbwlOHe5aVduBlPDi8=;
	b=cXa2PMyCs2DDkT6H0IltS9BYIb4KXtstX6FoxnAOq31xe0PmURnRsGuqV8QhuQJgCGjd
	 z5SFdpb8UxRJMFIsLvM8GmV67IEX9OUmbV8jaMoafDegDDfwGw2tngyqQFv5oibhzUJOt
	 qmrwmdJ/mp3CbPPA9M9B3UncZNEKOvUmdf8HAhegyHGDn0xy9sav+cQCs8h3k/q9OoGN3
	 5MBeLUa3gjqplSsYsmcJ5ovZOnwerb+3aXtZVUXXAVGGBFC1nNBB8lQst5CxwLmrfCfQF
	 BSFzkK9vFKX/r4dcEnMXAar8nUZdDI5/TQ//jyy0A6mjW3gXwI5SFWocZT2MMidLo1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795459212;
	bh=F+Kxp02zHHEX3/3+BfYexdSU4CbwlOHe5aVduBlPDi8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H7od/gwDiEOz6cqEtR7A2bdiQ9WBeAzVzQNGpI64QNCGhsXTfg0KLGMPf8ifvv89m
	 ZZtwmSbYD4vF0CW+hGXYxUsrTNlr/lmj2T8UH52U5SfN9WHXy+EvGYnHra8rYsaHLt
	 U9Qh1WRsEAPCNK49qRGl+pHiAFSZVJFo4yWA3ZSuygtlzuFhu1p+ZL4wz5F9SjIGsp
	 AmAUqmr/2znPNNX5CekTRnTWYFDHDsJym9zM1RldZDUbJY5PhkD7Wd4Gnso/Avlz2D
	 zVg+m8mrz4A2OWZLMC6lNDgGU/+xshbiEySgrpRQbaVsMRkmzMLctpnW8Jj5sI9O76
	 9HDG35/WC6GqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69BC140507;
	Mon, 23 Nov 2026 18:40:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE54A3A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBF894021C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f07uh05YcnHX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 18:40:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 32D5340093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bT4vrT2e
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32D5340093
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795459211; x=1826995211;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=y01KVrh1lkH9P0Hfd8bZ5/2P4/Qeg35IPf2x0cwMkVc=;
 b=bT4vrT2en1jToGsYp2ta5X6tOQP99coTvTYgsF01bY64WL/jjHg4Zx44
 kfuhdr3pW1aKll6eTHDus5vqX7oQNkXY6EUJSWJNcp1Z+ek525VHEU+b/
 OHObA3O7ewj82Djt/PeybHvMREPUC9/VPuXWHiQ9exbYwt83+Fc2MeThA
 UuDGsf6rbHSmhb6T/qAUO52ZPKzzwnB0Nhc1jmTtHTZ36NZ7L9ATL3ygC
 Zvphxf3hJ1jsJFES4Je+EFAiO0hFdTu14TlhbyfdrqVhcYeTuEx1h8Bf4
 Q3FdzIfZ0NlxDTdCRKcaXJCx667zsKPvnqZ+b+NBC87/XkpTpiJVnpCSu w==;
X-CSE-ConnectionGUID: sXwwpq7dRP6pQLFBM1VC6Q==
X-CSE-MsgGUID: zNq9w/y1T6WDvDsvOiJcuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4157656"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4157656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:40:09 -0800
X-CSE-ConnectionGUID: SnH4d3SoRCO0ZMhSdtnoZw==
X-CSE-MsgGUID: 1w/WKjnKS9ykmUPdtPmhtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11245363"
Received: from ccdlinuxdev13.iil.intel.com ([143.185.161.17])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 10:40:08 -0800
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net v2 0/2] e1000e: Remove unnecessary workarounds from
 Nova Lake platform
Date: Mon, 23 Nov 2026 20:39:54 +0200
Message-Id: <20261123183956.1177222-1-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a dedicated Nova Lake board type and associate its device IDs
with the correct MAC type. Then restrict the K1 workaround to Meteor Lake
through Panther Lake, excluding Nova Lake where it is unnecessary and can
degrade performance.

Changes in v2:
- Corrected Fixes: tag in patch 2

Dima Ruinskiy (2):
  e1000e: introduce new board type for Nova Lake PCH
  e1000e: remove K1 workaround from Nova Lake

 drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
 drivers/net/ethernet/intel/e1000e/hw.h      |  4 ++--
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ++++++++++++++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 17 ++++++++--------
 4 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.44.0

