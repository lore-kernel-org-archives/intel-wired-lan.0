Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352D606A323
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=b5CsfP0H;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLv8RI8T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 312C680D7F;
	Sun,  8 Nov 2026 17:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4uxUFeqTSk9x; Sun,  8 Nov 2026 17:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 928B080D88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794158901;
	b=CRAWtL9xgnc0DZR8kPMAsg3Tri72snBZpbnl4mzW28qr/xWecUn3uRCOUX8aIPqva2mI
	 4UCftdPZRzKaQvmLyN5diFgBEiZeNGWuBWXqUBCOyo+JD+12GTvip9lh2Di9c10FSpHXq
	 rJqNPmgYJjDTycsLbgMWQz5t4F+2ewzPeuuElDgVQOFGZMiopHD6gY1ADraygwx51LRS1
	 WuEg2IxKZXBXQULboEjcNOM1veveZ686G5U7OyV0zSDpmYzWlnHENJA+NV6x6V2CMRhHS
	 m0uz+NSYLWZXE+ZhKOL4KA6WlYEbcTHMa5JhVI4Gma+F0uAk8i1E3d0MrSMCCxA/nyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794158901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KSXUWRx0EDguLxJ+F0RcWQ7qU373XM5KCoNfJLe1Qho=;
	b=K5LllTExsIHsVabglxl9AONkfZgtRQxBVdWqJqdAHqqoy0D4cji3BkojiQEotDVdIrOR
	 C1gTAPlWPq18qHziJ2NAGr85TcwsrQ24nNGJBoEntIEj00BT+SmWqveQmRxbm1d5HOaS+
	 C/BYumxeaVWKKEbEw8tDrSU5r9aZAuW9WwnrDXOaFcbEt+dfXgLdBtbRYSM3dHeVtgGy6
	 p2n9KV2xLDGdgrtahglAbuV39hIgK9WbFIcuwpurC1Jmz4+vpLpmoKGm4iB1Xx/BszVaR
	 Gj+kKM8GDjuJfq9jTzHmA40nV6ffu2/dQnw0a61R8a3np7bLLN8kus0ZcI8OakLQZeA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794158901;
	bh=KSXUWRx0EDguLxJ+F0RcWQ7qU373XM5KCoNfJLe1Qho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b5CsfP0HoDZuI/k9CRkccZ9WSvon4R29IRlGg/eeOhxnifbxHapKTOqrJsDa/COm8
	 svLoxso44P4Q43L0m4rAh8Nw8QmP5FH3cG2eWy4jLlSXQP140nXIjz3G14ohbQcf72
	 8iNmfDUSj9ENRrOvZIohv5Z6jglrxY296OZwAclqRzxwu7gkn1SWHuYNoZdGR83z59
	 aucMzF8ksJK1pIFIg/ESJH5fOC8EPI96XfH43BOrRSRfz0bZni8BDGbFAfKMPQRdoi
	 OTbm9ymZKQ77KMnXnITdSDbuOAeLgQ159oeUJ+oNFYNpCIODpMZJBZXPtoh1gbfRIc
	 X8ScIXNfI55NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 928B080D88;
	Sun,  8 Nov 2026 17:28:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B97CD2AC
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 17:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAF666061D
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 17:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBwhPHgkuPgB for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 17:28:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD85B605E3
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CLv8RI8T
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD85B605E3
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 17:28:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E54E611CC;
 Sun,  8 Nov 2026 17:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D9D1F0089F;
 Sun,  8 Nov 2026 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794158898;
 bh=KSXUWRx0EDguLxJ+F0RcWQ7qU373XM5KCoNfJLe1Qho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CLv8RI8TF0gEJYhrgPQJTn7qGYJ0sEzAWjPBOfzEzCguXMFLLI1vEJHa9RvWRRZ9X
 y+76QOKaGeScbUjelNLNOkYQtOIIyjBW8NdEYvsdi4pa2v31NwQKUs5O8HLYmMjE8M
 5By6QobOgMupcmz3mjNS4ivQL8Fv8JvSSc2l0/OzEElFd+LLVsXs2bnGZP5iWdXDT/
 xUY6+AM1d018TFU0N/gP9xAOK9raWAMN/rRqmMGMw667AFxl1XEqs2QSuODufsCQHz
 JAaWJDLfdMz1P7rouigVPJtHXCY1T68G1NiGvUE6itCYeryE7mgP+Y/jLunSnmPshy
 WR6lIbshI6uTw==
Date: Sun, 8 Nov 2026 17:28:13 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Message-ID: <20261108172813.GI18859@horms.kernel.org>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
 <179405014554.994134.10719290719575125531@kernel.org>
 <20261108172504.GH18859@horms.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108172504.GH18859@horms.kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 05:25:04PM +0000, Simon Horman wrote:
> On Sat, Nov 07, 2026 at 11:15:45AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [Medium] This patch fixes the SA reference leak in only one of the two
> >   copies of this Rx code.
> 
> I lean towards this being a pre-existing issue that can be handled
> separately from this patch. But I do note that taken at face-value
> it severely impacts the reliability of the  teardown path and the
> usefulness of this patch in practice.

Sorry! I responded to the wrong patch.

The correct response to the issue above is that yes, that is true,
but the requested patch has been posted already. It should have been
part of this patch-set. And the author should keep that in mind for
future patches.

> 
> > 
> > Pre-existing issues:
> > - [High] ixgbe_ipsec_del_sa() unlinks the rx_sa from the RCU hash table
> >   with hash_del_rcu(&rsa->hlist) (line 783) and then zeroes the same…
> > - [High] ixgbe_ipsec_find_rx_state() finds rsa->xs only under
> >   rcu_read_lock() and takes its reference with xfrm_state_hold(), which…
> > 
> > --
> 
> ...
