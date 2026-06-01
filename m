Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A65CCD6E56
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Jun 2026 09:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0596542A3B;
	Mon,  1 Jun 2026 09:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EmITdznpenm0; Mon,  1 Jun 2026 09:23:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 378D842A3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780305837;
	bh=XvO6AWWbrytQKUaTglHDoblgZaWUr8G3OaM5lLPMVTo=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mIKJwBT1ImnmufXvXFZi2tL6RG6dlhMn9FMYadPo0YhMOPBKG8DdrxPsJfENfCp1Z
	 yH51FgvGVSgyndcO+yc14SO8wpNeiONbeKiP+cEmBQ56unM6j759a0jvcJ9K9mRmUI
	 +lUtruSfyfv2UbTuHUG1bw3z1enlQPbwbXPOc6gu3RpNyjPG7rB7kpd9otpMViI8mb
	 uo5ojpLgVnesuGwEBRAVi3I0f+JAzQ9RVVQLXhjkLkbThg+vIfalDN4mbKl6k9Uh/K
	 nqjTpBt6qVPgin1s4/13Biu4kXYmATTJixSnEgcCGS2pnSIR834Z25Y8oCAiVKAnbh
	 MusZs70Q25nlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 378D842A3C;
	Mon,  1 Jun 2026 09:23:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76306257
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jun 2026 09:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C23B60B6E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jun 2026 09:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arzmraiWxMuF for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Jun 2026 09:23:55 +0000 (UTC)
X-Greylist: delayed 641 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 01 Jun 2026 09:23:54 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2767060B5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2767060B5F
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:237:300::1; helo=chamillionaire.breakpoint.cc;
 envelope-from=fw@strlen.de; receiver=<UNKNOWN> 
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2a0a:51c0:0:237:300::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2767060B5F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jun 2026 09:23:54 +0000 (UTC)
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
 id CFCCC604DC; Mon, 01 Jun 2026 11:13:08 +0200 (CEST)
Date: Mon, 1 Jun 2026 11:13:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Felix Fietkau <nbd@nbd.name>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 intel-wired-lan@lists.osuosl.org
Message-ID: <ah1NJMrJ5rEkQlJG@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=strlen.de
Subject: [Intel-wired-lan] Possible UaF bug in netdevice teardown path
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Another sashiko drive-by report. TL;DR, do you need to apply this
pattern in your driver?

-       metadata_dst_free(priv->md);
+       dst_release(&priv->md->dst);

Affects:
drivers/net/ethernet/airoha/airoha_eth.c
drivers/net/ethernet/intel/ice/ice_eswitch.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c

Long version:
https://sashiko.dev/#/patchset/20260527135751.1031891-1-tristmd%40gmail.com

This isn't a bug introduced by this patch, but looking at this fix, do
other callers of metadata_dst_free() suffer from the same use-after-free
vulnerability?
In drivers like ice_eswitch and mlx5 MACsec, a metadata_dst is allocated
and references are taken on it via dst_hold() when packets are processed
(for example, via skb_dst_set()).
However, on their teardown paths, these drivers call metadata_dst_free(),
which unconditionally frees the memory without checking the reference count.
If packets holding these references are queued (like in a netem qdisc)
during teardown, does the memory get freed prematurely, causing a
use-after-free when the networking stack eventually calls dst_release()
on the dequeued packets?
