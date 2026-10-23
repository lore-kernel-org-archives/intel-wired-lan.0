Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F231B606AC88
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Y6NZFV3b;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGQLpkuv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60FF80BCD;
	Fri, 23 Oct 2026 07:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xr6mtd4t8W0n; Fri, 23 Oct 2026 07:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1528780BFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739028;
	b=OMBtka/xycSPervCjma71gH05uv8D9JO3sGlapLU4LaXOof+XToP1XcBEYH2r3X1NxrD
	 phVj3hJsT7c1xNx9ASLNqyBKGlXhM6BnSXlI5/JLHL+LjAuUVdY7SXxJW0dY4d66oi9LU
	 JTT9gk9yePCXlk3m2xRYBqRRxtFNIz5n72w98I8/nM4XL41W/86w20XrH1kMiNHZtHKaC
	 E8Kx4oMik32BBdr32mNtoTw+tl0iu5qGCQcqV5iJoajHCqPhiC0vWPTRBan/dp3tqsAhj
	 PPAddWqGN9i43pYMWKTmF5aspCzP7OePwy5O9MKOELfyUX3GtFSzZ7I3ddd8O5Qkx7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
	b=AErvBTP5CopzYnKarb0UB52o8pqTCYtyTkOTKdoslHMYG/KPgKswT6nrDAjqHylqrqR8
	 OL6E9jbwrvin9L6i2i4/D3JlUB5DNWC4LGqvbtJCIo9mPrEf+AcYw/d0H3TqB3bHxUmHm
	 u17oYRvV50iJ/yoR7QIiAyBACzUIOhrk09BLUzJSBC/zbFW6sPZNjuQ1MiYoJVvw8SeM8
	 VF1kXXm38hivKwMWukI3bbbsE1cHKl5P3Aib/2yL0OHvVQMNqV3YkKVdXorQbdzsbAvCw
	 pQ7vSQScD7dW2BwmdZ4PTAfBmPb0Cqu2tOp9jPzOu81pWX0pKqixxHP0rq+D53CV6FA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGQLpkuv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792739028;
	bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y6NZFV3b0SRmaOitwkP/m6piu5FUNav+CJR3GvrQcTA5N/LbVEyLZVBH6LKL5+3Wr
	 RFzQcpp0gqoDHuovCRmEjoVe9RliCakdKyRh+1zpXrD+Uhnq0l+rEsVZQT3kUQ1tjA
	 61oP9AKnC0h0t9HBzXCrLqtGPfcUqkyKaoleE/nvv3dM2ZsXomOUzrbCuyw50NR5mp
	 hCkiDXKjt/obE0yYLF0RXRHG+DkAJmq6jXoA6qUog6cJhvAdEMz2rtW28zjUnmE7TR
	 7argoM+x7HQumYVUlEQrCOlIq/ecy/AtyNGQy07FcXe8/tAMPDLR+fsvEumE0ffsAz
	 HAw0K7Xq1M3OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1528780BFE;
	Fri, 23 Oct 2026 07:03:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A527449D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 970ED80AE3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywJ3Yq-fHdSn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 07:03:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2BA780A92
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739025;
 b=pvWPlFQwu4EjXEEYEm5e0QDG1XusT5HsILG+QnM/vhuMrMKQbValq9GGn2uWoV2Na8Bu
 G/dZv7oR9l2YiwIqDJKLleG4cZsZkw/BzG4bLZDsgZoVJddUQsyYQ/6R72BqAUYk4Pnd7
 +PdsMKr2Zw6rRSZtG9RiJc8oRB1x03Z3x84Ez0h3HVeFFHnPbtYBmeF17l/H8+TDx9IDS
 5UD5cc9d4rIviwXcVabbhPVGqzwkukK8ipqb8jbX5MhoU4T3ENOdce+3AQ3/tVIAy6AKa
 OckpnYcoiMjIzJm+yXlAZDwVUwdoBvN6x+NfGe4eVDzHMPgccWjKXHE/MbDgkMfzVJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739025;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
 b=W5dB/8LjcFJHWWlogdMo28D1Cj7nK8lDgJ2KfwHdJfI1cNuxCVDYo6FdxBykMSK2ZwwS
 rjUksVqJ3pBo/n30sk22igT3W3Vx5A2ri4F+hZdTEavydWRJKoW6OSptGrQUaYpde9xXJ
 k8lH59rQ450Dsxs+P8vYIPdYSg7HJge/ocbM4RmBRPZM2TZU7JKNwpDzdEKsOuF9wjCn/
 gb+xi8K6BL9Gq2xFrTlSmPiVrqmO1lFb3je+uLkZLTMOdTiQfE4wiLYMp0neY/v0A2AfD
 fqGmxMbDmgi4Cu6GOsVXGggtYFDVFAcZbm2Ozr09ZC0qQOc8PiIv7Rbz5rVpsedywKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=JGQLpkuv; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGQLpkuv
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2BA780A92
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
 b=JGQLpkuvdTQrnEl8ZlNFRI4EKmm+z2ivm1+IRqQjt8ZTDiJFLEv7XlNgFz6EG3Mw23NL+j
 b/Vc0FfYlHcwOFUnap6rVUJ46cJbgJk4ZtjNofzecSUBzN7pnsGQ1b/SxzE3d1Bi0QxKaN
 h9ZjWiQp9VlpnKxrtOTDEvuccDPWP8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-6dwtmr-BPEaaGiperbAeJA-1; Fri,
 23 Oct 2026 03:03:39 -0400
X-MC-Unique: 6dwtmr-BPEaaGiperbAeJA-1
X-Mimecast-MFC-AGG-ID: 6dwtmr-BPEaaGiperbAeJA_1792739017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1631A1956053; Fri, 23 Oct 2026 07:03:37 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4BB11800347; Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
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
Subject: [PATCH iwl-net v2 5/5] ice: do not block on the aux device lock in
 ndo_setup_tc
Date: Fri, 23 Oct 2026 09:02:57 +0200
Message-ID: <20261023070258.730168-6-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: wlaEvCmR_mRi6B6i9Q5TT3CqBw4pdhbnhKYUxfJXY6I_1792739017
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
runs with the RTNL lock held. This closes the same cycle against the
RDMA auxiliary probe as the two preceding patches.

Use device_trylock() and report the device as busy when it fails. When
the qdisc is added, userspace gets -EBUSY and can retry. When it is
deleted, mqprio_disable_offload() ignores the return value, so the
hardware traffic classes and the channel VSIs stay in place until a
later qdisc teardown gets through, the same as the existing -EBUSY for
a bound RDMA driver. The message is a netdev_warn() because of that
second case, nothing else reports it.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- rebased on the new patches 1 and 2
- netdev_warn() instead of netdev_dbg(), the qdisc teardown cannot
  retry and ignores the return value

v1: https://lore.kernel.org/all/20261019065301.3983537-4-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9de375f5c4deb5..7eb653a7ebacd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9451,7 +9451,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			mutex_lock(&pf->adev_mutex);
 			adev = cdev->adev;
 			if (adev) {
-				device_lock(&adev->dev);
+				if (!device_trylock(&adev->dev)) {
+					mutex_unlock(&pf->adev_mutex);
+					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not changed\n");
+					err = -EBUSY;
+					goto tc_unlock;
+				}
 				locked = true;
 				if (adev->dev.driver) {
 					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
@@ -9471,6 +9476,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
+tc_unlock:
 		mutex_unlock(&pf->tc_mutex);
 		return err;
 	case TC_SETUP_QDISC_ETF:
-- 
2.56.0

