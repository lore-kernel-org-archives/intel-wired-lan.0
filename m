Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97AEF4BB8B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Feb 2026 21:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34EB440A97;
	Tue, 24 Feb 2026 21:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WaWFM-4pHCML; Tue, 24 Feb 2026 21:30:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98D3F40A27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771968625;
	bh=vbehI5k0rB54bjh1f0a2umagLZ4OYrZF4eNdQQugxLw=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OwgefXJ34M4JxXcIaL+ksALWH6N7Cqpx0RlWXgYiSdPiBSsx3trPdv6PqcjmPjwp3
	 zCSRy69svvI/aJZm1WsmViZ0dE/Hmld/dYju6KoHOoaU/YnBD7RZzQVpDB1r67ZHlT
	 R8SSF0ScyCm2GhhdKX6obPhwyOZ5M5DfVXGZ4P3CAZeVp1KqIaK5eIk5xW1YtG3Wfo
	 XOLhlBiegtDOKIqzYNyTS6iGv4tcL5QCDJA/nbgLpV7m2j0OQzl6IKIgGHhP8StdTw
	 9PiE/8doJc2y4ErWK7BY0uJbLf4fx6pH0T4XiYCEfQygks51g6Tc6nF7GWZkWdgc4R
	 Rg87oHSBcQpiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98D3F40A27;
	Tue, 24 Feb 2026 21:30:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B3A51B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58A3C60F19
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_A6yimLYybe for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 21:30:23 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 24 Feb 2026 21:30:21 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8531360F0C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8531360F0C
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-68982-202602242125141c2da29e28000207c5-lq2a_9@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8531360F0C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Feb 2026 21:30:21 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202602242125141c2da29e28000207c5
 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Feb 2026 22:25:14 +0100
Message-ID: <f269adc1e366685a15622fb51740eca7168c9339.camel@siemens.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran	 <richardcochran@gmail.com>, Song Yoong Siang
 <yoong.siang.song@intel.com>,  Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 24 Feb 2026 22:25:10 +0100
In-Reply-To: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
References: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; s=fm2; 
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vbehI5k0rB54bjh1f0a2umagLZ4OYrZF4eNdQQugxLw=;
 b=KcW5ewYGX3l5vf4Wblfb+Vgb1Jpva+THV2gf/O4U5sXYcTiaDI7LLIzlAwZMx9XA8avU3B
 MQLeoJMHcWwQCTYV+Lbgn3qf3lawLd9EMojyc47icVDouNXsJJbkRi9MuydVi1Y2oRAEgY9U
 W96vDkI/s4GJtRjD1v8EERcDzrnoFuR4N2bBcqEagUxqt4QDYPEVaFLMXWkTTmUInyqXA/67
 dSjuG5ywwV4GpDznI04Ak2CUpfcKMKF76RVh6CM5zU0SWApiNooKLivJ5BkfGYoQBNqrOYq9
 GSfAnJqKWOzldv8IzuXYnOj/5a/eqfGWLWyn4qc+ed3rWdHWodlyNeww==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=siemens.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=KcW5ewYG
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix page fault in XDP TX
 timestamps handling
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
From: Florian Bezdeka via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Florian Bezdeka <florian.bezdeka@siemens.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 2026-02-24 at 13:38 +0100, Zdenek Bouska wrote:
> If an XDP application that requested TX timestamping is shutting down
> while the link of the interface in use is still up the following kernel
> splat is reported:
>=20
> [  883.803618] [   T1554] BUG: unable to handle page fault for address: f=
fffcfb6200fd008
> ...
> [  883.803650] [   T1554] Call Trace:
> [  883.803652] [   T1554]  <TASK>
> [  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
> [  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
> ...
>=20
> During shutdown of the TX ring the xsk_meta pointers are left behind, so
> that the IRQ handler is trying to touch them.
>=20
> This issue is now being fixed by cleaning up the stale xsk meta data on
> TX shutdown. TX timestamps on other queues remain unaffected.
>=20
> Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP z=
ero-copy packet")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

