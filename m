Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E92CA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 14:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 834266067C;
	Mon, 12 Oct 2026 14:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hr-SOCixxwo7; Mon, 12 Oct 2026 14:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83B8460665
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791815676;
	b=Va4ihi54B1hzXt1X7bw7H8jbreWGZll93C8wJ7ev8viIQUO+K7arNIJVsIcb+jrKRgjh
	 FSAATGEfDwKSB1xr1LtL/3ytx/jSpsoM9pajz2CcGVnvx6+niYVfOKIYBl0V3f35jjdC9
	 8bUpqtuX/qHvk0RNddvcdj+DtwYX8ruHeVNc0RelpOPI1DeJWeIQjpuORMoYr6LVc6EsF
	 HjdQAbxpo987IpFtqiWwo7U6YU3HgtToMI5aL0X+Trk8+wzK3swOG2JsALnwhRvgNptQb
	 ghkpDDhQA5P1yx0b+FUr/adw7fxkGADuG7+p/Ch74mrSQdCdty6yIy6HP3OtU0392Vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791815676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IKwRz4QUPGDbJdjaFuLMpfA2bqdlLEpCL7HyH6C3+K4=;
	b=ksO+kz0blN/68CW3UAPN8rl3VpyZgN9J3O2ke6Mf/goH1qFFztcs90DekjQwZVXKIDs6
	 WFvSUtHde8chuOyOMPSvsnIjm0knDRZTgHgPHYdopn3ZE5Gk/j4qoRIN5vdtAf1cxd8g6
	 K2E1maBU14XFKprtCMU0rmOYw4306EgvTrnefjmj1kWxd8Xnwh2D1jU37g95AxO+pkpVg
	 YdemMmueGtTxtYk69UljolSkLwguEVSG7Zb19fsTMPx/R08wU/AEcDGPX3OYJkOSn4jsY
	 WtGfxVp6NPMsP9Vq1NDWvkmFeJGO6TFI9pZ5F8HTgUpN9Jmit7vF01WsrYIB5kxu22A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791815676;
	bh=IKwRz4QUPGDbJdjaFuLMpfA2bqdlLEpCL7HyH6C3+K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oJd7Ku2jOZAJdm7D5S+HSDycBGkvEOcshSKl2p625JzK6r+w8mEcO86nYsS4Xav9D
	 L1ookgC31poRJzpddS0fg+n5P9kxj4KwiJWAQ7DSn+D3UqUnZhTTjgu84sxrRmyjl5
	 Jq1Ht6OHzCaV5m8/+zntY1520CW4IP2IaKy7baSwKgxvJfbvYEAp+QTy/71ipiqUrO
	 anf3Kaoctim102fHaH11AtpUdujztYstON4nI7BRlFUwJHrvIQH5LD7ZLpoRui4d3z
	 IFx8cdD4Bhj0scYrhI7a1NjJHaKoEYEr0St24RSjj6WwkQtiuQDUwJFZLQJLgwcEuw
	 tEK1ep4h+UOEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83B8460665;
	Mon, 12 Oct 2026 14:34:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E54E9194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 14:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB0E04010F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 14:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 69qp4mqcunSP for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 14:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F0C24004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791815673;
 b=X9XW/x6j6mhuRuJ1d+ZY7QavYk/w7NBUuK8VX0fUE6aopIWq0H2s/DQAu98Oxx9CMv7X
 0n1vHO4ta15t19J305YvEn2A5Bz7mMMnn+N5KEQ4dE6YKdhRlGy5yGYmBLzgtGPEbqQEI
 FAb9eLInjp+poxv9rct7upMzhbmTeEbFP7q4DXSmqq4CRW0KaGy4N8aD8O6qbMtpTH68u
 J7XYUrwJYGH0vL4GZzeafmZf6edV0UUp1h5V3EedtenGfyAu+7kaWE36284cruB9L+F6A
 IDwixjmSrAD4nwyE6IO/Pg3T3zGTXsd3oLK0fSJgKXUuqANPaufFPBHyWhN23cgdIGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791815673;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:In-Reply-To:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Type:Content-Disposition:Content-Transfer-Encoding;
 bh=IKwRz4QUPGDbJdjaFuLMpfA2bqdlLEpCL7HyH6C3+K4=;
 b=g+3NZ/N3iRB/PVWz86fNpFHggFsjLiUOQzMaM1XYhjGksNbJyV7uSLr6edgDI1TfTqlQ
 nID15B/2buPJcZsFVEnmvy3Tmt/iGtrSGSq2dAh9xckqf60vtHoerLJOqlVgj2A65pQDP
 sUTTBt9+Emi/uB1gulJW1sPBDEchNqrEp3NphPWL5cj7RD/6eovpZF4kFnAUqeqNEQHbQ
 jl3G6ftsuOkizvV1IpR9PAPrcXvKltQVakCp7dc0QIjhG5JfnpLj8L/ykk043uSZxLC9e
 0jdggT/wbiP9slqk15Whr+TXQVumHxcAiLaSOMBfrHdTQLCd7SVrZeB07RWFdk3aAqA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HNV7hCY3; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=HNV7hCY3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F0C24004D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791815670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKwRz4QUPGDbJdjaFuLMpfA2bqdlLEpCL7HyH6C3+K4=;
 b=HNV7hCY3XQVNQIbrIpHgvUoQn3Qz7h8vNVSJcu1+qErKjBkWOBSHlNQxl/8WCXxAEAgbpA
 vdPzf65vG5H7kebkSeRJraKtJ8I3wbjYfxntjijsYO8CEQEwcTeKCotXxxEtsp6a7E7i6J
 Kur8GIXfIZdmlpo1XStfuAQ90F9lQtc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Yfha-EgvOsy4iY2-N26Hcg-1; Mon, 12 Oct 2026 14:34:29 +0000
