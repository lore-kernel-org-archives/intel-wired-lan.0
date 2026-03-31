Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429CCFF60DF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 31 Mar 2026 08:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0192660EFF;
	Tue, 31 Mar 2026 08:12:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHt80XTbUTmz; Tue, 31 Mar 2026 08:12:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34B2C60EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774944722;
	bh=MPLei+kZYJdowg7pDgVGP3typtbek2grKrPWpuL32W4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yOEyXP8vxNta5s22LJgnWqBMVBZExc2dWmuMwmuFU7NfC3lPM1WkMrgdmcjyKHE8p
	 3ceCcPmVPfcBbitoF0DNLjMp2u9wqL5YP+KIwHNKRmxmp3SYBicpx9pc6hZVpVoWSU
	 YaAL7XX3BUVv+lshZ8ZKuvWQg80T1DECuDu1y7m9AjMD/v2RwEW6oySzPQ7hLGUbL7
	 sSBoljzIeuxC5HGeXwM2ymCLm5l+AhDTTUh2SLR7wHYRgeVn6VWt51Sr+HWY5rz/mh
	 fqKTXZMDAC/9NaukMVJoCCWuD/H4jkydDL1enB22Mhz7hDds7Digw1rE+DgP5AaMvP
	 HRGfLdfGAipwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34B2C60EFA;
	Tue, 31 Mar 2026 08:12:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D93A2C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 31 Mar 2026 08:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F5B082307
 for <intel-wired-lan@lists.osuosl.org>; Tue, 31 Mar 2026 08:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BaXUHYm7XfFI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 31 Mar 2026 08:12:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=166.125.252.92;
 helo=invmail4.hynix.com; envelope-from=byungchul@sk.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A147081EFA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A147081EFA
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
 by smtp1.osuosl.org (Postfix) with ESMTP id A147081EFA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 31 Mar 2026 08:11:55 +0000 (UTC)
X-AuditID: a67dfc5b-c2dff70000001609-4a-69cb81c61269
Date: Tue, 31 Mar 2026 17:11:45 +0900
From: Byungchul Park <byungchul@sk.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, david@redhat.com,
 willy@infradead.org, toke@redhat.com, asml.silence@gmail.com,
 almasrymina@google.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Message-ID: <20260331081145.GA54972@system.software.com>
