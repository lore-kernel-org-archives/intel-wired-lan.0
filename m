Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB9ECC6B1D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 01:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87028608F0;
	Wed, 14 Oct 2026 01:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEduxIkZEjyc; Wed, 14 Oct 2026 01:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B965608EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791940208;
	b=pLeNCv1lV1HW3HM1UwT+aI0lzbmK8YeKTCZ9n4EfvveRixn3d4VE8192PJo8B3c6Ifru
	 XE2czdn9VIYQgemMCD6Z86150fIcldAwPuUKjDD5zM13kxEHV+1Any4ZR7LIQQLB2lKHR
	 b9A7pYOeKxpteASfJ72QoebBkb6/LY2MYEt+jO+Ir4MsMkkb8KZDqekwRR0DUFovxcA0j
	 aG6QF7gkG9YyS77HCn+Br668R9CPkIkVl0EgLGBuPIe5tOXteyl6l8S8wKA1IkfcIfbQg
	 A1imhw+93yT6nW+MrgUY0KCSOgb1iFRebmziYRMXEtSkLwBKZ+9/KiVW9vzRF8QSr5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791940208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=gFMFRY5rXyo7J/k0Q3YsujSZ2nRKW8H7P24CnMBQMSs=;
	b=TFELviAwiUqVJvjPjMlieEQXiy0K3zIPUcp6L7Vh29UUM2TICQ2pFk0NVTTFX6GAgNnp
	 sOVwx3bOAhIoiC8Pv2wGVfUT9y3WuIaMfGE+9/SjMl881kMI32vIU5AM+8M/LhVkN1Isp
	 6HN6KnsGD5R1yVDWmWXtN8Bf0RB7v1zZ35auRM2BCav6iAP8F4pt6QCbqFIpqeleW8TQ1
	 vAtTTDTCfe2k/DJJ7ioBU6bQIjfmCOMc3eAAFyo0mSYLpLJubf2iOLO8xEbT8nBpgEGie
	 qg8crODsgXaCWioTvXMNfAomXhz6mZH2KWOtuvdx++yxk7VNuqPwSieJ1BXJmlgVG0g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791940208;
	bh=gFMFRY5rXyo7J/k0Q3YsujSZ2nRKW8H7P24CnMBQMSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=T+z335kNZJjqONwUz0z8OqB8Ste8CT6NU6fMV53OvzNnkaFHfKomopvE8SKyj0QiW
	 UKLx1bBCJuPW9pdOmKoWBQzUq65GPW6vqatmvYnhzu2M+q1TWAhwVynZ4R3j3DdQac
	 4hDBl1xKEqZ5CZuiwRJLifihTD2WaX0GT7HHmQSN7oeoMBu3+Zl69IcrLmYv64WwvT
	 UkNlq4bYau3V5752BrLeuZ/CouLQ+5AtZQL47ahRiINidfSpMJ/QNILeMBwAYECoUV
	 AFVtSl3PZFpim8BEgC8HEhDEHh5Ei7C0PkdiiZnj8XfZ9n6FnElLwWiHfx2mwOyIO1
	 bweuExdQsTbIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B965608EC;
	Wed, 14 Oct 2026 01:10:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF9B175
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5D5780A80
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTaAMBMeE2fW for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 01:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B14FA809BD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791940205;
 b=s2+yXH1JAo2VzSVZDCXysuSXpylzj0rMf8gL7V72lhsrp9aVUJWb0o+tH9b6OZb3S0QN
 rFvI2NlaVrx2y9j12h3CPUHIQugSy1QxRaw+Ds+AWkFz3JhJyW4U/f6W0Ltk9AxtK48un
 7vqXyxTSW9cBMRya1XtokwemyVwXUFcHSWcLJVR6Thx1u2uayq42huIAwt4ckSCpwTEhP
 A5LpsFKe3ZMxkWAwtA6DqlOhIJH+MrX3KTrPVZRy+m6nqEgTHSc2KPXML5PdU3CslFoNE
 6whhBo7+Bw7EYm/nd2Dp9EbPllzBI7+VkZJtzT2hOm8WyGQ8ZLxsTvFe5pSCxwatrHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791940205;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=gFMFRY5rXyo7J/k0Q3YsujSZ2nRKW8H7P24CnMBQMSs=;
 b=ViMPK72MT03BMGVgq0GhN2ibE3oNb5ngS8b6lq8PqME5em0j07Bm0v1bQYOz74kw/xJ+
 NR5Ky/MXGhfz5t9cOUfkKHl5wIEF9xXqJR1NegddBSiMraH6wu9J4xBdPcQbRxmooELuh
 ODQl04O5uEvFi/z9P/WLKEhzQdC/FcVLDZiG9tDMeLgopqtpUTy22CrD4b/7a5/wrTfz+
 KEfLyitbgRJ/IsqEm8ixGfmOe0q4amc5nHz7wrttaUQBBZ+fP158850sn9LVHK6RS0TUy
 yUA8cFRyiPN7bwBqkVCgiYdAtrjp3svZLH2ueW1lcDRH/3Hz9K8jiE3zXzgEO1dd58g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P68vrILW; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P68vrILW
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B14FA809BD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:10:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEDE7409F9;
 Wed, 14 Oct 2026 01:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EEC1F000FF;
 Wed, 14 Oct 2026 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791940203;
 bh=gFMFRY5rXyo7J/k0Q3YsujSZ2nRKW8H7P24CnMBQMSs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P68vrILWmf03ngDcra+22nifcwIYRzKA71Q2wPk5WiZIIf2ROxtwqDS9HrnWOX74S
 lzFk1s90GL6YMXt4hexs9RstZJbN5UKVly3BYTosMy+XGlOIn/Dy19Lt4ITxw5LkwQ
 9B2NfhMc2lGXQnbUNQVefZeb+AT2beqP+qt1x0Cn+VpwLvrkqyV3F4/ZDxRdt8BOPe
 aAvb9CjIyByHl8rphPUjZ0fi5LbNmwsc4aImbGpZa8cLL1lNfHsZ+Zl9oP83vBoqjx
 4HeZ787KvaRRlsqSx4tZfyp1OJK40t/4Ge+yHjrnPcVkTHEHq6cKA2yRO0cxps5VvF
 clN3k/trCSffA==
