Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369C606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=4H4L5ZmC;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=f00LtqH3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28F4F40541;
	Thu, 26 Nov 2026 02:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cS9haE9lA4sG; Thu, 26 Nov 2026 02:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21A4F40560
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795660021;
	b=RwhUCHYvB4ZI6TvZbLCcU2Iqq8UG6NdncRepF8Tb7g2FnEnp/tIWLZO5PlMuisPtKbcy
	 s5m3Z/AamTpYr88BnR0U9LHxgKQKFPJazAAzpTtjc/8F5WPZkLHrucaM/Dx4q2AwSPgXF
	 iSNFR4wAtKqjEeukQAJE+sUEoG69FqWwYX848ZH+Iwoq0efPB0Sd6EWrJCPY0OAQYlviv
	 WT3RymvaMUzmyvuFN1sftlwIL6nEau228lb5Qy1vwphBlscGhz2fy+EJgxUmxfIQzNqqq
	 B75XfBwYPQ0bAjeC+5mItgrv0slj60ww2KmhxSr9IZRDnpnfG0kw7ftveSMUZ2+nddg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795660021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VZ0LpREsSiaCZ1xvrAarlAYj3hq6yIUoz1ZqZEl4im8=;
	b=UVe0Sr1KGhNeq44PXas+iXgXZMTcK1KaBgwf15c0WEcfYSexkdbwCJFP/IRQ4nXmV+ol
	 imUIK0cBG3cY/mthyXi73GnJBR+/dWT+g0qJ0xPGuBfr1EZk0U801/lZ2rJVzy6aExOGj
	 Vzbz2KLhXxML5RkjRlbTjYU0h7hojni/ZmVLVDMVQmb1OVgtoZbDP+0FPBieBt+nOT1x7
	 bjRRd6tnLvKF4v9ap+TL4vdLHRFhAIAtMWRv9MI58+f7PbwffjAfbhsWcS/OR5NaGun/j
	 6obT3M/26P9o2u2DZ3xQ5GhySRCuTKfNyE3bfoutjX+vXnl4bo4kHi7QKibYWQNpZBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795660021;
	bh=VZ0LpREsSiaCZ1xvrAarlAYj3hq6yIUoz1ZqZEl4im8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4H4L5ZmC1MbqsSw5SGRH4U6ZFSi4KHpIY9/ObGsBSGJlGnQ2WoQJo10FBA5gEgWiq
	 ks1+Iqr9bGqVhzJyNqHnji4Uvcvzq692pJ8qTR8N9CTDz8NSdHJmENAp0ZimJ5ZwKB
	 zTIN09IfEMJxp2YPMi68Jya1ijazd3xw6tE8gtdkOV0M2iArkQKksUStUATecgMeGp
	 Ck/HjJHQB61RcX3szydWKCMKyaewtTasyr7Vy43/IPfHL80OAzJEe0U+Dem8pJ7qTs
	 l2eRwKjeYlVWxXlWab8k2+ZhYVTfK51ROscJ0uH77YOqBmtiYVuCBzE3nXYX8s1rI+
	 g7ApXXS4zf4Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21A4F40560;
	Thu, 26 Nov 2026 02:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3F131C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D111660725
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RkrObH5krSKT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 02:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D59C60671
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=acelan.kao@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=f00LtqH3
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D59C60671
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:26:57 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4AE313F62E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795660014;
 bh=VZ0LpREsSiaCZ1xvrAarlAYj3hq6yIUoz1ZqZEl4im8=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=f00LtqH3q59SIz4jEhz/G7Xi2UaqG7ATPnX6nbQmtMBMQLmnwL1P6WmbfJcCxk3FR
 H0NB4UsHCC4JI/rWDkLcZEba1tJbhPDY/wDsJt9cX12eb7OiRWCkQBnnL8G+alWmbt
 YWnV1/nxW5EM8VBnyyGbGsdiT5QGiz3/do/I+teJp4vdkvK79wNYeAnI3Hh/FVwddz
 TxtHcZEZO2Qcc1Cl6nCBNmhgy8vT0RkF76I1pY01naU0vffOM9D018CJerW6NAZGiY
 gfQynXCKKeHovl13RlT10BtqCEl6PVZ7CwFHUG6q440tOgxhgoyLlFHezHYHepT0Kd
 q6eLt90gs2yJ9u+VrjD5DXp3roQegOVX8cmk8uquw1zr8CTvCkBDHT8iLqWWY5wYTj
 HS3emDEqp3fPDAR5WVQXGsoMy4IPoQX0lWrOH5MNeXk2GsliibsHaZKyTcSbEvAQ5S
 lFp2RMr2boM3pxiFIY/RRFFGWQUfh/DoDjX8zoDSK0VnKCgp8sjfNk4L/VsF2PqXke
 dsnKitFTCzN5cGMWuc+Jmrfns7Jerpq5Q1YIdgbCHiSSHySFpzFvU3r80nM26O9Odu
 1FsO1sixDnxgjW9wK71h3ZZhac0lo+3YMKrEim/8K2Y41/KsLlsHnKxpvu/TiWat05
 ZWMCH0X5f5giQB76eagC+PMg=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd60e4e8bc3so4392335a12.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 18:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795660012; x=1796264812;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VZ0LpREsSiaCZ1xvrAarlAYj3hq6yIUoz1ZqZEl4im8=;
 b=OKSfFm3PN4xj7hUdxS2OdoDPaZucU4xQ5EBvxWCAk+InTV6voECaUr23kV3480I3LW
 KF3G+6BGEblu8062T8XHKy/3nDBp+5b8YzUq9LBZ6HOwexAEYMgfpUeW1Da4J+dbojW1
 wg1DKysVbdIozxeqBzBdX7uUtXH0K4Lc2qF7dSC62yMw+X3hWWGu/9RUpAJgSIyq6n7X
 k6Q2tvABh77f5XY0BgOMow0ozX7NhNGcb+KbDURUGIAv912EUoLWgGuNgdOd3ge2vbwy
 w+jPCeEXQKZHKSRRIX1WnhLpy0hZsCBh3mu1jzwxN7ew7cXRh02p2+kAVfnmjZcI8p1e
 mqsA==
