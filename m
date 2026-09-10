Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43F3C79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F9FB40AFA;
	Thu, 10 Sep 2026 15:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_2iuueKc8EO; Thu, 10 Sep 2026 15:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DA0E140B01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055636;
	b=Byot0Avdr2cKNYrDePTlOPqKimBzKaKSomkZnL76zn0GDe3sj6w4Huw4XfgOkTDZrtwi
	 EMDz0cDTX5GlzmW2kwnH3U79G/OWmrs+saOT42QeDs2ola/K1FNiCHvdUUOPIQ5qYNgYG
	 Nn0TZbvZ+nCMtgqqg23WVui0MBhzBPfkUmFTRlr+rsvBUgNv+VI4w55SZte6l/zufaS2s
	 9hmAZ9oTYFALDZ+RGOyn7hnc7PgJX2d9Cy0sOqIyzK92UEQIqAvHlqNLm1uycJATUIocE
	 9YsLfbGoyNvrOJQiRqPfmUZ52l/xHapxr4v52NbH34+Qz6SCvmt3Gr2tlQXHgLLYvjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
	 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
	b=fxjuoM78jmr1tan6s0lo+AZKaeTSHvGWRle4HnRnbUMM3FVXcB2ErX3EN8eXp2y1TNFo
	 Ns+mFZZLP5oTm/Pm/eLgI3sqOLYl+wn5A8Ltt/eXcig/3MXcPWw6qpsqRKyMSqcmAi70/
	 O6uttihA1q2leEdK/dQ6cumvHdif/BdM0PpeO1FRKVOm1hpZj1oXimRHLhJs32YaYWSzN
	 5Igxln0FNDQIQLiX1sM9VPVLPP9wymDpdg2kAVnkfSzAjnGj6NYmTsS8Rxs99F2dpN0z0
	 bf5PkR3ftHvCOfxJNXdGPXOVWG6wUwst4I/glENl81XLqZkYL0RoI5WyJ7I7K6EHWwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055636;
	bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tdLlymrEwj/OboIk9zFmZoKv5/5mxfvbs1pxItNiXTsj0Ltwx0fKzLcnu9u0vvPlA
	 iKpQYEwpA0CIDf+0FLa6KgnssfkZThy0cqaGZBrvAH7dv65vTLjJqMF5XEIWEYbWhc
	 +EHP4yxUczi4pxt6sR9euRAK0ZR2MsFW+0sNHEzCgU/KtkgBSzCROCNAqfqp52UhMW
	 Lcptt4fEijz5ijA3P4UPdNDBLn8jh78CL4Mt5gMI868ZmbS2NRZUvqWEgBQH/DvRhi
	 rPIqFI5nKGlMcjg/D7ap+r/5EIYriC3pucHIdLrAltTvLdSH78BopUCZF7akE3Fzqo
	 DvWJKSZ4UaRNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA0E140B01;
	Thu, 10 Sep 2026 15:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5240B29B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FB514034A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8e9uhIEuWKT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 15:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BED454032B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789055635;
 b=VrObznK1g8cmnPNevpH0x2GC1T+zXVWUvSMUwAyHC9ukt4450mHgYORzO77rnPPYJ57W
 /+GqKUAwA+pj20HoFyKpm4jzv4Daw2iP0EXqH7qfzNZNub4eUMciGfQ7idQ2zdL4ayBp2
 Me7DFPl2AOWLdvHtQxdnSYs15bJxtW0MIC/KTIfvaqCgjR1ZNzMvckIV3fx7oymVcuYhj
 jvHk26nw3LgjojRFeiJ54pxmi6qQQl4Msdf0ESux9QSkxoIVl4Qme297FiafmupdVJ6zE
 +pOOa5p5chfyiK13GVTh4f78R6MAgkvhmBmOmxgOsGeCB67bUxyjG6obynY+axZPNyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789055635;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
 b=l9ha+kjEs5kX0jVyolg5cm2ZwMFCicBISkyc+1tB68nhkdz55ZI42Bn5B3+djiUZuKcn
 KY/PXdmoXwk7Cg9s1hbwIlL6NXR3xPz8vzXvRNudeBVClCrw87AdeEne62tP/cCrM7KUb
 Gooxoe7FnwpB+GqCSXsl/G9D5IRUZj6VxChtqrfwnl/H7P2FRYrFkv7OUb3ZLPW64mPdN
 AhvW6k03bDdWrh4Iv6fsyRwvYsKs4a0DDXf9qAzT/25klktd5u53LaV5idLCS+z5zFIOL
 jqT+ptQx3i5vEySzl2BR9+uek8QC6Hn0MBxHUunknmn4FHHiGRyapLV5e+B1+7HvYUQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BKkFimHp; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cbdSZ2dA; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cbdSZ2dA; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="dG8+/5Z3"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BKkFimHp; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cbdSZ2dA; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cbdSZ2dA; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dG8+/5Z3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id BED454032B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789055325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
 b=BKkFimHpzBvvuwnPKuBhoXvsUdnJnqD1wqLmkxxSE+/txbt3DRWnPpstXEDuJAk/UxqdO+
 YIQTiEoFmXht2pyRvGzUcJyBYeCmJ0D38I+GGAkRW5kSrRGkAJb848nDDkLjQGnpF3sben
 75K1+iZaWTA3Aq1p9GJtywfT9ioG1gY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789055326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
 b=cbdSZ2dAfrx6x5J9jZb6PqbIGnX/awdQhFk4ZKfBN0vDFwO89lTt+6M7540NVtdvHeGZ3m
 IlgLIrgK6YdkcaQpi7FSaIGUvsJyLNXenSC91NuLo9Tuk/AgO2u7iS7UGLsSO4BCiYNubp
 KJF79vivrZ99Y9ZCsmkuFO8JnJnCejQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789055326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
 b=cbdSZ2dAfrx6x5J9jZb6PqbIGnX/awdQhFk4ZKfBN0vDFwO89lTt+6M7540NVtdvHeGZ3m
 IlgLIrgK6YdkcaQpi7FSaIGUvsJyLNXenSC91NuLo9Tuk/AgO2u7iS7UGLsSO4BCiYNubp
 KJF79vivrZ99Y9ZCsmkuFO8JnJnCejQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789055629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
 b=dG8+/5Z3nmhvPImOaPOooC8uA8q8wc8Wm4osPj+RQKssn5lVgJh8w7pac5x/rsF9ZL0P+C
 B/DrOXKMcqXttKMisI6P8+Cc5VRAb9MGtnZniq81ljShcJ9ZvpRQfOsD0o/r28hCa7Y+Fm
 Ue6wLIi3afyZO8pZqleqvbULEId53Iw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ksM_xiT-PjaO0lTE5395mA-1; Thu,
 10 Sep 2026 11:48:42 -0400
