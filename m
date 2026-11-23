Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDA606A331
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1C3745wQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/dN1gxv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1D0B4064E;
	Mon, 23 Nov 2026 20:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pe-_rCSzB_GX; Mon, 23 Nov 2026 20:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A26A14061F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795467368;
	b=q1WtqzCcnSKR4fNQHSJMTKA4T9QBwh9IGLEGqQn4vLTyE2A7swuUxE2P7tdg2wSHIDsw
	 fF3kOFMjs4D9bmK9HZ+DexhJOZn9oLJaYRPhJZ9PVg7UCsfOYWYFgZXcu8G1Lk/6HYyr1
	 T3kH7Zlh4vF381qb+A8/k1Unu5Mj0ZD4VvPjUM3ZZZVr29a0vU2+1qBW4V4fEM121GD5b
	 gk/Ec9Ui1Wn8MJx4bLKDIsmjF/r7oZG/P5nq/S/bik/LVc/vG+2YkhbFK3KDD9kASrmnd
	 gZ+y5RiCrx5P502qTz3MKodXpF/jrypLyrSk/IWoHfcIb6t8OrTR0mLoMvfjERPSepQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v9Xs/9UOCy4NfFRwfw2OqgdiPlsC+LHKW1TGrRmz/LM=;
	b=k/lPrXyA3LM0EWZ/ObLHuTwzD5ZcxUDyPppdheHTcgfEwgtkXu8GkqI/rN3dixSWkpYD
	 NgOXO3QGiFE9VHhNsBsqkBzyR5Fpy0p+0pnC4FD+7uF8ef3h5Zdca2aXs1ENbNXnE2pN2
	 VDL3spvwBs6iUPZuEvpxrgOXkj0jUlSKNZZaj1YrOSePDfrqoVM30j8MKhNfUINLqwOhp
	 zjKsDa3XTvRXxfL86jTbJOV4lCvCfs3xpG6rbz4Jh+PQX843rKyIvMtCPEF3SgLdSX34G
	 lKla50Auc6wSmem8hPJwXyzBVF8s3j7QJ8jnS83iDUMkvG1ZymiCD0dWDnJASyRZaEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795467368;
	bh=v9Xs/9UOCy4NfFRwfw2OqgdiPlsC+LHKW1TGrRmz/LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1C3745wQLPAPZxgzJYaetNLF8oJENI3OJhprJefzCu+rORiHj8S3ab1HI1VHstKZW
	 u4MoT3rIB4erFOe7yjfIyqXUq2xyXgFTivjvdonpWuYyqZ0ZGSmgz04Ye+0SFM8KCu
	 ztPrDWU8vMWFmprMZZQQTqgOh9lObzd1psq+tFKNqbzuihxyxLEGhjmAIbCA7vEBBc
	 l6ZtgkCrAjscM+EDo+ezFMxrex6GbusKKceSkLfxJ6TIj2RQfd5uxszV2hvr9pS6SG
	 lP1yU21EWDbv8jyOMvzYDzSi8hfQbmwd0/Us3fm7QP5yVr66iTuYeD4nC1SyHbVfe1
	 j/cqjwJfuLQRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A26A14061F;
	Mon, 23 Nov 2026 20:56:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 117F5311
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBCEE40081
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUVmQrWFCo_C for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 20:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F51340024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J/dN1gxv
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F51340024
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A89444DE4;
 Mon, 23 Nov 2026 20:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FFD1F000F2;
 Mon, 23 Nov 2026 20:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795467365;
 bh=v9Xs/9UOCy4NfFRwfw2OqgdiPlsC+LHKW1TGrRmz/LM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J/dN1gxvnYKauldEd9oK53I5GRAkqD2Gs/66fv1eLZdajpk4FFszV+WhEOqyKTq1E
 ltZn6EbmVnwsjwB7909nIxNW/4qglyhhEFLRe0xVUTyCacyuSwipXlyLcwSk7EO60d
 2GRMPTPvgucDJP6XH6ZGDJp76yY6WLSIW2yXpQAWtOYo6DWAK3nco765LBzmXbLcDH
 U9+5ZxWikEwWXi8TZq/UHY2ny63wkgdEt2sHxRN3XLWl3cAn9jZ14LVk6TSX7+1/tL
 MMtZmv7XfgRrnbCvfK5B9KO3Dt9GYqqlVynShRtjVqYDzpHNzkbngne8jiQbDVwKKS
 9DMofhxtvtDjQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ahmed.zaki@intel.com,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] iavf: don't unintentionally switch to symmetric RSS
 hash
Date: Mon, 23 Nov 2026 12:56:00 -0800
Message-ID: <20261123205600.1794292-3-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123205600.1794292-1-kuba@kernel.org>
References: <20261123205600.1794292-1-kuba@kernel.org>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RXH_XFRM_NO_CHANGE is 0xff, iavf looks at this field to check if
RXH_XFRM_SYM_XOR bit is set, without first checking for the
special NO_CHANGE value.

This causes any ethtool -X invocation without explicitly
specifying input_xfrm to try to enable symmetric-hashing.
On VFs without input_xfrm support, NO_CHANGE would have
returned -EOPNOTSUPP.

NIPA HW tests would catch this but there's no runner testing iavf.
iavf was pointed out by an LLM, fix was compile-tested only.

Fixes: 0dd415d15505 ("net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index e7cf12eaa268..d81b2d6a68ac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1824,7 +1824,8 @@ static int iavf_set_rxfh(struct net_device *netdev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if ((rxfh->input_xfrm & RXH_XFRM_SYM_XOR) &&
+	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE &&
+	    (rxfh->input_xfrm & RXH_XFRM_SYM_XOR) &&
 	    adapter->hfunc != VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC) {
 		if (!ADV_RSS_SUPPORT(adapter))
 			return -EOPNOTSUPP;
-- 
2.56.1

