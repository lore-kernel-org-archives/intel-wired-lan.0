Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD8AC9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 13:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F40BD812B9;
	Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zb9KQd-LscC2; Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 35E25812D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790342822;
	b=rdhCO67EKU2FvGvz1mgPjHIxWmwEwosCEtQ0F1VDMhbCnPq34rE0tazSudampkCtZAcr
	 JITe7a23r9pYnpt64x9byDOdqATgNSxoqDO9GqjWJqSCa3pNi/MXum0+umMkq7dnzZK32
	 Gfdagx9s+RQfI0kU9u+ehYu1KxnOiWnaygsJsOr9Sd+huFCJfukh8nHZ7Ewf9TkylYZMy
	 kjWzeqYA1B8aWKdt9HVAdHD4SaRPziVcI84rbjxw1oF60smYud4DbGL0AqjtIaGF+9iWj
	 w18AGJjvw3REByREvc4WLw6rK7hvMBbKf2v8rpZQAzgumcVSzeebs9ZHFQSu4P7bGNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790342822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oGBVYLhJlz4NGG54dKtS+/M74MW33Nt8UenwhM8nq3k=;
	b=GlA30HiVdcjBefj1j6XoLaZWoMsem8ISrxJkhFYZflD+rovJpV6GZno7ov8J1RjQItBL
	 xlw8OQkwar0unSmP46rqBiXlBPjcvMMiKeI+aXAsPjO+6sonLRN77CS3aKKVETSKuiGgS
	 KngXUP5jVhja1RqwtDWX0y2kShJvv6bPeTDS2nRCqkeA7NqfMzhBxha1allehoBX3uLNK
	 bNskYgh0quDrJwDKmyVLqqQ9GMlh5F3cZQdl6yJqjT4Zw2HV+3vTcR+gth3u2fGrbidEI
	 6ny4l/eeX1OLwVIK77FIejicgWkymJLAz8odBy6x1FXpg2TDwFGQNXOzn28pi2PvOcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790342822;
	bh=oGBVYLhJlz4NGG54dKtS+/M74MW33Nt8UenwhM8nq3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QC9Uo6jKh/FZq6b+mxRLnVWGyjgHcJ53QvZchWg6AEzK1jRvQz8ZHIoezZGZ2f03a
	 dGCLguEJPX0PK9RtHX98+RWuBY/yc1uSApGNqOxybcwe2BQvUIjolYb6CEDc0TPudk
	 Tg2A5mZLLSSuwUVYtcSpcqnPQ54nspPSOHIflK8y8kJ9Ug1savHOi8cuwFUn5uUG3f
	 y78ucHDVlroZDmh8a/v7CS9q4dhvhYCZxmlWwbvnloOFGsvUqNOaX/zYXv/Ub6y5FV
	 H8YRxyZDuROTgom8cu5ub2sayJG2hRje7xJn1SwX7XoqMaHDahEGfafXhYRgKWRKVA
	 6g1ofIwywrCkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35E25812D3;
	Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3176A32F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 232D240B2B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOdkBWcww5Gy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 13:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6325440B9D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790342818;
 b=SOrHckFDUkbFQBB6dO+5QIuRxsXFd+nFEyNbI2DhoSIf1gK4kJdnnnfFtzH5xxIKfiBu
 NepPywXXmqBAw5ALUVKXt7wxQpLdUS6XbaYxhDd5OHzBhhces4+bj0QaQfk3yKDTAdJsF
 MJAEkzdv69ckPzNxbf5gBM8WqaGSiPSI59IR38juHiVZeNmdHAJ2x4Qw716V/Wa40O9Up
 6A5/AHz5PUWESu6Kn0fUQJ5KD5VpeFBSrYczmRFWA3xnv+/Fb66DNE/HZbleBR1mHMIh4
 AInPO4cMAnejf8/OqUVRqP2mrhxgsA/AuW11ni3G/jOb2L/q2qmT7MhePRwE6CMb3nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790342818;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=oGBVYLhJlz4NGG54dKtS+/M74MW33Nt8UenwhM8nq3k=;
 b=MQ/2h2v8/8iQofwJYVSGsV1gHyHOfhMSOoiXJz4/U/3lkwlQ4em2iThYskbifYrpUy+p
 lFfnmdV+fhl74jYxtxv6Tg54uvIOlHgprZukdyeYd+xxfNI7DK1Fmqc8pCHMQ4FdqkuFX
 p6HO/1WJqPPkQ0RHDGLxvXJJiMyibn8KhlBJmkMTuatr5BfnGZ4Vtw+nAjkegGVXFj7o/
 is9n8FAOA/W2A4p0D45KbVu6/6nAfQyPaP1D7Jce+/gkcMsW1YV0a8jQ4wmbpqePA6qzh
 4R3dFL27eEgfb6kYtAQZZgS9LLBuHGdYXlzvoe8tkTFmNMQv4oiSUs8M+U/VHCchlPA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fghHd0D6; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fghHd0D6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6325440B9D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342819; x=1821878819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h+ue+vc6ZyDuBSyrcnvHI2NC8aUuThBba84HNiRQPVI=;
 b=fghHd0D6qUo/C8/wPBg9GukerWrKviGWW/TNJNhBAoJUuWCvBlhdkmVy
 be0klGT1nzBKMUuvbaYXK+yRPQHwKOUfXkr7coC2YqzLZcZN/9Jz3esa0
 4nII781KYgUMgSRfHwfze469YJr4Sx4dy9OPQZy+XO83qh65Wu1bmeQdI
 DiyQT0HfKKJJEwtWsV4pACEgLy2XfDpem+nBgV4ZhV5RWARpDsWChl/GE
 JLUbjDMd7Q8RKhUtpYWDTiaYmL1qztpfgYZENwjq/Tghx7CtHyPvHM18O
 TF+faIxFIhITDVbdYGHtFHdpiS4++6ZJHFydLaT1EK9bYycNOdlcWjf9+ g==;
