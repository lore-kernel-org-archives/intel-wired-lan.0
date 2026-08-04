Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1158C55172
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 08:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 649D140703;
	Tue,  4 Aug 2026 08:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4jzaO3INhF4; Tue,  4 Aug 2026 08:37:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 716DB406EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785832665;
	bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=afVAjNl2gLv016P2xlC/0u3HkyhXOl6BZoUcUCjD2un2HqHCWlG6gvPeEwUNJloqN
	 TSKjoQrzbxqjueJDThXV0FPuSkKd3i3Pvf5O/bl1iNoR6gcqWb7z/fO15bb1MZmgVP
	 berWv7Hi+l8HnVpWu3/M1wGqPcECosTaAwZC4yu8nvTic9xvyNSYiTGHdcg5fE6Yyn
	 m9rHnA4QqFcPP7vcyyhOIB386lwnsySaIQg8AQOie434Vvdn4C7u/zME+P4JA8QafX
	 p53vWrl99sy2fUlAO6MVr1zxTLFbFMUbcVaZF+eenCxlalfXxqWeiJsETGduHRsTjI
	 pjuzLXQIdFDNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 716DB406EA;
	Tue,  4 Aug 2026 08:37:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A578C26C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CBA94004D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BzJQ4mnCA3vz for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 08:37:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 421BF4002B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 421BF4002B
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 421BF4002B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:37:41 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E3C13FBC4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 08:37:40 +0000 (UTC)
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15fc5a1b7eso295127566b.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 04 Aug 2026 01:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785832660; cv=none;
 d=google.com; s=arc-20260327;
 b=iLm004S9jvLdPih3gs/ATak/dOqgUKdeQ12SGBgtoCiq65T9myjsEy33SxluhziS12
 TSF1PwewG+ke/inU+stgOCfhU1mLcPfa6vAYDP0MLjYUEsSO3aKqON3ur36U5myDJvaC
 xoQSTInQ1V1+zpa1cP7qe5+AtvkQI7mEIbf2c770oDdiHhR5LKP/6tn8ZlPg2yyRwKfw
 4MS/tshyHHGIljl43oH4adj2BgXD9lhAkTQzk6NkH88EQ5mmO4B4kYMdc904eD8SulkF
 0ELPUJ6Mu8L56k0ppkPRxKwL6X4X+DZngn6dgrkPGDrub+RtvK2/WZAOz4C0B1L8sur2
 vUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
 fh=EdeKlZlIpV2f0BVFruqxX0nfUcEqiJiLmHvhawhAzUE=;
 b=VilmNElYyPGwz3FZ93R7+Bhy1GkI8FI3XnIG3eXYuYHhaCHBXCOg87owROyuGFlfuJ
 y6o7nwaOzKR8pzrRAQiSdcEijpkfnItb9M829iTB26tvp4PoGDimS+bxZHSjZt2hTr93
 cbRVkR0rnj5WSLYcLcYOu4X6bsQ/bDLITMEJS+oJrwYXfXk07apKMDvHwVBdQtQPdFhM
 sV2xQzj/o1xY/rqaklfSVjUw8X3vdTM8a1tHRcYXmldk4PjacIpefeKWkzm1W+ph2Gl4
 li1IicT6wDW/S3CEeExV7HEPApWfVH3iWxSMCLY8RPvGYXYac+qzxYuIJezK1Hl/z4A7
 B5sw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785832660; x=1786437460;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
 b=OFUSasanpF2XMiiO2iFg8JB86ZusdRoo+uC9ZBlrVmndBcz5tGEiPUAS3++P6Z1h16
 lqtRZ7Yc+beLOs43SOclROdn9KZfNIOZf0dP9QsEhY8/JrJL6AGrdK085xGzfuX1zUJP
 svMkW19P5eb++DtYO4VfzxGu0oINCH3fV+/ybfKJPiI1KzkLcRhng1WMCaONXuabbBbL
 FoEuDpYaNb81Eiq2M0Q0S11cMr0fUNqAHaPZzaeGCP5f5pb7PMAwBAnRqbs5ij95jY5G
 Svv/e36m8y7yVFUVfmYAx7RuhcbMvb4hHtO66qDqMDo/8QeIni1u0CF0wk+gWdAqbccN
 jkkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpORP2dRtv9kyb3DXOBVRNcTIVXpWvfiRf0ZsYI5bSNPtzgVK1/igzYB5ebR6qJLlVu0+GXFTakcMkBsmPOHEg=@lists.osuosl.org
X-Gm-Message-State: AOJu0YztGgh2+/tHBb77FhPxIqWhjiFIy2vbCiSsfxqb9PyGW06rgC4A
 EDHVxxiDBoZVeIHKSFvR9jmFbUKQNlLmbwtafOGu+040CoRWGAm4OiYCwqw2I3zhHt+XNQXvXVF
 VFzuME8YH78GIXg1fJsuJ2XYqcBeVOT0EeQRWC7giK+qPmewgDuM12mVsOSRUSN/YpFeeESB4/m
 5X4hi4x6Ul3BASh1LOQZd1c2ZpXF+ZN9YK/mOukUvRJRu+sjI0Q3Xkve+hs2cYzQ==
