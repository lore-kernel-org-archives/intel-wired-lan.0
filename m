Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C3606B0F1
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZufP4E90;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XS2pZ9k0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2F3D8108A;
	Mon,  2 Nov 2026 15:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AgUXxfyjyTa4; Mon,  2 Nov 2026 15:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 34E4281090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633723;
	b=A4RspRauoujyWa+fmRca5eIHXfT4sHk/a/ITPPwoU5Z/Ic/JaYQHjbrFAjPsBt91+zSr
	 BFHip92qkU1PFjxvV18XaGC6YSfo04U9AyepVbTH0RcJFF84nZbxHS7HGCeJ6p28rAK6L
	 2+Oy+qaA0oADEcQGRpUGA6y8OgMTnDmgRyDU2oCcfluwJiUh6PaYJDO+9fpGDd/G24i5i
	 xmUwwGsBm/pO4DQklEoyK+6ZJaIsSz6paeB1SWFyOXfKUt7/e1SpddmhtSHUcO0G4ktxr
	 GQImjU9tC6CD8Y8xXxS3ZSzY/kqTUnS5MObhb6aw0Zu6BV9sPs30QNlkmXZGZUkNyUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2WaRQZc+Q4ZEeFmN74uLGmR8XwggSYLXrdxJ9V4dwaw=;
	b=WVT0B7dUuW5CR1NV99QqwMC0LoVnAZXNajnLnafc62h4rccUbXXw6xvnpKZzPG0Wj7hN
	 juO/CPSmerPEHXvPDp36fT/e+KsOEkTU2Jcg0laFiUevdfeHF5TpK2sLdRCwbV9Ri0tqJ
	 9/IdtpdatcmMaGgW0jCWO3nROfZLUowRSLz4zgJy2Rqh72N+XaIAyysILQD1rm9dkneaL
	 JGr1VmbwyxSn+tx606ypo7TJlzj7cgrObIDZjdYPe2Gnff7KnoenHzQ0jNlGKg+r1QrVO
	 NVr9dNtGaQf+nufB21Erd0btVYnnmSXta7xuZWc7cDyZCJ1TLhnlV5/mR20iOSuVKAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793633723;
	bh=2WaRQZc+Q4ZEeFmN74uLGmR8XwggSYLXrdxJ9V4dwaw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZufP4E90OJMdIbkEAscvaQOT51yjqKUEl+jAyFbnLIixkwNoeN2ZPp91q80KqWp/R
	 Y/CL8/8eDM+CNFw0bHxoyZLejJvhA7YO5J2oGhLiqDUcOqKugbwaZKst8yO76NNvcb
	 bg0AjVDFBxRtNsqJ19pBG2CfwPN/3F635U6BCMNkJxzwSPoz7RJIJ4eEos309yksF0
	 hXQXxNn3L07K+890GhMeqGp9A9ZVd+Gk5ioG9Wat8HjX83VJmy6WkL9ehEGbklb1gf
	 To41za7DWQsUhGv7A9Via+5he8J5ak/tF+cgjy0XjyYpPCeOS3HfHaq/rNqqEZteid
	 VFxUyMNOjqB6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34E4281090;
	Mon,  2 Nov 2026 15:35:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACAC4D3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E7B6406B3
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OyOX7GwSzkbN for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D77FF40695
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633720;
 b=oO09+SQt3JrXhlolkcNSm+/KafJwzxAewCyuC+6ukPy5QSWlijQcRvf6C3YklA08Rzqq
 I605OwJheQ15lWyU2HrD+RC+SLpCA4GYXClYvTaI7LAsItOw8Dk4j/cqaZPXkvlihGUNi
 qCYS+GEFsdwEj2Qi5XPlszZfdQEwslrEkO5VHHDtq7SHrgAdaB23LthqgAVs9ISUYnkCK
 BrVf2AueGpgWEYGechepH9SPsNySke7FkpgNpD/zrxhpOgNcYWKviVMCIlDpTHNRi7qNT
 Vjpu976SKVMlAN8fuHdJzHVw5V2bf9dTAhN2wjcc3gwwRv2z/kZFy2NMwQKhVoNsEIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633720;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2WaRQZc+Q4ZEeFmN74uLGmR8XwggSYLXrdxJ9V4dwaw=;
 b=NlvXukgzud0YCNaTUQEUHoYpXED9bd3uQe8jSTjN2sD6YxEqUBY7/fIAVTLHQ20zHGMX
 924u8AKOVhymTlAhXRsB2o5htsfMsD3Rl3a4DJbaZqTisJTM8a+HlkmP5q2Zp9lcADWbx
 3FmLzcTb1flOc45BPfbTKrgmU8X5VUkrgceFgpHEbKe7nG3Dh+dQg85B/smIjzgYhad+a
 LIxOG9ODzINl7bJBWLVYybHc1oUwMcFEPjV15Z285B0MCKRk4ToNQqQs+An4nhnuwuWD4
 KhW0GNZEQrvAYxiDlOzlMFYkklGCab4qarE8TelXBUNClHFTUKhokA0oiRy90Fm9xsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XS2pZ9k0; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XS2pZ9k0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D77FF40695
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633720; x=1825169720;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kUTERZJMLouxqhq6OyVayF/XBYtAE8bS5huDFpgWRLc=;
 b=XS2pZ9k0e4Ny2D60g2470sqGjv46Z/xubk5beJKdAhVdmyT40bsgckA/
 Q3jxSHW9qrMXV8Y8H/TRdMb2Fb4g/haGJjGsDxHjyQJsxn4P4M5gp7FIT
 r1hX36iM0C4jdUj9+UWxHFr/qXNsGnVqhXkESgJTd9dNCWEfJ7ePXdLFk
 tzBalY88p+Ru8iPVK7aEqt/K/5FpphinOcZ+3JFcmfmnsvSOUBDLtZ3tv
 ULWEJn6l2t+7JXz0ImPUGlHOlqx+iuWdyCt5uJKI+uOCJS3SATegwh1E+
 +wsOWq251FvdvpmfmxVAPvTWZDBEyJFW3CxOGIXj8ReNkNmlq4WDZVQDu g==;
