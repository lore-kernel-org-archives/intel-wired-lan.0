Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2D60DFB02
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=btPU0lkf;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UdtyV5N2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CF9560653;
	Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XjOe4M2-knre; Mon,  2 Nov 2026 15:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1579607C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633720;
	b=C5kAc6mhGv9/mapc0pTQVGAHQBlFcgqH1Gn5LMMIU0I52mws1a6dSMILFO781AMbeaFy
	 JfYb6AT/kwLqIQoIafSAQ4ELh7alknguKZRJD4sXuGxp0zeYJT7yWLFEUh9z0mAFFUFFz
	 JP3gb7X9M5EjjaGnVjRgEMtSdKNI5aKizLnSIeSRV13dzd/6zVTZSIxcXFFzufNa5eP47
	 TaixqtT7YvH9mISegwCHyqUcWneLEzxbTccli9OJ8+v/CkIFSaDnHl/GufYkLszZwafAh
	 IIvkI1XZ06npS5SOglfvikir14qpB/hC+zXTqtOFPHlm8DV98FyCTgd1OiTcFHH97nA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YEPbPwK3w8A93AczfLk39x6PR6xnDby6G2sVzUPLGUI=;
	b=awZdRxde7zbXINBW4z36RPGQxkDxf9eRO5b8pCRxLosP7NC5/yVN4Ho95/IC4qD4hrlM
	 o3uJT8p+wrziP94TpwPNDsLYIpXDiooYVPFm1t9Nt7ODJuno34Ilpx2l90BBhxsCkVF8q
	 tNR4ECiPNJyxiryzMuy2hXSbG2KpSX4/PFfdqAES9UGbRlreVWyXYHyoIKeW0flJNC7bO
	 yR8LyZSR8MTOg/4qXwKFgwfKVMoHQ3plJ8dmrFik+foNtSLGjG3D4GrDI3Ai926RJeYlS
	 U+k3xbk/6LxpdyTIuqNoQPkExZvB4B1kLEvlIbdub6D8yJZYvt9NFj88Kp2HyOSfCUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793633719;
	bh=YEPbPwK3w8A93AczfLk39x6PR6xnDby6G2sVzUPLGUI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btPU0lkffk0n7qmQTzhqlmLWA6whqcPpaEkxSNH1BJ6ktoswADTGgJWlj4DRoR/Xt
	 dseNoAaEPqxlFFY5Ubp2OMVM1YgPal+bUsu94JxrO8TBeW3BQhtqSqRZUPCccPVCsV
	 LN5A8BqiZn0oVFSPSlWz2C7Mn3J3USt2CYmz6AEp6FMTgrRuZeSxeW8Aos4pvqOpSo
	 8SfQEh9ui50ZH0g2mch2Lse+e1CxiaAgqs3Js2czwm35Qas1VXp+2JwuvIdmKcCMQV
	 KfWYRY1goITdzXbI/Wx22HuIIptvq2p9nwcl+JgWg+6Aq8RwTckegNvCyPCdzIdbfa
	 qMFAeLOD3v2yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1579607C0;
	Mon,  2 Nov 2026 15:35:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9165E411
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 831A680FFE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45V6Cgg7Vemx for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 15:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0B848107E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633716;
 b=IGzfIcigypvkkNCdtk9zM3GxzMnawRQugwMQbLLJeWXaMqB1PKdP627J2f5R6asIC1Mv
 KEfvK/tV7FioiY93lL8npWXlGBPhma6nWaSgXHlI+DpICn++V+UMna+3ZSa+D+VP5QN5P
 aMKBvPTNIaLxpL2ErVEKvebNtt45TtEOCw+q0sL4x5OZwddpCENJUEEY8YnROBD0ITi90
 ZGtiEGTN/u5xfgS5J7NBZJz6m4C1VTOR9S2WyXX1C6m6VfgMo29CBDmWpcRhNY89nl9NU
 BVdZ5afubJJcLkbt6HhCMVT4NSSF+r6bq/BzH5Jem500f08WDS+GFeNvoz1hDeiuo5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633716;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YEPbPwK3w8A93AczfLk39x6PR6xnDby6G2sVzUPLGUI=;
 b=Pu3oQkSDB9oRsq9FlI987PVrLVkdCu6Uez/bCOgpxy9pYXBM8Xdrl4lN2Oz6AKjcxpFO
 8KBhvGDDa2foqS+gyUNIejQQTjhF86UYRJZe3tNx0Khxf11pPFbx90iM2HrhvvJZBZVfH
 YhJXjG6tW2ba68ahdil/TuWAK+fD0yAlu3GngG+8UFksSOp7rGqCEnlYho1RV/CzzH2Ew
 J/sO0DMKMKcTGrnTyTvpi7e8VGXMsgdMpWFJKM7P3TaGNt6RxSPyiZ/sN3n9pdODgm88Z
 0JndkELkSrTbmM0mJprFl+0CYcEF4A1EBKQASk6U2dg4DzVq07awQODK+Ud8dP4qRtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UdtyV5N2; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UdtyV5N2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0B848107E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633717; x=1825169717;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PhmvTqKFKB7CXsITa2Pn0wqzMpWzmIBCrfci6Z/8lP8=;
 b=UdtyV5N2lFwgEuj0keiy6Alxy5p+QuklnGYtL8thsj20dbEzpVcNC4hU
 AC35E+L1gmgTP6zqx6FYAjt0AkvQmPVcWMkIbTtjvWDNIhxsxXcDnEm3B
 xobV8dUX7r9G0SgAo6pkN4A6AV0aovyFbpQw39PUh+Tdbmoqm1Qb3tGrH
 d0qacaoj3gZoxkETbnIndyiwNj+7Ylna/Ut8z/US54XghjGML24bE2iaZ
 kWTmiAsd1tDME0RwI0GWF3X4eVwV0c6N3R1Ncig8S3gDij3zImvy3F5rh
 zcpV4HlEFcI3CY0sR4c/3MJaFvThYJtdujApDTL9ty+5VzgAnrxSYPiWl A==;
