Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E673606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MyLuPYkT;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rx1XK/Aj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F83B4070E;
	Mon, 26 Oct 2026 16:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2wV66GZ8fQt; Mon, 26 Oct 2026 16:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE4AC40756
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032479;
	b=UNGnNtWSwdxy6MhmoLJhBsk048OkL/BlTJEcM1rKbD2gRxRuVRTbtLWWzjxu2NH7PYDE
	 Llsyp7xVded5thK4HPp9IfR1LyhXxRRqN6CzkaDqa0rOL6gOeRP4euL3ufBk7cw+x6rYn
	 MoVVzyUChV7KxtvU9Uxy2hIFsuXTEoIHbFGfFBovlO7LeF9MwJihzD8eugN5M9wXKa5wY
	 v6IvshDV55eCds33Wz4bxGsJdXR0l6XuuyM3lcw6eONWIBAiTxydLDhQxF6gtZuQ4pxMC
	 b8y0j9X7v085RWSDfSxYUfN0oReBQaJxQEbeWHj1EC8hcNEY0xhdRH+0Z0AgTTLWdQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xk352vk76vnQ3MqMoZCtPzGIrF5W7ccorLPVYZuXbj8=;
	b=AHzrFZoD7DHWMkzB0U6fif/4Ldhj32NnOPbCaJl20xQSWliB0WyMDGkUtJfongpBpM5O
	 3IOcZzyR2kkEK3+iSCgRS5owMbQBt390qj9C9jGECUweB4Vwsekk5FpnLSQGmnriIUT0Q
	 F+lTdE/WTHeidD65r9mgw9UibRMWC9+ZfMFdMNA3wPwKoHvWWqbfjaWpyBCvHs9+8Y32b
	 lbXQF3bjEID2tgIb7khEzi1vTlDyRYickaRzDfZL51XiBQ+qzB/O4K9jQA9uNN1wBgWRs
	 w++Pv71doCLKUBJqnGudYaHouVOoNsiV3lNmGFnEMIidlpXIAQghtiIGe9hS0ePhXJg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793032478;
	bh=Xk352vk76vnQ3MqMoZCtPzGIrF5W7ccorLPVYZuXbj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MyLuPYkTPOSXUnFijXUOWcgFj2z6C94DCwWutDOtVpy8YKCGsn0NtC2DG6deImZq+
	 UjmEBVX37PNLWOS3vUExY2iHrQWMPRcTRCqgbXl3Y2dHJW/JD7wBY/Ik8DSbMHUDXt
	 uyoTsFElsZOov//DkvgV22Hm63TfKg+gSfTMqsS101RtfRyIVJWfblRsrSPqohnP+I
	 HPNseZqvs7J5S9Bba3bwebQj5NVl4FcJ90ol6FOy4gTsSZhfS+qdsZRlbT2VzLw3Cu
	 bGj4Jr8TrJ5aRBACGC8YSN3J76nWnq11TvE8w1zfUYJxRTmFYj57ZmeN04MneHI6qV
	 mcZLliIS84ArA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE4AC40756;
	Mon, 26 Oct 2026 16:34:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91052356
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76EAE605F7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrg3QBtZeNWl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 16:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C531A605F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032477;
 b=prWTxUXHbDU125ycDknkEVKXtt5i8xAWLUWnBdbA0vO/+C3sms4tfD7kxhdgbJeVoQTY
 Xykmxo3q0lsuYg1wfo0M8i/VIedCWofc8LHrNkaynvH9PfpGIACe96wQoZ4VMlD/KOgXk
 P72kCePFzKD6zUvGLpSLSbbC6gFwGX8rGQgiEdQ45BHcJVWIBrD9PFVvncerdz3Lh+Nir
 BVze7eJUG8HLwMNmTJmybGZS7QwxPioq1ujpcZ/a2Ioyo7RqYBMEbYQSrW2WrXZ2yz+Rj
 HKXn2r1PQCvT7iwt1+SvkAFxRTNkW5LvEv37qP2nBr+XyooMtvaPudFLbdSn5plXgWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032477;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Xk352vk76vnQ3MqMoZCtPzGIrF5W7ccorLPVYZuXbj8=;
 b=jPE1W5/6Qsx51SZHldTABqKJHAtM2aoR+F8NT+f406F2rKJlnS4M/Ks44E9U5MktGQ26
 t+GOevmqV/eu4ZLwM6hJlF7KTN3amS7tXRusG42ufEOf58rM4+xmAsnBZgTN6VxNfYJKn
 3Zx8eWm1ak86/EZcu3HOTSO5nuvj025c/BMPeie6jF8va6dZN+GV1/3uIBuuvsaE0UbaO
 VWkMcsFVO7m3nCuitrzi/uD/O27v+P/lhg9DAaW48Bt8spS9EjxtV/RqZquHth3+hGbuZ
 7gQSywKx60SGup+CIIMuocWZK6QeM5LK+JfNYoYuVv7zjBjagXkb0a8//uMt6x/h26Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Rx1XK/Aj"; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Rx1XK/Aj
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C531A605F0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793032478; x=1824568478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lSRhtHpuzWrVRr6eROEcXDQ81PY6bFrPEnZ3LfUtV0c=;
 b=Rx1XK/AjY5qHERXv2wvIekLlLvGg5lTGhTcHCYZxvxODE/DkxnfhlzH8
 yKNYMG6D3kgIg46cjLbbCTU1mGqxRp3eLLxhpr/YU90rtVZP4FTm5sTBj
 K/yBaFqKTM9R/pWXiVLohaJVg0xYUusnCC1SqUqeXnAya2xS7Tid2E1OO
 J39qWD9052AcHTcSBH+9fFwGu3kgLrb2I8n5vYkiAQlsSmiTd49ON1s1q
 a25DNIgQdbrKNDDtNBoNPkIXEaIw/UNt7tsGmnX3z7r3HG/3u9pBj/4yd
 guNhQXEUamJP92SlCUTgJEzBbVzs6mqtA+x1VL4cOYg+ww1peavb7pZ38 A==;
