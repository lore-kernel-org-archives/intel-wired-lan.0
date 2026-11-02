Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338D607B46E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5aUkwz3k;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMWp2TMY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F004607EC;
	Mon,  2 Nov 2026 15:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_X-53UOTR5t; Mon,  2 Nov 2026 15:55:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E08260703
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793634913;
	b=SRj9ROxpWfaE6r/42jIzXZFggDI/zY7uemYPcRxtzXUxyy8Yn5goAbDJltz0qblB0jTI
	 geQH/ZRT9XwzOdTNfgGcn1jbJfCT1nka+J2fJvYERqvJlnsUBnWRgAjDlVoPqwRC7DWV4
	 1xUj++++tw0Lt3hAGIiBmDZggQSKkIuVZzc+C9jX3b0UG+QRVSecHCPe6a6XlU0APaegT
	 aVEmyWC7V6bs57WazdVnLlVMbkeoZ+hbtHsojKvjbX8VA5ILeosdbfRNr1Ss4EbGXKHMU
	 qjdsUetSVEiTfy1KawaHNHOe39q0i17k8jEbheW2y5Lgc+rcOkEQn+RF2cmXQ3shWDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793634913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mKv9KYZCZiJ5TtLuOsshBW8qXofw+6LjB5hk+wiVA7M=;
	b=QY2gq6oWwMUMswBuoqLJ8hKszoGCp5RlACrgcXLRKkYSA4JkSJzDXleld1d5MlO9Qe25
	 eZpCGYfdGXZoW0C7RdHyYK9Wh9vAzQmtDtZq3bewBSup2D7tCqYGF5Ezl4Ae2BwrRbFry
	 jNlzuwywp9Fb6hAEsEGNs/gnmxSPFgJvV9VCd3Q1s9w7yKxf7eVCj+Xrs7PD1YY3ptwa7
	 U6VbdS/gT/oCTFL48/PiX04x2E5Lr8cvtSNkvVG4HwQsiwuSncyJCwdk/Wx5af3Zqt+KF
	 /9RyB4YREsE2pmCRDiMqnDbupaL5SHG8GQC3RDrhQjqOcv1vyHpPyZiN4HwrhtadRqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMWp2TMY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793634913;
	bh=mKv9KYZCZiJ5TtLuOsshBW8qXofw+6LjB5hk+wiVA7M=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=5aUkwz3kCT3t83TU+yJ6pxPN8By+vpUKL07QgieMFfIA5oYMeXyuHeG3Ecb77p7b0
	 mIaqYeA8FTu37bq3Noij+pTJiHbBuqAgNnzrcIn4apWf3aI6xP0f0UJgxnRQCbt5Y5
	 G5ForEq22B5QhNjqH8Dxs6p8hWf0tAy17wSAlf0JWXHKi+sN+UkcWyh2/K1INa51Vx
	 KccgzWJH5OYArJLVrJ4+xQi/tTVE5ZKx2IUABWd4ZWLYDyj9VtG26Gjs9+R3707ePX
	 JcLP8rkd6YCYe4ZCiIMXeYDpq81lC4yX1dWuJnW+z2Dv6g8Q7jy5roYuhAdc+jo0O+
	 eRtkz5+48MpMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E08260703;
	Mon,  2 Nov 2026 15:55:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45D454BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28EE160703
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCqsjXV41HE4 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 15:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7306F6063F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793634910;
 b=ICmp2lDlAfSGP5rdQj5f1vDnIMWEAXHfjm0qyfbhmG+wrnuX9dE5N8JcJRdELGj/RS4H
 pJM36O7IaX/XPByzv1QvhdYSboFQz2G7ylNO9OOwn2hVDJReCX1AYHXDbvAXRp2P+nfOG
 ADXKPlqH0ou5z7yZvkJxPi1E5CCDyqpiF/pA7WT/HfPr6v+pCEN8x9JsfWT2IB+YREOhN
 VbCMLXpg/sclJ8Sf4Qts01g9twR4xVorR3Q0ryf+jdrHhtV6sJKWmzu8ce/pxl/R6ABFS
 IBn8LFstzGVoszSj6yCh+Tr3WBOLCJgbZwH2SAt7Q/hS07jve3Ua3JFBriEZlokYESw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793634910;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=mKv9KYZCZiJ5TtLuOsshBW8qXofw+6LjB5hk+wiVA7M=;
 b=iVuspQfkADRP43TiZ8Qxcv6nnbv+IdwnIDLcCswUWuNFwRvhowCn+2SpljNldTfBs/+9
 +8wAuUo9TQdxjpSKp/S20bnnBr1SAYppMw8d/Px5i+TCYH4nNBuX8Fk1ZMSz+dP7j4m7z
 AAGpP9RKFgarzrLRLcxSx6WAlUUfyL+fmlMMSpSuoGFEYoAiYvQ4n6RfAB9lMszfLMSc2
 s4y3dWcIvMUlUHT5/MlTdbds2OlXV8NdDM7gip3/MaicoojTnT81tsmhhgO7c4nTtjgL0
 5A5YsIvz8/EjCcJMh386J5/d7dFnCtEiOIESOcNewrMmU8CzrcO66lpJAf7GpraRXBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nMWp2TMY; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nMWp2TMY
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7306F6063F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 15:55:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F12260628;
 Mon,  2 Nov 2026 15:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3946E1F00A16;
 Mon,  2 Nov 2026 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793634907;
 bh=mKv9KYZCZiJ5TtLuOsshBW8qXofw+6LjB5hk+wiVA7M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=nMWp2TMYMen3rVbyAjMDAy1GzcyX86TdL7+Q1rSOOl0ax4L1QiyUTOoHbkUTSebI5
 DGY6KOZ/2846Y4Z9IVebuiJF81zozLgp9W6GwTw7uTrf26wHOjdM3n0cs7oDLXgbo/
 SSRaja0mMrG3F73ATamUtEsdQVeya3PZ+P8eXaP/PhaSah2ulYZQ1qIQwmoGwQb8tt
 BO7dw19by7bSw0h0KsmlqlsBff2r6hjL1E9xyA7L6uoLyQzUuZp89Qox5vN51H0fpu
 D0nCf/T041pua9IHMIR5ydPcQFHseYpoSKsVlZoIgm3FbzlY6COxXtMF/5w7qkOCnU
 J84NySz7Kmjfw==
