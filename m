Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19E606A324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1UKzm3Yf;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=qVPRVx2K
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C718D405B6;
	Fri, 23 Oct 2026 14:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWOXuK0COGXt; Fri, 23 Oct 2026 14:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BCE6F405A9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792764839;
	b=JsaaVkYAWBzdNT9lmrTj51euSLjV0kuuyiAjKEYdVb6dLT2QXlX0FY+H4ZzVbcmWoOz5
	 8OWaRJPj3Y5h3SxlMML4BUVWMfI+GDuinEfMRNE0HpAIUvxEZf1Bdri/zj/3Rcnlzd4zG
	 g7TuM1NMHeVPTx6zyD1lnqPDVCLp00xuJ3kFAvCEhGJKEIZT3r4RDeBLmbplPY36ClgQ9
	 AJr4CPxWDCv56lHjXYNym1/ig+uRn3dklyhxrnXKwQi9mSTgnzPwjLP4D0otJz3jrNqe4
	 XhRr5H4GIeAM8pLEkgWksrr457pKf0GJwNhsX2NEtinqiOPSm1UUZZmtpWBv3z+smAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792764839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J1uVLXrP2VUfLCBDBnXOa4nyynN6pF7eavsl/v/DnRE=;
	b=fbPLqJ2WU0AP6j6MBPKQtUNOE9hDP7C25tpDJZh8ZCnhkZNWEwFth1Zs61aF+LlsGgyU
	 M9r8G8ljEtHxvZ4v9jvhn0zDai47Dw913dVKlovRiTM5d+tuPjBLWIvKUr+uV0/xJ7ei2
	 Z45odGeHGyin/v/zW8cFAZT8nd6BebskPqbhM0ZGQ8OvGSHPSMfUsZ0aZrFP9N7sUEw4k
	 A7gkANfvIOVF1NYsRBHYTLKCDbXrfMWKGAyqbpWRdG1bnppuh+kQpIlHvsL41KCq/sANa
	 JFILDHuAzd/KJbJLBsUi2VM0+e7f+/pIvJb23gy+JfNi0AhQPD9oluaupa8kV+u4low==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792764839;
	bh=J1uVLXrP2VUfLCBDBnXOa4nyynN6pF7eavsl/v/DnRE=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1UKzm3YfSvyN2XJ8T8Zc5ClFxL3K63lFhV9fq3PglTPQgAyq9fPk2+M/oyCjL0D0c
	 GKe81Gq6zKibou670O8/GHjpiVVpf00s/r95vCRUgqV7aqpe+mS1zpBOHiGvfhoL74
	 VQoardMyMbEafXTrzg+kZ7EJABiE5Vi/71kJ9ngKO8BQI8LxE8fxHZ8edhfaJJ9dbS
	 pFMuntect2xRYMKNpDWzxbof9B1KNK1UD2okeRyIPRuq5t6ncJL9P92j+gOWMLnF6L
	 VgQkz8c+Ou5ISrImsep97+J2/SNhNpnGsuSyPyqgE9BVG3RPM9YYcZtdpJBS6UKxO9
	 qKoDgD36PpTew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCE6F405A9;
	Fri, 23 Oct 2026 14:13:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9FBD356
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB4FC80BCD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YjoB5UyKimdS for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 14:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2684580BB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792764837;
 b=FheSpgmLhkQl98s+flXmzZjNkH2r3B7o5nvqizazZyrksb98vR8vFJ6Zs85j8pArufTV
 QyupYBmfTQIFMXVkMZCoXGSw0Wty8h0aU4bpxvxuZnn8ebOekZhyo1gWafhIEMrZu0Z+1
 kZEVBUA5XoVt13xr5Tdy67s/fyj9nJKzjJMLbbWQlvW1hpHChXCdX3iAJw7oZ0Nn6H/Pv
 jL4Rv42AKnIVxk+gngwAO2ekfuejgM/0Ixj4r3j6NzAF78kgGkLYP6JBqjQwECz9eWZve
 MNXXnw2XhlhioMZaVXThls9lNLyY/DOdDuC2LM/C64/NV8mEAC8XL0Oww9qNv4XTM6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792764837;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=J1uVLXrP2VUfLCBDBnXOa4nyynN6pF7eavsl/v/DnRE=;
 b=cnbpiKGKv0psmrVWP3wTkmTyesMUT9DKIgxweJksUxr/Rtd9/j9sqg5fD1Jtvm39asrF
 nAdbmcKKt5MAhd7rSfL805VcQa8dhxH2KR/2wNiRiksXCxOtsD/UE4mpqQPP9ZuTh81hi
 vlxzkvCk2AnOKJUPFsMikX0eW68FXw6/CX9xGYeeE6QQbCw7K/R5GPiG9zm5J/aWWQmy4
 mOsKmF7J5DlrtyDmBRMFyVQYBvUqrFhTonryjM6KJ4GfXcAC/MSAXVq5wR68LBCbRUmS0
 80gxz0kY65dp4I2tpn7yXqa/m0Sbnb3UrRoT/gKf2AygeEfGb8B80HXaFyCRtjxfieQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=qVPRVx2K; 
 arc=none smtp.remote-ip=185.70.43.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.18;
 helo=mail-4318.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=qVPRVx2K
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2684580BB2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1792764832; x=1793024032;
 bh=J1uVLXrP2VUfLCBDBnXOa4nyynN6pF7eavsl/v/DnRE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qVPRVx2KJkZqgOoqwCznUE/sIAqy40GAvv2BXne7a6FOwy/56svtqOm9ImLSjAv/y
 EAOsuS/qfOortQd770yPKCNa6PAPsr70i99AxFWyrn74gFYOtXmf1xrM9InmPe5XEj
 H6o3nf215g9rCjB253xkI7bOZW1isqXveguCK+5qRQqQy3ZVfQVLxBUlS2b1ecK0Yw
 NGcy3TBr0HeRwoIHVRA01YonRSyzMykOCG6rO0/SZfL8LWq9qvnnxlvLvaTqAmBZPP
 Sj0k/5BirM4GL1vmfEpayLjLh0UyHAxzAql2LsPDOygfKnk2g4ZC0l3zLH/636zEO5
 y26YegaRSz0kA==
Date: Fri, 23 Oct 2026 14:13:42 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <20261023141317.3904442-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 459190e83447046727bfe621ed78266b52582fb8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Converting an XSK buffer to an XDP frame allocates a page and returns
the original buffer to its pool. If the TX ring is full or DMA mapping
fails, igc_xdp_xmit_back() returns an error without freeing the copy.
The RX cleaner cannot release it, so the page leaks.

Return the copied frame on TX failure. Save the RX memory type before
conversion so native frames remain RX-owned on failure.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
Tested on Intel I225-V with baseline and patched kernels. Physical
pause-frame backpressure caused 46 leaked copies on the baseline.
With the fix, all 72 rejected copies were returned once and freed,
and all 192 copies were accounted for.=20

 drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..39263fd04aa9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *=
adapter, int cpu)
=20
 static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff =
*xdp)
 {
+=09enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
 =09struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
 =09int cpu =3D smp_processor_id();
 =09struct netdev_queue *nq;
@@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *ada=
pter, struct xdp_buff *xdp)
 =09txq_trans_cond_update(nq);
 =09res =3D igc_xdp_init_tx_descriptor(ring, xdpf);
 =09__netif_tx_unlock(nq);
+
+=09if (res && mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL)
+=09=09xdp_return_frame(xdpf);
+
 =09return res;
 }
=20
--=20
2.56.GIT