X-Gm-Gg: AR+sD12M/xodSUnF8MYHKIJ5gELsxNbwTAL0VXldUoN31KrxWD5CfG0E3dtaXlR9L8G
 DhhqOUDYsNsGxHfNdg/Gn1BPbYMqhbhCHmHe0zUaVDWS0x+8ayFKZVy16rRsM6TTSrer32uwTKg
 1x4OTOEMEZDVeHULhF0xVPk6X31Hpg2jCRgoj61jJ0qrXwgwQd8ElXrYE=
X-Received: by 2002:a17:906:3c1:b0:c16:581a:2a51 with SMTP id
 a640c23a62f3a-c1fe80c6321mr881100166b.12.1785832659693; 
 Tue, 04 Aug 2026 01:37:39 -0700 (PDT)
X-Received: by 2002:a17:906:3c1:b0:c16:581a:2a51 with SMTP id
 a640c23a62f3a-c1fe80c6321mr881097366b.12.1785832659261; Tue, 04 Aug 2026
 01:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260731111008.1266444-1-robert.malz@canonical.com>
 <2e3101ea-13ab-4c9a-913c-999eb15207be@linux.intel.com>
In-Reply-To: <2e3101ea-13ab-4c9a-913c-999eb15207be@linux.intel.com>
Date: Tue, 4 Aug 2026 10:37:27 +0200
X-Gm-Features: AUfX_mz_Jae7dMx4vYi_J6NQ-TLRVLNHOrhEpeKex3aI5IX41UDwspVk9wh0tZM
Message-ID: <CADcc-bzeA2CeWUttUcPTOhS=4e0k3=NMFS7i4=EgJHe-w=1j4A@mail.gmail.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>, 
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785832660;
 bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=jH6oseHLZD0nW+2AezxIfZwnVA0jwJNEuhMVpefIdrzNXgco5bG2wuE0bMtY2MQhQ
 HpU0LjADgfTetREkiKwgBQL1ULc5G85zrIBVB19kSmaVyV7uzz3hHaOyKVV8IAjJa1
 IVc2tZ00adqmKgCkHQEt/Z7ICrFYy0fxmy+BRyz8ZPS/bCGpKP2DMTDD6UHrEPLAXT
 XVK9Xd2AReQBY1+cSpEMp8LFPZ/JWJ+hWR8HfvbneWYI/k3T1KlVSLgl1UnOIy9Lp0
 cAeuGhRK2P9WVORd3v7YJO8ZFSpX/+cMCNuQy33ff31LJM7B66Dhwk8/jc9EGH4Txe
 Y26AdJ7gzp/PcugTwJfwZacNf9nSsG7yOgvUSvCTInldxma2aDZRN3spHYm9bIPTxU
 vhiPJAkCPhQjznJJe93BqBGpQRyTkjktI3ALWRzPwRCN4BG9A6zmXlEUx7x0kAeY0g
 zWKQLIPpAsG78FjFD++X9OIITe4wVyCMX+HAvcltVXiturcIYg2ektwU/ilUI9N8kU
 OfdFNlg8jWgzbfqEJPE4LeXs/CaWFvJd1IWfBMJptTxlVolSSnIx1ux/LoYd150WKs
 VVMPqX/JzUtzmbhSi0giCiKfCS9dpgaZ6iuZjEC7DgZCMI/jkelVdEdTPbS0jT7xHq
 pRy28K6qph+aDg7jQE2Q7j0g=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=jH6oseHL
Subject: Re: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
 each flash read
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
From: Robert Malz via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Robert Malz <robert.malz@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hey Marcin,
Thanks for the review. Changes applied in v4.
I removed ice_read_sr_word_aq instead of ice_read_sr_word as callers
already are using ice_read_sr_word.

v4 ref: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-2026=
0803/056281.html

Thanks,
Robert

