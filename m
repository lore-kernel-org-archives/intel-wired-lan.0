Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2343C77B75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Apr 2023 13:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 655C541BD8;
	Tue, 18 Apr 2023 13:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 655C541BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681824650;
	bh=dM3tisTRfyDvVuhxffY0iwl0/lk7VRCs1CE7YV7ra6U=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6Ru31HC2mQNqDNwDfJjfIBNX0GsCyaoZdurBIEiXtfOJwAIFk4e888bgoGR8eN/OT
	 ZSG92QhG+v8k2vVhP+tSqUz0oqxJvCLEfTLMA7JgktiJp9KjAVK5l+c5btuxNxl9G1
	 teRX8yAToNHKdLZeQhA7WVJLiBjR8ySg26ImX3chxWsOa3DCYlO+SEmIBfz0hnxF2e
	 bXJZnjZNMausio7GpwOAp4iXgMPjZ/srmWTghfPn2GZvUWf11dRzRL/FLNw6etFT2x
	 uueeqWC+gXDI55mBX4KOpXDSh616NmwaMESJeLYf7iuRgNIP8NXQS9vvFTx9+79Njs
	 eW8UNE2lvdiiA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ojZAUzx5jLhb; Tue, 18 Apr 2023 13:30:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57DC2418A5;
	Tue, 18 Apr 2023 13:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57DC2418A5
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A61131C427D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Apr 2023 13:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B8E883AF1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Apr 2023 13:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B8E883AF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tjRxHjywodG5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Apr 2023 13:30:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1EE781FF0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1EE781FF0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Apr 2023 13:30:46 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-bzWQQw1RP9eGc5wyzBXe9g-1; Tue, 18 Apr 2023 09:30:41 -0400
X-MC-Unique: bzWQQw1RP9eGc5wyzBXe9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91BE43C02539;
 Tue, 18 Apr 2023 13:30:39 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE8440C83B6;
 Tue, 18 Apr 2023 13:30:39 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id A6299307372E8;
 Tue, 18 Apr 2023 15:30:37 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 18 Apr 2023 15:30:37 +0200
Message-ID: <168182460362.616355.14591423386485175723.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1681824645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7E6qqj9b24iehviZ7WDVb8EbUsqIS5yQF8iCmZUzngw=;
 b=al8ZRUK7h0z1+LEDbf0rI4ixHzhbc4gXL7WxHlCvQxBWirbNLQL3+M1/eLc4ovQBcwINe4
 UmZbyPf7g1wrUgtPHZadKjsAG+Oth8T1zOROYjswVbSXgLR7EjMcCTxfSdkUwzFgOsf1P9
 0AryE5jAM5j6VnzTYvIJHe14qs/cNXc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=al8ZRUK7
Subject: [Intel-wired-lan] [PATCH bpf-next V2 0/5] XDP-hints: XDP kfunc
 metadata for driver igc
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
 ast@kernel.org, jesse.brandeburg@intel.com, kuba@kernel.org,
 edumazet@google.com, yoong.siang.song@intel.com,
 Jesper Dangaard Brouer <brouer@redhat.com>, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net, hawk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Implement both RX hash and RX timestamp XDP hints kfunc metadata
for driver igc.

First patch fix RX hashing for igc in general.

Last patch change test program xdp_hw_metadata to track more
timestamps, which helps us correlate the hardware RX timestamp
with something.

---
To maintainers: I'm uncertain which git tree this should be sent
against. This is primary NIC driver code (net-next), but it's
BPF/XDP related (bpf-next) via xdp_metadata_ops.

Jesper Dangaard Brouer (5):
      igc: enable and fix RX hash usage by netstack
      igc: add igc_xdp_buff wrapper for xdp_buff in driver
      igc: add XDP hints kfuncs for RX hash
      igc: add XDP hints kfuncs for RX timestamp
      selftests/bpf: xdp_hw_metadata track more timestamps


 drivers/net/ethernet/intel/igc/igc.h          |  35 ++++++
 drivers/net/ethernet/intel/igc/igc_main.c     | 116 ++++++++++++++++--
 .../selftests/bpf/progs/xdp_hw_metadata.c     |   4 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  47 ++++++-
 tools/testing/selftests/bpf/xdp_metadata.h    |   1 +
 5 files changed, 186 insertions(+), 17 deletions(-)

--

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
