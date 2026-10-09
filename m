Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0820BCA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1C3681495;
	Fri,  9 Oct 2026 21:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id km8fxthtnDcj; Fri,  9 Oct 2026 21:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E90408149A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583020;
	b=Un+db/gFi2GlxFUHoE2xxCE2FgWJpVQYsUxzx19sNCt4JaJamWsYlHLJlm98FPG5O1U6
	 7p4e7zufKeFTuDjZkjjbjQUVlnVgiNq7ayhvi98jH9EeuxJAGLy/BM38ACc13o8RZfXau
	 OvNQaFAs8cbYtzJKxvBMXpPat0YUPCnjCiWFy6EZ0o/rQeH138Dx4/sBpgO43+dZzUtue
	 Fv+6eW8anXKsb/1MIs3KTtEYxkmpsZAICqW3QQRBpd56Tb7gqhe/4r8LJ4dMeQvBcib+v
	 LGfVqLVXqIV9q3gEP2rpcOLXXWb5Crk5b6ChZfDwLJPhuTCISf8yvuJnAjeFd0MbkbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=sLmtlJ6FMcD4qG9Z1mKHYTDHQDtwKt61Pybfe58KAMs=;
	b=c7n5NO+DC976iBn8Mr/h/+foGk/Iw5OgVQQjg+HlY/ONrNotVWDqSU9n3BylJTbdGkrO
	 ZS0U6/SZQ0qwvfTY+WBvnC74ABOV+XFD5DPCVW3RAshECi/RmRtSzVwk7OBQMekoliFV2
	 zv6iynw6vw45im173NU+eVNTqOtzbVs7DqAPI/RGRq/j2FXH63WsdUDZ1kEbFjUiFMB6U
	 oqRd4uylbe8a8BL7gczzr885k7t8IRnmiVVMcKPO/xq3Q7cyKMCRpvmbA60hEl8boS7Np
	 WiJVbyrolkDMltsGNQnc0g1URG0P+auLWDPh0Bc81Kteg6PEz4VA/Rcqrp5YrOKoU2Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791583020;
	bh=sLmtlJ6FMcD4qG9Z1mKHYTDHQDtwKt61Pybfe58KAMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=e6u7BWdUt5V8b204c4eJ2D15U2jPWsGjk7Fn+0w+zyiTSo9IzUD/QoFDFoe8Erk8J
	 pi+Y47S1aCKzCLz7+QpGaWxDUwuWNf+vPJACpr2qt19HyuDHip/3tG/ot6TFcq81bh
	 oBgcPyiUTBTGqIpnXIjKadLlnAMjhsVmmjOVVzp7DHxtfuvUpqOm0NeS1S2P0AYIeo
	 5ISD22nI7yYDdHo6jcZABCHhGq+emdpp12oeEvcezfWKKyq5ogwvb4XB6pHTynHGgA
	 Af+b1Y98DIeajOCyUquChqheMZwioLj6ui4s/ezYFou+XTgBOzXzBkTUFTWUZUg5qw
	 3XA1G+GDTKEWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E90408149A;
	Fri,  9 Oct 2026 21:56:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7EC8184
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DFDF60727
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4km8VMC_v3YI for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:56:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A926F606F8
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583017;
 b=qHO3JkHZmItwHka2NFb2G3QIwDsdsV6/0OPpWjtEKfO0r1FTFE41kvcL4pwZzJDfBKTp
 JjVqdqOwWKMfehPInCuiiMZetvNdDRa5oNZg2wYFnCqxxf8TtdO05dE4v6QWSgluQAajt
 Mcu23Goj02PS1l/elj6iswaoFtiy4Ydzgjsreb53DeMnT1Cl5KvbeZBGWl50/6um+FKb2
 7rhH7AeI0AlIZVRErq6wE8+qRXDvDMcZ1y9nGljmphdPDT23pQEm6ghxtMMQ+WyQ4i8xe
 c3Tc5xaqVOYpuVu2FbZq/pHp3qs8oU12Zpjt1bqklura6t9gbqyVp31n4PxvmnM/R8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583017;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=sLmtlJ6FMcD4qG9Z1mKHYTDHQDtwKt61Pybfe58KAMs=;
 b=YAP0xzQ5o6xTe3X5spKzx4WmVsN3zgSo3+ZobtVRAoZCMpSLRwEAcBRs0k60gEdM6Seb
 VvwdjXBxmKQsa1NOy9x4uWp+/YkFVs2STF+4RvbFyPJ9np+1LL8zECXdFA73jfVEXnnnU
 FlUGxBjvDL/fTnCxQxQdaRtDuPsvwgzl1dDDMdmjxkcRnsev7oKVc7CxXRxR1Tlv5JCMp
 27kHnWxmtKmAPvujy0bwvsqr7DmjNWB4CGPpOmYznDsxslKi6f/DlsazLgQxU9TV4fKtt
 kQAGvYKLndc3XUQ4J8SI3iN+EMZkFv2kwUmoB92zVisuQ2dnBYcArAmlUF7j6wBAO6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KYmYQ4rY; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KYmYQ4rY
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A926F606F8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:56:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 686436021E;
 Fri,  9 Oct 2026 21:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA51F000FF;
 Fri,  9 Oct 2026 21:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791583015;
 bh=sLmtlJ6FMcD4qG9Z1mKHYTDHQDtwKt61Pybfe58KAMs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KYmYQ4rYhCULbGgfMLNhu/yi21+ATzkpHyN7hOgYI3yBjvXnx3wJ243mRYu/X3LOu
 9tfUVxF9dFta1Rp+iE5aWvKM9L1A9d7D0QFjTK0NQlvK2wZNHiJngyu3bk11B/My8m
 Kn3auGIAnzbP9uIk35/CXH/pLPNUA2rK1P2v+TOOYphMicorA7Xxh1OdfURsOr5HIm
 1zGZFJNHii0RTX2hiJhZW+tA7Zw3wxDjcGF+dixX/BpQC1+ZsuBIUM5f5VHrKcsI4U
 gE5z2j7RyL4O6yyNofEUyUdeeXhPR8WfX4g1F8pilR07f0GBPBJafQBsu8rOQmxs3Y
 H/sbpWdd/iz8w==