X-CSE-ConnectionGUID: FsZBR7kyRAqoldJEH9Ov+A==
X-CSE-MsgGUID: mLdQNYnGQ16Q73gwUJT3rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1588021"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1588021"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 09:34:37 -0700
X-CSE-ConnectionGUID: dIFldJtdRmaXD7Kc9pKaRQ==
X-CSE-MsgGUID: ROH5HDd7Qd2dNsElc+CoBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4708015"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
 by fmviesa007.fm.intel.com with ESMTP; 26 Oct 2026 09:34:34 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com,
 Przemyslaw Korba <przemyslaw.korba@intel.com>,
 Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 1/2] ixgbe: clear Rx timestamp in packet enable bit on
 disable
Date: Mon, 26 Oct 2026 17:36:40 +0100
Message-ID: <20261026163658.2733471-4-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
References: <20261026163658.2733471-2-przemyslaw.korba@intel.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TSYNCRXCTL read-modify-write in ixgbe_ptp_set_timestamp_mode() clears
only TSYNCRXCTL.EN and the TYPE field, never TSIP_UT_EN. On X550 and newer
that bit is set whenever an Rx filter is requested, and a later
HWTSTAMP_FILTER_NONE request takes an early break out of the X550/E610
switch arm, leaving the bit set in the register while clearing
IXGBE_FLAG_RX_HWTSTAMP_ENABLED. That flag is what gates trailer removal in
ixgbe_ptp_rx_pktstamp(), so frames keep the 8 byte timestamp trailer with
nothing trimming it, giving wrong skb lengths and rx_bytes. Only a MAC
reset clears the bit.

Add TSIP_UT_EN to the clear mask.

Discovered by code review of the Rx timestamping path while working on the
following patch, and confirmed by code inspection; not reproduced on
hardware and no kernel modification or error injection was involved.

Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 6885d2343c48..8dc6a009b62c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1111,7 +1111,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 
 	/* enable/disable RX */
 	regval = IXGBE_READ_REG(hw, IXGBE_TSYNCRXCTL);
-	regval &= ~(IXGBE_TSYNCRXCTL_ENABLED | IXGBE_TSYNCRXCTL_TYPE_MASK);
+	regval &= ~(IXGBE_TSYNCRXCTL_ENABLED | IXGBE_TSYNCRXCTL_TYPE_MASK |
+		    IXGBE_TSYNCRXCTL_TSIP_UT_EN);
 	regval |= tsync_rx_ctl;
 	IXGBE_WRITE_REG(hw, IXGBE_TSYNCRXCTL, regval);
 
-- 
2.43.0

