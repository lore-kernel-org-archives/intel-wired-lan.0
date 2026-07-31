Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A72C54F54
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 Jul 2026 11:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4430B40FA0;
	Fri, 31 Jul 2026 11:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dw96674E5DqL; Fri, 31 Jul 2026 11:14:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F4EA40FBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785496445;
	bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YeMjeOne7T9n56aEsFAOs94cU6sTjORcVAEs7temjDKGI0e7VFZ+6Qq6l+BGPEwwI
	 B6y6TtQ/kQPtMFG3yolOg/iOYcVUzOOEJC2jucgY7ID0649WLsnUqryONg+DMfOvUJ
	 /xW+eyah3GGsxcoGCQu3wi9Gl0xJ5Jjm3v2ECPrKHmta8W1SAmjyMx53eedl58iD9+
	 H92+ABv+TF2xuk6OvmXveQHdIV9RTWvbRw7GTQBzzDq2dHVSTU1dgRk3SyhKVKKsE3
	 9M8enRa+Oks8nVWA1WGSRaNBzAUHO/XRkFkt67K1s2GhtR6XolqBczM5lPqGC831Pq
	 O1Vyt/QcHFLAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F4EA40FBB;
	Fri, 31 Jul 2026 11:14:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A84023F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 11:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C5DB81086
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 11:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_vknl3WcqOh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 Jul 2026 11:14:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 35B5A81080
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35B5A81080
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35B5A81080
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 11:14:01 +0000 (UTC)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 29E013FC12
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 11:14:00 +0000 (UTC)
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c158b6e31aaso69206366b.0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 Jul 2026 04:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785496440; cv=none;
 d=google.com; s=arc-20260327;
 b=jwvCQleAFQrHIBjXM5X0RzTnPYWmlm7vvRdufsqmS5AcB2diOHu+2EERzqGSBwyFy1
 kKgQ5OrmtSDnrexFoQ7Cjf3nAY2ScsqLZFtAp4N7jn3TpUpoLeGiKlD+uZq7/6yVnbW5
 Yfgu6Ky65+uhHynHJB3buAVqygR0tmQ9hHFzwKy9RgCCLuTUTlWMlddtIzaVm3bpUijP
 SUE+5IvyK48pyAXscO1RWwze4qHQ7LU/pkI2ENokJeOB1wTxowXPs5qN6hRvTUJZAZ7L
 bcZ6TFFvrfUTx4oCWCK7GxbwcXr3zZt+SVu6xn++0LY1gpAwkgatp7DgntiVVGmBxuvu
 cS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
 fh=SbXqRYU9wp46ylei0UlDqP+2yLBuTMbh1g5CJNYmVw0=;
 b=FtGk1XfixSo/bnf1fyPjQPeREnazjUtmFTu8y0xHuIgoM1TQG4Zy+XCYPHatwIFt9H
 12EyZiW5b9LQzYLRhbB1sy9EAm2w4HCKC2GM+Dhlr05mX/oRrk7GaBLy8vYiqsyJGEf+
 jenivIpBp9BkLvPvLE3B+7bTJ0A8qzDZFUqkhakuo927mLo++7R4zbjIiW5EKiQ6jv7M
 9g7DV1gfWUOIsu2ZMPUcZFg2VfUVw/YDQEOoi7lJgcFUrwp46QO6KAOu6zhVLtFsHAE+
 a+HXqbSnchaunLjaFTxhaXJwdmrGdlzVpylYq47qtDRZJuoESLPLWV88ew+LFDbE+7Xl
 F0YQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785496440; x=1786101240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
 b=WyDic8cIHb4RSHkBWI+FPDPU3X6PIN7WO+H883yeKS2MEJftjZNAhu0BQr0cfMdxON
 WOn/sAO0Cd/lsOoFBSkDg1+98/zkoAnRTIt/RDnJcrLNPH6G4vYuCW0EDF4PiF6W+jNy
 VRUGDlZHTJQ+/VBVwhO3kXbA3LS3MFtOPjYMfHKFD+FqhoWDHY5pDGVl3I6UByrIepr2
 zihJtrzsvD3cmFiClF3aUi9pVI/OZiK1WiNOGGsk1XwGzEnZ6G/N7M/xKL3hrOBXLmnS
 8mPZGrBOkhR4TKj48EXQtqEaiQ2RYGwggQi7bPsQsh0aO0T7+6MLm/nP4Jt45Gmmu+y0
 e66Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RooEh8Sj2L18UYDL5LzHt0ZKUBntUfPwRCMtGUo/1AT+xkkjOcRhN+OThBqc0q4P/B05TuN1gyVtixlOEg08O8=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwxqQnpWOKLtjw/OmqcEVyMfIOA5G+2TbQB7eXoVeBt6UjTodGm
 8Up0UZqV2EJ2g1fCnSzkAwrvVkAXmZV4vjyKKIK/glyCa5g5qA0tD3/ZmxpmPkyhyf7eoeAZslw
 LfAmlTaOyT7YKmLrdCO7KITak4bxyz1RxeX+t586f/pgE+FABWZQbTniMV5mLRTwse+9zbBoLcS
 9Fh0LCO6AMU7uO5TJzpyNofMuWxKanT5SaRjByCJzSC47gYM10Z3UAH68/rCM/5g==
