Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83120C25B76
	for <intel-wired-lan@archiver.kernel.org>; Sat,  1 Jun 2024 12:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 178B560820;
	Sat,  1 Jun 2024 12:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cN7AbfSPYXDd; Sat,  1 Jun 2024 12:06:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FF4B60720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717243612;
	bh=sDBdQ3N3Cu0FEIs5zYbsvCkBxZeRfNvSatcfI8fql7A=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qCT5HTAnYrtcbTGT6OPNEDRoblk9wjc3OaPuVZQe8ArhfRhhgR3fD98UMFmrGkdq6
	 29cVB5AzGdtrha6eBOupu7l0Wmd5apHytB6IZ8M06vBX5pM0LbQSHviX6XHg5YklSg
	 Xn5xvXo4e4vpsctBJa3xZdVfrOhF5Vy3XOgNNXLcnPoYnVQTfYCJYIAdlF9bRA6rNJ
	 P9N1rg8GAqxNpCAhcRMWP2lfUQP0Gmj31JQ6UVNwAowaDzv6GsWjweum6v25FLyt1h
	 UAJ39Kv5gyidgwQLn4l9A5kqgW++6pRaoqd00Txw6aV1HsS3gD2RQAOXgnpggtBrLW
	 eDQOwsnnC6o4w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FF4B60720;
	Sat,  1 Jun 2024 12:06:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7DBD61BF2CD
 for <intel-wired-lan@lists.osuosl.org>; Sat,  1 Jun 2024 12:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69CCA60720
 for <intel-wired-lan@lists.osuosl.org>; Sat,  1 Jun 2024 12:06:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cO4CQkENtX8S for <intel-wired-lan@lists.osuosl.org>;
 Sat,  1 Jun 2024 12:06:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A1710606EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1710606EB
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1710606EB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  1 Jun 2024 12:06:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6C9C1CE0977;
 Sat,  1 Jun 2024 12:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED9C116B1;
 Sat,  1 Jun 2024 12:06:43 +0000 (UTC)
Date: Sat, 1 Jun 2024 13:06:41 +0100
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <20240601120641.GH491852@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-12-ahmed.zaki@intel.com>
 <20240531131802.GG123401@kernel.org>
 <f2cf6650-a164-4d3c-a3d9-cc57c66069a5@intel.com>
 <CO1PR11MB50893931EC0BE4F79FA46761D6FD2@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO1PR11MB50893931EC0BE4F79FA46761D6FD2@CO1PR11MB5089.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717243605;
 bh=p5Sw3GRe1Lge4SnF2pmAC4IQ0ato2xmCd88hFsuZff8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ILjt9RouX1ucqRipERDIi+L/u5HdPvHVds7Ws10gho3vykMKgAg3HbaYTVcKm/PaW
 7c3PQePyZi24BoY0mqWrphT1ZP7wBlS24+9NU9kXI0+13wrKKOPo/rZnhWifG9Cu6I
 SMomQxlUTdXhDkrEl0SnCXiiOVyfW69RQCf03Ne8hSMvuk2BmAAKTICn2t77a4IjSz
 UTaYleqf0RwHNvZViknzYuUejkBw0jbYpcs8Nwcow8xzHRfsbmi5mVrMbnwFu8tM7N
 z4TzPON4rzXbgA8NUE7TvUiVDrl5gD5LG7jp5PqKrLXBJxciJeTn+FeRe+IfQJXCU/
 tXKxznl4dh8AQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ILjt9Rou
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 11/13] ice: enable FDIR
 filters from raw binary patterns for VFs
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaki,
 Ahmed" <ahmed.zaki@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Guo,
 Junfeng" <junfeng.guo@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, Jun 01, 2024 at 12:24:14AM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Zaki, Ahmed <ahmed.zaki@intel.com>
> > Sent: Friday, May 31, 2024 8:48 AM
> > To: Simon Horman <horms@kernel.org>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> > Guo, Junfeng <junfeng.guo@intel.com>; Marcin Szycik
> > <marcin.szycik@linux.intel.com>
> > Subject: Re: [PATCH iwl-next v2 11/13] ice: enable FDIR filters from raw binary
> > patterns for VFs
> > 
> > 
> > 
> > On 2024-05-31 7:18 a.m., Simon Horman wrote:
> > > On Mon, May 27, 2024 at 12:58:08PM -0600, Ahmed Zaki wrote:
> > >> From: Junfeng Guo <junfeng.guo@intel.com>
> > >
> > > To me tweaking the order of includes seems to indicate
> > > that something isn't quite right. Is there some sort of
> > > dependency loop being juggled here?
> > 
> > This was needed because of the changes in ice_flow.h, struct ice_vsi is
> > now used. I will check if there is a better fix.
> > 
> 
> I think there is probably a dependency loop. Ice has had a lot of issues w.r.t. header includes ☹

Understood, let's leave that for another day :)
