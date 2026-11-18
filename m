Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D1606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W7tGhhhU;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZe09w0d
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2B998113C;
	Wed, 18 Nov 2026 13:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vgUqN0Ikc_2N; Wed, 18 Nov 2026 13:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2071D81169
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795009043;
	b=XKQ/TrQkz6rIHHfK5M1jektNitRjS1kYE2MqTsacSpw1GqFT+asSe19SQtN2rLt/pgls
	 N0eJhojCQoUcKoqQSPPB7LH/AyGgOSpllEeBoGvQurxvEz+chj0NZ116ff9g6Oh24kyfm
	 vYQgrdSBb4i1aNQJHUcv1dLsZmyLbqqS8Fctkiy2bc/W/DKfYHrBbQOhcnzHuhekwPIOd
	 YK2kuWGMpRINKhIA43BryptfCiovYCF7oscDOYMFTDaK2dvfV1/vHKxQ+dF/ozBFsDdoE
	 ohg9zvjfmtbLeDnMai4y5iBwz5jRYmJkLU8351YIHrISFfDgeYETxzoutbGxoZrSmHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795009043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+Pne64dTPZwiQyGJLnEYc8Ub7GDR3IIujV0fV2jCbvA=;
	b=gALye1A6xU/En6guzcxQaeGui0kY1AwZphHVVyTwChybzcZQnRdd4SC3rI8B/6WblddF
	 MFfczyJzesu6LNAOQihgdD/2pDxXmPhPQwSI7kADT58kxjSCHe4U05EwbzWtmAxETh22i
	 X5Y1e3nV0R63DGuHutfF9ykSINEMmeu7UyIYz07QJY2iXovCsu7lKxS7eDagCJrHKzjWK
	 6rWJbk7yKFkC3j4By0rWaaedw4Iv5J5LULWnin+kJLXJ3GCATRhaWdpJ+CFfkqXbZ9+bo
	 Zo2VFErJB19kD2eEpn1mO8kJgt0VYF+dvHR1XXaGrMCj1uYLqJZyg/Dnv++ghCc7ckw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZe09w0d;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795009043;
	bh=+Pne64dTPZwiQyGJLnEYc8Ub7GDR3IIujV0fV2jCbvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W7tGhhhUj4pKQo0Q/aAM1RuNlXwNA70nIn7aOJdMmbDdB/hNf1oCh+nEXbZBSCz/0
	 W08kbXi8UJ1LDY6SHtpezYHAI1X7ScJdwbPY9C0p8osVsqoTddp/InXpw7gJzf3TlL
	 4HmZsPrgnPPouc2ZrIPQmr/lTXy8ke58pagGSYnHDUOHnsMk0Nfb/YUur1LrSyD1I+
	 Mnzkw/2YvJ3aswgLZDQEoFhNeCEp69VXWtQ1FAHs6/Qt93MSqpyJWeeScs25WhED/7
	 yXcTu8wwGXFXHUODbmmXHzSUMPruCpmfIDmKga1zqO+yXwV5dMzf6vlfSFJaXajxpW
	 C5Us21vycJxFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2071D81169;
	Wed, 18 Nov 2026 13:37:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 544A549B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3741481169
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tp3kk6pk24ev for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 13:37:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A1BE8113C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=HZe09w0d
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A1BE8113C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 13:37:19 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso494239a12.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795009039; x=1795613839; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+Pne64dTPZwiQyGJLnEYc8Ub7GDR3IIujV0fV2jCbvA=;
 b=HZe09w0d2zw+/Ggu7fj1kbh5TB2XO7GZ2s3eUXKHY2HV2D3BMh0c05I7LxW1+vy4P9
 1/kO8VJiPqk6Erp1BD/jidRgYhdfS/3xomgZGDzLG7z5vtRigRnRvAr86U3WD7ln98J1
 bwmVi0TYt+adifz68g/8eAU0kGkCIdIZzeVJe6UgxrebDKkezoLK8n6TzNK1GWq7TGoX
 AE07tS+cSbixapV8bC0bFpghyzj15IPgoFVhG9DSXJ4CcxHVRwDcmjNtjL6iIBuY+U+v
 ylp4+v7yeUM9vdWg/KP9rb0ATvA1vPF2EyagzZwsrs7Q71lBR4NUPaiHT+d6kS5kiHmo
 Kzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009039; x=1795613839;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+Pne64dTPZwiQyGJLnEYc8Ub7GDR3IIujV0fV2jCbvA=;
 b=U9r4ZU7/LvBNPw/OokhpjZW1DYZpgvpDKDvsmVLj6MISaOvyiOC1D16p768Howh6jc
 VNHiOEiNlJPiqK14s9tPmkh7qomTW5YKB8ZUfxJ1BneCbixK57L7NMXCAFN4oS6NOJAV
 OkN3+JtAJ3RLBQPCgasEoJQ4nMEqM/9FXneAex+jbpcZ1M2pFzsS86gNGsKvkq4ywIQr
 tOfRhNDFjWqbAz7WBLhq7vljvKy3Ls0w4+dNeIk6Al3rIEXqcWZ3MMRueM+5GcGh/P1E
 8P39colH8/YQmIYsUjQGuXuqb+ij4lJic2yotW3cDYKQ5UE8mDbtg1WGPqbGBlal1uNk
 0crA==
