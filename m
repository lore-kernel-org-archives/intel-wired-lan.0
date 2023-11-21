Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22654C61D97
	for <intel-wired-lan@archiver.kernel.org>; Tue, 21 Nov 2023 23:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE203401CC;
	Tue, 21 Nov 2023 23:29:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE203401CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700609356;
	bh=u4bHnwgPu7RXBuzGddifS+dXYpasGH87l9uOw28uo+g=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UqZW5QwskIIcqeO/RCyloCRzba8SSqrTGrpld86XrN2rhDZ0+pI9Su1drWUexcwvj
	 MfCWnxC+Ts2SWH+WheVdFXotfx2JWOsEews+ttmjhPN+0j1ovHW/HYZJ9TUmip+6Cg
	 rreMetKjxX7CDofC1Mq+5jW/AmXSAfiJzUIWsnGEOYFH9A7adzO75hyseQsfWtslFC
	 15QfW8FK8fnmA4Hvc4tksnG1aA+TdDXAiLvxSHp3wAyAsYvu9Eyr0MgtBXq181+it1
	 ZVerJdyUN5chmelHXBsVyZnsRg3ySkUn7K+R8D7FOHeDGEHtuDXIpGQ5snU+IQL9XO
	 CYqGkXN1aR4RA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xM2FxLJEqgbG; Tue, 21 Nov 2023 23:29:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EB6E40360;
	Tue, 21 Nov 2023 23:29:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EB6E40360
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id F125C1BF94D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Nov 2023 23:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8FA1408F3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Nov 2023 23:29:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8FA1408F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RvCwxWNu4lF for <intel-wired-lan@lists.osuosl.org>;
 Tue, 21 Nov 2023 23:29:10 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC9A6408F0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 21 Nov 2023 23:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC9A6408F0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9D30361B8F;
 Tue, 21 Nov 2023 23:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C58AC433C7;
 Tue, 21 Nov 2023 23:29:07 +0000 (UTC)
Date: Tue, 21 Nov 2023 15:29:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20231121152906.2dd5f487@kernel.org>
In-Reply-To: <20231120205614.46350-2-ahmed.zaki@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
 <20231120205614.46350-2-ahmed.zaki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700609348;
 bh=fEzPROx42WfkO6ncCKE3bs0DQa21Xu0Wvi6ZF8DSajY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YguDlj+pl7itFbltiXmiLAhBiOkyiiGdJyAI4BCCsdkqNRbkC82NHhpmJZERwVdBm
 iHKbJGIvsbOdu7H1eSNxTdDaa4h94SHPK+tF9q0rbcEWXw4ajc1aoUCC61i7VB+33C
 Dm80MalZYh/LSDTAyDbn63w8nr28K7/N6Io+6T/mkDuUxxgt9EswN6fvq7RN+KoOfP
 HNaUuoqS9BkpHRGL/Mt2tlyGrNMOoApmQEFGq5kNrV3+9eTtp0IFxa4usUQy60xPp5
 lUnca9vviogco38F5hZg9YisLK9X6GJ6QAEbfLJ62aUE79J2K5reijKSpaIP0awBph
 vXIPMZqMKveiw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=YguDlj+p
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 1/7] net: ethtool: pass
 ethtool_rxfh to get/set_rxfh ethtool ops
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
Cc: mkubecek@suse.cz, andrew@lunn.ch, willemdebruijn.kernel@gmail.com,
 corbet@lwn.net, netdev@vger.kernel.org, gal@nvidia.com,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 Igor Bagnucki <igor.bagnucki@intel.com>, edumazet@google.com,
 anthony.l.nguyen@intel.com, horms@kernel.org, vladimir.oltean@nxp.com,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 20 Nov 2023 13:56:08 -0700 Ahmed Zaki wrote:
>  	u32	(*get_rxfh_key_size)(struct net_device *);
>  	u32	(*get_rxfh_indir_size)(struct net_device *);
> -	int	(*get_rxfh)(struct net_device *, u32 *indir, u8 *key,
> -			    u8 *hfunc);
> -	int	(*set_rxfh)(struct net_device *, const u32 *indir,
> -			    const u8 *key, const u8 hfunc);
> +	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh *,
> +			    u32 *indir, u8 *key);
> +	int	(*set_rxfh)(struct net_device *, struct ethtool_rxfh *,
> +			    const u32 *indir, const u8 *key);
>  	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
>  				    u8 *hfunc, u32 rss_context);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,

This conversion looks 1/4th done. You should do the following:

 - First simplify the code by always providing a pointer to all params
   (indir, key and func); the fact that some of them may be NULL seems
   like a weird historic thing or a premature optimization.
   It will simplify the drivers if all pointers are always present.
   You don't have to remove the if () checks in the existing drivers.

 - Then make the functions take a dev pointer, and a pointer to a
   single struct wrapping all arguments. The set_* should also take
   an extack.

 - Add a rss_context member to the argument struct and a capability
   like cap_link_lanes_supported to indicate whether driver supports
   rss contexts, then you can remove *et_rxfh_context functions,
   and instead call *et_rxfh() with a non-zero rss_context.

 - Add your new member to the struct wrapping all params.

If you just expose struct ethtool_rxfh to the drivers (a) there are
fields in there drivers shouldn't touch, and (b) that struct is uAPI
so we can't add netlink-only fields easily.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
