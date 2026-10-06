Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA75CA6002
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 10:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9749F40585;
	Tue,  6 Oct 2026 10:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahLGghTGjqnr; Tue,  6 Oct 2026 10:06:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F23EC4054A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791281160;
	b=LSneaYpOVI75KPomKa/HVidxeZFx1yBrZ1y5WPTGLYx8HwN6Q2a/b8zC+ZqUwu+NQkmn
	 M8Hg7X0/0YqJbW+KPWCkhG5oHjtYXSRR3AExaLtl987jHDexoHE+dtBILxra3oOZqfT+f
	 cL/A2Ek0//gjqj4gkZDsqrS13j3vMDFEo9A9CjbmwoU2F4mvKfZH5KUtZXcQkruzWFoQ9
	 y8SqmcqQNeCDHWEd2trEj9nYpsAaKckPpndbd2U4CydjqOgM6iocWzWkn+o4cywrjPDj7
	 b0OQTcDFUQm1ZkCMllwTq4QStLXpKCxDJOWtymQrf7bZgj7Z9c3Ll4OhP7gW1bkoP9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791281160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vizTyVjGlBaKxZpLXjEqoJUEq3qkgWbFrOaL4K1/bjk=;
	b=CzkhnxDZIlRtRKyFijzx7KB9RI0L8oU0Z4bBn6l8yHEkPcePaR4QugICejN819NVVJyj
	 yegoqmmJaTe3XJ/sakll6dKz66PNaww1xrY139Q9zw4kqQl1vC2/gjdEFkZonOUEzn8Cr
	 lI4fHNAgP5N40+yGwJDMaXpyf8m3tpqR4h/pwEl2rFsKUGUcbktqom3vPsJBW1fAevR8N
	 mN1jqXsJTD4YICzRn+1QQD5VOCCGlmKAPb8YnRVhvz/rQcERTRlQ9A83LWRDhXHlm7q+J
	 +8zjtEiu8XovFxjoLdpFGtz6s6WsSeW0CTDrhbvzFNh0i/5yqxiBvdEuDP5s7QKXoNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791281160;
	bh=vizTyVjGlBaKxZpLXjEqoJUEq3qkgWbFrOaL4K1/bjk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDOeqHJ1ICHJaz5o5TBaFY3PdoGYUmmfBURY9ezwMFB0hkbb4heA8QlCimzjx7It8
	 7VfbyzfD7yjCNNbLvmq44Z4uxjM8ePr/7LLxUXKupRXLVcEmXYCvBPx36WVOx/BXFk
	 nWaMnoZVdTaOculs9HOWb6rNV1XUm+CzYv0678n0+9EqT7+r7VYvCRIOz73TpfggFw
	 R5a7AkgAEbQ+/VCEBOQOMwMADPJtduo8TwTb6TJlIAD1ZJ2VxNOQvSC2i6BGgXjO7X
	 X8DQBmmg+56yL7ktcf22JgIPuVeBVzJGbYZJ8Pab1LSSDnqnrWZbTZg0Lhtd2mfyRo
	 JaFgpCv3Icceg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F23EC4054A;
	Tue,  6 Oct 2026 10:05:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 938CF32F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79FA5605D8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aM1ROHeJsOyh for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1407C60740
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791279938;
 b=XI6j/du/+KDQelT3jvo6e3rtVVP9mK6dox9xwqj+S52khlmdOuRzJJZNN3i+dmynJP+i
 fjCQwdvkxcOd0P0nsycUPom/braOnfmQGV6C0p9UGcd39tD2/I5hdVQqMu/2w6yvpAwfe
 kc17q6SvMu2KKYHG6JWE4CNMuBubkcPm9nvaU1ut3GhfH/tQXtosLjlLWoGZfLAD83K0s
 O9vmBsn35Bfoq52YDtDWGHLtIjfsYmObBcz0Gp/tH+cYkcPLqBlISbGlg9MzZu0TRzJVZ
 8TCkbJq9TS223T1U6s/mq/hw4DKbbiqrzRqWzoW5nHlvoLDY3kDBsYItngm5UDttqnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791279938;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=vizTyVjGlBaKxZpLXjEqoJUEq3qkgWbFrOaL4K1/bjk=;
 b=e0T2ISUl88/b6d+u5ecOaHoHRI7ynzZQnUILWF3lPRwpPsQJVYVdbq8mCURb9V0awu8z
 W2s9s5AFUm+Rxl6/bCvYTmAU1gmO18/5ZgvnhT/1A6PBHcAOk1UO2eMoFMCTI9KoqFglT
 A2/JPSO2I0yMm9ItVoPy9M/GEBV88uNuw0njtSa4RI5j4dXAjuT7YkChdxVPnGtw1kNo2
 z8RKx4dTVPmI/+Ji+f8KwPYOvFWyhTLNuzgKSgYM+ZTEuIbRiL1q36frT77kZFgHjfuRv
 HxCnjYABwuj/4GOOCuHI5pvle/maqkwwGwf1qnw7RjQn0cXxpGYiVkZrCCbB2tkDrFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kR6FtYEV; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kR6FtYEV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1407C60740
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279938; x=1822815938;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=y0xqd6ED25c5+jarz7mF25uTdq99n5jdN5Dtv67bn0g=;
 b=kR6FtYEVn3IlPajcg4KDrt6Vs0x5CsjjD6VuErf44CSViht2BLbu6mnw
 86F29IdnL1/CCulOhY/HkXKyZAsGCItnxRIDTdvd14TElExdBAepRsKFX
 VeLpiqhPvrh7803ZOyarAPFW656JO4uAjUAxolzqKNIW1lpmcEi2QZsAD
 v/EeVBpFDEhe45i2fN5fXkGMn8N3BQ6y5iFVSyOAuyK90x1+s6obULv7t
 tM4oNDrRs1YsAlwEmL3RI5pd/EoNX7Y3CM36KFOvid3SRqeyjLfBRAy+2
 EXADnaL7dd8mlUelvWhX7DSW7IbFHmxBzomzQes3cRIF89iUJaLkOXHsV A==;
X-CSE-ConnectionGUID: GX7ThpKLQCuFlRDYs3j6KA==
X-CSE-MsgGUID: wmq+nmMcR/K6OTD48iBAZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3210"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3210"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:45:38 -0700
X-CSE-ConnectionGUID: aoH2+wH4Sz+OrMP3Dj1sgA==
X-CSE-MsgGUID: V3oOXXyCQoasLUNtrMGbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280350286"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa003.jf.intel.com with ESMTP; 06 Oct 2026 02:45:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v3 3/5] ixgbe: Fix FCoE refcount taking for
 unsupported adapters
Date: Tue,  6 Oct 2026 09:45:32 +0000
Message-ID: <20261006094534.418657-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
References: <20261006094534.418657-1-sergey.temerkhanov@intel.com>
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
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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

