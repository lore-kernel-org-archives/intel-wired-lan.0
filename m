Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC27C47258
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 Jan 2024 03:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AB0B6138C;
	Wed, 31 Jan 2024 03:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AB0B6138C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706670957;
	bh=M5vfFw+B4qQaAmX0KSnFyPWaYeXXdPCyWr3sYtimr6c=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=G2gI1Z2MO41/QxODHAQIGQMQRbNumRFBMhFtoGdW0/cwZRL8ShEc2v1pojtxPvxys
	 WeDXkV/3LyIE62AqP4LkVrjHcDB1y6412jqNwB2RfQv1Y1b4fp8Us2LwWE7UJq9QCR
	 fFWQuP5xC1d55lMumUPQ+sLX7/mrDrFJUCb7rY1PXMf4I5nA+Uj2s8TQkzEakOh3SP
	 Y9fijFL6dO/IaFA2CY+/TEl1of5HfAFlks856tBsl04gG89SOCxb//xOZSwSJQKflp
	 NEwdx9LJQRV2JVM0b1qy8CIPy7AVH2Ddx4qxQo4hpTga3a1ruBcs8zJxIupzMluZxN
	 9EHwjY9dSuiCg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hjuwv9r-jua; Wed, 31 Jan 2024 03:15:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D6D5613A5;
	Wed, 31 Jan 2024 03:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D6D5613A5
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 994771BF277
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 03:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D8AE613A5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 03:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D8AE613A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYk-gcdaCqcJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 Jan 2024 03:15:54 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BD396138C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jan 2024 03:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BD396138C
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dc68150f46fso2727034276.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 19:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706670953; x=1707275753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5vfFw+B4qQaAmX0KSnFyPWaYeXXdPCyWr3sYtimr6c=;
 b=JvO9LN2DVreT0XdIQXY+EADzqzcQJg7V4ogb8BdlXgLhRXSfszCbiQcDeoBPi65Gv7
 bPwboC5BMv/eIRq5GTmhBxhfGRdhKnJ4nzj7gJjZoQHhQQdoTbdz+YlUN6tD5hRP/sYl
 0mTM4puW4F3UKKxz18A45tgIvV6dhWZsVttpvVDdEyq2teTc8w69jwzZpY6UaorftTb1
 2ixiyk0Csksau7t3nEnOBBOb+7GYgVsz1lXAZuB36ZRzJzd5vSjGdvkXy9EnJ7uWpusv
 aWE859cMI2qXStq1RuqTHuiU9WBiRohhXJsuviGPphFHSK5xJjCN231wCwqOf//G6LbE
 tNqw==
X-Gm-Message-State: AOJu0YweOqByMP+ty57mjciZcRXjE/4V1x6CXuWGlP+po/QtyEhmohqR
 ElxqnIGTqFxqjt0GQQSF9lleekjin4h2vlH4LAbbi0CLT1gytFUV5utu0XllTS7XU5YReOuAYW0
 rePgIO8EHu+7xpfStj1fRkTNSWTY=
X-Google-Smtp-Source: AGHT+IEgSI5FvPenJVdi3XSwbwBPCPZgeHMPUFSwjko4DrgrPFSHLEF6/7bMGVVrk7NI2yxvajEREOc/g+s3DqlyrL8=
X-Received: by 2002:a25:bd92:0:b0:dc6:b945:e58 with SMTP id
 f18-20020a25bd92000000b00dc6b9450e58mr348589ybh.48.1706670953113; Tue, 30 Jan
 2024 19:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20240127140747.905552-1-hayatake396@gmail.com>
 <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com>
 <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
 <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
 <ZbjLWwG8m-FdyxMH@nataraja>
In-Reply-To: <ZbjLWwG8m-FdyxMH@nataraja>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Wed, 31 Jan 2024 12:15:41 +0900
Message-ID: <CADFiAcLuKXTsHm6FzojKcD_wc8LQz43xt-cN0rHJyA3Va_-EDQ@mail.gmail.com>
To: Harald Welte <laforge@gnumonks.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706670953; x=1707275753; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5vfFw+B4qQaAmX0KSnFyPWaYeXXdPCyWr3sYtimr6c=;
 b=fWrYOZuu/kfESLnVbeYT/mHsNaORYSOCWlaNxW6DWlznyDR0CaqAMn4BKcAXNA3cvd
 0GN/5Dm60jDw0mgofw1QvY3hHD4Yfns0Q6gC7VKIZI5SmTz1/l146CdFMs8e3ugVft+G
 6F77u9g6jqU0Fr3Owpkh30pqUw2UId5zRCKIGEVYc4/yTfn+TgFx+jlYAV2qLO7N61KC
 Y9dhSD6368i3aKKP/2RukaBKgvmAf7N8+T7fLXQ6ce3PXyze6gyQV+4o1IjxlDixUxHA
 U+Zqx3IOtz1l1R5CiayhXS4U0Q65X+LM60hQk3rP6PIMQKWLwUMC9S+K0ukX2wVWeyT/
 LWnw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=fWrYOZuu
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
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
Cc: Jonathan Corbet <corbet@lwn.net>, vladimir.oltean@nxp.com,
 linux-doc@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 mailhol.vincent@wanadoo.fr
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Harald-san

I apologize for the delay in making further progress on this
patch.(I'm three months late...

> There are many different GTPv2C messages

Thank you for your assistance in explaining GTPC:)

Thanks,
Takeru

2024=E5=B9=B41=E6=9C=8830=E6=97=A5(=E7=81=AB) 19:15 Harald Welte <laforge@g=
numonks.org>:
>
> hi Marcin,
>
> Disclaimer: I have no understanding of the proposed implementation here, =
just commenting
> on this from a 3GPP protocol architecture point of view.
>
> On Tue, Jan 30, 2024 at 10:59:40AM +0100, Marcin Szycik wrote:
> > >> gtpc(4|6) doesn't include TEID, so what is its purpose?
> > > In GTPC communication, there is no TEID in the CSR (Create Session Re=
quest).
> > > Therefore, there are cases of GTPC that do not include TEID.
> >
> > The way I understand it now, this patch (and the ethtool one) adds hash=
ing on
> > TEID field in GTP* headers. So I wanted to ask why do we have a case (g=
tpc(4|6))
> > that doesn't include TEID? Do we hash on other fields in this header?
>
> There are many differen GTPv2C messages, most of which contain a TEID.  S=
o it does
> in general still make sense to be able to use RSS for all those other mes=
sages.
>
> The CSR (Create Session Request) will not be able to benfit from it, but
> it's just the first message initiating a dialogue between two elements
> (think of it like a TCP SYN).  All the follow-up messages in that
> dialogue contain TEIDs and hence can benefit from RSS.
>
> --
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.o=
rg/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. =
A6)
