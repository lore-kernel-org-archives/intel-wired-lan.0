Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E69606B0F1
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=c0O55vsK;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dm5fjoQj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80B49607FA;
	Mon,  2 Nov 2026 15:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVHUUtSQdKxc; Mon,  2 Nov 2026 15:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE60D607F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633722;
	b=VogTQp8hiKN8LAG0ScWNbXHTRPN9e87vpthg87bcCEh4wbFrUog0JrCEHiOPpcs9kIKc
	 RKcVXv0w/hU70a6Pm+Y9Sbxk48QXVvnSo0v6+yY/+aMbk94XF2a2hXKvAK4LYEKnkGMA7
	 Kl8+SgbsHkRE2xjcr1n2vncG8Ruu1BjkbLV6VE2+yzOLguWWqDVWx+JaUIhj98+FPXToO
	 CLqNFAT2tdLfvlehxirk0bZLpUDxxxnIaCOxThCmAoEQbw71RNElTk/k8olqPAxrKHSgE
	 NJKV6maiuUYhgLbxF+316pYwCIEJZTSW1yJt1y2D4aMei8tu7goViwLjzMvm3N96wCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Nnr98Ips5/sDTLsCTy1NRIc6cmGwTSY4qBvs0caazIQ=;
	b=VDNINzE/bclhoec+Ry1eZ62hm/GuIAcBPzCLQrRns422E5an0GS+dCo+056U+6KdwahA
	 Wx0EBdzfGMPP0Dsfwg0v1FoW82Fsgr8M6xceMsCypQacpxc70V8DUVMVDv88HPAkgQnhr
	 Qw87pPB4Y+I9+u5Zep6LU3DKB+zW0amE81bjOVMhtS7R3wT1WF99vkdjaWg4Ukh2bg9lr
	 YYgD8F1pf0z5BLw/OFXt32fMT35WljwRqjBYKKXKTgKHVWEfyObECGCFQWo42vmCosXaN
	 UCPkx+qnAYTvTUQFv3Ir6OKPuRP1UPZ3F24rTwQaCgui9kxukkNagSPrhfGsRJEyKKw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793633721;
	bh=Nnr98Ips5/sDTLsCTy1NRIc6cmGwTSY4qBvs0caazIQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c0O55vsKXY6xDfyc8C5h7179gUiUuZ7AHWN/7I5w6b2CRFOJ8ci70KkHd5FCCgi7S
	 WiNSvEoUUQ9LO25EuO1UImHUZfrPUZuY8z5nCKtcFNUjzGKyk2t7y9k0zL74j3uBAW
	 uPrywV0QOseFsg0hbx+RJjLhRTZU2JKh1x76BkhPKT9wOcnrSmeO5J/C5AFroWYosS
	 SqnlVEeppLyk2N0Ep1lOBMqtVQ6GaCADp0w+4qjscBzduBkYEWfL2P7YimEyX1lUbg
	 +viZbq8I63cT1x2KqcpOhXugZh9GT8TWIDS3atbWPTLEUUwmrhIUk2zgv4u1cKcQHu
	 gWUSZJoV6mMJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE60D607F3;
	Mon,  2 Nov 2026 15:35:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43758EF4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34E944007E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id saflgJ8mM-_A for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 15:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6DA56400D6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633718;
 b=ai1IDgc71jiWiyH9lrMI2AZ/nmTbLdPrcfmptUtyXXhii3msY52+IX2F1Voef/Zf9L+c
 FpWv5zjBYFSO7OsFC6/KkkCLUTLvDfxAF9wV+GcDKEOy1zdBUDGov+3QCf9pR9fIE9nVz
 HETTyts8wZ5ioV3eGCtcmzVOxCDws97LyMeXucPujU2rwqZyUGcRWPkGGCsIOcy3YOpzo
 eX0aBmdYCkymB6xp1g8z/E6y28sMs8ppTeo0bJGES8XfRjfdrDMS5C8o4weeDdT8/PKca
 YlJZYmc53LITIvAc/I7lOzD3MrUbfMU6VqL0SI+Ag2FpJ8ZheyhFwAIGp7AQISeJH4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633718;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Nnr98Ips5/sDTLsCTy1NRIc6cmGwTSY4qBvs0caazIQ=;
 b=koef/zh9hDpeUYvtaZUzcvPumhvq2O10rH1SnPd8OU7VN04CRKw5yCVt59CLqIyVms1c
 jlQJHOL976pETJ2UiUz6Vb+J+w9/qa9+hRn5VfY08OPlUVHf4XteLZpF+RbjQpHcKhy/Q
 wOeak6pXC3V8qsDD2uj28JhYXLfqcgt+ZvOtWbx6CwDmC68bCZO+0q1kZcPJFPvcQe+dm
 +gsN16QNo5mPvuBSUZot5NbH2r1NDQC7rvJOLd1D77DggdkWvAmcm2EMroZuiOy3DNJNf
 xkVlsq+AVbvA0KZmTQW+Lxn0jehx7xQnhjFUtnfiRmzMee5FIY4W2NIkRANOXYlRxug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dm5fjoQj; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dm5fjoQj
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DA56400D6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633719; x=1825169719;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EIX6/hiK0qWbnVeAK5gKf8yXA00GBK0gaBIUXSs2i8A=;
 b=dm5fjoQjXR7ywZsmehUFeb9qI4ERYg4JGdAmB08vhte9Ad7MfkbqpsjG
 Y8D/Ttp3nP6iJmmMu0o8bZ/4BHLhPJivh6mAxEjORbfI2QaJWopK4QFbT
 nzZFZufHmTuQsc5Ptw5/U82oSmeMXOus81zBwpnRTRKzimgom1sE6xyDZ
 0ndtMuT5ZS0oJtPW5x9J9I8ulhxDlL+Sq6ih5KJ61kGgEewpX3rwWzKeb
 722Is4g1IICOlTTQIcu7QDTFECI99fzPqSQ+ptd4YI/XAFVkEs4GWTwgk
 44Wg8YtaYIt6cURvhd1D+zz+JzoWu2XCPZHi1vhhRJIWojziOzYzEUY56 w==;
