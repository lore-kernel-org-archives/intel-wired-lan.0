Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54775C27C50
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Jun 2024 14:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0963D847D6;
	Tue,  4 Jun 2024 14:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGFGrAuqBAwo; Tue,  4 Jun 2024 14:47:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6403D847C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717512439;
	bh=6VybkIe/mfuNwhZtf42D1iID6jfQqsZ+FYBBYw74ooE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OS87n7yByZf79bCmQB0aBW6iSvavuUvUfdEo1qkHCiIolaF97cnVRVUofamkAh2vH
	 qZ/i+90sY7nQ03kpvMB6EJeyXwZ9Iw0t/VZ29MCgzPmHs2ICVzyaDWSFl6ceHDEB0T
	 IQC20vsiEdHlwFOo0I1CNKPCvKwipXhXtauES5HBzNRbIBKj0Gd+envSZjkEcfuQ9Q
	 Qx4Kjfjt3IPx7YI7sftKiu2Sm0P+iEcgBo/Vll+SJ0K3KY0mmYT1ZSwsXxJhlxsD26
	 N60z8q5RLZH1hlrHo0eIO3xFp7h1ns0uMGbZKvd80UQvhzIneI3Deer1bIUdvlk3Mt
	 XQeCHkOhdz8og==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6403D847C1;
	Tue,  4 Jun 2024 14:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7927B1BF344
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 14:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 620CC847C1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 14:47:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nvum5jTSFPRG for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Jun 2024 14:47:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9F9E1847AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F9E1847AF
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F9E1847AF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Jun 2024 14:47:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C7E7B612E7;
 Tue,  4 Jun 2024 14:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DA7C2BBFC;
 Tue,  4 Jun 2024 14:47:14 +0000 (UTC)
Date: Tue, 4 Jun 2024 15:47:12 +0100
From: Simon Horman <horms@kernel.org>
To: Karen Ostrowska <karen.ostrowska@intel.com>
Message-ID: <20240604144712.GR491852@kernel.org>
References: <20240528090140.221964-1-karen.ostrowska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528090140.221964-1-karen.ostrowska@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717512436;
 bh=DQpc3H/iGHBzXEnXirKC4DTb+vp4yIJgxU2+Hd02O04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PxjSqW/ewt4Dy+GkrFEJ5uErXcctItLMmHKgt/gRpY3Axxf9BDJUjOchF8VsNgtIu
 s3Gaj8MBBe15ZJbhTrQdLfIgoTBywyCYYdBoXPrjCyLiKjXU1aDTXP3qFL107jtJ42
 uF6oh4SwYbd9MSGsjZobJ974Dzhc5Jqrsm1HVK9PRRslB7H2g8GWwTbdgehnI9ky6w
 uVCJLk0ts02C+afV9Ed8h409n7kq2CautYClAVeMm9eyylsVVqVQzkcGrJnz+pX4iq
 wW+OZSqnkCXI7dlHHv0+6WXGd26G8mgbdkLsqI0s+ys8dJE5qWUB6zyMKb+3kdc9vP
 r9TiJywyFe1qw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PxjSqW/e
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: Check all
 ice_vsi_rebuild() errors in function
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
Cc: Eric Joyner <eric.joyner@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, May 28, 2024 at 11:01:40AM +0200, Karen Ostrowska wrote:
> From: Eric Joyner <eric.joyner@intel.com>
> 
> Check the return value from ice_vsi_rebuild() and prevent the usage of
> incorrectly configured VSI.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index f60c022f7960..e8c30b1730a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4135,15 +4135,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>  
>  	/* set for the next time the netdev is started */
>  	if (!netif_running(vsi->netdev)) {
> -		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		if (err)
> +			goto rebuild_err;
>  		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
>  		goto done;
>  	}
>  
>  	ice_vsi_close(vsi);
> -	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	if (err)
> +		goto rebuild_err;
> +
>  	ice_pf_dcb_recfg(pf, locked);
>  	ice_vsi_open(vsi);

Hi Karen,

This seems to be a good improvement to me, thanks.
But I do winder if we can go a bit further:

* Should the return value of ice_vsi_open() also be checked?
* Should the return value of ice_vsi_recfg_qs() be checked?

Also, I think the following is appropriate here:

	goto done;

> +
> +rebuild_err:
> +	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
>  done:
>  	clear_bit(ICE_CFG_BUSY, pf->state);
>  	return err;
> -- 
> 2.31.1
> 
> 
