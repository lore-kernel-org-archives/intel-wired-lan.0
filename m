Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C4606A323
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ELlhyXLh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVyyZK4I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 804E04072F;
	Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pnChpmHAvY-s; Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E14B40AA1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336046;
	b=Rwz2vM58iOwpTPCzuaWiUb3VZO8+E9WaQUVMHjfscTsWUThJbu4RFCI6P0IBXSLRGGdv
	 o9DfHj1ipmIVz/EkqFGr7RyGHqiTQjqL0e7HhwL8XCGjaN5MvI4En3c2WmJlTT5FqYS8/
	 PdU+2rLtUF1b02GN8RFh0R30TUNFmU1Z+tkVs31PYi0BL23zkrwfs5g0zIAJ11EOMvkVN
	 FILIspIg6kXGxDT29p4DSwkgktB8NdJN1wRbqyi4ei4pXFsVe9IlgxhwxipqJLGc6Rnl/
	 W1EDAwejfmnWXE1D/qHgiRPlwSAbm4YRznvOEA0OiQI8aZx3Y2qtUfdeO0EBRqQJmKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=UgrbNhZggdVFRei7KhGNOpgN4GBvhsZ3ydNx2ziXKzA=;
	b=Ol17j0j/WMqZsVH5f4wQKfzhplCP8QIVtjndtFzRhBJv7qwLTI7ltaXHYn44cUKM4WsB
	 V2t3mbp1UgGjH9jkhM6BAGF6pY/txPUhYCYmdjAafimgt84WicJaFSlefXqX7wakFo1aG
	 pChFSBCPhqtsdiFnL7lRJSwSqZFOGpWjhb1nfkQg7FxiiMeXVVDVvmCnGH3kfYZzSEcAs
	 rLOAPndfsNuDv6+XhWyjpGMehwfSM30MuztHwDa0iGtUyrzYxhi/S0YicyRrG2WzfOo6t
	 nb9QDOx0HwD8H53J1MIbhwlx7qsslh316c1Ha2qc4NrIE7PhLJGcuONhscwmbWFihVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVyyZK4I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336046;
	bh=UgrbNhZggdVFRei7KhGNOpgN4GBvhsZ3ydNx2ziXKzA=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ELlhyXLhV4La4SM1NjHUWhO7QAi89YhWnDl5HdOpI8Z5AH5/RZGQKt03A/f4qUwtM
	 s9T/iW7xAb5WT/jKZU2GcQQ7Ew2/3eqT60hbhy2pe1gDNfbl1WT1nZpM002F0B3lXK
	 LqatvGz+jYGV1W2yG/gk7KnjtxswYpiHrkhxrhelFswLflWbdgIytN8LaXjrCoPjMe
	 dqLSW973C6Pl4bw/CaF40bis9VMvZVbpy/8KiU+eH6JHy3bX8mhN54RtDon4M+meHj
	 SZWxamrI0NbNRR8Yj8RcK0mtyCjhCV8T109tY4TSdYylEgc/yTDNVX4P9i2VegEOhT
	 ZR30T1VN1dorw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E14B40AA1;
	Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7ACAD38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A92B74072F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEzJ2UrSDDoA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACBCE406EE
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336042;
 b=qbC4d5f5fOLh3EhsSIxmOm4APG/8yEk0ukNoIsJSBX6I6B4H8XmUoaFRwpBmYirDo2Tf
 S3kgwBYl0znqRT+d+uNFHgsvbslHrNvoY6PUG6jUjJqjZ6Cyi3hZT3ykmv7pJ5MO75C84
 tIlTp82/5JoAXoNh4ywZPlYtH7upWwIdFGDUacpyL1XZCqg79LCzHWaOx50u0s/62Tk19
 c+ByGfrtuBqpkmZYJLp3+ww1bX/JrqZPwuhCkHcGpVXYKasMT4774dV6V1CgBLCX0uu6f
 H290p5otocGxkybgp7OZIMdR2ImeGNZSsbWpYO8Ou17gl/AoJUxBKSvLsAlx1c96+jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336042;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=UgrbNhZggdVFRei7KhGNOpgN4GBvhsZ3ydNx2ziXKzA=;
 b=tFqZSjSB8+73ydZJeynOTU5YKULi7pXTeP47JjkRPURewPmrfgc3WN0kT5pbUiKMkmAd
 6AQx9mxIse0qPT3uQPzgGXH2RQLUimNScKIZYPhsHdfLEgaOjRpEV6nklYNAzkOdixOPY
 4C1CHUra/pbaHl/77yybPHqUtoGpi4ChzF/SxNM+ztqkY37bzu/ZaA4gH96+fw/Bjm84a
 dpxQjHiHKtmsPHSrevZ5mYmpDXOCgt6Y87nigGfqW8zxqSrxH7JoiEvbGxplRfk6ycAux
 j+O2UeQM7gP/yH+ks3OcKW8uqc+vzb6219J0s7zLxawjOtbzYYbzzSUv4/iJrwp9gKA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nVyyZK4I; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=nVyyZK4I
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACBCE406EE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24412406F6;
 Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3901F0093A;
 Fri, 30 Oct 2026 04:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336042;
 bh=UgrbNhZggdVFRei7KhGNOpgN4GBvhsZ3ydNx2ziXKzA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=nVyyZK4IEQUUT4aIz+692XqIj8aeWMsU+jRxSN+9/ULcVWNu5bPFF7pv7vYRbOzMd
 LtVe6QWey9x4vQ7NZNOSoQvB94SAcvIx8oD1STTM8/gcbzTdaykz2h52sTsB37qZIm
 7Hlsi1WAS5w4U8ELYoSOBZVhtOT3H2jUfNbCS2uEshDfAQFq8En6eb02vDwnNXNs7b
 6qxcHrBkRb5/rUBPsngTroZkWWwOFPBUWvrqQ3hJq2AdXHtp3aUMFZtMZKCuldXh7V
 1OYvKagp7PtPRlzCbDAN4NUlHCbe+r5dwnmcuip5yeYzidOTPKdwEnRa24M0xJAv8S
 icVV0x+BDHIfg==
