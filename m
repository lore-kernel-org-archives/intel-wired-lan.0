Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748360A5BE5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ZqbAI9e+;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsEApbJb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AAA480D8F;
	Tue, 27 Oct 2026 12:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vS-pu8rowcZe; Tue, 27 Oct 2026 12:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 500BD80CEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103304;
	b=B6RdghudGf6fX8hFVXqSM56to5DPPp/+6NKHYwmkAqvhk5dImucoTaw1b7cxH+Mp8hEw
	 sRep+b68NZfjsBzCjSk/AKsCzx6pnjIoK32JY2HDMMZsZzh4RRJCQxoAY1v2D937MpGp0
	 taHLf7JtR38zIpFZnpqyZvPfSW+3aiCb2LpjuyAJSw7igfoYQ3qWYCBwncXwhlUYYlMO5
	 QZQJ24A9FIRFob28WJpowpN62LiwmrsbpzUGGanawb1UwJWXTgi8e/7Kvks9V8lDM3dzi
	 IgXkPuA+1kWN5V0LiEPY4lTHZIDbS5+LSwf/GbOeUr9yFsc8hITKn6Dx1OtIGJxx7ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eorL2S94yMk59argX2jOXPlj4JIfINkPUowuH7b8Yt0=;
	b=WHkhRVFi8kJua5wTf2y7+XAMviofhgOr5gJ9QB1u5L4mODEHGFjQg2SLaoOLRdvPugBz
	 5ezS5oL4n0F3O10upG/vHyCJ32oibJG6PK70Zfc7CODAFCgFzynaAKSfJFyM6VGUsOoyd
	 rT02TGgfWKzM0Crk1Jyq9A08G2wHr7uGimN/jlmUicX81GPZv/sMSRy229KvNOr4a69eN
	 vP+qDxZFGdjmtIOGAmpjCyf1SDutQ2nMJNUwuMi5OZNJGcSK8Hw6vTQZhltthD8VYBP6j
	 JAwxNHQP9YtC1IgSRmLLN+VseP4ouS/DwtN9+sSgoAnP5NjlA22JVCOLQ+9RD9oT4TQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103304;
	bh=eorL2S94yMk59argX2jOXPlj4JIfINkPUowuH7b8Yt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqbAI9e+JhXT3xMlR6YcVcL+qfGsgQSLdYXJqBFjki0bBECRspP5p2GwgYHAr1AVC
	 1s5IWF1Ft1Gcbq+yRoeXYtfjsaFn25gO2k9dAzJ2v2VpZMIZnDibCwAhN5GIA3B+GO
	 c7dTMemO8MJ9mKFnvmoskWOIV9StY2RKHjCCFg6A/h1A7sxGhGmqB5WpFDC8QTggDI
	 g9uskzrzvDZ1O20f380IiEPfiO9cCAi6RrESSECz1MGnUbrwX7VIM/HJEDJLQqbpFD
	 BQw8y3+2EDK2YypTXPhtE5NgV/BN8XUM53KX8IMB4O6yHPRqjIRsD2HGxkEDiDgRO4
	 7gjidnNPIYOIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 500BD80CEC;
	Tue, 27 Oct 2026 12:15:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D2534D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BAC0606BA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8W0ImGVgEHp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87F9860725
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103302;
 b=TkjIs+q2n2z2xIl45/xQ6gt396r6zaxLazpWXTe63fEURcCY8zEaEDAxgqFWt1Nr1Gje
 YxUisRm4RqLLdaRF84TlhhjrS8f3+0BuHfEG/ZUnLdSqN5b08pEpeunnETQqm08l38c9S
 ahqApeGUnXhv98EJQEK0JizP14pam4uPnKR77QLznoCeYFG4K0VQFeKguD+8GJghdpRkI
 ibkdD4lz9hicqG+gdpA89LXhpsGT5GYKyhPFdUQUeUh7DTKeIw0p4r9fRBf4W4wdZ2Luz
 TqQtv7TnT78hprSrqtLn1FGqMubjj5nnYuUNH+lxly4eN1D2vH6L9NG1NBKpFRYYqkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103302;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=eorL2S94yMk59argX2jOXPlj4JIfINkPUowuH7b8Yt0=;
 b=ZATDDAsjPCE8gP1Xv82+O1QRqpiG3bLLiY+kIMI2yTW3DAkeK8Gd4RhqQO4AR1S5qCnT
 4T5EMYLdeWyxM3dpAo4/KA9Nk5BSFkxQE2/0+4NZ3ZXB5s4JIl9nk5ySWUa3HdC6fcWts
 +qSG3rocjeismAHA1aQqYJXghsAJswV2GSMx/1rYCx3JBvb6SfQM9kqKozeYf6bfB1Dmu
 nqh1No5pK1OkptK4y2wZp8bVm+LbL+oeEWf3hnkcP+5sbWDRWqIgsmL+S6kwbRoZbLaFE
 5tOUX8YpGjK27AsHwv3q3TWK28fOOmWlmQyssud2Ol1CapuxpuVnGS69whIo8eyFcVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EsEApbJb; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EsEApbJb
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87F9860725
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793103302; x=1824639302;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3D7YT8EUbWoQcbBo6UbB5/fOvhkRhwSXmON4p7yEjnA=;
 b=EsEApbJbtbo5loxWigfH7+ddiGrZdRxRDHryqNdQLBYYH71v0wRTfvg4
 yAK+U7FOKIBxjq/cBM0oqee5jmgLOLITB6UgA1Ww7J4OWVP3nBcBCqz2l
 5FlDjwcKWHOdn24MRIuoc1K5QX4uFVbqLx/NSiQZgcmtSzyTcVZhRypWP
 CgX7lSTGo+Uj7Z1RTagjjURRXWZNbP05HUaCqLv+TRM7RZ1HgHob5vZYc
 +sOMWVItN6HHXSXE6P8Bwu0ARaVophvxT+/RqZ+nXES6c09Pf08X5HJzC
 Xxt7GwEEJnbvVXCK0hY3tfcg6pb2niCAoKKXIAXNIgf2+Y3LrnJkufZDW Q==;
X-CSE-ConnectionGUID: budfpt60RwidzBIG/2Fjuw==
X-CSE-MsgGUID: zi2YFTMWQ5+HAEnwMUjFbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1709360"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709360"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:15:01 -0700
X-CSE-ConnectionGUID: YLizwNoLT8a07mzwBxLnEg==
X-CSE-MsgGUID: rmuuHRhYRWGzCHL9UvjfLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4529810"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 05:14:59 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 13:14:42 +0100
Message-Id: <20261027121442.907414-3-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261027121442.907414-1-magnus.karlsson@intel.com>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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

Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 8982cf75466f..2c290d7788d2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u8 *hdr_len,
 		csum_replace_by_diff(&l4.udp->check,
 				     (__force __wsum)htonl(paylen));
 		/* compute length of UDP segmentation header */
-		*hdr_len = (u8)sizeof(l4.udp) + l4_offset;
+		*hdr_len = sizeof(*l4.udp) + l4_offset;
 	} else {
 		csum_replace_by_diff(&l4.tcp->check,
 				     (__force __wsum)htonl(paylen));
-- 
2.38.1

