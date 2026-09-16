Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477F2C982C3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E12EA40754;
	Wed, 16 Sep 2026 14:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BvP4eqVghu7; Wed, 16 Sep 2026 14:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6BA514072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789569693;
	b=YjKbrN0K3nZnh/Xa+9olqU+hJ+OGsLzSyjwUraNbPfiOwIBPiWMsG+GzUFK02/gajE+e
	 svjGQoLuXyhw/lqLxYa8gqYwlru5cYRC/oclcnzQC401I8X8L0B6V0xNDZc9nnHvNn2Bw
	 ZcZPUp9OSqjy8C1UbNwpyw85cqUkHkXB/WEHnU4HVlzohgUOFOLk1NdTTeUBaR7vAZExQ
	 Zqkaut2AsCQmwgXQrGj+/m9zpdULzWlbKmyFXvolUxO931LLhdIJQI0kofrL2+PzYma5N
	 B/pEhYoYUENP78/qp83qdB0fe+0A4xwa2PkCTwXmzTN+Gkd6JN2jqvTvT37k27zVSlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789569693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=82sCX0TvTRzwmUtFpBAYs8yegtSun3AYeBn0vabgQE8=;
	b=CkFjKs/p+QmNqE6JJOEuoK3ojQc374jDmMiGO/iNZm0jkZhad2gkreQjWpaHDWltc+u4
	 l2rijnGzM/UdHQpXV6+ib05Rmh0axWrcdlQ3zwc0vvIrfCGd9y+q/J79rIFnA8W94DWpa
	 o56DGjSeWO4WMzGynVIWpfT5NyJHTGcWiCewkUHFllcuQWpm2dvWA+RFTa+mQsB2x854O
	 1KX6AvAInShNE9BGYjgvjpUtSimQ9odN410un7zT3Cp6MeuRfq2kcuAfmxU3iA2F397N9
	 5U8EekpdwQsCDOEFj6Sbqt94wg7uRSyis1j2HEjtjoZJbms138IIUlDeKW+2DgNg+sA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKXghM7y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789569693;
	bh=82sCX0TvTRzwmUtFpBAYs8yegtSun3AYeBn0vabgQE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=25lO6lwr6YUA3o8AHN7il5sj5oxguqH41cdROgaimU+4IzkrOqFmRuOPFitgm/3s6
	 6QXwHtBB87Q9EIjBjIknVIT2/S5Unq1LaYeiNCM2m+LFWhTqE1ngHO58E46ecoVXoR
	 B8Exutwc9q7QRCCCqvRetxHItGpVm5lf2Niy+0xHBdHf4FHlkeHk9fqqlK9rXikNOv
	 SUvnKp9AYza4k/v8Z8npYrfbSnhjx3KisypehHBUDhwrMzIVt6ERY6HXJzoQAQ41C/
	 vwrPohQ9N1ZthjTWrFF5YgltYhSKpzBWupvoi4DSO13ZsaERD5nIF6qNk2Q31O/Tgq
	 tehS2E7WuRwQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BA514072F;
	Wed, 16 Sep 2026 14:41:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E2D3493
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 614EE4072F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Skj4vTwloKJF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:41:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D47D240729
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789569691;
 b=nx01jpDIZ0xKW92BxLm3lASg9Z2zfXrPVM6EETzsG97TJuU2nfpqPFeYLGJk9Ii/rUJe
 W8KsH23nSBTYw4GLDc3RaBDC2n6HJuJe52TVij3dYsIQqEiAg8rydAQSimp7Qkh2OneHh
 EOyMeEzcC0EpXdMsSuWcDepmB+jHLfkRw8RIia2H+ElE4b4ZRCUp6dgy8DUSMM4WkU5oG
 J+QWNQSTpF5JN7tbeVHlK+U/81S1dg+/K+4TIN063C8CECI5ADneHtzVso9HeIjzmCc6M
 rN+3nVyA4hR58uwJMWrnvkd5ipUlcL0vpcNf9JSriVqqXfg6k7BgLA9ZO9VvosBD1nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789569691;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=82sCX0TvTRzwmUtFpBAYs8yegtSun3AYeBn0vabgQE8=;
 b=ZnfkNpv1mJTFanmD1oHnKfp0jMxAExfn/fzNJTShkTT6JjnhC8016FsoHDNBSmhbtA+y
 cHH943z2hNpUsAxzrJoNldiquhu2AMhRz9BPJvjyoRx2tWruRlzdh/GSCXsTzMqfDeDx7
 2o7rW6BQLMz25rARAm5Kgalu8YBRLX+3iUrv8agV7ZQe9Z90HuyF/EOutKEQ3wZ9lBs7j
 8a6jQOtWv++ykxtiWUd/QsqQXqJcQIiO/aa1Gh/G/IALfQvxDKty/1+rRyxWctofJfu5s
 60f4O01W6zCaE7Xi9fQtf8TXTATn1bnGcoh2yCfQYa7D6n1G8fzna8FSYj4n/6vfkbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WKXghM7y; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WKXghM7y
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D47D240729
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3B4140126;
 Wed, 16 Sep 2026 14:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33FD1F000FF;
 Wed, 16 Sep 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569689;
 bh=82sCX0TvTRzwmUtFpBAYs8yegtSun3AYeBn0vabgQE8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WKXghM7yA4vICpye4shwC3xDWVWYBes52zArD8yKuEWlIbNMB+oUPA5/BkUotObvW
 61qnzLhyMbG8jt5NiBK62i/Efwfg1yQFhjfDXZ9445IapfoJGWeqlj0LnkYgvI/ECo
 +cyx5E6RaoWLqB6+vcIpaH9Z5ehWthv9iloNPFBzDSUJEfLWmk52q4Vfkhz4TvPE3+
 Okg9P+sk2MI/rCLnrmq5BXLpWa35YOHecY2zeQNLGL+6Polx+qJ0dLDMh42aXzhDJV
 JcQ7UACePlkuIiOv7eUIDK6EGBHuuIqUVI9uMeKqiukiJDW3CENOt1klARIAyhtl6Y
 8dvqDb01ZeBMw==
Date: Wed, 16 Sep 2026 15:41:24 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS
 to prevent RX starvation
Message-ID: <20260916144124.GM51261@horms.kernel.org>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
 <20260915125538.3975870-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125538.3975870-2-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:35PM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> At the current maximum of 126 us the minimum bulk-mode interrupt rate
> is ~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic
> this is low enough that descriptor ring starvation can occur before the
> next interrupt fires.
> 
> Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the
> minimum rate to ~11905 interrupts/s (~12K ints/s), providing enough
> headroom to drain the ring before it wraps.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

