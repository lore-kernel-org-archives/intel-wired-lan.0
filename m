Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86179C27C4F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Jun 2024 15:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 285B880C2E;
	Sat, 15 Jun 2024 15:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9x0kw9JriNb; Sat, 15 Jun 2024 15:16:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96E1281308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718464609;
	bh=k6+SnTKbUusEIF0rwEEMPmfFP7oS1BI7RELTSyI4xuk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Tl+vgkvKkZIOKBIW1G5PwtLwjmeHhHt67SZI6au2sbxVsFPvqJ107l5ZlEoWxeD9S
	 3ztmZlBNXbi1hOczxi8M5i8Yr26l2WRi0GbtBrwxHzZc+X0RsZ9byBEa1Mkk5dhSEB
	 PZjZXIUKJ3HwgF959ReC0TN0K4SDml4YYNXj42/z613kFY52F4NjW7Y5Btk6q+GJGB
	 MQ/dEvwvWgV+zkjRrBLlfhsZw96d+xixKdV+KLV6qA6Ujj/GfJFsC/fZWVqDjsc/jC
	 sQZEavFuxaBCKNGRIWvljWK78cCptCkxfPslhv8NiBdaX8KiqLP57DxqQboB7BcEMa
	 LQB+Bk5Gv4VDw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96E1281308;
	Sat, 15 Jun 2024 15:16:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 85A981BF301
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Jun 2024 15:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F35360659
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Jun 2024 15:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZWwI_iGHMTDH for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Jun 2024 15:16:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D913F605CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D913F605CB
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D913F605CB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Jun 2024 15:16:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0BEF860472;
 Sat, 15 Jun 2024 15:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39B0C116B1;
 Sat, 15 Jun 2024 15:16:43 +0000 (UTC)
Date: Sat, 15 Jun 2024 16:16:41 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Message-ID: <20240615151641.GG8447@kernel.org>
References: <20240614094338.467052-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614094338.467052-1-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718464606;
 bh=40Wj6XVGNuJpJuinT1FRLIVr94RxlZv+LTy0tHJIxw8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oITqWQkLtoirbzPziEOi8v1w2dJiXHu+NmH1id2OgsJQkJu21MBaSc/z1dJFdFzs2
 x6jiFctC069hir6E/AtWT/rgAA+qP7/M+PmvgUh4zEAkESVjXTPvWECHcTsN3rpkPK
 Dvp3g+rO4u6JhEjvVbffH/bWbylm45AVTHRRuD+a9k2n/XcweJSQJFkrc4DcVXatSA
 w5aaGFOm2SHa2U9qNa/YsqiSMn/x8zkHl9MnFe1r4oERx3YAqub5LgFP3K7m6CjP1b
 4xbguxZnP1O9UTmBMBl2+6fPm63hqJzVedAsBtjt5HZEQhI0nLXo5K+/e3tzH5/IYg
 CDAKXPm2TzyIA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oITqWQkL
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: use proper macro for
 testing bit
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
Cc: ivecera@redhat.com, netdev@vger.kernel.org,
 Marcin Domagala <marcinx.domagala@intel.com>,
 Konrad Knitter <konrad.knitter@intel.com>, Eric Dumazet <edumazet@google.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Jun 14, 2024 at 11:43:38AM +0200, Petr Oros wrote:
> Do not use _test_bit() macro for testing bit. The proper macro for this
> is one without underline.

Hi Petr,

it might be nice to include a brief explanation as to
why test_bit() is correct.

> 
> Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
> Signed-off-by: Petr Oros <poros@redhat.com>
> Acked-by: Ivan Vecera <ivecera@redhat.com>

...
