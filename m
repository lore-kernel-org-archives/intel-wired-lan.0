Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBD5C02194
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Feb 2025 12:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE5664017E;
	Tue,  4 Feb 2025 12:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uu6tM3ywY_3y; Tue,  4 Feb 2025 12:05:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF56840947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1738670747;
	bh=nAkyHHvvNVUqn1sFLI2NcYQNrFVKXd9OUKm3exT/wrQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bV9KUIDK2xWp8G4bKP+/T5xgFtxj2gVhbk/bZhulFYT021IyghAoUTF1Ft1FSmv3T
	 o8stNG/VvikbMz7epDBj6skkdgKYVH5q5chzl0p4C2N2lc37GVEUuL+ratsAcM35rX
	 hrMTBcViSD7pA2jkgt7lzBogI7HROSX1leDVHMT4DaObNL4nr7aE6gEJfJbMHS8Ilh
	 hZ/3osE0eCXJv6jaWmrVG8xXjvf3eELH+xhlGyWoTiLMschIl+6wp3wU1EbOT+8RsK
	 15uENGSDdETsIyICAfRQJoQUjQ3AkzF3NaA80jlwpHL21i0MT433FzdPC5GTVI5Mut
	 bthLlAd1jBHyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF56840947;
	Tue,  4 Feb 2025 12:05:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 443CE185
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Feb 2025 12:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2647C607BD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Feb 2025 12:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4O_UTasyJDll for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Feb 2025 12:05:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 40BC86078D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40BC86078D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40BC86078D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Feb 2025 12:05:45 +0000 (UTC)
X-CSE-ConnectionGUID: AJXey3/+TEK5KrIOk29OhQ==
X-CSE-MsgGUID: VRS4KkbbRIqVI7M4fitT9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="38424786"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="38424786"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 04:05:44 -0800
X-CSE-ConnectionGUID: 9Xc4lbrtTCKZ/HZJSQpMnQ==
X-CSE-MsgGUID: v+LQwvfBRMO6e7lCadO8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="147783203"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa001.jf.intel.com with ESMTP; 04 Feb 2025 04:05:41 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 22A3932CA9;
 Tue,  4 Feb 2025 12:05:40 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Date: Tue,  4 Feb 2025 12:50:50 +0100
Message-ID: <20250204115111.1652453-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738670745; x=1770206745;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xi4sBUQvDSLZfwfFDQG/hOsrvWDhJfv7KlrwKAUi3XA=;
 b=fkKc9eVUEoAwBbobLXUMESW4Vk1NUijT855Lbl4knWoKDW7K6BkOc+/Z
 i0f3iRZTEowko7ibXTxbP+4HkWjzMatOFMcHcmwksth8ou+K5hSnmKi0A
 D/IJxuSrYD1g8hACi2/g2TbRbi48J/usWVZ3Y5dDj7QpesVzm9sJKVFZG
 cvFKCFO63Gbh1+kSPR5NL7a5OYauYD7oLmbPzRqj0JjVqe1FmXwy3hMZc
 7IWkXN2myI0uNQKTIfgA0V5C2J1ZEIz1T+jtSxF6Q/Mwe/4V/ke5yFoxW
 XIvTbyduQc0/bJ0CmatvkWrXYYql+VJ6LLMmb4fG+cM7fIQOnqRNM/GEQ
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fkKc9eVU
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/6] ice: LLDP support for VFs
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

Allow to:
* receive LLDP packets on a VF in legacy mode
* receive LLDP packets on a VF in switchdev mode
* transmit LLDP from a VF in switchdev mode

Many VSIs can receive LLDP packets, but only one VSI
per port can transmit LLDP, therefore LLDP TX from VF
requires adding an egress drop rule to the PF, this is
implemented in these series too.

There are no patches that explicitly address LLDP RX in
switchdev mode, because it just works after adding support
in legacy mode.

Usage

To receive LLDP packets on VF in legacy mode:
On host:
ip link set dev <pf_ifname> vf <n> trust on
On VM:
service lldpd restart

To receive LLDP packets on VF in switchdev mode (host config):
tc qdisc add dev <pf_ifname> clsact
tc filter add dev <pf_ifname> protocol lldp ingress \\
   flower skip_sw action mirred egress mirror dev <repr_ifname>

To transmit LLDP packets from VF (host config):
tc qdisc add dev <pf_ifname> clsact
tc qdisc add dev <repr_ifname> clsact
tc filter add dev <pf_ifname> egress protocol lldp \\
   flower skip_sw action drop
tc filter add dev <repr_ifname> ingress protocol lldp \\
   flower skip_sw action mirred egress redirect dev <pf_ifname>

For all abovementioned functionalities to work, private flag
fw-lldp-agent must be off.

v1->v2:
* get rid of sysfs control
* require switchdev for VF LLDP Tx
* in legacy mode, for VF LLDP Rx rely on configured MAC addresses

Larysa Zaremba (4):
  ice: do not add LLDP-specific filter if not necessary
  ice: remove headers argument from ice_tc_count_lkups
  ice: support egress drop rules on PF
  ice: enable LLDP TX for VFs through tc

Mateusz Pacuszka (2):
  ice: fix check for existing switch rule
  ice: receive LLDP on trusted VFs

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  71 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  56 +++-
 drivers/net/ethernet/intel/ice/ice_repr.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 243 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  17 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  26 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  48 +++-
 18 files changed, 449 insertions(+), 73 deletions(-)

-- 
2.43.0

