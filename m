Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69676ECD986
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 16:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 069AB41237;
	Thu,  5 Feb 2026 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EA2sL0wL3DSL; Thu,  5 Feb 2026 16:43:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 907C841216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770309829;
	bh=KydXj7FJV7eI4RaSnpEMpn04wpviyE/skfmAQzfW4aM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6fkSebzZw/qHSEDbKV7O1shz0D7GcIONki+1l4NjJYY38TtzKD1r08h+yr42BfggF
	 W4oeSimIE4G68w7Gjn8Oocd7CAM/kmR8VJ5ah4RmqM78stTomqnlLD8sBrl+i166PM
	 Jaek3SiUTtlsDXM7KQC3bMUmMOaTn/ye3YVKejTTKHtazZ8utM+v0O46ic44k540pU
	 vQYfjyGWORAoZCYiJ19Ovx0baT38qmYt5YM006EFTh9ucERbHSs0lCUaeCHynQrjJv
	 ByweEGZwszFLZWwW09KXkBClSO9JC4/r9w6HszUzbGjil3DPtSBthJR3RLDPjBUai2
	 X02yhxwN2RtnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 907C841216;
	Thu,  5 Feb 2026 16:43:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDD2517A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB28840876
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rKyg9964kGYC for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 16:43:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0440240810
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0440240810
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0440240810
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 16:43:46 +0000 (UTC)
Date: Thu, 5 Feb 2026 17:43:41 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Message-ID: <20260205164341.pJvni8kA@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770309822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KydXj7FJV7eI4RaSnpEMpn04wpviyE/skfmAQzfW4aM=;
 b=Pekszn7KxVSM+oHVMKA2ooTZA1dsyUwxEeInKoSTpq3sgNnDqBTggzelkybvmAfpAmJXKe
 gZ/3X5RTLYTh2YMXHB9+OnIeztFKZTraAjSsByLCodz+v0x0QIcNeF7sdsA8fwcn/tgCfW
 JXt8VZ9lTm/ZLzp9LFqpjiBbBYCev6StAZEDUDUgOF3CJ+uVjrXY+pWT0nbLPIrdEWsjqb
 V/mTl4wg3XkO5EzOf9UHRjO1U2N2rAY4pJJzwnoGAbrGN4xtGAMKqcxc5rivGVREO+eMX9
 LbvsdssTtNBSJ1wHmmRUVyVHIyIqu9NTknY0DkHCXK1UELSuZCtUddPz1K6e5g==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770309822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KydXj7FJV7eI4RaSnpEMpn04wpviyE/skfmAQzfW4aM=;
 b=ab+q7BSqcHxfuC8sKrooKlNeB10oMSiuEFxsifO6gvvErCt4H5ZyJdMD6xcojzWMQvZked
 CQgentwdMzdMCvAg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=Pekszn7K; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=ab+q7BSq
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

On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
> > So the only thing that bothers me is the read_lock_bh() in
> > skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
> > the same CPU.
>=20
> Alright. Now you make me think whether we should enforce OPT_TSONLY
> option on socket which doesn't have CAP_NET_RAW? Then we can get rid of t=
his
> check, and in case sysctl was flipped off - drop TX timestamps as
> it's done now?

This would "fix" this problem for all users which do deliver the
timestamp from their IRQ handler instead of napi. There are a few of
those=E2=80=A6
This would be considered stable material, right? (despite the fact that
we have it for quite some time and nobody complained so far).

Sebastian
