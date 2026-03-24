Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB90FEC119
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ED4B412EF;
	Tue, 24 Mar 2026 21:21:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IA2HLT5zNwR1; Tue, 24 Mar 2026 21:21:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E609C410C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774387280;
	bh=HC6UnGTha55WhSG2IaiLgrKfIV4tJkaDLEE3yoCmMtw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wHBQehqNubx7+j7Va82QT3Oakg/Jifa/n6foWVuF9lsjwtqY0T3dZes2ONX2jF4H2
	 hkKSdww0Ppa6B4AlC66MGwWOBSKbBrYdQuhi4M1SjoHhHJ+0J1Dm+OdO0wexUSUIQk
	 s5YWwXkzKroLMw8KVchJcl620nW3MhRYdywDe08bJ3Ibz5QVFhJRMNNTIroaX3Fdz/
	 /k3xIRHsJNDLVEM7KZGIjUZJ7/ro49+pflfZwxxNKIKKgfm4k/EappQp+LvFXYTc13
	 RUAUL+C7t1gy2z/b8AEoqeVuqTSe3VnZlMce4730tyHnhseSMaU4XcYmrPBxSk/gL6
	 D5qb/OGVvVqZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E609C410C2;
	Tue, 24 Mar 2026 21:21:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F0FC1D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 21:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34D0E83CF2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 21:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WlJMXBJeHFxv for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Mar 2026 21:21:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 564BF83518
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 564BF83518
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 564BF83518
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 21:21:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C49D600C4;
 Tue, 24 Mar 2026 21:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E9C19424;
 Tue, 24 Mar 2026 21:21:15 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:21:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Message-ID: <20260324142114.216fcb01@kernel.org>
In-Reply-To: <acLUMN1BYkIVyOk8@mini-arch>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org> <acLUMN1BYkIVyOk8@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774387276;
 bh=bN+zpILDmRdAJyoSgSd6M94WASWO6vtvLneiqPi/Tak=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GPxpDeHTRLLHKaMrMRhB7HRNMR0vz+D407bx9zvLOnTJbqqZwfjcVWSbRqeltmaXk
 U/jc0OvHw29QxROpi7/KR2iQfy/gTs99qOAsWHMNeSNW7mXTytQfOeJ0JePeYl8+9Y
 GCQH2vtDTDe2fFdbFORXB7fmH9UwxKQz+2+rkstQ76DtCwx8tGXeTwO6ll7Vhv3WP/
 PiD5yKwuyY3uLecx7KaywivjQshWNbFzJTYidBNzpT0X1/j9v+mpkubUwomd5VxAyV
 i1ek+xmL0NpeY5k6srstmCNWYqifsJse7cXPJHy5VEo72hxrqBILALL0I1HJo7XGsI
 esc9q6V430cAQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GPxpDeHT
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
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

On Tue, 24 Mar 2026 11:13:04 -0700 Stanislav Fomichev wrote:
> > > +		netif_addr_lock_bh(dev);
> > > +
> > > +		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
> > > +					      dev->addr_len);
> > > +		if (!err)
> > > +			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
> > > +						      dev->addr_len);
> > > +		if (!err)
> > > +			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
> > > +						      dev->addr_len);
> > > +		if (!err)
> > > +			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> > > +						      dev->addr_len);  
> > 
> > This doesn't get slow with a few thousands of addresses?  
> 
> I can add kunit benchmark and attach the output? Although not sure where
> to go from that. The alternative to this is allocating an array of entries.
> I started with that initially but __hw_addr_sync_dev wants to kfree the
> individual entries and I decided not to have a separate helpers to
> manage the snapshots.

Let's see what the benchmark says. Hopefully it's fast enough and 
we don't have to worry. Is keeping these lists around between the
invocations of the work tricky?

> > Can we give the work a reference on the netdev (at init time) and
> > cancel + release it here instead of flushing / waiting?  
> 
> Not sure why cancel+release, maybe you're thinking about the unregister
> path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> extras.
> 
> And the flush is here to plumb the addresses to the real devices
> before we return to the callers. Mostly because of the following
> things we have in the tests:
> 
> # TEST: team cleanup mode lacp                                        [FAIL]
> #       macvlan unicast address not found on a slave
> 
> Can you explain a bit more on the suggestion?

Oh, I thought it's here for unregister! Feels like it'd be cleaner to
add the flush in dev_*c_add() and friends? How hard would it be to
identify the callers in atomic context?

> > >  	/* Wait for rcu callbacks to finish before next phase */
> > >  	if (!list_empty(&list))
> > >  		rcu_barrier();
> > > @@ -12099,6 +12173,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> > >  #endif
> > >  
> > >  	mutex_init(&dev->lock);
> > > +	INIT_WORK(&dev->rx_mode_work, dev_rx_mode_work);
> > >  
> > >  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > >  	setup(dev);
> > > @@ -12203,6 +12278,8 @@ void free_netdev(struct net_device *dev)
> > >  
> > >  	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
> > >  
> > > +	cancel_work_sync(&dev->rx_mode_work);  
> > 
> > Should never happen so maybe wrap it in a WARN ?  
> 
> Or maybe just flush_workqueue here as well? To signal the intent that we
> are mostly waiting for the wq entry to be unused to be able to kfree it?
> 

