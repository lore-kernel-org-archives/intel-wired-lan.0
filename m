Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4738606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8IuK8vgc;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LRz+KCdf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 858D040756;
	Mon, 26 Oct 2026 16:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujBPo3U3pZ7A; Mon, 26 Oct 2026 16:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB53F406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032470;
	b=IcQo9Yfo0ehWKBHr2mr86O/Z/kpN8B/W3dwwLVX4SEU4lXtBqCW0iNw1rFr/cJdjoUhA
	 G2QMTAd3vKCvAJdwDsthBYegVWmA4i5Zg7xMzgownY4ZpGVKH5GeXd470mwleVo3TTJXH
	 fDKUz3pVdPgQq+F9ECBdojH32H1R6W7WDIHKu4Hr3hupJjww1+7vI/X7p1t+vpGzcZFL1
	 1l40t1xURC2EL6XM4KEuS9DRmU/Pu7Y0C/y0zBfCbWiHmtGx3BrLvePKprCpD6WN3wDDa
	 RT+IWDTUzHyDNl0Xx3vvl8825cuOCXWsA5Qro2RReEN7Ys5kFNnDT2txomXOxX0MOpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QK/PoHM5+wgvodGyNDBQYbqD+owasM27mwqFVXbozAs=;
	b=D9oKNGyl3y/PBaoUt4E7wUnQ9Ekchd+18cP/aKgOaNMAhFk+7uBIgjCWi1s3J6//buXJ
	 lYSLeAP/W/0cn8E/SkW3L29V8DlV5MV0Xy0e2QEUh+bQyVRhahclGLEbyEHi4EI0bq+4y
	 MDqO3YEDhs4uCilSMU7Sc27adSaAfZsBNeudvPbQmu/QiPptAXdM7vT/vV83lvZ889GuP
	 d3K3y3Y+AfijQVP1DyeEFi1pQSFIziKn4Dg7f+WET+sT8Gsn/gvZ1kCBqtUf+btRUlGeK
	 FYZxNGnM4TUSnx2otRO1MG++D0KTnmZwQUCZ8r5XqxUkULmLfV8voO53yjln0moZuVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793032470;
	bh=QK/PoHM5+wgvodGyNDBQYbqD+owasM27mwqFVXbozAs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8IuK8vgckvIShuvEPIXGNQfHAQ7OpTKkYPp5TR75VpXtlZJ+DoQubI4N1j96lO5hv
	 B3cGs+8eEXQmOic2gq9e0Z4sEYv8bY3LodoSHQKaFNB1nQ3Amvv2RramYFF4sNY8rO
	 HowQhwQtiZztUURXRSTrCdBA19F+AGDYEcKsL+Ri6wqtnRSBdp7AezjUI4q4vB5uQi
	 lH6Nu80LbB9TZ8KGelCh3wwYkPwxh6rgYWrVxI/0lWG/cJwvMSDmxR0F/T1nl+EcQ9
	 9+DBEUnScYji7/m+FK2LZ+vQpIlWNvB+7Mc5hQN+WDU8rWxGmYWtzD0OsXsh1B2G8g
	 xmwIAAvOGU6Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB53F406C7;
	Mon, 26 Oct 2026 16:34:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 662F1356
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56BED80F44
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PR4GGj1kjInX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 16:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06FB180DB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032468;
 b=S6uvyLDi5cmwEL1VZP5jG4AGWJL6E0Bbw+s7USTYjpI70rRbvvuJUPxAKJetT0+QY7jF
 Mg9vOqfOWCcRwSCgYIS+X1N8SDni5uzkLm4ekZ4I5wyjvZPXtc6Oh9N2qc280jR1XmOrB
 KiPnUVk8xCT3TrKe6CxxRoYyPxW+NyYaDffRMkAbVyTuVrUgm9RVlcHJYXa3xwqLbAf+C
 iTtqYhPeM31L3EmK1YVgNp6cVuBXKjya62lODrXx60PfJ+8mtfa9XksHB1ak+4Aj0GruL
 oIC9K6r+queEsu7ssiF5098FBHkhAHJ24TAxTVzFzgXbY5i02tPprRhvPoLow4Fh49Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032468;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=QK/PoHM5+wgvodGyNDBQYbqD+owasM27mwqFVXbozAs=;
 b=E7k7Q2ha7ny1KFCVd/MrkVTjt2lfyVL4pptIqMleIAWVeIhPXmLAmEJmOxzeOV9IyEgB
 Vm65/uSih8K4VFjQOiEo1a0U7mnpkPB3570b/B6y/MrHuG7Ar+GvcvtMCWkxdDUptZ/pG
 OllynU0WvfRqFZ9wtMZjI9M86tMNuv+tHPdwj6Sa/aZ2bNNqT/NVn8VNQbh+CWqg31OBP
 JZwHgXId/4dnCpPbNml9eY4+O0x+TJ23ey2ILZZT2ZOeJW784VzVNAozwHpOv27121+Ap
 YO4szzNWwP+KmjILFgXbDfvscjyhpACWPiVThW2a7MPVdxfh5En12g1k2aZj7/j4ApA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LRz+KCdf; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LRz+KCdf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06FB180DB9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793032469; x=1824568469;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=86qXUPydmouqTil5Ze3OwFmndJELU168k/JBbzKnthc=;
 b=LRz+KCdfms2IB2BZM9n1nWX+N90N8A8wsfRbkkvI0wGmCdqorH0gyjwN
 hLdQ98dJrMtMfVxHnC7Y7H4tW6gqCuDn1FxTkcFsgmFXdceopA6//DGA5
 tdEJdniP2jhfIeObNgV7VfJHeWxxZcukxedwZvafNSz/TUEb2OMtIEufz
 4TQ4sHWyNBoBx8w9h8mUOvorfTYIhSS7+dTj6XuaEhL6mh6MKcON6uq6L
 ZhGOpzOex9mulCJc01CZhrm8stZN+WdDA0YnJi9+kcE5oW0A+EW4pAj/q
 SVw9fq5h1eCRm3KL4BPMz3kD/pPUb/xswl/1F4uZfoJMTAviq1xcBGKw2 w==;
