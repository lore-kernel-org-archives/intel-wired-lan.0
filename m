Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D4CA6004
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA17440608;
	Tue,  6 Oct 2026 14:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FuLj00YFtuKM; Tue,  6 Oct 2026 14:39:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1EC6F40557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297552;
	b=povFEEHLuAHJ7QWNOwSATfOCuuYK1VuM6INd4YqNFWWxpNaOTu3LwaEA4klAnpInSY/h
	 SBJfsamELrl4y6BNxbh9vvv9Z5Mo5un039qO1LLhJG//pO4t2HfpjCCHMo2At8RvqyQlp
	 nHdgRNwAygDWl7ELco2ddr1KmJv/gO2RoBZtcqB0QiWdb4nsed4vplHYPAtvm8ntRJ11Q
	 BumtS12u/36o77lAlKVt3Dvbu1YOPd3Lmq1A9GSg9jn50Y8YtI776t05RjJ99YZllztEH
	 2/Q3eEU+Aut8cYn5mP5FcP01eztvHICUiTmcFPng8iCt0IQwABHRby/IjOlEjpUATjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y2DW9XmBpb6bpo0NwQ3DWRN9YD7IQOZBtXpsx/NhqcQ=;
	b=HMrpr8KC/7gEhogWMPZ44w3gJX+nZ2H3aLCiOUurat5fXZdcGsqnHFK+tMZUN8gHvrqh
	 HMa53XbGhyA5urbPXZUsM96nm3/38Ry7AmyRhv1mYKIZ9rFBpsIBfuwFvXej7L/dm/QFH
	 FUO3tZFzRNTT6d6tNZy4Pi2uLZarc8z9GDCs/3TZlNUsVJcQb+vcD6nuzwC8oZk1j+COc
	 LOaxoM4o9fLxZYG1hdPMK5HUuWejftimHX3lIbk/3C1u152I0hEhQJXGhm43io4YGW1re
	 P9P1amtMsD8Ei1+VwZwA9dVsO1KhnI672SHaxKFK3QGnVPMcJaCexPvgxlF28ejjNww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297552;
	bh=y2DW9XmBpb6bpo0NwQ3DWRN9YD7IQOZBtXpsx/NhqcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9XXzSHsaxsvXZVueEWIsEyQGAtMLy4fGqk5QMOh1yu2BqFnUd8UeP0Pu/mmaobU7I
	 pM+j8EAANQV/DD/is6rgu1bwUOXwfY2mWrrogrphCk/FCRYR3cQP9bsWMdFTVQb+tv
	 D28bClKhf9FJuMX3azQszmW5WH3r87KS3hQOdkucNiyT0878rL+27I9KdkWZzCGewl
	 bB4Cr1vqMxUF67J7R5WGI+msNp8dGvAxCvdts9CC8G1xPblGGi9O2BtW8dNlpgdq0v
	 hExv5fcKLLOtC0okddpJJLcY57Q3O+UYMH7Ie5PUzumwAvwC5+i7mDRhyZCRpNoyYY
	 v1o1Ce8HoFReg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EC6F40557;
	Tue,  6 Oct 2026 14:39:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AD61F1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F01680AA1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ac1X1Zxmutzf for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:37:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 76EFA808D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297448;
 b=RBZogGinGLXJUHLh0nrNuvvchda8FHudY4J2l0L4RSzDF2ID15DsHNwIxrSbBKuXWIuF
 /mGkLRvERdgt5NZo60oo3W6a9S6m9mA6tehJdUN6PpNaf8P5nV82M7vbhMSP9wxaCQYjO
 o+U458Z4I4iJhDLg8AwBBglHYvMQHZiQw3jGpfRt8NmdCaa6z87Bv21ATKooDhMrQ1Ks9
 mWo2Z7ev2WpWTzasTR+dK98T6+KIX3bZhuk6ENYro3sIcwNVQN009AOsX0cFOmgAc79U2
 HvZdtd6VdYvBEmpgK2FzkMaGdWP5ZDBapuo3X8hbgj1KjqtCCDEabNUVX31tqEpm7+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297448;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=y2DW9XmBpb6bpo0NwQ3DWRN9YD7IQOZBtXpsx/NhqcQ=;
 b=d/YbkNwWgvBUDjpyBFwIt32RiYXILVjHVicM5xwX3EQTWaj1mlH4cmfjlQb68Qd+lSQr
 U+OkkYba4ojS9xmuDqVHUxTjvvR5eSN04XZGS4W6wmcR3oEJSIYjlNDCV8AsCEiu/u7TU
 O04GrvAnmq7pwq6RW2AYohexX4WlHTCg28h849MOyCogxqUJGqJfSXF/0YTIQ8A9Slu4G
 bCw+k2JiEniMxq1j9ZAh9+4Boa0PBOPEVso3CULa1s/ZsoI9gLpLFsxFTObYvYJALI4h/
 Cl3PEDJ1JRbA/9C0goBJ1gIYgITl3NQprGhpuhZ42orbgGgVSNfA8LMKewnL/2CXzrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="ZndAO3/h"; 
 arc=none smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZndAO3/h
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76EFA808D3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297448; x=1822833448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LWroWkCTkXT+OC8lMY7a+/nTQtfzGPplfN4gHqUOQvQ=;
 b=ZndAO3/hXocc2lxFUlHbhUypOW5VNI/t9fI65ldSHc0dr/FSK9VBeGdk
 RlHeEXSd1iwu+TxO6ZQlWSCEcG5h9VwO4uUc/mZz0Tcmfrx8pmQsllDrw
 QEmFavE7sziYsFQBI6mzO/Mc09DAGcKL8whFfSgBr1SOZlTzM8/uQ+LpZ
 ujWBB5wIiIiVH5S9r2lB4ibtdJUfltk27edSngu1VUBHbsejKAJ5kb595
 VrUNWcoLfAuvf4eAJ6/lbjSxM3Ldz55TuldHuK2ViSAmYDmBmhZ+/fXZ1
 VzCeNInDy28g9ng52qG5T7ryaiZXDfb/CEyxk6dt/U+O/ZNe64R8eoEIw Q==;