X-Gm-Gg: AR+sD11Kv6gpl4D5+4IIXyngjXR9/Xihc70RC53nzdvjL4xbotqltbZAk1m/6JYZCOC
 ONsw8n/J+Tg9YW309uNEQEGaMlVGFmDieyipO1OUw6LPFLFGfV7QR1/xkfhwcsmTmtpXZ+XMTuv
 FldIVDnWCRrQQB4yoQhxDjGctTX57pZ2mnXQfIZz3O650j8sqGiCdsXig=
X-Received: by 2002:a17:907:c24:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c1fd3168c63mr90468766b.6.1785496439594; 
 Fri, 31 Jul 2026 04:13:59 -0700 (PDT)
X-Received: by 2002:a17:907:c24:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c1fd3168c63mr90465666b.6.1785496439129; Fri, 31 Jul 2026
 04:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260717121224.3908963-1-robert.malz@canonical.com>
 <IA3PR11MB8986E2BE513E6BA3AEAABE6EE5CC2@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986E2BE513E6BA3AEAABE6EE5CC2@IA3PR11MB8986.namprd11.prod.outlook.com>
Date: Fri, 31 Jul 2026 13:13:47 +0200
X-Gm-Features: AUfX_mzoxeJQ5WIo0tJ5aZ1g3dKP61ZkHXfa_nLqpwgqBsAVQgT0uwWoKQPDRbs
Message-ID: <CADcc-bxGVRYK3GfYa_sCaFgQV1EvwOzm+mxFuV4eG_XPgoPBKQ@mail.gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Keller,
 Jacob E" <jacob.e.keller@intel.com>, 
 Jesse Brandeburg <jbrandeb@kernel.org>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785496440;
 bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=aJOsqBaOVUroornroTImHQ7/bUdleSXMBnqykBJHblOAIMmGGTLqrHlBflNDPZcJN
 k8J2/lhjk7bWoSg9k8TQPnTOR3XqwZSUgaiYYifPRL6yGwPfBCJCMkBWwO3r+zKKFC
 bBapLV5yhJVC/BIFU+OumZ6gaf0I2AxM3/zjQzLPjVdPdfWq632nF7YzPz2zUpncNT
 OY/3Kc/7kSr0Kl1uFOTrRDu7n3Wo7DoeOoWPldbXKc3voG0cztiz+s0v+W1TRCHop0
 5ZdSn2q17+94YmC2Xef1igxJnPGaqoSnsptR2nLwAtDyWxphHxJWuKjeIHHfK6R9re
 s4BGNSRFl9DW+18hkRwGfg8VZwZa2Lyh+AHdaouDietF0cPVChwgo1S+SV2uItTNsy
 jMVbZ8MMUIaNjSI0roNA6VVtV7vNHgBcXLpmCmPF7sUvP32NoDOGUda/vgqK1iILM6
 lJ7iFHJn6iq2ciMMEsjhtrc66guO7yr75DAM2YekwfqBNHC2WYEGKYVZmDOjBpvTR9
 zP6eRx0XATLJmF+CiNSVUBUNDGnRxk0UERQa/EUYHXN66M1Z7Iaq+ShfmXYNVWLvPE
 dsFkaHilpvOoTpx5+oLlEWbo5468030NMPRX3WRyKnhh0wrJOWjizAHWY3AEgh57mp
 M9HtRAgPy5POGUXvSP1oJsLg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aJOsqBaO
