Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD059C761A6
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Mar 2023 17:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4351C402E5;
	Thu, 30 Mar 2023 17:07:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4351C402E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680196072;
	bh=QsRpV5G+QKoMHOyOkjD8GvAzAEq1uzP2NcpVZQ8/a+8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=43pNfyFCNmiFHiUTRtw/yMhE86T3ImPyb7TzAjgFg5UXV9p8JJaEwJhSVUwu3mLdC
	 mmZqxsKMzroflfIshqsuKxPXKzRzH8gttBoz+zcrr1iwpT7ahBD1uyNYcjy5tgORM5
	 HYa7MwIOx32a8/VD/34iIemzP8S8VTMbJDh69OiSotNw/qFFuotw5SjyFSffGcIRCM
	 iR/yflYIiVUfmm10HSv5EHOnl1ew7QRST33vsI+ysGmky/3vNYLmsyPaBKPTPU3dnt
	 +7BYz/NyKJ4N/uYaNrguFRtY7VdmtWcyEAF1ylhYv8y1XMz4Htq4IL9gK8F1dfns8w
	 uPddYuV7/QG0A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgzeYwda1txt; Thu, 30 Mar 2023 17:07:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47DB741E85;
	Thu, 30 Mar 2023 17:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47DB741E85
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 8D5EA1BF3C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 17:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6530984029
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 17:07:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6530984029
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Li9svwVxvmw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Mar 2023 17:07:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FF0F84012
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FF0F84012
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Mar 2023 17:07:48 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-v7LVQCxVMTC5u30CO1FbKg-1; Thu, 30 Mar 2023 13:07:43 -0400
X-MC-Unique: v7LVQCxVMTC5u30CO1FbKg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 583F53810B1C;
 Thu, 30 Mar 2023 17:07:42 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB96492B02;
 Thu, 30 Mar 2023 17:07:41 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id B0C8A30736C72;
 Thu, 30 Mar 2023 19:07:40 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>
Date: Thu, 30 Mar 2023 19:07:40 +0200
Message-ID: <168019602958.3557870.9960387532660882277.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1680196067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEiCemmKyXQlz2Hqo8bHOiogjHXuOrfjM9gWP+5n7L0=;
 b=GduHeGwVpjoV3rMVJmtUtpb+VpM++2ne2/F6wMfP2hLQ2EeLG81yc3K8jHpMv9YaxUbdYb
 NoVeClYPj5e4UCX4i7IBjHoUGUSUxdmMACRp3F4/oHFnW+h4MHxhrSTsVM5iK9sAmJvFlk
 0Osec2Vl/MPdHZdyUWcGlHX7M4VYC7k=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GduHeGwV
Subject: [Intel-wired-lan] [PATCH bpf RFC-V3 0/5] XDP-hints: API change for
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
 ast@kernel.org, linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
 kuba@kernel.org, pabeni@redhat.com, yoong.siang.song@intel.com,
 Jesper Dangaard Brouer <brouer@redhat.com>, boon.leong.ong@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Notice targeted 6.3-rc kernel via bpf git tree.

Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
but doesn't provide information on the RSS hash type (part of 6.3-rc).

This patchset proposal is to change the function call signature via adding
a pointer value argument for provide the RSS hash type.

Alternatively we disable bpf_xdp_metadata_rx_hash() in 6.3-rc, and have
more time to nitpick the RSS hash-type bits.

---

Jesper Dangaard Brouer (5):
      xdp: rss hash types representation
      mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash type
      veth: bpf_xdp_metadata_rx_hash add xdp rss hash type
      mlx4: bpf_xdp_metadata_rx_hash add xdp rss hash type
      selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for new arg


 drivers/net/ethernet/mellanox/mlx4/en_rx.c    | 22 ++++++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 63 ++++++++++++++++++-
 drivers/net/veth.c                            | 11 +++-
 include/linux/mlx5/device.h                   | 14 ++++-
 include/linux/netdevice.h                     |  3 +-
 include/net/xdp.h                             | 49 +++++++++++++++
 net/core/xdp.c                                | 10 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +
 .../selftests/bpf/progs/xdp_hw_metadata.c     | 14 +++--
 .../selftests/bpf/progs/xdp_metadata.c        |  6 +-
 .../selftests/bpf/progs/xdp_metadata2.c       |  7 ++-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
 tools/testing/selftests/bpf/xdp_metadata.h    |  1 +
 14 files changed, 183 insertions(+), 24 deletions(-)

--

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
