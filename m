Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBD606A321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gO36oE7M;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSuDcR5T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5696E811AD;
	Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6rUqQjDkYOA; Fri, 23 Oct 2026 07:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B00C0811AA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739010;
	b=bgB64TbkDVuRiOYheO/EqCg+UJb2A9QAhaFM2snHbkEG9K+7h2EJDxOES4eiJU/ccga4
	 +u+KTJ219JKxAf9InVX/MwP9f50De1wF6VlmamHmtXubH66eLXdiQMidg7t05t9AVQ4X2
	 8qpVha5mmnMwIH7orTEYO1K4PVIo5ndoUF3lqseqBTNgtmlrDXjRfDLurUQ6LDg5Za1Ax
	 6rRjTQhlzZbVi0KX84RabbBi6izLoGDzVSA2KLpB4Y1NR/ju+ctEpdDK7ETyC9fNakCh9
	 JVodPq+shgg3drE+YKUabjyA1d5aUtWO6ouLr2f/UcECgXyy7fdvgn7aRmBsK3rT0VA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pwY019oU3C9OxFF5eUZEycOGj4BsSFzJByYT9dKQ8So=;
	b=I7bg4pil3IdFC4i+j4U5tV12mG5L3JVCnkAoPoy4Rg1IPhJFq031sZ6zjvSQ01/k9fcI
	 IrzWBzdzQYNrVXzqAYcRA4lQt7sE9qSdBmJYvxYUATahX6JC8oB0yjCZOajhEJRVnwk+t
	 hW/8ENShDLyUQJlrOyCb19sSxoeJVf0UCJHc/VwUYN2XNryarWkMt7ZFRiNuwZJAPJ71D
	 UHDvYwOYD+TgvVKh4N27cYnzmQpVkxzCzNt8etEeHU0a3HwU45Yb2KxDx2RUW0/Y0Hvvz
	 iGP4F7E2g52ssIm6N41dLHvIjjr0RhhFb5cet01JS3srDaBM7coSLmSoYPyjBQbZG0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792739010;
	bh=pwY019oU3C9OxFF5eUZEycOGj4BsSFzJByYT9dKQ8So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gO36oE7MyH8CdoVlJAuJyDTq0rhI0dxcxRGNkKbLRoWFSjVKgu0iAChixHxWnYD9N
	 czT8m4CXWXgGGQYXsqOQRb2mNR8xRl8u8tBmkKDG7gI4OM4WMR10zUlHEWXkUGNrVo
	 d5fFIX8bnCHQH1x3UvXfSB7U8ZtfUSvLZ9GOuQunvIvhLEb/X9l0E09iitg2DcRCVY
	 YksAEE9vZ3o7j0G/ZRmV14dOwHFQOs9fz2cFvQngPvDARcm4UauTLyny70O8tyondH
	 8+WhUitZwNkTXzxRtz5n4lNrbrGRCKDPBIoNR1fbT/mMD1+55bVlhFPwmaOfwHYNNV
	 2LXqS+eEqpamA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B00C0811AA;
	Fri, 23 Oct 2026 07:03:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 07CE93C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 056B0400D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fb3ISaDMQAHW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 07:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 270CF400AD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739008;
 b=ahEzFHCCIIsBWFwUVrWrwbHr3G94V2Dncsw+0RFFBhZvzY8cwHAZ3llz5xyqpex/aPSt
 GNkwcFTeH5D73pc/PivxKExFRF03yLhU4H+xLTQz7h5YwmcLyN/CKtDlVr3E3vk1cBWM8
 R1IqT/EXzR3M7/MUzKal9UFbfK9w+ChY7wEkzNQNdEsj1hl6g4Qj0gViotyBAqpEbnh8G
 2NMdq5ewdfIenR9aLisgRh8bMjyed7rbL8tOuPygtJeEpCByqjq5LNJu6AFSfIFHcTBBG
 OAszWqEGfFWn54miqnzeRI7j+xZR14/+yQFMSUX/4HioI1gV0x4ky6e7sBorXUwM5bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739008;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=pwY019oU3C9OxFF5eUZEycOGj4BsSFzJByYT9dKQ8So=;
 b=MOz2LCJ0+1jkYWuHb6IYK1Fm7cHraLrXXrjl9/YfYXYxJ48qKVj40GCW4w+79f1sRruw
 UdjhBe6MfD/ammPDcYo/CmpZ+OiCxyMLgZCbs6fPrSt77QqPVluKlbFo3w8niangOhKWd
 38lDRziLEt+JhY+SLF14ft75B+cL6jebOzkDYU2wTV/XtwsBhABv81qLEbbsXsKAJLYQn
 NmPb/yH9Qe0+p83bCizVpTrv7lg2TvUlNv0ib+DdAhJImfAPP4CQt72Z10X83JzlkYfKA
 GLjy3nnmK0iFDLfLqKybUV0xvtsn26Gc32/KZxxc/CLjywcybyodTS2Rg7CdG+vQbLA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dSuDcR5T; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSuDcR5T
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 270CF400AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwY019oU3C9OxFF5eUZEycOGj4BsSFzJByYT9dKQ8So=;
 b=dSuDcR5TZ7KHOcA/a4I/mPBU6PP3DvdN5xbyKLpOjmYlAMOuMkzoQWLJ/24EmSJsBpoO35
 mGLDkjbJrIvHJR/JTADFYSoIIzqE/dCQkcWIeRT9Yp1beMHro29edRzK/g2YO9fFOcU87Y
 CgO5SgMHvqRFrv8FWzDl0rvdX0DRi40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-6C2F93JlOfGx6fuJEDqLpw-1; Fri,
 23 Oct 2026 03:03:22 -0400
