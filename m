Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE36C3DA7A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 17:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 431E781247;
	Wed, 14 Oct 2026 17:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GXr8YYYw0tLb; Wed, 14 Oct 2026 17:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CF3F82290
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791999375;
	b=QHC4dqvRVuem4TGtR5mrt7/3PGyYTP9g991nH0FergseD3ZE5vcFf5RQkHB0E4+pP8g1
	 geU6sYsX+mwr5MaltjZi9gAInz+Zj/wceC3cOL/YX2maMvOz6pXN1PUZYTuxf2Iv6dS1Y
	 DGEJUy/uOZ5uDmBsqpg4sYjB6ivtwqKk26DqUnMuZYPca96JnHrcK/IeD8KFidysLJ4ou
	 Lqt1Lq5xu5iiwXjaQGz141RCo/GY72Q0f/1HesvLzMjPpSw8/MFRC0hg/38VFNIu23VSc
	 nsjn6CDecwggn/Uvry+v3GoFQJ4kwIEjPt678BT78uUe0Ep059ZZo7YqcM6FIvp/bIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791999375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WBMVjY8YeonBZOvSdmUkR4YHsUWbR6DizhvuUowYl5c=;
	b=NtOyF/+Lm9RRCXWLFqSTW7jZwqnHtpa8LpctqRm5NVVjdPaV7y0J2q1C0ZbJzF/2v/uO
	 TPQ4dCpKNCOjO7RnG38V0Ger1gWDagvH/Fwkn2XHrXIRJraZ1rltvESpUu60jy4UFqxpb
	 B4wRWj+fMqj/N9h63ntFw2/p7dxkImoj74JLxJp5L94tCf4LEiZT+ZFh+Lqh1ZbqoZMpY
	 VR5QJBdF5CylYL07qPIjSFG0JCDX+zLQjwlXlLuliPJGpg7ZyOVVzzncmdhQ0eqIBEZGs
	 27tIcrTuxLhYXQX353jMfou7cPKP5qbaACEW/SxuVFBcnvZhT1oZ03OzB7SMqprPjWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791999375;
	bh=WBMVjY8YeonBZOvSdmUkR4YHsUWbR6DizhvuUowYl5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEHmwnSvDDgr3P9KsH5SIta+3E0EaQvlf6/0WsAepSOiFnKfZjwOUNcAp4UvdVNbZ
	 KpTGKv0oZeZVqAkiil+ond2pU2OnvL6rFeqLJUEkJE3vgL89GqUWxiVLXN8sbteQkw
	 UXCC5d1XZbFin9Aja0wYa3zvlQYpFa00N5vfWT+z60PZsxAx3yl5vLToPbjz8gsX9G
	 fz+mct8Kbgyur1J77nED9Lfjglt8F26zsaAHtCcirPGDmi95GbHwsg/9M52yhtnDSt
	 ERvl/3+fUdGquptf4NxEX9oBHWuO/ap/4zeg6XEJUqlSA2YHQe2M/uBeRA7oBDpP4r
	 CPbjvLpVpDhhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CF3F82290;
	Wed, 14 Oct 2026 17:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B6ED5E4D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BE4A4055E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0ggk9Ly8bcJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 17:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18B424052F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=49.212.198.91
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791999372;
 b=CBRpPcTGfShRLqCBx9N3RVv+pv/BRPR6l14QT6j33OEK2Yra16ew2Uph7n2iwZu+Bp/M
 B1OjmpMyau/ym2uTm76gjRW2vd8hymV1L363he+OIhWQKoHymxzA6zvm001hIogVyRcc/
 3C/U4Xy+kdcHVuozRm2F1atXKL0cAxbXRE9Xqfxo5tHk0OuErqYIjciFK5BbER2z25UFN
 HGO15kiCeMhsblcQXh/1m5fHMtV2rQ0b/QSpmYN0rJvDzWCZ8o38Y3a2IAtb0hUCvy2Fz
 xfiMrDfg1obmXxUG2g209AV+Et2j1rjrIdFhIBGIpIIeUQuTvLVG5cYsGGZ98RyVvsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791999372;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=WBMVjY8YeonBZOvSdmUkR4YHsUWbR6DizhvuUowYl5c=;
 b=Ae0nEERUma1gga+h9Vn76SXuIv6830UW4nYhSDoVCIJ3j7FaT33rQGb0by2Djt0b6Gfq
 8VMhG7U0C8C7+wXj2aYu+ydMDO9GvlyIkiB9dHosxja/1BToNFLjoDHy6RMmbpWQRV+UN
 umKHQGzT9dpLNOb1H1Fc49YlJv9GLqLkLoL4a4/xsOfMRlJGclna0AQo3BB9ki81/E676
 Yal3I4iLwfa//nKohFfCillgiFUuZ1kqQFr17694ZcZS9khwzUErkxapvmInx82+BeeY9
 Mr9UkfgiPpwIHDSPf0Z+Uk7Se56nH+/pvHLR1IojbCN1vhmLGUc41BP4WsH8mu10sMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=enjuk.jp;
 dkim=pass header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=Dc+WSIlM; 
 arc=none smtp.remote-ip=49.212.198.91
