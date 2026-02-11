Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C78E9E2F8
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Feb 2026 12:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF33760EF2;
	Wed, 11 Feb 2026 12:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6p64MXpvOos; Wed, 11 Feb 2026 12:08:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E80060F2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770811738;
	bh=3/vTkl6AvUhtleUGhfzTBlzeM/5VjtsQLy9IYXANB7M=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kTTfOtKIGFSOPj8HnhPEubC/j0KNUMYwWTax/DQ6SRFKk8iot7ReeYt4MC/elI/jV
	 WGRi8zcdl4Kvhgkqh+TpVd4AjULIDjT5gqxE0X2ziZ0cfZoWKqwyO1KV7z5YFk/Km/
	 pGAWheiKzOiaaZrVxDuhyZffuqZd+RP+hutA7bvbzPfTMSN/PJLEyLKqU7Ys2cjbmz
	 776WFrQTOtjnYuuhJPaQxFW/cpDB2Wf4PE9v0wO33Fda5BvrgozX2wlorGopSDD+1T
	 lPfhAd/9oArsaKKNBdoajPzEIprSwOx8soHnMIcMHHdqqOLir8v3UK+RJBw05PndCp
	 LnrzVCF8COR9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E80060F2A;
	Wed, 11 Feb 2026 12:08:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D40E323F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Feb 2026 12:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B938760F2A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Feb 2026 12:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQ-kzpHwoRFT for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Feb 2026 12:08:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=kurt@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9A8FC60EF2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A8FC60EF2
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A8FC60EF2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Feb 2026 12:08:55 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn
 <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>
In-Reply-To: <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
References: <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
Date: Wed, 11 Feb 2026 13:08:51 +0100
Message-ID: <87qzqr5vos.fsf@jax.kurt.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770811733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/vTkl6AvUhtleUGhfzTBlzeM/5VjtsQLy9IYXANB7M=;
 b=pL8ZfjDUF5ZD0/8j11okajAj6FSQhpdfoQD4uW44etpx8XP5QWbaRup1awTOtVIIbNsW7y
 07HcUy1uTgvmXBfarJhbeOpunX6Y6aJAaulyLsm/XZlFoOqlayV9i0O8q3D51llNqAn73J
 +YP+ZmTZFhVI0rVgkIDLcFuEhnjzfmPI9NogfMJ0lkq8Qri6/IELmN0vfd5BSXJlfCJPMQ
 WSebTq7GPY7cjT/9jNcdYJGXXJOweEhBRND1gE1I0uX/qFfNnY/xsI7Hs3UkHZ8+lGcvFC
 +4H74BS9DlhXrUTZgTJHjYuGF9IkBXJuKFglDunoIOv2RRx/oqQW/B9eHPfwmw==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770811733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/vTkl6AvUhtleUGhfzTBlzeM/5VjtsQLy9IYXANB7M=;
 b=atjWLwPMWpgm0wC3MfQan/BN02jSIISsUhcGZdRuJevEphi9wrjdm0kUwK/UYSgWxNJvDd
 RxQgAZ0dPAhtI5DA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pL8ZfjDU; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=atjWLwPM
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
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

--=-=-=
Content-Type: text/plain

On Tue Feb 10 2026, Willem de Bruijn wrote:
> The core issue seems to be that the ptp_tx_work is not scheduled
> quickly enough. I wonder if that is the issue to be fixed. When/why
> is this too slow?

The igb driver uses schedule_work() for the Tx timestamp retrieval. That
means the ptp_tx_work item is queued to the kernel-global workqueue. In
case there is load on the system, the kworker which handles ptp_tx_work
might be delayed too much, which results in ptp4l timeouts.

Easy solution would be to tune the priority/affinity of the
kworker. However, we have to figure which kworker it is. Furthermore,
this kworker might handle other things as well, which are not related to
igb timestamping at all. Therefore, tuning the priority of the kworker
is not practical.

Moving the timestamping in IRQ looked like a good solution, because the
device already signals that the Tx timestamp is available now. No need
to schedule any worker/work at all. So, it'd be very nice if
skb_tstamp_tx() could be called from IRQ context. BTW other drivers like
igc call this function in IRQ context as well.

Alternative solution for igb is to move from schedule_work() to PTP AUX
worker. That is a dedicated PTP worker thread called ptpX, which could
handle the timestamping. This can be easily tuned with taskset and
chrt. However, there's one difference to the kworker approach: The
kworker always runs on the same CPU, where the IRQ triggered, the AUX
worker not necessarily. This means, Miroslav needs to be aware of this
and tune the AUX worker for his NTP use cases.

I hope, that makes the motivation for this patch and discussion clear.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmMcVMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgkf5EACZwVUUvNc7py0uF6SrA9X07oBlVklo
StF+ThGyjZhpKPq2u+1MNjt/r4p+dibkjycrrom9LIiFHDWPA3poxdo7STQO8Vgr
zk62M3uaJDdWVKF4BPb4jiSyFbx89iTTJaY0WvHrwke5hHAy5hCk7Hygqn4BO+YD
507pyajHpayo3Bl4E07XUFY+A3VN0LtCpRXsl3FNqD08u0RiJ9pXUxixH16potRN
Nm8Jcvygsjj43FlCy5rPncp2Hurvj0WKvAnaYM7YmwLP8hYhxSd0UkC8w9uEkPYW
mW7btcjNhyh2fa4oNW4KIkAX9NWVXzoYj9Hc0p8defQEcQm348fjBpnQZZLk/DGs
LCFqfUgBetWV5OtQxp2RnkuvZ6HYYuTHzaN3c4aZiYG97znyEMijMN/RgR/gTqu4
e3blXZhLqQOB1QyxIviVKcuNlvUFVTxeuhMxzlUcDlCOi/hRZI/WESBYvHu3OQJ9
rqT2QwhDAht1OndQakb66Yan60iiMs8UdyFTRCQQLSn/FZEI8OEHzxbMC+vNLqZ4
Ut+W8xT7FQgPFRqVc9mFH+17JWQsoL5KdTqLPP4jk9mxzQMHZkzQsnERrFGonqf4
7UhLueNDycMMDU3LXCy1+4Fo+J8i9lXxmg4IXSR0X2Kws/Y9mtpR0u4a/ofe09WD
eH4n7GXcxYEO6w==
=yPTv
-----END PGP SIGNATURE-----
--=-=-=--
