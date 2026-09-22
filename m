Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77998C982FF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 217A960796;
	Tue, 22 Sep 2026 11:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qzNpBinUQwV8; Tue, 22 Sep 2026 11:36:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A209560780
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076965;
	b=ZlDBUnhI4bnJxwSDyunAWOBNl8xy/svdghRsrSjdw3GFpFZnSCqGMM2ZR5cXtnNwuMkL
	 0FmlC4LGZHe4jE30OYStPENqZWe9Q/1l9Hk2nZcYwZv/8gZaHbGniFj8rW/VSED8rtTcC
	 eXun8qf9tnQVbTCZfN9shS4c9+QJRZ84MECweLcat+clO989ZEz+KFZX6DX+a7rqwKDke
	 eShYQGWCUv7C/btrqzmEvDH9iEw6lcealSPlvjasO9c47OlAeNlusJNUxrQviaf13yfGM
	 3yqVQIPuYXTcjodg2TO7+E/3lti8VeFt+hSHQl+o/WV5Ubw9+89nzWqX7WRmnYIPVQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JqetkN7V+Go1GbZVm60LW04hQbgf7zJheygUQQka3OU=;
	b=G4G+ioOGzOBN9jrgWAAn51Rn8WiFPVLN0DX7BIYd7V6VEDYsGYISSBKA4Woz78+raZpe
	 583ymvCHT1563R5hdqCcLOJotjIN3OJqwJsJd05U9uszFNZTOb2Lo337iniDTe+YapMhs
	 1JL2q3UJN00fSNlxxBJ6kHOctMQC5rchotyuh+/T19eK4eFdxRei6GX+nwCJ06MYDN/XV
	 +SJWIBZgDlfwtpBdavIn37rGgFyThUfIj5HtsE6cJA7ttpoDj+7DafLSQCeen9XNLcC3E
	 kuSE43evow/pzB3NZHs9A1URXyP+Upvd8hRQ8euJXUGwCdjPXtXHFjq40NbWC8OkcDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790076965;
	bh=JqetkN7V+Go1GbZVm60LW04hQbgf7zJheygUQQka3OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=initRNYye6lzsV/ibHoulGPEpdi6PVeO82zuk/o1QAmy0PmgHzIe//amkt43xJ25w
	 9YWILBB8syQhuUrlnjkdYW6BmcoSvX7RTz93bk6o5vYaSbvzYdyxIpDb635bXohwWe
	 brj5/xpDN/youQptcIzyZpJQLBFmBVOMwpcr/Bnf1Ek4W1tTnHNXc2z4gCZm/+zPFW
	 q6xJe5X0H8edNIffRR8KkPxeYcUMCH53l6H6YbGIlq4rsHtd/yej71ZOMIPJiEj7T3
	 yCvI/xD4JfGItdA+Nf2fGSLkXnkMgs18SCc0JnIfpHA9QktfGCTgwVgllAPKpglZ7v
	 r2VSLnmV8eLcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A209560780;
	Tue, 22 Sep 2026 11:36:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B555735A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BBC780C50
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mC02NPBHxsUt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 11:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E418280C4E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790076962;
 b=Ro1OGkdsnV79hVgSXnHTFYWTt67LaWR1rvDS8kN6TAh5ppRq0kI0posN+J+eTscCDUWV
 FxXpLOs1BewtIyOqqqqz1q0vM32XpRJyX9kFESgiVSk68qyNjEJeC8VDaJnIM0y4UMGfP
 VECi/JeLEktPpWN4YB3IXl/1ZFHer6J31YHjM7IMd/A79+Ebd9WUnjrxpKCXLbUptDqIY
 UpLt9PG7JQRkXqolntE0/idahyyphZyJquIrRO9o+qLasv9LvvyXn8WqwvXyW/f5jBuQr
 F+yNdsYsxc+aWb3ouyUgCBWwQqQ0N1Ui5jKcZQeugvcdtDlutUrwzkuKFZjFc+3Cw4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790076962;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JqetkN7V+Go1GbZVm60LW04hQbgf7zJheygUQQka3OU=;
 b=EvXcEPWe20zVGO1etiL/MKwu7ThQvKnBfp3motIjYq2IG9rUd8cRlCj+qN4IasVL82Z4
 7umq5bV6/8al3q5N20SoiGON8hiKhSkHb895/HQFPmlNPUvvkFugElfpnuxY7hOQ8Ec/o
 ct3XzaBMZeVrw8YM22uZWuIBfq7PUjAVauD2k/QuvdOVxt6xi3YeC2jC9rIPu9qiS1dLi
 g4lS2CdLTlo879xn7wi9jcEG39dSuObDHXtqjD9PvWnv2XDkMhA8xwdphUJcor6hN3d2d
 WP2IroxR0n6TVCUp0O57hNLgoI6CPUC6KhTYP0D42DW1mgHiGdjlLb1lkjNWUfKEdaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Bps4lsAw; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Bps4lsAw
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E418280C4E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790076961; x=1821612961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EKdSAYxXzsS0D7//wmgMkbjn8Kk+YYSMLuL1v0Aqp4c=;
 b=Bps4lsAw1BBjcBobuXORGhdcvrcOxJ5ydsp11FWXloKIJyiB5RBlVBqP
 TG3fO19DBDkhzn8HB+HY+EqT6oyeWPoHS0v+dzmRp0/slBfMQdFz6QIe8
 COui8RxAIQ0uu32pEJrKKFPTy2N09hC6Wfi4zugrs+tRcWVEIckyALA0r
 WbM1PrXwc/eBqWT9BYmOoTBYBTo1FG+9fJdXry99CGcMERH8hAhP3Nvcf
 UMtAbCnHyTEHYbVRiG4jPz8KwKODxJBwAM2bnzJGNntmvIcn1V1qbVE4h
 84AzM62d826C587Lx5zwNHx/99ocaehck4MZwtG5bqERWwVRmu653wWX/ A==;