Message-ID: <sashiko-outbox-190395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 8/8] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS
 constant
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20260508031226.3601800-9-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-9-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The min() comparison evaluates unmasked ITR values containing the =
latency flag, incorrectly causing the driver to choose larger bulk delays o=
ver smaller latency delays.
--

commit e683a9d65e2e630a93fdde9696800531a58f1ed8
Author: Alexander Duyck <alexander.h.duyck@intel.com>

ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

This commit introduces the IXGBE_ITR_ADAPTIVE_MASK_USECS constant for the
ixgbe driver. It replaces an open-coded bitwise complement expression in
ixgbe_set_itr() with an equivalent but more readable bitwise AND using the
new mask.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/=
ethernet/intel/ixgbe/ixgbe_main.c
> index 395f556c76e04..f27702962eaac 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2959,7 +2959,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_=
vector)
>  	new_itr =3D min(q_vector->rx.itr, q_vector->tx.itr);

Does this code inadvertently compare unmasked ITR values that still contain
the latency flag?

The q_vector->rx.itr and q_vector->tx.itr variables contain both the comput=
ed
delay (bits 0-6) and the IXGBE_ITR_ADAPTIVE_LATENCY flag (bit 7, 0x80). When
comparing them via min(), the latency flag makes the latency-optimized delay
numerically larger. For example, a latency delay of 10 is 10 | 0x80 =3D 138,
while a bulk delay of 100 is just 100.

Consequently, min() erroneously chooses the larger bulk delay over the smal=
ler
latency delay. This seems to violate the explicit comment to 'use the
smallest value of new ITR delay calculations' and may penalize
latency-sensitive traffic on mixed workloads.

Could the new IXGBE_ITR_ADAPTIVE_MASK_USECS mask be applied before the min()
comparison to ensure it compares the actual usecs values?

> =20
>  	/* Clear latency flag if set, shift into correct position */
> -	new_itr &=3D ~IXGBE_ITR_ADAPTIVE_LATENCY;
> +	new_itr &=3D IXGBE_ITR_ADAPTIVE_MASK_USECS;
>  	new_itr <<=3D 2;
> =20
>  	if (new_itr !=3D q_vector->itr) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031226.3601=
800-1-aleksandr.loktionov@intel.com?part=3D8