On Mon, Aug 3, 2026 at 12:05=E2=80=AFPM Marcin Szycik
<marcin.szycik@linux.intel.com> wrote:
>
>
>
> On 31/07/2026 13:10, Robert Malz via Intel-wired-lan wrote:
> > FW caps the NVM read lock at a maximum of 3000ms regardless of the time=
out
> > requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
> > multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued und=
er a
> > single lock taken by the caller. Reading a large region can exceed 3000=
ms,
> > so FW reclaims the lock mid-read and the remaining commands might fail.
> >
> > Move the lock acquire/release into ice_read_flat_nvm() so it brackets e=
ach
> > individual ice_aq_read_nvm() command, ensuring the lock is never held
> > across more than one FW read.
> >
> > ice_release_nvm() issues its own AQ command and overwrites
> > hw->adminq.sq_last_status, which some callers inspect after a failed re=
ad.
> > Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> > capture the failing read's AQ error before the release; callers that ne=
ed
> > it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
> > instead of sq_last_status, others pass NULL.
> >
> > Callers that previously took the lock around ice_read_flat_nvm(),
> > ice_read_sr_word() or ice_read_flash_module() now call them without it.
> > The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> > dropped.
> >
> > Fixes: e94509906d6b ("ice: create function to read a section of the NVM=
 and Shadow RAM")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> > v3:
> > - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
> >   ice_read_flat_nvm(), rather than silently aborting the read.
> > v2:
> > - Replace the save/restore of sq_last_status across ice_release_nvm(),
> >   which could race with a concurrent AdminQ command, with a new optiona=
l
> >   read_aq_err output parameter.
> > - Add missing "Return:" kdoc to ice_read_sr_word().
> > ---
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
> >  drivers/net/ethernet/intel/ice/ice_nvm.c      | 79 +++++++++++--------
> >  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
> >  4 files changed, 59 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers=
/net/ethernet/intel/ice/devlink/devlink.c
> > index 22b7d8e6bd9e..5a1ab9654fb8 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct devlin=
k *devlink,
> >  {
> >       struct ice_pf *pf =3D devlink_priv(devlink);
> >       struct device *dev =3D ice_pf_to_dev(pf);
> > +     enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>
> RCT
> Also scope can be reduced.
>
> >       struct ice_hw *hw =3D &pf->hw;
> >       bool read_shadow_ram;
> >       u8 *nvm_data, *tmp, i;
> > @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct devl=
ink *devlink,
> >       for (i =3D 0; i < num_blks; i++) {
> >               u32 read_sz =3D min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, lef=
t);
> >
> > -             status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > -             if (status) {
> > -                     dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_e=
rr %d\n",
> > -                             status, hw->adminq.sq_last_status);
> > -                     NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM=
 semaphore");
> > -                     vfree(nvm_data);
> > -                     return -EIO;
> > -             }
> > -
> >               status =3D ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK=
_SIZE,
> > -                                        &read_sz, tmp, read_shadow_ram=
);
> > +                                        &read_sz, tmp, read_shadow_ram=
,
> > +                                        &read_aq_err);
> >               if (status) {
> >                       dev_dbg(dev, "ice_read_flat_nvm failed after read=
ing %u bytes, err %d aq_err %d\n",
> > -                             read_sz, status, hw->adminq.sq_last_statu=
s);
> > +                             read_sz, status, read_aq_err);
> >                       NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM co=
ntents");
> > -                     ice_release_nvm(hw);
> >                       vfree(nvm_data);
> >                       return -EIO;
> >               }
> > -             ice_release_nvm(hw);
> >
> >               tmp +=3D read_sz;
> >               left -=3D read_sz;
> > @@ -1945,6 +1936,7 @@ static int ice_devlink_nvm_read(struct devlink *d=
evlink,
> >  {
> >       struct ice_pf *pf =3D devlink_priv(devlink);
> >       struct device *dev =3D ice_pf_to_dev(pf);
> > +     enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>
> RCT
>
> >       struct ice_hw *hw =3D &pf->hw;
> >       bool read_shadow_ram;
> >       u64 nvm_size;
>
> ...
>
> >  /**
> > - * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessa=
ry
> > + * ice_read_sr_word - Reads Shadow RAM word
> >   * @hw: pointer to the HW structure
> >   * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF=
)
> >   * @data: word read from the Shadow RAM
> >   *
> > - * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_wor=
d_aq.
> > + * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq=
.
> > + *
> > + * The NVM lock is acquired and released internally by ice_read_flat_n=
vm()
> > + * around the FW read, so this function must be called without the loc=
k held.
> > + *
> > + * Return: zero on success, or a negative error code on failure.
> >   */
> >  int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
> >  {
> > -     int status;
> > -
> > -     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > -     if (!status) {
> > -             status =3D ice_read_sr_word_aq(hw, offset, data);
> > -             ice_release_nvm(hw);
> > -     }
> > -
> > -     return status;
> > +     return ice_read_sr_word_aq(hw, offset, data);
>
> ice_read_sr_word() is now a wrapper - can we remove it and use
> ice_read_sr_word_aq() directly?
>
> >  }
> >
> >  /**
> > @@ -856,20 +876,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *h=
w, struct ice_netlist_info *net
> >  static int ice_discover_flash_size(struct ice_hw *hw)
> >  {
> >       u32 min_size =3D 0, max_size =3D ICE_AQC_NVM_MAX_OFFSET + 1;
> > -     int status;
> > -
> > -     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > -     if (status)
> > -             return status;
> > +     int status =3D 0;
> >
> >       while ((max_size - min_size) > 1) {
> >               u32 offset =3D (max_size + min_size) / 2;
> > +             enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>
> RCT
>
> >               u32 len =3D 1;
> >               u8 data;
>
> ---8<---
>
> Thanks,
> Marcin
