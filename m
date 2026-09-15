Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAD2C88E7F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D04216077C;
	Tue, 15 Sep 2026 12:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zSGwY5ZSgcNu; Tue, 15 Sep 2026 12:55:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3278260780
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476948;
	b=UnZMPBQfGIYVMou79qkPyCvEkVPS9CFIhR4faj9eD4wK37Rlf8uHaxrbVNdZojvwFj5+
	 4eKJ6lmyXlhQXJmB7QYliWTF17QFEo9OqvoYnsw228GfbrYhUjc6c1Zo1OATnCVsk9CMC
	 3sRMwPSa4ubpznvcp60zkGbiNp+Skep46k9mDgl1PvFFTa45iwjjUUE67BrD63+vFWuy/
	 JMiAg9gMm5RTWtfuJt3rDJu/dG/lkCI+rDyr0vVuaE2UT1edORCMozcIOvaS8rN9zu5Un
	 TMsffdl9AS9dn2gSIwAyZkZniBHVo/9XGd8ssw05YC2hJ5usbVQ8XKy6nSdSZiJrH6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EXGP4hJz8y8SstGQYzwyN6Gv3e+Yi+oxa2/ESHlJfpI=;
	b=WYxjDpjyALs5IMsSHWwj8FmGAW9MFcs/kUwuK9NIirGl5KqFhB3dvecLJCcJ3dLCwEDg
	 wk6Jg7rJy5yXkZmIKizrhG+R0eE8EBzkUq4aIyz4VyzeWMc8rcioCW4qqavg61J2Ie+u6
	 syucJwwZZW2Ni+vebtHbXyNYXruVXdBvHCQxXSBdIPNevfvc6Y3kd2eooY1Rh9qi3x9K/
	 +dnYEswnjrrRTm8IyjoXnttNfe/SywPmzxI0WQvyJdV6xVO97mCXP1f2BrcmfQaPtBqWm
	 9WsYCHRnKvpnL2YJUwYKtUaOJrkwg6+asc2QRtNq+m80hoq85U2I9nQ0FR3vNJxmO6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476948;
	bh=EXGP4hJz8y8SstGQYzwyN6Gv3e+Yi+oxa2/ESHlJfpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YedFFBdH0VOS4MAJoeYBA9suRzfKNpJVYtwCm4hJXwIFeU8eP5U/GC8TJlsq8uORU
	 KM+tmUlj2KtaVdDKQVuKbc4ItQqUlWDP7peGHxQ7hxlLMxFbo1WqbrkY5rwSmEDvoo
	 sNoLIUtrYdntQYyNoL52DuK7W/rG+F8qZKSTn0ZMvPN3iu6Z1GgLRfpvLTEpAuMzmK
	 Mm3viK/1YRPePXU5+hj7kpqHi7XEitThLq2tExmVC5Rf91b5t5ChOMluEGl+GZH9YH
	 pvuZX+olIw6Pe6axj8eaaWjzY7AF57Ofu0088qvTOSQUuqtnUbuH9mXAcKVB1dAFVL
	 UmSKx2zLVSv1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3278260780;
	Tue, 15 Sep 2026 12:55:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 997BB493
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B4184009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXmLYEB7K7cV for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C2D634002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476945;
 b=YUd15+pL0NXoar1T4yRvzojkb/QFJgC5VwKMGQxJVcd9JEUOpNB7177czTokquwwFmwQ
 StWM6YKdw3aBp7pz2OPGMDvZZmFY7LHj6SJtJYeOmIF4ook1zVAJV4YyXjRxLNoFjR044
 andrybqXkWYEK4enA5L6nR1rFYeQcCXB+PQ4aM1Nc2NGYGuLIpIa4nr1uI+Lk/ithZ6RG
 P0u2R8hUD2jOM1zPiVxy4cPCi3AEviT2610QGb9JCVsVr2zxuRw8/0IDpN918vcQPLZrr
 8to836zCbvd1G2/+BqoenXV4hJqywasxnTbROO8j6TL0HhouIh3nQ/9mvD1Br3WpkXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476945;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EXGP4hJz8y8SstGQYzwyN6Gv3e+Yi+oxa2/ESHlJfpI=;
 b=NeyoJtRds5m903oWkWuxSXdY/H0fcL/d1cTgJOhJlT3koEovZmiZ3NAlXlgDWRr21FkC
 bH9nxXh2SgpsZrXi32Fa/pgKcCGp9s1l5ACLfvGf+3aYH/Jdf0BMKP7NE3vUZU/70EPz7
 Xv4sFMEGPS6zuohd5ruphMGr3DMCSsmp4q0XCfM8sWsRtYCDlWiGqn6ktXyD/cUKjEVkO
 akjnqsCYeZKCGg1kaanfPkUzs8eqxV/Q/s8BE5uRTZInqAC1cbIlnvCy7Lo6Yys2GXOwv
 uhykwb3LGIx5wAKOdstgg/lMEzE09DzIIyYDfhtGC60P1LeND6Tqy/Of/RPLIPZXG2w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SMUNj4TA; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SMUNj4TA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2D634002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476946; x=1821012946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lGVnIQv9TtpdjxowxbaaH8QKjUMRQwGbViMg10Lb1h4=;
 b=SMUNj4TARKCLT3Ly6yiaKqFdpTIUEmIl7oci3aACDXMb87phYUE7Z+GG
 Cfpk9YiQqfeujNMWgCphA/sstYTxPr3pqbnwJ1z5RilJVUQGsr0/qKNla
 1WdBtiGTkTgtpWN3I3mkAqEk4csQAIMRBjZWX3/5bYm0MPvTAgj6kUekw
 hIoRkm4en/rkJsSA0sijAUZCZoLsSwCxvLvBjwfnA7Hi046+bz8eqtVfw
 PoRZ5SXYXfxoC5jTgGoj9+OyPSQ1wthylm1xtIU/Lqv2se0gTNDjIVz8g
 e+GSHmrWblkfh7pIsW2Mjif33I3Fw8RVO1PC7SzD+VSUKjBlljnQCdJZt A==;
X-CSE-ConnectionGUID: m0JPSPOfRSKD9ZE9UPW+Ug==
X-CSE-MsgGUID: ianmkNFFRKWjUIBltUMslw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853134"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853134"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:46 -0700
X-CSE-ConnectionGUID: l+pfQBX3QyeJL1fJvPhYHg==
X-CSE-MsgGUID: 67vQhP6bQTaQHDuaNwzrbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225245"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:44 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next 4/4] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant
Date: Tue, 15 Sep 2026 14:55:38 +0200
Message-ID: <20260915125538.3975870-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.

Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
0x7F to name this mask explicitly and replace the open-coded AND-NOT
operation with the cleaner AND form.  The two expressions are
arithmetically identical; the change improves readability.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 1a7fd90..594ccb2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -478,6 +478,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 #define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7fb2ab4..8d3627c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2962,7 +2962,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0

