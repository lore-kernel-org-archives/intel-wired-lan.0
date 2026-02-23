Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EA6E98E14
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 10:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5767F8425D;
	Mon, 23 Feb 2026 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4WevagbokNe; Mon, 23 Feb 2026 10:22:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D263D8425E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771842167;
	bh=ACzDr1fBVuDc62fKILKnXGZd0hs5YxjbimFCsf3xR20=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=9oy9dQYxmAItiitn2mmE3rXch+zf4Sb3jR5TVKtHRMTgzwlCwfH220l3GanOQoyeR
	 fyQzFb9IIKiUscgQPsJM67jbwDyKHBz4aPElrfvYAwYHOI6WWxZ+5xJVnYBmKC5j+O
	 U3Evjzg3yDtOlF4UGvK4y2nsXhw97gYSITk8R2aRyToLV0+g1cfmE1VojS1W3SqIIl
	 EgIADntUNFBeBmppwFNUgL3I/Ay08Mru2ptMYVl7DcL80TtxknCH48cY87fQfzGkU3
	 ee8qL4SyonvKNtu6rT9RLX/8cXQRWGWg2VK1Mv7fzMriK5hxYXs8vaGN2B9zxZ4+mA
	 v6biV1JBY3myw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D263D8425E;
	Mon, 23 Feb 2026 10:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CCEA0237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 10:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B294B40A97
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 10:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OoqqEf4VEaZh for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 10:22:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 365854053A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 365854053A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 365854053A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 10:22:44 +0000 (UTC)
X-CSE-ConnectionGUID: HUXA7jcxTI+SXwSMXjqqug==
X-CSE-MsgGUID: qT4B6C0kT2a8XJnayHJwsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444677"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="76444677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 02:22:43 -0800
X-CSE-ConnectionGUID: qmw+eeu8QJua+8CK3WWvOA==
X-CSE-MsgGUID: BvMecX+9SnqhBlLI/WU4vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="246121703"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:40 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 5761628160;
 Mon, 23 Feb 2026 10:22:37 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Natalia Wochtman <natalia.wochtman@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 23 Feb 2026 10:52:07 +0100
Message-ID: <20260223095222.3205363-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771842165; x=1803378165;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=l+MBHZeoAJKuGomA3vp4AjGUwAnaEYYc7K+R5iWjZRo=;
 b=HYrdqxS3Cmh2Si5BHnF7bUbGOQaR1DYhIptdc+0GUlr2lhPVfzVGUn/+
 gEeu6fAN0Pm7y4YaOb9NA9KVRolhg9PVGr1gNmOEwzrrs76Visk1k/T+f
 ptzNovGLYfJVuzpXCUg9AijZ2udAR4mssfrOByxTRbbMpyyxnTBvJ3ihP
 3sW3JxU5ypbqiLxhhMeLciykfWX2wMXZd1hDfzM6CosbNeY0+afMZjTbe
 b0Iy1KAflLuWV36usVW0jqf/k2zxFo0MUgcCCai/Io1snTbkoubSEOcEt
 tnmlVdO7UJtpwcMgX+gVlBRE0Y0jfAcerialONJ+ADfx88jgVfvPl/5VO
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HYrdqxS3
Subject: [Intel-wired-lan] [PATCH iwl-next 00/10] libeth and full XDP for
 ixgbevf
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

Update ixgbevf with standard XDP features by utilizing libeth library.

First, in patches 1-4 refactor existing general and XDP Rx code
to use libeth fill queues. Then in patches 5-7, add support for
XDP multi-buffer and XDP_REDIRECT (target and source). Patch 8 addresses
particularities of one HW type by using a software header split.
Patches 9-10 address page pool not being reconfigured on MTU change.

Larysa Zaremba (9):
  ixgbevf: remove legacy Rx
  ixgbevf: do not share pages between packets
  ixgbevf: use libeth in Rx processing
  ixgbevf: branch prediction and cleanup
  ixgbevf: support XDP multi-buffer on Rx path
  ixgbevf: XDP_TX in multi-buffer through libeth
  ixgbevf: support XDP_REDIRECT and .ndo_xdp_xmit
  ixgbevf: reconfigure page pool when reallocating buffers
  ixgbevf: allow changing MTU when XDP program is attached

Natalia Wochtman (1):
  ixgbevf: add pseudo header split

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h  |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   48 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   96 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1104 +++++++----------
 include/net/libeth/xdp.h                      |    2 +-
 6 files changed, 486 insertions(+), 767 deletions(-)

-- 
2.52.0

