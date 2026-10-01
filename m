Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F6CCA5FD6
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 Oct 2026 15:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 240CC60BF1;
	Thu,  1 Oct 2026 15:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5_Rng0jLnJ3; Thu,  1 Oct 2026 15:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 562F160C0B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790869552;
	b=SIf8wvkWGFWB36kmOWbHoe5FFJedRmxZcYROzykxkbU1Y9YyiV6WTmM2840jDhV4Whpp
	 y530aVZjVRIacOuXcZloxvC1mVHWHs4A2/FzY3Afz486kGo+8RiNJYOh1jm73X3q/AWgB
	 KP4Y230TfH+RlBYMQoxXIeFaNYCcUAy7/thxTp2Y35ttGM9rmxF9XXqqs7OV6b/dPQ3EH
	 UiWl864My+6yg47EB0j2qrjsUVFed7kAwfeq2oI+UZH1+SgzOxOJavTP6mWAQbwzVh/fx
	 +59Cr/agMWwjSxd348qFg/yujpSnRCTxQfIASlfTcLGdtAlJe79WvyD8FW+4fsWgWtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790869552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=Ls6TrqMVBhb5UcIXAOv6ozIgrt6Fu0MSudf/a1XGNcE=;
	b=FGnutbFwRz3980Y3wv0hvbADaKSeUUSOHi7VC4atUikEJuK2ZfQhp3pTmVugyRv/+B5w
	 D0sxARW6CwaPxmBYF9D6ynI8ioT+0ywj2cRnmKlwxilLO3k9uaUwK9KxV9McLS8ylm0z/
	 sx3lhNg0XoEnnQgZn32gwTerlM+KImGrVgD442V3heAKjrwwUQR4o03JSWtXEWleXCOMq
	 4y2UwMESF3VpkExmP2xwFdENbI7Gzm3HfGoB0725mf6hV4v9HlZMMsjQxmWECxqD9OdSm
	 vGq2rX6Dj6OqfuErfO8jLY7e+4tNaCrr0rwnmYEsKWBaeRMbMe3xQDVTbXfADNrIR9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790869552;
	bh=Ls6TrqMVBhb5UcIXAOv6ozIgrt6Fu0MSudf/a1XGNcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QWIcg9VJRPcZFkFMLxyER9Kqg+UFSt+uHHg19oLiushZ7KY8t2ejywgfd9qz2dFt1
	 DRS4jHfaf/MAtwDD/97R+Uoo/GKRwf9IgTtwvWrGLd0A//P3i7MA3wEdFU2dKlb29E
	 oGgK4l1Q2ATJKJRYTc4G/91KwfdCAtqrv3s1L6Hs+7Fnz4ESLuHZWjcu3aM7n4jWZ+
	 997zMOrNZKBh0zhl4XaldUdtIg7EfMBPMkfwZG333I/G8ym+VLNNccvYWc9JCuls/N
	 FkZMhL12BhLks2C7QZ4QpQWDhdFbOsFHSPI59y5aYYqryPyrkVofdCpCW/ItWL/c5+
	 LzU/Q8FVSjLHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 562F160C0B;
	Thu,  1 Oct 2026 15:45:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8B8E282
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 14:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5DF7811AE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 14:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id il9ytZOhsicw for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 Oct 2026 14:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F65C81167
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790866160;
 b=kqvNhpU4YJlZC73Z4wCPZCAZ6yp4TdqRt9PvZReooEvizQVt1Q70/sX3VAWrKNfL6UrQ
 ENCHnEp3zdit4B6a6n/DEhec4zd4GQmBTiqZh0yIa2ISi65rHSB4pPgws1tYSVSslq11h
 +XYGZVDLSsBPXL9ITpFTvojCh2+N8ojtK9fe0zflqXjHIfs6VMKS/GJpfWg16OXUjK8/U
 ERYlmCA9p7JsNc3jxffj9lgpd0EBGoMyKocGOj3zgCCYXGlNyEAWe7am0TLYs+oZx1n+n
 FPcMhc/WmRI6g8OtG3UK/7OD7w13XTW7GD9QSJubHzPG7DaQb64ZVC1ky6ebm4GFBWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790866160;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=Ls6TrqMVBhb5UcIXAOv6ozIgrt6Fu0MSudf/a1XGNcE=;
 b=MlJAjeiCk4WVxlphAQm2Uzyed4NEgYx2c09RsShcEnMLHbdMSvWkDfTC2bI0bFCqyeoB
 u2la8eYyOSys4UPyI0x/P8a+fetucPwEzxV7Zg2+1zAwC9ZM4OK13ylkO5vYOXSx/AO1g
 tLWaeY/VkvT+t6RLA4L6ukARHFS8MaJaf0lWhqihAFuTxUEh0Y4x3Dq9UeUSCzrLCChzP
 o7+X8ZpG3sPRi8ggSrfrm2jWCaiJlzdbUiQSUJWsrBa1yMVznyr+21OeTA87/XR/Ovlyj
 EkHVqIMq6D+J0WPP34QvQF+ItahgN2Sh5I117SLsXzdckjJfCX/9bVxhMqiQM1jvn/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bRkSQb0U; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bRkSQb0U
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F65C81167
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 Oct 2026 14:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C59A36022E;
 Thu,  1 Oct 2026 14:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531AD1F000FF;
 Thu,  1 Oct 2026 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790866158;
 bh=Ls6TrqMVBhb5UcIXAOv6ozIgrt6Fu0MSudf/a1XGNcE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bRkSQb0Uk7E/lI2KjN3Ad0W3vh2RtjcwoHLDr7jMR3IGLKlWQMmTB4kUX2tcbWbu1
 BuUW2exqIzewGBtcfhTpxgpcU4lG9kV+0XAigVjLiVb/EvYMTsMmXLjEDEvaS53R4c
 2rYDNu1i3qoHw404lVPzvwZ1Xu4qsLb/5HYjNwKsVfiZJH6UEeSTn7fTLUyfNbfMaj
 WvTPP8DIGu0uNgRGh2N3gUofJ1SAuhxBA8kyqmOCDVZmdUbSbZgSCzGy6xkuPlXWf6
 C799M8Mu+QIBJlrJrn87tJu2Ag4bnriC8rbT1TtYJzr4alDIB2raGQiwe4uQHx1nO8
 bKKFs+NihOMEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] ice: Skip PTP timestamp processing during release
