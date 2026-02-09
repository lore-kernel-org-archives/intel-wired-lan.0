Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A51E78D68
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Feb 2026 09:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71BAA608BD;
	Mon,  9 Feb 2026 09:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjyqmjD3Wtzv; Mon,  9 Feb 2026 09:06:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F07726084D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770627989;
	bh=izwmXDGcOhI1rhK1YptHQ0xdhXMS3g/xP1mQsaYPcIA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6lWHq9gyp767MC+Ghiywu33zjp0TSYBfVkwRmnXs4gWHgki/yAWaNpKnzg6TwWbA4
	 2KQ5wG2uIfQ2dZ4D1reryddmDi8ijOEsNwtrH38AbpP5Tk2ve+geP/s/qvH7Pd4cAd
	 8kEZOPAGnQwoDHuM5eCDAC0Sa9unriI7Qz8bDQK2DDSSe0AztFmMFGJMEnVUWYeiij
	 f1i0YN4PdLQiL95vBWsHBUIny8O3/rfcliZveRyxUy/vvGTjzSgI9CYMzEGX+Zhe3K
	 Kv/9sooJo+judW810tZPImF1B6DyMIYXWvmH7ePnemJwswJH68t4HJU5ihc109Cd78
	 5BCt6PhNmIF9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F07726084D;
	Mon,  9 Feb 2026 09:06:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B4F1C2A2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Feb 2026 09:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 720266084D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Feb 2026 09:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ptVRoCYziX6g for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Feb 2026 09:06:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5854C60844
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5854C60844
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5854C60844
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Feb 2026 09:06:25 +0000 (UTC)
Date: Mon, 9 Feb 2026 10:06:21 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <20260209090621.GiZqTiMJ@linutronix.de>
References: <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770627982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izwmXDGcOhI1rhK1YptHQ0xdhXMS3g/xP1mQsaYPcIA=;
 b=nds2+wjToppI2hWlDjPSv8KFw0Ambxp/OYf6TtQ2EAxUoHIdSZNhrP1jpDUPIYEE3d6md7
 epTZl1IXdHbpnpQKgOImpOLKdnnQiJwmBUXli54nJql3JTmhiI9PoCimLzgUtGVRFrjWEd
 +a3HgIdIqrL9zd25v7SXSng03Y/DBCEMzx+4RvLcl4DCAGjZckAHWGUjZD5aMMkzk1xadu
 lgi+XfHVTjP0WXxrzb2IH7KMjMrwi13EvWehA143lpJl5swkt+YG9SEmEObrhoe8HTvYCS
 Uk+SfPXWxgXtl8wplu3Jzgy2njVwokzyb2EXrr1dZDi2tB4c4Zv/OI2GaOEOGQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770627982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izwmXDGcOhI1rhK1YptHQ0xdhXMS3g/xP1mQsaYPcIA=;
 b=KBSLFnNvVcg2VTnTtba4F0uRzD1NwuN+RJSvnCmiYMGvjLlKaSRLdMEQV5hWqEbta+ksb1
 WUj29unSJMCYVFBA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=nds2+wjT; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=KBSLFnNv
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

On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
> > >> But it's more like a question to maintainers whether it is acceptable
> > >> way of "fixing" drivers or it's no-go solution
> > >=20
> > > Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
> >=20
> > Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW=
 all TX
> > timestamps are silently dropped.
>=20
> Are you referring to sysctl_tstamp_allow_data?
>=20
> That is enabled by default.

Yes. If so, then we don't need the check below which requires
sk_callback_lock.

Are SIOCSHWTSTAMP the legacy users or the ones which do not set
OPT_TSONLY?

I would suggest to move the CAP_NET_RAW check to the point where
timestamping is getting enabled.
Also if ndo_hwtstamp_set is the preferred method of getting things done,
I could check how many old ones are can be easily converted=E2=80=A6

> > To receive these timestamps users have to get
> > CAP_NET_RAW permission, and it will work with the updated logic as well=
=2E..

Sebastian