X-CSE-ConnectionGUID: xlDun/ZoTRC25P+hH7SSvQ==
X-CSE-MsgGUID: hTrSXHLLSra+we3RU1qAVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787334"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="90787334"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 04:36:01 -0700
X-CSE-ConnectionGUID: K4nx68ibT6OMcZfrQaMv9Q==
X-CSE-MsgGUID: +Ue86OZIRBSouRcLo686Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272591993"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:01 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2 2/4] ixgbe: Fix FCoE refcount taking for
 unsupported adapters
Date: Tue, 22 Sep 2026 11:35:56 +0000
Message-ID: <20260922113558.2288111-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
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

ixgbe_fcoe_enable() increments the FCoE reference count before
checking whether the device supports FCoE. The unsupported adapters
shall not take a reference while the ones which have FCoE already
enabled only need to skip hardware initialization.

Fixes: 27ab76065c0c ("ixgbe: add a refcnt when turning on/off FCoE offload capability")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 54d8b079ada4..6585af527743 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -838,15 +838,21 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
 	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
 	bool running;
 
+	/* Unsupported adapters do not take a reference */
+	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
+		return -EINVAL;
+
 	/* libfcoe calls ndo_fcoe_disable() even when this callback fails. */
 	atomic_inc(&fcoe->refcnt);
 
 	if (!netif_device_present(netdev))
 		return -ENETDOWN;
 
-	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
-		return -EINVAL;
-
+	/* If offload is enabled, only skip HW init, but keep the reference.
+	 * ixgbe_fcoe_disable() decreases the refcount for this case and only
+	 * disables the offload when the refcount reaches 0. This handles the case
+	 * where multiple offload interfaces are enabled on the same PF (e.g. VLANs)
+	 */
 	if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
 		return -EINVAL;
 
@@ -892,6 +898,9 @@ int ixgbe_fcoe_disable(struct net_device *netdev)
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	bool running;
 
+	if (!(adapter->flags & IXGBE_FLAG_FCOE_CAPABLE))
+		return -EINVAL;
+
 	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
 		return -EINVAL;
 
-- 
2.53.0

