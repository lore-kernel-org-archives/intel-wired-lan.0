Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3958BCCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 06:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E822080730;
	Mon, 19 Oct 2026 06:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLUdhzZ6iiqK; Mon, 19 Oct 2026 06:53:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EAF680F51
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792392806;
	b=G2MCZIzy8oalWXiYP3kD2soGR8FPp4hzZcnjniu8JMXENGvpi3H9DfjgN2EkynDhzcs5
	 F4VsIGcM3HAcIr9JHQifGzZNmRpfl0NPzRc8AaUeu7CblUaBXBYtWr5rpuUAo55wCQMSj
	 EVXVcfWDfkZIwCV3ITQm4BlsDnKLe9TncWNh4UJcGYcR8uuJMbtqpmly8qyYA9aXIW9PK
	 +6XWyrNsrTECyQmgcI3pQKyWWY3CJatEl3SbswwzYaZSWpujz4ER3cZh+rIPSuRCeVEtH
	 uvPL5wYgx9gMU1AS8D9UxxDa73Gb3kKMlTx4xMftCFpqEup+fxCr47e4U1kJTrjP79g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792392806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ia+ZEym176fLK/VRzqajkyY5xZ/llz9gMIBRTMQe8QA=;
	b=BJSIH4coFOSM1avw/0jElEKDf7NslYktex01KJ6zXQOLDYuNzFKCLAAB++2sEujceMva
	 HccD8EGKBrkkU/uAWjMg3z3S0sCpnZR8pgs+duRXrhiLZUpaErtVgwpaVKmaS2x4d2elB
	 ZKyqKgz5GrcdSVaOs/9EpKdnNnkAxL1cBmRTQaev7IXVK+Jm12RQqJy76Ps2dA6KxF5jS
	 7j2UG9H0fHyW36BnPIhVpZyEz0WKnkevWzexNdMtIcvYHH3chLAvhywuRjanxgj68W50s
	 APlLmzWtAAm38ohjpdFlkE8J6wDxu9Gkba6OyJn7L9zGA76lwLHHOCRs9LTcLtC+nBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jUzyGQFB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792392806;
	bh=Ia+ZEym176fLK/VRzqajkyY5xZ/llz9gMIBRTMQe8QA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QfGfa2Oa4jpvo60tHbPklWe2hddcaik3/0PJlFFbWgYuPaLMoKuKkuW+uJJjS4pg2
	 AnJLxw7Jhd68iufQRmL/LAJjUukcoAiP/lfzhUtbwsZtIV8i8Fgh7OGStjTchESHEp
	 oKVOcOmn9saDUr2AqUZy99STmNTyTVbaOV+xaDC2M9cySZBgLPlmSpESVTi3k5dvPI
	 cqhHimrj2DObAGia+isRkRFyivM8zd7BNM+LhIOdqSIiDEIDh9/LeadiyJFNKySePl
	 wt0dLs4R1YIYQ8izTE+8AXnaLa8B5wGU9w/fDYzCMVWoTJ5RuTTXNaFBRFYSw81uMo
	 YzLSzPjH52SRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EAF680F51;
	Mon, 19 Oct 2026 06:53:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46EA42A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CCEB80F51
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOgU_N03V46Z for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 06:53:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CCF780730
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792392804;
 b=PgBVvaPFeJVJ41aALiTzey4dtZLg5Y4Q/wLCsptLCwn67r0OxdrFVtQ+DkhMFrxk/gYH
 aqYnIF7iJo4HXxg8vl8z4EZxLngtyO/ZHGh+z9YPQ6zT2Hf5VN+yg7re5xDijRFdHJOn4
 aPofzNjKg7xPKfdDN7BkiTmKRyAiiThN+B+hpJy1dnDmryxwg2I/vrL/4VPHrfGThvHPw
 J5Qe4CZWrD/TG9e6wxE6VoERF+KW/4ro9aKilGif365tCq85LnS0euxfFv997zyhiqgl+
 ti5zwXd3HOVBBekKQgJZIgcMqxzyBLWdfZlQrbpdWxpNHFUKL9sEDVswBNZGJtZF9Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792392804;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=Ia+ZEym176fLK/VRzqajkyY5xZ/llz9gMIBRTMQe8QA=;
 b=ELsoMhPp1YQ3muES+PvQr9YZvMcUzs5X5ihnGbWDVwQte2trGhNHHjjgURx+9lVyAFOq
 RSMPuAKCiuj9Bg2JQNCO8S7f1PgYCognJ9GPABu9b0bcyjwVA4FPY1pwczDA/QARR+7yr
 X1bd6R6X010WCB0pD3NZxtUIfc2np5iUSTJkZMpMwaSF/3Q/sII6iCe5ViYU/CayaXS27
 TVg02FHKiBHg3WXZ2x2hbP/XC2ir1rBE51jx47x0oPY2wZNf2kdJudWlHJW3yCnvEoytE
 Nc2whBxvl1YCMSsr0elMj2/VfYn47GRWVif4YWztwprNNt4O3+bGiX80whUZXZiYkgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jUzyGQFB; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jUzyGQFB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CCF780730
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792392800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ia+ZEym176fLK/VRzqajkyY5xZ/llz9gMIBRTMQe8QA=;
 b=jUzyGQFBAa8OXqudQhwrED4vvEMdw9X8456LzQ7hr2UWvCuV6puG6EckzDOp3HfLFAroLA
 PTUR+82sWl7pbvc62JH5bUV1XsYevym5EAqDVI30OqxAjrUnF3jG2GBHHb/5tW9zYnxj0K
 nmTtPpHbn9kWNTl77nPx4C+YE4oMMAE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-RhZmXjyNMK-bjT8GInK8pA-1; Mon,
 19 Oct 2026 06:53:16 +0000
