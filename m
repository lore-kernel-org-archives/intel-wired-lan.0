Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E34C25B7C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 May 2024 13:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AA6C82011;
	Tue, 28 May 2024 13:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJemUz7J5LBp; Tue, 28 May 2024 13:15:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C822281FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716902131;
	bh=gNqQAuc+JpE5V9gEUop9KurHTTYTeTshn1JlyjJRjfo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=U6LIh7I/OUaAVreJ2KDf2nMXNhblSBqc5OL1BTTKn6cPa8ZRUS2M0hJy0F33vdJVw
	 OBS/bbpf660jJORUzz/i6zVfJqiV1u7j/q3jf4/ihK4FPkRmwEKoHT2ju2tpnVsDTD
	 9fBF3LrE8hIpnrHvJUIk6sK+o+8Z69HYwru/2GFKxXk080nC5Lwxm+Z3vGkgBZPzso
	 3ZbY5ZVULqd4mn0aalHaARCMsSx1DcCU7n7BXionItM+b2ldebrnttXppN14+LruWZ
	 4WjvUtiAL6vRjPEcSvJlMwwQm1JFxtUh6ihAovuW5aIzFjiVLps2kCCz9+Pf2WEmhu
	 2OfCvEnUTWzlg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C822281FF7;
	Tue, 28 May 2024 13:15:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E5F551D2818
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 13:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE4EE81FDE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 13:15:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYiRVlPmUCX1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 May 2024 13:15:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1275381FD7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1275381FD7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1275381FD7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 13:15:28 +0000 (UTC)
X-CSE-ConnectionGUID: PvE8hJ+6RTSuLk5TMMYZrw==
X-CSE-MsgGUID: SqsgwYzlTBe2WDz5zyOdBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193524"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; d="scan'208";a="13193524"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 06:15:29 -0700
X-CSE-ConnectionGUID: jB5T4MqqRAOO4jlBHV4a/A==
X-CSE-MsgGUID: BN4OeRSTQ8G4vBpYNbBWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; d="scan'208";a="39891097"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:27 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 28 May 2024 15:14:18 +0200
Message-Id: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716902130; x=1748438130;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6biWVuxMhZ/tEyLZWM2lpwUSsb0yPNVnUuWvv4Y3Hoo=;
 b=S0XlCdTsxDpWlWeyVvvG99+Equ6GnVbvbZF6soSJXnAkQYJ3vafBVO6U
 MBZpzoOUG7EbSo+3rMfuIhQfsj47zQjJpMy99NTz6tp+ZZrlsQqfgJKtB
 E9MAIK0fzMvhypUUvWy117aDilhDiWSt783ESZWC1ed6mO/seuLkw8mIn
 OhCu4gCwH7cSrweMcaKkxSitKoX5urPH1QAsYP2Nsu8DGIf57WmxXwy1i
 M2Yy0MRoiMxQGkxt8zY7IXqNS0cdIIFAhNBsphIwMK7oCT47Y0if1exMT
 37H/JD0gc+Vl3ROkEsqAwvVAO0MtQqwNunUt8t8Pg8rqa7iybvQ0fkYmF
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S0XlCdTs
Subject: [Intel-wired-lan] [PATCH iwl-net 00/11] ice: fix AF_XDP ZC timeout
 and concurrency issues
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
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, larysa.zaremba@intel.com,
 netdev@vger.kernel.org, michal.kubiak@intel.com, anthony.l.nguyen@intel.com,
 magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

changes included in this patchset address an issue that customer has
been facing when AF_XDP ZC Tx sockets were used in combination with flow
control and regular Tx traffic.

After executing:
ethtool --set-priv-flags $dev link-down-on-close on
ethtool -A $dev rx on tx on

launching multiple ZC Tx sockets on $dev + pinging remote interface (so
that regular Tx traffic is present) and then going through down/up of
$dev, Tx timeout occured and then most of the time ice driver was unable
to recover from that state.

Patches 1-8 combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.

On top of that, Larysa goes further with fixing XSK pool setup issues
and race condition when Tx timeout strikes at the same time as
ndo_bpf().

Thanks,
Maciej


Larysa Zaremba (3):
  ice: move locking outside of ice_qp_ena and ice_qp_dis
  ice: lock with PF state instead of VSI state in ice_xsk_pool_setup()
  ice: protect ring configuration with a mutex

Maciej Fijalkowski (7):
  ice: don't busy wait for Rx queue disable in ice_qp_dis()
  ice: replace synchronize_rcu with synchronize_net
  ice: modify error handling when setting XSK pool in ndo_bpf
  ice: toggle netif_carrier when setting up XSK pool
  ice: improve updating ice_{t,r}x_ring::xsk_pool
  ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
  ice: xsk: fix txq interrupt mapping

Michal Kubiak (1):
  ice: respect netif readiness in AF_XDP ZC related ndo's

 drivers/net/ethernet/intel/ice/ice.h      |   8 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  |  23 +++-
 drivers/net/ethernet/intel/ice/ice_main.c |  41 +++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 154 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 7 files changed, 151 insertions(+), 89 deletions(-)

-- 
2.34.1