To: "Sergey Temerkhanov" <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261001115232.13681-1-sergey.temerkhanov@intel.com>
References: <20261001115232.13681-1-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:49:17 +0000
Message-Id: <20261001144918.531AD1F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Thu, 01 Oct 2026 15:45:49 +0000
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
- [High] ice: early return in ice_ptp_process_ts causes infinite interrupt =
loop
--

commit bedb82d9a31e734c0c507d3503f8d563a9326bcf
Author: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

ice: Skip PTP timestamp processing during release

This commit skips PTP timestamp processing when the hardware is not in
the ICE_PTP_READY state. The intent is to avoid executing the timestamp
callbacks on unready hardware and hitting uninitialized structures.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index b2de76065f46d..095dfe23140d5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2815,6 +2815,9 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct=
 sk_buff *skb)
> =20
>  void ice_ptp_process_ts(struct ice_pf *pf)
>  {
> +	if (pf->ptp.state !=3D ICE_PTP_READY)
> +		return;
> +

[Severity: High]
Could this early return cause an infinite interrupt loop or kthread storm?

If the PTP state changes to ICE_PTP_UNINIT (during driver unload) or
ICE_PTP_RESETTING (during reset) while there are pending timestamps, it
appears this early return bypasses ice_ptp_process_tx_tstamp(). This leaves
the tx->in_use bits permanently set since the garbage collection of pending
timestamps is skipped.

If tx->in_use is not cleared, ice_ptp_tx_tstamps_pending() will continue to
evaluate to true.

On E830 devices, this can cause an infinite loop in hard IRQ context:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_ts_irq() {
    ...
		if (ice_ptp_tx_tstamps_pending(pf, true)) {
			/* Process outstanding Tx timestamps. If there
			 * is more work, re-arm the interrupt to trigger again.
			 */
			wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
			ice_flush(hw);
		}
    ...
}

On non-E830 devices, it can continuously re-arm the OICR interrupt from the
worker thread, causing a kthread storm:

drivers/net/ethernet/intel/ice/ice_main.c:ice_misc_intr_thread_fn() {
    ...
	if (ice_ptp_tx_tstamps_pending(pf, true)) {
		/* If any new Tx timestamps happened while in interrupt,
		 * re-arm the interrupt to trigger it again.
		 */
		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
		ice_flush(hw);
	}
    ...
}

Does there need to be a way to clear tx->in_use and free the associated
SKBs when bypassing the timestamp processing here?

>  	switch (pf->ptp.tx_interrupt_mode) {
>  	case ICE_PTP_TX_INTERRUPT_NONE:
>  		/* This device has the clock owner handle timestamps for it */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001115232.1368=
1-1-sergey.temerkhanov@intel.com?part=3D1