X-CSE-ConnectionGUID: ZStVcisKRGGeHnbfgGPtDQ==
X-CSE-MsgGUID: VUxZhSrkS2u3N/lYPSUE9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1588004"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1588004"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 09:34:27 -0700
X-CSE-ConnectionGUID: JxvY31gbThOuoZxQAIXDEA==
X-CSE-MsgGUID: 5vmTiWMiQ7a4iUWv6/9t6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4707988"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa007.fm.intel.com with ESMTP; 26 Oct 2026 09:34:25 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 0/2] ixgbe: fix Rx timestamp in packet handling
Date: Mon, 26 Oct 2026 17:36:38 +0100
Message-ID: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two issues with Rx timestamp in packet (TSIP) handling
in the ixgbe driver on X550 and newer devices, including E610.

Patch 1 clears TSYNCRXCTL.TSIP_UT_EN when Rx timestamping is disabled.
The bit was never cleared, so frames kept the 8 byte timestamp trailer
after timestamping was turned off, with nothing left to trim it.

Patch 2 enables TSIP for VLAN tagged frames by setting the per user
priority mask in TSYNCRXCTL. Without it, tagged frames carry no
timestamp in the packet and the driver falls back to the latched
RXSTMPL/RXSTMPH registers, handing out stale timestamps. This made
ptp4l over an 802.1Q interface fail to converge.

Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>

Przemyslaw Korba (2):
  ixgbe: clear Rx timestamp in packet enable bit on disable
  ixgbe: fix Rx hardware timestamping for VLAN tagged packets

 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 7 +++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)


base-commit: b7e46a73815485bc5deb94945e50594a8bf6b499
-- 
2.43.0

