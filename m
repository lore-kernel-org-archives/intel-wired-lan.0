Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FA0C0502A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Aug 2022 12:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DC1281753;
	Tue, 30 Aug 2022 12:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DC1281753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1661863102;
	bh=KBRxiYD0dbk1Qql5Olmn7WQxItA/18JZhXLWv5fombk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=op8B+GDUAIdd9U59zBnKZ/V0Rz4HlKjdjhBqQ6VAxxyC47fWqEzzlDPEhajdZizqr
	 ul7YDHbz3Cu3EPZfCfJWuczlVLq3DkTOc/ZYMi8TDjLeVacCLjPs9kWZM+iqOwrjOS
	 NJcEI3+ZdoxAdloqUj8TuoqfyH/nFS6t2kLjIcJon7bZpdsJBNKYZQfDBaB04oo1d8
	 Y0N5SMenbdS09hKQl9Kuo+6L2PfCMy/JjE67zejm65npogwnN32aoiRrp2Nu8+IdhU
	 z9pzdaEAXfgD8ICwXabFVEVt65uaOu0/iqLjdGvOL37eLOrt6dNJSlg4H/jzcSL9ZA
	 mrmwfiwIQas/Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogeJUwCkSfIS; Tue, 30 Aug 2022 12:38:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A8BD8174A;
	Tue, 30 Aug 2022 12:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A8BD8174A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 0DE781BF3E9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Aug 2022 12:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DABB860FB0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Aug 2022 12:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DABB860FB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VEJGjE6LAopz for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Aug 2022 12:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19FB060FA4
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19FB060FA4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Aug 2022 12:38:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295943118"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; d="scan'208";a="295943118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2022 05:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; d="scan'208";a="588585167"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 05:38:15 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 30 Aug 2022 14:38:01 +0200
Message-Id: <20220830123803.9361-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661863098; x=1693399098;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ar3h548rpaRpqxHgVz0lKjqIVfTKSVBgjMXjddGtLcY=;
 b=m/g0W4e6ijkphf/yfV7Vr3fwpul+moQDo3qibLGvS2/pC3OoJipHRGX9
 IL6BfEciwSwAuoyL5Yy7rr0VadH0TyQfE1rNVgkYOO8KDJ0gmW4aA2oaq
 dsEtwjaHjyII52enAA4pRY/0ooYavc+SdwaD1STBhiO/vb76iMJgjNu2r
 ZnUCq9acXaINjacYX0TEKl+wQI2J67XsXutDAkdA9UJCZIalSLu+BEH0/
 romLGE96OzsKhZXGIJFOA0hgDKHVm3cCO6VXKDmqAEjI6apkIzvp4rXaN
 Q1+i3orb0yrjfe2qHBWhGrvVOlZq3BtzGp9egV727+Xu+adU9s2Gop0er
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m/g0W4e6
Subject: [Intel-wired-lan] [PATCH intel-net 0/2] ice: xsk: ZC changes
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
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

this set consists of two fixes to issues that were either pointed out on
indirectly (John was reviewing AF_XDP selftests that were testing ice's
ZC support) mailing list or were directly reported by customers.

First patch allows user space to see done descriptor in CQ even after a
single frame being transmitted and second patch removes the need for
having HW rings sized to power of 2 number of descriptors when used
against AF_XDP.

Thanks!
Maciej

Maciej Fijalkowski (2):
  ice: xsk: change batched Tx descriptor cleaning
  ice: xsk: drop power of 2 ring size restriction for AF_XDP

 drivers/net/ethernet/intel/ice/ice_txrx.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 165 +++++++++-------------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   7 +-
 3 files changed, 72 insertions(+), 102 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