X-Gm-Message-State: APuU4Z+EiiIye4Z92EG1c9MDK8zCYNsG7wNv2FcYj40T3qMRb3Kjf4qF
 EHetF7hlGBi+nDJKeYmnV96XWDoJNPIJ8swDs1FKISuCQfmcBTggI1i4fgST7e+Dsyu5Sq79+b3
 d9XiVBxAaa27wukGUzlRthA1iRYB944/j1vhxefoaHp6aaXTmWzekkTDf4dLQIM4LENlOxFv6uS
 YIH9nvmOxTYIIZwtcwMOM=
X-Gm-Gg: AZFdTZeN0JX51sdIiYwbTKASBpyy1a1MocpnylnzcGoPtKEKvOfpEr7tj0bmaCeTBN7
 D3VqGgWCAdesnrIzKVzpNpsP6bhYXx4cx1UqFCT8OXuLGdNV4TMxaBoRTV7uNfKyIoSB8IS8sfi
 SmizFptFiXksQlQKWEVld5loF1My0POK73jvCGN7JSCoSFOF/qiLAC4WEVvMkwQphD0WddNtNYt
 0PDPUQLrS9MQ3LqfEFeiInOxVDbY4D/85CdupQtHj4uXhKdyc9A6YEx2cZldMDDDspPPvZ7DoUa
 rt7rja4ByFibdxY25RYhmAc+4M7ra8Sx/isUPQkKCi7TwRkhUjuRCBsIg3hpjWlDYExcvF8koS5
 EvJfS06hs/D0e7w8EnaXcuHvtM6r/MQsi9s8JKm9UL2Wu9rYG9LAjjCPqIdkNoRV/zqw3bFqVdI
 6a2wVbIE5Q1yqvC1fAt8rHwIaPaQeo
X-Received: by 2002:a17:903:298d:b0:2e9:740c:36c with SMTP id
 d9443c01a7336-2f03f1ba67amr192049505ad.41.1795660012469; 
 Wed, 25 Nov 2026 18:26:52 -0800 (PST)
X-Received: by 2002:a17:903:298d:b0:2e9:740c:36c with SMTP id
 d9443c01a7336-2f03f1ba67amr192049315ad.41.1795660012059; 
 Wed, 25 Nov 2026 18:26:52 -0800 (PST)
