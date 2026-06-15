Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EA9CD98C5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jun 2026 07:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16DF440F54;
	Mon, 15 Jun 2026 07:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zlGXQyK1k2aX; Mon, 15 Jun 2026 07:54:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3247140F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781510045;
	bh=OBrL6lgGQBMYLJZdswh2V1MoY8JuyilmLozsgGz4/8o=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rgx5qNNx2z0c4wI+XBIS0pLs4d81+h/Nf9QSN+bvCSNMKE/aiSnHiSyhdQPls2weL
	 GoTtyXvnV1QEE3iVRR8SB8go3g3+JXTcFZPVk+3UEcL6UllL/94f+pNRo6000jv1oZ
	 tk8jW5ss4sdTUROdFLh7GFq7B6RQ/n3UbPh3u0pXmi3aTNc2qpzSpJfPedId1Qapnm
	 T6EhMmXrUh3IH4MB9VUDan0nat4x0Dbp5aNRM6WJb1jhU9TafEdmt2j/00Uqt+HNn8
	 Fk+GQ4fZdOqXegY6NgreFPMhrrmFQ0x5vyaZ/E2cZSTqWx1kwtIumZ8XWTAVIgtL/W
	 J1Hq76aMww/hQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3247140F8D;
	Mon, 15 Jun 2026 07:54:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B16142B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 07:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A340640258
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 07:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkyXPC2QuhY4 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Jun 2026 07:54:02 +0000 (UTC)
X-Greylist: delayed 609 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 15 Jun 2026 07:54:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 81261400FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81261400FE
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=kurt@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81261400FE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 07:54:02 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
To: Tjerk Kusters <tkusters@aweta.nl>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com>
References: <PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com>
Date: Mon, 15 Jun 2026 09:43:48 +0200
Message-ID: <8733yojljf.fsf@jax.kurt.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1781509428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBrL6lgGQBMYLJZdswh2V1MoY8JuyilmLozsgGz4/8o=;
 b=ODNxDDQOCe9UfjLWIOph6jNPzGzUPcQ+xb+ydJN9M0i6CFMiDsHRgjKbJLr26Xs92UIUER
 lKk3TdIbh4npedW/uj/ukiC4XGVc+eObQqnG/f4MIP5kVqDZDM/CLqZ5YNUESHyzn+cLy2
 /yMm/xh19asWEgDKSKbe4u6Rg+QWSI2SfIM6JuIixgrz8fEimXRjEJxM2P4RyF60ZpOSK7
 Du6tM6kFrNhg64BegewC6SFUM7+veG/iZtTEBVDQ1OjGbkbULfgR9PhU7HX0X8gHyVY2Mt
 hV9T1J+MgpL1sefve2st+f6Ub7LERak9Nj+SzSHpQ5DlIoUYAxaXF4UOvWxOBQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1781509428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBrL6lgGQBMYLJZdswh2V1MoY8JuyilmLozsgGz4/8o=;
 b=/8pMZfjPCT/NlvqtaxZ/j9kB+C0va9VKo3CGEL3R2t074ZTbNOt/mu7QDZ8BlQUZmbWcIa
 6osH4nK734IJz6CQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ODNxDDQO; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=/8pMZfjP
Subject: Re: [Intel-wired-lan] [PATCH net] igb: only strip Rx timestamp
 header on the first buffer of a frame
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
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri Jun 12 2026, Tjerk Kusters wrote:
> Hi,
>
> The patch is attached (0001-igb-only-strip-Rx-timestamp-header-on-the-fir=
st-buff.patch)
> as my mail setup cannot send it inline via git send-email; apologies for =
the
> attachment.

b4 has a web submission endpoint. Maybe you can use that one:

https://b4.docs.kernel.org/en/latest/contributor/send.html

[snip]

