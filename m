Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46DBC00528
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Jul 2023 15:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78EC540899;
	Mon, 31 Jul 2023 15:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78EC540899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690818853;
	bh=5f2dr3ACvGWgrw/FkB6SE9nl+4dY0cDBZDBUmm/SiWc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IxsZVh75Tlij4f2KC4UVPly6x9vpjqA7tFewlqTHGeWaG117kYm5AQ2Lh517vicsB
	 YxxM8YXvwHx558jI1QJTljuIkxXbfiSqUL0bNaLs+6lR56+VXfqQLIORkHhgB06yRD
	 TpKYhHUzICZds/SRGpuLu0B519VNcnfMxlojSbWmZTl0g4Cu7omV2D/d3OUN82UCyL
	 5Mgw+7qiD4HvgnLQuWaTDz9OnPzehpgL+XBE3SC6EDSeQjhQRaWXMDP41dCDcumOIt
	 j0vXCKYdET8Bfiko0J3ALm/EYOdleAKR55w81EyU5eaFltLoXF7TEnXA2zQt0coM62
	 IeTR2sNMLK2ZQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9Ij5o2q5m6M; Mon, 31 Jul 2023 15:54:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F00F408A1;
	Mon, 31 Jul 2023 15:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F00F408A1
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6A9F71BF3BA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 15:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E63840B67
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 15:54:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E63840B67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NR9hgyUyC8-J for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Jul 2023 15:54:09 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71DB6404C2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 15:54:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71DB6404C2
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A896A611E0;
 Mon, 31 Jul 2023 15:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80DC433C8;
 Mon, 31 Jul 2023 15:54:06 +0000 (UTC)
Date: Mon, 31 Jul 2023 08:54:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Message-ID: <20230731085405.7e61b348@kernel.org>
In-Reply-To: <ZMdfznpH44i34QNw@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
 <ZMdfznpH44i34QNw@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690818848;
 bh=s0kAjQJcavEtn4qvC3HzqyRFEFYgPphknK2SvtAotiA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ai5cILmtb3ikR461b8t7idKX14GQLmt2bs/fBuBiOKhKc+OryJNDPvPleFOOZTVlc
 HmshJ1DkT3qyLODzm6f4SpXnv8+U3LBo31m3Z17rA+CIfHwe4gm2oKWJk87lCMsgSE
 VmSxUS9E53HwBkcY4fkB166eUYdM9KDAH1kkkkSsw4mBqgGOm94IcY/dOS2yfD9wWX
 ZcmsLKcbH55gYPozq7qpkWENSU79Fgm+QIrcahW9o5w469Pa9DjjKw0TGGEMKGVcZU
 lSJGonui4w8fDPFS/pUly4U4Y2r/1p/fY1Ku5X0siK5onBeTBT4SlU8QJaIN2oKqX1
 UQe/LZhANotNQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Ai5cILmt
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] rtnetlink: remove
 redundant checks for nlattr IFLA_BRIDGE_MODE
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
Cc: ajit.khaparde@broadcom.com, simon.horman@corigine.com,
 bigeasy@linutronix.de, somnath.kotur@broadcom.com, edumazet@google.com,
 anthony.l.nguyen@intel.com, michael.chan@broadcom.com,
 louis.peens@corigine.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, huanhuan.wang@corigine.com, tglx@linutronix.de,
 yinjun.zhang@corigine.com, Lin Ma <linma@zju.edu.cn>, na.wang@corigine.com,
 sriharsha.basavapatna@broadcom.com, netdev@vger.kernel.org,
 oss-drivers@corigine.com, linux-kernel@vger.kernel.org, saeedm@nvidia.com,
 davem@davemloft.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gTW9uLCAzMSBKdWwgMjAyMyAwOToxNjozMCArMDIwMCBTaW1vbiBIb3JtYW4gd3JvdGU6Cj4g
PiBQbGVhc2UgYXBwbHkgdGhlIGZpeCBkaXNjdXNzZWQgYXQgdGhlIGxpbms6Cj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA3MjYwNzUzMTQuMTA1OTIyNC0xLWxpbm1hQHpqdS5l
ZHUuY24vCj4gPiBmaXJzdCBiZWZvcmUgdGhpcyBvbmUuICAKPiAKPiBGV0lJVywgdGhlIHBhdGNo
IGF0IHRoZSBsaW5rIGFib3ZlIHNlZW1zIHRvIGJlIGluIG5ldC1uZXh0IG5vdy4KCkkgZG9uJ3Qg
dGhpbmsgaXQgaXMuLiDwn6eQ77iPCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxpc3QKSW50ZWwtd2lyZWQtbGFu
QG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21haWxtYW4vbGlzdGluZm8vaW50
ZWwtd2lyZWQtbGFuCg==
