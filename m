Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E6606A330
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=wC9nWRFA;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyufintC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17E8B605F7;
	Mon, 23 Nov 2026 20:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJAgg78HxoSJ; Mon, 23 Nov 2026 20:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53B096067E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795467370;
	b=mgMXFDSiZ9Ix6WRv84D0pYRIAwui7XS3QkBwF6kgwwsARGQ/W7IXz8MvrsyEnLNLEe18
	 9lWt2X1agiXV6Z8ItwvlX7VYjzco6DuntA0i43YxZP2M/AD4MnhP0G/zeQBoFrmn4mPHa
	 mZzpLqB+mMeXy9r/1SjIZ/DLGCywRdxaT9uv9CYUgpkMO9Wu4b6InS1NRqPcLqHLSyCaL
	 c70Prgu6rcVimrDmt5+BsBN6/6Qk1fFBeGPMYjE9odzt9oKESIxLY/McMFGzr3o8zSXxk
	 oTJeJ2k6FXAruY3q39j0HWSEZgK9V5632f6wTap529ng8HUoM6Ih0o3lo9mQ6hNZENg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HAvjf+qFnF2PlnNrWEQfKw74csMPKo5xN9MJAY/vfc0=;
	b=XXqD8FUHitixDMGr2CcsZOGRiX65WmOthAQjajOvnjer2V3pbuOz+/cZDF/M5jMyWaIz
	 LyaZrYHcJ8XG/4VEfJjvHC5jTQSB72mnueDj1ET/M2eqG2L3KrVO6jyT7K8o9JQMvpATt
	 cMZ0qlGl0pE1C+4uhFD+JzbmCKLU4p7FOofb+71ejh7w7Js00fjHsafxh/cO8FHXBa8a7
	 7RGRr2qOrlDlveg1LN7pQWXNDyxXFTE053nbR2S+Hnd8NZIzYHs8SUwy9vRR+FlVJWKvS
	 F1Ve44B43eXtcZD3hFTqSgGQLtx+stAP9VujqmGgwV/WGWa/VSRAFjQCrZ0ifKqQFlA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795467370;
	bh=HAvjf+qFnF2PlnNrWEQfKw74csMPKo5xN9MJAY/vfc0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wC9nWRFA720uHNm/sZbbil1Hwgdmc6BG5rJyiXgNOOpmwz4ar1Y8BTyq6lHetAs20
	 D+N+uyMaOgWLPc3yGgM+Z7xlRl+v29EuKg7xea8+HhschKEQBZT3v0nNhYjAoGTgWC
	 ZqsevUOMQK4cIH/4lrf+i4VeZlPway2BmsdhPVNKzIIaMByRWq9bb1bZNJEealf+Na
	 8X6S3m6lWT5RcyxndLSACqFCUv5ylpcXmjbJrE9Y78nlaz5qoKYIVNYJ6dgIPTI6D6
	 7hULU61nLyb1B7FAlR73/sCVj6zu3SeMXhHe/H5B4CTYa0yqX7rbt2ovgscRRkTaD2
	 fxfklktwSzwPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53B096067E;
	Mon, 23 Nov 2026 20:56:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 88E34311
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AD7980D8A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-RFW4AOOk7t for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 20:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 951F680DC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SyufintC
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 951F680DC5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:56:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27D3A6251B;
 Mon, 23 Nov 2026 20:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7431F01567;
 Mon, 23 Nov 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795467363;
 bh=HAvjf+qFnF2PlnNrWEQfKw74csMPKo5xN9MJAY/vfc0=;
 h=From:To:Cc:Subject:Date;
 b=SyufintCTIvTXofljWuywuFKxyTrKNIjBQfzoo8FX1eNNrTJvqz+ff4VSTZIFMXsK
 K+nCP53efjnW+7DH60/NPz7vYYFVf+lDu0KD8AvdVfCbtrCwcVBD5ws5DXLDO28nUG
 lA5Tp3roSpsR8wVDxeGaZzWd/DB1RgFkqQwQ35xqumPFufkpnVmgzzdmysPIWP/OHh
 TikBSeFbnjqCjsba/SNzHonKbIXNmWamhzSa9t0rGJHEjYjWcMB2KvSPaLmez5AW82
 HNa6G5hLDvd4vZfuuyNTxtpfz71MX5m4xopLdv/YN2VNMzg4MoDeHNo9J0WCDaEqwl
 6BFhMFzDQwGpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ahmed.zaki@intel.com,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/2] eth: intel: fix unintentional symmetric RSS
Date: Mon, 23 Nov 2026 12:55:58 -0800
Message-ID: <20261123205600.1794292-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix Intel drivers not handling RXH_XFRM_NO_CHANGE.

I had an urge to "fix this in the core" and hide RXH_XFRM_NO_CHANGE
from the drivers, by fetching the current config instead.
But "NO_CHANGE" values are already part of the driver facing API
(hfunc has ETH_RSS_HASH_NO_CHANGE). Besides we can't _completely_
hide RXH_XFRM_NO_CHANGE from the drivers, since we want the drivers
to be able to populate the defaults for new RSS contexts.
We need a "user didn't say" value there.

---

Matt pointed out that the upcoming RSS sizing series breaks
NIPA tests, this is because the fix we shared in June:
  https://lore.kernel.org/20260626152636.1e48330f@kernel.org
or Maciej's version:
  https://lore.kernel.org/20261007200311.730443-1-maciej.fijalkowski@intel.com
is still not upstream!?

Recent discussions suggest that Intel maintainers may be willing
to ack patches on netdev directly. Let's put that to tests.

Note that I think this is a major bug likely to bother real
users so I'm targetting net. Przemek's series will have to
wait for net->net-next merge.

Jakub Kicinski (2):
  ice: don't unintentionally switch to symmetric RSS hash
  iavf: don't unintentionally switch to symmetric RSS hash

 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c   | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.56.1

