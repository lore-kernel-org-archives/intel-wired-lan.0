Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D88C48260
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Feb 2024 07:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E21042713;
	Thu,  8 Feb 2024 07:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDhyg9A_WBLQ; Thu,  8 Feb 2024 07:35:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA82342ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707377704;
	bh=OwiLWf5rY+M5k7F7A5kk6IJ+AFJMy/SNlblmJ/d533s=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GdARBsIdJczRLKsPbWLYyT20vCTj1IibtXY5PywXpHyEBKIqe8ZPTAPaWzuS06pua
	 3HHEyI1Q32JlRNU9Fpat+nHe6bUf/WS4BTFAgg6P8FTOl7iFelVyW1n3zS5YVR663q
	 jyoICNDVbycXphclPHZ9bfydknyVlnaBp0fHFJ0VbfDoT6h4mL3pFuJh9ldZkd2giE
	 H0ZhlV/eoZZTvN6GKSwxzLU+gvIy1L6rzsO2oGsr4GU7SgYrQVfgPwk4ItGwEJAr+0
	 KWXK5ve6b56oqgQ4EDFfh1t7jVocggZgVWIVhnfDJVSUk/8HrWgiiODxQLGQF63h18
	 U1gfyIMmAGfAg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA82342ECB;
	Thu,  8 Feb 2024 07:35:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 6B4DD1BF476
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Feb 2024 07:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C544846AF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Feb 2024 07:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E0Iw8qdG_tPT for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Feb 2024 07:35:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b2d; helo=mail-yb1-xb2d.google.com;
 envelope-from=hayatake396@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6A947846AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A947846AE
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A947846AE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Feb 2024 07:35:02 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc6af9a988eso1245969276.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Feb 2024 23:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707377701; x=1707982501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwiLWf5rY+M5k7F7A5kk6IJ+AFJMy/SNlblmJ/d533s=;
 b=hEYkdHBgPH5Y2r3IRJvkDAeSJUj/Sg/x0C7imA3ghNtVwzFrFrWv3DXPjXj9Nzf/ah
 8t04Sh5inVsD6SDj96UJEsCgdO77sSrMrVvD1CWDiww/mXsuDB4jUpCEqDCBZJEJiJsI
 f/fGaJKh1VUD2Z+wXkHT1x750TpCn1VQtNdKWE1pDeakKKZ/SNWvhbujhmNa39EVvfFC
 0v4zP+ZfeHDL19QBr0bPK0QLeU0CvRN6Ro5iBGo4j5KcbB9TaPjWo1jc9/YfeyRzdPm3
 jEJ6qLEOejhrafKBS8xygalPIAiP+yGNgZEYLCh5FhKM27P5eYA7rB8jT6cQbKT1L/3w
 oBGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1MiC6XMhQkDRhZFUJEyCIymTJ+PwiUgJ5BMXcjUmJMiG3za+uCI/LmSIxkQWUDKPS2PjLUl8UhrTSa2yk89+nNBJW5TRZGb7pkcn90R4oag==
X-Gm-Message-State: AOJu0YzGDBS93MYJFQuifFUoFmwF9HzpvrAtkDLedlN5SycXWYFYvGRX
 ggfqj22HO/rUSBYamxaWx+482p6ZqoaHrNTlm2fmihJ70L5Ay7iRUdePzdvUKUdrZ23x3lWw6Up
 3xH5wac0yeLgOlpzU7ndSF01WU60=
X-Google-Smtp-Source: AGHT+IHGcjkvccjmKXkUVl0dy4auf3wes5FH5BEijtfhWmT3ZweyADdEGnbtjanITGRXfjgeqxb40zpZi79vnfnfwQA=
X-Received: by 2002:a25:6981:0:b0:dc7:461f:6920 with SMTP id
 e123-20020a256981000000b00dc7461f6920mr325253ybc.48.1707377700189; Wed, 07
 Feb 2024 23:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20240131134621.1017530-1-hayatake396@gmail.com>
 <20240131131258.47c05b7e@kernel.org>
 <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
In-Reply-To: <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Thu, 8 Feb 2024 16:34:49 +0900
Message-ID: <CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707377701; x=1707982501; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwiLWf5rY+M5k7F7A5kk6IJ+AFJMy/SNlblmJ/d533s=;
 b=aryxAiBp2k9QtIzAIVw+6kHKBEAd53N3QUBGkxzCjByrB5cG+GYvqsKKedQizFe3Zt
 9jbUADwMNYD74OZAEpgFp+ZSi4hUf/N2uCMT6rsMMXgVatCFhvrPwwQ8btm+383VU/le
 BRjBmuwoPQEtS58qQNg693cRcDxCyELZyAFWlVG0LcX7oUbFWt84KIRHXVkY4SgK+loP
 TmUtqBCtENqc8xS7oTVgiTnRW3Pl6qS2SwLAqFo25L6qqopL9mqivXcz0O8tg/EMGlrx
 WYZgR9Qcoy6ZhglVK6LfYJJv4so2oZXRa3K4Xq+czv5J49FRiSEFQ/CNexSrHnE76yRW
 uTDg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=aryxAiBp
Subject: Re: [Intel-wired-lan] [PATCH net-next v6] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
Cc: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 laforge@gnumonks.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 vladimir.oltean@nxp.com, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 mailhol.vincent@wanadoo.fr
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello Jakub-san, and all reviewers and maintainers,

It has been a week since I last received any feedback on this patch. I
apologize for the inconvenience during this busy period, but I would
greatly appreciate it if you could continue the review.

Sincerely,
Takeru

2024=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=A8) 9:59 takeru hayasaka <hayatake=
396@gmail.com>:
>
> Hi Jakub-san
> Thank you for your review.
> I apologize for the delay in resubmitting the patch.
>
> > Could you split the uAPI changes and the driver changes to two separate
> > commits? You should post them as a patch series, but combining them
> > into a single commit makes the uAPI addition to easy to miss.
>
> Understood. I will split the patches and submit them separately in v7.
>
> Thanks
> Takeru
>
> 2024=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=A8) 6:13 Jakub Kicinski <kuba@ke=
rnel.org>:
> >
> > On Wed, 31 Jan 2024 13:46:22 +0000 Takeru Hayasaka wrote:
> > >  .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
> > >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++=
++
> > >  drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
> > >  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
> > >  include/uapi/linux/ethtool.h                  | 48 +++++++++++
> >
> > Could you split the uAPI changes and the driver changes to two separate
> > commits? You should post them as a patch series, but combining them
> > into a single commit makes the uAPI addition to easy to miss.
> > --
> > pw-bot: cr