X-MC-Unique: ksM_xiT-PjaO0lTE5395mA-1
X-Mimecast-MFC-AGG-ID: ksM_xiT-PjaO0lTE5395mA_1789055319
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D756C1954AF0; Thu, 10 Sep 2026 15:48:38 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.140])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7821C433; Thu, 10 Sep 2026 15:48:34 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
 Kiran Patil <kiran.patil@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 0/2] ice: fix TC flower filter priority violations
Date: Thu, 10 Sep 2026 17:48:22 +0200
Message-ID: <20260910154824.3603687-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: oez_6gShWMXmLdmilZnfMI7hNcSeZ-CCJcKjhBRuaaQ_1789055319
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

Two fixes for TC flower offload in the legacy switch mode. Both
address the same user visible failure, all traffic on a port silently
disappears after installing a filter chain that mixes offloadable and
non offloadable filters.

The first fix covers filters matching on ip_proto alone. The driver
never programmed the protocol lookup, so a filter like "ip_proto udp
action drop" was installed in hardware as a match on eth_type ipv4 and
dropped every IPv4 packet.

The second fix covers the interaction between software only filters and
offloaded drop filters. The E810 switch gives drop rules absolute
precedence over forwarding rules regardless of recipe priority, so a
lower priority drop offloaded into hardware overrides any higher
priority filter that stayed in software. The driver now tracks filters
it could not offload and refuses to offload a drop filter that would
bypass one of them, keeping the drop functional in software instead.

Tested on E810 with the OS default and comms DDP packages, including
the original reproducer from the report, L2TPv3 pass and drop chains
with and without session ID matching.

Petr Oros (2):
  ice: fix TC flower filters matching more than the ip_proto key
  ice: don't offload drop filters that bypass higher priority filters

 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 187 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  22 +++
 3 files changed, 201 insertions(+), 9 deletions(-)

-- 
2.55.0