X-CSE-ConnectionGUID: ULs/x4NaRW24azRsl6U3vg==
X-CSE-MsgGUID: NdSiCWM4QcCfgWGPmoQrOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2210862"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210862"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:17 -0800
X-CSE-ConnectionGUID: OA7OED4bST25VfcS/ZUiFQ==
X-CSE-MsgGUID: nWq71kReS/C2QDA1wvtyiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5999761"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 07:35:16 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v1 2/4] i40e: fix raw ip4/ip6 flow match docs
Date: Mon,  2 Nov 2026 16:35:09 +0100
Message-ID: <20261102153512.1601855-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102153512.1601855-1-aleksandr.loktionov@intel.com>
References: <20261102153512.1601855-1-aleksandr.loktionov@intel.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The raw ip4/ip6 flows match only the other-IP traffic.
Fix the stale examples and rejected qualifiers.

Assisted-by: LLM
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../device_drivers/ethernet/intel/i40e.rst           | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 92015b3..b47db47 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -137,6 +137,18 @@ only a source IP address, a source address plus a destination port, or any
 combination of one or more of those four fields. The raw ip4 and ip6 flows
 reject any port qualifier.
 
+NOTE: A flow type selects the packet type the hardware classifies. The i40e
+driver programs an ip4 filter for the "other IPv4" and "fragmented IPv4"
+packet types, and an ip6 filter for the "other IPv6" and "fragmented IPv6"
+packet types. A filter created with ethtool(8) in one of those two flow types
+matches only traffic the hardware did not classify as TCP, UDP or SCTP: ICMP
+and ICMPv6 frames, IPv4 and IPv6 fragments, and IP traffic with a next
+protocol the hardware does not classify. It matches no non-fragmented TCP, UDP
+or SCTP frame, even if you also add tcp4, udp4, sctp4, tcp6, udp6 or sctp6
+filters; use those flow types to steer TCP, UDP or SCTP traffic. The driver
+also rejects an l4proto qualifier on an ip4 or ip6 filter, and a tos qualifier
+on an ip4 filter.
+
 NOTE: The Linux i40e driver allows you to filter traffic based on a
 user-defined flexible two-byte pattern and offset by using the ethtool user-def
 and mask fields. Only L3 and L4 flow types are supported for user-defined
-- 
2.56.0

