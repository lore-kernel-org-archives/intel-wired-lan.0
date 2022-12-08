Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9045C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Dec 2022 20:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47DAE40192;
	Thu,  8 Dec 2022 20:44:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47DAE40192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670532289;
	bh=b/zebeUMiX2cV6okB64JpEl5OxEd0CWvcf2leX0eKv8=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QZkUnJhkjV0VWrLLW97J5NemMtXzR66CED2HY9hzC8ZyHhFiHZtexCs7kFvHXLars
	 a/ZYrWsUzSI8LLxg0s+jgfPp+QRKCLkUE5H2Xu/1SkQ1uwGGYzhHgcKsLyRFGXkqze
	 q8HXNacsQazuiNa5ffF+ByG5E4D+ZhTZqkupXUOv4W+EW2IKU2K6Vc+o7LBiGpQ0YX
	 kSHKRtgDI/0eh4gyR0vuVlVYNxw9uDFlevK5P82iG1qATC2tqgCMJ20TCiF6+vVTRq
	 wMY0r7RqHMrbXEN7IKyBI3jcBI0069s6dnjmzC1xqVmZ4UPaup0/p45nsSQ6cwKhrD
	 OxHW+hYqpv/Gg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXOTg7lmEnyn; Thu,  8 Dec 2022 20:44:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5701B401B7;
	Thu,  8 Dec 2022 20:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5701B401B7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 03DAC1BF591
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 20:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB68740339
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 20:44:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB68740339
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NyZsrMrxb9Qr for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Dec 2022 20:44:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20FD240192
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20FD240192
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 20:44:46 +0000 (UTC)
Received: by mail-vs1-xe2d.google.com with SMTP id f189so2575757vsc.11
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Dec 2022 12:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEczapz4b90UVUtZua5dx9uUROy78SLPUHE2fQiWiJ0=;
 b=e8f5/zQyPD7e2Br9hPdW1evCWZryYXP7mrgO2Cs4I0mBqLrpEDjtVzoQrxaLaAfXnZ
 7bSx3jyY6jRd2CzKwzcSeaHdWt+gdIZYmIQ5d1KLDPNbjNb9RfkYEesPWFgMFCvHAop+
 IrlsHURzNhBIdErPc7aWzHI8dN5pD5cOVX5BdVdaHFq3BvTyGe1z+V68ksWa/vvoTgnf
 937Dh7NZ13sNWEPyD3JEjVREL3WCFKObxPPwRwdBhNfVWB5ENRtt2R1pdwETEP3vIw9D
 ndYhxNI+2MFn4+Ji+PrOpq2MJQlc5Za2nrRHzaPg1AGOcoEPZb+xQU6KcfD01DhoDY6J
 qNGQ==
X-Gm-Message-State: ANoB5pnuD/S/lBJpct6R4KjHRiEH6+3iBQLnpdfp+68Ir4h1+hmgWWh4
 o/zNQORwfOAa73mdGbsaQKphfYxeXLws4S9SuCk=
X-Google-Smtp-Source: AA0mqf5drBZc1Vaq6FFHTkkR3BuQFV/rZdLiEZcWEGuIO/OHDVnCg5zn+58lY7mCEkTuJPPwpm6Nq/zuQjCj1dDxvXM=
X-Received: by 2002:a67:fb52:0:b0:3b1:1914:e63d with SMTP id
 e18-20020a67fb52000000b003b11914e63dmr11414624vsr.40.1670532284823; Thu, 08
 Dec 2022 12:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20221207144800.1257060-1-jan.sokolowski@intel.com>
 <20221207144800.1257060-3-jan.sokolowski@intel.com>
In-Reply-To: <20221207144800.1257060-3-jan.sokolowski@intel.com>
From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Thu, 8 Dec 2022 12:44:33 -0800
Message-ID: <CAP-MU4Ni2bBHS5nxjxuc_fWqfag4GmDTOZYfWa9NtQhkPAz07A@mail.gmail.com>
To: Jan Sokolowski <jan.sokolowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pEczapz4b90UVUtZua5dx9uUROy78SLPUHE2fQiWiJ0=;
 b=h3EkvNeucbBFWJ9imgQsrvtZ2ywEGx7zPkTZuHPwMPHf/0xD7VCJsPZDJph2jKmhB2
 EvPBJ1jiqAWZjagEDA8JSajuiAbimQ9m650wjsSCu/XwWUNGOgb8Vp0AnGdsYhriQiL2
 DNHXVqD8Sk7xH27Htbm2X73ENyxzXA8CAjd0zydcVX2VAroGHn7n656wTNGssZq5x2UE
 A+ohOQ+r4oqomT1Ft/VNkxu9UybpTYsN2oNnNB1j23J8SUMcA3QrIqqVK5HH8VWoePei
 FpIoGCQ6qEgk1Ro3GextYpEn0+ULmfvgB1+lEAObpSVmkabzFoNrCOYn2EiyDECXbH5H
 C+aA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=h3EkvNeu
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 2/4] i40e: Remove string
 printing for i40e_status
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Dec 7, 2022 at 6:45 AM Jan Sokolowski <jan.sokolowski@intel.com> wrote:
>
> Remove the i40e_stat_str() function which prints the string
> representation of the i40e_status error code. With upcoming changes
> moving away from i40e_status, there will be no need for this function
>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c |  78 -----
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  16 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  41 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 307 +++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    |   4 +-
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |   1 -
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  28 +-
>  8 files changed, 201 insertions(+), 282 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 10d7a982a5b9..d247bed9af59 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -686,8 +686,8 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
>         ctxt.flags = I40E_AQ_VSI_TYPE_PF;
>         if (err) {
>                 dev_info(&pf->pdev->dev,
> -                        "couldn't get PF vsi config, err %s aq_err %s\n",
> -                        i40e_stat_str(&pf->hw, err),
> +                        "couldn't get PF vsi config, err %d aq_err %s\n",
> +                        err,

After the last patch in this series converts all to the standard errno
values, you might look at restoring the readable error messages by
using the new %pe option that can decode the errno into a string.  For
example:

    dev_dbg(dev, "oops: %pe\n", ERR_PTR(err));

sln
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
