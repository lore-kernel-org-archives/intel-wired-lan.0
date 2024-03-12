Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83870C54E66
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Mar 2024 10:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AEB840547;
	Tue, 12 Mar 2024 10:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gh7jDeEskBsF; Tue, 12 Mar 2024 10:29:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3646540335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710239397;
	bh=7BQBZQEZWzGbgfKljnIs0QsvUZnCKzK+sDNiXyr3xc0=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=01NQq6SIfchoi5BBHJYlzIzwyomD5q3MrhGkLYqk/B/LBH9SFYY+W5B4A8cNUSwGZ
	 K037U98Un8j53iJnDGm4PSqYuovuAP9ruj+68ahxFJdm51wEp3KI6pxSUJWr/OQ8Fq
	 oIc1rYzwVit0UWRxw+9A5gIeUMz3pFzlez5yGAEB2Y3yAbLofTzkp64HiDFDGYhLun
	 +Lgzg9EYJYW6t3WSglbgiw8AsKgzVrl2MuG+uNqjTGAdQnXW5d79dwaBGphSp9Vjqv
	 7pWmO8gWujIUcl3bEGYPjhuBp+VTiGLO0eUgT9D9PAJFbF2eET5Er34S8IPBLM01ft
	 Bk7eKd6kz9m2Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3646540335;
	Tue, 12 Mar 2024 10:29:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id F37021BF34F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Mar 2024 10:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFAB88145F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Mar 2024 10:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xa0dkywUGiIo for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Mar 2024 10:29:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com;
 envelope-from=erwanaliasr1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 948C98145C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 948C98145C
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 948C98145C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Mar 2024 10:29:53 +0000 (UTC)
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-472967264e7so1751775137.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Mar 2024 03:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239392; x=1710844192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7BQBZQEZWzGbgfKljnIs0QsvUZnCKzK+sDNiXyr3xc0=;
 b=TDhWoP9DVQqAwrUQvnDDHUnk2xvc4afpJgoyXt44HF6CVSkud5rZz2zpc4FyzwMzKf
 hijbMQHPHQG7u7AH3EBSS3u5C1v2Jy1Ja0ZyRz+QqueCr8st2uzdJM5CSNbR7ib3tCVF
 gEeyAHWOwt3w+ziaiOkbACN38ikhkb+YfuhhY8n97TMfPR17Osc7U17FovQ9ruL3bLAv
 xT6u31D4xhOgLvGbfGUFld2GyF/51qfdw/4/5tO07GmdyS20fmKGBB6uY+fpw2EPxeEG
 5f1tDk5tHKG9hCnUnZhETP8iuGpZ+qDDwKwnXxBWF8Tx4t1qcCiXg1w1wfpqiZ58c60O
 tDXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw3QsEIQQwvuPp+XeU4WJJ4h65KJrjmNfr1AWndsnFFqkZZA6SSyg1q3hrRoEMmdKRB7L46vcY3cO+wQhFSV6ODvBbtoLS68Sz75KaW4uSZA==
X-Gm-Message-State: AOJu0YxYD91G8hWPU5YPbTzY9+yl2EbV5H+5PRXOWvmzbeYjFmif77ua
 SmBWOVGhX8yIBsanHZ7Ps5Xi99Jf5+8NjyTQrF62exOMVzCCY4d0jrOnzdvM9g6+Z7GRj8/1Gc6
 4DiVA4OKEcM3Ijvq8PIQGwnr3Tuo=
X-Google-Smtp-Source: AGHT+IGkD0P7F8tx7lwSIyxICJzqzXGcCdhHe2449N4OpO89nUTsr1Ql+xRN06Bb7z+1VPWcuB0lRUbKcsBeXplOK0I=
X-Received: by 2002:a67:b347:0:b0:474:acae:f3c3 with SMTP id
 b7-20020a67b347000000b00474acaef3c3mr710675vsm.25.1710239392315; Tue, 12 Mar
 2024 03:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240312094259.770554-1-e.velu@criteo.com>
 <7169b33e1e4487370a530fb60d97dc096a24acfc.camel@redhat.com>
In-Reply-To: <7169b33e1e4487370a530fb60d97dc096a24acfc.camel@redhat.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Tue, 12 Mar 2024 11:29:41 +0100
Message-ID: <CAL2JzuxA1h=L=0cr+Q6CZ9UDbHB6ptbzCQ7gZddZLi2JumdLQQ@mail.gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710239392; x=1710844192; darn=lists.osuosl.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7BQBZQEZWzGbgfKljnIs0QsvUZnCKzK+sDNiXyr3xc0=;
 b=fll61iwmUjCm78Y5A+YpIpOyC10IPQJO2038PjjjS6HaXh4OT2iytakhR0bXq7W5d9
 u1msiTcI/CFYPmu6+XEcPR53FwyWwcvi5dAz5hocentFTK4LF5r/seM0bN45n8bMG0og
 7olc4ajSypXJlfzEgSPIrgXcsBXGyySoAQ8TbEWouedbwRN3crr9Obs9tSX3a4VftHA5
 Lc0Opuejhh1eOExgIbvCvbxkbAGA6uISRVYJJ5b+GMpgFJEm8t5N67N5kWE2zpdT0+Bw
 v2NNOMah32GpnpIPVvIMkB3GOm5U6tQ9BqwjVoDHOBUohRt63tiQCvf8mHtxEOHdawlh
 ELng==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=fll61iwm
Subject: Re: [Intel-wired-lan] [PATCH v3] i40e: Prevent setting MTU if
 greater than MFS
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
Cc: Erwan Velu <e.velu@criteo.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> On Tue, 2024-03-12 at 10:42 +0100, Erwan Velu wrote:
> > Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
>
> Please use the checkpatch-friendly commit reference: <12char hash>
> ("<title>")
Done.

> This looks like a legit fix that should target the 'net' tree, @Tony:
> do you agree?
> If so, Erwan, please include a suitable fixes tag in the next revision.
> Please include into the subj prefix a suitable target tree. I think
> this should go first via the intel tree for testing, so 'iwl-net'
> should fit.
Oh I didn't knew that part, thx. I'll wait @Tony to see what target I
should use.

> In any case please respect the 24h grace period when posting on netdev:
Yeah sorry for the v3 ... I shouldn't have done that way, that fast.
