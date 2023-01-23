Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E5C54EAA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Jan 2023 20:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8471941625;
	Mon, 23 Jan 2023 20:10:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8471941625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674504606;
	bh=z1zOzYxcptm8r891HvUVADrpmWtqZNphsPnQs0Z3V1A=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MYacvl3UC7qjBMI5y968RWKXjEGx1LBg4mNxRYtKJhsPZ5QoHQ+PFzynTpLnQfIqr
	 2LyV9je2g4W2XxovC+uj6ISO55Yu+5P5pSWbwXIWc5NCOF9SxgDGanhgKCInmFz2Kf
	 Z51Dw9TKEpYvr8A6MxMkd9CxL8Fgf1GpiZNYdap3NzihnvnA6kslG9UXtNjl9rHuMJ
	 4945/dIddW/2mADLnd29Slq5v/7QM5u3b/Qx33bjpyX92bWZv2ObXOh2it5Yk09Urw
	 f+eh6sK2ngYh2DhcZCZ4Z99aSstUm/obX4nQnuVnwbvEdZZbxbDVsPlxQIRlUdn0Q4
	 WJW+r3+txhn4g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ikkC-4jesoh6; Mon, 23 Jan 2023 20:10:05 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E4741706;
	Mon, 23 Jan 2023 20:10:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62E4741706
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1A0FF1BF28C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 20:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E824040B55
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 20:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E824040B55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J2cbkeUZQP6J for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Jan 2023 20:10:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1696C404BB
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1696C404BB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 20:10:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5E86B61029;
 Mon, 23 Jan 2023 20:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3070FC433D2;
 Mon, 23 Jan 2023 20:09:59 +0000 (UTC)
Date: Mon, 23 Jan 2023 12:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <20230123120958.741cf5f1@kernel.org>
In-Reply-To: <Y80odbX/CVjlYalh@lore-desk>
References: <cover.1674234430.git.lorenzo@kernel.org>
 <acc9460e6e29dfe02cf474735277e196b500d2ef.1674234430.git.lorenzo@kernel.org>
 <d0232e99-862b-3255-aeac-7c04486cb773@linux.dev>
 <Y80odbX/CVjlYalh@lore-desk>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674504600;
 bh=x79GNAYGa5nqxksUZTAo1zLvL5fVbuVje1NDQA8AE6k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OD7S+PMxqfw4XRZjqaqZ34DYR37+wyAhOxXb8NLUjsJBDaOtBKv1RFk/IkFrBsAwG
 ig3HbTZYPmN2vmtYk6OsDKzPhwcKYJ4sqfptxoKhL01szt8bU6K1VbhQ7eN8p7Too4
 9z8DpxQft9B5q/nWdQYGGp4jSBu2qow10keNqh89VlzNbj8Rd+TPg5bZsYqEN2V4RQ
 PxxGz3sgZnui3xHzaZx1OZy3P5fmSdznskDHPXUMNXQvHZ+RHp2L6YNibm4NXT5R/M
 4AqcpV7Rn54AQ2/jxkepEDovURhrx2EPthcBt0C6nfTwKi2oBY3ZXj/L+ZAqWYPxO2
 bTDr6w9YtA1rw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OD7S+PMx
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 6/7] bpf: devmap: check XDP
 features in bpf_map_update_elem and __xdp_enqueue
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 niklas.soderlund@corigine.com, andrii@kernel.org,
 intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com, pabeni@redhat.com,
 aelior@marvell.com, hawk@kernel.org, christophe.jaillet@wanadoo.fr,
 memxor@gmail.com, john@phrozen.org, bjorn@kernel.org, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, leon@kernel.org, netdev@vger.kernel.org,
 toke@redhat.com, Martin KaFai Lau <martin.lau@linux.dev>,
 ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, 22 Jan 2023 13:13:41 +0100 Lorenzo Bianconi wrote:
> > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > index d01e4c55b376..69ceecc792df 100644
> > > --- a/kernel/bpf/devmap.c
> > > +++ b/kernel/bpf/devmap.c
> > > @@ -474,7 +474,11 @@ static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
> > >   {
> > >   	int err;
> > > -	if (!dev->netdev_ops->ndo_xdp_xmit)
> > > +	if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))  
> > 
> > The current "dev->netdev_ops->ndo_xdp_xmit" check is self explaining.
> > Any plan to put some document for the NETDEV_XDP_ACT_* values?
> >   
> 
> I am not a yaml description expert but I guess we can xdp features description
> in Documentation/netlink/specs/netdev.yaml.
> 
> @Jakub: what do you think?

I've added the ability to document enums recently, so you may need
to rebase. But it should work and render the documentation as kdoc 
in the uAPI header (hopefully in a not-too-ugly way).

Example of YAML:
https://github.com/kuba-moo/ynl/blob/dpll/Documentation/netlink/specs/dpll.yaml#L27-L46

I've also talked to the iproute2-py maintainer about generating
documentation directly from YAML to Sphinx/htmldocs, hopefully 
that will happen, too. It would be good to have a few families 
to work with before we start that work, tho.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