X-CSE-ConnectionGUID: iYKhqoAuSXuGNjGLIHqS3w==
X-CSE-MsgGUID: zPN5PBnZTra+zgsDGa4gDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2210854"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210854"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:35:16 -0800
X-CSE-ConnectionGUID: +HVigZKBT+SzvZDNuWVl7g==
X-CSE-MsgGUID: yLCZyUzaSBSkYu2R04LaSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5999754"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 07:35:15 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v1 1/4] i40e: list accepted Flow Director flow types
Date: Mon,  2 Nov 2026 16:35:08 +0100
Message-ID: <20261102153512.1601855-2-aleksandr.loktionov@intel.com>
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

The hardware accepts all eight flow types. Keep the examples on tcp4.

Assisted-by: LLM
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../device_drivers/ethernet/intel/i40e.rst    | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index e01f0ad..92015b3 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -130,11 +130,12 @@ The Intel Ethernet Flow Director performs the following tasks:
 - Supports multiple parameters for flexible flow classification and load
   balancing (in SFP mode only).
 
-NOTE: The Linux i40e driver supports the following flow types: IPv4, TCPv4, and
-UDPv4. For a given flow type, it supports valid combinations of IP addresses
-(source or destination) and UDP/TCP ports (source and destination). For
-example, you can supply only a source IP address, a source IP address and a
-destination port, or any combination of one or more of these four parameters.
+NOTE: The Linux i40e driver accepts the following flow types: IPv4, TCPv4,
+UDPv4, SCTPv4, IPv6, TCPv6, UDPv6 and SCTPv6. The TCP, UDP and SCTP flow types
+accept valid combinations of IP addresses and port qualifiers: you can supply
+only a source IP address, a source address plus a destination port, or any
+combination of one or more of those four fields. The raw ip4 and ip6 flows
+reject any port qualifier.
 
 NOTE: The Linux i40e driver allows you to filter traffic based on a
 user-defined flexible two-byte pattern and offset by using the ethtool user-def
@@ -193,11 +194,15 @@ new filter use the following command::
 
 Where:
   <device> - the ethernet device to program
-  <type> - can be ip4, tcp4, udp4, or sctp4
+  <type> - can be ip4, tcp4, udp4, sctp4, ip6, tcp6, udp6 or sctp6
   <ip> - the ip address to match on
   <port> - the port number to match on
   <queue> - the queue to direct traffic towards (-1 discards matching traffic)
 
+The two port fields apply to the tcp4, udp4, sctp4, tcp6, udp6 and sctp6 flow
+types. The raw ip4 or ip6 flow rejects a port field, so use tcp4 or tcp6 when
+ports matter.
+
 Use the following command to display all of the active filters::
 
   ethtool -u <device>
@@ -218,14 +223,14 @@ directed to 192.168.0.5, port 80, and sends it to queue 7::
 For each flow-type, the programmed filters must all have the same matching
 input set. For example, issuing the following two commands is acceptable::
 
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
 with the same fields, using different values, but, on one device, you may not
-- 
2.56.0

