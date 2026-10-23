Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC8606A31A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qwjA/MSL;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjGl2JQW;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MgQKc+fl;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjGl2JQW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32E9760660;
	Fri, 23 Oct 2026 07:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGunAOnFtVw8; Fri, 23 Oct 2026 07:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52A7260665
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739302;
	b=L09/lbDYEhzC2uUJU9NjiiIe33y3c6FMRHkkZfJmCfTHdO7onCkvdsRe/p0kL5hisEZ8
	 fK8B4WGF8SnD2gHtK1sdrIA8sr69xR48EDl2DivKXqQ42kvRz9jwGquPJgUOO3itrwFEP
	 9HxE2oQ3oxqPgmG8RC6bLWR0ZDM0LtK6HUDH3BCudMmfcP1+T4NgjE1lPbDSSZV37GEt5
	 SxIPAP3x/HMUDTyrg6TqHkfZyXL4Leor0kvKRD3bzhtWngEU1stJEdrQAGZ+fAtAIdk81
	 hsN4UL9SuMMiF892zcGRvZuUQ3S0hvkjjxqZ26UWtKyURXyv6FZwY6cKaetZP08m5BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
	b=k1RHbuZ1Y6k8SgwwgwktgSemu6rdLli8fKxWUmFwPUfaSSo7FYbUYdp5XKh3vyNIbXbG
	 tHdqeJd88z3RsePCE0yA8hy6lRyvc5LUOD+PQOL6KkI/WYvqoPI8Y4PUdh5827Reo0Qus
	 DzlrpEj+5nDY0F4KCbotTGcCPy4SVRV7NKZ6SaI22k/P3fVTVrJqQ4QSy8wT8WIqAzYUD
	 yytwTQhq//nZCYz+UpzavpnQDFBjtRyqdsfc4Yv0cNtsfx+4kn9OrmO8c0YE0OQYMU4K9
	 5sbyQt2rSz/b7hc3oJ3b9a8+bE8WhwOAL/8KLzB4RCbmYyefRX+kVfuK5yovy4v/h2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792739302;
	bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qwjA/MSLE7Ek1TxLhf79CVIzkBCb/AA9lUtpJbWHHXy0YDcewJbAntqzgRYrI1qus
	 pffheVIbLVizoBdsEWjPk5539AIb9/p85EQFsra3zNdXC3oCpO6TYo0fjMlAYGXDGn
	 UtnuhrlnTctGT8fpyiuHc+iTaEVVws8ElMvGEZdmsjJHSg3wlcmtjAeQHZNonjR68v
	 WEy4Hhd9FdF2igKCBogO1+JqCgU5z3rt2W8x2WOC1VvvLlnlyltYw+tVoMVMxCarKb
	 a9KcjL7yLVpxsG6qtuu7LTi6WShoHbKko+nmPCrjUrHY2sXFgociWA2EPs0/sNQ/D3
	 6iESxl+H/GMeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52A7260665;
	Fri, 23 Oct 2026 07:08:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BC4549D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71F0D811C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOTmdmAhXJwS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 07:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5847D811B1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739299;
 b=QCpuz+yS7Lh8SSQuLpH/E53aXA9KIJJIKaue0iFwrorghOAnUtI8lJ/au/pbaJWSsusA
 eFnR2ikhIrQ89LBWU2NRhd4XlEWBYSWq4gCf/XVuvdPGB464lZDlRcryy6Eg91+In5YYh
 yIyN+UlJ+lI++Q3D2Kv6Qp0r9Z0H6pGIDZgJSZKmihgKlkNq3T/ItPgRUy9iYdaeAyRtl
 DcfmOMjSmtZsqFUMa50gxTd3NPzGMEcBJIPCmBYkgxY5eDLJwYjKf+cesMu00Z6hSpiTy
 BYcGX501OeybiLiNHa+bBL6+M/H3LNJLorCeeILqGaytbZQ+sbs85rF4fUVRp/SEa6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739299;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
 b=czGEDcI0Q1aUKKHCHGGzhD7jOVOetj1KoUB8vfmvH8dwBqnGpPhTmu62zGMt6Ej0MIct
 h7PhjzT1djyiDJAP6G9UCF0CrSwnkgp5JZO0KaNKKmDyTOt+nyFm3B46BRyvDPFuz/E68
 9EPYbqVNCoYeh1Y+DbD+O5HeRHRwJ+8eWDI8l8Mc3Tflxgps5jm0jwxXJY8EXoYap+iBF
 Gfm+foDHeFJJeTFVG0OOwB6xoD2yfCdPsCNCPWcShjIrRbRiKJbxG+q3sgZ+vW6ELHbIn
 aL6Ntm6Fr+f0Nf//Iw6Oz8vV8Q8+9GMiVzeb743sPuEkwFKSuKvV/30VbedsQQZew7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cjGl2JQW; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MgQKc+fl; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cjGl2JQW; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjGl2JQW; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MgQKc+fl; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjGl2JQW
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5847D811B1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 07:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792738996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
 b=cjGl2JQWZh36gXCqf8qSgs6mpx9ixB5G0ZYHx9rSLdGwB4zxrUhx+Z+3GHNXweqSuaLbHP
 tTT4uz4ydTD8Yu8gP+ThCi9fPKFLAigtod/KoMcZD9St1OfyTeS9CfyOZgzJnoPb6p2YKS
 hXkiG93pyov8rGlkTmwwmO8I3V6lajk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792739297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
 b=MgQKc+fluKrZ37hDmoNb/sOn2SYimFuJZacU1047jkKRAZ7sPzeSr80MrskcoW+E4Q3fwl
 I4hKoseOU8sXYls+Izl1XS+s3sBtEtywYi+ISlRitTlwhYRM3aS+k6wTuzXZYoWdg9hgJz
 h/atptoXsrIOzyOn7aVPjCCuanBjX8s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792738996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
 b=cjGl2JQWZh36gXCqf8qSgs6mpx9ixB5G0ZYHx9rSLdGwB4zxrUhx+Z+3GHNXweqSuaLbHP
 tTT4uz4ydTD8Yu8gP+ThCi9fPKFLAigtod/KoMcZD9St1OfyTeS9CfyOZgzJnoPb6p2YKS
 hXkiG93pyov8rGlkTmwwmO8I3V6lajk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-ajkdnhQkPMC7JQNKU9NkXg-1; Fri,
 23 Oct 2026 03:03:12 -0400