X-MC-Unique: Yfha-EgvOsy4iY2-N26Hcg-1
X-Mimecast-MFC-AGG-ID: Yfha-EgvOsy4iY2-N26Hcg_1791815668
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so13415845e9.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 07:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791815668; x=1792420468;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IKwRz4QUPGDbJdjaFuLMpfA2bqdlLEpCL7HyH6C3+K4=;
 b=kLDYGQ5skX2GPJ+ecy2O8ViQwihbOyZWsmmgJaZUHBnncP8qD5SI5vyzey/GPinDNS
 7vzKUKT5+kzyo9KEpeSdc8Yl3vg6lkukfmwjvVMv7TH0D1HSSGPvn2DEuORAYrqXZ8df
 ht2pNOqqx5F3HRIFwQ7iwJd9hifuYqorCRyyE7Z3tr2F9Tkwj/u4iLaHTJJ5Ppum71zJ
 G9PGUsiNuJMCigWoBCl27EIv1M493FHnhdEhCCP3+Vk4sgEABpVDRJ9H8cbqEAW9oIiq
 MGEH61lWr5/c9rAif5hvTByh+zHXZcuXXuNHGpqsU8QnVvWa1lB+Mtsq2s1/zT19OKQ2
 ykVQ==
X-Gm-Message-State: AFq9FYKDEtexwgkFnwUwE5fiA1lXh6RXrgwP4k2EeMYmVCT8O/RRY/QL
 WbI2xstV1qJHkN64eh3knDSkGiKgDBFY7CFc1+/7JBnoOxMLAbIfu91C0yeyaa0vZ5Cn1IgtQSO
 Q/sc/LkGVs/PkaqGLgxo7p96Mt7iBMz07gDFMtuZ2gCqwcI8iGlkq/TUyHhpeT9SeTgwvf0Y=
X-Gm-Gg: AYBFou1bFloxeVcXUyK3IhOyO2qkPSPPemeFQ5J2v/F1KC7e0ZQr9M3Hz/jW4M5UsGt
 B68C5MXBTbYFd0TCuOMaaUeyteBya0mONsEYl45b0hmhfaiYxpr8Zh6LHSdsJUpbgxUi/kjr5Av
 CyZ3pb8GKGwOsthY38MtyEOC89YKcD0qw2NzT3394PAFS5QkPvjMSRw2awIEJxxLtWCiFjmZBhF
 cYWdED55umh3Qfw6suWfaXtMzfv04tXVBox6wiaCfcGdmFTmLHOfJNSSn8VrqDD3Y4TUovrhfkh
 yVtCTxXofE8ocheoEQ7YOXHjOWJ9/Q+SoDdo13zi25X+9HO2KB4a3xU8a3xa0trFDCKcbokMSD8
 F/xkMOjblmKhg5KrU3ow9J+fzw11OW9hH
X-Received: by 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a18e49d633mr171857915e9.7.1791815668131; 
 Mon, 12 Oct 2026 07:34:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a18e49d633mr171854335e9.7.1791815665546; 
 Mon, 12 Oct 2026 07:34:25 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19471edd5sm355048835e9.11.2026.10.12.07.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:34:25 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:34:01 +0300
