Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F8606A32C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=itjXdSJc;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d22nyETS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D696640B1C;
	Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMkWU9UDVwyi; Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0040940B0D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097528;
	b=tSg27DAyYwNWcaqjigSxziQaXFJXhkiDLBUgc9gYSwHT57h3cko83DS9mOkeNzi3zoQZ
	 Ytar8ULSfpkNo2Ss2hx8IxAdmAU7dK9y+Z+36ZiPTTJWxmQAIGRhnirhIxO6FUy9F70jl
	 AqmPpiDrfQ3VyuG9z7omWivkh9m0WE4I+LBlO7t4UGFKIyqeekDFxG4gvdbJVSscZ35Kl
	 sx6ecTsRPV3jwxtZh6/X3DvRHblmtdXQhSi3MzHHlV/fAs6mRQvgg7fUDevityiEzPPOh
	 JVopRsbgNQBi0lWisQt65K3/Sjhke5oUOQQ3+u4IWYUM4u+49pdvj9pB0VtRrP0Cn5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hjPafoteUj1iw0RBESfhj6J5Ljt4AJY84jyyN+kenQM=;
	b=MFWhX3iu5TmHunq8miPdLmriE0HYIw2Zs3nXdqqy9gbF0lz5ouTPs0viUwi7M8muOIsZ
	 JOIJ6rMFChV9E9RzcMqOXqEPxCoHTy1Jkir6GOAVZ24W6z3uXBzzKLPMaaWI9sNE+yi4p
	 CfHIk14YobLDhw48NiRhfjlW//EYW3qbSDuVH7EQxqBixTdDW8ayY8KBzfLdhVVphtLHY
	 oM4A9p/NRxRj6vOlOBl/U5OwABwHdexoCm9a7ulVQHUjliZUGcLbAD1Z0QIx2eGhGiRaS
	 ONKhVCiUbXV3fe7qKLJGwQgEpL8GUCzxWJ7CtrNw3OA5z2gT4P8EDzZ3gK82cssqc0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097528;
	bh=hjPafoteUj1iw0RBESfhj6J5Ljt4AJY84jyyN+kenQM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=itjXdSJcQss5jYyow0t5WlNayhoIVDu1uP1VY2ll7BJegF14nPeJZlKU20r2VNnKQ
	 umYY5ab/Mq1DNBCVbnDqEROxe/4vtWnKbFffhVWfzW8RsezecdjhbtELCKE5uj/04x
	 K+d06t0xdMVNoBgHmpJ+9Q1tOzwHqWZl0rrI2x8KcozRr4FTTbf8Jga0+eR2lysN2C
	 TzQ6m2ukTgtP1QgJsS69axLK0d9rzVf8dNqOeh9z4RZNL4YvcjF9yq5D/zzShvXjEV
	 e4pVQK9+XaoW35HCJMvtRUi1dfwiZRQx86X4/XppEIfmvEaUnrZcjzuSAG4vbt478A
	 eRlvUcafnLX0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0040940B0D;
	Thu, 19 Nov 2026 14:12:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 759481C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6721D40545
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycCYTJ6ogOm2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:12:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 74A0040542
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d22nyETS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74A0040542
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097525; x=1826633525;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qJkPdyW4rtOLe4wx7726HY9qvRhlKUetk3f9wwfNTFU=;
 b=d22nyETSRL0PKDr+NVjMRvkRDnCEMnvQoGdC/clVb2OZupkjxJfDacII
 dlHa9zEjJsrbPCzocj2spVQhjf1Saog7RHK5XIcBAsaQN8LYCRs57pPyS
 OXk7aI6UfCBk0S5nc8yM8ZUMmj2Uo6wngZKt48OKqlBo3aXTfdGk4kjcd
 Z/W9APq2qbuZjWzTchKqKZOQZuWCzbUuEeUxPT99Wvzd/QjVy1kO5mLbE
 0gfKN2LhlSk3q3lJPXi9oVrwdIdKqns3Iy3jzufSPrjANLTzeVlNE4hEn
 EOKbIEw3+JXa53mVHRFCTGK3dE1xdzBhAqR5CfrrAc4o4TCGRn2/zUvlX Q==;
X-CSE-ConnectionGUID: srhWp2H9RZ+gF/u3nzn3Fw==
X-CSE-MsgGUID: 95JUWUv2RgWFJDHE/L0n8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835623"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208,223";a="3835623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:12:03 -0800
X-CSE-ConnectionGUID: MGw3zx9GRVKv379Ple6uCQ==
X-CSE-MsgGUID: rD8NwF/GSdKPiFvhKvuZrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208,223";a="10476144"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa002.jf.intel.com with ESMTP; 19 Nov 2026 06:12:02 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 0/3] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
Date: Thu, 19 Nov 2026 15:09:35 +0100
Message-ID: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From the first days of XDP implementation in idpf, it relied and
worked solely on top of the queue-based scheduling Tx mode, which
basically means simple FIFO. However, turned out not every firmware
supports this mode and XDP doesn't work there at all.

First, fix two already existing issues found by Sashiko, then
introduce the flow-based fallback for all XDP paths which is always
supported by any FW. The actual implementation is selected during
XDP program setup basing on the caps that the FW advertises, so
that firmwares that already work correctly won't get performance
regressions the fallback brings.

Alexander Lobakin (3):
  idpf: always reserve one empty descriptor on XDPSQs
  idpf: enforce strict ordering on BE when reading XDPCQEs
  idpf: add flow-based XDP fallback for FWs without Tx FIFO support

 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  18 ++-
 drivers/net/ethernet/intel/idpf/xdp.h       |  60 ++++++++
 include/net/libeth/xdp.h                    |  13 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  19 ++-
 drivers/net/ethernet/intel/idpf/xdp.c       | 152 ++++++++++++++++++--
 drivers/net/ethernet/intel/idpf/xsk.c       |   2 +-
 6 files changed, 242 insertions(+), 22 deletions(-)

---
From v2[0]:
* new fix (0001): fix already existing issue with not reserving
  a required free Tx descriptor in case of XDP Tx, xmit, and XSk Tx
  (Sashiko);
* new fix (0002): enforce strict ordering when parsing XDPCQEs on
  Big Endian (Intel's Sashiko);
* rewrite the bitmap set-reset implementation from scratch to fix
  fix S/G: HW generates a completion per packet, not per descriptor
  (Sashiko);
* fix excessive allocations, possible pointer overwrites, and corner
  case static key imbalance when setting up XDPSQs (Intel's Sashiko).

From v1[1]:
* rework static key management: move to idpf_xdpsqs_{get,put}() to
  avoid refcount imbalance issues as .ndo_bpf() is not always called
  in pairs (hardware reset etc.) (Sashiko, Intel's Sashiko);
* don't zero the whole pending window but only the frames sent since
  the last batch to avoid missed OOO completions (Intel's Sashiko);
* micro-optimize idpf_xdpsq_set_rs{,_fb}().

Sorry I've had health issues for the last year. I hope I'll be
restoring my usual "usefulness" (reviews, submissions) on
the LKML bit by bit.

[0] https://lore.kernel.org/intel-wired-lan/20260818155101.2416665-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/intel-wired-lan/20260708151327.1091570-1-aleksander.lobakin@intel.com
-- 
2.56.1

