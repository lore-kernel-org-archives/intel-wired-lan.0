Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AC7C48260
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Feb 2024 02:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3302F40477;
	Wed, 14 Feb 2024 02:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXGPnyE9I5a0; Wed, 14 Feb 2024 02:13:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5571D405F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707876838;
	bh=P+YLseCSnPrmNOCJOJXzJRbDvmIvFMopOTvg+h6CyZ4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=aClycacpq3Um5IPj+LlOE948XQpPemBwtF0imyPzZDFePdTTCysiO7PCrDgafBNoz
	 hQYpQ3eaT0uZ/HiQacS0ga1L4rg4y1BrMlGWM7VXwXmlLjuQSxUIyMDjv5qZQoSMPk
	 Qdo/BNBq6U3LOipb4PMLTiCuaIcJmoWJp7lrj3348pPWF+NaaosAWtkYoGZdOXr6Rh
	 PARpcuD97vUO6aWUonohF238w+cDXngKAVaknGVMHzcOXsh5qawbqEFXqhT/zCHFrU
	 yQ0r/jc91HRe1AgGyfuw0SqPS0Ve1DkfdNR4o0WLK0+NR1qOoBb0EYFAMQCXpCQdwL
	 F8/Dc5yddRcTQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5571D405F1;
	Wed, 14 Feb 2024 02:13:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9DA841BF5A5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Feb 2024 02:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 880364159D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Feb 2024 02:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DcRXw5_p8RiD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Feb 2024 02:13:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 81D9D406EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81D9D406EE
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81D9D406EE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Feb 2024 02:13:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2892061735;
 Wed, 14 Feb 2024 02:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5E5C433C7;
 Wed, 14 Feb 2024 02:13:52 +0000 (UTC)
Date: Tue, 13 Feb 2024 18:13:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20240213181350.1755f669@kernel.org>
In-Reply-To: <20240210021000.2011419-1-jesse.brandeburg@intel.com>
References: <20240210021000.2011419-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1707876832;
 bh=lQNXSwJuhMO0vRmlUmCazz/caFJslTJfAuXVjDyef38=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ktWfJ38Q0dUcH6T8zWlNcGLYs5b3IJvc150zAC4qCHw5tyPOvu/uRZIARkgukup9h
 h5J74yyUEi2STrwPxKIhZWiSYjPOcWZakudrEdp9LT5UfXS+twIETx7ykqNko8M/+S
 rsby2D+opQllO6xLe8E1ObdSSZA+UXu0U3GeH6TNkQoZxzMeWKrQLsrMbLQ+blm4V2
 787si9fYmxol/1PUoPgD04cfRFq/H7MQvVwc7VOxvc7D9Eq7qJ5D0Yl6vYOYpMk/Cv
 I63/CqTZ89z3lw4O7uRfbcPH0b44A5wa4ulTcEcRusFkHcT39sFDGIPpwPBrFlqCkO
 4tH6+CKzowvZA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ktWfJ38Q
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v1] net: rework FCOE and
 RFS ops
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
Cc: Kory Maincent <kory.maincent@bootlin.com>, Ariel Elior <aelior@marvell.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Maxim Georgiev <glipus@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Emeel Hakim <ehakim@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Raju Rangoju <rajur@chelsio.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Sudarsana Kalluru <skalluru@marvell.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri,  9 Feb 2024 18:09:57 -0800 Jesse Brandeburg wrote:
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -10416,14 +10416,11 @@ static const struct net_device_ops ixgbe_netdev_ops = {
>  	.ndo_setup_tc		= __ixgbe_setup_tc,
>  #ifdef IXGBE_FCOE
>  	.ndo_select_queue	= ixgbe_select_queue,
> -	.ndo_fcoe_ddp_setup = ixgbe_fcoe_ddp_get,
> -	.ndo_fcoe_ddp_target = ixgbe_fcoe_ddp_target,
> -	.ndo_fcoe_ddp_done = ixgbe_fcoe_ddp_put,
> -	.ndo_fcoe_enable = ixgbe_fcoe_enable,
> -	.ndo_fcoe_disable = ixgbe_fcoe_disable,
> -	.ndo_fcoe_get_wwn = ixgbe_fcoe_get_wwn,
> -	.ndo_fcoe_get_hbainfo = ixgbe_fcoe_get_hbainfo,
>  #endif /* IXGBE_FCOE */
> +	SET_FCOE_OPS(ixgbe_fcoe_enable, ixgbe_fcoe_disable,
> +		     ixgbe_fcoe_ddp_target, ixgbe_fcoe_ddp_get,
> +		     ixgbe_fcoe_ddp_put, ixgbe_fcoe_get_hbainfo)
> +	SET_FCOE_GET_WWN_OPS(ixgbe_fcoe_get_wwn)
>  	.ndo_set_features = ixgbe_set_features,
>  	.ndo_fix_features = ixgbe_fix_features,
>  	.ndo_fdb_add		= ixgbe_ndo_fdb_add,

If we'd be having a vote - I personally find the #ifdef far more
readable.
