Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096F0CD98D9
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Oct 2023 00:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 776934012E;
	Wed, 11 Oct 2023 00:47:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 776934012E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696985262;
	bh=C6Y7PxgoSylaCvk1r+b1UrUXNPJxsdZNkCucxEhTOMY=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=TWq/37FNMNEM6wy7eJpSrnfZ4bTtrXLSCzH01gcg6HNk+oZkNppAl5mUGfNqPg9O/
	 dVpkRly6vNxJlX6qqY/5TuahQJYQXFlvaE7xMTboNVZNlpRfRmCSjixy7RLR7W3+c4
	 01+nNc0WxUAQfz1HDVO1bnrOePJzndcbDjvcciz6rg8MovXzh0Qe7N5mrmlDVLLck6
	 Vbnfndw+WmBym78EsI++GlxTphR+xmgIwQFEnIne6YRkOJKtSGSR3askgHyph4YYrk
	 fMfFrduclp7fIvsURokv45c4QJ/ngw5Ma0vM/WUoe97XZkgN7zmnpOoCy3sydVTgyw
	 PBPD3iXoWgIIw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaoJVObID2fE; Wed, 11 Oct 2023 00:47:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4ECD4158B;
	Wed, 11 Oct 2023 00:47:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4ECD4158B
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 40EA91BF97E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Oct 2023 00:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 182014158B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Oct 2023 00:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 182014158B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0AjF3CGRiSoD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Oct 2023 00:47:38 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57DC64012E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Oct 2023 00:47:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57DC64012E
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 211EBCE21BB;
 Wed, 11 Oct 2023 00:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC9C433C7;
 Wed, 11 Oct 2023 00:47:32 +0000 (UTC)
Date: Tue, 10 Oct 2023 17:47:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Message-ID: <20231010174731.3a1d454e@kernel.org>
In-Reply-To: <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
 <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
 <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696985253;
 bh=GML/tjgAq13M4+96lhLvoGtPl4yhrUdZshloPeDdWqM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ryjEudkJcuUfG9yZePCjX40V0FqAFEM5mudN5TtbVVdwCNZM7Zb3feRbDMR9cUeK2
 j3JWZN1mGsjcmDty1myc9gr/NchebGTRsncb1SHyXdCF55oSmZsux8VETkAEb+SvXK
 bp8UmQI/amPTbQ6zfWyumJgv7PQiW+a1CI1Iy7ClAflXAC5SX7duC1fErtPQnB9/bQ
 m8yOoVyNO8dTv36WGZ+ECuHhJTAqaJ8B3I2OSFIuRNgTUoG51sIIzUn6gNBZ8xojjr
 bWBJqQ1raQpgyxM311FIJfki/PYhBtcrLJB2AfSzd+OmcaduwanDfvLFhVefPdjUmS
 cUFPvdMhA5oAg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ryjEudkJ
Subject: Re: [Intel-wired-lan] [PATCH] igbvf: replace deprecated strncpy
 with strscpy
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
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 10 Oct 2023 14:41:10 -0700 Justin Stitt wrote:
> > Thanks Justin for these patches, please make sure you mark the subject
> > line as per the netdev rules:
> > [PATCH net-next v1] etc etc  
> 
> Sure, I'll resend!

Please do read the netdev rules Jesse pointed you at.
Maybe it's the combined flow of strncpy and __counted_by patches
but managing the state of the "hardening" patches is getting 
a bit tedious :(

Please group them into reasonable series. Do not repost withing 24h.
Do not have more than 15 patches for networking pending at any given
time. That's basically the gist of our "good citizen" rules.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