X-CSE-ConnectionGUID: cuZPwfqtTS29g8q0Lia+/A==
X-CSE-MsgGUID: MXaDDbgASt+/x9xkJiQy4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="43279"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="43279"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:37:28 -0700
X-CSE-ConnectionGUID: a4TOT8gaSwu00i4nZifHaQ==
X-CSE-MsgGUID: fPmbRHDwSnOh3kO9iU4Lyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1185335"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 06 Oct 2026 07:37:27 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Kiran Patil <kiran.patil@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 2/2] iavf: return 0 when TC flower filter not found
 after qdisc teardown
Date: Tue,  6 Oct 2026 16:37:23 +0200
Message-ID: <20261006143723.2883728-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
References: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
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

From: Kiran Patil <kiran.patil@intel.com>

When an egress qdisc is destroyed, the driver proactively deletes all
associated cloud filters to prevent stale hardware state, decrementing
num_cloud_filters to zero in the process.

The kernel netdev layer is unaware of this implicit cleanup and may
still try to delete the same filters individually. If the filter is
not found in the driver's list and num_cloud_filters is already zero,
return 0 instead of -EINVAL to avoid confusing upper layers that
believe the filter is still offloaded in hardware.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2 -> v3: Resend the reviewed TC fix in a focused two-patch series.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 09b7f51..81d7082 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4214,7 +4214,8 @@ static int iavf_delete_clsflower(struct iavf_adapter *adapter,
 	if (filter) {
 		filter->del = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
-	} else {
+	} else if (adapter->num_cloud_filters) {
+		/* other filters still tracked, so this one is a genuine miss */
 		err = -EINVAL;
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
-- 
2.52.0

