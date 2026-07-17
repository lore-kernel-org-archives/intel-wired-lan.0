Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B87C4451C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87FD4405FF;
	Fri, 17 Jul 2026 12:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXclWR83HRIS; Fri, 17 Jul 2026 12:16:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFF604094A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784290561;
	bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=atWj1a0oHkjJATvUIwbkE5Q9W42h4QN4KUrDPYYXEcgMZvD3hMOd2tWDBIJ1vd/3X
	 r3rTinU+7x1wXtk+YWz1DuWK4D8mypBXsSAEkN6lXAclmwUCvAVsL7FnZP5hj5iQa5
	 xWT8vO1SC0tvgvxpFc5H0xa7Ow5W9riy55Q/ooiJjtLcR/1BT8WjyuMZUsP8aYjG91
	 LQaX0UuR3FvUJCCzWsHHltHszZImE9zshMiwTso3oncBsvPfG38gaZK+Trfvl//L6z
	 oSP9M39C5SE4zvzRXTueVmCUrMYS0lUphoXI08ZlMEIhqi1Rvd4x6LZVzQh9PVF2BW
	 /zcxIVWC43FCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFF604094A;
	Fri, 17 Jul 2026 12:16:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1CC736E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A359C40176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbIM0XnQLUSC for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jul 2026 12:15:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=robert.malz@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5DE3A40100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DE3A40100
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DE3A40100
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:15:58 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9008D3F82A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 12:15:56 +0000 (UTC)
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c158e733fd6so835944966b.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jul 2026 05:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784290556; cv=none;
 d=google.com; s=arc-20260327;
 b=jdOKJZ6YfdB+kSLDUDQ3HIYCooMqLZPwFbcokwRAVaotbyf4uCcchmWD7b5r5aVD5n
 C9ibyjC8sgsuKhgF4TXD97/70UN7SUqiu+8jZFpa1DSRj4Pk2M9c2wqv9K91B+r1w773
 oZwVDCyqeM+0HyU1l7d1HHPs2Wb2W7WDeo/4lMxkEE8ufv+jPgyOUmoFIc4a42/TaFUA
 W90Qm3J6Qi2os0uRw/l9vBR3yjvz1hMRcvo7gZnBTZZAaI5AAkReerdDa3a2caIjLdQf
 +L33C0vLrZAng/IMPOuWOhjvZW7lHBREZajCwu3lXy+a2+/jMBdk5PqLViCBf2BUwZeU
 riog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
 fh=Eax5AXEll8LEPUZGpEFVx+pT+kEJvp3wxtu9WmBKniU=;
 b=omRAeA27IbtDZlGE5uRFWyrr74Hn8sikM01uDECdJeN+2/9fwenNRut8XlDKWQ84Nj
 ea70MZzB+QgqHjqOyScsaY/yPlgcXlBne3E+138ZAmLaiLktCVrJrEr3uBvhwkXHYwIU
 /83YUPEfZjMU3x4JVXLW3j+ZkQsKOYiR+VN6FCVBQCyzdNUq1J9c3luvtkBBFNj9okN/
 9zLlF3fqLRjv99sF0Eubxnc64ndyPnEHZtEQaSj7We4R7/RelYP7uoINpPjLDt+QMg4P
 whYIMU6gbQjFqe7hD1HD1ndoNhrE6V/i/64PQNSxiaJKk6+9QjBPMUfIfCsOcHKEzOEE
 KLBw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290556; x=1784895356;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
 b=YD99SdJdKP7enELuw3xTNCiSH759+kWG3xxPTzlcO4N4kdTvnQrO5XJpSIbYRk5uke
 0MIKPf/Ny4DgOzkoDOG2qtscDmuM5YdS/ir8CrhLgyzOhG6LGNwymQOpI1FBXgoqNkzZ
 Snd1hGpuHx8yJvWt32XhjYv1vsUdrrF9e04+ymyezJpaharrXSrEXDUgEAXTJXoL3Qjc
 2dRtK3HOPb7QkxsVKI8fm6fJw2+26Eg02V9xkIPsu/YtilWlefQVEBgI9R1I1B0B3shU
 7gnB47ClTwVhbm5RzGZsPTFRLDAORoHvY2cDrhpfor3+NbJmsxQGTvQxTwOPq0zri1sC
 oPyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RroNjVmK9/eZMrnlyTbEOXSDiHk7YIPJpd723im3jwFkskenj0I+fTwvPFaTRk6SRt5Ii5QNwnDh/g93OaLQlo=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwvywruXYo8ulum+4djeC/VaZgHrhNpWvDn55Pd75JXn2U/ULdH
 nXzI7Ia6nIC10AgCusXQUjI4jP/xEu3zmBR06rZDNO8gyJ4Fz0i4/xxjCMoPclxkeHqcKQMR7qu
 1FVasU0rRAv/Jbfp5d8uJTxDn4wWo9A7/iAEw50ba1dTnp7YttDLy+zUkzsbmPtCZ88FGAZvy+A
 pLm8GxZPweP3HZGgqUq8fDFKkFttv9C7PtDXtP5SbRct+zcYRdSJyauDmO8Tp1mg==