Message-ID: <sashiko-outbox-193711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v1 4/4] ixgbe: document raw ip4 flow match
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261102153512.1601855-5-aleksandr.loktionov@intel.com>
References: <20261102153512.1601855-1-aleksandr.loktionov@intel.com>
 <20261102153512.1601855-5-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:55:06 +0000
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ixgbe: commit message contradicts documented and actual raw ip4 =
filter behavior
- [Low] ixgbe: documentation embeds E610 test note and overstates MAC suppo=
rt
--

commit ef5298950b8a36e3b13694833b34dbd3ea4c7bf6
Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

ixgbe: document raw ip4 flow match

This commit updates the ixgbe documentation regarding raw ip4 Flow Director
matching, l4proto and tos qualifiers, ntuple and hw-tc-offload filter
persistence, and per-port classification mask rules.

>     ixgbe: document raw ip4 flow match
>    =20
>     The raw ip4 flow matches all IPv4 traffic except TCP, UDP and SCTP.
>     Fix the stale docs.
>    =20
>     Assisted-by: LLM
>     Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

[Severity: Medium]
Does the commit message state the opposite of both the ixgbe driver
implementation and the documentation added by this patch?

In drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c,
ixgbe_add_ethtool_fdir_entry() clears IXGBE_ATR_L4TYPE_MASK for raw ip4
filters:

    if (input->filter.formatted.flow_type =3D=3D IXGBE_ATR_FLOW_TYPE_IPV4)
        mask.formatted.flow_type &=3D IXGBE_ATR_L4TYPE_IPV6_MASK;

And in drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c,
ixgbe_fdir_set_input_mask_82599() masks out the L4 protocol in hardware:

    switch (input_mask->formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) {
    case 0x0:
        fdirm |=3D IXGBE_FDIRM_L4P;

As the new note in Documentation/networking/device_drivers/ethernet/intel/i=
xgbe.rst
explains, an ip4 filter in ixgbe matches all IPv4 packets including TCP,
UDP, and SCTP (whereas i40e and ice exclude non-fragmented TCP, UDP, and
SCTP).

In addition, the patch updates the documentation for ntuple and
hw-tc-offload filter retention, l4proto/tos/IPv6 handling, and the shared
per-port classification mask examples. Could the commit message be updated
to accurately describe the ixgbe ip4 matching rule and summarize these
other documentation changes?

> diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixgbe=
.rst b/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
> index 1e5f16993f697..1cb9935fa9788 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/ixgbe.rst
> @@ -329,13 +329,36 @@ The src-ip value that is written to the filter will=
 be 0.4.1.2, not 172.0.0.0
>  as might be expected. Similarly, the dst-ip value written to the filter =
will be
>  0.21.1.1, not 172.0.0.0.
> =20
> +NOTE: An ip4 filter matches every IPv4 packet that matches the remaining
> +fields, regardless of what the packet carries above IP: TCP, UDP, SCTP, =
ICMP,
> +an IPv4 fragment, or IPv4 with a protocol number the hardware does not
> +classify. The driver leaves the L4 packet type as a don't-care, and on e=
very
> +MAC it behaves this way; the only measurement that was done was on an Et=
hernet
> +Controller E610. The i40e and ice drivers are the opposite: there an ip4

[Severity: Low]
Is the remark that the only measurement was done on an Ethernet Controller
E610 a patch-testing note that belongs in the commit message rather than
in user-facing documentation?

Also, is it accurate to say that every MAC supported by ixgbe behaves this
way? In drivers/net/ethernet/intel/ixgbe/ixgbe_main.c, ixgbe_probe() only
enables Flow Director support on 82599EB and newer MACs, excluding 82598:

    if (hw->mac.type >=3D ixgbe_mac_82599EB)
        netdev->hw_features |=3D NETIF_F_NTUPLE |
                       NETIF_F_HW_TC;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102153512.1601=
855-1-aleksandr.loktionov@intel.com?part=3D4
