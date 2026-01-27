Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE50D34097
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 16:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4102813CE;
	Tue, 27 Jan 2026 16:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5MVD0GRzQGO9; Tue, 27 Jan 2026 16:21:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1140980DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769530904;
	bh=5zpSHGdhkg0KPTImlaLFxoqVNqQUyXwj8Op585Q6z94=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vg9RFnM1RQt+NrVdyopZPJVGf7UygTOKw8hTeMpNCa/xkIVelVVDvhZbRvRMlxH5D
	 Z/mUS2MfkQPNm7f6fHA4uppoRNhvNQ39QkmJKneinCwPrOvJJbEXdajPaUgc+WDqzK
	 gvClJTtx5vNbRCBT2s2LHbedWYqwXQ4bVaOU3APq4y+sH7phifYPuci9IEKqDN2Skt
	 1rVDFCKLcy/qb4BhP0lOPR0kFmlw3TJ3vTtarQawe9/ch7bb/TIWZe4UV3sUUBWGLV
	 OnXQrMVopo/PIU19yeOzU7qQkvF3+03vv5dpFuzImVn069Ye5V8ymFz/5R51R9o4Qm
	 p/t4nJfjiJqtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1140980DCA;
	Tue, 27 Jan 2026 16:21:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 726AA118
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 16:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60EA480DCA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 16:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30Azk9e4Z9lO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 16:21:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B62AB80DA5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B62AB80DA5
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B62AB80DA5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 16:21:38 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB48E4C442F986;
 Tue, 27 Jan 2026 17:21:13 +0100 (CET)
Message-ID: <c8807b34-59d9-4b8c-8b2e-477fa25ef413@molgen.mpg.de>
Date: Tue, 27 Jan 2026 17:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20260127-const-name-v1-1-9c84615c55a4@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260127-const-name-v1-1-9c84615c55a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Make name member of
 struct ice_cgu_pin_desc const
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

Dear Simon,


Thank you for your patch.

Am 27.01.26 um 17:16 schrieb Simon Horman:
> The name member of struct ice_cgu_pin_desc never modified.
> Make it const.
> 
> Found by inspection.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 93901bccf1c4ae1e1782e7a2af4322a6777d0b6c..87aa4cfc5a463f74509ecc4cfbc00e06f26cab5c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
>   };
>   
>   struct ice_cgu_pin_desc {
> -	char *name;
> +	const char *name;
>   	u8 index;
>   	enum dpll_pin_type type;
>   	u32 freq_supp_num;
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul Menzel
