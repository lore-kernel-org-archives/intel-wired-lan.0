Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEB8EC1EA6
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 11:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9641960872;
	Thu,  5 Feb 2026 11:58:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kJIODETqWTG; Thu,  5 Feb 2026 11:58:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B951D607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770292711;
	bh=FaY+zcPJsv44lhmYeTzy0QXccJoXnwqwWFDyKJTpeRc=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9604O5Vl8y0lDx5AgSIdXoU7AZtuN25wGxq3eqFR1DH2/FYioK9tNENp29FHNcNO8
	 dwfvBONAornjnaqoH18Spjqeo/a7sFPSVUJZR0Oi+4z35c2amM8Gq6uDhRP0ctub/8
	 8JN+CimuWKwU08A+P0grJR5TgQ4re34bVmb4nxIIDTUvoAiwCf4bfYrv0orES57Dkq
	 wjjs5/4NHOKGZu8jb3W7ShqX6sIl1VcCyRTqtm2RhEAVs91LVfQN6MRTLfbRqhJZXr
	 eXcP7L410dkfMVUSmgtgQn/F2y3ySn6L1mjqzlKwfa892yYKT/RIbW7aW6i5MXa8Ip
	 weju4WCXrrL5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B951D607CA;
	Thu,  5 Feb 2026 11:58:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 861FF17A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 11:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AD4141177
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 11:58:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dm8jZRA6qOb7 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 11:58:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=kurt@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ADD044114F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADD044114F
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADD044114F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 11:58:29 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Date: Thu, 05 Feb 2026 12:58:24 +0100
Message-ID: <87ikcbwgf3.fsf@jax.kurt.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770292706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaY+zcPJsv44lhmYeTzy0QXccJoXnwqwWFDyKJTpeRc=;
 b=vN4rmS3QaOHC0G2Y7Vyl87abmG6X+AMgvf7NovoT/aTYnlc6qAXMxaUQ49STghr8zEkt/E
 rHU3dPC1LkzlC6I5GJFLtiHfzI2o5el4AKztHm/DDXbcCD4NvOIWPJECN3eDVUfRo4PgLs
 mYL1jRViE/RJTWfsJE8ITrfcqNfK/wg5qPt3hyBAygA6T+c9aVsSV9WGpumf+LSmKcTh6k
 ZmWb+ub3339Bc1SD2NLyNEOlKQnU0XFBpmdY9FUksX9Aagcm9QqY5xKkKDDaZu5gdIc4IS
 1L/A2ffInttIkqRVAl5aurEE7+QVG9CE5dwgza3gp/9vcv+fN3m0v4pdE31cMw==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770292706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaY+zcPJsv44lhmYeTzy0QXccJoXnwqwWFDyKJTpeRc=;
 b=6+ZmsWrQWpPklOV8aRq2FmT4SM82M6hCiQyG9ciE6tr66UcF4kwMHiaKRiSy+Y4bp+KmzW
 C7u56BbNeEl8UCCQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vN4rmS3Q; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=6+ZmsWrQ
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

On Thu Feb 05 2026, Loktionov, Aleksandr wrote:
>> +/**
>> + * igb_ptp_tx_tstamp_event
>> + * @adapter: pointer to igb adapter
>> + *
>> + * This function checks the TSYNCTXCTL valid bit and stores the Tx
>> +hardware
>> + * timestamp at the current skb.
>> + **/
>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter) {
>> +	struct e1000_hw *hw = &adapter->hw;
>> +	u32 tsynctxctl;
>> +
>> +	if (!adapter->ptp_tx_skb)
>> +		return;
>> +
>> +	tsynctxctl = rd32(E1000_TSYNCTXCTL);
>> +	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
>> +		return;
>> +
>> +	igb_ptp_tx_hwtstamp(adapter); <-Calls existing function designed for work queue!
>
> skb_tstamp_tx() can sleep
> Smells like sleep-in-atomic isn't it?

AFAICS skb_tstamp_tx() is safe to call here.

> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep

In case you're worried about PREEMPT_RT: On -RT the IRQ runs a dedicated
thread. BTW I've tested this with and without -RT and with
CONFIG_DEBUG_ATOMIC_SLEEP.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmEheATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpSIEACp5OFasb0yP4xndC0NnYoFS2pJFu4A
kYJaT8KZ+Om5qTpruFYi+RAz4eGL97eqg0+sOJTyx5QhQhl2glDe7OJMOyG3+k7u
LLOwCnIfldZI/7MatML3r5RmU5McpyN5lm4pLINEUPhRtfHzX9nH59mOQbrJsD7r
sSFxVvyd0IobQyJOhfS5rgxlNWnPAPHiv7iXglR5+fwWGIDXxYeZ82WeV9GhcIe5
hXOCrQcPqfodbNhuC+8g0q4N0tbTF/IINpv/s+O9F+9mCMmbteSEZIr02BGI4GbJ
dwUGLzj8vJYw0Cpz3lZDKesBYGz+qrKSbEdCUFDswlxyjFk2NlYjEP5pU+E9ssE6
ExDotEp/WgCj5AVTC2O0f4SuYs2EPwWBIfa0L4zcs8KHmRzwP9MoQ+ZK6tjlPCd5
FzAVdrLFgNgABUOD6GuvU4tUYjNQY/W1lGeYKrDL/KSeBBtpIAMSXsd6aOIGkKp7
AsZ0eNwLFfnWCuAFGqvn5PJfCJzbPmeIXDz2ZxFaH8GPwhDdEjrOMSR4djmtcleC
txcUduxQaBZlF2SyaJGHI96qs8D5aM2AQs0Pi7M2SvaSxXZXjTaYTgleRLZELmqs
QyqkwOa4pLUGIlBzupzo6n9BxCJ1WM74zOwoZIvcCUAMTrCsrojMxJNOfDlOawNA
wd2tjTxoKKz/7w==
=R2Ag
-----END PGP SIGNATURE-----
--=-=-=--
