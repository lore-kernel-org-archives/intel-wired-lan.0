Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD93C54F4C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 12:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBC6580C16;
	Mon, 27 Jul 2026 12:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9-zxbyMVQbD; Mon, 27 Jul 2026 12:59:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EDED80B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785157186;
	bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mOBI6hD7r2bNSRjGElCXaNIb8MOmQfanZldgQVwWahIN9+8zPS2a2eJm1AVitzQSI
	 ZEoKMcEUidfNSiQtynaECj4cFpkvjZ2OJnrBm1DdkpYSdr5C9RNH3drxh++ee7ceLZ
	 ZN0eSrkF4AxZaArI7jqKc/BpE4u4OEPVaE9OiJz7OjClfxrrRfZ71Fh5kXzoWdGIeV
	 I8AdNoZHFk9Ll9/YfNuB/4uGYlAH9Z37qyj+dwt+YAIgM47dzRW4yrjDZPf7KwI8yJ
	 XTAifLWe2Ly7TIBucKpdSVGuGpe/qFaiRwznRWLzrdW15UMd6D9jeolvTtUGnwOgc1
	 +WZ4qF+SBt3Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EDED80B75;
	Mon, 27 Jul 2026 12:59:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 454A3194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 12:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AFE140063
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 12:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1nosGShWIrw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 12:59:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ekffu200098@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AA9254006A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA9254006A
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA9254006A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 12:59:43 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81e9d8f3289so31449137b3.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 05:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157182; cv=none;
 d=google.com; s=arc-20260327;
 b=OBES6S5lP+6RVh0rBl6PmD77rG/ctBHk1kAD2Ase0HcKudQZYLXfeW9OYbdkFXMZSD
 1LOfWlVorT0lcQsdiuwpva4voqbHejk+Ao8CkIfMi9B/kEbnDLWgTbJONvHgwKUilDQh
 y6hNQuWvS+mFFHs/2RIG+yorGeGXnTxnGZvQaIdXywzusSi66a+q9pZFmPxQB4CjGqSp
 sUksS9teLU5k7iLe7KJaRcw7XNLXuGdYhtBmuxuI+bvnGtuskduAQa0oh1ejssa25PQ5
 1uUr0lzh4iIuZJPigVggVnSodibrtZkGQb5Ie4XlRKnV6XgoPdg87IxvlFdj3CYGAdae
 ULGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
 fh=oAinjdPWSSaawtT956X6hXOBzzcGgSTE0/e4W0zvO9k=;
 b=GCrP1kfjRp+eM12c14Z7b7K642UWk1BbE4z516a7OoYVGuZ2CxBGRlE92YnFr8KUJD
 hTnbC4h2ufnHuXaIwgCq62LXlOzsH1FhZ1rYeqHwsH/kbDKaGctzarUMKnlrJiutDURS
 M+pKX1k298DLp8wo52oacIwOrFkf1CpFA7vCBbHbK8Zj9NjyYkTa6W6yPBiy7AvRrwNy
 17Wu4AfNy0ycTtFXdfb9QhVOhMBx++tNA0pwmjfUbnUg8OKoYBwQr/DCbCjNpZg0xnGa
 6cUKJLbezQuvzzhonbAHz68It//8punRKcYwWGi8hQ/SKKNeMF1oIp6uWAKOK1Cvqw5r
 6JAg==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785157182; x=1785761982;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
 b=FtT+boKzV9H4rteWOlhv4T+qpH2OWr3lWoEtk/d9mfgvhdxYI96sIa3hDzBl9xyGg9
 eUNxVWCxSaVHSgdD/4rNe/JKEnraounbZWtFAzncCEUx9nEwnLqpRWWB541zqhrHo4JT
 JrhBQwrLySXgvhG2TaThOIFJ7qKrAZhPs9VvZT/zpu5upauucpH5gBScdtev/qkAEvU/
 vucdkF18+awltMODdHtxh/RtD/Vb1psr7V3NjadVSN/1HMv0yMRrjTLlpxRxZs3L+5C+
 LmR8xmncPlmoGUtdH0Ujks8Tarid468flr4Hqq0gjbFCAL6MYQtMADOf1Nup9f2jqXFE
 7shQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLIz104vneMaUOKO0ND8+CETjUsQwuY7q7A0voI33b7DpZCNPzMPbbdI1j6x4g3Rm/Caan56TGpz16AIhheHU=@lists.osuosl.org
