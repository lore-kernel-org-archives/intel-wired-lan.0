Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFC606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nwFjfL+w;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QIfvxIUM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC2E44091B;
	Thu, 26 Nov 2026 12:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZW6EEg2EoOn; Thu, 26 Nov 2026 12:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DABE4091D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795696319;
	b=o0VDOtaCuS9lho8jbsTdCXqdPkVgPsFNHb+ihn9RyCRgyx/VKAyRiO4285Y4H/HmGb9X
	 UX7VVhnRfmfx5SIOKHCbT8WMHvBya3D4feaLDkHfUWqbjmMbUJyLCDbNRDte5iHJd2T6V
	 HHtJhGbg8FTPliz35uVw6GUKdvL2TXuTDoQRK794AFMXXTEY6qpNJT1wZzOHARQnulQbY
	 3ap/l7kYE+SbnAzT1x332yPtWkcJD8KcDVWMpSxIKBmZOsn4UYPY/dlBqoBG4Gsf+TFYF
	 hmRsKNJcuWtNKjZJD/YvI/g/1KsUQuBqEIsbSC77TreTgaGglwjV1MpRT3lhbPZgUPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cFTRdaPd9FLNp5xRWJD0hfOG8q26IX70T4fOt+lnlIs=;
	b=mBtDES1OPwYW0BLZG28gdkj9Hl4am+aJBmpU2RuKubczLVvIxMofwgA2bd5AlZ5jhX/z
	 sHP/pV8UxY8cYWAlawkkz/pwTAah6hyf4GPUESlMMZuDkxGkcyFGCTjKqT/oakgF3T3mR
	 8piNzJS8BQuJbtuCmZGmd5sNisggyCLfFuEOSdaoY9+quI+Yfn5MvDW4dPaZ7kpcsPkUu
	 GK4Sdrn4h930Sgy1AqPnOUxbx1Na2Ztl9aaPfgAOWsI71bVpvjPw5G2/sCGIN/HKPQWat
	 +3CgVpmxwgId+OAkXOrBhVl2GTBlEdCX+pDqiPLqW3kvryJueFGVdZu6OiPsAjj7CyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795696319;
	bh=cFTRdaPd9FLNp5xRWJD0hfOG8q26IX70T4fOt+lnlIs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nwFjfL+w7S4ob7UieZVikEzcDLIfvNTQ07fZieevZPbpRdhnxdSxMQA3jmcQBOUGl
	 rsW1EGxbKyAuAux5GiDiV5GKBuoNM2WogZ7FhUVn832NcbuYLivadD2syiv7QKdlSF
	 XojQ3ea+/4pfLy6mzB4HwgdM9O6C5zCInOFh5UGldSgN83dI3wU+3INlmVVjNjDv/y
	 C34z93O4EM0VS7hYLSNJlJfyUmBgYkDHKvzhnp1dyuHphk3c16CP7+6oE0+XLUhSVu
	 qoSarSkNmPaLL98SzGh17uHQ1nqBLrqHPze+yt08SCXwnJLaf8BwTtpsxBubYigkN0
	 y084DI+t2dj/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DABE4091D;
	Thu, 26 Nov 2026 12:31:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 90C811AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81E69404DC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_mafbXEy_KC for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 12:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9C579404C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jramaseu@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QIfvxIUM
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C579404C5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795696315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cFTRdaPd9FLNp5xRWJD0hfOG8q26IX70T4fOt+lnlIs=;
 b=QIfvxIUMMn7c2d/He2Mi+ls9JDfW5pvYn4BHAOtRdMuGY4V8uX/EDq8zmTvs5S+emI/Vfy
 OhDJGiduIfjYtIk8n/xYVEpci0d5CAoVHGM4l5sgqPCkLoZlf1H9n1exBh+LwBtE6Dj7hZ
 9/1QSozGK1cDg0eigease18GbURxdPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-4dIC1Vp1M8u588k5GFNOTA-1; Thu,
 26 Nov 2026 12:31:43 +0000