From: Mohammad Heib <mheib@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH iwl-next v6 1/2] i40e: move ATR sample rate from ring to
 PF level
Message-ID: <aszuFVtf-LO1O8_7@mheib-thinkpadp16vgen1.rmtil.csb>
References: <20261011134952.54887-1-mheib@redhat.com>
 <20261011134952.54887-2-mheib@redhat.com>
 <sashiko-outbox-168217@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-168217@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WyLyLSVPXS7A_W3dE4EYVDCnPrx-umKoo4QaRhMKDCY_1791815668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On Mon, Oct 12, 2026 at 01:50:32PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] i40e: combined reset flags downgrade reset level to weaker PF_RESET
> --
> 
> commit 6e65935fd380dc5da870cee78bd93449fc30b74c
> Author: Mohammad Heib <mheib@redhat.com>
> 
> i40e: move ATR sample rate from ring to PF level
> 
> This commit moves the ATR sample rate from the per-ring struct to the
> PF struct, initializing it once during software initialization. It also
> triggers a PF reset when re-enabling ATR so that the TX queue HW context
> is appropriately reprogrammed.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > index 0ae50d7f34651..bc9b4a2bc23b2 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> [ ... ]
> >  	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
> >  		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
> >  
> >  	if (test_bit(I40E_FLAG_VEB_STATS_ENA, changed_flags) ||
> >  	    test_bit(I40E_FLAG_LEGACY_RX_ENA, changed_flags) ||
> >  	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
> >  		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but does this unconditionally
> overwrite reset_needed? If I40E_FLAG_FW_LLDP_DIS is also in changed_flags,
> it looks like the I40E_PF_RESET_AND_REBUILD_FLAG will be silently dropped.
> 
> >  

Right, as you noted this is pre-existing — the plain '=' assignments
above already clobber earlier reset requests regardless of this patch.

> > +	/* Re-enabling ATR requires a reset to reprogram fd_ena in the
> > +	 * TX queue HW context. Skip when FD_SB (ntuple) is already
> > +	 * enabled, since i40e_configure_tx_ring() sets fd_ena when
> > +	 * either FD flag is active.
> > +	 */
> > +	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> > +	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags) &&
> > +	    !test_bit(I40E_FLAG_FD_SB_ENA, new_flags))
> > +		reset_needed |= BIT(__I40E_PF_RESET_REQUESTED);
> 
> [Severity: Medium]
> If changed_flags contains multiple flags (for instance FW_LLDP_DIS and
> FD_ATR_ENA simultaneously via ethtool), this bitwise OR operation can cause
> reset_needed to contain both I40E_PF_RESET_AND_REBUILD_FLAG and
> BIT(__I40E_PF_RESET_REQUESTED).
> 
> When both flags are set, does this cause the weaker reset to be executed?
> Looking at i40e_do_reset() in i40e_main.c, there is a cascade that checks
> the weaker flag before I40E_PF_RESET_AND_REBUILD_FLAG:
> 
>     } else if (reset_flags & I40E_PF_RESET_FLAG) {
>         ...
>         dev_dbg(&pf->pdev->dev, "PFR requested\n");
>         i40e_handle_reset_warning(pf, lock_acquired);
> 
>     } else if (reset_flags & I40E_PF_RESET_AND_REBUILD_FLAG) {
> 
> This means the requested rebuild from I40E_PF_RESET_AND_REBUILD_FLAG would
> be skipped.
> 
> Also, looking at i40e_handle_reset_warning(), it appears to synchronously call
> i40e_reset_and_rebuild() with reinit set to false, instead of deferring it via
> __I40E_RESET_INTR_RECEIVED:
> 
> static void i40e_handle_reset_warning(struct i40e_pf *pf, bool lock_acquired)
> {
>         i40e_prep_for_reset(pf);
>         i40e_reset_and_rebuild(pf, false, lock_acquired);
> }
> 
> Can this lead to the VSI reinitialization being incorrectly skipped when
> both flags are present?
> 
Good observation, but in practice this cannot happen with the current
code: the '=' assignment for the LLDP path already overwrites
reset_needed before our '|=' runs, so the REBUILD flag is never
present when we OR in the PF reset bit.

That said, I agree the reset_needed handling and the priority ordering
in i40e_do_reset() could use cleanup. I'll look into addressing both
in a separate patch.
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261011134952.54887-1-mheib@redhat.com?part=1

