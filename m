Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B956C5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Aug 2026 08:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A3BB408FF;
	Fri, 14 Aug 2026 08:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBP6H8Cqb92t; Fri, 14 Aug 2026 08:59:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EB6C40835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786697960;
	bh=9XIZceZi/Vth8ThKEJJfdNlyvXugHG+VbBwkmtjj7Hs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6J+YPbLihAXWTDYxErzBdcTpJhnSKRD0FeLM7Y09H4fJonxwSJuC0aLzN6BKGTPYx
	 /HrInQs9Xa3V07maFQvNTizAsM5mLvWYVsbFqVsbwSou+7qUvk5FSRbIY8LbVDvz+G
	 PV1JUwL9Vln0BfbU6fPEB8VlVQIwDgrMR/JN3w5TOoMMQmxkZPAQWpWfK1uKVyB7dD
	 g9X2JrjkLTviulidYP60fIKRBWWTKxKOnZHBHWyAPFTt5zcei566Ja5lI7/Z5FqK2V
	 MUZ4+vJQGmWcTPCWjmTQojkJEaXN668f1JI3VSYnGkcqNIj/EizLFozCQfWt/SQKH8
	 NV9wvg3F67M9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EB6C40835;
	Fri, 14 Aug 2026 08:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A189A1393
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 08:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A090401AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 08:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVGlLxPQ-MHu for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Aug 2026 08:59:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DB9E3400AD
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB9E3400AD
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FnOzR989
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB9E3400AD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 08:59:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 230D3600AD;
 Fri, 14 Aug 2026 08:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E15F1F000E9;
 Fri, 14 Aug 2026 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786697956;
 bh=9XIZceZi/Vth8ThKEJJfdNlyvXugHG+VbBwkmtjj7Hs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FnOzR9891i0yO5BqTHyAOG53NRbJ2nXAVdCxd87AVyQ1TpPlh1Fy08Pizi7hSdyWc
 ukYnjzLiT3oVBWKkBb6OYjCZYrfgg/9FFHL8uZ7W4xHBT5ZMtdU7dYHjMkielCCei3
 bBzB0VHThQyhGcNz8GoLBYPzkc37BIJePKv3uCqQUcmiNDENk2VsHu9erKXhkvx9Od
 4b6P2SQ+1ePArCCV/O0YEU79Pmanpf/2XTedP++pv4qx+cP3xdiO3LNWALhmO+UUIJ
 T35CLuR1PLBlsH5kBUWFL8qAfMur0MGSmYo0rcvoarfYmUMmtqrYiumdO/r/fYaAMD
 FtkmPUMTprNeQ==
Date: Fri, 14 Aug 2026 09:59:14 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20260814085914.GH265046@horms.kernel.org>
References: <20260811181127.1142095-1-david.m.ertman@intel.com>
 <20260814080709.GF265046@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814080709.GF265046@horms.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix incorrect LLDP
 filter assumptions
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

On Fri, Aug 14, 2026 at 09:07:09AM +0100, Simon Horman wrote:
> On Tue, Aug 11, 2026 at 02:11:27PM -0400, Dave Ertman wrote:
> > In commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> > necessary"), it was assumed that llpd_fltr_ctrl was a unique application
> > of a filter instance and the other command in the flow was generic.
> > This is an incorrect assumption, they are both meant to add a filter to
> > handle LLDP packets and only varied in the actual AQ call made.  The
> > newer AQ call was created to handle a special case in some NVM images
> > where a LLDP filter was already existent and the old AQ command would
> > generate an error if a new filter was attempted to be added. The newer
> > AQ command would detect this case and instead would add the current
> > target to the existing filter rule.
> > 
> > Fix the flow so that the newer command is always used if available and
> > only fall back to the older command when that is the only solution.
> > 
> > Also remove the obsolete state flag from the PF struct.
> > 
> > Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry for the duplicate, I forgot that I'd already sent this yesterday.
