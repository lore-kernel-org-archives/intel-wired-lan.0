Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F3606D829
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=M6JNcESx;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCyE8kpd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCyE8kpd;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCyE8kpd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC6F340934;
	Fri,  6 Nov 2026 12:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fm7TJeIhyHOq; Fri,  6 Nov 2026 12:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED0D64095D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793967029;
	b=E2fewQFScjpc3k4EazOlcOPiWUPKc2IzTwdJYhZLrin0LdZ40/US5lTcRTM+XXaaDFa4
	 cAXmkg2W/leorO5zyd1TDfIWDXyzk/3xokBKMkd1GkAeIZv+CFdqcvrmvoeySJbJebN/H
	 8efuM6rkj+ouvoqWJbujCOtI7Y+ZydgU+ifS+lylMQTTV7bBlKWK9sXVN8QUmusyDrjWa
	 ICwmom6b2MJSsBc1iUvDnxYJJMdOEAFT9DvJD+Lt/Wo4lf0xVjaT7CYB8V1xg3WSdb57F
	 zlQsPKGgpGPI0U3ejWf4ucaP7BEYnX0//B131O4EDOJ7i60NFNtY0dCjCdz/pfnZEGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793967029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
	b=D8Gni7yJT9oc+9pb7ktwNi4sErXAFMXBiD2tOtFyO9++Q2Pm7V/I6KB536avxafcAv/V
	 J0UnewJl4xcaPx22QNfGDgcJ2wfX1cxMOkoz7bdOPU5CxbW0C7Pjs3AKDAobQhdpzsoP9
	 O/7ncjDKYOGFknVEV0TmtYKKcDcHQjrEFmN265PKNuRZV/kZtycOFWI69zwPXh9GYlSyy
	 1nFuQ8RbvEpXEkcVXxTNYE5XYHpfpgypMljpi9Pi8GFwf5uqGA6ljqi1JQsdpbQ7XePtU
	 v3WHmBB9/3v72ytEqAfBJ5nshKMD11FABnK2Y+p1zyNz0Lr9nDnJGt5EwEcbeQbGFqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793967029;
	bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M6JNcESxaWuhnKVJEbEcQ1uGkSwcwPwc0p2zYKljdxy0DkahFYqu6+r2AL4swJRCT
	 gAge5OkonX/gSySk4X443Ha5yerNiFZ7/lwue1z3asYNbefgyKPp3FTp+nWkeyL6iW
	 IELDXKVVDJ3HdMtvZdK2nJizVD4rdK6Wa7Xdqd2+XAOqO/aEVfxMNsrS+HKY7kdupv
	 41il1rcw1rtuNPyNorTFsFKUBrU76CPzdiRRxlui/dZwCU4eZbMOcmsdboiVmPeH8p
	 rWy57ip8fqvaqqnVcOIuTsn32niRISEfuzGkXtyCYsJDoSAkxh1vWpBOnxia1+Uc75
	 LXvnBGgnQB+GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED0D64095D;
	Fri,  6 Nov 2026 12:10:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0CBF235
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85E87403A9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrQTBDIL1ytE for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 12:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 48AA7400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCyE8kpd; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCyE8kpd; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCyE8kpd
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48AA7400FF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
 b=fCyE8kpdYSKK6BV6UreETCC8ay9eEzt8GwTKIy0CgYtVOhZXRyRv1RKj6vS8U9qBQSKNnS
 Mb9iURC/qA8bXgEuXMtYjgdNlnlujVnXusNrC5iAjRHqzpXi5dlyjHIZ93b8Mclr1PQ7uh
 XCI3rKPAcLLdpl+HTngOC5rsIxFkj2o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
 b=fCyE8kpdYSKK6BV6UreETCC8ay9eEzt8GwTKIy0CgYtVOhZXRyRv1RKj6vS8U9qBQSKNnS
 Mb9iURC/qA8bXgEuXMtYjgdNlnlujVnXusNrC5iAjRHqzpXi5dlyjHIZ93b8Mclr1PQ7uh
 XCI3rKPAcLLdpl+HTngOC5rsIxFkj2o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
 b=fCyE8kpdYSKK6BV6UreETCC8ay9eEzt8GwTKIy0CgYtVOhZXRyRv1RKj6vS8U9qBQSKNnS
 Mb9iURC/qA8bXgEuXMtYjgdNlnlujVnXusNrC5iAjRHqzpXi5dlyjHIZ93b8Mclr1PQ7uh
 XCI3rKPAcLLdpl+HTngOC5rsIxFkj2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-xMNlk3AOMYWJEFraLRt9tA-1; Fri,
 06 Nov 2026 07:10:17 -0500
