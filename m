Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1957606A331
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=juiP09hS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF6B640722;
	Tue, 20 Oct 2026 17:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NSQIuT3C85C; Tue, 20 Oct 2026 17:07:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B03FD4081C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792516050;
	b=aFbtEz7SYYy73AT8vdJPEFzR5ZsjGBvycRb+0x3iATw+8kjR2aFB/mt7Jr7GDH7PNjrE
	 ZPfr3a8MrZ2ZXpycNr1jiEd3k+uQ9V5ch9p8yhqhtKFp5eh7+2U2WAcKYeK1kYblgoPs0
	 BcBOcRuwFQCt4WuEDbJtVPMP8NR0pWQRBsmzgPmu3WmFDLFJQX2JBcVS5yrxRTSH1wuVf
	 N++G14HG3WywJOheegaqVHNZweotT4m7+YEhLb76WG/g7ufiYXAYZlca+slJq+VYxqy2b
	 KLb0TzLvz496SSG8xK5tE9n41b6Ah+kjjN5kXo0ATa03sAq7ELiJtaRmJRQJG9ptPuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792516050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9/l68fSQm/RuZObxkeWmD9P0V6B9tkMkoAUEJkdJXq0=;
	b=RkrkEKIeMyADNzFpWWTTdpPeZzMbRoo7vzrVaFkNbND97DcQDIEe6/tZXCCDjDWVzhdf
	 dy40P9Cw+zC4GYzMYOSnWZzd7DND7fDUko1gM/sQ3LBn4z+HQt4HcdGEREXrnKM03r7S4
	 g9AkWDXsAOn3/xO7+peax2CRZB/ZsRJsCzqyYsgQwrbFsVyNZHVpX+8wYG8eiSS5aT7GH
	 pUqhAf3oGR8C3YFz1j8i/+7jEa60opZa2faFQ2oOoyQO+9p1gzVg0miXuK3/B78vwOk4H
	 IDNKfwR5Bz6PICMCtbR3FYBP0IPyPX8V7gm5GKk8nSp9KxUYOW1qmP6MWEF+BQzn0AQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792516050;
	bh=9/l68fSQm/RuZObxkeWmD9P0V6B9tkMkoAUEJkdJXq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=juiP09hSwg5a4ti2mU/MlK+N/byVNOERrC6IeACg5lx4PrsWdctviwy9PWSVas44r
	 k4euOEQLtIctWsxxprG5KIoLybaQ/N1PdmiUkEGK49cibM62shyJ/x7DaiUqNCkjOw
	 6KlFM4Zh7eID4M6joTlmK87vqycfodQfGfWV63igRZ3/4sCr5h0vxwKTj2qf7/U7Qn
	 6qqrzLXs7dEJQGzcKnD7EuDnwv6uZ7VguFiC51YniHpQdE0g0WKYMV29GzGHFeXUwY
	 +Yk96OqZBmimFm9LcZiCAzDc0ulZRJWkgZw7sW+b/4xWPPombi9LK0/e6wL/LZFDt0
	 EeizxBRgQYzlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B03FD4081C;
	Tue, 20 Oct 2026 17:07:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79821930
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 17:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AF9D81106
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 17:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PanFO-7yL2c2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 17:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4176280FB7
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792516048;
 b=aP9c5fSQ0dkkKUgiv/ndGBJ38YXXmO8JwuCXMD72ix9hFzfLoVUemLil6RYevFIGneDb
 nlI0z7eJCvKLklGqFPP88l6cRWHWH8k3Rb1RNX93pm5SqaOyyzvyW5X3ngXvwN/Z+/fTg
 /++4/vQMD5h+77hftYj65TVkheagb614gUqMq2VYrc9XW40KmfRzghf5OqMsadK2UKgE7
 Ok/wEgD5gxqz2N9BMUbA59DH1Z580OFoq7ts9FCVuYSu1226naZNcb7QGzc8isthzUhYl
 /9SdiZeUh6Z9yShNl/X6uFqvWn0TWiQTUnsRXQvU7eZkoPPdLwOPzyKcu/jbmX2i7SQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792516048;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To;
 bh=9/l68fSQm/RuZObxkeWmD9P0V6B9tkMkoAUEJkdJXq0=;
 b=cuOMVwTF+jTvg4+Q2GQ+ZttCjHquskM1g8ZzTeQJSAw3xyOpJlWnLsxzYa2oO2rYhD3c
 Sa9V5VbyIOYn1tTeTI5OdSpvYtHrrLdUyC+Gg0wTXym3nKawYBwaEnRjmmIpSN5r5yYq/
 dGwf/5RobfkBi7oVtrtawa+E/ug/2rl4dFhrNQQl3+EKmHumbJnY41HUldoPZsLh/eYTr
 2Bon+TN4fwpI+DssyICyN/asVnh5HR/hfVz0gS/+hnIzcEL9RAcqpFgm5cz1BA8mA07qp
 xcMmx3knuobEKz/0n0FxwzEw51jWyQwTi6t8Iob1AlVeGKc12oMCwc/poOonNtBNYFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4176280FB7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 17:07:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2982660052;
 Tue, 20 Oct 2026 17:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B891F000C9;
 Tue, 20 Oct 2026 17:07:22 +0000 (UTC)
