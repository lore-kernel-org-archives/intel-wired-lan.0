Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE4FC77B76
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Apr 2023 14:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6079B415FC;
	Mon, 17 Apr 2023 14:57:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6079B415FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681743436;
	bh=qBuS96VJqcJDzzSHVvZkwFibTLRhKSqhmg5BoOaUMbI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Mk4HZseek0s/2WWGgtuBmPss84gwW/pKhA6JVK405fSzVFwOXCpTk4k2EmjPhaSK2
	 5d1QL0MmFFViQhBqfkNbZkg85RmrVDq7y5aPScVh6CHGfL9gHRWNAokpyemZ9S7I8+
	 J7SS5Te8N6SnHKHpnGR9nI78/OXPXMULdrMXqT0b/cOgpebRA2K7dIZkk1EC/JWmhW
	 tEuhQ6yvvZN9UvRuUjzXLk6ZIPyRdzuvJDb/uwIL7vk6TD+Og7HLdRjZklDL+VcPKA
	 FBgDqfQVvDOW5aSW0bTXOCnIhNoqyVQQoXJVG8xkZJVkiVfTPY5QQoN39FsMLHSALD
	 sXQhb1tGW4dPg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13ougS5zkMGR; Mon, 17 Apr 2023 14:57:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CEC8416BF;
	Mon, 17 Apr 2023 14:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CEC8416BF
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id DC78E1C4188
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Apr 2023 14:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD015416BF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Apr 2023 14:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD015416BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YWxCY6sZuaKr for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Apr 2023 14:57:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E442E415FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E442E415FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Apr 2023 14:57:12 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-M2QY-31ONNC_ldxX-K4nqA-1; Mon, 17 Apr 2023 10:57:05 -0400
X-MC-Unique: M2QY-31ONNC_ldxX-K4nqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 458671C0907B;
 Mon, 17 Apr 2023 14:57:04 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C20DB7D283;
 Mon, 17 Apr 2023 14:57:03 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
 by firesoul.localdomain (Postfix) with ESMTP id CCAAE307372E8;
 Mon, 17 Apr 2023 16:57:02 +0200 (CEST)
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 17 Apr 2023 16:57:02 +0200
Message-ID: <168174338054.593471.8312147519616671551.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1681743431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h3iGQcB3e7F3+oGwghn9gsZP1jI84iVAMvZuMJ+erzM=;
 b=IXCcSjAdWd//MgwSTOA7BDlYhpWELjrSK1w1P2McUXsU59s2vRC00EUQ/SvYd2/D8jSd3Q
 Fz+RXs1x7RZGNQHsPgzzAHdy1cpClChaWOgyyrEfOUicrbyGs364gpTHyacyrBCkRBiMUU
 cxmYNRHGm+1kdegKGkvxX6Z/azS41gk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXCcSjAd
Subject: [Intel-wired-lan] [PATCH bpf-next V1 0/5] XDP-hints: XDP kfunc
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
      igc: add XDP hints kfuncs for RX timestamp
      igc: add XDP hints kfuncs for RX hash
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