Message-ID: <sashiko-outbox-166100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 2/2] idpf: release PTP before freeing vports on
 the init task error path
To: "Emil Tantilov" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009212537.3996-3-emil.s.tantilov@intel.com>
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
 <20261009212537.3996-3-emil.s.tantilov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:56:54 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] idpf: double free of adapter->ptp due to concurrent idpf_ptp_relea=
se()
--

commit 140d271eb2e765967ee1a351714e7ad1ecc7d8f6
Author: Emil Tantilov <emil.s.tantilov@intel.com>

idpf: release PTP before freeing vports on the init task error path

Release PTP, which cancels the aux worker, before the unwind frees the
vports, matching the idpf_vc_core_deinit() order. Previously it was
possible for idpf_ptp_update_cached_phctime() which runs via the PTP
auxiliary worker to read a non-NULL but already freed slot, pass its NULL
check, and dereference the freed vport.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index a1c739cdd5406..9c541dd6ed4d4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1747,6 +1747,8 @@ void idpf_init_task(struct work_struct *work)
>  	return;
> =20
>  unwind_vports:
> +	idpf_ptp_release(adapter);
> +

[Severity: High]
Does this create a race condition that can result in a double free of
adapter->ptp?

If idpf_remove() or a hard reset is triggered, it invokes idpf_vc_core_dein=
it().

idpf_vc_core_deinit() calls idpf_ptp_release() before it calls
idpf_deinit_task(), which is what cancels this init_task:

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_vc_core_deinit() {
    ...
    idpf_ptp_release(adapter);
    idpf_deinit_task(adapter);
    ...
}

Concurrently, if this asynchronous idpf_init_task() fails during
initialization, its error path (unwind_vports) also calls idpf_ptp_release()
without locking or serialization against concurrent teardown.

idpf_ptp_release() performs an unlocked check-and-free:

drivers/net/ethernet/intel/idpf/idpf_ptp.c:idpf_ptp_release() {
    struct idpf_ptp *ptp =3D adapter->ptp;

    if (!ptp)
        return;
    ...
    kfree(ptp);
    adapter->ptp =3D NULL;
}

If both threads execute this concurrently, could both read the non-NULL poi=
nter,
leading to concurrent executions of ptp_clock_unregister() and a double free
via kfree(ptp)?

>  	if (default_vport) {
>  		for (index =3D 0; index < adapter->max_vports; index++) {
>  			if (adapter->vports[index])
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009212537.3996=
-1-emil.s.tantilov@intel.com?part=3D2