X-MC-Unique: 4dIC1Vp1M8u588k5GFNOTA-1
X-Mimecast-MFC-AGG-ID: 4dIC1Vp1M8u588k5GFNOTA_1795696291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A8F5180065C; Thu, 26 Nov 2026 12:31:31 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76F4D3000229; Thu, 26 Nov 2026 12:31:28 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Jakub Ramaseuski <jramaseu@redhat.com>
Subject: [PATCH iwl-next 0/3] ice: share RSS hash profile IDs between PFs
Date: Thu, 26 Nov 2026 13:31:11 +0100
Message-ID: <20261126123114.893916-1-jramaseu@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iWvPlnJWzeGIcFn_NBDg2bgjnj01YKodqcDt_irjCRQ_1795696291
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DDP package gives all PFs of a device 126 RSS hash profile IDs, and
since commit a6d63bbf2c52 ("ice: Implement RSS settings for GTP using ethtool")
the default RSS configuration of each PF takes 19 of them. On devices
with 8 PFs, like the E830-XXVDA8F, the PFs probed last lose part or all
of their default RSS, and RSS configurations requested later fail,
for example for VFs:

  ice 0000:6c:00.0: ice_add_rss_cfg failed for VF 0, VSI 2, error:-5

The PFs configure the same profiles, and firmware already lets them
share an ID; what is missing is a way for a PF to find the ID another PF
uses for an extraction sequence. This series keeps a list of the shared
IDs in struct ice_adapter.

Dropping part of the default RSS configuration, for example the 12 GTP
entries added by a6d63bbf2c52, would also make it fit, but it would take
the default GTP hashing away from users, which feels more like
a step back, and it only moves the limit: without sharing, the IDs
grow with the number of PFs times the configurations of each,
so VFs and ethtool settings can exhaust them again. With sharing,
they grow with the number of distinct configurations.

Patch 1 fixes a profile ID leak on the error paths of ice_add_prof(). It
is independent of the rest and comes first, so that it can be backported
on its own.
Patch 2 shares the IDs of the default RSS configuration, which fixes the
exhaustion.
Patch 3 shares the IDs of all RSS profiles added through the flow API
(ethtool, VFs, replay).

On an E810-CQDA2 split to 8 PFs, with a VF on each PF and the same
"rx-flow-hash" settings on every VF, the PFs hold 126 IDs and fail 70
allocations before the series, and hold 37 IDs with no failures after
it.

Patch 2 and 3 were also checked on an E830-XXVDA8F with
one VF per PF and "rx-flow-hash {tcp,udp}{4,6} fn" on each,
all 32 changes succeed with no ice errors.

The series is for iwl-next although patches 1 and 2 carry Fixes tags:
sharing profile IDs between PFs is a new feature rather than a plain
fix, and patch 2 builds on the shared devlink instance holding struct
ice_adapter, added by
commit 6381ef1b1338 ("ice: use shared devlink to store ice_adapters instead of custom xarray")
which is not in net, and it is too large for net.

Notes for reviewers:
- CORER, GLOBR and EMPR clear the IDs of all PFs, and every PF empties
  the list while preparing for such a reset, before it can allocate
  again. A PF that prepares late can drop entries made by a PF that has
  already rebuilt; that only costs sharing, the IDs stay valid and are
  freed as private ones. Skipping the flush on some PFs would instead
  let a PF join an ID the reset freed, which firmware may meanwhile have
  given to a PF the list does not track (DPDK, a PF assigned to a VM).
- Sharing relies on the device serial number identifying one device,
  like the rest of struct ice_adapter; E825C and devices without a
  serial number don't share.

Jakub Ramaseuski (3):
  ice: release the profile ID on ice_add_prof() error paths
  ice: share default RSS hash profiles between PFs
  ice: share all RSS hash profiles between PFs

 .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  |  13 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   7 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 356 +++++++++++++++++-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   9 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  14 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
 drivers/net/ethernet/intel/ice/virt/rss.c     |   2 +-
 10 files changed, 395 insertions(+), 16 deletions(-)

-- 
2.56.0

