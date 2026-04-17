Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE682F436B4
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 14:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59C338150F;
	Fri, 17 Apr 2026 14:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a8IXNABNAzkN; Fri, 17 Apr 2026 14:59:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC29A8150C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776437968;
	bh=9Ttb12HYWY7Ea82iFBVHynj+VUTRAVF7RCJbsh2p51M=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=VCao8fvaKBZ50Q3zuSh50yNzQcIruYLbj2yggSTcogWT1HxOBH57QReItMFC+4cXu
	 jI3uhfB9NeJNYipAPe0Y2+evCsKD4/st97bCihex+jO0XgqMhmIMiPhqRe/qPiD/Wy
	 DKdy4aVlz8axhQnrsICbjsylNyyQG0vUjO5jsCPiHkFsEXWeO22TlKjaL6VyAHnRIu
	 CfYrF6HbBFUSDEd4mBwt/5Jh5oYR9CHa6VhFOyEKZJ2bdBZvzS5GR86OFmkpRkuDQr
	 Rh2Okb8FSv1umxIdl4UuQ3iOQiY2X/rXtkRfydKWxgZL8Uja7m4432OTwNCBPykW8k
	 1l0bp0KeIVhTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC29A8150C;
	Fri, 17 Apr 2026 14:59:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BB65270
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 596C4405E9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gAKfzhVwRmT6 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 14:59:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5284940518
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5284940518
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5284940518
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:59:24 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-8Tn1GChdNhGF9RphoU8yiA-1; Fri,
 17 Apr 2026 10:59:20 -0400
X-MC-Unique: 8Tn1GChdNhGF9RphoU8yiA-1
X-Mimecast-MFC-AGG-ID: 8Tn1GChdNhGF9RphoU8yiA_1776437957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51AB8195607B; Fri, 17 Apr 2026 14:59:17 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FD9930001BE; Fri, 17 Apr 2026 14:59:10 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 17 Apr 2026 16:59:04 +0200
Message-ID: <20260417145907.696307-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: yrmDQF3hNVwSc92P5JtfavAiWZvdeLHTBE3IYNxlJRs_1776437957
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776437963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Ttb12HYWY7Ea82iFBVHynj+VUTRAVF7RCJbsh2p51M=;
 b=HEXKRk5j5qAOx6o5DZ9QYOWMT7pYMgB7akyhtP4hJZDsPIsRc7deXIsEqeT8LWhRSxSiJ+
 QSO2IWmh7ggfA1muc6iabfar59OYVgXFHxm0iCS5aDoPz6N8DKLV/bvI4jThra6wOEkyeF
 flPCQVUp30l51zzgnZ55cc4Lc2gYOQU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HEXKRk5j
Subject: [Intel-wired-lan] [PATCH iwl-net v7 0/3] ice: fix missing dpll
 notifications for SW pins
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
Cc: Ivan Vecera <ivecera@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
 Rinitha S <sx.rinitha@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The SMA/U.FL pin redesign never propagated dpll notifications to the
software-controlled pin wrappers.  This series fixes that in two steps
plus a prerequisite dpll core change.

Patch 1 exports __dpll_pin_change_ntf() so ice can send peer
notifications from callback context where dpll_lock is already held.

Patch 2 fixes HW-to-SW notification propagation: periodic work now
notifies SW wrappers when their backing CGU input changes, and
phase_offset reporting for SW pins reads the backing pin's value.

Patch 3 adds SW-to-SW peer notification: when SMA or U.FL pin state
changes via PCA9575 routing, the paired pin gets a dpll change event.

Ivan Vecera (1):
  dpll: export __dpll_pin_change_ntf() for use under dpll_lock

Petr Oros (2):
  ice: fix missing dpll notifications for SW pins
  ice: add dpll peer notification for paired SMA and U.FL pins

 drivers/dpll/dpll_netlink.c               | 10 +++
 drivers/dpll/dpll_netlink.h               |  2 -
 drivers/net/ethernet/intel/ice/ice_dpll.c | 79 +++++++++++++++++++----
 include/linux/dpll.h                      |  1 +
 4 files changed, 79 insertions(+), 13 deletions(-)

---
v7:
 - split ice patch into two: HW-to-SW notification propagation and
   SW-to-SW peer notification (requested by Jiri Pirko)
 - drop spurious blank line removal in ice_dpll_sma_direction_set()
v6: https://lore.kernel.org/all/20260416113952.389405-1-poros@redhat.com/
v5: https://lore.kernel.org/all/20260409102501.1447628-1-poros@redhat.com/
v4: https://lore.kernel.org/all/20260319205256.998876-1-poros@redhat.com/
v3: https://lore.kernel.org/all/20260220140700.2910174-1-poros@redhat.com/
v2: https://lore.kernel.org/all/20260219131500.2271897-1-poros@redhat.com/
v1: https://lore.kernel.org/all/20260218211414.1411163-1-poros@redhat.com/

