Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84DACA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 23:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E9FC607EC;
	Tue, 29 Sep 2026 23:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avOvSFqBLMcu; Tue, 29 Sep 2026 23:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE11C6081F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790723616;
	b=cqYOVDLScraOxRWz+14tUgPlEdlE62WD4qkkGi3LDQEH1TsGZ7vaZ2sbc+z6FEQNQgBj
	 WSHg278cjgwsLJ2REsCJySUBKo7uVsYZxB4lAq8TXwEsiuWs6mwurew5gbfGImVRpMn9O
	 x3ls9SPzSSTgYrAeuwGQ2yAAzAdA4qeqcoNJipVKS8zeTdK83IP6/HjkaaFFskG2XHcYQ
	 0AoFUszZjZYI79qha0v47Q3pMQmTcDJPrNdHGlyrQivMQU1v4ovynRp6AVgKGjGsATTsS
	 SCPAV6T+w/UB4iOZsFZzhuP0AeGirC3vNjCuja5ocgZ6Ierr8AEN2T9KFZt15sqv4pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790723616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
	b=E66Ytxfr+DZD11RkdhZE3zX/XpZRIyoof0XdjSU7sH99kgn9D1CYOEND6Jq2pncNxyuB
	 y3id0AMG/DTEyDXAvM3fM3DEvz3ursJEwrtNBn4TzegCWzTD8PJP3OrRkdeVCv21neSDP
	 LRRTLcukZ12SdcFJkcTyjSr5PiMwq6IQZHAvV8BtgkY1w7x9yEZF/sscAAUxMSOcbQdNZ
	 IWzjJ9/UMmGnFU96XXsy3632oGLcyEHIUVxi7mdFDZYsQHSczhgmBlxVQ5CPEX9CMNIve
	 kQDDullf7zM/+wqe7hJID4HoHtm9C0MJ9GV7fzEf9ZkP+rMx9H9joL3VRuGOej9hfRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790723616;
	bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KjZPjOB2+Bh4ElHVorlNbemU2CO880g0TW/QyaKI1hEf5uYkDXxmxav2TppHturZp
	 Pc6/ubj2pWmuJVy4TPakqHy0p5QMFchPQGpmPWWQ3N+l0XGqKYx3xCVyV6TJ2z6D8x
	 exDhHzFp4dW1SorRgZ0MCTJtJqqmMRHE9uk/OvxPv19ww9iB7II57k2hAHbf8YiLB0
	 e6pw7hwSGQKmBGtY7no4PymH44RFCnYCxW3u1ZwUT9srv1B6FjV5PNsQ4fBij63rGJ
	 sFaAY2FzRQh3HO/0RnPljwAAVaEZyH8qmnUHKPsjgJPyLzr0Zcb5NsdkCM4ODPQaHz
	 HnsBBPNgHGSdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE11C6081F;
	Tue, 29 Sep 2026 23:13:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B4021282
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 23:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A573F40354
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 23:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTYyr4m-Z-7R for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 23:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 55B61400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790723613;
 b=sA8qm222p5BiqCBjiVqdHtaGPxVVmDaciv+zE7X5yLdp9pL+zJYpJ6X2bK2LNApZb5i0
 2VDI3bHmPSq7liaG2BaNB2XFWGaImtPMLnuG9cwIEH4xU8ICpzfaSJJ/UxSlU/7CZuNy8
 7RK6C5LqsujVauK4eCLgsL9svVf6b94nJ3kN521tYRb98nmVOr5siCVaF0r1sXZd7Ze7z
 gBmvgcB4sgfSBZ0GfD8wRqRhGE6lc6de+1k9Pm3F26XN4gEqWbyEGqEQxah2ciDL67UBl
 BRGp4i0L9CEBtfVMUQ7SHmHTmO8it7zKSzOcIsUFwsTCDQUO0pBZTDyokt7jBY0lGNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790723613;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
 b=c9JaqotS2Vlb0wGusRP+f0iz8A4oQ6HgZvpzDZoiw+0IL6DtFgGyDh3j6quGKjFfjfCi
 XKxFllNxyugapKSAwVjnf55f6ZGpupnjRsk0e3y6gYSR7/oxe4/r0paUqd6xhHDCdvQR6
 zCG2b69wO3WrckMpfDKxK1zVZsWA0nJRLC2npN0+wckg6UgIi2JTkH5wphBT7UR+ZgATq
 iq8PTqwl1QUeDUXRISFGCcLPwwrIARmDzm/RFK53L4Ch3OhyupRPDSE7z5fC1QEfLBPrW
 pkyNdQ6XaKcw1V0biuzy3maJWsu8FpGpdgb9aHPo2objEbN+V3ZswJ30eNbrPYk/knA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=dama.to; 
 dkim=pass header.d=dama-to.20251104.gappssmtp.com
 header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=zQIMPEPl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=joe@dama.to; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dama-to.20251104.gappssmtp.com
 header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=zQIMPEPl
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55B61400AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 23:13:32 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so2233534a91.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790723612; x=1791328412;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
 b=zQIMPEPl0nvW4xF0IaVoy2NfkSwGExXKeTH32r1k1lJJK3yU9OuSdp+mNY11zjx8SJ
 Sk4U6DF8I/GniZTXqwJFP3Yfj0K0Gvorpup4UYv4M5tIE06ai8fD+qvW2wW1O9+3IS/L
 +kSZsh1abHK+7+U6y+73fHwRuDCc24W5M/L1v46uhVm/R5BBoxeCYWO+7ihPAskagWqB
 buQ1ndTBZr2eXEzcojwBPLWeau6Bi9bK8t200WSQWM8brzSTpbQGJASigvmUFmLV2j2R
 o9fbvdsi7duLNIfQ6TeEInuiDvlQ4Iqb+FWC6eJ7zC7rCU13x1OFinDcCdyqp4TMv2L0
 gI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790723612; x=1791328412;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
 b=ASRMvyyNcXLMBMvhhE5tYu2qetheECkMv44/84aG3lfMHOx/iGseH29PbK9TBPeF0+
 nVzkNK6Kwn0YzSExIuKlPLkJH/bnDvHUF975P3828E3xIbgKkDttPyk+FeZ0DwMYSnJ7
 Jet71AFBtaphn0dfnPoJxEy2rF8Oka/yMq2jA+6wyVSW6uBrqM9CoY/U9Kk/BBnWd1oq
 dkBXL/pcS1YzAW0cYHLX+YEBYG1fxQ0vuWot5377Gd/qiHCFFljDmCn/pGJVMS2l8/ke
 RUtyHyh8pBsSUW4K52WfB9odoDovm3PfbKrgHjndYKqsFw4AFl3PM5SgYIu9Bn2FBDuz
 KrJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVAA3r8HS5lXOW9IPSKZElRcVd2yvBMFnGkeZFKgG9NUtqKGHgsPIp1j2yL5TphTIB/nMh3gGBcltDy82vwno=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKrEK0YHRJSFoy57syquihVO6c92LF+MhuqXQaJokBFRLG+SLur
 1HCMPxZqaPdSP8Sef/lcqVxOXIlzJ8D8eAE1EVOFODeV6itInQ55T7agiDi1koS7lRw=