Date: Tue, 20 Oct 2026 18:06:49 +0100
From: Simon Horman <horms@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, maciej.fijalkowski@intel.com,
 avigailx.dahan@intel.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
Message-ID: <20261020170649.GQ503057@horms.kernel.org>
References: <20261013010854.4068874-1-p@1g4.org>
 <179194315897.434549.3743742848544230715@kernel.org>
 <Z4u97qIiSB-8nYCRmd03ddR4OFMcrpNVUcTHSoOADzNQcLvQVIQotijZpukYAO4AzV4r6j11nGS_lWTwyh709u_USu516VJmvffbjukcAs0=@1g4.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4u97qIiSB-8nYCRmd03ddR4OFMcrpNVUcTHSoOADzNQcLvQVIQotijZpukYAO4AzV4r6j11nGS_lWTwyh709u_USu516VJmvffbjukcAs0=@1g4.org>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 05:43:10AM +0000, Paul Moses wrote:
> On Tuesday, October 13th, 2026 at 8:59 PM, netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 2 · Medium: 0 · Low: 0
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [High] The patch fixes the TSIP length underflow only in
> >   igc_clean_rx_irq().
> > - [High] In igc_clean_rx_irq(), the new condition `if (!skb &&
> >   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP))` uses `!skb` to mean…
> > 
> > --
> > 
> > igc: only strip RX timestamp header from first buffer
> > 
> > This patch changes igc_clean_rx_irq() so the 16-byte inline RX timestamp
> > header is only stripped when no skb is in progress. Before, a continuation
> > buffer shorter than 16 bytes could underflow the unsigned length and
> > produce a skb fragment of almost 4 GiB.
> > 
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > >
> > >  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> > >
> > > -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > +		if (!skb &&
> > > +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > 
> > [Severity: High]
> > Is !skb a reliable first-buffer test when an XDP program is attached?
> > 
> > Suppose the XDP program returns a non-PASS verdict (CONSUMED, TX or
> > REDIRECT) for the first, non-EOP buffer of a multi-descriptor frame. No skb
> > gets built, and the loop moves on with skb still NULL:
> > 
> > 		/* fetch next buffer in frame if non-eop */
> > 		if (igc_is_non_eop(rx_ring, rx_desc))
> > 			continue;
> > 
> > On the next continuation descriptor, !skb is still true, so the TSIP branch
> > subtracts IGC_TS_HDR_LEN again. If that continuation holds fewer than 16
> > bytes, size wraps.
> > 
> > The wrapped size then goes to xdp_prepare_buff(), and the continuation is
> > run through XDP as a new frame with data_end before data. On XDP_PASS, both
> > igc_build_skb() and igc_construct_skb() compute:
> > 
> > 	unsigned int size = xdp->data_end - xdp->data;
> > 
> > That comes out to about 4 GiB:
> > 
> > - igc_build_skb() passes it to __skb_put(). On PAGE_SIZE >= 8192,
> >   igc_get_rx_frame_truesize() also wraps to a tiny truesize, so
> >   napi_build_skb() would place skb_shared_info inside the packet data.
> > - igc_construct_skb() turns it into a fragment of almost 4 GiB. That looks
> >   like the same corrupted skb the commit message describes.
> > 
> > Can this be reached from the wire? On PAGE_SIZE >= 8192, igc_set_rx_mode()
> > never clamps RLPML:
> > 
> > #if (PAGE_SIZE < 8192)
> > 	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
> > 		rlpml = IGC_MAX_FRAME_BUILD_SKB;
> > #endif
> > 	wr32(IGC_RLPML, rlpml);
> > 
> > So the hardware still accepts jumbo frames even though XDP limits the MTU to
> > 1500, and with XDP the ring uses 3072-byte buffers. A remote frame that
> > leaves 1 to 15 bytes in the second descriptor would hit this.
> > 
> > Would it be safer to track start-of-frame explicitly, or to drop the rest of
> > the frame's descriptors after a non-PASS verdict? Another option is to
> > reject size < IGC_TS_HDR_LEN before the subtraction.
> > 
> > >  			ctx.rx_ts = pktbuf;
> > >  			pkt_offset = IGC_TS_HDR_LEN;
> > >  			size -= IGC_TS_HDR_LEN;
> > 
> > [Severity: High]
> > The same unchecked subtraction is still present in the AF_XDP zero-copy
> > path. igc_clean_rx_irq_zc() strips the header from every descriptor with
> > TSIP set. There is no first-buffer gate and no size check:
> > 
> > 		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> > 			ctx->rx_ts = bi->xdp->data;
> > 
> > 			bi->xdp->data += IGC_TS_HDR_LEN;
> > 			...
> > 			size -= IGC_TS_HDR_LEN;
> > 		} else {
> > 			ctx->rx_ts = NULL;
> > 		}
> > 
> > 		bi->xdp->data_end = bi->xdp->data + size;
> > 
> > Can zero-copy frames span descriptors at MTU 1500?
> > igc_configure_rx_ring() programs the XSK frame size through
> > IGC_SRRCTL_BSIZEPKT(), which is (x) / 1024. With 2048-byte chunks the frame
> > size is 1792, so the hardware buffer becomes 1 KB.
> > 
> > igc_xdp_enable_pool() only checks:
> > 
> > 	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
> > 
> > That accepts 1792 without allowing for the 1 KB rounding or the 16-byte
> > inline timestamp, even though the comment there says frames should not
> > span multiple buffers.
> > 
> > On 4K pages RLPML is IGC_MAX_FRAME_BUILD_SKB. A received frame of about
> > 1009 to 1023 bytes, plus the timestamp header, would leave 1 to 15 bytes in
> > a second descriptor.
> > 
> > The reproduction in the commit message suggests TSIP is set on such
> > continuation descriptors. If so, size wraps here and data_end ends up about
> > 4 GiB past the XSK chunk.
> > 
> > Wouldn't that let the XDP program's packet bounds checks pass for offsets
> > past the chunk? On XDP_REDIRECT, it would also report a bogus length to the
> > XSK socket.
> > 
> > Should igc_clean_rx_irq_zc() get a similar fix? Should
> > igc_xdp_enable_pool() also account for the 1 KB SRRCTL granularity and the
> > inline timestamp?
> > 
> > --
> > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013010854.4068874-1-p%401g4.org
> > 
> 
> Yes, there's work needed elsewhere, but it's entirely independent of my fix. It's 
> questionable how much of this is even reachable and if any impact whatsoever. 
> 
> Here's what I can reproduce with and without kasan and what my patch fixes. You are on your 
> own on the rest.
> 
> I'm sorry, if only there were more time...
> 
> Good luck.

Hi Paul,

Thanks a lot for your patch.

I  do accept that there are some pre-existing issues in the AI-generated
review that are not strictly related to this patch.

But I do think that it would be best to make this patch more complete
in so far as preventing the overrun described by making a wider guard
for calling igc_test_staterr().

And including igc_clean_rx_irq_zc() in the fix.

My slight preference would be for explicitly tracking the first buffer.
But perhaps that degrades performance.