X-MC-Unique: ajkdnhQkPMC7JQNKU9NkXg-1
X-Mimecast-MFC-AGG-ID: ajkdnhQkPMC7JQNKU9NkXg_1792738989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DE151956052; Fri, 23 Oct 2026 07:03:09 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A6101800347; Fri, 23 Oct 2026 07:03:03 +0000 (UTC)
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
Subject: [PATCH iwl-net v2 0/5] ice: fix RTNL vs auxiliary device lock
 inversion
Date: Fri, 23 Oct 2026 09:02:52 +0200
Message-ID: <20261023070258.730168-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: y3jmIjD-BW_sEEFw57Dqo0xWuBZnbihrDODZpFaOCeM_1792738989
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice takes the auxiliary device lock of its RDMA auxiliary device from
three places that run with the RTNL lock held. The RDMA auxiliary probe
takes the two in the opposite order, because __driver_attach() holds the
auxiliary device lock across ib_register_device(), which needs the RTNL
lock. The result is a hard deadlock of everything that needs the RTNL
lock, so the boot never completes:

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

Lockdep cannot flag it, because device_initialize() marks dev->mutex
with lockdep_set_novalidate_class(). A PREEMPT_RT kernel with
CONFIG_DEBUG_RT_MUTEXES reports "rtmutex deadlock detected" instead.

The probe side cannot be changed, so the three ice callers use
device_trylock() and refuse the operation with -EBUSY when the driver
core holds the lock. Patches 1 and 2 are new in v2 and fix two separate
problems on the same sites, the auxiliary device pointer was tested
before pf->adev_mutex was taken, and ndo_setup_tc() took pf->adev_mutex
before pf->tc_mutex while the dcbnl handlers take them the other way
round. Patch 3 keeps the locks across the whole DCB reconfiguration so
that BEFORE_TC_CHANGE and AFTER_TC_CHANGE are either both delivered or
the request is refused before anything changes, and re-arms the service
task events. Patches 4 and 5 turn the remaining two locks into trylocks.

The proper fix is provider-owned registration as in i40e and mlx5, which
makes the inversion impossible by construction. That is a net-next change
across ice, irdma and iidc_rdma.h, this series is the backportable part.

Tested on an E810-XXV with two PFs, irdma bound to both auxiliary
devices, on net tip commit 191aa41548b2d2 ("MAINTAINERS: add Bobby
Eshleman as vsock reviewer") with and without this series. A reproducer
binds the irdma auxiliary driver while driving one of the three RTNL
held callers into the probe window:

                        without the series   with the series
  ethtool set_channels  deadlock 10/10       0/10, window entered 300x
  ndo_setup_tc mqprio   deadlock             0/10, window entered 50x
  dcbnl ets set         deadlock             0/10, window entered 30x

A window entry is a contended device_trylock(), so each one used to
close the cycle. 25 reboots on the patched kernel were clean.

Changes since v1:
- new patch 1 for the auxiliary device pointer race
- new patch 2 for the pf->tc_mutex order in ndo_setup_tc()
- patch 3 holds the auxiliary device locks across the whole DCB
  reconfiguration and sends AFTER_TC_CHANGE under them instead of
  dropping it when the lock is contended, and takes the locks before it
  consumes pf->oicr_err_reg in the service task
- patch 5 warns instead of netdev_dbg(), the qdisc teardown ignores the
  return value

Link to v1:
https://lore.kernel.org/all/20261019065301.3983537-1-poros@redhat.com/

Petr Oros (5):
  ice: check the auxiliary device pointer under adev_mutex
  ice: take tc_mutex before the auxiliary device locks in ndo_setup_tc
  ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver
  ice: do not block on the aux device lock in ethtool set_channels
  ice: do not block on the aux device lock in ndo_setup_tc

 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 46 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 +++++++----
 drivers/net/ethernet/intel/ice/ice_idc.c     | 48 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 47 +++++++++++++------
 5 files changed, 130 insertions(+), 39 deletions(-)


base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
-- 
2.56.0

