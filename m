Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A22C7619A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Apr 2023 18:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD64B41F19;
	Wed, 12 Apr 2023 18:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD64B41F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681323955;
	bh=CE7Kn+UTCId50HfPZTXVDjDqALjKcWc7cdCE6GX5Tqw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=eKQMRik7plmh152zRmveA4zfSqC52ym4zpz62OlwMnCguVbq4odqUm9IJdw3twPi8
	 BaaFaV0ebumipXq1HWj6awivG2vB5kvOpVuZBBqFxnqzGg6Tf1PH8ZEMfuAsWRXlsY
	 T0IbTy6ll0LSX7xvSVbZza2OzdBGHHEumK7w/LVYpd9iy41lR0iubD1EZVSAhH7YYF
	 OY4TuHAumqRjm3Kse1YDE16RbA0StHVQ/jTj4x4A/6ODhHbVlbgeQxZICpYuLDlYyH
	 LfTMFaArwgO1QxnX2suZb6NeOKBTB6gNoqng7BWAObTy2pOD2X1gbn0k8VCRqeMD08
	 7NBgFBuGESIQw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dyZZjwes9Bta; Wed, 12 Apr 2023 18:25:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C68E141F1B;
	Wed, 12 Apr 2023 18:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C68E141F1B
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 5DBCC1BF3ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Apr 2023 18:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4049C41F1B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Apr 2023 18:25:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4049C41F1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jAyHZ_QY6P73 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Apr 2023 18:25:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80A1241F19
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80A1241F19
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Apr 2023 18:25:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C2A8F6332A;
 Wed, 12 Apr 2023 18:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1511BC433D2;
 Wed, 12 Apr 2023 18:25:50 +0000 (UTC)
Date: Wed, 12 Apr 2023 14:25:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Message-ID: <ZDb3rBo8iOlTzKRd@sashalap>
References: <20230411011354.2619359-1-pavan.kumar.linga@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230411011354.2619359-1-pavan.kumar.linga@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1681323950;
 bh=UEarsG8+t9h8x0NcSx6SKLQ286Rdbp1kW501IH/u5Pg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rw4r1bjxez4sjgEz2qfJ95KECPAbSZMIMUDps6w/OLDVxTk97Jbt8JZLR+Ri2SKju
 CcGaAkOI5FiwRA5saOEyQrYL7e0WlUGxUgwcML4TtSzTtzDGqYOUm6XgG+v6vFuIum
 PCr3asMuYdcTivtfnSnLXyYCIr2Xbp6b0uEGOQyUaZT0fuJ8vkQyZ6fv07z2S1L22+
 BORMVhWeEGkF24zCaXvdDoYRxzNlmaxy5Bl09+U/JT0yTdTPGiONWSgvAclAZ2GryA
 IWk5uZJWJzVlRlxhl9bB4vGWKe5rTejFh1HwY1MbX6IJZzWEk5D8QxL0XCpMZsIjk/
 +hxcpgMfoVfoA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Rw4r1bjx
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 00/15] Introduce Intel
 IDPF driver
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
Cc: willemb@google.com, decot@google.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 pabeni@redhat.com, davem@davemloft.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Apr 10, 2023 at 06:13:39PM -0700, Pavan Kumar Linga wrote:
>v1 --> v2: link [1]
> * removed the OASIS reference in the commit message to make it clear
>   that this is an Intel vendor specific driver

How will this work when the OASIS driver is ready down the road?

We'll end up with two "idpf" drivers, where one will work with hardware
that is not fully spec compliant using this Intel driver, and everything
else will use the OASIS driver?

Does Intel plan to remove this driver when the OASIS one lands?

At the very least, having two "idpf" drivers will be very confusing.

-- 
Thanks,
Sasha
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
