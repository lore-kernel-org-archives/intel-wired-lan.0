Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BD8F419B9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 13:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A57A853BA;
	Wed, 15 Apr 2026 13:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UwTW1JCMSQgu; Wed, 15 Apr 2026 13:46:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB07E853A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776260808;
	bh=e2E16ESmFx2Dv/sZs0E1IKmC6EICNa32ZsBtsT+TPrY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btJKaI1Drh+OTgnGOWL3C4d3UTtk5QZuzu40C5RYy1ZdfRp29qMdVKgVHDCyaPvO0
	 QBGDaCOzK2N7Qjr7EEjZfe8hWb+Zyb6ThZlSdHqmXPfiy2VNXs1hp6KWFcvcVuCIFv
	 sBkn/HMgfgguhTx30DlY5vyIHCGlBgKbPVAzzAGWdOAPkkwtWKTIa2aXzXvu5N8hHL
	 7boNjvJ6LhQoi/5FAy+096V5FX+gPHkzJ4+/giMvNUgmcxqBaotW6nYOxy1BvYq5ht
	 Yv0nWeH7YyPnDMmgaukC9nicDMOA60FWB03rHp6qeLHHouRiD1g+I7vH9MxvjC820D
	 +lDhnv4gTrnpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB07E853A8;
	Wed, 15 Apr 2026 13:46:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40481237
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 13:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2597F6F526
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 13:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id boPP4_I-eium for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 13:46:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7632C6F4C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7632C6F4C7
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7632C6F4C7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 13:46:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1453640B9D;
 Wed, 15 Apr 2026 13:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA725C19424;
 Wed, 15 Apr 2026 13:46:44 +0000 (UTC)
Date: Wed, 15 Apr 2026 14:46:42 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Avinash Dayanand <avinash.dayanand@intel.com>
Message-ID: <20260415134642.GJ772670@horms.kernel.org>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413073035.4082204-5-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776260805;
 bh=hUX+08o1UGhyqMZxAK7BKsm8gMlYpj2DYuE3FXFWmiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mm74+F2bxyVi1iMSesfUj0I41WtcnfisuF5oIYTOP13t9S1w0+qUJoSFt8ywZMLpZ
 X/mN5Xj1ITnFmBE0EjG3IfA/zwiamEt+kLZjbIc/DdZfeF/Csrul2Z7ypZiR4xR2DQ
 9KEoyyS0TlL7p7K58PcaNmwaHq0aKK2EP/3DxSYrVjvEZKZja7+q3pGnaHo2jK9C5/
 ymFiYr+bZg+861hBsnWh5iR9HVOexTQA8Fprh76cgyZmPMA2sosB5Wcr9Ie2xAZRcz
 2FyplORTjonOkQDRXohxIcO9LeNNBKUnn+o7+dFN95QabobrfxDBdAShGAhYB2rz+N
 qevYxHM4n/h7w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Mm74+F2b
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 4/5] iavf: fix TC boundary
 check in iavf_handle_tclass
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

On Mon, Apr 13, 2026 at 09:30:34AM +0200, Aleksandr Loktionov wrote:
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> The condition `tc < adapter->num_tc` admits any tc value equal to or
> greater than num_tc, bypassing the destination-port validation and
> allowing traffic to be steered to a non-existent traffic class. Change
> the comparison to `tc > adapter->num_tc` to correctly reject
> out-of-range TC values.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I am a bit confused by this logic.

With this patch applied:

1) For tc <= adapter->num_tc, which I assume is valid TCs (other than 0,
   in which case the function returns earlier), the filter destination port
   is skipped.

   But the failure path for that checks logs:
   "Specify destination port to redirect to traffic class other than TC0\n"

   This does not seem consistent.

2) For tc > adapter->num_tc, which I assume is invalid TCs,
   the function will eventually assign fields of filter->f and succeed
   if filter has a valid destination port.

   This doesn't seem to be in keeping with the patch description.

3) The above two points aside, is there an out by 1 condition in
   the condition tc > adapter->num_tc. It seems to imply
   that tc == adapter->num_tc is a valid tc. But I suspect that
   is not hte case.

In short, I'm wondering if the function should look something like this
(completely untested):

/**
 * iavf_handle_tclass - Forward to a traffic class on the device
 * @adapter: board private structure
 * @tc: traffic class index on the device
 * @filter: pointer to cloud filter structure
 */
static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
			      struct iavf_cloud_filter *filter)
{
		if (tc == 0)
			return 0;

		if (tc >= adapter->num_tc) {
			// dev_err(...);
			return -EINVAL;
		}

		if (!filter->f.data.tcp_spec.dst_port) {
			dev_err(&adapter->pdev->dev,
				"Specify destination port to redirect to traffic class other than TC0\n");
			return -EINVAL;
		}

		/* redirect to a traffic class on the same device */
		filter->f.action = VIRTCHNL_ACTION_TC_REDIRECT;
		filter->f.action_meta = tc;

		return 0;
}

> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index ab5f5adc..5e4035b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -4062,7 +4062,7 @@ static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
>  {
>  	if (tc == 0)
>  		return 0;
> -	if (tc < adapter->num_tc) {
> +	if (tc > adapter->num_tc) {
>  		if (!filter->f.data.tcp_spec.dst_port) {
>  			dev_err(&adapter->pdev->dev,
>  				"Specify destination port to redirect to traffic class other than TC0\n");
> -- 
> 2.52.0
> 