X-CSE-ConnectionGUID: t94Rbz94TjmP8HhargR4mw==
X-CSE-MsgGUID: Nrgs4z6LQrecx3s+L4vB6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2210872"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:19 -0800
X-CSE-ConnectionGUID: 3WExDr+hRb6ZV2Obwswswg==
X-CSE-MsgGUID: vijiAQ2MSTC/SgihnB3wlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5999784"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 07:35:19 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v1 4/4] ixgbe: document raw ip4 flow match
Date: Mon,  2 Nov 2026 16:35:11 +0100
Message-ID: <20261102153512.1601855-5-aleksandr.loktionov@intel.com>
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

The raw ip4 flow matches all IPv4 traffic except TCP, UDP and SCTP.
Fix the stale docs.

Assisted-by: LLM
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../device_drivers/ethernet/intel/ixgbe.rst   | 54 +++++++++++++++----
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst b/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
index 1e5f169..1cb9935 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
@@ -329,13 +329,36 @@ The src-ip value that is written to the filter will be 0.4.1.2, not 172.0.0.0
 as might be expected. Similarly, the dst-ip value written to the filter will be
 0.21.1.1, not 172.0.0.0.
 
+NOTE: An ip4 filter matches every IPv4 packet that matches the remaining
+fields, regardless of what the packet carries above IP: TCP, UDP, SCTP, ICMP,
+an IPv4 fragment, or IPv4 with a protocol number the hardware does not
+classify. The driver leaves the L4 packet type as a don't-care, and on every
+MAC it behaves this way; the only measurement that was done was on an Ethernet
+Controller E610. The i40e and ice drivers are the opposite: there an ip4
+filter matches only traffic the hardware did not classify as TCP, UDP or SCTP,
+and matches no non-fragmented TCP, UDP or SCTP frame.
+
+An l4proto qualifier turns an ip4 filter into a protocol specific filter:
+l4proto 6, 17 and 132 program a TCP, UDP or SCTP filter, and the driver
+rejects any other protocol number. The ports of such a filter then take part
+in the match; for SCTP this depends on hardware that programs an SCTP port
+mask. Without an l4proto qualifier the driver rejects a port on an ip4 filter.
+It accepts a tos qualifier and ignores it, because it programs no tos mask: a
+filter with a tos qualifier matches its address regardless of the tos value of
+the packet. The driver implements no IPv6 flow type and rejects ip6, tcp6,
+udp6 and sctp6 filters. Filters can be programmed while ntuple offload,
+described below, or hw-tc-offload is enabled; either one keeps the Flow
+Director in perfect mode.
+
 To enable or disable the Intel Ethernet Flow Director::
 
   # ethtool -K ethX ntuple <on|off>
 
-When disabling ntuple filters, all the user programmed filters are flushed from
-the driver cache and hardware. All needed filters must be re-added when ntuple
-is re-enabled.
+Turning the ntuple offload off does not drop the programmed filters while
+hw-tc-offload is enabled, because either feature keeps the Flow Director in
+perfect mode. With both features off, the filters stay in the driver cache and
+ixgbe programs them again in hardware when either one is turned back on, so
+they do not have to be added again after such a toggle.
 
 To add a filter that directs packet to queue 2, use -U or -N switch::
 
@@ -362,6 +385,10 @@ Where:
   <port> - the port number to match on
   <queue> - the queue to direct traffic towards (-1 discards the matched traffic)
 
+The two port parameters apply to tcp4, udp4 and sctp4, and to an ip4 filter
+that carries an l4proto qualifier. The driver rejects a port on a raw ip4
+filter without one, and it accepts no IPv6 flow type.
+
 Use the following command to delete a filter::
 
   ethtool -U <device> delete <N>
@@ -375,21 +402,26 @@ directed to 192.168.0.5, port 80, and sends it to queue 7::
   ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.1 dst-ip 192.168.0.5 \
   src-port 5300 dst-port 80 action 7
 
-For each flow-type, the programmed filters must all have the same matching
-input set. For example, issuing the following two commands is acceptable::
+All the filters programmed on one port share a single classification mask, so
+they must all match on the same fields regardless of flow type. For example,
+issuing the following two commands is acceptable::
 
-  ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
-  ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.5 src-port 55 action 10
+  ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.1 src-port 5300 action 7
+  ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.5 src-port 55 action 10
 
 Issuing the next two commands, however, is not acceptable, since the first
 specifies src-ip and the second specifies dst-ip::
 
-  ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
-  ethtool -U enp130s0 flow-type ip4 dst-ip 192.168.0.5 src-port 55 action 10
+  ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.1 src-port 5300 action 7
+  ethtool -U enp130s0 flow-type tcp4 dst-ip 192.168.0.5 src-port 55 action 10
 
 The second command will fail with an error. You may program multiple filters
-with the same fields, using different values, but, on one device, you may not
-program two TCP4 filters with different matching fields.
+with the same fields, using different values, but on one port you may not
+program two filters that need different fields. A plain ip4 filter needs
+different fields from the protocol specific flow types, so the driver will not
+program it on a port that already holds a tcp4, udp4 or sctp4 filter, and the
+reverse is also true. An ip4 filter that carries an l4proto qualifier is one of
+the protocol-specific filters and shares their mask.
 
 Matching on a sub-portion of a field is not supported by the ixgbe driver, thus
 partial mask fields are not supported.
-- 
2.56.0

