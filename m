Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0DDC79F9E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 12:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7DEC80865;
	Tue,  8 Sep 2026 12:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9WTgTPDDAfy; Tue,  8 Sep 2026 12:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 26B7F80A47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788870054;
	b=OQJEgaOhDz3Rb2GmB2I14nIQ6RF5wyjnMWv4hbQM8JgmZ69uQ2FDoaA3bs9BT2OkpukR
	 FtpO/JiWVLxrkUdwgDyuvg7dmtJuAzwpcQtgnqEZJlL0uUldfj5uBr7jWjIMiUMo84idc
	 fqx+vvHRevj7ER0oJWRmM488rRKBIQ1ivBZ86dWH2paslDIfa3wDqFI4dmAEAXXPVhZgj
	 LqHZjk7rPIXQGJcNRdsoobhaPDzA2r8GBCpC71FaOq3NnQMO68qNJEDUYuvLDVhsgl50f
	 FsEwd+9+nNq2uJjnBHmIRcACmoKqEUxw7i7coUiBvAnzzwk5cWKyoDw+dLUGzP1/KfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788870054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cWvpOXyjjZrhIetQiwdMhEUgIE2tbl5vXLToXqUCVRc=;
	b=H5oECE4rXIXXXu2Wpe5vm2txRmvusxsLl+1oAw/YqVRx26v3A9MJdtlBsez4H975jGMB
	 QJWq/AcQHxNMakk9NpH99IPyF5I6I/chaQza+O2PagZFqKLeJKs0G9cpzGPqQIYHBfiAJ
	 HB53S5ufw2lI4gGeKDNq2cn/ITb0zTk6b/t4l79+Hg3eSGfANnal58IXaJzon9qoXHPUS
	 GbM54GWeFi5WhoudsnUINiJ4WDWD0ljVwHCE0f/de+sXETzDIWHQVxLFGfcQUfNmhPCM1
	 M86QGd9daX/O5oI7U3PVeYQeN2F+kqcKROs03hhLWdbrDL746Q6z4mxPej/dZ3ZsZgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788870054;
	bh=cWvpOXyjjZrhIetQiwdMhEUgIE2tbl5vXLToXqUCVRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xt15ZPRG9HKC4MmIGUNUlC3LAxNhplvTfOEfwEemeQE0zCHYDvwqd8Y8TR30tDY95
	 bVwdNZmkn0NMQS2k4eXU/sfuQJ9XapMjP8pUoIeEEsSM0RGgYchip1ZH30iwBdGydD
	 Yr7H9g6R0lVZIvBK2h/GhC5zJryXPvF4JSkde2qKOcpKlbR0nP+8JHvI0A3tn+KCq7
	 pbjEwwsXycEC6NzNLr5q8WKjzS07dTgPjL/Zf71BDGjds66ynha2TG8mAUWThhymrS
	 sEJCbXJbC7Sfx7asUtLN4gK60aYh+VhibP6ySuEdl+DRliZ/6r2menhQBU2K3rfd+O
	 HwVdtIPawnwvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26B7F80A47;
	Tue,  8 Sep 2026 12:20:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 25F48990
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 12:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A613606F2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 12:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3c2KbPlliUy for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 12:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3EE6A605C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788870052;
 b=hzev7tHfxCuOS6K/vg5/PyPikDsBtq4shhcl0WL1FKPfzwBnHsE45VP0dBiwOk4nNBKj
 /q/ySGJWPmrkUiqGUrErW0jvEMSYvkAqRwZnijn7B55CPFzo6623FfQHf9TDsfxfrHZqs
 2myxaL78nKP00nLgvttU8ikWeLVLeVlYdLAOqCOxfA+Q8rcy63YR6jNzJsoyxCCieJ30Z
 6tVA0RnumWgxrqZUL99T2rRm0Obr9AKr+Q5/eh2RJHy46j8rJbaMugsGA6WFx8Z9qSUAT
 pE0jIgSlV9uBTI3xY/OAHkXlh8odNbG0uyXb53OxFk86CnePOqk+KZOkXO6A5FgJFtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788870052;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=cWvpOXyjjZrhIetQiwdMhEUgIE2tbl5vXLToXqUCVRc=;
 b=BeM5qiqK9tniw4DxKVNB0PoKmRZbw9t8OY6nFiFZp0BskZZiewvrj1cy0HlT2BDvP7V6
 9rTRJL44w1jxCUEcQHPxI6k1XUaSBf6SLy2TEJmt6ZsRAQsz13lJNlG+9hqOu0KrVjahW
 4ayihsG6tt6hbkmf37mBqOcJebID43Ux/VKn9v5y3JXYPupPFYKowwYuKnvBv0yORc9wV
 gNdPRMU5WUjuwM+xllMshkn9Rv0sEMwD3wsEwlZMFvwv60MXesTxB4r5Qsa2eHO52RhKw
 yqsH2i2/ynVvNiiIWtqlErIK4sffSW12ZVVeYC/zLx6we61a7rNmuwbyZIDD1FTjokg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IXZG2LvN; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IXZG2LvN
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EE6A605C7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 12:20:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9A8A4086C;
 Tue,  8 Sep 2026 12:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3981F00A3D;
 Tue,  8 Sep 2026 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788870049;
 bh=cWvpOXyjjZrhIetQiwdMhEUgIE2tbl5vXLToXqUCVRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IXZG2LvNeocHOQVTxDTDAErRRrlRN46C/5PV2WAfWlyj+j9UYwNHXgxJKiCySZNNo
 O7CrFoUhVsyWJaqaucuMC98xswl6QO8zmMCmPRUv7eqbeggKimmI9KLX0WpYAu1t6L
 AEjHsU8BOvOi+RBoMnV1dmdtc0PtKvprENYzIR0ojalB3HF8ZtrVXuYRNE8iJaL2MU
 r9WYetbK8pfI6DJW//4YUJJsEf3j33XoQyrUxe7anWtUBhdVyE5S0Pwb3EaFyCU18k
 YwnAlCn0QZaqBORJYmKp/xapXUnu/2OuLju/oY+jqhQxvy4A++SyXtun+M00QD9JAC
 zbv7ilSwlLqmA==
