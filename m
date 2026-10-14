Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1340FCC6B19
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 01:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCEA280CC5;
	Wed, 14 Oct 2026 01:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNzJ9M6eChgS; Wed, 14 Oct 2026 01:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95A0E80CEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791943164;
	b=Vv4WU6qR6EkMmH5A7NPyxejdXsjxozX9xqyMsl/RZMXH3Dq51twwCZnLx8AcG33Iin/O
	 Jlg4yZ/Cc+fMOtxqI3ayEwYDGnsSgVQoYzcI1oGyIajq7z/vAXOrTxTv9dlS3vend7CvC
	 2c7gsE82gC6RisttZSG9QGHWRVP9brHcy1xM1Oo4+GrD8h1uVFSFcpQcXAGtdcFGzadhb
	 mvD5PUJrlEXOGtl4pfyszG/f+jyPYRDpzm9u+ZtFsGXK5KD7dIvvFIfIlE6WzzKQh/d3e
	 XnbOCMrbiXRVkOif589Ft6Q010khT613j5rpMTPTjunF7ubSQVroTNhgAWbhGPPc9BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791943164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kawrkzhFyj9yV3XlykGBmt/LBNk1s9fbUDf5Qjez1pY=;
	b=C+lU8MiPQsHs/UUIsZvRg/TiHKAOZ7efIUSZwcDZDsemeevP80UWmb3AWJTag4GAMxcG
	 Si/R7tqvsVJEo1HL0N66IlQArmqgTSYrMoBiHSeGFr9Qvvyi6YFfC4XSe0dW8k1NNaWM6
	 oVozG6vc1nga5I4llAxb3FccQg+t2Jv1jmWOD13NuazhHYcH+yibZfW/zIVEAzFh+59ot
	 z4OdsGCDeTW+N55O89eJ2o9ZTYnQWrwcEae0eEMqaslNzrPZ3CWDuLqp4AQeD0s8hQ5wf
	 0i507MFZ0Lw1tu7T+pkYaIQ2+BH4QQDsZbEnmd+Xny7abbgS3s9rGeN9wpvd9F8J7lw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6UcFYmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791943164;
	bh=kawrkzhFyj9yV3XlykGBmt/LBNk1s9fbUDf5Qjez1pY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S03AOzpVnvYvtMc6nO/6+KEuVUT40gMQn9p3dqghyxEzgAAiX0K1s5tjhjdMVITcD
	 mugM/f0352C33zIKpC4LtBCOrTagWqnrSXzLa69UnWgxwQOclLyepKlNbDD90gztTJ
	 8y25oHv7lIPPoMEadX5lOoPstj8MGGx+vogg+1Rg4m/IqsORxmJQ4TsNEsWCFF3Af7
	 uD0Pmm41gAuTuYhem6OQ3uLrZMyFwEN5AHvBeihve4uBYwr8fa++12LdqzdIg4+zRd
	 V4Q/EZoMFsw+crPpQjRN3Inf6pnsobfs00BnOH5iMbNsqYuj1AAIndj8OZzGz5AAzP
	 y/MUv/ZxTcCoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95A0E80CEC;
	Wed, 14 Oct 2026 01:59:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC7DB255
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE30F80CC5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lSKIorlMhbpz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 01:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1ADC80CC2
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791943161;
 b=ltBuo/Yuv31Rb01s125drqu1If0tXAQRMbaExQWLZGFTIkCg0gATBQzWlthzq0XYk9M8
 q0vUv1OqL7Um29Y2bOW9WgAIC8HXbkJgUn2cXlXHjaGryhHzCd7KFc8cJLGRr6NlxJHz2
 9GyJbG2RkkLD+2wf8QCcGg32gQVJRSphxbuMZvG71cOqqYtRnsJm8IADZIaxsi11+CRyc
 BOFLgtnt6LZPasBoNRGq46hVOqT1hw/wkzDaA05GWpksEoLLg6rd4eDAI0zL+Mu9yxnNj
 /9Sz72WNA6XHI4EdsRw+liihTB3nblLd/mqK/ikJZGT0aoborURPBEP7MOFAfX9PmiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791943161;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=kawrkzhFyj9yV3XlykGBmt/LBNk1s9fbUDf5Qjez1pY=;
 b=LF29wQWqMF2HrBqJclXlmgxudJ/OZE2sjQQ0EeEV03ymqF1pK8QuOxbSk8ptBsDBSQMY
 CeOiF3429oSzcQSH8COh1+M06MgvtlvSBIDO6H4oSIf2Uvm5WhPF6+DruZo0QdbOaRbCM
 diKPOCyTi3sjB+YD1Rt/Wx54m1IrCVwvnKMyRdP+c+x+8qX0g21cRpT7frLqizsuE6boK
 7evxmAsY2IGZGbOu82IAJuLcEEYt8GrBQpoWcpWrG5dS30FPdyM8F0jVRhClhT6uYDGD4
 x3ofDCYN0FFr9LURJWAUOK0Io58NvJ4BMPFVqBWdDZPDhW4ua0mj/YE4d07h0dAObvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y6UcFYmd; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y6UcFYmd
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1ADC80CC2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 01:59:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D66240D86;
 Wed, 14 Oct 2026 01:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722F21F000FF;
 Wed, 14 Oct 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791943160;
 bh=kawrkzhFyj9yV3XlykGBmt/LBNk1s9fbUDf5Qjez1pY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Y6UcFYmdpqYwYSSRtNG+xfeScFwh/UDGZROvC8G28l/WPGdqjFiwXsxfDSg/arcoI
 hcUEYYKZydK8C6oTiPZXkto919qEYKD0r0ZJFFjc+zOXWUZm62qilB7NpzR6MyQ/sc
 TZ6njX0HhJDmZK3g2VkRxSAEzmSfWgOoXAP08hfCbw/jssJA6Q5PVyBBtG4jyl7fNo
 MXnAGGtWGmw/tcxVcxKhophhooiXfzqoEv95/cds52r90k7Py/fBl7sXIsHSacLW0Z
 3bxCBGqvW5ua3UuLXERYgbRT84FOTmetQed133DiXCz42ufgOM87FrdB7W+tlxBkqj
 J3zqljMP8C6XQ==
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 maciej.fijalkowski@intel.com, avigailx.dahan@intel.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 01:59:18 +0000
Message-ID: <179194315897.434549.3743742848544230715@kernel.org>
In-Reply-To: <20261013010854.4068874-1-p@1g4.org>
References: <20261013010854.4068874-1-p@1g4.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the TSIP length underflow only in
  igc_clean_rx_irq().