Received: from acelan-Precision-5480 (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee84027sm95486895ad.7.2026.11.25.18.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:26:51 -0800 (PST)
Date: Thu, 26 Nov 2026 10:26:44 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Ye Shu <hello@shuye.dev>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: disable K1 by default on more MTL+ systems
Message-ID: <aweXIb8RzSVHmTwT@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Ye Shu <hello@shuye.dev>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261119001818.513503-1-acelan.kao@canonical.com>
 <20261124022233.1234651-1-acelan.kao@canonical.com>
 <087a9cf2-bd0a-4f57-8dcf-9b0962186fe1@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087a9cf2-bd0a-4f57-8dcf-9b0962186fe1@intel.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 09:42:20AM +0200, Ruinskiy, Dima wrote:
> On 24/11/2026 4:22, Chia-Lin Kao (AceLan) wrote:
> > Like the Dell Pro 5 Micro P5M1260 added by the previous patch, other
> > systems with an I219 on MTL or later no longer enter S0ix during
> > s2idle since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake").
> > Every suspend ends with:
> >
> >    intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)
> >
> > Each unit ran 3 s2idle cycles on kernel 7.0 with the default K1
> > setting and, if all of them failed to reach SLP_S0, 3 more with
> > disable-k1 on. On the following systems the default cycles never
> > reached SLP_S0 and the disable-k1 cycles all did:
> >
> >    Dell Pro 14 PC14250                       [8086:550a, 57a0]
> >    Dell Pro 3 14 P314260                     [8086:57b3]
> >    Dell Pro 3 16 P316260                     [8086:57b3]
> >    Dell Pro 5 14 P514260                     [8086:57b3]
> >    Dell Pro 5 16 P516260                     [8086:57b3]
> >    Dell Pro Max 14 MC14250                   [8086:57a0]
> >    Dell Pro Max 16 MC16250                   [8086:550a]
> >    Dell Pro Precision 5 14 PW514261          [8086:57b3]
> >    Dell Pro Precision 5 14S PW514260         [8086:57b3]
> >    Dell Pro Precision 5 16S PW516260         [8086:57b3]
> >    Dell Pro Rugged 10 Tablet RA00260         [8086:550e]
> >    HP ZBook 8 G1i (14/16 inch)               [8086:57a0, 57a1]
> >    HP EliteBook 6 G1i (13.3/14 inch)         [8086:57a0]
> >    HP EliteDesk 8 Mini G2i                   [8086:57b3]
> >
> > Add these systems, matched by DMI vendor and product name, to
> > disable_k1_list so K1 is disabled by default. The HP entries match
> > the product family, which covers the screen size variants.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 98 ++++++++++++++++++++++
> >   1 file changed, 98 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index a8f0d3c0fd750..319c7a44f5a53 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -80,6 +80,104 @@ static const struct dmi_system_id disable_k1_list[] = {
> >   			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 Micro P5M1260"),
> >   		},
> >   	},
> > +	{
> > +		.ident = "Dell Pro 14 PC14250",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 14 PC14250"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro 3 14 P314260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 3 14 P314260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro 3 16 P316260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 3 16 P316260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro 5 14 P514260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 14 P514260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro 5 16 P516260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 5 16 P516260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro Max 14 MC14250",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 14 MC14250"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro Max 16 MC16250",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Max 16 MC16250"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro Precision 5 14 PW514261",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 14 PW514261"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro Precision 5 14S PW514260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 14S PW514260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro Precision 5 16S PW516260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Precision 5 16S PW516260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "Dell Pro Rugged 10 Tablet RA00260",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Rugged 10 Tablet RA00260"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "HP ZBook 8 G1i",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 8 G1i"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "HP EliteBook 6 G1i",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 6 G1i"),
> > +		},
> > +	},
> > +	{
> > +		.ident = "HP EliteDesk 8 Mini G2i",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteDesk 8 Mini G2i"),
> > +		},
> > +	},
> >   	{}
> >   };
> Hi AceLan,
> Thank you for this investigation.
>
> With a list of systems this long, covering multiple generations, this
> suggests a fundamental problem somewhere, probably not what this quirk is
> intended to solve.
>
> Furthemore, as I said, I am not aware of the mechanism by which enabling K1
> can prevent SLP_S0, and the GBE_D3_STS as a blocker seems particularly
> strange.
>
> I have asked our internal validation team to investigate this, at priority.
> First I want to understand if this is limited to Dell/HP systems, and if so
> - why.
We have Dell and HP machines in the lab, so only systems from these
two brands have been verified.

We also have few Lenovo workstation/server here, but it looks like
they are not affected.
>
> I would rather hold this off for a bit, while we investigate. Though, if the
> investigation turns out complex, we may apply this patch, at least
> temporarily, until a better solution is found.
>
> --Dima
>
