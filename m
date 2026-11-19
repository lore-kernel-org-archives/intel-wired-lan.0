Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6B606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=HalcMHOs;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fTwcoXXD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64EE640B22;
	Thu, 19 Nov 2026 14:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZ8zuEnJ5J_Y; Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C315640AE4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795097528;
	b=s47+9nsZyAjWiLVOh9CNmvVo7l/m8U8Pg5FoBF5NPFf+Wb7u7RMoCfa9TWPgGMmRyHbb
	 x61aRJX4Z1XZT3o7w4wc1Bf/ovgDgmV8S2l4bfYX4DsJyqgX5FU+0JhlSwnvYd+I2CXYs
	 O+gO5sNNBvCUNx87/h20yKHsJ+NO09trm6NMmpnD2WVc2qKPaSfp53bCV0YpN890q/nCC
	 WcYMN5t8/ZGyk67D0MxUWkifj3GdeRFNSj7a0d4liMD4O0eFujo0o/a8LSBxb5MLOZY64
	 vSqmPuRNjxhL9CqzireCIPhnMUOB8i6c/VXT+tjFLRPhoEg2llN1tBiQovlKaTTHHNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795097528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K2eaO5KthBm6xqXpWKBCvrCFiONFqgpc2DtBPnCprW8=;
	b=bvxu1UwSK4ZSSyIICFcpLsSaIApUK5rYJsmqLZPTsUuz9j8NyHyGO7CySe0RjLF3kPR2
	 R7LvgS0xDb0eOgS+CaY1+qAdq/N1uH/kAspE6uv4zcuwnBQtSOiRNNnx5b0lcIaz3t/ez
	 Ajcr6CamK8AhWDz9JWGuE5xrAcnl0ja8aT4DxJR054TnB4oGTq7pE1UirC7wk9qEsODjv
	 GDoG+BwctZm9Vbymgm9q+F/QGBgs7lDNvreZt/eh4ffDy5OqRFyFp+mPxozt0lJ651LS3
	 S+wUxQqjfZ3vknck7CEe5OoW72z3INYESTap1IEEntyFfDPEwtFn70RRjOBl3fWiCcw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795097528;
	bh=K2eaO5KthBm6xqXpWKBCvrCFiONFqgpc2DtBPnCprW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HalcMHOslL0rKsfSc/H2eubfr86CQMbfpEYQLGbLZIhUYu9cQJtEb4U0zcrhDl2HB
	 vNl2fgyl4x9ALZPHP2kpGXOlchEQKmOc0IcHY4YIYbNSjOgF3O95ZzQatClJyyjx8Q
	 p5TKEXI9cdPZbYff7wyQQQv3cBaQHhNiPQLqbJamM/eEMUUKESh/SOlDtIAA9JDh07
	 QsPlGaVZJd/Sj91wkpC04SyA41KfiH6fXwH5EKkF0FJeSIuXSdjxd3YVfwE01zzqDr
	 7RSHNND2caWLJ/hEL8GN5BfZ30tip1Nfu8zjLJivn3NM8cSR6ectXdXl3hb+UavsNu
	 Z0c7RnsUumKUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C315640AE4;
	Thu, 19 Nov 2026 14:12:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 931701C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9115940542
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtnfxs1yYAfr for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 14:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7AAD40544
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fTwcoXXD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7AAD40544
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097526; x=1826633526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n/iBxPET2SIFQ0ptF5C2r+HLozj9+RShh/zl8NhljwU=;
 b=fTwcoXXDvFs/AcgD0nD/8AfLuQhe+d4uSgQL/ZIW0ccEza6cg99DFpnf
 btjuwUtAEz2WaKrcAu9P738HMa170Yq0hTt5lyDEmRI2HbF5pWfch7Sdi
 Bx2rZBvxb7idwYg8/iSqV7+BTNEKLnz2uEEvylVGV+LBHtMMSawaTF3Ip
 FVJfSJSgulW9T6PyoF+KJJNOdFEcg8TcqbPc5rzDU1bmjvKKZcS+KgZNX
 yQYpSGW5t42DUAwfJyEuzTtIJxPgf80f6hKljQFho75gzZGaNezCKxldL
 0JqM1QsLrEYm2sh+htPq1DZ5glzwHNJKH3kXcGd34RRc54SDMQ4ozSBTS g==;
X-CSE-ConnectionGUID: ieyaeo6oQV6WZEock4QWuA==
X-CSE-MsgGUID: mCvsKs0oR32idniOcQR/Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3835625"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3835625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:12:05 -0800
X-CSE-ConnectionGUID: A1pAg2sNQf2v8YOtHncBqQ==
X-CSE-MsgGUID: tsS8m9EKTmq2ttgkO+wf+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10476150"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa002.jf.intel.com with ESMTP; 19 Nov 2026 06:12:04 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, stable@vger.kernel.org
Subject: [PATCH iwl-next v3 1/3] idpf: always reserve one empty descriptor on
 XDPSQs
Date: Thu, 19 Nov 2026 15:09:36 +0100
Message-ID: <20261119140938.1363722-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
References: <20261119140938.1363722-1-aleksander.lobakin@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

idpf-powered HW requires at least one Tx descriptor to be always
free, so that head and tail are never equal, otherwise the HW will
deadlock. This is already taken into account in the XSk xmit code,
however, not in regular XDP Tx, xmit, and XSk Tx -- these are much
slower and are in fact almost unable to trigger that.

Either way, be better safe than sorry and always reserve one empty
Tx descriptor by passing `free - 1` (this can't underflow since
`free` is always at least 1 due to this reservation).

Found by Sashiko.

Fixes: cba102cd7190 ("idpf: add support for XDP on Rx")
Fixes: 9705d6552f58 ("idpf: implement Rx path for AF_XDP")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/xdp.c | 2 +-
 drivers/net/ethernet/intel/idpf/xsk.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..1d8ed7ac3e17 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -351,7 +351,7 @@ static u32 idpf_xdp_tx_prep(void *_xdpsq, struct libeth_xdpsq *sq)
 		.xdp_tx		= &xdpsq->xdp_tx,
 	};
 
-	return free;
+	return free - 1;
 }
 
 LIBETH_XDP_DEFINE_START();
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index 5a0a1d8a7a86..ef079d2cfaa5 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -294,7 +294,7 @@ static u32 idpf_xsk_tx_prep(void *_xdpsq, struct libeth_xdpsq *sq)
 		.xdp_tx		= &xdpsq->xdp_tx,
 	};
 
-	return free;
+	return free - 1;
 }
 
 static u32 idpf_xsk_xmit_prep(void *_xdpsq, struct libeth_xdpsq *sq)
-- 
2.56.1

