Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFC606A31A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=o5L++zsC;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nu+qVvb1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BBE606C2;
	Thu, 29 Oct 2026 10:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IpYnnX7-3sGM; Thu, 29 Oct 2026 10:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D43F6068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268168;
	b=EG3zVP5sq+LLE2KRXqy7Cxi92lpXD9ZFbE0aNGOnzSIHCmLv6Nrqc94PCqIEkq7qc7Ml
	 /Vp7CRmFNczmi7uenE5m9l6rZvteT1obdubQiZOswr3b302nc9f7LPS4olSgRFi8xo15q
	 RpA1DDzN5MZ6szYeS6QvepTfwBCI89g5FaCNY+a1DQfpnrOQcY8Oe8t0d2hHxxRMsJNQn
	 /YoFI1pmv1dN+Fqw+e0VOh0s8Ru4yz69kappOVBcOM5HP8qvV03ho663wEEAeBNsYn/dR
	 IVOyhRc9hfozbzYaehV6jM1QqCF++SB+p7yD10UVOTu9OVAWxytXqrr4tjBIezhfsHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268168;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h+5D4ZS4eIASdcyfCeWrhm71jCf5qcdKuyYyGqZ8MrM=;
	b=pv4Y39vUqdhlXO9JH/iByXkQxYW3zx4tTZpQnTmGJZ/xMmxkzuMKNQbJYhm0HvOxRw96
	 sGTDtblsExtpfuWLgMJr/g8d+k4BAf4+YvBs7bLom0ZvWNLQo8IFblLC2XyLtl4R1W/6Y
	 1QiGJJ8Lxm0I0LwBq9l/pRycy1AEw+89Iz+v4/iznTmLG5v5u3UUeDNG+oa59eDbsPB1J
	 GQ7QKWkMpHRqZhZYPWZEvW9BNN9nPWp8evLsShL/nUJeCG1yiIXwgSwcJGxC0psAD+H++
	 lzoyYZBplTxFeWm+no0ZG5LhK3gltWT5r0MbeeFfFqSpZatMMBfhjKtFkdsfPL74Zyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nu+qVvb1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793268168;
	bh=h+5D4ZS4eIASdcyfCeWrhm71jCf5qcdKuyYyGqZ8MrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5L++zsCm82hlG7EPM+j2VUgEDQY/idTRgIDdsGflMP40saPtScu2f92V2YeYDerI
	 8NXKW9I2SI3DbOa1wNw4pWfPAQ2hd7O2x+YWb6005LX5pNbOBuE4rGsxNcN9ZMHRvA
	 EM+ndOWLeoIdUtdlKJp8ZqIVUDBPZoDbEZcmr2h5+LRVlMUosRoFxAhLK4cR2RIYCs
	 6QDbkcv3wEIMMM8Plm8zm4E56NJbXMMfzbM6JQ6uxH5y87rTLOaxI3o2zqzS8U3jeR
	 12YTAjJthBM8RjWG6d186AKYGS+H2uAoxzjrazSihpNVNAXWwdFSoo49fxEYJi25bf
	 0VN8FttOovbLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D43F6068D;
	Thu, 29 Oct 2026 10:02:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8380D356
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75520605CB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0O19O0YnVVf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 10:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE7796069F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268164;
 b=QE8TKFdxCVQf2RJ+8OVH/sb8jdmmuoyeZY8w4UjplVzwPt1qtoo2PsxRAKf/BGbAhemL
 jAThojjB4jKj6GT6EgEjyv1PNAWjtUT+Fg5uEl+3Ars9qGZGUVr2Nwg6/T/7oNoX84AuA
 2WfX+zY2pFlEQsvlqW0QhDmDoVh4sYjTC0CRkUtEzpuoz2BtQboPXnmcextUlldQxAsj8
 keYzuRw0Kg26MwkYLtnQaikIdPXVHbB1vObj0g6yhKZPChPBcd0H3aL7dCPLLYF/qFRoT
 Wh4qPt5SnDYXWQkkZOVDk/LCKVgmhWQ3kcnDElMctAuQFh2mc0FSbWfdUK6VeqIoTlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268164;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=h+5D4ZS4eIASdcyfCeWrhm71jCf5qcdKuyYyGqZ8MrM=;
 b=izkh8KsM2nJo14vN/KA+hWdKSlWG816r4q+UMhx0nP5UtRPSwmKhhLbrOx52bu7OFu8f
 UZ9oswNEO2RpWzmGTMvauyJIzblTKLJwiJV2cw605YcNtwEmytaNKLMUBcQPmqqfkoeAT
 wnh6FousjkpN7FJDboUflWoW4bGnsVbf7D2KLryKM2bVSkV63Xo0tqDCUpxyclP/Rirbr
 KdWEr8Zwh52aXf8tou7rXFWRwItZTdjjV0ISLhktiRPs4u2lY8RJVIIClO0YBC0b74lbe
 Ws6WdDo70qX31MksaAMawNS89vsvUZfaN1T0REzhsQ4PgDf187yNGdIVk3q922YGdtw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nu+qVvb1; 
 arc=none smtp.remote-ip=198.175.65.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nu+qVvb1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE7796069F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793268164; x=1824804164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mXShuHerbK2oFfN/B90JzwQbi4IhojUTwXSHg3Vzsl0=;
 b=Nu+qVvb1QkoXbMANB/p3u5DjUlfldkfh9D1Fp3QAeD+qln6GVbAX0+en
 9PXYaLFEpzREGhiePGBj/LygCOZ95pBtR6mRqLWgDde6aLu6joskwDVT3
 ip+WjH3Vw9Z5Ry4ANO0JxGbEaq4fsevtVJk2OHwmAXLvO0zmmhgteYKqj
 gJA0pk4C7VrnxbAQpKbcSezmvUf1C1T84r7H2FOF2wu5/iI86Nj+dB4PW
 vxynGM3AfPOO2HRkfkd7ZT/naCn9Ej/so6Xvc6HhakVvGliAHhTBZBUpt
 NciDj8ZeQTg54dI9AnXDu8Zuj0DFKYt7QYTaZpnyi13QnjLeTAoeFPdc/ w==;