Date: Tue, 8 Sep 2026 13:20:45 +0100
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Message-ID: <20260908122045.GV40544@horms.kernel.org>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
 <20260905183245.GD40544@horms.kernel.org> <apyrTFlAsrifzqzB@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apyrTFlAsrifzqzB@yury>
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

On Sat, Sep 05, 2026 at 07:52:44PM -0400, Yury Norov wrote:
> On Sat, Sep 05, 2026 at 07:32:45PM +0100, Simon Horman wrote:
> > On Thu, Sep 03, 2026 at 09:20:36AM -0400, Yury Norov wrote:
> > > The function has 3 callers, all except one explicitly require
> > > pf != NULL. Add the corresponding check to the remaining caller,
> > > and remove it from the ice_pf_state_is_nominal(). It makse the
> > > fun function a one-liner.
> > > 
> > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> > >  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
> > >  2 files changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > index 73996e3022ef..6d5b8acc4764 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
> > >   */
> > >  bool ice_pf_state_is_nominal(struct ice_pf *pf)
> > >  {
> > > -	if (!pf)
> > > -		return false;
> > > -
> > >  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> > >  }
> > >  
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index d88835482d3a..168d85f9477f 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
> > >  
> > >  	pf = pci_get_drvdata(pdev);
> > >  
> > > -	if (!ice_pf_state_is_nominal(pf)) {
> > > +	if (!pf || !ice_pf_state_is_nominal(pf)) {
> > >  		dev_err(dev, "Device is not ready, no need to suspend it\n");
> > >  		return -EBUSY;
> > >  	}
> > 
> > Is the new condition necessary in ice_suspend?
> 
> IDK. I'm just trying to stay on the safe side. The
> ice_pf_state_is_nominal() was safe against pf == NULL,
> so I'm trying to preserve the invariant.
> 
> If it's impossible, I can do:
> 
>         if (WARN_ON(!pf) || !ice_pf_state_is_nominal(pf)) 
> 
> This would imply unlikely(), and more verbose than an implied
> assumption that pf is never uninitialized.

Let's stick with what you've got.

Reviewed-by: Simon Horman <horms@kernel.org>

