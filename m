Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570F0C25B75
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 May 2024 11:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F223A40512;
	Wed, 29 May 2024 11:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5yDp-w75y9n; Wed, 29 May 2024 11:23:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5247B4057C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716981825;
	bh=kSi0QxDLejAjyHHxUmmZUOSRYdRxvU0b41YjqGiKyYo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=k80d6jGACVaxj6TNyKzVg12jFcQZ3WL0PzRKDtPwe4t3iFVqTuHvLZAbAodcS0Nen
	 sYi6p7YQISP3jfqsP/2ZyUS0he/V+47lNaRDku/pkResryz64kmKbRbXwFrD5vyGsp
	 BdpqYhSc7sDotel0HKAlG4VucaHG1zaowZ7S1oM7gpCieiTlY1PT0vMsoaQH8dMrDH
	 P6LWUDS9sWIU/6apADfzouQbBJ/+r38olpOWTwD25d6EiWbQIeYgRyEQuCBGX9ezlc
	 KAzMSnN0HSyP5GzPil7rgJUy4DllnSDGK8suIzlRqv+aXmWgFY9e1wrLWI0MIfzGV8
	 HU33W0Alge6xw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5247B4057C;
	Wed, 29 May 2024 11:23:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 0B7261D3494
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 May 2024 11:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAAF360643
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 May 2024 11:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b6c47xrYcfjJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 May 2024 11:23:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1CF04605CD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CF04605CD
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CF04605CD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 May 2024 11:23:42 +0000 (UTC)
X-CSE-ConnectionGUID: BxqtnVJlTjS0xnM21r0vlQ==
X-CSE-MsgGUID: kC16DSIIRpakYBD1P+/6DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169217"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="17169217"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 04:23:42 -0700
X-CSE-ConnectionGUID: qI70jKXrR6qCqNQ1YN7fvA==
X-CSE-MsgGUID: M8dMU7+VR0Gb5TBr7Tp0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; d="scan'208";a="66277164"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 29 May 2024 13:23:29 +0200
Message-Id: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716981823; x=1748517823;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FWMUQoO5gUNSL6Hs4/uH+Ck45jDQp1IuueH/k+fPzXM=;
 b=P6heEzDv/uL8CvlcpGPissWPByFWGJeRCp6eZaVFkGFqlkRhL23Dtrmb
 pXBOtTTo3H1HZOqkMd8tiU/TTW8i2UtOdc8CY3Zj6ZqIt0CtapJkD0UBM
 rhDZvrN5purC8xVyIUVyAvI6QXcYy0bWuG+S1Nb6D9nq60qQBO6ti3Uut
 hwx61WpVLJfN9p88PJTZUqa+4nzxSBAo4WMdIyMmBwmlENNXJ9RKso5/R
 iAIYP7nB7sJyuCj/wKvthkZq8Ns9IwU9k4f1rLkiiePU/EmbbpxE0Kk/1
 zUtadyeG7B8qO7ki5V66UlQkwrZ3Jclrs1PJLLN9OOpPCI3BiCq39/1gQ
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P6heEzDv
Subject: [Intel-wired-lan] [PATCH v2 iwl-net 0/8] ice: fix AF_XDP ZC timeout
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

These patches combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.

Thanks,
Maciej

v1->v2:
- fix kdoc issues in patch 6 and 8
- drop Larysa's patches for now


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

 drivers/net/ethernet/intel/ice/ice.h      |   6 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 150 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 6 files changed, 101 insertions(+), 71 deletions(-)

-- 
2.34.1

