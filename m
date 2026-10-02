Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8FCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5107481231;
	Fri,  2 Oct 2026 13:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02VkWRZFzgRa; Fri,  2 Oct 2026 13:08:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD7B781222
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946501;
	b=hhGhrg/MsW1irlvbYe+IjCjHP0hHw2HiFAw8UpZ+Itgh8YG6hD8jtmtnxTv3JLBUaQxY
	 XQiDQNGwKNwDV2iEEWOK1bnQg//Wf0p+PxZzY1amv6zSBQpDfgG9crxRJ2n61+mI2qCLp
	 tbq7upnWb2p8xnQei4BNMLv/EzzHbLYRCHMWTdIDwiNl1B685bd4kl7rQv5lyWrZalkgd
	 jD5a4z+ZNMGzAEUDg+c2vPmS41Odu1wUjGoF6/6TaU/uVZ6d4CzdPxVys+AjmnV9ex/Ae
	 Asm4wTA23J+PGj+/Tke/EajIuAYwm+q2S/+0p0wXkp4ajtebCRqYoar9tSOlfoEwVdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lUHnkDSrrfCXFMH8IJydTfHAXtd3mYVbUu8G9r9OmXs=;
	b=ZjAlx8VysPrUO/viatpQX/OFkyuUMFJFj0SQ51+WQ0G1bJQX/PQPYdYrcUuL/p4uhGP3
	 7WBW7AdB+J7QbSdFT+EPCdcndMyVCZ2qvDkeDrjQVSrq003WhKdYhW5DQjVNPNLX0iTr1
	 ClDECNa7K2wpI/DDtEeFc0BHw+GVBka8kNwX8gXc6Ep56LRHitbQXE1J76ZX+rUnBlqIZ
	 seEcv9VFfT412EXlC+CZHQZVs2UE/kfI7dmGF0ieXw01K3dImDDHVJdTbujVZpnU24eA0
	 rPGh8XjE/Y3s6Rii+/5ayp7gfuJpadg714+o1V1SszOKGdpPTBNT3HiixVwXawM5NIg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946501;
	bh=lUHnkDSrrfCXFMH8IJydTfHAXtd3mYVbUu8G9r9OmXs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YKSGEoWl3JtbaXBklUQRtAoz1ed9AjfN/PHp84/lYnrAp+A1MIyrLSREfnHL+422H
	 ZFDK0dH4ClPx2NweVBEGZeh1gUvnCDYvUrn0LmICtHlfU/h9gRkozrM08yGTppbZ6d
	 hYEIhuA0KVOhFHahO8hg3icOSOjfx1QWoDNrCEDdswMKdXSDy1h5SW5J4TTp1mIkBr
	 jw/8b4cx/BmF2SmUWSbmIX+AzVK5uDZa5JMamEc+Ps6hpzLM4LblAp3N/KKp/y7A0l
	 B+YJ/X5yQgwNP6zW+pC0rg2yGj3js3lknk9ud66VJEBNol1I2gGCbY5jE0oaAUquy2
	 7gV6EnpGd50+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD7B781222;
	Fri,  2 Oct 2026 13:08:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE31F282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF11B606FD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qt-Yy41knaFA for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FFF1605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946499;
 b=fnhB4yMiB8uT+2a+AsNJzHbaETF6XCs4g8PcVrjCb6d5fgaptWlfHRJEhVox4+8pR1dO
 tLeqo1IU7ey+1Z63QujIiym+xavlXVmEdfhet2GdlzmMeJZQlxwyUMPxetqHFu+nuZvxA
 Yce5fixnkfIekj/P1unH+r3YUv65tVGw4UHkDIwe3F3EB0M5Pkifzw5Y+soBAASTB/wdT
 YmVkBU/rkkBUMA668AGOCa9JuHrYfZTluinZxevke1S2PM5H7d5nLBpYTcPjgQ+d08Hgg
 1VkBAqMziAgb3FEAv0cx50Hr73DoOAujUnBuLTe99g3zU3eAwDLrffajOrYCOAcacTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946499;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=lUHnkDSrrfCXFMH8IJydTfHAXtd3mYVbUu8G9r9OmXs=;
 b=qXLtO7sXvqG8BT4s0aavY8CcsKtNkDfCWs2xAxT3HjJ9ECVPItTcNfPA40hVQmsKSf1m
 K9LnQpwWSowS2Vghd0hVdcF/+bfGlPIrPk/37JTr/ewXw3dtSKVx7jkNG4DoDbNzmpSKI
 aABkTo2ebYqOppaG6RHMSQalcBrILbNQ4WvAcbGsiz/gbaWTKdXKW1ZgkCWn2cMMzQW7K
 WLLK8sMnZBzrBfBruVlJPjJYe6P9XyI1Eqd9/WzzI56v29XRg75iejhkH6Y5JR0dgUCT9
 wnoY5BN7Eg3dmz1mFk6I4ArffO/INvHmIQP2ARlqQsaOlGsU16wiy3Nm+HgjLlYeM+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="jPEFnS/r"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=jPEFnS/r
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FFF1605E9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lUHnkDSrrfCXFMH8IJydTfHAXtd3mYVbUu8G9r9OmXs=;
 b=jPEFnS/rMmqIicbfmwnlZMzXmNqe3Ka/S2+xvrEpnTX3iw6JrxNa7pXhyrvJxSeuu1jEus
 LbxK0YRDBjRXRx2wqTdzFq4z47NdxzPKAt7RYMXy84iw4gDFa8Wzye4q1DdE6M4D5/zxON
 kqjNEBQJuOVpaoEMEUvyBUzGgOmjCzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-VTi12gDzPNeEvE01KJKvzg-1; Fri,
 02 Oct 2026 09:08:08 -0400
