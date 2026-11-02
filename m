Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F6606B0F1
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=y2nqDNRh;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q5f3qgTJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB4C480FFE;
	Mon,  2 Nov 2026 15:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndtuxKndtsxJ; Mon,  2 Nov 2026 15:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F32DE8107E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633721;
	b=DM5x/IVtTPV33rXdBjRuwOd8gZPriNA1TVV7+IZkSnuYCzdclqEKmc7MbxLqSs4jwJIP
	 7BCNAFjGmW0qdmttKGU5b4CWmZNgi2IamE0BLEwc+cLa4EJ94Uyq0XrPWaOr1qH1is9hL
	 SBNhsnHaP5RUx+ahE8PMdbN/6smTKrNE/Aip+ZNRTeqwEQ6/U86FtTnVIAq4tYd66JMl5
	 2dPAL6tCh5FToL1NYBV0B4EYX8mvnpJZa5mID8I8LE1sYKxG+KvWV0qm0DnFnFJjS7g4b
	 iMWurjRXMSVLj29ni9BD+5lF6VN1HAofu/fgQfrjqxcg5ZBmy3Fsq1b6BwRPhPGzgsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bTnF88zQvWDgvQnQqUKqy/cWBjF4bWPunYCihjiMQc0=;
	b=HZabr8pzjLpVqebZjsW2+my4TyFwobhuGh/6b2eew0UMRVJgxdu+lkcDwHBfUJKscqcz
	 xsTn7Dn6Efbs/sgyS+OrQtHcJqEm+mnp7clkjTlY1YRpQvI0USNe9LZpsq36YgghFG38j
	 1CFXhcnG/gr8i6Dzcu8gujYTIv3TlPyu2w0U72QXgBFYBs03sfa5/Xc/uhb7ge4br0Mog
	 NF4jRrQ6kelwM2tyhVACpdbXECMkJc+yWlfFKSEc+Am11CqrrQIKqhsEtXVwyKjMkLKlD
	 ix2Y2vJrOsToInowvbuyVjuQYH9TXJ6DtiKyvOYBDGxz20P2KCXB7xCpH6c8ndyP7zw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793633721;
	bh=bTnF88zQvWDgvQnQqUKqy/cWBjF4bWPunYCihjiMQc0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y2nqDNRhWybfyzIL85ABtOHhBRflxXgg7Ce3fGWj4wGNZ+OpfWLjMOgPYWc1aqmP5
	 7A5QsvQNeneJkaBCz5HPmR1Pp4EUJr73ciiDBgubIroe6DJYemY83BGbGASejjMvdU
	 +kfvYLvCGaxThcuMJ8TrFq+Gij1rU63U3Sih0zHbFaCKLXHo1GbkT8uBnyyGSWRn5J
	 allQoP5+8/9qIbJ1exh2k0xebWqxfghlx7WYPs/aU3qEKM0do0tyJC5o738SFbExSz
	 wfds9T/fO/21Da1T8lufQnKu9SsuIR6Qw8H1WGufufDiIxch9fun+lvbzAyMW5FuA2
	 ae+rhzuZDP55A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F32DE8107E;
	Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3616FD3A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 274834018C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9F4r6E8kQjb5 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 15:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5AB4B4007E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633718;
 b=Ay97/qqnyONRGX7hYoZJm1XjqhQwG+p7e3sk+wBmErTITK0iKxK/LMuIM++jbqvREX5w
 Ecg1sGl1t2e81FF1z2NuckiMfc5bgPIpd2vb6TfxUs1s+HdieHDPPnVggbfN4+XPxllps
 JwjVHcUOZeBf9CnvWHOKMd3md+qWs80zk19vz4hxx+B0sYpDclGpGQ5ckZqDeNX3OF/cl
 9zJr3rrAln3jd/BRL1qXVqeWaiWqVzrRjIP0mHfjDTV89jc2Ymbahi6erRcRKtXHPodeN
 5NNwTSEg88WPAz3RIu5jir2kNjaTM9v6wiNRETBGgLT7DxonxaztNiMESEbXcfSc05w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633718;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bTnF88zQvWDgvQnQqUKqy/cWBjF4bWPunYCihjiMQc0=;
 b=Bn3A/397fwit5kptQ2sbs7wAipDHEn9C4MU4IVTzKZtzGPXCAlBxs2s1NpiMnPtH5lz0
 tiX2NKepZrPvk04GJEtQ1fcPGHR/milOT6tJYN6JgmINvXaY6wmDkkzHCDmC1YYwdHYuv
 T5GU/K6LLJKEXKi58N867LyTBh2YHekT5ncg6nzhSN8IABnro5GX3XdDOmQNhZU3QC6bv
 IlKeJYznHF2muGObSB70J2AwRPhigATKQYZJNV9gHgAXl4cmctfMM9Tk5MUZP3TKIS5gD
 TAbWkO4AxXH2Icp7i6Tow0STzQODQQpjxAE1rrJRKXJ78O+rINa0soS2LhqvuH+eGWw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q5f3qgTJ; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q5f3qgTJ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AB4B4007E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633718; x=1825169718;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=3m64GUwgXo3jGz8/0Z99dvtXs374FxZ9x3fdUHdNjiw=;
 b=Q5f3qgTJDnKtQFlQ/HzUzmUJrcIPYahN/ImI0hlhIfJoAyT5a91Uf67a
 I3CNUQw+eibQtNFlzOo7RU4oJZf0Lv5nyE3cmt7wszi/txft1PvbBsGRw
 obzWzaT+FAlI+YNPkWjHs4NydKfPHItxYwMikf4AOpK+PS7EH/x4nJQ2D
 RpSIQaBfWfElO/02Cf9mx4BMMR7y4uIis+WByY7yw22Wo6kD4t6fnzxwh
 ZIsNsX//3GcEpTNghmWBwUCciyHKXE/WU11lnIcAWb8a6bAiAYpTmlBEB
 Fy8kx+4DvkSEn4WYIXS+xJVuY58zrkvcyUBblTJdX6smptrcK5D3k9hY4 w==;
