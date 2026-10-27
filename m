Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0260A5BE9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UCnkzQCw;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d2eK9i3s
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED6CE605EF;
	Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Siv1GYEA92Nc; Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6715D606BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103302;
	b=tFKezadmikAeaNro9a3oS2WVYRkRV28kPkOJaXGNQnuR/JV7Lwz1/RltrM7Xuglarl0s
	 NIe23bgvA8hSN9tWo8BmDdHWaGfd5xzhzRzTm7d5fgrn1BqyIv6sIbkyJIlHsGe08NEEV
	 LZYQINeeHo9U3HhEIEVD+X760F1h1cc1YDRbI7e9V32nXEKEPq4/8g0871wbP2petJOha
	 vC/y55tmMfB3qxKAw17xVp8HCEmnMfey5UoZIMo5WugY68Go3ofXYSCUGtCJjtqVGx8//
	 yRyizpHIheePrTafn83y/glK7lx52TKrIQ3pPiDttitWIGQlw9Ld4T8J4oo7+RQX5JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BViwE3dfXKqpkwdZwEdcio9cXmtdv8ApzP+/cAcGPKw=;
	b=YjuPAUZWRtyqzo6jWnHGulsxCiwpYNTh6x29mY1gogwFxoESvADeMMwKhIHBBdt7b2/Q
	 NSbD4A2wT2HSE3BGi3y4gYYn2KYa92dgVnhVCcmbv3RsbYrnvJhvtuRJp4AnggjEG/LKP
	 45uFRSltc4bKqQynbCqFeIa/jnhDIzYagi3hdJgJO5dKBsojijhLid2irVH4kJiKVewBu
	 qG2SNslxVisUlMpPAHdFoNprnkK++QK1Ypv156wzMIss/D4ss7LmW2VM0Q09NSr+ZQaGI
	 j0EOD8aFdOASDdmnKPUhtq4A8Rldi4CpOCKbhxT6vd2STqONCOmPwgCVTOGFSkwVVzA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d2eK9i3s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103302;
	bh=BViwE3dfXKqpkwdZwEdcio9cXmtdv8ApzP+/cAcGPKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCnkzQCwu81PcJmyAe6RXsC26+9dJ49yfqae9hLFyx+jUF85tYqqiRodiFGb3yJm3
	 s9tK+MyBoSjR9UKfNXepQkaZv5otuMKqVDjm6GRAOrTa1i9fjNYVSe6atX+hr29MA/
	 pSKBCaKi82al4AabXqLta4jmRBQDpMf8tN+/Sld5Fbefi0ps8F9A/UtQHpWcVAF5By
	 MMGXA7SoGPszfGn3zAtWBMUzdGSgMNWBjWBOlgesrxn39GYRAdq2yDqOfAv00GzWSa
	 tKCnn/UlePPdU1mvny9FP6wWmfq7BERV1gk1nOYC+ZzMbK4fYb1GLU3y7p8iCDXjdC
	 MZp/CYO60q26A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6715D606BA;
	Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE9A64BC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C53F1605EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFxWL6JjGS_I for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F69E606BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103299;
 b=Bw+9puh3gUoC5+E6wDfwMEB7bQ/mOpqpjHo66ZYYks/qrY4zhG7vgbxX/BJ+ynVEd4b3
 L0va8HfaSf4o5bUrEecqnUUc7s14gGLGAYoR7wDp2Pqebi1/N0id9xBXRcrFlc6JsaUOl
 owkgImEDs6KVv4wburOY33U2YnrCBQ3drJt0MPyj6J2Ls1vYdiGmI7MnTcPJNT7FIWkC8
 zqCNOkjXOcVdWKYl7n2eri1/EJNM46UZWRf/SNt2N8qRoIiXvsa465+UjXcC7kIiGogyI
 pCbGTQ1x0K1k/pFM+OiQ22rg1wOzxnXSoks14y44dWd6pbMVWxSxr6inGkG93oujSnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103299;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=BViwE3dfXKqpkwdZwEdcio9cXmtdv8ApzP+/cAcGPKw=;
 b=nrejkuKY7n1IQ0QbHwOjoGzjekG+HZp69kOKGnKnDybgGJik9O8Pyiq6NPZjvrvvkt2C
 b1QQbuzvE6y/+yelJVmji8oOEYifvSni9FbOWjhUe6ppZCfSpFZhrKPDQYBmnsPzBKY5u
 V1tMCcnK/Vac+3haA00ZrulWPrOgBUuSI+Y3HFm2L5mjM/RBEvuTCeUlsthciLJODtnIL
 Q1B/5Qj5FpX9qCVvXKXNe2TDFYkhmmzrtYfOYlz6CR/Cj6OHbq0ACfaMblBYp6sFszbaJ
 gtG4Nfv68F2LxZSJVtyeP7Zkmv7a9mnnw7eOuTrKP8scSkm2XWeVvmOiSUwFhJldx2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d2eK9i3s; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=magnus.karlsson@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=d2eK9i3s
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F69E606BA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793103299; x=1824639299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YyLWB1wW4GQLOCVklLn2VyX6mM9SGN+V9to/Vkzquwk=;
 b=d2eK9i3s01LxRuz5f+deLXwWVarnWOOJCqwaNwcl8lFEJK2fCWAxTSyM
 MJ2KXDpWU70obQQC5sz01mFU23qOpb9TyOTSr2f+8SuF6fqWLGWE21kWT
 sqRgEEpnfDrVRFF091GO1aHj9D1ZXrQ7fi9zKC2rP6jWIkIEB2XhXmWlj
 e2I9AKIBTpYuND2WIPcKd6HhgxiJCZ7vV1Nt4dfjz0psFg11fR2o+ogNL
 ejQ8cSovfmM6nycSavb26UOamS2bcN9XA7ZgtZLWTnASCfz3q9d3TYaaU
 LL85udnMpvefo/3GnDfgRpy1BTuPdBXKuGBdKXyGS41pen6hWRUVp8w7H Q==;
X-CSE-ConnectionGUID: c7qJ8vpfTJSnDVd1KcvFoQ==
X-CSE-MsgGUID: /cP2r7+vSJ6OtyHAcl86zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1709352"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709352"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:14:59 -0700
X-CSE-ConnectionGUID: 81Nx+QqnR5y1NH4EymS6tw==
X-CSE-MsgGUID: 3scPnqK2Smil7T5i4hYtsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4529800"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 05:14:57 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 13:14:41 +0100
Message-Id: <20261027121442.907414-2-magnus.karlsson@intel.com>
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

Fixes: a54e3b8cffd6 ("Support UDP segmentation offload")
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