X-MC-Unique: VTi12gDzPNeEvE01KJKvzg-1
X-Mimecast-MFC-AGG-ID: VTi12gDzPNeEvE01KJKvzg_1790946484
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E20A118F4BE8; Fri,  2 Oct 2026 13:08:03 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA859433; Fri,  2 Oct 2026 13:07:55 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 00/10] ice: port missing i40e fixes
Date: Fri,  2 Oct 2026 15:07:42 +0200
Message-ID: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 3Y7sViY4Qh4QXq1HGc9ZuQ73u0kK2U1jhcgySY2ONJM_1790946484
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

This series fixes bugs in ice that have been fixed in i40e, some of them
years ago, but are still present in ice. They were found by going
through the i40e history and checking each fix against the current ice
code.

Patches 3, 6 and 8 have no i40e counterpart. They showed up while
verifying the ports and are kept in the series. Patch 3 was found while
testing patch 2. With the IRQ unwind fixed the netdev still could not be
opened again after the failed ndo_open, so patch 2 alone does not make
that error path recoverable. Patch 6 was found while building a
reproducer for the i40e MAC filter overflow fixes. Those are not part of
this series, because a full switch table on E810 leaves no room for the
promiscuous rule either. Patch 8 was found while checking the i40e PF
reset fixes. It is an ice regression of the poll loop timeout check,
which i40e does correctly.

Every patch was checked on E810 before and after the change. Patches 1,
4, 5 and 6 have plain reproducers, which show UDP tunnel offload lost
after CORER, an always empty default XPS map, VF tx_dropped stuck at
zero and multicast filters silently not programmed. Patches 2, 3, 8, 9
and 10 need conditions the test box does not hit on its own (a failing
request_irq, a hung PFR, a WoL capable port, counters past 2^32) and
were verified with fault injection. Patch 7 was verified by filling the
switch table, with debug prints for the failure analysis.

An LLM was used to go through the i40e history, to write the
reproducers and fault injection hooks and to draft the patches and
changelogs. All of it was reviewed, and every fix was tested on E810 as
described above.

Petr Oros (10):
  ice: replay UDP tunnel ports after a core or global reset
  ice: fix IRQ freeing in ice_vsi_req_irq_msix() error path
  ice: stop the LAN Tx queues when ice_vsi_open() fails
  ice: restore the default XPS map after a netdev TC change
  ice: report VF tx_dropped with tx_errors instead of tx_discards
  ice: keep adding MAC filters after one that already exists
  ice: take the switch rule AQ error from the response descriptor
  ice: detect a PF reset that does not complete
  ice: program multicast magic wake before tearing down the main VSI
  ice: fix unsigned stat widths

 drivers/net/ethernet/intel/ice/ice.h        |  8 ++---
 drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    |  6 ++++
 drivers/net/ethernet/intel/ice/ice_main.c   | 36 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_sriov.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 17 +++++++---
 6 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.55.0

