Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41034C87FC9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Jul 2025 01:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68E6282B69;
	Wed, 30 Jul 2025 01:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHrERsBi8MOo; Wed, 30 Jul 2025 01:45:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B10DD831B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1753839933;
	bh=DSi8xLsl82ZynOTJoNES1EIO8+IjbrYPEqW5/E43/n0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xzhni5tKgGqM+v5W5y64K754tLDbjNT7k0fnedg4mrVl8NGxAdLAVHlAN+laFc3Dm
	 33537tUvgv2w/0cTTl6T+NK9iM+fFK5QAGb0ntgKtHFI+YAdWHiZ3co73EPTwTkCmP
	 vMF1ALqkPXKw6NcfG7bFZ6iCw3sCEecASScrwb581B7eXQ1Rki1Kg+bIEwmrp+ztgg
	 Jrn+pvIvRouFaAUIjDE3E0DeVLPgOxlwqlQLCBs5GJUC+k6D14Ln8C7fO67yk/PvNs
	 pvcKZIqX3NpcBksqvI8tfdb4TzTNtNl4+vGi50LhnEQRAnB5HvcsauB1C56jhNMhi0
	 xdskFahiv+qDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B10DD831B0;
	Wed, 30 Jul 2025 01:45:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6264A194
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Jul 2025 01:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53DA24079C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Jul 2025 01:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pUdUjIqugunU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Jul 2025 01:45:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A9A2F40090
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9A2F40090
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9A2F40090
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Jul 2025 01:45:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D0C3433D7;
 Wed, 30 Jul 2025 01:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52730C4CEF4;
 Wed, 30 Jul 2025 01:45:30 +0000 (UTC)
Date: Tue, 29 Jul 2025 18:45:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Message-ID: <20250729184529.149be2c3@kernel.org>
In-Reply-To: <20250729102354.771859-1-vadfed@meta.com>
References: <20250729102354.771859-1-vadfed@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1753839930;
 bh=zKh6Ix9H+F184fAKB9LOEXmgZa9PaVCbMzYZi0p0yqg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MoyrOd7gBgpSeukLaTrwUdf2chz3B+865rPM1N3v5fh54S87swhX4WmqU7U87i0U+
 fXCQpGwf+n04TPbYNs9nInzuVh3ZNfry1jgPAT0J9KNBieQ1uoyH7Njya1bI6aRVTP
 pQfnrjB3jhO6wxr/a+vmEqjH505UR9KWTkSrVA1em+9Vbyvl0UEbakzi3LnPmPrmhS
 z5C6GGXedG8YPcpESCOpSSGTsYdxgx2FO0aJb56gv10AnHdK4NxJQBrVdQv80UFjTe
 9CX33AehdYuwriubfW8avww/gisnxI69ucGjZMF6D4w6gvQmzFs7qPiAP0SSfmH537
 Q443k+QCkQQnw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MoyrOd7g
Subject: Re: [Intel-wired-lan] [RFC PATCH] ethtool: add FEC bins histogramm
 report
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

On Tue, 29 Jul 2025 03:23:54 -0700 Vadim Fedorenko wrote:
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 1063d5d32fea2..3781ced722fee 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1239,6 +1239,30 @@ attribute-sets:
>          name: corr-bits
>          type: binary
>          sub-type: u64
> +      -
> +        name: hist
> +        type: nest
> +        multi-attr: True
> +        nested-attributes: fec-hist
> +      -
> +        name: fec-hist-bin-low
> +        type: s32
> +      -
> +        name: fec-hist-bin-high
> +        type: s32
> +      -
> +        name: fec-hist-bin-val
> +        type: u64
> +  -
> +    name: fec-hist
> +    subset-of: fec-stat

no need to make this a subset, better to make it its own attr set

> +    attributes:
> +      -
> +        name: fec-hist-bin-low
> +      -
> +        name: fec-hist-bin-high
> +      -
> +        name: fec-hist-bin-val
>    -
>      name: fec
>      attr-cnt-name: __ethtool-a-fec-cnt

> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
> +	{  0,  0},
> +	{  1,  3},
> +	{  4,  7},
> +	{ -1, -1}
> +};

Let's add a define for the terminating element?

> +/**
> + * struct ethtool_fec_hist_range - byte range for FEC bins histogram statistics

byte range? thought these are bit errors..

> + * sentinel value of { -1, -1 } is used as marker for end of bins array
> + * @low: low bound of the bin (inclusive)
> + * @high: high bound of the bin (inclusive)
> + */

> +		len += nla_total_size_64bit(sizeof(u64) * ETHTOOL_FEC_HIST_MAX);

I don't think it's right, each attr is its own nla_total_size().
Add a nla_total_size(8) to the calculation below

> +		/* add FEC bins information */
> +		len += (nla_total_size(0) +  /* _A_FEC_HIST */
> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
> +			nla_total_size(4)) * /* _A_FEC_HIST_BIN_HI */
> +			ETHTOOL_FEC_HIST_MAX;
