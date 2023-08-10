Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC47C04A6A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Aug 2023 23:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EA5B41DB7;
	Thu, 10 Aug 2023 23:51:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EA5B41DB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691711483;
	bh=K97cf1tVCZo16FUpCHBvCKlkfknc176PgF7c5BjQMwM=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=VMxvCP/iX1ff4tiwDAnd+oxkkAQqsC6m5PGjDGlhEw0sodfd4o+eo3A/4xmWbuTjG
	 yjWAeGnlutWeAAAQMYdp6iepwvv9Zoq9JTI8f90xfA5Yj15MWB0T8CV+zG0QukGHDP
	 IaZN/7hAqbR/neSdf0Z3oh/utNBgP8Fe+TsNMjiBZOVryrISINUwrLBPTSE4GKUp67
	 U9mWYH8j+qTHEW+hJa/Ag/SkVOAMtnbzAJma9ZrxFO46Sxb3kc2ykf6ZP0m8TNQXAd
	 v+dQcLkKo92HLE9wTTZC6UDfk4M41BkKa1dfNkLTADlz90wsK58Sm/YZZMfoPKIdVs
	 K8u4/VwW9vZhA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3kFZQ6UBKMsD; Thu, 10 Aug 2023 23:51:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54A0641DB8;
	Thu, 10 Aug 2023 23:51:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54A0641DB8
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 549581BF5B4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 23:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3990B40144
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 23:51:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3990B40144
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6tK5nJiTtMd1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Aug 2023 23:51:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91F4740012
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 23:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91F4740012
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402521337"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="402521337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 16:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709331876"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="709331876"
Received: from jbrandeb-saw1.jf.intel.com ([10.166.28.102])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 16:51:18 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 10 Aug 2023 16:51:10 -0700
Message-ID: <20230810235110.440553-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691711479; x=1723247479;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+FebJGVtOU0ozNN9ME2PO2RSeW7ryCgG5maaWtlALcM=;
 b=m58YqInYuqLmVUcQQ2DYum7oGiQMp8Dh+wW0vtg51Q6WJivUFm7dZupv
 nGURfALAqqAyDdwmk7d9WYTcEEJ3kfaRVEfRMM95mY5P7wOFI3OraKMo6
 LSIFEQMz3c/lELua43CXW7jLBJ/y5ZQOeXdUuuyf1CfFbytSkiLrKkU7G
 kfYK9v/rIzdXR8HLC6acnDI0GzJEElNSxmaBTOVZnxzn58z7UbFMnWAND
 aWZY28j9mN/HCF6jmfJpG+CAgkBmqZQPqlZyh8nML1IdFpsKEZjt9305x
 SZzp4Tg/63ptHDXJ6on9rqo5Gzh029E9ZqUk640X7zZeXqh40BnRgjwQp
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m58YqInY
Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix receive buffer size
 miscalculation
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The driver is misconfiguring the hardware for some values of MTU such that
it could use multiple descriptors to receive a packet when it could have
simply used one.

Change the driver to use a round-up instead of the result of a shift, as
the shift can truncate the lower bits of the size, and result in the
problem noted above. It also aligns this driver with similar code in i40e.

The insidiousness of this problem is that everything works with the wrong
size, it's just not working as well as it could, as some MTU sizes end up
using two or more descriptors, and there is no way to tell that is
happening without looking at ice_trace or a bus analyzer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: added fixes tag pointing to the last time this line was modified in
v5.5 instead of pointing back to the introduction of the driver.
---
 drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b678bdf96f3a..074bf9403cd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -435,7 +435,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
+	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
