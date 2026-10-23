Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA960A2604
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vuxmCkC5;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ii2tm5/2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A30E160660;
	Fri, 23 Oct 2026 07:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqHPD-xTx9lM; Fri, 23 Oct 2026 07:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB8FE6064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739021;
	b=syvnLL0b9MoJFntGMLLiireFJIPj12yFvDLZmjIlakqTAKvD8rCz8vuRNcWtQz8hbTVg
	 i6SbRyWX7nUKJsP58Yjm/ACzaL9OmaP6evv9uQQvxjVKriZS373HHgDH7uaRTD+vqt7kk
	 5NMykUG810I8vRsHo08vZ+jaofrmD0KgQNpoqT7/gi/mlsmReEGlNMd719MDShpFx/i3V
	 5OLXegvEl1sTmLptoIJSlEuJb795SVaA6bm4ev9n8ljSRSnAapCJvtZKHzAe6OhuKI/oR
	 S05EBNmqU72dIZEMXOkMoqFGyt8kI9vrin3z2ImmuBXYjWMSoo7pMfI1PEsn/CRLnSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=75R9zmnE1BoYKXTA7IKrCfrOxlvJnACSHeuJYN46sWk=;
	b=PI6UmDolcyRUJuYWl3ttWErtBHbp3dgTKrH8BpnjcnYkjCgtVIMwqY95coeZTkCE2sLC
	 Z19AfRhFoHQGwfGp2vDHfQbn93B8omTcCUy2FpFfdvznxWOMo9KqETNePyLQ/FTml/l/H
	 +CntMV7txK44Obpdanwc9zMTFtiWChWKi4MLGXpe5rM7fU7mu887/tUWFQTqJzAglS9uQ
	 YygaPrLK0yXUqmoI89pU7bvwzuUk/BtM85hYvXFTtlM3dzlvJO6U/miHmCQmXr9NxmFhx
	 qYvXZ0n1Tv5kko+lQO7P5xZyKBX+ZdKA8dWUmXUjz/pxqjsJsOJAv92HTayORVil0IQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792739021;
	bh=75R9zmnE1BoYKXTA7IKrCfrOxlvJnACSHeuJYN46sWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuxmCkC5chPDQLKprTWjdEWy4SiEKbcbjo305G9TLbNAXm3JUn19NyFbtioHM/oat
	 +D8x0eGD8WNx007uz/ySLTPzyCseKju37e7/IBcs2SOigg19/met0tZ5pR9bLPWN3o
	 sd+sP39OjgZXgEV/Myj8MxNjBXZYgLQPL/jvPC3OR8vAwc11CFLO1hFpuOCcy4lpRs
	 HSrkY/JrZQ1cb+FF0GW/+nfICcWA/f+yQ9JX8AoM8CNMPoawrb1SNVbcuyHtOKqs22
	 nwLHpEM7TVjsOsnv2PFPn3MD5lHb2KM5jzjiSq6QaVTgyQ8p0IlFPzqMVio0Lyg7/B
	 /iKQEZqoCBZLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB8FE6064F;
	Fri, 23 Oct 2026 07:03:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CADF3C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 630A7400D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Fn_6jAZSXnq for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 07:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 79FBB400AD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739019;
 b=BdND/+RIjYErXP9WnocgM1lEFpGxE8MaLTVQQ8UnkS/JxxmkPBQp14PUma3PsGoMV87w
 1kJwGz5gLGNckpPL3BkV4KU9nLwiJphO1WoHnhJ0fKQrmAIyeuxwV+bIx/dTi9U5R9CSX
 AxZ0hP1VHKXCkPgQHuhYHDB0fwuh0Nyxjjg5UjE0JnS5PgOel6JXtmHOKhQiWZJb8qz5K
 3ju8XRozzlBRvEEbu3ycg79H2Xybgaz9WCsPxrIm9iVoWsuq444X+ZMMOWspcoUq+8haC
 oto/kkZECoc74Bu7qhKHSK/J9GXZ72uRq8eUEkKJyA5mVh1MjRjROu6sx7AjEDJm9og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739019;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=75R9zmnE1BoYKXTA7IKrCfrOxlvJnACSHeuJYN46sWk=;
 b=CyTEd5WdRuXwcplpdpkVDsU5mJ0dZqtaBFrGPnOlfKQjWaoXwHSmqfme7Z+TAGL2yr6n
 xj/VdbSn/PBjnOU/n9HZWT6MlTtLpEpBzEFXZCsH5OZffY0X+uWviT4F3Kp5Fx4PPUGHM
 5WCxcipr7iojG6Y8LSi3wLkdBMvyM7k6Axgj1MIGLL85w8KIiPI5YjJMOguQdffNqbih+
 8k9+4gZ414MdVXoRJ+E5MIjnd92ookH3VXvYnobUhdAhyeAz+0OldwIRb6+TBPJReuNyl
 COC4idqkUwU0ZfKKmnRC1+AvRiEFTir3r9NVwnQR6h1sZVmTs4VlWg/KZCMw93As2AA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Ii2tm5/2"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ii2tm5/2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79FBB400AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75R9zmnE1BoYKXTA7IKrCfrOxlvJnACSHeuJYN46sWk=;
 b=Ii2tm5/2FY/3MdfhpFE8/NhSZASid4nejB4gg0zlwszqZrqpYn37yRGvZONt67G2h3e0I7
 0Y6uZFR9YOG1KIfXw1DQ3hJmhuVe8SX1WdalB6hUoMgeNOiBSeHfYK0jImSj6NlcISrDgh
 k2cyMgOPF9zE8oxItuMpWU31Za2QlRo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-p1kmpOMoPIuDWuYvxLby-g-1; Fri,
 23 Oct 2026 03:03:33 -0400
X-MC-Unique: p1kmpOMoPIuDWuYvxLby-g-1
X-Mimecast-MFC-AGG-ID: p1kmpOMoPIuDWuYvxLby-g_1792739011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 627291800624; Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA9331800347; Fri, 23 Oct 2026 07:03:25 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
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
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net v2 4/5] ice: do not block on the aux device lock in
 ethtool set_channels
Date: Fri, 23 Oct 2026 09:02:56 +0200
Message-ID: <20261023070258.730168-5-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 55c1upyEl5JFBsmAfx-xicdhmx7yvCWpXBTBoY224M8_1792739011
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
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
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- rebased on the new patches 1 and 2, the trylock now sits inside the
  pointer test done under adev_mutex

v1: https://lore.kernel.org/all/20261019065301.3983537-3-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 5482a64c81c95a..dbc662d6233957 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3947,7 +3947,11 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
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

