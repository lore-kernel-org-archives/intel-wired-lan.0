Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C366FF8868
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 09:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E8BA411D6;
	Tue, 28 Apr 2026 09:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rb6aoRnezWR; Tue, 28 Apr 2026 09:26:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 667AC411D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777368399;
	bh=hjK2G7LPiw+kvxLQtLAeEl7+956uNxj39I/8SWahJxw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O84vdL72pODdZg+KC3Fvx5iCmgjczyTPC/UdfW+Q6THK4mn+zehuQEOExj3q38pIw
	 mmUeiDnzPOfAp+++urcDoNuUo3Xfv5xB0Slt9aUA/UsCfpC7W1JlADDVOQ3qiDVjWn
	 MlvlxNwAeWxjso/C9dF9QHIZFdoJERTA7Q9YGxUJ/emMoTP/kJ3LC5VGOKUcK0mpZW
	 V7/e47hry32O05CxhHQV36iD34oZaLgrXzJLc1gSag5ht4vtOnp1SI+glsJLkvnjdJ
	 vjNVHfBqFFZGie1QAVSDqlCq0lmgcjwV/VgLBHgVVT0mT40chtA+20F5y5xi5STsoL
	 5JJHtJvCVMT4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 667AC411D4;
	Tue, 28 Apr 2026 09:26:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A26AF23D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 939EE838B2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fui_0KMLq4bB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 09:26:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A7A87838AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7A87838AB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7A87838AB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 09:26:35 +0000 (UTC)
X-CSE-ConnectionGUID: wY/IDiPSQnOdmdGHZUS0qQ==
X-CSE-MsgGUID: l7Bggz5WQ7GNv16S4HGKfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103731749"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="103731749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 02:26:35 -0700
X-CSE-ConnectionGUID: Wzke/4szQrev/j5M+PO4pg==
X-CSE-MsgGUID: mK2Ni828QX2LTMAvEA+HGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="237861386"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa003.jf.intel.com with ESMTP; 28 Apr 2026 02:26:32 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id B5BEE2816F;
 Tue, 28 Apr 2026 10:26:29 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 28 Apr 2026 11:09:10 +0200
Message-Id: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777368397; x=1808904397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NPBLQJqucg7/CxKX3h1LojM1m977hcBM54QKuG8/OJ0=;
 b=cxoyRqxmreq9QbxtI4wZftjPuxQVhGcDsf9wlZUQWsawb2EKiAUb2aSS
 9YDOiNa/Vu77KRxeoO64qkUsWnahHV0JMLpC5xaworR0MG+2N46CJLt4Y
 3iuRWKMEM49ZSO+djxwD4nHZP7II7yEIfw6ul58QAumkmHK7IyB5MVEjz
 6tKX22tpSN6bEIo/42m9c/jCUgHGpseDrEw2arSZgbC7gRXIDKWyK1O6v
 IAML0+sfibUu+CK7WVKw1dlq+KKQUL8M1AbnNawp5pVS5gL9K3xI1F8Lc
 xTE7DQzbjNlMO/L5dVb2Uq0v/sDUKx26YVsefv85+NKTkBUIUFic7gntE
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cxoyRqxm
Subject: [Intel-wired-lan] [PATCH net-next 0/2] devlink, ice,
 mlx5: add init/fini ops for shared devlink for ice to use
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

Extend devlink by two callbacks used by shared devlink.
Callbacks provide option for the driver to have constructor/destructor
for the priv data attached to the shared devlink instance.

Use the callbacks from ice.
mlx5 is just touched to have additional param passed.

Non-null additional param for the constructor will be used by separate series.

Przemek Kitszel (2):
  devlink, mlx5: add init/fini ops for shared devlink
  ice: use shared devlink to store ice_adapters instead of custom xarray

 drivers/net/ethernet/intel/ice/ice_adapter.h  | 13 +--
 include/net/devlink.h                         | 26 +++++
 .../net/ethernet/intel/ice/devlink/devlink.c  |  3 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 95 ++++++-------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
 net/devlink/sh_dev.c                          | 39 +++++++-
 7 files changed, 106 insertions(+), 76 deletions(-)

-- 
2.39.3