X-Greylist: delayed 3564 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 14 Oct 2026 17:36:10 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=Dc+WSIlM
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18B424052F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:36:09 +0000 (UTC)
Received: from x1 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69EGaZFg095707
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Oct 2026 01:36:36 +0900 (JST) (envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=WBMVjY8YeonBZOvSdmUkR4YHsUWbR6DizhvuUowYl5c=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1791995796; v=1;
 b=Dc+WSIlMSIFT5Of2aJUnUTIQPWZvu077QPVp2qtM2QIP66sBWEcLvv0eorAaYxqe
 Ft5RV7g44YCJ2K/uPUBfUGB/1Xnqvqy705hyYe5T8gs5Ji2awUb28IDtblvwvIwy
 XDhmH9iyHwdWUQM9MsPDGh7WJv3uiY7/0grkfYUV+FvOk1xCCUZSexqdaKxwwKdp
 iFHRGgeFVKQCMOuJ3Ilgje5sa2Q9hbPS093JGLa7zsD7v0nFbscvHeJIhavbVt7L
 1dohrheiB2vkcZVAfv/vLDCXnkxLxBrLtmPvZeQzzjikGQj80v+1TO8m+fwDDUkX
 s4tmMy+NJoVQcqJmP8DdJg==
Date: Thu, 15 Oct 2026 01:36:35 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: intel: ice: Modernize ice_vsi_free() with
 scope-based guard(mutex)
Message-ID: <as-tT0nDrchWa96T@x1>
References: <20261014110552.56976-1-ayush37735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014110552.56976-1-ayush37735@gmail.com>
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

On 10/14 16:35, Ayush Yaduvanshi wrote:
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>

The commit message is missing, and this patch seems to be a clean-up
patch, which is discouraged in
Documentation/process/maintainer-netdev.rst. Also, this document says:
    Use of ``guard()`` is discouraged within any function longer than 20 lines

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..c695df442822 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
>  		return;
>  	}
>  
> -	mutex_lock(&pf->sw_mutex);
> +	guard(mutex)(&pf->sw_mutex);
>  	/* updates the PF for this cleared VSI */
>  
>  	pf->vsi[vsi->idx] = NULL;
> @@ -466,7 +466,6 @@ void ice_vsi_free(struct ice_vsi *vsi)
>  	ice_vsi_free_stats(vsi);
>  	ice_vsi_free_arrays(vsi);
>  	mutex_destroy(&vsi->xdp_state_lock);
> -	mutex_unlock(&pf->sw_mutex);
>  	devm_kfree(dev, vsi);

This also extends the critical section, as devm_kfree() is now called
while holding pf->sw_mutex.

Could you please clarify why this change is necessary?

Thanks,
Kohei

>  }
>  
> -- 
> 2.53.0
> 