X-Gm-Gg: AYBFou0xxthKuS82wag5qnhJ4qlwZ/Bheg8oQT/w82XB07zkWeMSd3malsli5Ms/5KH
 SYRFg7xfXtlUxPq3pokAMjQ0rsL+9CJu2LzVzscY+ImGciE4iBB5yBlrjuDUzb5wwEQLSYkJLUg
 3yT8+vwL2H2vnrCWv/mHivW/9fxF0lh1Co9HWLSXaAsUSBbD50tZpY6d8DUS0pMMB9mQLB/sjEC
 h+k3SWS7MrfdK4MJT5yyKqhudQPGy6yZpnxEgkzkNoW4RXDbMQ113Ts9+Y+wCVH1NcnU7TznE6D
 tVpEo/iW0X9mro5UGDe3ZD4rU7DJpoCvXuNnVjeoGAY0UMO8PMJhC4d8Vt8ef2eZGGhMsnZA3Ta
 tAYvhSJv33SfM1KZDT5Y8o2EEHghRnz+CKNbhtLbSH04IdCJS5OiYITKI9FfZRDKMJUY010fLNI
 NrsB3BBJYiDYTBxkVoz59Sxab9ZOPIb42J9FlogAHzpJYecIJADl1W+7pSrrHYP8rQ0Tg+J7eRD
 octClUfbgvP
X-Received: by 2002:a17:90b:6cd:b0:3a4:a3e8:22ff with SMTP id
 98e67ed59e1d1-3a4bfd9ec43mr734665a91.19.1790723604565; 
 Tue, 29 Sep 2026 16:13:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4ca3f3d67sm152927a91.8.2026.09.29.16.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 16:13:23 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:13:23 -0700
From: Joe Damato <joe@dama.to>
To: Filip Balluch <fballuch@redhat.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: rename init/exit module functions to avoid
 confusion with e1000
Message-ID: <arxGE+eYEmkxNQ61@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
 Filip Balluch <fballuch@redhat.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915122639.64936-1-fballuch@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915122639.64936-1-fballuch@redhat.com>
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

On Tue, Sep 15, 2026 at 02:26:38PM +0200, Filip Balluch wrote:
> The e1000e driver uses e1000_init_module and e1000_exit_module as its
> module init/exit function names, which are identical to those used by the
> older e1000 driver. Rename them to e1000e_init_module and
> e1000e_exit_module to clearly distinguish e1000e from the legacy e1000
> driver.
> 
> Signed-off-by: Filip Balluch <fballuch@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
