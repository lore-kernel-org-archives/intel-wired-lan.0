Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF6610BA435
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F08C83B46;
	Fri, 27 Mar 2026 07:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwTZKGfsa485; Fri, 27 Mar 2026 07:31:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B794583A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596662;
	bh=kVIaHAa4uaRA0Itr5dFO3XCQ/gulNkxlSsAb0NK53Dg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0iAaDiuBFM5jTKqGtZVY+5bjFekH2SOzp/mQ97/EVzY/YlUhSCVxiYYv2GMakxRtP
	 hjWppsF05eJjdz7OdOTbHgb7eE1Erzm8KXgYWtnft1D/G8Zzy7nn42TQVQBB5Ifva3
	 UPSd8vMhXINHsBnHueR8OYs9AwX8d+tK2jGTqxxesbXX5TAUjqGVs3cQJrQztrdZrH
	 MrSQTk1FVWGn8wGVCjLjg0shKeyCpFFBy+okYvppQvEYjp2tGCWg5WmnswX55yVx0k
	 F2iBaZFYR8EFBWROFnY8yj/bdN/tvgm/MTkKjViWYV/Ny9LqCuV79ZRZIRBLAudCcI
	 BfkqGBUn8tZtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B794583A88;
	Fri, 27 Mar 2026 07:31:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E6242249
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8A58415C8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXPrgyHDDg6B for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:31:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 12BEE41598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12BEE41598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12BEE41598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:59 +0000 (UTC)
X-CSE-ConnectionGUID: q9sEOLgUQlqDgrgR+akypA==
X-CSE-MsgGUID: TDCxDuhdR1+xu3DsnKkivg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734326"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734326"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:30:59 -0700
X-CSE-ConnectionGUID: HlMc/K/cRtG7tuq41lPEKQ==
X-CSE-MsgGUID: ANQZfXGWT+CTad4XqS9ztQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740394"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:57 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri, 27 Mar 2026 08:30:42 +0100
Message-ID: <20260327073046.134085-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596660; x=1806132660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w3FMcVYaCrwrpfwoeEHl6nNRYb9VqqgyYnHsaVgefjc=;
 b=ClVvjAFyYFT0NBjkSkQORYpvl0+mgQglgOyA0dYBkmCkGpnI4gdghYUK
 B1BM78j7Blz5xyWK8/ynC7WFrPrv+lXoHNhuYEO9D6ufAXtWCxvewxhGX
 5Ifw96LsbyinqNGBurbU/HVm2JbaVkQekvB5w5opl3A2UnF+0JhkDL87j
 BKc/H6XYlpLxQF2YLJykeLB2TV7miGrww+N29R6pojJswYjO5iMukw/tN
 WUsJg9tWQsJ5sDi+fIQ95Xvb1qFr6gwqHwgM6lJaRXBdZ0MrTeCgSRjJ9
 HOvV9aBoDypi1D8GEtvLQbVt26KjHId8UQJGWk4zAJrNiULouMQ9LN09y
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ClVvjAFy
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: fix cls_u32 nexthdr path
 returning success when no entry installed
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
even when ixgbe_clsu32_build_input() fails for every candidate entry
and no jump-table slot is actually programmed.  Callers that test the
return value would then falsely believe the filter was installed.

The variable 'err' already tracks the last ixgbe_clsu32_build_input()
return value; if the loop completes with a successful break, err is 0.
If all attempts failed, err holds the last failure code.  Change the
unconditional 'return 0' to 'return err' so errors are propagated
correctly.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index db954e9..8ac80ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10311,7 +10311,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 				kfree(jump);
 			}
 		}
-		return 0;
+		return err;
 	}
 
 	input = kzalloc_obj(*input);
-- 
2.52.0

