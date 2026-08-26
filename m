Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2ADC61DBD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 18:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED8180DD2;
	Wed, 26 Aug 2026 18:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPi382TaUldk; Wed, 26 Aug 2026 18:27:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787768852;
	bh=mOrWrsVxNY4DeKzF4oVpyrcTmPtW8ML65wACYvxEaYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ycTTqpkbu+nDeO1j2h5bzrvLLHaOMzeJ4gJJAxUUwK0x0P/Uj2UsnKpvhEfouu0n7
	 LD+xly/bYg9hoknpKGSmAd0+VkE6x4qJKD59MlXLxppY6qaCKCmtFQdMMySaDb6R0c
	 nt/uJJzEtWq7ZAWEz2X/Z54aQ9z9Gf35eBgKzeyDDmRC+S9hUGl3dCeccQAwteuJXY
	 6JCPySppg9RGQe3KlSoBVJ/svvhXidFWOJR4pIQYmSE14xOaky3A9eYbU6AGg69u2c
	 JjfYvUBBh7Zf0MeJFTxoahCgvFZYmhubW/WVT0Ft19pxtBOxrB/XcW5mzkwGHbcph+
	 BjYamTdeu9++g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E40A80D62;
	Wed, 26 Aug 2026 18:27:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40DA5334
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 18:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26A2780D62
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 18:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8w0MMpDTnkOW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 18:27:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.175.108.22;
 helo=mail-108-mta22.mxroute.com; envelope-from=ripatel@wii.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=wii.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=wii.dev header.i=@wii.dev header.a=rsa-sha256 header.s=x
 header.b=xAgaOhMm
Received: from mail-108-mta22.mxroute.com (mail-108-mta22.mxroute.com
 [136.175.108.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4944C80D3D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 18:27:29 +0000 (UTC)
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta22.mxroute.com (ZoneMTA) with ESMTPSA id 1a03f53b7fe0001089.003
 for <intel-wired-lan@lists.osuosl.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 26 Aug 2026 18:27:26 +0000
X-Zone-Loop: 36d080b2be24d675a4c84c4edf0f6c4e76afaa1651e0
X-Originating-IP: [136.175.111.3]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wii.dev;
 s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc
 :To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mOrWrsVxNY4DeKzF4oVpyrcTmPtW8ML65wACYvxEaYo=; b=xAgaOhMmwZ7SlDvKpdqUk5kn/U
 Er7LKw8sIjIMgSadrb7joPJ4ln5IQ8QZmy947SskB70pIIYIwYMQCCLQqiLNLdkf6Uh9WPjZ8t0sQ
 E06hVcdBsdQHMpt0h4eoNqqF9h+69Cs/tWEgwBBY0NhYbJgZNqtdL5igkd49KMVySG0RpMw+xdThS
 mLOnwBm5aCVNSxhX1ZeC632sRj+BYCRDdXZVBUKGgdgtsiBELODKTNWqW167zSfD+Rssz/dgbj2vd
 JGpOFTGnDqVaeWm6+fCXqSbDznusZwlf6W0ltLx3NysG1ik1w24g4w6DlF2YL53ZYvf78CKhbsjvg
 MCMyredQ==;
Date: Wed, 26 Aug 2026 18:27:04 +0000
From: Richard Patel <ripatel@wii.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ixgbe: fix MDIO bus leak when rejecting SFP module
Message-ID: <ao8v+E27nWRW7g7V@wii.dev>
References: <20260826042945.2344686-1-ripatel@wii.dev>
 <87e4aa92-4687-4fbf-b632-9493932c349f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e4aa92-4687-4fbf-b632-9493932c349f@lunn.ch>
X-Authenticated-Id: ripatel@wii.dev
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

On Wed, Aug 26, 2026 at 02:23:25PM +0200, Andrew Lunn wrote:
> On Wed, Aug 26, 2026 at 04:29:45AM +0000, Richard Patel wrote:
> > This code path failed to unregister an MDIO bus owned by that
> > netdev, so when unregister_netdev() tries to tear it down
> > (via device_del() -> devres_release_all() -> mdiobus_free()),
> > it trips over the leaked registration.
> 
> Maybe look at using devm_mdiobus_register()?

oh nice. Will submit a V2 tomorrow with that instead, thanks.

	Richard
