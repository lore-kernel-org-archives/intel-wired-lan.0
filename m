Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25E606A32C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2yDlyfGc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+KjG8aS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A75A9811AA;
	Tue, 17 Nov 2026 14:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8KpRjUezPEG; Tue, 17 Nov 2026 14:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C19A881192
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927565;
	b=O5LLFqpvhxtLteDgY7AZw6YXDTzfBdY3KCiA5boKb+Bo7Z51RKv4J4cCoPv5CO4sXXd0
	 1yhTK/IKark2RnFFGCI7x4VlQ8Rl6nS2m5pPWd1bfIBzRlX03G0xqdbgljYdkrd0uABwJ
	 33KpJ4i+9EP3gZGTxvhHp6k5TnAWKeVGFRj5tPrDOWoY30szNp0tKsCnKk+pOo2vlmSHE
	 DSp58fzmKwSz0jCCD2PL3vnoc8SnSxoqs4ZVbAPrx23SQilHaftZXadDwY3zYXDA2FXDg
	 jhHEOw6ghsevC0w7hqDgPsNxKtp+KX6sn6mpoZ6gwJCWkaadPSfZ13AeIKMy51mILjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bVZRjmHTBiiRqHSDXN7xu58H7nbEzh4cn3nVg+rSD1w=;
	b=jvBx3/3IXXW7iwgRpEOhout93kuSDxHdPEUAKrzUbnn+J6b/3FuwLW/m8FevuLOY0WNt
	 xX91Y8WHz78PMGU6vgldp03Xv7m0TRoRCz6lGSkUuM8jgG+J9CiJX24p0PJRBqKNq8FYA
	 6zy2miWp7E81gfHnNrPwIYOb/7+9q8tUewaeTbq6ilbqXEL91xpGImHkRFHF1cKMWS5Ad
	 R3AnTXczI2rdDoh6xhfS3L+t5KFky2We2fA67ebZqENyofgZj7U/I2/F59E+DuwwO4Sl0
	 bwyF0O+VE7A4ZWoue2pitp60ovCuHdsT06V8a4LNPJj2tX/WX8qklqvSGm92RG9Vs5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794927565;
	bh=bVZRjmHTBiiRqHSDXN7xu58H7nbEzh4cn3nVg+rSD1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2yDlyfGcwzQDwqDX+bzvDUvRlupVe5/Md5YJZvHpBDxThYdmf7rPzLt9E2U+G8x/3
	 KX/znDhzvZ3V6+aSFYsA6XgA7Ai1acTvGbccScaPuEGzklSHifjr1AbykwEXBFRqmh
	 TkWWh1w/oU/Kw9MucAY6wr5A0HZ3tvOghb567UzdIqweDzt4vdddnCgNmnsFttpusV
	 EHyu5ndYPX5D9JaeLIKXCkSecxbjtXi2AJ5h2AcXJLN2BIEz6ohVu4vwMC4/Ar/g8x
	 FK4jibRm9DbcKfFDzJh2Jswa0XJ3YFOghYPPbjqN+wt9PY5Nzdd4ECQCtSeNmpSGVQ
	 sIn8cwRgaKsOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C19A881192;
	Tue, 17 Nov 2026 14:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1362249B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAC9140822
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id td5KyUbO1qYr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 14:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 087274078E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=leon@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a+KjG8aS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 087274078E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 14:59:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25534419DB;
 Tue, 17 Nov 2026 14:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E6C1F000C5;
 Tue, 17 Nov 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927563;
 bh=bVZRjmHTBiiRqHSDXN7xu58H7nbEzh4cn3nVg+rSD1w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a+KjG8aSwS76s40qC/TiUL0lxGAZVkvE/chrm7qqANN4BlXadBB94j297CUXcJt7g
 wNbAFRV5ysQuBjNAwTG1BXGryBpnsNdVy4ztxK/8uL6Uq1gSIzEw5P8vxjR4ZFwrAb
 u7koq9xMF6YuYVQnTYAXFVoBvKfzquw6Bk8mpwqqMUVLk3/PgKapyrp1a084iBPqK2
 m/UWiUr91MC37l0aSdrlAk06GcuVZ5VftHF2V5x2cIeQLXS8D2WUvnuzF3QVYziflQ
 Agl4EMIgfBnQI4LkHuzDzJKSx6xtfDbNFbHCWqTVIl+ZtFI/xR2T1q5+mhVcQUwtgL
 o+vVJrYOsMKcQ==