Subject: Re: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
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

Hey Aleksandr,
Thanks for the review.
Added debug logs instead of warning as some callers are already
logging errors in case of ice_read_flat_nvm failure.
Let me know if that works for you.

v3 for reference:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260727/056=
245.html

Regards,
Robert


On Mon, Jul 27, 2026 at 10:27=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Robert Malz via Intel-wired-lan
> > Sent: Friday, July 17, 2026 2:12 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Jesse Brandeburg <jbrandeb@kernel.org>
> > Cc: Robert Malz <robert.malz@canonical.com>; intel-wired-
> > lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
> > each flash read
> >
> > FW caps the NVM read lock at a maximum of 3000ms regardless of the
> > timeout requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a
> > read into multiple ice_aq_read_nvm() commands, one per 4KB sector, all
> > issued under a single lock taken by the caller. Reading a large region
> > can exceed 3000ms, so FW reclaims the lock mid-read and the remaining
> > commands might fail.
> >
> > Move the lock acquire/release into ice_read_flat_nvm() so it brackets
> > each individual ice_aq_read_nvm() command, ensuring the lock is never
> > held across more than one FW read.
> >
> > ice_release_nvm() issues its own AQ command and overwrites
> > hw->adminq.sq_last_status, which some callers inspect after a failed
> > read.
> > Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> > capture the failing read's AQ error before the release; callers that
> > need it (ice_discover_flash_size() and the ethtool/devlink log paths)
> > use it instead of sq_last_status, others pass NULL.
> >
> > Callers that previously took the lock around ice_read_flat_nvm(),
> > ice_read_sr_word() or ice_read_flash_module() now call them without
> > it.
> > The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> > dropped.
> >
> > Fixes: e94509906d6b ("ice: create function to read a section of the
> > NVM and Shadow RAM")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> > v2:
> > - Replace the save/restore of sq_last_status across ice_release_nvm(),
> >   which could race with a concurrent AdminQ command, with a new
> > optional
> >   read_aq_err output parameter.
> > - Add missing "Return:" kdoc to ice_read_sr_word().
> > ---
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> > drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
> >  drivers/net/ethernet/intel/ice/ice_nvm.c      | 76 +++++++++++-------
> > -
> >  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
> >  4 files changed, 56 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index 22b7d8e6bd9e..5a1ab9654fb8 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct
> > devlink *devlink,  {
> >       struct ice_pf *pf =3D devlink_priv(devlink);
> >       struct device *dev =3D ice_pf_to_dev(pf);
> > +     enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
> >       struct ice_hw *hw =3D &pf->hw;
> >       bool read_shadow_ram;
> >       u8 *nvm_data, *tmp, i;
> > @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct
> > devlink *devlink,
> >       for (i =3D 0; i < num_blks; i++) {
> >               u32 read_sz =3D min_t(u32, ICE_DEVLINK_READ_BLK_SIZE,
> > left);
> >
>
> ...
>
> >  {
> >       u32 inlen =3D *length;
> >       u32 bytes_read =3D 0;
> > @@ -92,12 +102,27 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> > u32 *length, u8 *data,
> >
> >               last_cmd =3D !(bytes_read + read_size < inlen);
> >
> > +             status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > +             if (status)
> Silent lock failure without any traces in dmesg looks scary!
> I'm pretty sure we need at least log an warning or error.
> > +                     break;
> > +
>
> ...
>
> >  int
> >  ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16
> > *module_tlv_len,
> >                      u16 module_type);
> > --
> > 2.34.1
>
