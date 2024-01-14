Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8302C47077
	for <intel-wired-lan@archiver.kernel.org>; Tue, 16 Jan 2024 16:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 671C161183;
	Tue, 16 Jan 2024 16:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 671C161183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705421772;
	bh=ArVkJJlNDO0F2DIfmT0Sy+zs4DhujdMQiBeMUoROCgA=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GGerv0LYZvshyH8iTCDqqczERruMmci23LOIzgb10N2jl2Jt10KGTImjdK2REKEYg
	 Eq9/NnZgoy7DqOcAvrhE6y0koz8rVxEe3a0s55mQd1aDFXlvl3i9yNzKjgF65GmU/R
	 AHkuQFPLoJhJPAFTLusLf4CGGfpJ+MkvLuc2krzVgEjwhrlmJZKdeD5jHVNJn62IwU
	 jkEChGDL5MN1lRdHnDjGp2rV0SKs7on1TNfm4SCofq+yfTqCdLQEZiZ+XcMICy76B6
	 /4veC8BYI15F6achRU5R6GRwb09awqhkoRIjAvxYjBWn0ORpcsbL3l6jcq+kuG4x9S
	 Q0KsdO2XIyRkw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fk7vmuWQSH55; Tue, 16 Jan 2024 16:16:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C621961168;
	Tue, 16 Jan 2024 16:16:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C621961168
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 410461BF358
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 Jan 2024 12:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BA6B60AEE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 Jan 2024 12:06:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BA6B60AEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsdQZfDR2CsH for <intel-wired-lan@lists.osuosl.org>;
 Sun, 14 Jan 2024 12:06:08 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E18F60AEC
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 Jan 2024 12:06:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E18F60AEC
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ccbc328744so94616921fa.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 14 Jan 2024 04:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705233965; x=1705838765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArVkJJlNDO0F2DIfmT0Sy+zs4DhujdMQiBeMUoROCgA=;
 b=EvgZExvOR2/VfuozjK6GjYmDHeN/lxZ8JTs4G+Q1nSTOAGN0nJBm8wmu7WJaiHUcWb
 IOQHxwsVCLBEmpB0pyhOWjW5xg39xIkfpoCwjbNOddTV3X1xd0TgPLtuxxb84o3BA3yH
 wwmAZIzOU7VoAqzr6azZnZpfzYsn9roLu0d7m+8IjqCIy7g5bgRVNcbfkW13Vf4bUJeC
 v74idx+3cC0ZcHz2BE0rUeLGNVhKZGn6rBkoyYljMXVQwOc5E7uElEwD+QzvWnRv3yVZ
 6HrIrqtVAGhxUSmQg+LW+Jdobf2gWBfiPQAxbqXGKYU3xutdhxk/U0qoekIA8FCFUwDw
 /Z7g==
X-Gm-Message-State: AOJu0YyaABFhekdc9bdT7uxAPkNjrXLHux0d+emgOIPipKwkpdPsCFKF
 5r4psnuiECh3bPOws3kwNi0iuR6dSzthKoy63Qpe0rEE92FR
X-Google-Smtp-Source: AGHT+IFeP6TMKlC5EDAfD3/H9mE2dri5QbT2KNEkepgczVkz7a7u+KOTlN/1i/UVrXzdMEoC2c52JC/r35YlMr0lIc0=
X-Received: by 2002:a2e:93c3:0:b0:2cc:2678:6d35 with SMTP id
 p3-20020a2e93c3000000b002cc26786d35mr1759501ljh.6.1705233964910; Sun, 14 Jan
 2024 04:06:04 -0800 (PST)
MIME-Version: 1.0
References: <CAK8fFZ7Xi3=1HFY400firmpRWzHDPsi90cUU5bjOkF00KNZWeA@mail.gmail.com>
 <bce78734-d359-499b-9693-05549e6a73a4@intel.com>
In-Reply-To: <bce78734-d359-499b-9693-05549e6a73a4@intel.com>
From: Igor Raits <igor@gooddata.com>
Date: Sun, 14 Jan 2024 13:05:52 +0100
Message-ID: <CA+9S74j7LKDJ5U7RDdkUW3UPch9P9U47AyZcbpvQfHGHzW14Qg@mail.gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jan 2024 16:16:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gooddata.com; s=google; t=1705233965; x=1705838765; darn=lists.osuosl.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArVkJJlNDO0F2DIfmT0Sy+zs4DhujdMQiBeMUoROCgA=;
 b=FFwa9RhAAh8ym5j8cAh+xNHTXeI14XP3iSN1mbp4AAukXbQDZNv8w1SRezTajWlKkB
 9TuvVfkrIfXfwqEW5sQv2ri6xPWz3eZsCrMmB2IQAVKEzsi+v3yrpNDNfHTv8ixhpfIR
 T/0mRSSsGTWp34vgLbhCxt/2Co/hSCUi+dUlU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com
 header.a=rsa-sha256 header.s=google header.b=FFwa9RhA
Subject: Re: [Intel-wired-lan] [REGRESSION] Intel ICE Ethernet driver in
 linux >= 6.6.9 triggers extra memory consumption and cause continous
 kswapd* usage and continuous swapping
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
Cc: intel-wired-lan@lists.osuosl.org,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Daniel Secik <daniel.secik@gooddata.com>,
 Dave Ertman <david.m.ertman@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Jesse,

On Wed, Jan 10, 2024 at 7:08=E2=80=AFPM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Also, I'm curious if your problem goes away if you change / reduce the
> number of queues per port. use ethtool -L eth0 combined 4 ?

I've tried a similar thing out on our servers and it does reclaim a
lot of memory.

# nodestats | awk '/MemFree:/ { for (i =3D 2; i <=3D NF; i++) total +=3D $i
} END { print "Total MemFree: " total " MiB" }'
Total MemFree: 53934 MiB
# for i in p3p2 em2; do ethtool -L $i combined 2; done # <--- these
are the ports we don't use at all (they are DOWN, not part of any LAG,
etc.)
# nodestats | awk '/MemFree:/ { for (i =3D 2; i <=3D NF; i++) total +=3D $i
} END { print "Total MemFree: " total " MiB" }'
Total MemFree: 55279 MiB
# echo "Hey, here is my 1.4GiB"
# for i in p3p1 em1; do ethtool -L $i combined 2; done # <--- these
are the ports that we do use
# nodestats | awk '/MemFree:/ { for (i =3D 2; i <=3D NF; i++) total +=3D $i
} END { print "Total MemFree: " total " MiB" }'
Total MemFree: 58371 MiB
# echo "Hey, here is another 3GiB"

P.S> I've done these tests on a slightly different server that has
more memory (hence more HPs and different amounts of memory per NUMA)
but we have the same problem on both setups.

Maybe an important point, we set irq affinity to one specific NUMA as
that was increasing performance when we did tests so maybe for us the
better setup would be to set up combined 6 for ports that we use and
combined 2 for ports that we do not use.