Date: Tue, 17 Nov 2026 16:59:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Petr Oros <poros@redhat.com>, intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH iwl-net v3 1/4] ice: check the auxiliary device pointer
 under adev_mutex
Message-ID: <20261117145917.GB162713@unreal>
References: <20261113161453.1234851-1-poros@redhat.com>
 <20261113161453.1234851-2-poros@redhat.com>
 <afffea49-0a9e-4598-a6c5-ec8d8fa7bd5c@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afffea49-0a9e-4598-a6c5-ec8d8fa7bd5c@intel.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:48:10PM +0100, Przemek Kitszel wrote:
> On 11/13/26 5:14 PM, Petr Oros wrote:
> > ice_set_channels() and the mqprio path of ice_setup_tc() test
> > cdev->adev before taking pf->adev_mutex and dereference it afterwards.
> > ice_unplug_aux_dev() clears the pointer under the mutex from the
> > service task, from ice_prepare_for_reset() and from the devlink RoCE
> > and iWARP parameter handlers, none of which hold the RTNL lock, so the
> > pointer can go away between the test and the device_lock() call.
> > 
> > Take pf->adev_mutex first and test the pointer under it. Without a
> > device the mutex is released again and the rebuild runs unlocked as
> > before.
> > 
> > Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues while RDMA active")
> > Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Petr Oros <poros@redhat.com>
> > ---
> > v3:
> > - rebased, Reviewed-by from Aleksandr
> > 
> > v2: https://lore.kernel.org/all/20261023070258.730168-2-poros@redhat.com/
> > ---
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 +++++++++++++-------
> >   drivers/net/ethernet/intel/ice/ice_main.c    | 22 +++++++++++++-------
> >   2 files changed, 28 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index 35dff5e937402d..910664b35b4d35 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -3888,6 +3888,7 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
> >   static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
> >   {
> >   	struct ice_netdev_priv *np = netdev_priv(dev);
> > +	struct auxiliary_device *adev = NULL;
> >   	struct ice_vsi *vsi = np->vsi;
> >   	struct ice_pf *pf = vsi->back;
> >   	int new_rx = 0, new_tx = 0;
> > @@ -3943,14 +3944,19 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
> >   		return -EINVAL;
> >   	}
> > -	if (pf->cdev_info && pf->cdev_info->adev) {
> > +	if (pf->cdev_info) {
> >   		mutex_lock(&pf->adev_mutex);
> 
> a small problem (less critical part of the last Medium issue raported by
> Sashiko for the next patch) is that pf->cdev_info is changing while not
> protected by adev_mutex, here we accidentally re-read it (instead of
> keeping a variable), but overall it is a bad smell, would be nice to
> have a wrapper that takes both locks, and only after the success callers
> will deref the protected stuff
> 
> otherwise a pretty nice change! thank you for your continued effort!
> 
> > -		device_lock(&pf->cdev_info->adev->dev);
> > -		locked = true;
> > -		if (pf->cdev_info->adev->dev.driver) {
> > -			netdev_err(dev, "Cannot change channels when RDMA is active\n");
> > -			ret = -EBUSY;
> > -			goto adev_unlock;
> > +		adev = pf->cdev_info->adev;
> > +		if (adev) {
> > +			device_lock(&adev->dev);
> > +			locked = true;
> > +			if (adev->dev.driver) {

This is the wrong way to check whether a driver is bound, use
device_is_bound().

Thanks