X-CSE-ConnectionGUID: wtEA0fCVTBqf/476aHXcpw==
X-CSE-MsgGUID: H5xbWm7qTqKmut8aWDhJlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2017750"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2017750"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 03:02:42 -0700
X-CSE-ConnectionGUID: WdJen8qcRo6gj3a38LLB2Q==
X-CSE-MsgGUID: tCAZJbZaSdiSpbkHWHZ9EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6941130"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by fmviesa011.fm.intel.com with ESMTP; 29 Oct 2026 03:02:41 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, maciej.fijalkowski@intel.com,
 przemyslaw.kitszel@intel.com
Cc: Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
Date: Thu, 29 Oct 2026 11:01:58 +0100
Message-Id: <20261029100159.920118-2-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261029100159.920118-1-magnus.karlsson@intel.com>
References: <20261029100159.920118-1-magnus.karlsson@intel.com>
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

That USO works for 64-bit systems is just pure luck. Currently, the
computation of the UDP segmentation header is performed using sizeof()
a pointer instead of the sizeof() the UDP header that the pointer
points to. Since the UDP header happens to be 8 bytes long and a
pointer is 8 bytes long on a 64-bit system, this works on all those
systems. But no such luck for anyone using a 32-bit system as 8 bytes
!= 4 bytes. So fix this by using sizeof() the UDP header that the
pointer points to instead.

This was found by an LLM while implementing something else that used USO.

Fixes: a54e3b8cffd6 ("ice: Support UDP segmentation offload")
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2c7c4962882..d9ea812c5c4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1925,7 +1925,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		csum_replace_by_diff(&l4.udp->check,
 				     (__force __wsum)htonl(paylen));
 		/* compute length of UDP segmentation header */
-		off->header_len = (u8)sizeof(l4.udp) + l4_start;
+		off->header_len = sizeof(*l4.udp) + l4_start;
 	} else {
 		csum_replace_by_diff(&l4.tcp->check,
 				     (__force __wsum)htonl(paylen));
-- 
2.38.1