X-MC-Unique: 6C2F93JlOfGx6fuJEDqLpw-1
X-Mimecast-MFC-AGG-ID: 6C2F93JlOfGx6fuJEDqLpw_1792739000
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3007A18005BA; Fri, 23 Oct 2026 07:03:20 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 247CD180029C; Fri, 23 Oct 2026 07:03:14 +0000 (UTC)
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
Subject: [PATCH iwl-net v2 2/5] ice: take tc_mutex before the auxiliary device
 locks in ndo_setup_tc
Date: Fri, 23 Oct 2026 09:02:54 +0200
Message-ID: <20261023070258.730168-3-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jneCHlhytl0OsfA0jpR46WhE5jsm40WojhskueaMWpA_1792739000
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

The mqprio path of ice_setup_tc() takes pf->adev_mutex and the auxiliary
device lock first and pf->tc_mutex after them. The dcbnl handlers take
pf->tc_mutex first and reach pf->adev_mutex through ice_pf_dcb_cfg() and
ice_send_event_to_aux(). Both run with the RTNL lock held, so the two
orders do not deadlock against each other, but they form a circular
dependency for lockdep, and the DCB reconfiguration is about to hold
pf->adev_mutex for longer.

Take pf->tc_mutex first, which is the order the dcbnl side has used
since pf->adev_mutex was introduced.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- new patch, ice_setup_tc() took pf->adev_mutex before pf->tc_mutex
  while the dcbnl handlers take them the other way round
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 984479f1e1f6d9..8693ca285d5f1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9438,6 +9438,8 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			return -EOPNOTSUPP;
 		}
 
+		mutex_lock(&pf->tc_mutex);
+
 		cdev = pf->cdev_info;
 		if (cdev) {
 			mutex_lock(&pf->adev_mutex);
@@ -9456,15 +9458,14 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		}
 
 		/* setup traffic classifier for receive side */
-		mutex_lock(&pf->tc_mutex);
 		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);
-		mutex_unlock(&pf->tc_mutex);
 
 adev_unlock:
 		if (locked) {
 			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
+		mutex_unlock(&pf->tc_mutex);
 		return err;
 	case TC_SETUP_QDISC_ETF:
 		return ice_offload_txtime(netdev, type_data);
-- 
2.56.0