X-Gm-Gg: AfdE7cnaM3G8gf1vSsKFcoAigt3iwJ5vhNUGQoiD5rcMsn0dqKzhnyTLuIpvY93Zwtf
 F2cvwjtBMr+36KAEqN5dlxkXymi0echoM9C0fGh8UOe2XPOazb1X/zNcmOzDPj73rYYT0KsWJhu
 NrYKzNRtXALNzMVnpuDxTRn7JbV4mGGoOdY6FxH4qSnpCxTrRyqd32DlPf/A==
X-Received: by 2002:a17:906:fe08:b0:c12:713b:e199 with SMTP id
 a640c23a62f3a-c16b46e922dmr112680966b.25.1784290556008; 
 Fri, 17 Jul 2026 05:15:56 -0700 (PDT)
X-Received: by 2002:a17:906:fe08:b0:c12:713b:e199 with SMTP id
 a640c23a62f3a-c16b46e922dmr112678966b.25.1784290555523; Fri, 17 Jul 2026
 05:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260703103245.374800-1-robert.malz@canonical.com>
 <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com>
 <CADcc-bxLMg1NujF+jE2rOXGc38quv_XqZfv5K+yGQFfhc03avA@mail.gmail.com>
 <e8a4e549-c67f-4d20-8d33-fb50b4c44de9@intel.com>
 <5b420008-96f9-4f62-b155-a4b694a58369@intel.com>
In-Reply-To: <5b420008-96f9-4f62-b155-a4b694a58369@intel.com>
Date: Fri, 17 Jul 2026 14:15:44 +0200
X-Gm-Features: AUfX_mzqbVwIfN-n_6r4R2Imerfb5FAU2AjX_1Gj95UHrg4tI04VLZsTxG42NGg
Message-ID: <CADcc-bxOBSaH=NdS3rHHCSZZ7e_0mXvmD0R9tanNQ1_JwoQ=PA@mail.gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784290556;
 bh=N/hnahT5kZbiNxMSUWsFWdLZL5SL2X58CFxZoF5fAdg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=g/X+YoOcMiMkod5lc2R2TrCxW33/QUCORe0sULosfB1rhSn9KTYL4Ssu8UW/BBQo+
 i8z4P6TTlZiUFpL1EWbeDrExHoEIdu5uTLVaQlmMyprNUo8rxKX4Rl9b4292xHVX4Z
 0UmjMpBAvcKK9GQAG0Bqs3/YdPMGlxy8te2TSMgPZ4O7RtPUf6RwprhpfKMA2Ayiai
 lhDbUEwQvFUOFUfD3uLu7BnSfUy9/M9k8PrTMqGfz2psBqhaEMfIItbsDRN8Gzx9Cn
 fCAp5ngReacWtIkd6u91+PsvmYs8gaOS5Ra6eItpr/P3gkLZOEUE6wUj/RHLJywf7o
 eIIaYxocr+3xc1el2UlDw1akJozSEHwD9d5hr+3q5huqmoYZQudD5C/DNHME5udGfr
 UFVtptJKE+/IdrUskCiGPqE25ljs4GM7pZDRBCYgenTQRvEcQHNQPAaoCVE3rNcayS
 s8SwTpj4VwRsZPNxCf7qnUSE7uD03CH+OZbu4fqLtUy7ALdasi7LTKiL1FT5L3HdLV
 n55ExHVMdOgMIv+HceAe+vUyhDcqj7fMgKW9GluXoxYXwSqwP+8vnD6jIcK9UVCxu7
 Tt0usj7Rw77EIK53ovByc6With5jUSyn2YcI27KCxZpbJfLaAfzqaMrRDr+ZSbkkqA
 eZ5/kgnY8fbQRwtB5KwEXZbU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=g/X+YoOc
