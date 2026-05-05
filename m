Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E34FF885A
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 May 2026 01:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BFAE810EF;
	Tue,  5 May 2026 01:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZ4A1-vz4Bw2; Tue,  5 May 2026 01:26:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8608810F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777944399;
	bh=2N2W/P/nghWCch8k7VqHw89LB387uaVtb/VGfYKc+Pc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0DtQkM4tiE8rF5+6vxAVB330A+0QeH8iUiJOmKj5Y4wKqJD3D5Vnq4m2HZ/gdCv36
	 ltfFbhE1TqCR82kDJ89qOxrOFlDEl7MMcR3yiVWgjMnQT7VwAhdccE8dD2Up1FIxP7
	 j9RbV5F/jsizIyl5PqNxczicxSr/W9qnLex7sYBlgTk2rSFCwzI+uFYp2iH6SemI59
	 hYyUKbwfi68nhQ3lFKI0XPn3teaQekkXao7mR0P6Ukttummn8KOuT6ADc1EEMpf8jq
	 Yd7GE/4/XgPzsAxtzUmlTe1W9/lvesv2SsNqUHP4o3roAUnTyOGWjZVACCXpQ+OL+b
	 79b7WRKOFy49A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8608810F2;
	Tue,  5 May 2026 01:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3324430A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 May 2026 01:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24A2840121
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 May 2026 01:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LRA1suQAl-tn for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 May 2026 01:26:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 879A940112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 879A940112
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 879A940112
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 May 2026 01:26:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29CD04066F;
 Tue,  5 May 2026 01:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3D2C2BCB8;
 Tue,  5 May 2026 01:26:36 +0000 (UTC)
Date: Mon, 4 May 2026 18:26:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Message-ID: <20260504182635.39e1b7a6@kernel.org>
In-Reply-To: <D670011F-AA11-4AFF-A70B-4DFF03C5F049@nutanix.com>
References: <20260504154823.2535612-1-jon@nutanix.com>
 <20260504164901.7b3a737b@kernel.org>
 <6F0C5872-0388-47AF-8CD9-1D116EA13224@nutanix.com>
 <20260504180656.62539d96@kernel.org>
 <D670011F-AA11-4AFF-A70B-4DFF03C5F049@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777944397;
 bh=wmOzGc/Fp8zFwcVA/+EiRdoheVyhK7v5Xvoe5ybKfxQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=s4rT0w84GV4YzmmCoUnJ5+KNl6+u6rX0I4juDTIJjtzGadKYVLDfCHW/TosEisKMw
 eTqpXGgMExH3eVJtfOtVuW8ks3O5oJB+JQ5Uaij5ezWdtwlHSmuVumb1cuHT2xPlzU
 t9jJM/ntS+0miFv8BaizcRRMvuLf3maGUV7i+96TcCSOUQSIOrPETj2IitohTXL0Sv
 vx44UnA9sb9PT5kforhtsIgnhM9vM6ZeMbdTkNqfRVsdS34YD+np6E8pOnvZ5TdbKn
 jCtjOOy42x3BHBSd6SiZgdw+VCbutpJ/VFJLoYpbq1+fQ6XOCVyIGcZrWxv2d3BLHE
 CQaKH+E2p5DTA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s4rT0w84
Subject: Re: [Intel-wired-lan] [PATCH net-next] e1000e: ethtool: add
 get_channels support
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

On Tue, 5 May 2026 01:12:29 +0000 Jon Kohler wrote:
> > On May 4, 2026, at 9:06=E2=80=AFPM, Jakub Kicinski <kuba@kernel.org> wr=
ote:
> >=20
> > On Tue, 5 May 2026 00:59:40 +0000 Jon Kohler wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> >>=20
> >> Perhaps, but I=E2=80=99m not sure that is a guarantee. A good relevant=
 example
> >> is when I added get_channels support to enic, which supports all sorts
> >> of channels, so I don=E2=80=99t think EOPNOTSUP can be 100% consider r=
eliable
> >> in that case. Meaning, if it just so happens that the original author(=
s)
> >> didn't put in get_channels, that doesn=E2=80=99t necessarily mean ther=
e is only
> >> one queue.
> >>=20
> >> And in this case, there is an "other" queue as as well too, as far as
> >> I can tell, so the output is at least semi-interesting. =20
> >=20
> > Sorry I wasn't clear enough - if you have an actual, real life use case
> > why you need queue count of 1 to be explicitly reported - please explain
> > it and put it in the commit message.
> >=20
> > If you don't - please don't send patches for the sake of it. =20
>=20
> Ah, ok, sorry I misread your message, this isn=E2=80=99t a patch for the =
sake of
> a patch. Long story short, we=E2=80=99ve got a user space part of our con=
trol plane
> that reads in the output of ethtool -l as part of some broader queue
> management code. On systems with an e1000e device present, this specific
> component goes into a crash loop as it expects all NIC(s) to at least
> give it some sort of output.
>=20
> That crash loop is easy enough to fix to ignore unsupported outputs;
> however, my thought here is a simply defense in depth fixup, especially
> since the kernel patch is quite trivial.

Got it, thanks for explaining.

My concern is that if we are expected to always report channel counts
we're signing up for a major whack-a-mole with the existing drivers.
Most drivers don't implement it. The networking stack does report
the number of queues the device asked for via rtnetlink:

ip -j -d li show dev $ifc | jq '.[].num_rx_queues'

but in your case I'd personally lean towards user space fix.