X-MC-Unique: xMNlk3AOMYWJEFraLRt9tA-1
X-Mimecast-MFC-AGG-ID: xMNlk3AOMYWJEFraLRt9tA_1793967014
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF7741800676; Fri,  6 Nov 2026 12:10:13 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1469E18004D2; Fri,  6 Nov 2026 12:10:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 00/10] dpll: do not serialize driver callbacks under
 global dpll_lock
Date: Fri,  6 Nov 2026 13:09:55 +0100
Message-ID: <20261106121005.1327603-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: uYJiHS_xbPRyNyk_DbdxeIzqQrxe_fkm6-gZyJkPmxM_1793967014
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
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dpll_lock protects topology and object lifetime, but it also serializes
all driver callbacks in the system, so one slow device stalls every other
DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
commands with a 60 s default timeout, and zl3073x callbacks can wait
seconds on a driver lock held across ToD writes and phase steps.

Make dpll_lock an rwsem for topology and lifetime and add a mutex per
domain for callbacks. A domain is all objects created with one (module,
clock_id), in practice one chip or card, so channels of one chip stay
serialized as drivers expect, and they still block each other. Device
callbacks run under the domain of the device, pin callbacks under the
domain of the pin, whichever driver registered them. Only one domain lock
is ever held, so domains have no lock order. A lock per device would not
work, because pins are N:M with devices and callbacks notify sibling
channels.

The driver API does not change, but a callback can now notify only
objects of its own domain. Patch 1 changes the one in-tree callback that
does not follow this.

Registrations across domains exist in the tree only on E825, where ice
registers fwnode pins of an external DPLL with its TXC and TSPLL DPLLs.
These callbacks are no longer serialized with TXC and TSPLL, they rely on
pf->dplls.lock, and requests about these pins wait while the external
DPLL is busy. Intel folks, please check that this is fine.

Each complex of a dual complex E825 has its own DSN and so its own
domain, but both use the CGU of complex 0. Patch 2 adds a lock for the
registers they share. Without it a test lost updates of them.

Patch 5 is the only patch that lets callbacks run concurrently. Patch 6
adds KUnit tests. I also tested each commit with a mock driver and YNL in
QEMU, with lockdep and KASAN, and the tip with lockdep on two systems:

- A board with ZL30732A: every notification the driver sends from a
  callback, concurrent traffic with PTP, driver reload and rebind.
- GNR-D with dual complex E825 and zl3073x: callbacks of the pins shared
  by both drivers, TX clock switches, RCLK pins of both complexes, a port
  going down and up, and both drivers unloaded and loaded in either order
  under load.

mlx5 is build tested only.

On GNR-D, with ToD writes running on the zl3073x and requests waiting for
them, requests to an ice DPLL took 1448 ms in median and 3.9 s at most
before this series, 0.2 ms and 0.3 ms with it, the same as when idle.
Requests about the pins shared by both drivers still wait for the zl3073x.

Ivan Vecera (10):
  ice: dpll: notify TSPLL lock status from the periodic work only
  ice: dpll: serialize changes of the SyncE CGU registers
  dpll: add domain object
  dpll: take domain locks around driver callbacks
  dpll: convert dpll_lock to rwsem
  dpll: add KUnit tests for core locking
  dpll: reject measured_freq_get for foreign and on-pin registrations
  dpll: zl3073x: update locking comments
  ice: dpll: update locking comments
  dpll: document locking rules

 Documentation/driver-api/dpll.rst            |   44 +
 drivers/dpll/.kunitconfig                    |    5 +
 drivers/dpll/Kconfig                         |   13 +
 drivers/dpll/Makefile                        |    1 +
 drivers/dpll/dpll_core.c                     |  187 ++-
 drivers/dpll/dpll_core.h                     |   34 +-
 drivers/dpll/dpll_core_kunit.c               | 1573 ++++++++++++++++++
 drivers/dpll/dpll_netlink.c                  |  117 +-
 drivers/dpll/zl3073x/dpll.c                  |    9 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |    2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |    4 +
 drivers/net/ethernet/intel/ice/ice_dpll.c    |   29 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h    |    7 +
 drivers/net/ethernet/intel/ice/ice_ptp.c     |    2 +
 drivers/net/ethernet/intel/ice/ice_tspll.c   |    4 +-
 15 files changed, 1915 insertions(+), 116 deletions(-)
 create mode 100644 drivers/dpll/.kunitconfig
 create mode 100644 drivers/dpll/dpll_core_kunit.c


base-commit: 6584acd42820478910a771efb28a355a707e9cb0
-- 
2.56.0

