Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00748CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCC1440608;
	Tue,  6 Oct 2026 14:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAITwYhvzbMj; Tue,  6 Oct 2026 14:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 35D18405D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297220;
	b=A8bgs8mi0mL0UHLsaN/inxh+IhmBosX7NNqiHzi1NiVg8AWFoXPB3I2ccsQOEd3nujd3
	 xm/jq/T3rzJnNO4p5IeA2k/fyfqjgyPeiGHk7kuixOC9Z/eyt2sFtO+SfRtL3nIi1Y4bv
	 joRIJPLafR5JlDL8Ye5+SZ4cBiy/Lz8PEBuldxJU/DQPlkhyleYOEL78hkv90gZs5Kcpw
	 iOfh08/5gKisfU0i9SKNBzt9mn2IAtfR1eXHyM6RHH7Oxe8OpMjIR6lpIlutf4id4sVux
	 9CaXLaAKF/g62rGs0uuP9iFfEofT855YXQNKlSgS2f3eQN3BwlOHLKSfTnWRQeAxmaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297220;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KHl2iGPEQp4Xrkfv+DAGTykDMxTkEZ8AF30dbEP1mGY=;
	b=L9SSDySgdSb8Bd9xNBMfy2MmGoEvfNrevCHrp3WovEDE6mBZt5lY7E9kvC1L0AN8pXgO
	 QwzEKvMl6arm24UGh+wcp4U/NbDJTo72OHrD5AWWuFR6iDvUn55vhpn7ZoEaAUQ47QDHy
	 f6cNm822kbzuCtLC2rDfXIX+uE1Rx1nzRWwbbd+L8lrPFh9y/m/DDd6ofjFBKl/iT6tDG
	 R7kr9cj8nHl3nLXm2WviOJY9h8i+/dRik/H+E+M6ajPM3BiJXeUMqVmu62/eh1MD0CcZC
	 Cr0ugVdUUHdBAoDBNjnCblIcrfs9vzEmMuW9E0RYJRSd5/eSoeZX1oAlAzHQRqm9TEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OOd9U6qO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297220;
	bh=KHl2iGPEQp4Xrkfv+DAGTykDMxTkEZ8AF30dbEP1mGY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JNfl6dyem6Xdaw6n4R17/CDt0N7XpPR9soobyRrUX2stHmSBLJHZ3Z6cV0IiVVVTv
	 G5gRhLXSoNPTHnjIIteTlpmgQ1xBgN1LC4G+pAK4hvFtoJi/tDGubr2kRvrcyYcRo9
	 aqhXM09CZT/9FLLwSxI2SWKrFSljxpylkGxxiFM9hj+z+JVNJYvz4PGUq8dAzvsey7
	 2GxinRmHKk/VzaktnkPlPv7h0vUYmZB4zmatqFtBXh15x2Ylk4cjYJLV5pHxAQUzAp
	 l4TkydzcezlJk8qGY9gIK84ikQKC/q411IcqYXmMFgCxZ0Yym8YVqH9N1U1zFsmTut
	 VFl5TGSk6xxdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35D18405D0;
	Tue,  6 Oct 2026 14:33:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3DA1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CFE0402A3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ycq6o_m5zcSD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4D2A940268
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297146;
 b=EYBl19L8lyqOu+hUissqzIOkxssx9X2dMIybQszpqQixArwBBjwgxTx4N5DTnq7tzdyE
 d1dsaUobChuE5YiGgRain7sJco1vgVvNnd2lNh6BS14ODT/H14/ycju2608dj64K/KTV7
 UUFUPVoDfFa95mF3QJiIVO/pKZJ/xXhmDlmEKOq5Q5zCir86u0NeAhLnljPUpL0ChXEv/
 rv+nvaF8A2Z43AJuc/6U5PGEOWOIYyvjh+aiZROKkKv3ABD8GE6YsmJ4HaumzB2HIRlLW
 97nO7PXsrtTwEJZDtQp6yQnId+nLbjdbX7c9NxSWWH6ZCruYg/eCpQ+SnRwE0Z6IQtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297146;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=KHl2iGPEQp4Xrkfv+DAGTykDMxTkEZ8AF30dbEP1mGY=;
 b=m9Ytpd/XIwK7DH0HRmpTpibVR0ZV716BQiHpgF2qmGS3il/0BTUeAzB68erVxguq8PKM
 60oEiSg9B7gnbJB98d1Gv5h97P/O+j4YwU6J+47lv2oG5GhVb1DKdj5Io5lHirP7d8+Jn
 +Rk24wm86ZXJLTYfBLNrvcuIKRa/tuGAi1vQDxeyn8P3AUaPN+HsWrYVjDYGgHBR2F/+k
 RX6JUYxy7LW+eYimydDVRsCyA0gwkqYVzSlbpVM3hXqCqQ8HHLHerTvnv6MfdZWUlL23M
 9AAv4tV593+2dhgd3eAcELI6+Z+KGDxPx2q5WhfxgmAS+nliEODA31QQbjMw00ZTYUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OOd9U6qO; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OOd9U6qO
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D2A940268
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297146; x=1822833146;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I4X6tbLITYHJoIPgj2ltJVbDY+CvqTctIM5YDW0oOFg=;
 b=OOd9U6qO021mRj0lJ9vvaTNR/94LGYLi3ADToIpqwSxDoZ6G6Ds+lsyu
 3G9s4KU3jPPsz+8aaJSdVk6daczjl46e32OrPz08bPEI0Z0ahY4jDM6Tw
 Zk/QsXM1jlvCeHRm7VCDMh6GH/k0g9/q/QeSYen0ylxS2ctjh52GMIvVo
 H0Cm2EYWob2anBNeRccPV8coOhh6uB4NufMNN26U50JSLgVaPArrSdWht
 QW4j/4VUEofPBWBZlj3qO4jSJ23b+UUsB50HxZUsqD3GEisKFw3cEl7cU
 vnIdtDxhkTZKH9vEdv8aNxVERcERp7sDh2awS9xip7dbI8WVc4O8J8EyB A==;