Message-ID: <sashiko-outbox-170659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
To: "Paul Moses" <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261013010854.4068874-1-p@1g4.org>
References: <20261013010854.4068874-1-p@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 01:10:02 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] igc: Frame Preemption express packets (mPackets) lose TSIP strippi=
ng when interleaved
- [High] igc: incomplete TSIP underflow fix due to XDP fragment drop
--

commit 61d038c91b93b927335a69df60dbf6cc817c79e2
Author: Paul Moses <p@1g4.org>
igc: only strip RX timestamp header from first buffer

This patch modifies the RX path to only subtract the 16-byte TSIP inline
timestamp from the first buffer of an skb-assembled packet. This is intended
to prevent an unsigned length underflow on continuation buffers shorter than
16 bytes.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..41b293dc10c3a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_=
vector, const int budget)
> =20
>  		pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
> =20
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
>  			ctx.rx_ts =3D pktbuf;
>  			pkt_offset =3D IGC_TS_HDR_LEN;
>  			size -=3D IGC_TS_HDR_LEN;
>  		}

[Severity: High]
Does this condition corrupt interleaved express packets?

Frame Preemption allows express packets (mPackets) to be interleaved in the=
=20
RX ring while a preemptable packet is being assembled. When an mPacket=20
arrives during this assembly, skb will be non-NULL.

Because of the new !skb check, the mPacket's TSIP header won't be stripped,
leaving pkt_offset at 0 and size unmodified.

Shortly after this check in igc_clean_rx_irq(), the mPacket is handled:

    if (igc_fpe_is_pmac_enabled(adapter) &&
        igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offset)=
) {
            /* Advance the ring next-to-clean */
            igc_is_non_eop(rx_ring, rx_desc);
            ...

Will this pass the unadjusted size and unstripped TSIP header (pktbuf + 0)
into igc_fpe_handle_mpacket(), treating the 16-byte hardware timestamp as
packet payload?

[Severity: High]
Does this fix fully prevent the continuation fragment underflow?

The patch attempts to fix a queue stall caused by an integer underflow on
continuation fragments, but relies on skb being non-NULL to detect them.

If XDP is enabled and the administrator has enabled the rx-all feature
(disabling MTU enforcement), an oversized packet can be split across multip=
le
descriptors. If the XDP program drops the first descriptor (e.g., returning
XDP_DROP), skb remains NULL.

When the loop hits igc_is_non_eop() and continues to the next descriptor,
skb will still be NULL. If that continuation fragment is shorter than
16 bytes and has the TSIP status bit set, won't this check evaluate to true
and cause size to underflow exactly as it did before the patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013010854.4068=
874-1-p@1g4.org?part=3D1