Subject: Re: [Intel-wired-lan] [PATCH iwl] ice: acquire NVM lock around each
 flash read
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

Hey Jacob, Tony, Przemek
Thanks again for the review.
I have submitted the v2 patch with the mentioned changes.
ref: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-2026071=
3/056079.html

Regards,
Robert

On Wed, Jul 15, 2026 at 8:22=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
> On 7/15/2026 10:04 AM, Tony Nguyen wrote:
> >
> >
> > On 7/15/2026 3:22 AM, Robert Malz wrote:
> >
> > ...
> >
> >>>> -             if (status)
> >>>> +             if (status) {
> >>>> +                     /* ice_release_nvm() issues an AQ command that
> >>>> would
> >>>> +                      * overwrite sq_last_status, which some caller=
s
> >>>> +                      * inspect after a failed read. Preserve the
> >>>> read's
> >>>> +                      * AQ error across the release.
> >>>> +                      */
> >>>> +                     aq_err =3D hw->adminq.sq_last_status;
> >>>> +
> >>>> +                     ice_release_nvm(hw);
> >>>> +                     hw->adminq.sq_last_status =3D aq_err;
> >>>
> >>> Does restoring hw->adminq.sq_last_status here without holding the Adm=
in
> >>> Queue
> >>> lock risk overwriting the status of a concurrent AdminQ command?
> >>> If another thread acquires the lock and sends a command immediately
> >>> after
> >>> ice_release_nvm(hw), this lockless write could corrupt its error stat=
us.
> >>>
> >>> [TN] I don't believe the AQ lock will work as desired we can't guaran=
tee
> >>> that we will have the lock directly following the release in order to
> >>> restore the AQ error. Similar to the NVM lock issue, I think this is =
a
> >>> small window but wanted to bring this here in case others had
> >>> thoughts/comments on this.
> >>
> >> [RM] Agree, this can cause issues. We can't drop sq_last_status as
> >> ice_discover_flash_size depends on it.
> >> Proposed fix: drop the save/restore sq_last_status and propagate the
> >> read AQ error through a real return path instead of the shared global.
> >> I could add optional enum libie_aq_err *read_aq_err out param to
> >> ice_read_flat_nvm(), capture sq_last_status before the
> >> ice_release_nvm, and have ice_discover_flash_size() test that instead.
> >> The log-only callers (devlink/ethtool) don't care about it.
> >> Let me know what you think about it.
> > This sounds good to me.
> >
> > Thanks,
> > Tony
>
> I concur as well. In theory we should probably try to fully refactor the
> send_sq commands to propagate the error out from the lowest level
> without sq_last_status at all.. but thats a bigger ask and I don't think
> Robert needs to be asked to do that.
>
> The approach described here seems like a reasonable compromise fornow.
>
> Thanks,
> Jake
