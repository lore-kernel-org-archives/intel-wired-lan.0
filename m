Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49233FF8875
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Apr 2026 01:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0347F83E39;
	Wed, 29 Apr 2026 01:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqzZrtydsDXK; Wed, 29 Apr 2026 01:22:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBD8983DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777425722;
	bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Urab/K3WaiCPrZuM/jo3oMsGCubnfRRPnXtdmbLMp2CJh8rq/QyYUgQknEZ4q5YVA
	 AnW663NtZ7UJTBxYGfvJZrfFoYwdTdTJbv+RECEK21ibj0yb79S5mroC7TGyx3eige
	 Uo6NtLJTAi+QqKTArry8R+yPZl/RRpg+rEt5OvwRhwURV+dQv8SjG9FNfBFFcyTeHV
	 oyizjAhIFY1I6LxjBfpIO4O6W8z35HhTqKglo86fBs92vYEueQHPM21iDaQJv+794m
	 Io+FnYk5DYcYs/cPihI0R1ClDUM1gJ+WPJ4h9G1LJiQAOQUGVksuzvST0CwXMGp9Zj
	 3HeB2KQrRI4bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBD8983DF2;
	Wed, 29 Apr 2026 01:22:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5681D231
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 01:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F7E540854
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 01:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pgxHxC8cF1T for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Apr 2026 01:22:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=vincent.chen@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F88840846
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F88840846
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F88840846
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Apr 2026 01:22:01 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d37e7d7fso3085805b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 18:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777425720; cv=none;
 d=google.com; s=arc-20240605;
 b=C1zg+t4SwOP5nhJKPNvgWE2NRdJpMizNxKQvdFPcSgiOaTcwt09SnmNLlr5J+kb/Uh
 yEo3HTzXJfdS9kdjzdA8ki+7tHos0tCY2uugzocvLzPJzNM1GSL1+JHKgznFSt3cTGPF
 7IgNHlg41bcC0UnTeXJhBBe4FZqnkA5EaOKrEyuTIWkLapjcbIGGa5mwdTWdQEDje/qD
 s+4FQZSsSu96FMD/cqLf+DpsmtCe1A3IYksAKdc8NRgSJL7mokKFvOeHylXhPjPgyswh
 H3gPFc4e0acwmV22OeXED/zU6SHMkE9OmKA4b/KX8hCiarSHnJQNg/snWp+IzqBoKQ4u
 9Jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
 fh=ciAhGXkhwEsl2eBs7CpTrKf1Jy+bThlyHqEeeirjHME=;
 b=lCzX2txWgVVHNGm+aDjYQS1tP2IjTnBYEiLFFrlSRH8mRu1ZM+OaE6UQ4knMD/g7+P
 t6IFGxtssCGwaLrzeTvxaccFjk3PdRRQgqTNC1BDG1c7TVPBivSYW4/+txJXPbd+2Axu
 ENnwXLT+wg1vsql8BiEAQMqYF5OBnnDr5h8ZMBEtsIdkUXqZ2bUMgiu4rfsgqTkbSZO/
 jMlfFFIyRuCcV7s2yOHvcEk9RlL8j0Jj7/IOPZoT64jDB1lsQNUjNI2Ukam7WvqvKlIU
 8iaMR2Kt9DT+bYnsDEXfM0asiJj062rT86SL3BaIbpkEmRV/CFoEnoYdPERa4kHkZLKE
 BxAA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777425720; x=1778030520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
 b=GyRP+qM9tnjekQ5pOo5wyge7bWU9DPx4UUeBfpOcRPrNJgQu4q6vTF9MMBqigPnVDK
 yoW9Qedltx+rRPGkgnA0ET51JFkNssyDXCZakofRcJAGqwQ7L6MpewOQDVNLWR1rlD0b
 iEgGOtXsSyusZJIJasjGxHYyk1y8xeeILSylzie1X1vuBGpcpCYcqeFt046EoE+RNGIm
 GjtlzjHfR/QgCmYYLZ7G9qsTpNEu9YrkyG1coc2HnVX3nT2ehi9RUAea2FIVfvakuFeY
 s06D1ITh/2nJf4dsq5UxLyF8JNxFaFdzN5Zw9BWfXmBRLNpgwom3ofzzN8qZ7UlxZ1l4
 d3gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+08M7V38jfSHz/ycwlVolTgVqssJzJ1eJPLpe6SDAC6H0ACH9xfdiNKJYC89LQET5Lywt00DB7DwWpxH95pBs=@lists.osuosl.org
X-Gm-Message-State: AOJu0Ywbz9RLj+o22MMVBdOcQZilDbOnxyTcGqQJEbcHdOps3NEpSVvk
 EcGEzktivy1tuvHsLN7XSHNwDRnMShwycSpiAdaPS/c7ldLUi8P3CmfMpxiRdzDkF+gBJToE/Lq
 CW2K7We7Cx42YzdclVWhejgzc09KqI6z1jpB3QE0CPA==
X-Gm-Gg: AeBDieu+6DULcZRH6QYNS2ripKFfzXGvyuZTsnrz6j+mYZD7LVSkpXS1fb/v82YVvgF
 8ZAUFG8FSl9FlzeKya6wYHEC9kUnJ5GYnLPGvOqDt4vYId0gxLy3uU9VXGRp9u/+bWmCnlaVU+r
 oTCboSA5ghaAo3ieZJ+xK9qslOdq1JFYFxEl+nUTkOwQUfcO1Ae74u2oOWsMWszlicr8t2wlKcu
 f9g6n8cJ2akRFsxYiiEHMMQM0e7sxu2B0k3WDNhkvzBfn36zn4J382EaOh8lu/jA+5Y/CMDGcsf
 SBRDOJZ99PttlovGxqVv
