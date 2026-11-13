Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82745606A333
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iyK/uRNg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cFuzHR7a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F7AD81161;
	Fri, 13 Nov 2026 16:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xltvQ-JAXEzp; Fri, 13 Nov 2026 16:15:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DC23813D5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794586519;
	b=aHG0PM7bRUX0WX5ZBIXUdaDmnFWC779HRQ4+PfqowJnaIzw18J/fZCt6bHslclibBurm
	 +dYOoRulrp5QTYQWJjO1Po5dZq/kg/v95QLKuN8EBUgV1XLVx/tBfrNe8rosn/4crqQRd
	 XtR6sUlVizEqbI8kfmjnm/rfdwarviPh9sAAK8Ptym/ShCTmU3W0KokiS3Ev5QMCC2Pkj
	 5d5eYPMr8sv9mfZu2Wfi46Qfm701mHs8bYVqti2CWdrNL+pDH+h0pZvOph9TVN9C8cuOn
	 xiG/tNFVngHVRYM0/JFXz25ZiVl1hssxeMB8U4B3VksuJJwhrWQ5J2eEDzOEOvEFMGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794586519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LyAexoLdXtyWX7zHQ9kxhNDlcsHA6CRuNTqI4fwaJ8o=;
	b=alIR4e2UkbKKFFSZUxIYPmwHHxzMVzt659PoUfsPyieFKDE+JbyYK/7/G+eXiMPE8IAo
	 kjySWaIqd7QI6Yx6sgvBoGwjbIxfa9oA6BznS7zuOmtNibtcbaiywK3oAhcRqAgfbhVsa
	 rRF4Zg8Xur3uG+wM37IWpaXvtvpaN9mTa3OxuuXjSGV6yA/DbaB41Wz7EWhthdddrM7xw
	 169na4MgkjMzPGxEc9zjDmR8VBjfPuQIw/ZyaNQ1hzUp9jso9Nmtk/9CK8N+dcCc7x1WO
	 Diq+dZPABx8Va0DxHN3MnUEoqofTymgEuAHX1XaimCDpjs84XV17sXSHfCsZWrWwETA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794586519;
	bh=LyAexoLdXtyWX7zHQ9kxhNDlcsHA6CRuNTqI4fwaJ8o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iyK/uRNgl1JETTeUVTwjltJ7cluVo4StuLicr6YDhOOZUA1391k1L85sNI6lnRJt0
	 A4y/BMXQBRtgSdGCdh5+JnAHfA1CX7qlm3nAVT7XXyMruULeXhtLhPouFiuO05sSGF
	 2Xd5T28i4AwEzfUiMNfEdsITtibraU24ZYe8ro/63jaNFIl1YQfHChHgpFhvcvUe9K
	 ekwXFt6hxnQTOVedmJTncbM/zpkF5WZgLbKKyqtrn7SxWFCB5NI/VRgBdGDfbIzgmN
	 JLcW/Upt9SaH2GbTOUkBYqW/WR2voktqIxp7w/5GPigP/wtcU1sgoJY/KtDrnp0FRx
	 f3Gv62AnUGGyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DC23813D5;
	Fri, 13 Nov 2026 16:15:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFDCD2FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E153F6065C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DpR6jQIQY_XP for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:15:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DBAB60653
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cFuzHR7a
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DBAB60653
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794586513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LyAexoLdXtyWX7zHQ9kxhNDlcsHA6CRuNTqI4fwaJ8o=;
 b=cFuzHR7ageD1PAa/3Fziw7Kdp7ChZ+40+rSFsfiWouh7dw+euU7H+sk1o+uKuWddDUU0Na
 B5mr+pPnUeH4dUjwpZq8rHG1v7yeDCnZhe1WNKVN+CAvYB703UvAwjJci445T3aj1Pd1EC
 gqEOx+8sJIlWNIz8nzABIQqmPxQ38K4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-x8Z_BzvSM_mvx_R4vhOOlg-1; Fri,
 13 Nov 2026 11:15:08 -0500
X-MC-Unique: x8Z_BzvSM_mvx_R4vhOOlg-1
X-Mimecast-MFC-AGG-ID: x8Z_BzvSM_mvx_R4vhOOlg_1794586505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B92C180059A; Fri, 13 Nov 2026 16:15:05 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB974180054D; Fri, 13 Nov 2026 16:14:59 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v3 0/4] ice: fix RTNL vs auxiliary device lock
 inversion
Date: Fri, 13 Nov 2026 17:14:49 +0100
Message-ID: <20261113161453.1234851-1-poros@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xlbXZ_VxrI8JO8vC4ttdhrEmymfoFaPJxEI9DScBySA_1794586505
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
core holds the lock. Patch 1 fixes a separate race on the same sites,
the auxiliary device pointer was tested before pf->adev_mutex was taken.
Patch 2 keeps the locks across the whole DCB reconfiguration so that
BEFORE_TC_CHANGE and AFTER_TC_CHANGE are either both delivered or the
request is refused before anything changes, and re-arms the service
task events. Patches 3 and 4 turn the remaining two locks into trylocks.

The series is based on the dev-queue branch of net-queue, which carries
Przemek's "ice: fix DCB lock ordering" [1]. That series takes the RTNL
lock before pf->tc_mutex and then drops the mutex, so the lock order
patch of v2 is gone and ndo_setup_tc() has no mutex to release on the
new error path.

[1]
https://lore.kernel.org/all/20261102105346.30739-1-przemyslaw.kitszel@intel.com/

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

Changes since v2:
- rebased on "ice: fix DCB lock ordering", patch 2 of v2 dropped
- patch 2 runs the fallback for non-contiguous traffic classes in place
  of the transaction instead of after it, the deferred one let the RDMA
  driver resume on traffic classes the PF VSI did not have
- Reviewed-by from Aleksandr on patches 1 and 3

Link to v2:
https://lore.kernel.org/all/20261023070258.730168-1-poros@redhat.com/
Link to v1:
https://lore.kernel.org/all/20261019065301.3983537-1-poros@redhat.com/

Petr Oros (4):
  ice: check the auxiliary device pointer under adev_mutex
  ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver
  ice: do not block on the aux device lock in ethtool set_channels
  ice: do not block on the aux device lock in ndo_setup_tc

 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 47 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 +++++++----
 drivers/net/ethernet/intel/ice/ice_idc.c     | 48 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 40 +++++++++++-----
 5 files changed, 126 insertions(+), 37 deletions(-)


base-commit: 1fcc5adeeda91622627c5c238985b60421ee9e70
-- 
2.56.0

