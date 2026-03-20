Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D561099B2D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 18:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C8BC60B8F;
	Fri, 20 Mar 2026 18:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYPS6w3ZScsY; Fri, 20 Mar 2026 18:05:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5933260AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774029900;
	bh=4mEjp43NH3/QzOcEJdAkgsERvH4l3316pFf6YpNvDw8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/+a5zAIgAXEmlpAco/eF5eTMtxTroUhKxR/q2tJSGlG76VjsNTQBJcJgsh8nVNPM
	 6yy4d7qJCxKcdadV3/7rlNrCqpE9XBV0XNUI4x0Pq63Tb3A0y2zTd03sHySlb3fy0W
	 b8LaqY3RCNUIvjQ+cm84mCaXA9ZYauoPEylsanjM9POl2Q1PzYlUOvgtMZN4BVN40l
	 XlMcVsQ9pkd6DYmdkKUSiPGspXy0vPczivGaKOdJZI/0LGg5oPdRSwmtrvxlpvNBt8
	 9lFG9sc8NdfRXFGZjtqpYnQsJ3TnKH6BrENW+WblIXheIa5PwZMwEJNI7oa6FeE2bG
	 JOeyQ6he8hA9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5933260AD9;
	Fri, 20 Mar 2026 18:05:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CB7721F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 18:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E12A60AD9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 18:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfsJFfIbzmPT for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 18:04:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6870160767
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6870160767
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6870160767
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 18:04:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ED58140C2D;
 Fri, 20 Mar 2026 18:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCA6C4CEF7;
 Fri, 20 Mar 2026 18:04:56 +0000 (UTC)
Date: Fri, 20 Mar 2026 18:04:54 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org,
 Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Message-ID: <20260320180410.GA151863@horms.kernel.org>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774029897;
 bh=MWjx9x4Xl1BkLqNJhEJUVwdMpzVxVl0W3+B/XEfda4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dc0AiC8HWTroundPkJREjzoBqtTidxTGkbEz+xDedXhWDrPx+RDNPXHM2KD8gmXYP
 KpwKXdRQsTfzAR63tQ32OonJdjglD3N9CjI0f0kYajnGzR7kYcx6YSPu9sgB8on4YR
 rTia+oqnQNk2Q00ZewQsImi8HfDjswi89+oGBuhAlq/Jw5q3H5333iefqkdemL3GWy
 gI3OYciTiYbAeIInMnOA/CbABpSZYZtbYo+jWofrouZ6jFius9a8Pes+KTxxdnIptf
 DmchDyYme+S4+lisudfyRW5i7gtFUvY8zjAdR0tigvgaYXtVzBmzLWPpBY+5cuiolK
 iQUrB6KfH10gw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=dc0AiC8H
Subject: Re: [Intel-wired-lan] [PATCH] ice: add missing reset of the mac
 header
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

On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> 
> By default skb->mac_header is not set, so reset prevents access to an
> invalid pointer.
> 
> Call skb_reset_mac_header() before accessing the mac header from skb.
> 
> Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Hi Katarzyna and Aleksandr,

I am curious:

Is this a bug? If so then it should probably have a fixes tag and
a bit more of a description around how this can happen.

If it is not a bug, then is this defensive? And if so, is it really necessary?

...