X-CSE-ConnectionGUID: 8b/vQJdVSw+03QVvrSo8+w==
X-CSE-MsgGUID: LUo3T3WhSpaE2wjsGUklWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="40114"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="40114"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:32:25 -0700
X-CSE-ConnectionGUID: UX0YfoT8R8GF7Y3klL4ZsA==
X-CSE-MsgGUID: 0mDZpp8bRAGDVjhFA4LB7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="275813097"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 06 Oct 2026 07:32:24 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Jakub Staniszewski <jakub.staniszewski@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v2] ice: fix FDB deletion
Date: Tue,  6 Oct 2026 16:32:23 +0200
Message-ID: <20261006143223.2879430-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jakub Staniszewski <jakub.staniszewski@intel.com>

Correct the logic in ndo_fdb_del() to align with other drivers in
upstream. The condition was inverted — it was rejecting permanent
(NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
deleted, which is the opposite of the intended behavior.

The correct logic is to reject deletion of non-permanent entries,
mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").

Also add is_link_local_ether_addr() to the unicast branch of
ice_fdb_del() to mirror ice_fdb_add(), which already handles link-local
addresses as unicast via dev_uc_add_excl(). Without this, a link-local
address added via ice_fdb_add() would fall through to dev_mc_del() on
deletion and fail to be removed.

Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6b15f73..3992a43 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6373,12 +6373,12 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
 {
 	int err;
 
-	if (ndm->ndm_state & NUD_PERMANENT) {
+	if (!(ndm->ndm_state & NUD_PERMANENT)) {
 		netdev_err(dev, "FDB only supports static addresses\n");
 		return -EINVAL;
 	}
 
-	if (is_unicast_ether_addr(addr))
+	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr))
 		err = dev_uc_del(dev, addr);
 	else if (is_multicast_ether_addr(addr))
 		err = dev_mc_del(dev, addr);
-- 
2.52.0