X-CSE-ConnectionGUID: 4hrPLMjhSbC/THaIPce2Fw==
X-CSE-MsgGUID: T8d2kBvXToClOM1sR//u1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2210865"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:18 -0800
X-CSE-ConnectionGUID: er7fZNHqS+W55yqkwMa+Ng==
X-CSE-MsgGUID: 2xPPX4TbSli6DUhLUo0UTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5999773"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 07:35:17 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v1 3/4] ice: fix raw ip4/ip6 flow match docs
Date: Mon,  2 Nov 2026 16:35:10 +0100
Message-ID: <20261102153512.1601855-4-aleksandr.loktionov@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The raw ip4/ip6 flows match only the other-IP traffic.
Fix the stale examples and qualifiers.

Assisted-by: LLM
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../device_drivers/ethernet/intel/ice.rst     | 41 +++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index b720763..928ebd6 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -237,10 +237,22 @@ NOTE: This driver supports the following flow types:
 - UDPv6
 - SCTPv6
 
-Each flow type supports valid combinations of IP addresses (source or
-destination) and UDP/TCP/SCTP ports (source and destination). You can supply
-only a source IP address, a source IP address and a destination port, or any
-combination of one or more of these four parameters.
+The TCP, UDP and SCTP flow types accept valid combinations of IP addresses
+(source or destination) and UDP/TCP/SCTP ports (source and destination). You
+can supply only a source IP address, a source IP address and a destination
+port, or any combination of one or more of these four parameters. On the raw
+IPv4 and IPv6 flow types the driver rejects a port qualifier.
+
+NOTE: A flow type selects the packet type the hardware classifies. The ice
+driver programs an ip4 filter as the "other IPv4" packet type and an ip6
+filter as the "other IPv6" packet type. A filter you create with ethtool(8) in
+one of those two flow types matches only traffic the hardware did not classify
+as TCP, UDP or SCTP: ICMP and ICMPv6 frames, IPv4 and IPv6 fragments, and IPv4
+or IPv6 traffic with a next header the hardware does not classify. It matches
+no non-fragmented TCP, UDP or SCTP frame, even if you also configure a filter
+of the tcp4, udp4, sctp4, tcp6, udp6 or sctp6 flow type; use those flow types
+to steer TCP, UDP or SCTP traffic. The driver also rejects an l4proto
+qualifier on an ip4 or ip6 filter and a tos qualifier on an ip4 filter.
 
 NOTE: This driver allows you to filter traffic based on a user-defined flexible
 two-byte pattern and offset by using the ethtool user-def and mask fields. Only
@@ -283,6 +295,10 @@ To add a new filter::
     <queue> - the queue to direct traffic toward (-1 discards the
               matched traffic)
 
+  The two port parameters apply to the tcp4, udp4, sctp4, tcp6, udp6 and sctp6
+  flow types. The raw ip4 or ip6 flow rejects a port, so use tcp4 or tcp6 when
+  ports matter.
+
 To delete a filter::
 
   # ethtool -U <ethX> delete <N>
@@ -323,21 +339,22 @@ To add a TCPv4 filter with a partial mask for a source IP subnet::
 
 NOTES:
 
-For each flow-type, the programmed filters must all have the same matching
+For each flow type, the programmed filters must all have the same matching
 input set. For example, issuing the following two commands is acceptable::
 
-  # ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
-  # ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.5 src-port 55 action 10
+  # ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.1 src-port 5300 action 7
+  # ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.5 src-port 55 action 10
 
 Issuing the next two commands, however, is not acceptable, since the first
 specifies src-ip and the second specifies dst-ip::
 
-  # ethtool -U enp130s0 flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
-  # ethtool -U enp130s0 flow-type ip4 dst-ip 192.168.0.5 src-port 55 action 10
+  # ethtool -U enp130s0 flow-type tcp4 src-ip 192.168.0.1 src-port 5300 action 7
+  # ethtool -U enp130s0 flow-type tcp4 dst-ip 192.168.0.5 src-port 55 action 10
 
-The second command will fail with an error. You may program multiple filters
-with the same fields, using different values, but, on one device, you may not
-program two tcp4 filters with different matching fields.
+The second command will fail, and the driver reports "Failed to add filter.
+Flow director filters on each port must have the same input set". You may
+program multiple filters with the same fields, using different values, but on
+one port you may not program two tcp4 filters with different matching fields.
 
 The ice driver does not support matching on a subportion of a field, thus
 partial mask fields are not supported.
-- 
2.56.0