References: <20260224053546.62757-1-byungchul@sk.com>
 <20260226010811.GA16777@system.software.com>
 <af90b7e6-de47-485d-9e1b-31612456ef9c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af90b7e6-de47-485d-9e1b-31612456ef9c@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXC9ZZnoe6JxtOZBt/+i1qs/lFhsfzBDlaL
 3Rd+MFnMWbWN0WLO+RYWi6/rfzFbPD32iN3i/rJnLBb/b/1mtbiwrY/V4vKuOWwWxxaIWXw7
 /YbR4vbSq0wWlw4/YrH4/WMOm4OAx5aVN5k8ds66y+6xYFOpx+YVWh6L97xk8ti0qpPN42Rz
 qcfOHZ+ZPD4+vcXi8X7fVTaPz5vkArijuGxSUnMyy1KL9O0SuDK+bJvJVrCAv2LVgn9sDYyr
 ubsYOTkkBEwkzp88xdzFyAFmb7ggCxJmEVCVWNy3lxHEZhNQl7hx4ycziC0ioCNx/uYeoDgX
 B7PAPyaJ7XfvgCWEBQIlzl04wgYyh1fAQqLzVBhIjZDAdEaJNc8WsIDU8AoISpyc+QTMZhbQ
 krjx7yUTSD2zgLTE8n8cIGFOAVuJowc+MIHYogLKEge2HWeCOHMeu8S8J1IQtqTEwRU3WCYw
 CsxCMnUWkqmzEKYuYGRexSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYZctq/0TvYPx0IfgQowAH
 oxIP742qU5lCrIllxZW5hxglOJiVRHh9eoBCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacI
 CaQnlqRmp6YWpBbBZJk4OKUaGCU7hUL8rt3cfuejZU3xXt1b2kkrCjg0+VPmsJwUsuO57zf5
 z5H9PP6n+oVUVblKV5ayy53PYT365MhK6bOZ/XzC29dkuTZvSnh+2I9Rvp1JmqvIU1l8rWfM
 fAe/gzNiPC5du+OX8JzD7XT/YdniDh/5n1VCh2dtSjNwuvLcdFXI0n/+j3O3K7EUZyQaajEX
 FScCAJfF1c+uAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42Lh8rNu1j3WeDrToOeVjsXqHxUWyx/sYLXY
 feEHk8WcVdsYLeacb2Gx+Lr+F7PF02OP2C3uL3vGYvH/1m9Wi8NzT7JaXNjWx2pxedccNotj
 C8Qsvp1+w2hxe+lVJotLhx+xWPz+MYfNQdBjy8qbTB47Z91l91iwqdRj8wotj8V7XjJ5bFrV
 yeZxsrnUY+eOz0weH5/eYvF4v+8qm8fiFx+YPD5vkgvgieKySUnNySxLLdK3S+DK+LJtJlvB
 Av6KVQv+sTUwrubuYuTgkBAwkdhwQbaLkZODRUBVYnHfXkYQm01AXeLGjZ/MILaIgI7E+Zt7
 gOJcHMwC/5gktt+9A5YQFgiUOHfhCBvIHF4BC4nOU2EgNUIC0xkl1jxbwAJSwysgKHFy5hMw
 m1lAS+LGv5dMIPXMAtISy/9xgIQ5BWwljh74wARiiwooSxzYdpxpAiPvLCTds5B0z0LoXsDI
 vIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwapbV/pm4g/HLZfdDjAIcjEo8vDeqTmUKsSaW
 FVfmHmKU4GBWEuH16QEK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2C
 yTJxcEo1MFZJ/BGR7nnGw7xGzjaM657Tlut/3/ob9/B+4b/l5Jkmc4ztcLPrwocb/kXwd+w7
 +L/dc/Zfc+sN5ZffmWWw/Xr6y/LN944ewf2rJu48tFb7kvfnM5Jv6h6f/ncjbUHmJtPfRkls
 D+eErPi0aF5jVkHfWV3W3Xw9CbzKIQWWJb3S79pfhzAu9VViKc5INNRiLipOBABVjmPHlgIA
 AA==
X-CFilter-Loop: Reflected
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=sk.com
Subject: Re: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through
 netmem_desc instead of page
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

On Thu, Feb 26, 2026 at 10:13:14AM -0800, Tony Nguyen wrote:
> On 2/25/2026 5:08 PM, Byungchul Park wrote:
> > On Tue, Feb 24, 2026 at 02:35:46PM +0900, Byungchul Park wrote:
> > > To eliminate the use of struct page in page pool, the page pool users
> > > should use netmem descriptor and APIs instead.
> > > 
> > > Make ice driver access @pp through netmem_desc instead of page.
> > 
> > Hi Tony and Przemek,
> > 
> > Is there something that I'm missing or something wrong with this?  Your
> > feedback would be appreciated.  Thanks!
> 
> Hi Byungchul,
> 
> Nothing wrong. I plan to apply it today.

Hi Tony,

Sorry bothering you but could you tell me where I can see the patch
ready in a tree, maybe yours?  I failed to locate it.

This patch is very important for the project removing pp fields from
struct page to go ahead.  Thanks in advance.

	Byungchul

> Thanks,
> Tony
> 
> >       Byungchul
> > 
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > index c6bc29cfb8e6..c16e54dbe75b 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > > @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
> > >              rx_buf = &rx_ring->rx_fqes[i];
> > >              page = __netmem_to_page(rx_buf->netmem);
> > >              received_buf = page_address(page) + rx_buf->offset +
> > > -                           page->pp->p.offset;
> > > +                           pp_page_to_nmdesc(page)->pp->p.offset;
> > > 
> > >              if (ice_lbtest_check_frame(received_buf))
> > >                      valid_frames++;
> > > --
> > > 2.17.1