X-MC-Unique: RhZmXjyNMK-bjT8GInK8pA-1
X-Mimecast-MFC-AGG-ID: RhZmXjyNMK-bjT8GInK8pA_1792392793
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C677F1955F74; Mon, 19 Oct 2026 06:53:12 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 279441955F03; Mon, 19 Oct 2026 06:53:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Dave Ertman <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Kamil Maziarz <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, linux-rdma@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net 0/3] ice: fix RTNL vs auxiliary device lock inversion
Date: Mon, 19 Oct 2026 08:52:58 +0200
Message-ID: <20261019065301.3983537-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 5fkAyk1tR2kzTFlHilGOtuv8bxa5wCJUGAQKe-7n7iI_1792392793
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice takes the auxiliary device lock of its RDMA auxiliary device from
three places that run with the RTNL lock held. The RDMA auxiliary probe
takes the same two locks in the opposite order, because __driver_attach()
holds the auxiliary device lock across ib_register_device(), which needs
the RTNL lock. ib_query_port() reaches ib_get_eth_speed() first from the
port immutable setup and again from ib_cache_setup_one(). The result is
a hard deadlock that leaves the whole RTNL-serialised part of the stack
stuck, so the boot never completes:

  systemd-udevd   state:D
    really_probe                  <- holds device_lock(&adev->dev)
    icrdma_probe
    irdma_ib_register_device
    ib_register_device
    setup_device
    irdma_roce_port_immutable
    ib_query_port
    irdma_query_port
    ib_get_eth_speed              <- blocks on rtnl_lock()

  lldpad          state:D
    rtnetlink_rcv_msg             <- holds rtnl_lock()
    dcb_doit
    dcbnl_ieee_set
    ice_dcbnl_setets
    ice_pf_dcb_cfg
    ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)

linkwatch, addrconf, NetworkManager and every ethtool ioctl then pile up
behind lldpad. On a PREEMPT_RT kernel with CONFIG_DEBUG_RT_MUTEXES the
rtmutex chain walker reports "rtmutex deadlock detected" from whichever
task closes the cycle instead of hanging silently. Plain lockdep cannot
flag it, because device_initialize() marks dev->mutex with
lockdep_set_novalidate_class().

The probe side cannot be changed, so the three ice callers stop blocking
and use device_trylock() instead. Contention is only possible while the
driver core is binding, unbinding or suspending the auxiliary device,
since all three sites already serialise against each other under
pf->adev_mutex, and ice_unplug_aux_dev() clears cdev->adev under that
mutex before calling auxiliary_device_delete(). ice_unplug_aux_dev()
itself is never reached with the RTNL lock held, so there is no fourth
site to convert.

Patch 1 then handles a contended lock per event, because the right
answer differs. BEFORE_TC_CHANGE has to arrive before the traffic
classes change, so the DCB reconfiguration is refused with -EBUSY. The
MTU change and critical error events are sent from the service task,
which consumes their pending bits before sending, so they are re-armed
for the next run. AFTER_TC_CHANGE keeps its existing fire and forget
behaviour, and the commit message explains why deferring that one is
not safe. Patches 2 and 3 only turn the lock into a trylock, where a
contended lock means the operation is refused with -EBUSY and can be
retried, which is what the existing check already does when the RDMA
driver is bound.

This keeps the fix small enough to backport. It does not address the
underlying layering problem, which is that ice reaches for the driver
core lock of a foreign device at all. i40e and mlx5 both solve the same
need with provider-owned registration instead, and converting IIDC to
that model would make the inversion impossible by construction. That is
a net-next change across ice, irdma and iidc_rdma.h, and I am happy to
follow up with it if there is interest.

Tested on an E810-XXV with two PFs, irdma bound to both auxiliary
devices, on net tip commit 191aa41548b2d2 ("MAINTAINERS: add Bobby
Eshleman as vsock reviewer") with and without this series, same config
otherwise. A reproducer binds the irdma auxiliary driver while driving
one of the three RTNL-held callers into the probe window:

                        without the series   with the series
  ethtool set_channels  deadlock 10/10       0/10, window entered 300x
  ndo_setup_tc mqprio   deadlock             0/10, window entered 50x
  dcbnl ets set         deadlock             0/10, window entered 30x

A window entry is a contended device_trylock(), that is, the exact
moment really_probe() holds the auxiliary device lock and waits for the
RTNL lock, so each one is an occasion that used to close the cycle.
Without the series the console shows both halves and the box only
returns through hung_task_panic. 25 reboots on the patched kernel were
clean.

Petr Oros (3):
  ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver
  ice: do not block on the aux device lock in ethtool set_channels
  ice: do not block on the aux device lock in ndo_setup_tc

 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  9 +++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +++++-
 drivers/net/ethernet/intel/ice/ice_idc.c     | 20 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++++-----
 5 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.56.0