X-CSE-ConnectionGUID: oq79KWJ7T8y3DIfyU1zGKQ==
X-CSE-MsgGUID: xv+F7t2IT8G+PV1i+CM/CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508263"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107508263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:26:58 -0700
X-CSE-ConnectionGUID: hZgSwvmgRSabT3jqnqkNGA==
X-CSE-MsgGUID: 9MJ2x+c/SWSRYlw3NGeScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282414705"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:55 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1CE882FC56;
 Fri, 25 Sep 2026 14:26:54 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 3/6] ice: extract ice_vsi_new_stat_arrays()
Date: Fri, 25 Sep 2026 15:15:45 +0200
Message-ID: <20260925132636.123300-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
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

Split the allocation of a struct ice_vsi_stats and its two ring stats
arrays out of ice_vsi_alloc_stat_arrays(), which is left with just the
lookup and the store into pf->vsi_stats[].

The sole caller keeps passing the very same queue counts as before,
vsi->alloc_txq and vsi->alloc_rxq. A later commit adds a second caller
in the rebuild path, which cannot use vsi->alloc_* because it has to
size the arrays before the VSI is reconfigured.

Note that the error path no longer clears pf->vsi_stats[vsi->idx]; the
early return above guarantees it is already NULL.

No functional change intended.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 47 +++++++++++++-----------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1414127d32cd..ed32ae2667c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -519,6 +519,30 @@ static irqreturn_t ice_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static struct ice_vsi_stats *ice_vsi_new_stat_arrays(int txq, int rxq)
+{
+	struct ice_ring_stats **tx_ring_stats;
+	struct ice_ring_stats **rx_ring_stats;
+	struct ice_vsi_stats *vsi_stat;
+
+	vsi_stat = kzalloc_obj(*vsi_stat);
+	tx_ring_stats = kzalloc_objs(*tx_ring_stats, txq);
+	rx_ring_stats = kzalloc_objs(*rx_ring_stats, rxq);
+	if (!vsi_stat || !tx_ring_stats || !rx_ring_stats) {
+		kfree(vsi_stat);
+		kfree(tx_ring_stats);
+		kfree(rx_ring_stats);
+		return NULL;
+	}
+
+	vsi_stat->tx_ring_stats = tx_ring_stats;
+	vsi_stat->rx_ring_stats = rx_ring_stats;
+	vsi_stat->tx_ring_stats_len = txq;
+	vsi_stat->rx_ring_stats_len = rxq;
+
+	return vsi_stat;
+}
+
 /**
  * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
  * @vsi: VSI pointer
@@ -537,33 +561,12 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 	/* realloc will happen in rebuild path */
 		return 0;
 
-	vsi_stat = kzalloc_obj(*vsi_stat);
+	vsi_stat = ice_vsi_new_stat_arrays(vsi->alloc_txq, vsi->alloc_rxq);
 	if (!vsi_stat)
 		return -ENOMEM;
 
-	vsi_stat->tx_ring_stats =
-		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
-	if (!vsi_stat->tx_ring_stats)
-		goto err_alloc_tx;
-	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;
-
-	vsi_stat->rx_ring_stats =
-		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
-	if (!vsi_stat->rx_ring_stats)
-		goto err_alloc_rx;
-	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
-
 	pf->vsi_stats[vsi->idx] = vsi_stat;
-
 	return 0;
-
-err_alloc_rx:
-	kfree(vsi_stat->rx_ring_stats);
-err_alloc_tx:
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat);
-	pf->vsi_stats[vsi->idx] = NULL;
-	return -ENOMEM;
 }
 
 /**
-- 
2.51.1

