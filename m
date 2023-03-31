Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678FC76196
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Mar 2023 18:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D23FE8470B;
	Fri, 31 Mar 2023 18:55:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D23FE8470B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680288911;
	bh=A3DTUHe0uuXv85+t1UtwSnn7w7C2WdRQ5uXpLBf6dTE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=bpyZhFeZM2Sp7qb88CYTkFiBe1JzPhAGqBeifOFWax7P5eVcbYsg4zYUmxiMUwYrM
	 +Cjj1Wskor0XCGzx80D2b1Ud0R1P/NCSeo+Dt9A+vaWMSdTWg1MBRstzhYtz9qzVkY
	 d4Slqyqm9DNmaQ4WMisbt4lQXa+wcHhoO/ESHXc76s8lCS98W8UD9YxM0mvpq4BOJD
	 Tun51vB5whPXd8Rw3qR1z744YJVzGiyXOybogRe6gDyPuMgtqn+/DRL9cl0S570kyq
	 X1tDoSVeaz9JdlIzp6FqQLSWlFropwuIDv5+4FWZtZxjjjx2IaePkLf3F98knBBBA1
	 zKApWM/LFBUoQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q48-T43d8p5j; Fri, 31 Mar 2023 18:55:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD60F84722;
	Fri, 31 Mar 2023 18:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD60F84722
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6F3CA1BF3D4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Mar 2023 18:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 409AD4212F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Mar 2023 18:55:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 409AD4212F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vWP4mZ0AGYEF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Mar 2023 18:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 293BC409A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 293BC409A6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Mar 2023 18:55:06 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-6ST_aE1BN5izY1S-rDCwaQ-1; Fri, 31 Mar 2023 14:55:02 -0400
X-MC-Unique: 6ST_aE1BN5izY1S-rDCwaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BA6A85A5B1;
 Fri, 31 Mar 2023 18:55:00 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E737492C3E;
 Fri, 31 Mar 2023 18:55:00 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id F282330736C72;
 Fri, 31 Mar 2023 20:54:58 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 31 Mar 2023 20:54:58 +0200
Message-ID: <168028882260.4030852.1100965689789226162.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1680288905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kblsxn2I4uj63CCZ5lvLbiV5TyyMA+h7P/LAJWAO5eg=;
 b=fvrZD0rv++jQ15Jy7jfUQUL5dj9ygIQ4XPinNIoUENWKkEcg4qYtnIUyn4rcc2q/KHNE0v
 0kSphK1pt8OA3LSDH0bHwYltx6t806A7wPV84SRnPCc4L4ey61vQanCc/aUycrfHYAkKHf
 ihwqF9rfzu5Iob9VCT9H0U37tO5KIqU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fvrZD0rv
Subject: [Intel-wired-lan] [PATCH bpf V5 0/5] XDP-hints: API change for
 RX-hash kfunc bpf_xdp_metadata_rx_hash
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: xdp-hints@xdp-project.net, martin.lau@kernel.org, daniel@iogearbox.net,
 larysa.zaremba@intel.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, tariqt@nvidia.com, linux-kernel@vger.kernel.org,
 jesse.brandeburg@intel.com, kuba@kernel.org, pabeni@redhat.com,
 yoong.siang.song@intel.com, Jesper Dangaard Brouer <brouer@redhat.com>,
 boon.leong.ong@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
but doesn't provide information on the RSS hash type (part of 6.3-rc).

This patchset proposal is to change the function call signature via adding
a pointer value argument for providing the RSS hash type.

---
V5:
 - Fixes for checkpatch.pl
 - Change function signature for all xmo_rx_hash calls in patch1

Jesper Dangaard Brouer (5):
      xdp: rss hash types representation
      mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash type
      veth: bpf_xdp_metadata_rx_hash add xdp rss hash type
      mlx4: bpf_xdp_metadata_rx_hash add xdp rss hash type
      selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for new arg


 drivers/net/ethernet/mellanox/mlx4/en_rx.c    | 22 ++++++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 63 ++++++++++++++++++-
 drivers/net/veth.c                            | 10 ++-
 include/linux/mlx5/device.h                   | 14 ++++-
 include/linux/netdevice.h                     |  3 +-
 include/net/xdp.h                             | 47 ++++++++++++++
 net/core/xdp.c                                | 10 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 14 +++--
 .../selftests/bpf/progs/xdp_metadata.c        |  6 +-
 .../selftests/bpf/progs/xdp_metadata2.c       |  7 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  1 +
 14 files changed, 180 insertions(+), 24 deletions(-)

--

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
