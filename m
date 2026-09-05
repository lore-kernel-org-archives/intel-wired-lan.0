Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85139C624DB
	for <intel-wired-lan@archiver.kernel.org>; Sat,  5 Sep 2026 18:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 229014086E;
	Sat,  5 Sep 2026 18:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otrnc9p_a7_A; Sat,  5 Sep 2026 18:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7F02F40A28
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788633119;
	b=YIzGWOpqCaKLOovUimsWhnK29ykyJwWZn08paURkSjFuwXjDh/ykwSWbmhz+dcAYFLUd
	 xgd7p0ahuAOHWxFmY2iLCH6Ootaa7Wj5nyoTCqorlJq2B/ByFiD8oqE1EOirXFDJJyiPu
	 IioLFsIAQFahtpU3Ps57+TfKIhQacp9LoBKUb8OfNOKHQw6D+H5r/91+mXtSOl6cPuKgf
	 VVBkMinnLxWrYoaCCJT7kjad3lxCOMtVFzBz3NP5Qzwror/W8G9JXr1J2Hbo2nq5ahp+m
	 G1B73eUX2ztK8Pir3FLmyo7GSAwdBB8z/Z8hA6qVDOJ3KKUugFfIZEs/bRnDW5jH3GA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788633119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p2DvN4334apFD/6/MWBRYC8GzHwMGwZWsOlmewSgMk0=;
	b=rS4zr7doL+Pi14jtZHMvNbzgVBMLPVIkc4n55GyHYt/UAmvVp9bBEFO8COSm2QRwLiVn
	 XI+T0s9i94vsE9Q8srwoci+DvdWU1SLjGHmRABsc/92mWXNQt8MWU398TS3nGqVbH403A
	 gCAQpFNH7j8I5drvVhCLzl1eCR1roNYM6h4R+3KcTKFp80HHafSrsOcN/X+w02oHB3/P8
	 wPfvEeCT+IclgOTPPweT69ezo4IJ1GZbXTCzuu2xnTT5m6flDZRXkKrasAv6UOtr51X7M
	 KVCuUkLPComxYJrz0Fc4BKn1DMF2gTU1vULtoXok6Mk0tJeHtH1g0KIgtW0lhOHTaKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788633119;
	bh=p2DvN4334apFD/6/MWBRYC8GzHwMGwZWsOlmewSgMk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1q80zLkb8zkQVK0vlXRzbp/FgIv8FWHT0Z8YIeHSwEp8v9dthuhuLkNfB1NZv9Aa
	 41ibz4iLPJo7qD0s9id+ihPQUYYRFXNdN+cVbEO/iw6cR6Uz8zZRQ4M5mz5sg420RS
	 pIMG6EUwwxC5qoC0v7B1+UWyhXVGmBNuZd4bhemwQjFifgALpVJv3I38y4l3QhWJR+
	 4tbynaaFyLPvrI6GeEM+d3hWfbt4Izlv6u6cUdjop9LY1a0vXPOkkDB631xFSeMHdJ
	 aca8SRMa5ggaFXp2ynVSH8p+QPhNH0VIQ/NcFCrs4DYtRZB5371OHkgJLGF881Iu1f
	 xWKurmavm1fRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F02F40A28;
	Sat,  5 Sep 2026 18:31:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E7AA118
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 18:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EF7240067
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 18:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4QVI4pP-xn5 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  5 Sep 2026 18:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7650640049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788633117;
 b=ggQ4sFkhRvxeFsDLrZyyGBrvfYEDv8as0aQ55XkWZ3epBxb/pN4sXmC4CUrEyvlZkvv7
 yL5mkPhNcX9+jRSivOcOgNk4L8j4jkg3TYNErWYyW8AO44ZK91+6NlbV79876W5RdBZwz
 VRVFOJdhdMkX/kv2yhVCVHe0DQrTWaI95Dq9EX0UIPgTg47CGmrvArXJkPnlSOGLOHn9/
 xhbRQK4MIrGwwhIImp4gXmwJ3ixHl+PgamvdD3QIP1mTXrsMCPQuS5OeyuThaL3HxNIWm
 Xo1HsJjgBNqT/Rbo2Vf91djX0J5wdvgh/IF5hRe+/gUI6KE/sYMRFf6pmf3kRmSY90g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788633117;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=p2DvN4334apFD/6/MWBRYC8GzHwMGwZWsOlmewSgMk0=;
 b=Ty3Gvt/LzeukIvEI9d8tUvURzfYaQWVQpKeAVNEgXSVj2KKelNNiPSBEw4vRFYQdeRw2
 VcXAJQFDBsVNxmGjARfSjxIdYI8Zfj5H9d1H6x9Hmp5G1aV8T/a4qCiNDbD7xI7jXolnG
 QZLmpfRAcVcdYABOztGxZWQI5rzLiUpHGjL5+ZgXq7sH8tX4jGCVlwgaKeilvHXSW9Dxq
 Z5/YOGoTSNSJekwwFNBhUy9rI6pHtnRpySGyVmKTBlxTs27rDW3D3Kif0CVSXhgrJaY4B
 k9PY5K8VMldcvv+mSuMcbrVlms7YrALJHiCbcpCticUaZjngmcpKnMOxRKT/6X4+4tA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YopoFfQw; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YopoFfQw
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7650640049
 for <intel-wired-lan@lists.osuosl.org>; Sat,  5 Sep 2026 18:31:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3474B43B66;
 Sat,  5 Sep 2026 18:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF441F00A3D;
 Sat,  5 Sep 2026 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633116;
 bh=p2DvN4334apFD/6/MWBRYC8GzHwMGwZWsOlmewSgMk0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YopoFfQwDQgqHkfbpL2iSR6ekgyO2G8KzPY2X6o4MnVAoh2ajWG+ka2PjUDp6+gMn
 YLQeq4q4YPvRFFin3IViemdhmPnaFBshd1wcgcnEaSTL8eatAbPGFUnX166oZ3miUz
 tmhISV5W0PiqSPI06uP7HHNBH//X4zm1CphufnCPXOtS01HtEOUwO710g3oyh9/2oD
 Mr024Mfg4LYFeyrKPWc3rQI6qfgML0R0AXUV4qbQXVeNo+vin7NPDvdl3783k6+41g
 e/hLQ/0sW1nQmcWZsT99Z1ysl24AWtlOBpGr0RBCn41baqweHBpuTfLOh3AeJy6Ju2
 Z36ls4tbbXAAQ==
Date: Sat, 5 Sep 2026 19:31:52 +0100
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
Subject: Re: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Message-ID: <20260905183152.GC40544@horms.kernel.org>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-2-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903132037.81346-2-ynorov@nvidia.com>
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

On Thu, Sep 03, 2026 at 09:20:35AM -0400, Yury Norov wrote:
> The function creates a temporary mask on stack just to check that
> first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using
> the ice_pf_state_is_nominal().

maybe s/the ice_pf_state_is_nominal/bitmap_empty/

> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

The above nit not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..73996e3022ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)
>  {
> -	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) = { 0 };
> -
>  	if (!pf)
>  		return false;
>  
> -	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
> -	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
> -		return false;
> -
> -	return true;
> +	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
>  }
>  
>  #define ICE_FW_MODE_REC_M BIT(1)
> -- 
> 2.53.0
> 
