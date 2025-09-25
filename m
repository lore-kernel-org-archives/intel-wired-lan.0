Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5479ACAC5A7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Sep 2025 15:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25A5584261;
	Thu, 25 Sep 2025 15:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tr7ITnSr8j6t; Thu, 25 Sep 2025 15:34:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACA1F84248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1758814456;
	bh=aqeFnuj24wD8+jGhjWuaSekDJWucb5BCLPpLVXABYxE=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CpdHusHN7JMqktTux0vljvVhwJTpWGJCfyn/bzwdqKze+Qws3x5FqEyzoL3e5SSGm
	 4XGdPr6XaYWbLKZibWXLeY9qbaGwoWliaN9hwOH8Mb/BPzm9svqu9kyQ8Fj7ddVKbN
	 WKhlGJqXUBF8jVUHSJGYwx9nTYaOv2qhZ5dXsDKqkIIcdkwiJP66yjL0FAxlz76LWI
	 F+zo0Q3AztWpnmHiBgkAeTZI8GRJaUnohugruaFEuIDKdNfZtG3RUFXRfEfnb2503A
	 OCkS4Z7BX1WRUy4F8P5wk6EyU2m08R1LNlmrDQ8HuK0FT+InRN82ELeWXbGorCXATD
	 lGnR4mP0hoSoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACA1F84248;
	Thu, 25 Sep 2025 15:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC32412D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Sep 2025 15:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B29448423C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Sep 2025 15:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhnQNZC3e_6t for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Sep 2025 15:34:14 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 25 Sep 2025 15:34:13 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0A84584176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A84584176
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sreedevi.joshi@intel.com;
 receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A84584176
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Sep 2025 15:34:13 +0000 (UTC)
X-CSE-ConnectionGUID: Px0PUnDVQYKxmuIczOv7iw==
X-CSE-MsgGUID: iJWntazZTU+h+W+JL7DR1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64947222"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64947222"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 08:34:14 -0700
X-CSE-ConnectionGUID: +4ulARLdQE6r20O66+p8Aw==
X-CSE-MsgGUID: mB3Tsm8WQKmq9KhPiy580Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="208298236"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
 by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2025 08:34:12 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: sreedevi.joshi@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Thu, 25 Sep 2025 10:33:56 -0500
Message-Id: <20250925153358.143112-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758814454; x=1790350454;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3YKOg37lRqU0z0GBKA7dRSt2FRziUiOoQM11WCx5/WU=;
 b=jUx7uGHCXHE5PDoMbnfBvHX3ES+Y7wWEzT5AQnZsQ+SV8FfTbltz1qfr
 szp6RtDJFQitSP50GPgyMI9oyJHK+rrF4JdobmIsOTOPJpBMY7P7Id9ei
 Nsb6tU9TgWI3wr8anq5LSZSXoNmL2saocqGm3kbZB1wylKkm6XCRnTR9Y
 kLm6gCEGk0h4DiiJ0IizMX+j3yFjLscPOyg9tRdu5yVfBVPAW4ji+wsX6
 l1abRo13+5kCrp7uezpdZ8qOXTO3XMfY/7+25mG3qv9RhNyTZpyI918U0
 a6wKWPfM7pSgAnLo9jAMRJphVN7vR6xvFXIin9m48IcLplgU8SK/Yn9xB
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jUx7uGHC
Subject: [Intel-wired-lan] [PATCH iwl-net 0/2] idpf: fix flow steering issues
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

Fix some issues in the recently added idpf flow steering
logic that cause ethtool functionality problems and memory
leak.

This series addresses:
- Memory leaks during module removal with active flow rules
- ethtool -n display errors due to incomplete flow spec storage
- Add logic to detect and reject duplicate filter entries at the same
  location

Thanks
Sreedevi

Erik Gabriel Carrillo (1):
  idpf: fix issue with ethtool -n command display

Sreedevi Joshi (1):
  idpf: fix memory leak of flow steer list on rmmod

 drivers/net/ethernet/intel/idpf/idpf.h        |  5 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 72 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 28 +++++++-
 3 files changed, 80 insertions(+), 25 deletions(-)

-- 
2.43.0

