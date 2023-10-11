Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06221CDB468
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Oct 2023 16:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 956D8812A8;
	Wed, 11 Oct 2023 16:41:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 956D8812A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697042483;
	bh=p1VxeNfe8x9256wYK/00c+DMBX3B7bulESR1h8sj9ok=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DVtdN3wpqRz4lKq7amvlYbC2XVwJRxjETn53VP68+LJkxEwpdNe3AdNXaVuAbRaus
	 H21xuWbXFiEz8XbznYe64qNv7tdB9uC58JsuqvMDPYocvTaiCGz/KkurT5ooVCCE2i
	 cOXd2AXQRprUXp/2RtcJE67vFFyXGNZV1UjfaRz79RnbJl+l1ajKIaRKWyZN6PzgIm
	 x0ffx+SJaZzr9NWDt8V30KHn01U++jqPa8ZKg3CUj0nixj51eKAW1Qk7jHKWshdyWh
	 uBt//7a1rgxjIYYx4+7F+UhTomqzJmBBPEI5Ky00KXoJo5u0e7y8PAhIdheSPak/Ay
	 5/UZHR2B8p6dA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8MIT5CsjwyvD; Wed, 11 Oct 2023 16:41:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CE7F812C6;
	Wed, 11 Oct 2023 16:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CE7F812C6
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 257361BF420
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Oct 2023 16:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A1E240280
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Oct 2023 16:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A1E240280
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e0vvGkxaJyG7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Oct 2023 16:41:20 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E92F4016C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Oct 2023 16:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E92F4016C
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D2B4AB817E2;
 Wed, 11 Oct 2023 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB0C433C7;
 Wed, 11 Oct 2023 16:41:15 +0000 (UTC)
Date: Wed, 11 Oct 2023 09:41:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: takeru hayasaka <hayatake396@gmail.com>
Message-ID: <20231011094114.4d8f24c7@kernel.org>
In-Reply-To: <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
 <20231010123235.4a6498da@kernel.org>
 <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
 <20231010191019.12fb7071@kernel.org>
 <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697042476;
 bh=hejh49+2QJYUTv/+mj/o5LoRRT/U0icOUjD72vSPqFY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=D2uDkKIO6qFka1E/H1MPofJv0xZKXnhqqQeemZgDdoL97jDFj3u+R1OKQtU5wcXp/
 YLov0IhajJJu2nhyT0egq/WSQ45qaIAYKTW6uRuRN3k5cWyg1RCvM/3s8+PDZYk6Er
 S3RTx7vwBRMdgK0g5bTjHd674CMJeGkK2sS+hA67XQNnlkwlUIHi5vemHPQzJ8Eq9P
 6XijW+Z5bioIdbaTRnzbgRpOcs+VCxxFqhI+cdbaAE2MxoruSal/FHp/tOlWNLEDSP
 tW49wzRAMztLeirvCgB4tXverg+HJU6+ujzBjs2fmKWgtTJlvn9iC1a/dIweOYojD0
 FlVFjA5fFpphA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=D2uDkKIO
Subject: Re: [Intel-wired-lan] [PATCH net-next] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 11 Oct 2023 14:25:55 +0900 takeru hayasaka wrote:
> > Regarding the patch - you are only adding flow types, not a new field
> > (which are defined as RXH_*). If we want to hash on an extra field,
> > I think we need to specify that field as well?  
> 
> I've been really struggling with this...
> When I read the Intel ICE documentation, it suggests that in RSS, TEID
> can be an additional input.
> However, I couldn't think of a reason not to include TEID when
> enabling RSS for GTP cases.
> 
> https://www.intel.com/content/www/us/en/content-details/617015/intel-ethernet-controller-e810-dynamic-device-personalization-ddp-technology-guide.html
> (cf. Table 8. Patterns and Input Sets for iavf RSS)
> 
> However, for Flow Director, it's clear that you'd want to include the
> TEID field. But since I found that someone from Intel has already
> configured it to use TEID with Flow Director, I thought maybe we don't
> need to add the TEID parameter for now.
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210126065206.137422-1-haiyue.wang@intel.com/
> 
> If we want to include something other than TEID (e.g., QFI) in Flow
> Director, I think it would be better to prepare a new field.

I think we should expose TEID as a field. It's easier to understand 
the API if fields are all listed, and not implied by the flow hash.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