X-Forwarded-Encrypted: i=1;
 AL+hErFXemF1yO3/F8o+wbruYJk9MfvMRh2zeIcRN72F5X8XsEz4TrFBxbZKZ/0ymo7NUAicQ6EzxZaXRFxJA3jU/bw=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8oFkoRtpbZ4ZoFDHbpjLOXuS/61GHoUeJeLK+vZbjYcfStsh1l
 VIPt2Z9/FavK8uFhEMlzgmqRCDSKx0bIcrByTlTTgpH31ldXgitxmStYtxq36Ie/11axJzwllrS
 /056d0MxOTN/b+jMdO3JuHoo9VJme4aA=
X-Gm-Gg: AZFdTZe8vcRjv45b7UdS2yf0N4Zxow3g68sm7Qjco/RiWxsHhzZ9dhvUaD4+9ivE/NS
 ar4r4O3CWLn/g1pxhCPr7thkNMgx4nRmhPZ0X9bq44RrSO6U9vvd2KC3zIeqlZZUbiNGsky7SD6
 PImY37rJxwy+qCFr2mjWFovnGLa2RKvMCLYcbcMumZ8WN49V3oFg5BaIb7gh+0oo6EFJJJBvW71
 n4wnoN/j2Ja1zgxedrcHW85XSdH+k/ib9BfwzzeNgUmldzUMI52DMyS62Htj6try5C1BN5XhR2K
 BBsfqjCOtHJGJgtaf7ESNTVGOj7CvS76VrmKXa42WoGeH969vZlhO28j5dngrPnFNk9rNZTH9Da
 6rL+SieKd/FzKTLf75r7CKdxrTpJt1N9DfswCUihnD2nbKBARvOmVluPvAw0m
X-Received: by 2002:a17:90b:1dcf:b0:3b3:ae0b:4e01 with SMTP id
 98e67ed59e1d1-3b3d074ce68mr2508725a91.13.1795009038969; Wed, 18 Nov 2026
 05:37:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
In-Reply-To: <20261118115915.116177-1-poros@redhat.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 18 Nov 2026 14:37:06 +0100
X-Gm-Features: AclHuK8kWb7QpgODRzoYcPDh6yhYlBlMmtzxE4k3I08iqW3ixJVQ38vDDF66nYA
Message-ID: <CAJ8uoz0MMUx68rMZWoZs-JwjodpRixwQSrgpyta1NsanGPn=dg@mail.gmail.com>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Petr Oros <poros@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 edumazet@kernel.org, 
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 13:00, Petr Oros <poros@redhat.com> wrote:
>
> I think this pull is a good moment to ask how fixes for Intel drivers
> should flow, because it is not the first time a fix spent months on
> intel-wired-lan and then hit a wall on net.
>
> My patches 2/6 and 3/6 have been on intel-wired-lan since June, v4 on
> July 8 [1]. They were reviewed and tested by Intel validation there,
> and four months later Sashiko found real problems in them on this
> pull. I have a v5 and will send it once it is tested.
>
> Jake's E82x timestamp fixes went through three pulls before a part of
> them was applied [2], and Maciej described the same loop on the i40e
> pull in September [3].
>
> I know Intel patches go through iwl and are not applied to net
> directly [4]. But for fixes it means that the review which decides
> happens on netdev months after the iwl review and validation, and every
> respin goes through both again. And if iwl stops cross-posting to
> netdev, as Jakub suggested [5], Sashiko will see Intel fixes only in
> the pull.
>
> So does the iwl round still make sense for fixes? Would it be better to
> send fixes straight to net with iwl in Cc, and have Tony's ack and the
> Tested-by from Intel validation on netdev?

Glad you brought this up. IMO, it makes no sense for fixes to go
through iwl and it makes contributing fixes (or new
features/optimizations) a lot more painful. Sometimes even to the
point that you just stop contributing something. I am not in the NIC
team at Intel, but sometimes I have to do network core work that also
touches our drivers. In this case, that patch set goes straight to
net-next (as iwl cannot and should not take core patches), but any
driver fix that I find on the way needs to go to iwl-net so that it
can go to net and be backported. So the fixes that my patch set are
dependent on and that should go in first are instead sent to a
slow-path (i.e. iwl-net) and after X weeks/months appear in net and
then net-next. But my patch set in net-next is dependent on these
fixes so I have to either wait or just cross my fingers that my new
feature is stable enough even without those fixes. Not optimal in my
opinion.

So anything that could be done to speed up this process would be very
welcome. Sending fixes straight to net would be great. The validation
team could pick those patches up from the list and run the regression
tests against them, or would that take too long?

Anyway, good initiative. I am sure there is a solution to this that we
will all like.

/Magnus

> [1] https://lore.kernel.org/all/20260708125755.706263-1-poros@redhat.com/
> [2] https://lore.kernel.org/all/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com/
> [3] https://lore.kernel.org/all/are4rBUJO3mzrkO8@boxer/
> [4] https://lore.kernel.org/all/20260721174642.7749143e@kernel.org/
> [5] https://lore.kernel.org/all/20260922112216.41e6f8cf@kernel.org/
>
> Regards,
> Petr
>
>
