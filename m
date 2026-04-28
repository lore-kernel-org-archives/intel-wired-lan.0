Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D0FF885D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 07:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A20A60EE6;
	Tue, 28 Apr 2026 07:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUSTXdovYg_N; Tue, 28 Apr 2026 07:53:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7B2A60EE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777362835;
	bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oXBSyMCg5zzZTBF6rC7onPx8UpBO2Zu87ylgxJZdXRE1+QP5JpSYAGbq9RtRi8Cbx
	 JLFFMT/Jy0EFWFQq1hEx9WYjiZw0JNdfaxr6ArhIlDqg/hprmi4tBo+pi1Co5Czzxw
	 KTdtS5jztjqXuCPL10XQ4SLB77ODrszjckDojAp4/0mL9lUAg/xblCWFIacINBv05y
	 2YYiNQ+D2PmKhv5XoKsnsUsXS//vp4X6jwOyshRzGcVV5KNNxZ9EZHBAC5c+TXNT/A
	 htuXcix7ll9lZSWcgOBMPOaOWq5E1sq7XPyEOhM96mkmBCG+RNGBVaL0xlu2k/YHV1
	 1A2lzfn/vXEyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7B2A60EE3;
	Tue, 28 Apr 2026 07:53:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BFB981B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1689835CF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKOJ0ec0-Tlm for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 07:53:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7314E835C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7314E835C6
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7314E835C6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:53:51 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 887DC3F442
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:53:49 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2eaed3d96d7so3106276eec.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 00:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777362828; cv=none;
 d=google.com; s=arc-20240605;
 b=LwG7Mf0lQ2e9b4MW78RcJq8yWlMAIw2JzrtdGxHAxExzVkcoi0A8f7abHzbBT2BkAj
 QK/OC2cfTavTBoxnsd+ML6KgChDeBqXAhpkesHEUM4oDer4079WTsWJsI/ib0ZdI6Bwl
 NUQufNLs1BCyFGPMLVC2SLrQBWsVEHP5WfmoJYaUv1+WkVsEDFpAMKPitCbrlI2jGPXY
 s5AsuyW6iEQlRKiwQ84xUrnsiI/5msHVxlBiJOtIra+jAB3FgtoMkQT5Bx8z6c1lsM0+
 kdg4PBCpVUqLHMuSZ2VDK+WTA7TVhmqBc6N2ARxGNbZ+T3GwsHaxiNL1T5b0HDNXfJkH
 Jotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
 fh=y6dhouhf5H5tNCEnkQJsGBfJ/t2nAQPrNm5gfpr3GfE=;
 b=OBQB3BlWLvVL63lXkjl8SI24u69fLlnxf6lrWNbqoOKR//5Bmy6r0YJAkgj/Lj2Ub9
 O5leoLUbrWFrBuUFcA5Q512zEiMFVTVi+kOE3ShFynJVQPBt3Sg99N+r9RxTBOYyqn14
 ZCQtOOPILaK6z+IUw1YxZD59td+QAlpuEICuTIHleg6wniVMmqeVeleA7eCrVE5qQGt2
 iTjzgMAThki87mys/YlUZ6G5q9gld8EMClGqag98aZj3lVO0MwLJmWYts4mwyKVOKSqs
 cyNN9qVQQZLDZfVus8O1/CJKbeB17jDgkZisfCpR4Ga9g0vRAkx+LfzU3ZB2ZlyUXd5G
 5z/w==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362828; x=1777967628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
 b=YPD7iIXcAJrV0NbKRkPwLp3I5Qw3aZoMlNWXuvReAo03cY896MAqDJxiB7eRorE7Ob
 U3jSYAGstM886lcQyWgtzHIOFYq4S2rGC2KkEWfl9NJP/0s8iSNzQpJTuBzLOfVXE8D6
 EAOmFVzol9ViQsP01ri828MvQlvE+dSlWW6gaYi/w7Gs2VCIQeZb/dOcdIAzqTn/w8AT
 zk0fAiq0tNN+e35Fv313x6fkBFZQnXr+47CW083q8Z2v8hCxOwgRLjle5khdPj/kKOkx
 zqdrkJc9CgA5fgnqede4u+W1GMUQ9l/oaWSL99WLcdyvsngU2n6uWjX13sLthSZYhT9k
 SISQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jkXmd5F+6ZoBWXKOZVhtENaDylWPw5sQ3h29/pUz9ABYBh31oaLdupNPmdTTcFu1NiGOV/wM3tAM8xvRM8nI=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yyles9QKl86p1ODG1EsmKcu8/v8BAarO7mpm7dH5xoqu861HBYN
 wR2EfIdBlHci087DNZnS3GosWJhTNsbAJNnkth/4aAmTizlP3fn+uJc0P9P89GQ2Pcxd9HDOklj
 lLBedWE8TuN/i+pEkQy/VPs5HAIPgpecDWT5Un+FKj2IdlyTNLSh7/VvSAE8O60U7iQMjuOmgD1
 5qvKAKB0vvf6QQwDuE+NFi23H1LGwa+yY1RaPZFVvdELAQdusDWjjfxdLfuwXliQ==
X-Gm-Gg: AeBDievbqhnFZH8WbWHJPyGyB+Wx9O9zJikVx20R67WeDxQRYOMpe8lunlS8ZQ4YATd
 9BAAs1PDkZZ23lMDHCVGF9hIMPxj2ixlwefWBxXSKOd3TYIkEH1DafHHvx3ZXmNqPl8ns+q/qQo
 RkdN3DsMbWn5vjVPXsXMT5OGNWw1DwCkx4J376MXdd7m6wH2y7Gh6xQCOmfv46oH5ey2QXiZL/D
 r+M9yDQMTXs3prmrqARsX/sNLdMajuPehPFIbwuntgNVngiNauHB+quPgJqWf6ooG4s64GhoQ==
