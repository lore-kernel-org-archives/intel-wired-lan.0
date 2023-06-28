Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FDDEB64D7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jun 2023 14:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6C5641767;
	Wed, 28 Jun 2023 14:40:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6C5641767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687963216;
	bh=+8GhhiuWa5uigBZL+wFhMamNZC70oXa7WkO7TFYi+Uo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=C2OLBZUyexiRBu2qKl0pa0mZmGMc4JxwYb+bmzLSGnKb2T8dcL3OhiXgFY59A9grR
	 p54s/k3/hHMtncfV8/uMKnUgoT546j9R68w0zd6mN2/ZxJvVXlt1Yo1gzT6/1fENaj
	 Du7zU4reIRuxxCBGslgeY46o690bjWg2hdc1Ms+Uo0nRODd8f15ms/G/DHK0q7YOSV
	 2TXjoaX8dMAjYbilyQzAI3rUM6Jve8LWtoT8RahNx/iOxCjynQgPxDXZMhkQqTZaFG
	 mKoUGMJGkwY+cm5ICfizi7/piGDvqeAAv051YSHcyLhqjgqYA8nPqVtLJPjFPYkWwo
	 DvZFFddAJgAaA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxBzU-zWjfvu; Wed, 28 Jun 2023 14:40:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDCB941734;
	Wed, 28 Jun 2023 14:40:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDCB941734
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2350B1BF2CC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 14:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F00C840320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 14:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F00C840320
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7T-Gp1dzUIlY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jun 2023 14:40:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CC02400FE
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CC02400FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jun 2023 14:40:11 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qEWKW-0007sj-0E; Wed, 28 Jun 2023 16:39:36 +0200
Date: Wed, 28 Jun 2023 16:39:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yunchuan <yunchuan@nfschina.com>
Message-ID: <ecd70c28-1629-4b6c-96fc-a0b8f8713a04@lunn.ch>
References: <1f5652f7-7eb2-11f0-4a07-c87f2992e509@huawei.com>
 <734b846f-3235-f2e3-db06-6e852803cd7f@nfschina.com>
 <badb3550-e157-4a31-9e49-ad184990c06d@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <badb3550-e157-4a31-9e49-ad184990c06d@lunn.ch>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=cW+45nW3hJrB+ORXPsF9u401T/nSilM4vjgp2/JRVK8=; b=U1WferOlqrpgddhvvlvTWes0zc
 gz9sFpyiKouuyXJTUYNzdFHYS6e6yVbKtT8Fkilt/42PZXz2BDJyjoEp+Q596vjZztfSB1KA5oUT3
 w0vosHmfbAFtJLPTH97RuCn3S9Mc5r/aU/LSSbblgfHMV0vEIB88AAaMTA20vfI+hZ7c=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=U1WferOl
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Remove unnecessary
 (void*) conversions
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: irusskikh@marvell.com, kernel-janitors@vger.kernel.org,
 linux@armlinux.org.uk, edumazet@google.com, iyappan@os.amperecomputing.com,
 anthony.l.nguyen@intel.com, quan@os.amperecomputing.com,
 Hao Lan <lanhao@huawei.com>, qiang.zhao@nxp.com, f.fainelli@gmail.com,
 jesse.brandeburg@intel.com, xeb@mail.ru, intel-wired-lan@lists.osuosl.org,
 yangyingliang@huawei.com, kuba@kernel.org, pabeni@redhat.com,
 yisen.zhuang@huawei.com, ansuelsmth@gmail.com, steve.glendinning@shawell.net,
 keyur@os.amperecomputing.com, mostrows@earthlink.net, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de,
 olteanv@gmail.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jun 28, 2023 at 04:37:43PM +0200, Andrew Lunn wrote:
> > Hi, Hao Lan,
> > 
> > Sorry for that, I just compiled these patches in the mainline branch.
> > I know now, it's also necessary to compile patches in net and net-next
> > branch.
> > Thanks for your reply!
> 
> net-next is also closed at the moment due to the merge window. Please
> wait two weeks before reposting, by which time net-next will be open
> again.

Your email threading also seems to be broken, there is no
threading. That might cause pathworks an issue.

	Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