X-Gm-Message-State: AOJu0Ywp/1v21ygeJm4LRak6osB+nXwQRh4w199ggSGneBGnl9cAgAqK
 fofxhG0xDmV9/K0hjakE7CvgQ0LWzK555VduLriQOmiyVXKnIr1ntAii9QYSyJbi0+aGoIDzSFg
 jBba77M4/ugS+3JjYjWFHrqJo5vEN66M=
X-Gm-Gg: AR+sD13IflmsGYcE4hY/4GMPbZvh/Rbimn02osIWvmlNOV313AK+ZIKsQSzzbWx/iD4
 tjiBeq/ondKIR724OFOdiDIt3LkLY/beraXqdYOOaHNGj4AOyL79vceZk2fgSfqA1+wIrgqH3Rv
 KWKK3Mc83v6UEjbb4uzLUkI6/FLMYIESbBcW3lTy8mOnfzjuunIrVgmDYAGNdo3s/J76gFRVX/S
 HxWuq9vq11b7Zm8MV5o/FzFCOeo6L0AKUoccmSmGXUyGFL801/PkecKDf6TsPA6dAxrKA==
X-Received: by 2002:a05:690c:6f02:b0:81e:97e2:2210 with SMTP id
 00721157ae682-81f69ebac17mr31274727b3.69.1785157182142; Mon, 27 Jul 2026
 05:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
In-Reply-To: <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Mon, 27 Jul 2026 21:59:30 +0900
X-Gm-Features: AUfX_mxOitBR08KsPWHGWKTOhvBmlqBsOevQYdsbBN1kI3uyZROYcZJFQfRk1pk
Message-ID: <CABFDxMEmB=5UZx6RZgFNZyB5sg-+e2hgx_T1QjV0JzqP+auTFQ@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Borislav Petkov <bp@alien8.de>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Julian Anastasov <ja@ssi.bg>,
 Leon Romanovsky <leon@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linusw@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthew Sakai <msakai@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Mike Rapoport <rppt@kernel.org>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>,
 Shuah Khan <shuah@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>,
 Stephen Boyd <sboyd@kernel.org>, 
 Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>,
 Thomas Renninger <trenn@suse.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, 
 Yazen Ghannam <Yazen.Ghannam@amd.com>, cocci@inria.fr,
 amd-gfx@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, dm-devel@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org, 
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785157182; x=1785761982; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
 b=ChLm3EsqUNsfeYhWXc4j1GcDEF7JCWRZjQtTg5oL6dq/DBdQdsTEaH0o0z2mQpe5zh
 W4N/JTWvUTvskCgN2+G9NYEQ/Ql+qAeMh3hpEtn6z81+UyxP4W6dG37wFmuQOWtVHjq4
 gGoDsnx+rtpjF9zIGXpEpOa1ALA9IAqlqG8SIX/PZ/xnqnPpNyiA5g+yE2HfnYHiDsDC
 3C8hWvZKmXjukhVOvsfkghtaOR7afHToQnYYaHPwKExTgFnbw5NqIdy1tBvkbMedtbGi
 qbAHiywLP/f3cv5X4qA5C+FSKUjZl2mpOPke5kBvxTP3HYm5GCex8Jn/spC+EHZOHiPU
 MZFA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ChLm3Esq
Subject: Re: [Intel-wired-lan] [PATCH 00/36] treewide: remove conditional
 returns with no effect
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jul 27, 2026 at 9:12=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Jul 24, 2026 at 03:45:02AM +0900, Sang-Heon Jeon wrote:
>
> > All patches are independent and can be applied separately, but for
> > everyone's convenience, it would be nice if they were merged through
> > a single tree.
>
> Please don't do this, it does not make anything more convenient - it
> results in huge CC lists and makes it more difficult to work out who
> will actually apply things.  If there's no dependencies just send to
> each subsystem independently.

Thanks for letting me know. I'll keep that in mind. In v2, I will send
the cleanup patches to each subsystem independently.

Best Regards,
Sang-Heon Jeon
