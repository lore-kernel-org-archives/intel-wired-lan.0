Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5340AE6BF2A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Jan 2026 16:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB18340DB5;
	Fri, 30 Jan 2026 16:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ct-gdXgWmweH; Fri, 30 Jan 2026 16:53:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A46D40DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769792039;
	bh=6tC1wi5dMVORuOYEgaYlYA0EwXoXG5oInK0fxZdxC9E=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NIc2UpkoM0lUT/iqVw1cdFBnMs86uFDYTUNpp14Sd6oWlms409jru3l6/fEcb9qq+
	 JgXj9461XtkzkqchkLKUjovwejyxc9vu+zHGCJsCSc66wPVLrea2XW4fwbGppPHd7w
	 jGmEHaSPPWSK37vXkT23NP9B8IaVUKMY8a1aej1d/PwyfsYHzjh/6sP5dTPJdcgrKL
	 gS0ox/0Fw8eYgLnQvqj33YUBB6aYyHq3iTouAGIxIcMHOfGywGHr+Irvx94PrnZAqh
	 eBbakOhL3UULrQ05Uo9QtLFnwt2U5dqmwS0zXrzlHq9aE7DXfLcj3me8rcxGJnTdlF
	 uq6G34JID/vgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A46D40DB3;
	Fri, 30 Jan 2026 16:53:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A1886195
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Jan 2026 16:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F51A40DB3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Jan 2026 16:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tf-yJzXWeFlN for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Jan 2026 16:53:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6C7E640D31
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C7E640D31
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C7E640D31
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Jan 2026 16:53:56 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-a-Kvt5eXNMOR5kXebgYFVA-1; Fri,
 30 Jan 2026 11:53:49 -0500
X-MC-Unique: a-Kvt5eXNMOR5kXebgYFVA-1
X-Mimecast-MFC-AGG-ID: a-Kvt5eXNMOR5kXebgYFVA_1769792027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9174719560A5; Fri, 30 Jan 2026 16:53:46 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E4871800109; Fri, 30 Jan 2026 16:53:39 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 30 Jan 2026 17:53:29 +0100
Message-ID: <20260130165338.101860-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1769792035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6tC1wi5dMVORuOYEgaYlYA0EwXoXG5oInK0fxZdxC9E=;
 b=RPCVTsCy/qyR7uAOQw4tpds8TvwyMq2mAZ1QcNN5ytWoeV2SOxTN7NUbRVRfnzR2cH9xkU
 KbPpuzJfn5SfhEEE6D2//chORwbwBIVmppPsPoWPjXMAiEwOlcEfcMBciVgHEY34XEEIgA
 FAKIdYcco80kfH1+dCQpc0ZSissL9es=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=RPCVTsCy
Subject: [Intel-wired-lan] [PATCH net-next v3 0/9] dpll: Core improvements
 and ice E825-C SyncE support
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

This series introduces Synchronous Ethernet (SyncE) support for the Intel
E825-C Ethernet controller. Unlike previous generations where DPLL
connections were implicitly assumed, the E825-C architecture relies
on the platform firmware (ACPI) to describe the physical connections
between the Ethernet controller and external DPLLs (such as the ZL3073x).

To accommodate this, the series extends the DPLL subsystem to support
firmware node (fwnode) associations, asynchronous discovery via notifiers,
and dynamic pin management. Additionally, a significant refactor of
the DPLL reference counting logic is included to ensure robustness and
debuggability.

DPLL Core Extensions:
* Firmware Node Association: Pins can now be associated with a struct
  fwnode_handle after allocation via dpll_pin_fwnode_set(). This allows
  drivers to link pin objects with their corresponding DT/ACPI nodes.
* Asynchronous Notifiers: A raw notifier chain is added to the DPLL core.
  This allows the Ethernet driver to subscribe to events and react when
  the platform DPLL driver registers the parent pins, resolving probe
  ordering dependencies.
* Dynamic Indexing: Drivers can now request DPLL_PIN_IDX_UNSPEC to have
  the core automatically allocate a unique pin index.

Reference Counting & Debugging:
* Refactor: The reference counting logic in the core is consolidated.
  Internal list management helpers now automatically handle hold/put
  operations, removing fragile open-coded logic in the registration paths.
* Reference Tracking: A new Kconfig option DPLL_REFCNT_TRACKER is added.
  This allows developers to instrument and debug reference leaks by
  recording stack traces for every get/put operation.

Driver Updates:
* zl3073x: Updated to associate pins with fwnode handles using the new
  setter and support the 'mux' pin type.
* ice: Implements the E825-C specific hardware configuration for SyncE
  (CGU registers). It utilizes the new notifier and fwnode APIs to
  dynamically discover and attach to the platform DPLLs.

Patch Summary:
Patch 1: DPLL Core (fwnode association).
Patch 2: Driver zl3073x (Set fwnode).
Patch 3-4: DPLL Core (Notifiers and dynamic IDs).
Patch 5: Driver zl3073x (Mux type).
Patch 6: DPLL Core (Refcount refactor).
Patch 7-8: Refcount tracking infrastructure and driver updates.
Patch 9: Driver ice (E825-C SyncE logic).

Changes in v3:
* Dropped patches 1, 3 & 9
* Other v3 changes mentioned in individual patches

Arkadiusz Kubalewski (1):
  ice: dpll: Support E825-C SyncE and dynamic pin discovery

Ivan Vecera (7):
  dpll: Allow associating dpll pin with a firmware node
  dpll: zl3073x: Associate pin with fwnode handle
  dpll: Support dynamic pin index allocation
  dpll: zl3073x: Add support for mux pin type
  dpll: Enhance and consolidate reference counting logic
  dpll: Add reference count tracking support
  drivers: Add support for DPLL reference count tracking

Petr Oros (1):
  dpll: Add notifier chain for dpll events

 drivers/dpll/Kconfig                          |  15 +
 drivers/dpll/dpll_core.c                      | 288 ++++++-
 drivers/dpll/dpll_core.h                      |  11 +
 drivers/dpll/dpll_netlink.c                   |   6 +
 drivers/dpll/zl3073x/dpll.c                   |  15 +-
 drivers/dpll/zl3073x/dpll.h                   |   2 +
 drivers/dpll/zl3073x/prop.c                   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 755 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  30 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  32 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 217 +++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  16 +-
 drivers/ptp/ptp_ocp.c                         |  18 +-
 include/linux/dpll.h                          |  59 +-
 18 files changed, 1347 insertions(+), 150 deletions(-)

-- 
2.52.0

