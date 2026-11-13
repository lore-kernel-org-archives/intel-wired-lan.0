Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027E606A337
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=r8tcw/sq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nh+P8oDc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2FBC60653;
	Fri, 13 Nov 2026 16:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCB8broabjAS; Fri, 13 Nov 2026 16:15:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2769360664
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794586533;
	b=oAPGq5yErKRQDlVA8VJmraG/u3rRSd0vvcD0I16FRejLP1ymj82l3/Ur56EFmpg/9hjr
	 36I0jW7tpjpqM6W87jrSfCQk1gnLz0LQ0lNySg0we+2QYehdHiiuP5W+6O3OzjoLAikHP
	 CCWR0rtws9H6cUblQcTD/fMQ5hA3ygl2g8G/wQ7utB9erODVTTKdllvXOJ31dt3gn+4r6
	 39dd8bgRIXUUHZnAZzLFB30nBo2MZc5wK/qYviLdl7hQL40w1JoIsdx9ngcYIGQEkuckZ
	 bkDW2ywfQMJYTyCHlG2aMNunvHX0U2y18d0k/+3cQAELvsfnY04kWEOCkcD9TYSr7Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794586533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y+T2PsDWbFegQvLd1qPwlD8afn5/qQNlDfN35WPaamo=;
	b=ak76S9t3l1LQVVpX7zlsOkleFf/bWEXGPZO965IM8+t/elI25WVm/o13demG8ctgtI7K
	 Rk5+zoy7QcO6i/diC6pJfW4M1w2zZq9rAn5+Y6AyAW4KM3RoA/UQFd8Lx9XZH/Tj7qGpr
	 0izR0ocjwuiPf5pywtN1B7ZKJs2wMaoqNai3zPJYg86w1tn0krRJcx6I+kCdb2GCCligr
	 cHHzAmG6Ly6Uycd/hw/XwdK0CjZME5EGGZTujuAb4DLq+VntzxxO3+BSrk195kZRQ1Qm2
	 NP8z+ru/Bl3iUikke0G90scCVbCf9MU4Jh8RWr6ChpgWx7hDeY3iISw1LHZVoztZjJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nh+P8oDc;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794586533;
	bh=Y+T2PsDWbFegQvLd1qPwlD8afn5/qQNlDfN35WPaamo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8tcw/sqHr4/c+KDUsZRf6Gn0bh2HBBo6l2RxXzfOArjHLlsGsGQimZlqGs3YgWVs
	 6RX0O03mLZl0EMyS88KRdLHMwbQ+VoffMhDdj3choWd+R4DM8g6Ras23I+JQIFZNOo
	 PCe27uwLETNnrsbsrQGWCR6PXoBnREyLY6pi8fl9cqMi5/x1dhgz6w6CC2L4Ae9yzJ
	 XaBU0UKM+rORsQNx9lZkqsdfHDoi7ZgDsuFqrkv7JrgbNFPnw8Pjjcoga3BsGbis++
	 iXTIYpMKr6wwd5ocJj99g6k4n4UzVolSDVuNgzbJXKt/yK+/10xWNZtAbtamfiGwvM
	 g6OTvi7ESCoVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2769360664;
	Fri, 13 Nov 2026 16:15:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 869752FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B9A960665
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwRfqHb9cVvl for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 76F4C60653
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nh+P8oDc
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76F4C60653
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794586528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+T2PsDWbFegQvLd1qPwlD8afn5/qQNlDfN35WPaamo=;
 b=Nh+P8oDciU/CQvAvDaICQ/dIAQsS4khTA3DtZCAepTjXsm87P9HxMliN/cq4arFiu/G1+i
 9h/poypwZMfbkrdrFs2UKB7XX0QQovB4vS0YkCJFUeKdQ1qAEVyDQLnT9noVvCM+d7SGrv
 kQE6HtWeWf1T0LIE3NtWI5sI5oI4o3Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-fixCJVw4M8CmpHSiya07Rw-1; Fri,
 13 Nov 2026 11:15:25 -0500
X-MC-Unique: fixCJVw4M8CmpHSiya07Rw-1
X-Mimecast-MFC-AGG-ID: fixCJVw4M8CmpHSiya07Rw_1794586522
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AC5D1955F28; Fri, 13 Nov 2026 16:15:22 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97CD618004F5; Fri, 13 Nov 2026 16:15:16 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Petr Oros <poros@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH iwl-net v3 3/4] ice: do not block on the aux device lock in
 ethtool set_channels
Date: Fri, 13 Nov 2026 17:14:52 +0100
Message-ID: <20261113161453.1234851-4-poros@redhat.com>
In-Reply-To: <20261113161453.1234851-1-poros@redhat.com>
References: <20261113161453.1234851-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eecbWbxDZkVXDtSNlwIwWaK4Q8ykMxCCPwEJEQT0d04_1794586522
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_set_channels() takes the auxiliary device lock to test whether the
RDMA driver is bound, and ethtool ops run with the RTNL lock held. This
is the same inversion against the RDMA auxiliary probe as the one fixed
in ice_send_event_to_aux(), reached through a different caller.

Use device_trylock() and report the device as busy when it fails. The
existing diagnostic is not reused, a contended lock does not mean the
RDMA driver is bound. It is a netdev_dbg(), the condition is transient
and userspace already learns about it from -EBUSY.

Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- rebased, Reviewed-by from Aleksandr

v2: https://lore.kernel.org/all/20261023070258.730168-5-poros@redhat.com/
v1: https://lore.kernel.org/all/20261019065301.3983537-3-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 910664b35b4d35..61684812733bba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3948,7 +3948,11 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		mutex_lock(&pf->adev_mutex);
 		adev = pf->cdev_info->adev;
 		if (adev) {
-			device_lock(&adev->dev);
+			if (!device_trylock(&adev->dev)) {
+				mutex_unlock(&pf->adev_mutex);
+				netdev_dbg(dev, "RDMA auxiliary device is busy, try again\n");
+				return -EBUSY;
+			}
 			locked = true;
 			if (adev->dev.driver) {
 				netdev_err(dev, "Cannot change channels when RDMA is active\n");
-- 
2.56.0