X-Received: by 2002:a05:7022:526:b0:12c:66fd:6595 with SMTP id
 a92af1059eb24-12ddd9f3022mr878798c88.34.1777362827796; 
 Tue, 28 Apr 2026 00:53:47 -0700 (PDT)
X-Received: by 2002:a05:7022:526:b0:12c:66fd:6595 with SMTP id
 a92af1059eb24-12ddd9f3022mr878784c88.34.1777362827376; Tue, 28 Apr 2026
 00:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
 <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
In-Reply-To: <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
Date: Tue, 28 Apr 2026 15:53:36 +0800
X-Gm-Features: AVHnY4J-wg3tR_hPisWtunBUI27BB6t7zZFvy3Lps3d64t--As3DVEcC_39U67M
Message-ID: <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Akeem G Abodunrin <akeem.g.abodunrin@intel.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, intel-wired-lan@lists.osuosl.org,
 Kohei Enju <kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1777362829;
 bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=pdAxTo9hr0YG/1FIug5ujtqEVIwBMWjqlT5zb3Rp5Z5tAG0hp/hU5lA06IguW3HgH
 ee7DQoC+EQIW+oNRHrn2f09pf6oGWFN4tlVhbpZDYux/v4+JeKbsv5ijzkNYRgq5nq
 TAw+F8Iy7BBxGxhaqBkZBIKVqbXN1fOw+1ivHMmmOIt5AgO16eJNTNKpMDtaUJLC/0
 eRlNc2+1laVQQ3R1kW5DPvoCgDUao3cY0ao8OO/Z50NvVj9Zw2C8Kvcf/xTcxxJlUT
 XkkHnFJcNmDEZTYKspeAcorexxk3RWML7VXPAyPA/p1uaWLk3GTVZ/VDjaiakbCv/Q
 z3/ilAzgtfbeNA8dbAdlaaQt1UG/pEI9e092OI8l11ea7oD4tugQ/SXZybWyC+NTPY
 jvbK9ouuFfQGU7h3WsmwhEctWVimxgRlbtSpOA2jMZEPfCOe4jfRXS6fww/FYDLD6f
 2q0SLwbDiwD2yXH2WBm5MGswpXCIInwpDJvPSI8L1vzbcgOKxqxOOxjRATLtAGRz56
 ADIWmK4JUI4pNG1d6exHcgWdVRMjv7X6utid6VAPhG2x8p1blQrO+HGm7AUSb6ohs2
 FlASlR6zNZ+Ypkp/CepGbtbNA0zeCx2gowhUf0J+zMPCeRCEUTJBVW1m08qB8/1ylA
 6s+5PJNkdE9eOjq8xuyAR3UU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=pdAxTo9h
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
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
From: Aaron Ma via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Aaron Ma <aaron.ma@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Apr 27, 2026 at 6:13=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Aaron,
>
>
> Thank you for your patch.
>
> Am 24.04.26 um 05:03 schrieb Aaron Ma via Intel-wired-lan:
> > ice_resume() schedules an asynchronous PF reset and returns
> > immediately. The reset runs later in ice_service_task(). If
> > userspace tries to bring up the net device before the reset
> > finishes, ice_open() fails with -EBUSY:
> >
> >    ice_resume()
> >      ice_schedule_reset()          # sets ICE_PFR_REQ, returns
> >    ...
> >    ice_open()
> >      ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
> >    ...
> >    ice_service_task()
> >      ice_do_reset()
> >        ice_rebuild()               # clears ICE_PFR_REQ, too late
> >
> > Reproduced on E800 series NICs during suspend/resume with irdma
> > enabled, where the aux device probe widens the race window.
>
> Please document, how you reproduced it, and also paste possible messages
> by Linux or NetworkManager, so that people can easily search for the comm=
it.
>

The error message is "can't open net device while reset is in progress"
I can add it in v3 if you like.

 > > Wait for the reset to complete before returning from ice_resume().
>
> Please mention the delay length in the commit message.

The timeout is 10 * HZ (10 seconds), matching the existing usage in
ice_devlink_info_get() for the same ice_wait_for_reset() call. In
practice the wait completes in ~300ms.

>
> > Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> > v2: reword comment to clarify best-effort semantics (Kohei Enju)
> >
> >   drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index 5f92377d4dfc2..a81eb21ea87c1 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
> >       /* Restart the service task */
> >       mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_per=
iod));
> >
> > +     /* Best-effort wait for the scheduled reset to finish so that the
> > +      * device is operational before returning. Without this, userspac=
e
> > +      * (e.g. NetworkManager) may try to open the net device while the
> > +      * asynchronous reset is still in progress, hitting -EBUSY.
> > +      */
> > +     ret =3D ice_wait_for_reset(pf, 10 * HZ);
>
> Why not pass a delay in micro/milliseconds?

ice_wait_for_reset() takes jiffies =E2=80=94 that's the existing API.

>
> > +     if (ret)
> > +             dev_err(dev, "Wait for reset failed during resume: %d\n",=
 ret);
>
> Mention the delay?

Good point. I'll include the timeout in the error message in v3.

Thanks,
Aaron


>
> > +
> >       return 0;
> >   }
> >
>
>
> Kind regards,
>
> Paul
