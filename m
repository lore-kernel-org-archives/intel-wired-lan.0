Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B05C3DA4A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Aug 2024 10:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E25441353;
	Fri,  9 Aug 2024 10:52:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZxVVu3dReavX; Fri,  9 Aug 2024 10:52:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5292141359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1723200771;
	bh=kiWJE5/8pGLVo4Gm+PVZVQJBpcxBPR8cvNhJKGvGcfs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=83H64QWcFF+Ax048uZuP/ZP5m7CWYPjLECnUVobz5lK8Nqru3g8DVoF53YFfGMCC9
	 GoangEcMhSMxrAhBYX0Onp7p9mDMbW7ofuDhCniLrGNVlcnvZgmhoD+ClQ9v4Kn85S
	 zrcfgUwJvtfeFAIKLgdwdpbUyPbynhzDgy4LJHvhKXBEgR+LbYuKlCfome/1akNqX7
	 5epGnQ9JjwQIslsCaJ9kTlpLZw7u3Aj7edBY5Kv9YgMuM/TR3ArWgtJNoBqQvHxuSm
	 /Y7xBP1s2PrP+2EFt4yNADqgzaoIFI8/SB1ciXRKMMVVoeQS4YDCWRy/aRujwnflf4
	 TntsmjZUH1XFg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5292141359;
	Fri,  9 Aug 2024 10:52:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id D8E6E1BF36A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Aug 2024 10:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5A4B403BE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Aug 2024 10:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8aUuyQyYxTu for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Aug 2024 10:52:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC0F14012B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC0F14012B
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC0F14012B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Aug 2024 10:52:47 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso2128664a12.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 09 Aug 2024 03:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723200765; x=1723805565;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kiWJE5/8pGLVo4Gm+PVZVQJBpcxBPR8cvNhJKGvGcfs=;
 b=TLT5kr/zchaedQvdbe6a6dVo8JLSZLGUFlrSzzedsFOoo+5VhVwgDUenn46V8j3BRM
 0wVPvgtu+tapTYIGj2rRDWQGPfD1OyNOdC2JptdHknAn/Xgu0CZLY5nUxwFEvdYCRZK/
 TrRJf04naSldO/GTYNK+VPNpjAwVfSIgE00r+Yupgua1NyhPFz/criygcbPf2vvUhboZ
 ap8SPL0/myfNzZzirBOU+JAoAeytlIvhSy6Rcvg2M0NXIf0Pcz0FOh/KDtcjNeC3sYpZ
 M52ksQENTgeCxmMV/VdYnPQR7LcBAdX3svZDQ+YUCPKHp897QmNvVTc7lIdx6uL3Vo8m
 kcmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkPTrUp7HaNvcLOMZaR6yuFTtrYh1aRMqqYYMXyU4tVzPSB3Omj7mfGDZD95ZmByZqrT23xDxtXbjkj0pVgCfr0JQo0qFssmqY7YMlc8c5Eg==
X-Gm-Message-State: AOJu0YyUxQA/28Eoodm9oz9/gjFW9oYSnTZ9ZiUbwx+fi96F1FV/xVaR
 VWash0xWMKXXqm9Dn1zZCDHLQUOb8Rt0lAMpuIjIbp8BN9CM39E6dU951qtEeDc=
X-Google-Smtp-Source: AGHT+IHIjSqUukzlL4ZOQy/Z78vTSNK4/Bb7hQdjn9oY4m/EVfxnr+qH/0fi0DE8JWDE4pjrMmHT8Q==
X-Received: by 2002:a05:6402:2790:b0:5b9:462d:c52b with SMTP id
 4fb4d7f45d1cf-5bd0a52d861mr1088651a12.12.1723200765091; 
 Fri, 09 Aug 2024 03:52:45 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2c29f79sm1437475a12.33.2024.08.09.03.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 03:52:44 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:52:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <ZrX0--lPBusR_aKE@nanopsycho.orion>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
 <20240808072016.10321-2-michal.swiatkowski@linux.intel.com>
 <ZrTli6UxMkzE31TH@nanopsycho.orion>
 <ZrWlfhs6x6hrVhH+@mev-dev.igk.intel.com>
 <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08fbb337-d2f1-47a7-871e-3890b34a782f@molgen.mpg.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723200765; x=1723805565;
 darn=lists.osuosl.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kiWJE5/8pGLVo4Gm+PVZVQJBpcxBPR8cvNhJKGvGcfs=;
 b=kHCCIEZg/OpNG9EIgbaaYyVx/iZPcu4+RNNTkr3iOf3FWd34zLY6+KG/kCiv9GEQGL
 NqcqFhWfqbefLU7xiM86tHogmdtA1ORIU+hQsgxMFKid4N6Dt+pTlEI/aQ9xbOIfBose
 HDM8Ngp8hUOynIGTpXXAS2kAvWwGmCWk9fDmJ5h3tud242IDzEh9O8wQGtEXMOOgCs9F
 GzfGM6FKE6WfFfEl+4szFvAu9kjsdV97WrrimcwUkWJIsN0jdSh0bdNXvdOBPx+2usvI
 r4ChPAWEP9O46/ZDeZCFt/pBJMGD68s6Vohc4FeSmskBzBXkGpwRcjLa5yJshgR9OZla
 /S3Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=resnulli.us
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=resnulli-us.20230601.gappssmtp.com
 header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=kHCCIEZg
Subject: Re: [Intel-wired-lan] [iwl-next v3 1/8] ice: devlink PF MSI-X max
 and min parameter
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
Cc: wojciech.drewek@intel.com, marcin.szycik@intel.com, netdev@vger.kernel.org,
 konrad.knitter@intel.com, pawel.chmielewski@intel.com,
 intel-wired-lan@lists.osuosl.org, nex.sw.ncis.nat.hpm.dev@intel.com,
 pio.raczynski@gmail.com, sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fri, Aug 09, 2024 at 07:18:38AM CEST, pmenzel@molgen.mpg.de wrote:
>Dear Michal,
>
>
>Thank you for your patch.
>
>Am 09.08.24 um 07:13 schrieb Michal Swiatkowski:
>> On Thu, Aug 08, 2024 at 05:34:35PM +0200, Jiri Pirko wrote:
>> > Thu, Aug 08, 2024 at 09:20:09AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> > > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>> > > range.
>> > > 
>> > > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> > > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> > > ---
>> > > .../net/ethernet/intel/ice/devlink/devlink.c  | 56 ++++++++++++++++++-
>> > > drivers/net/ethernet/intel/ice/ice.h          |  8 +++
>> > > drivers/net/ethernet/intel/ice/ice_irq.c      | 14 ++++-
>> > > 3 files changed, 76 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> > > index 29a5f822cb8b..bdc22ea13e0f 100644
>> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> > > @@ -1518,6 +1518,32 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
>> > > 	return 0;
>> > > }
>> > > 
>> > > +static int
>> > > +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>> > > +				 union devlink_param_value val,
>> > > +				 struct netlink_ext_ack *extack)
>> > > +{
>> > > +	if (val.vu16 > ICE_MAX_MSIX) {
>> > > +		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>> > 
>> > No reason to have "PF" in the text. Also, no reason to have "max MSI-X".
>> > That is the name of the param.
>> 
>> Ok, will change both, thanks.
>
>Maybe also print both values in the error message?

Why? The user is passing the value. Does not make any sense.

>
>> > > +		return -EINVAL;
>> > > +	}
>> > > +
>> > > +	return 0;
>> > > +}
>
>[…]
>
>
>Kind regards,
>
>Paul
