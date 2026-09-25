Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995B9C98321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 17:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4362160D93;
	Fri, 25 Sep 2026 17:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPKPnPxYhNd6; Fri, 25 Sep 2026 17:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A3BC560D7F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790356978;
	b=Yqp46PMBQfGMdDFgNZBEtzjP1MJQ5yUfaI19Rw/O9yMMdClBIPyrxehCqJWAuLDsFyDk
	 13cXAz6psJG+P6nSzqsngbshGz2MnCSge8bfNsZyr1na8jmXGTmDnshW50CP8LuviyNkK
	 1TFU6LI4dN6XgY6iL0EiSEFpYTgQorGG+mv9qQlYNUs8K255pKUMHMz++oYGKkm9ed8+r
	 22VK6HlNPqVv+Sld6LbbRndgWhgs0g8XxI3rD7ix/5ecYsZ0N9Umj7Q7PMp0jyFrgY8a2
	 Y2WgA4BhZ4XS6nJYxvf3gI4CDejmbIc633w8HS8GnF5DoVVIHX0IKB4/NJej83qibDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790356978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=my5rV3MkvpAgY/IYTBj1G61ORyPyDGhx4/fK2LNjRgs=;
	b=Y99fy+n45rM3aNJgxRrQBIhn7sIxVK7CZ2+t1FPPOY2OL5PzTtMyX26TUhNpbDXB0Hw6
	 wvvtlmQRRcQY0l6NsJSP/mJXhcBXnoZ9HyhD3G40WojjXiKLzMnnV3jcdIce65py8z4a/
	 9fdhSFn/PI5UIkLx11VbIqy8cUbNDwbrZIXfjXixEhG997SIY3Ql8eZ1uvirLGHbpV2J7
	 my+0nubl+HFFhQsTPgZ4GpfgEQvNG77/7LgsAX9NJlNjdpPaWcCfHJWyDgXtK+8QE7zvP
	 sMBJMwA8rBuxeI4TK+ICYRvE/oL7VS4Z22q+L2BdofQNVT098ey09yEgLdSQU/ndobw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790356978;
	bh=my5rV3MkvpAgY/IYTBj1G61ORyPyDGhx4/fK2LNjRgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qhwDCzMpuy5xCowRZ85/xl97J8/v/NteLUVj4Hx0lbc7c531huz8Q1BJ7W91Si6R3
	 naiHACbp0eDDfhY52SvaOQv1aEz6GFlQanzQcbVW6M0V8s/hxCxgcM1iWPFPy8/zoi
	 LNhB37R/JFdhAz16OM/6FwsRBLvthZwLQHuQ2h9BC4WWTI6SMYnrOdu0RfF/XziEzw
	 wr9EDvevjgr2KB+kKXzNDle8eiuVUHw+HNjouixvp5/FyRua+Irg58P6j9NUdRiN8L
	 Q3JDLw+l/tU1/XUgsBptrmOK2JRpOBQY9nu8IwLigVJjGBXgGUQ9pFcFJzRjs86ozF
	 24atDpxpOx5Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BC560D7F;
	Fri, 25 Sep 2026 17:22:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFF14355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D11FA4049E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAMlZQCy8y79 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 17:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 405C5400E0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790356976;
 b=lupP092RbsIepCtHMCISCb1gDX1DDZeUAWEtxKeNQwPmGj4uAXKXfssOU7RRyDEeHIht
 FcyeMUUXaZExFQFnhZoNu+fQG5GnEu3UG/ej/TctKgqzBW1Yf+xmviKZGLc8kB1A83M14
 SCRYJ+8oP6nJLG0Ehntbz0KiFKRrxWnzoXDWR4pN2cyDv336T7tMW3laYs3jjXQPwGSOF
 ZI5689PqbcJZYX6OIqA9qjnvtbv+VhCmfTWDhK+2RCoXe9kUJIc9mB4D2UGJRVf49pPxK
 sPAnqYx0iinkPYWN79mxGFT/NF4idpFVUmI1p4zkojJwdxLC1V7x4TF7QpuVvP+0zSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790356976;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=my5rV3MkvpAgY/IYTBj1G61ORyPyDGhx4/fK2LNjRgs=;
 b=NlKhC1zJW2OrFZxaIofcEsvljFOhm9VesQ/lrIIFGGAPyQW7sBgPRdx/7L81XrdQghU7
 OLv2gB8I0051bpam1+U75QyyO5W+uaC35uS0ZCR5nOguIaFpSaWXhgpzDlUsDSch9I9zp
 38u4Odo50cqP6hMtWQs7yGuB+uO7v011GkgfSIKAUq02Urn5GwM8ctcYgSIGFt6uXuDqh
 7gzMFmMnptEwp3L6nKWvkquW2ZQ+zX/E9SgD9lgKZZBqqULMx2QxBM7Q7sjQT9T7WEHai
 ETsHZDeK/tBuSog4VYrT3VMr/pSOvUACX73H8qHcwHHQ32Npjo4nM80bOalgIfxKNKg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XjFudJyt; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XjFudJyt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 405C5400E0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 17:22:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4927B415AC;
 Fri, 25 Sep 2026 17:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF741F000FF;
 Fri, 25 Sep 2026 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790356975;
 bh=my5rV3MkvpAgY/IYTBj1G61ORyPyDGhx4/fK2LNjRgs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XjFudJytBQ0VX2Oiasaia35jiX/zgBzCGpDiEUz0R0HV13oeao11BGAuiDQz5qAbR
 mCxwUwE0/C1Ii5aaKFoVqLj0NZn4wXeyq1vOFtGECImQtxOfahB7ruTYnOfV8myoK1
 tStbm8LuXgU5jkYS+2fF2DdvSnSl/IiMVotu2rLkDt8CwSalR7+NqCPcWVKk0B8hEO
 1jh+/51blYyu9ubE1mEKAK4JhUy95zI+lbLrsxpuuSji+m+yF7zYzEpFC2ezyRwSL0
 tD/V3hgQ88f+h0A66shonEjWeyNpteoVd6P5oODn51WIDtQL+EyC8hsfwURHDIfb5C
 VwCeMVC5JPQcQ==
Date: Fri, 25 Sep 2026 18:22:52 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 1/4] ixgbe: Refactor device operations to
 check whether netdev is available
Message-ID: <20260925172252.GS13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-2-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-2-sergey.temerkhanov@intel.com>
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

On Tue, Sep 22, 2026 at 11:35:55AM +0000, Sergey Temerkhanov wrote:
> Refactor several ixgbe driver operations to check whether the
> netdev they operate on is enabled. This will allow the system
> to get synchronized, for example, during the PCI resets.
> 
> Fixes: f7f37e7ff2b9 ("ixgbe: handle close/suspend race with netif_device_detach/present")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I think the foce changes in this patch should be called out in
the patch description. Or, if feasible, moved to a separate patch.

...