X-Received: by 2002:a05:6808:1929:b0:450:bbed:7a75 with SMTP id
 5614622812f47-47c28f816bcmr3004473b6e.28.1777425720132; Tue, 28 Apr 2026
 18:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260427031158.2665916-1-vincent.chen@sifive.com>
 <f9fbc8c3-3b1d-456c-a389-4f95bf07822a@molgen.mpg.de>
In-Reply-To: <f9fbc8c3-3b1d-456c-a389-4f95bf07822a@molgen.mpg.de>
Date: Wed, 29 Apr 2026 09:21:49 +0800
X-Gm-Features: AVHnY4Ldv6uyCJi_ZE8aGxC2v2tla6lK0w3XQ3_fjdXzKK6Ue5badKUDFLkz3tE
Message-ID: <CABvJ_xhLj+GKpsT2wDNXoS_oWJoydR0h0qxa3BSxSTCvC2-bVA@mail.gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777425720; x=1778030520; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
 b=StMbxrOf1QqnlVRa3eDjalxLLscAirVnPLea/HlBQbU4ZvLLpGqX8/UbWvhS6kW4pl
 PJQHdR27IErdH74cZEtsFiRVDyF8now8+go915DXWBoXJnJwrScenPGvjHU3F8hWMwkY
 dg2yi7eYY53iwtqp6ngOj3Q3/09ok8Ijo/LSl2o/ZhtyZNvaB+OnYUNPsaaQrm7ungiB
 eNVDYgf3hHGZw3VkvLw3i1xceZQQIIHyqPGqNYmkYXSxV3eAlhy9W8FpIMvekaT3QhRJ
 x68oEe0TlkBqPbQEoHuujXXQIJGCbTb4jHhOCjwhYpWqIdc3qO/y/Af1dm8GXAwg91XQ
 989w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=StMbxrOf
Subject: Re: [Intel-wired-lan] [RFC PATCH] ice: allow creating VFs when
 !CONFIG_ICE_SWITCHDEV
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
From: Vincent Chen via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Vincent Chen <vincent.chen@sifive.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Apr 28, 2026 at 5:45=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Vincent,
>
>
> Thank you for your patch.
>
> Am 27.04.26 um 05:11 schrieb Vincent Chen via Intel-wired-lan:
> > Currently ice_eswitch_attach_vf() is called unconditionally in
> > ice_start_vfs() and ice_reset_all_vfs(), which causes VF creation
> > to fail when CONFIG_ICE_SWITCHDEV is not defined or switchdev mode
> > is not enabled at runtime.
>
> I=E2=80=99d add a blank line between paragraphs.

This is a good suggestion. I will modify it in my next version patch.

>
> > Fix this by adding switchdev mode checks at the call sites before
> > calling ice_eswitch_attach_vf(), consistent with how
> > ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
> > Also remove the redundant check inside ice_eswitch_attach_vf() itself.
>
> *Also* is a good indicator to make it a separate patch. I=E2=80=99d favor=
 this
> in this case.
>
OK, I will move the code snippet used to remove the redundant check
inside ice_eswitch_attach_vf() to a separate patch in my next version
patch.

> > This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
> > !CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
> > ice_eswitch_configure() API.
> >
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ---
> >   drivers/net/ethernet/intel/ice/ice_sriov.c   | 14 ++++++++------
> >   drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  3 ++-
> >   3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net=
/ethernet/intel/ice/ice_eswitch.c
> > index 2e4f0969035f..c709decb26d5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > @@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct=
 ice_vf *vf)
> >       struct ice_repr *repr;
> >       int err;
> >
> > -     if (!ice_is_eswitch_mode_switchdev(pf))
> > -             return 0;
> > -
> >       repr =3D ice_repr_create_vf(vf);
> >       if (IS_ERR(repr))
> >               return PTR_ERR(repr);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/e=
thernet/intel/ice/ice_sriov.c
> > index 843e82fd3bf9..6a0b724e46f9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > @@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
> >                       goto teardown;
> >               }
> >
> > -             retval =3D ice_eswitch_attach_vf(pf, vf);
> > -             if (retval) {
> > -                     dev_err(ice_pf_to_dev(pf), "Failed to attach VF %=
d to eswitch, error %d",
> > -                             vf->vf_id, retval);
> > -                     ice_vf_vsi_release(vf);
> > -                     goto teardown;
> > +             if (ice_is_eswitch_mode_switchdev(pf)) {
> > +                     retval =3D ice_eswitch_attach_vf(pf, vf);
> > +                     if (retval) {
> > +                             dev_err(ice_pf_to_dev(pf), "Failed to att=
ach VF %d to eswitch, error %d",
> > +                                     vf->vf_id, retval);
> > +                             ice_vf_vsi_release(vf);
> > +                             goto teardown;
> > +                     }
> >               }
> >
> >               set_bit(ICE_VF_STATE_INIT, vf->vf_states);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/=
ethernet/intel/ice/ice_vf_lib.c
> > index de9e81ccee66..71595410174c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > @@ -807,7 +807,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
> >               ice_vf_rebuild_vsi(vf);
> >               ice_vf_post_vsi_rebuild(vf);
> >
> > -             ice_eswitch_attach_vf(pf, vf);
> > +             if (ice_is_eswitch_mode_switchdev(pf))
> > +                     ice_eswitch_attach_vf(pf, vf);
> >
> >               mutex_unlock(&vf->cfg_lock);
> >       }
>
> The diff looks good.
>
>
> Kind regards,
>
> Paul