- [High] In igc_clean_rx_irq(), the new condition `if (!skb &&
  igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP))` uses `!skb` to mean…

--

igc: only strip RX timestamp header from first buffer

This patch changes igc_clean_rx_irq() so the 16-byte inline RX timestamp
header is only stripped when no skb is in progress. Before, a continuation
buffer shorter than 16 bytes could underflow the unsigned length and
produce a skb fragment of almost 4 GiB.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..41b293dc10c3a 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (!skb &&
> +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {

[Severity: High]
Is !skb a reliable first-buffer test when an XDP program is attached?

Suppose the XDP program returns a non-PASS verdict (CONSUMED, TX or
REDIRECT) for the first, non-EOP buffer of a multi-descriptor frame. No skb
gets built, and the loop moves on with skb still NULL:

		/* fetch next buffer in frame if non-eop */
		if (igc_is_non_eop(rx_ring, rx_desc))
			continue;

On the next continuation descriptor, !skb is still true, so the TSIP branch
subtracts IGC_TS_HDR_LEN again. If that continuation holds fewer than 16
bytes, size wraps.

The wrapped size then goes to xdp_prepare_buff(), and the continuation is
run through XDP as a new frame with data_end before data. On XDP_PASS, both
igc_build_skb() and igc_construct_skb() compute:

	unsigned int size = xdp->data_end - xdp->data;

That comes out to about 4 GiB:

- igc_build_skb() passes it to __skb_put(). On PAGE_SIZE >= 8192,
  igc_get_rx_frame_truesize() also wraps to a tiny truesize, so
  napi_build_skb() would place skb_shared_info inside the packet data.
- igc_construct_skb() turns it into a fragment of almost 4 GiB. That looks
  like the same corrupted skb the commit message describes.

Can this be reached from the wire? On PAGE_SIZE >= 8192, igc_set_rx_mode()
never clamps RLPML:

#if (PAGE_SIZE < 8192)
	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
		rlpml = IGC_MAX_FRAME_BUILD_SKB;
#endif
	wr32(IGC_RLPML, rlpml);

So the hardware still accepts jumbo frames even though XDP limits the MTU to
1500, and with XDP the ring uses 3072-byte buffers. A remote frame that
leaves 1 to 15 bytes in the second descriptor would hit this.

Would it be safer to track start-of-frame explicitly, or to drop the rest of
the frame's descriptors after a non-PASS verdict? Another option is to
reject size < IGC_TS_HDR_LEN before the subtraction.

>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;

[Severity: High]
The same unchecked subtraction is still present in the AF_XDP zero-copy
path. igc_clean_rx_irq_zc() strips the header from every descriptor with
TSIP set. There is no first-buffer gate and no size check:

		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
			ctx->rx_ts = bi->xdp->data;

			bi->xdp->data += IGC_TS_HDR_LEN;
			...
			size -= IGC_TS_HDR_LEN;
		} else {
			ctx->rx_ts = NULL;
		}

		bi->xdp->data_end = bi->xdp->data + size;

Can zero-copy frames span descriptors at MTU 1500?
igc_configure_rx_ring() programs the XSK frame size through
IGC_SRRCTL_BSIZEPKT(), which is (x) / 1024. With 2048-byte chunks the frame
size is 1792, so the hardware buffer becomes 1 KB.

igc_xdp_enable_pool() only checks:

	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {

That accepts 1792 without allowing for the 1 KB rounding or the 16-byte
inline timestamp, even though the comment there says frames should not
span multiple buffers.

On 4K pages RLPML is IGC_MAX_FRAME_BUILD_SKB. A received frame of about
1009 to 1023 bytes, plus the timestamp header, would leave 1 to 15 bytes in
a second descriptor.

The reproduction in the commit message suggests TSIP is set on such
continuation descriptors. If so, size wraps here and data_end ends up about
4 GiB past the XSK chunk.

Wouldn't that let the XDP program's packet bounds checks pass for offsets
past the chunk? On XDP_REDIRECT, it would also report a bogus length to the
XSK socket.

Should igc_clean_rx_irq_zc() get a similar fix? Should
igc_xdp_enable_pool() also account for the 1 KB SRRCTL granularity and the
inline timestamp?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013010854.4068874-1-p%401g4.org