> From fee3e3452dfcd7e109332369672a3e0090cadeb3 Mon Sep 17 00:00:00 2001
> From: T Kusters <tkusters@aweta.nl>
> Date: Tue, 9 Jun 2026 14:06:24 +0200
> Subject: [PATCH net] igb: only strip Rx timestamp header on the first buf=
fer
>  of a frame
>
> When Rx hardware timestamping is enabled (e.g. ptp4l, which configures
> HWTSTAMP_FILTER_ALL), the NIC prepends a 16-byte timestamp header to the
> first Rx buffer of every received frame. igb_clean_rx_irq() strips this
> header inside its per-buffer loop:
>
> 	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> 		ts_hdr_len =3D igb_ptp_rx_pktstamp(rx_ring->q_vector,
> 						 pktbuf, &timestamp);
> 		pkt_offset +=3D ts_hdr_len;
> 		size -=3D ts_hdr_len;
> 	}
>
> For a frame that spans more than one Rx buffer (e.g. a jumbo frame), this
> block runs once per buffer. The timestamp header only exists at the start
> of the first buffer, but igb_ptp_rx_pktstamp() is called for every buffer.
>
> On a continuation buffer the data is packet payload, not a timestamp
> header. igb_ptp_rx_pktstamp() already has two guards against acting on a
> non-header buffer: it returns 0 if PTP is disabled, and returns 0 if the
> reserved dwords (the first 8 bytes) are non-zero. Neither is sufficient
> here: PTP is enabled, and a continuation buffer whose payload happens to
> begin with 8 zero bytes passes the reserved-dword check. In that case the
> payload is mistaken for a valid timestamp header and igb_ptp_rx_pktstamp()
> returns IGB_TS_HDR_LEN, so the caller strips 16 bytes of real data from
> that buffer. A frame spanning N buffers whose continuation buffers start
> with zero bytes therefore loses 16 * (N - 1) bytes from its tail.
>
> This is easily triggered by a GigE Vision camera streaming dark frames
> (mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
> the all-zero frames arrive truncated while frames with non-zero content
> are fine. There is no error indication.
>
> No content-based check can reliably tell a continuation buffer that begins
> with zero bytes from a real timestamp header, because both are all zero.
> Fix it structurally instead: only attempt the strip on the first buffer of
> a frame, which is the only buffer that can contain a timestamp header. In
> igb_clean_rx_irq() skb is NULL until the first buffer has been processed,
> so guarding the strip with !skb restricts it to the first buffer
> regardless of payload content.
>
> Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: T Kusters <tkusters@aweta.nl>

Great explanation! igb_clean_rx_irq_zc() does not need the same
treatment, correct?

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index ce91dda00ec0..abb55cd589a9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9061,7 +9061,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_=
vector, const int budget)
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
>=20=20
>  		/* pull rx packet timestamp if available and valid */
> -		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
>  			int ts_hdr_len;
>=20=20
>  			ts_hdr_len =3D igb_ptp_rx_pktstamp(rx_ring->q_vector,
> --=20
> 2.27.0
>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmovrTQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgiv3D/0UL1rHA6YpGPl2jWtXbXCrHgwJJdw5
A7Gz5HXnRnXa9w1rEAJR5yTlDo6NGCctjf0ZQbauwUVEoZ24+mBdNWHZbRi+alOw
CiiLygla3wwCp6bwPdOfxoOWWw1RM9E+auZCv+8Gl9yFinuJkwY7ZgRmdzf99U//
FhM/mxLAcnheWAWmvPFeaQZY8jcBh7gy//sN5FaFnIamQXIVulKMmfLAuzqPtoUf
QMT/wL9nLi/yyp0cQUM9OXsb3WCFWfk1VyIHdOFtDKt8xZE3tgotUAH1JwYvUb5A
EBb7PwgbvPhlqBEjDgtCi7p+KL/Jk8AIxjReHNjG+nXxxc6FURTEkuvkHAu0Zfx9
O9hc9reE3zsvwDvtrL+wfcMst894XDrQfdlMhDGZDaDHkiOUHk5wpm2FTO3BhM43
cR1xUuXchLSmUufMYh4aW9iP+k6TqZqdRMK3x/v+4RGhkuHUvHbjEnyCKkfhsRAn
bqDgB2tnCHHHi3DUAPAu+fRf8yK/D5DYDWTrLT2EIsrDeTqU4DmTrA++NNsfkQU4
FqPIZssxIYXDDC9PtiG9CEscDL+EkMDeFVGzvYUIL5kLxAUl1UfmMCky9k7Qd4Mt
Paph8NOdC03rwrQQikqJ2SoH4hnakRiIeBu8YkWVhGKvzU/WTx9PtSKtrhVkzWeR
tnGF2+a/wNMIOQ==
=+94Q
-----END PGP SIGNATURE-----
--=-=-=--
