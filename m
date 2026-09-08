Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A972DC79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 18:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F05060732;
	Tue,  8 Sep 2026 18:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrOx95eyBjOy; Tue,  8 Sep 2026 18:32:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CDA3E60733
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788892335;
	b=eQDFZ4/xVNRnTJOs4Og/FZoyf0UscJ8vRcg3Ont6dZMKEWcELVRVXIE4k9QSRkeFcZ1p
	 99p0Sfc7c6r0lZXQxC47ijz0A+g2axLBseBNZZsDYgqNVqu1nX7wq24T0DTgBRQHh7lJO
	 3IkaRht/2TvrXYAh0ZdViILgYuEICHW330TLhF3vpYoIzDPN1NpglXx9z1JaNtEPEQ8qu
	 f35SLO1Cdz4toMIiqXcyK/hQCLLaVloMojfrrmJ7xAiLYPTFIPudR51q4yTECY3X0Zhpr
	 dZlWQmL4LE72+PVPI/Km/NNTE4/KV6OSCDkO9Ylz1+ZjDDiPCa+kqzHwox7mhzKu0rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788892335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l0CggrwevG1xFJXWU9JWMqvoGtAQryeGoT9XLBo0uuI=;
	b=U24/Vpo/PRVOIoZqqjt8+57dbfAnzQ8MyQ1fZybcRV6j1/f88vyHdi9hzTUiWErnqXBZ
	 6T+sTIc4buJ8lcO93B1rFFAqvCeIc57zlJGP41k0CBOD4d0iE49dBHuAKZ8ese3rPprjE
	 1ADiWpYmM9uBNWZiDhL4ULFI3Wm5sgqv3jfZYX39l2Ua4VHc+vPFvsgdfgP7roHxeBg5k
	 DyXJ7OJ6SACMN0v0ikKgIEeGYsycVYKAahTIEFbDjdLcB9F/jzEnWHBlxVVMx4vp9szj7
	 6svCnsmAXmAPwgWOdffO6+nKeLQBpRcBURxdBpJFiMxy5n0PUCrEw8/ib2Knzjo+1BA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788892335;
	bh=l0CggrwevG1xFJXWU9JWMqvoGtAQryeGoT9XLBo0uuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPefloCT50gmktYuynWjDfQNXcFqldWGZdW3giMndqSOyaCHZcKj6UE0wpdGsUTnq
	 S7MHpJ5XtKMULg/mZ9pymK/+pSmUMKceHeVuNyMe2dHmRjrCS2vbjvN/xdKOW59zhG
	 cJZeg9mROUqSKTyzeDyI/iPY3EkWKqdxsn3IPEYwSOxYKodmkMVvDciXXV9M8KMs7R
	 G+FMxaYifnOrFfph7MOqKvumj9Wn9NOX+Jc+nq+w0xX/lEwpIsof6TYPcKTKLlZLI3
	 5CFm3ksRS6oRzocoSPaPBUj9aWeAEXPEXDT1D6pkt7E8D1qlPNhRkEuIrZpXX8Ib6R
	 jBug0nPWiRjKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDA3E60733;
	Tue,  8 Sep 2026 18:32:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 509CD755
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41C3680C7B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1Gv4L_VZVZB for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 18:32:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 905A980BD4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788892333;
 b=dVX15JSbw3sK7Nmr9jQeJZjgLzGGhUDP/cvNUJVM8v5pffrLaxaoahuBg4ZrvHKIRstX
 XPgq2Cbsx6pVSsHscySILOLGQWREDBHiVmvtwuiCzPpXY+GIhSsDZ4mni/RA0yS4ZM9uj
 gRAr7Dtp49ILn74iV2q0wG2i1XkBq+qJXK0hjxyCR7w07XseJZwoggj/j3IDJFVvYg0gZ
 TYLxdIIkOcsTMOuCp/dyVfNMCN+yoaY7CJkmu4CEDSUingy0NRZzroI0OTZ2z8Ad4F/pk
 g98bbellWGZdPWA5UmfL+FKaWdZ9/GkMq2Bi4tXNntdHjKdWK/vQD8m4vNj4N0XN5aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788892333;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=l0CggrwevG1xFJXWU9JWMqvoGtAQryeGoT9XLBo0uuI=;
 b=MqdzuqhQ6HN8B5x00dmc4W/7cQerleXg2j5L2X1AQUgm9frzp7Fq0bY7B2QZliT8Gx2W
 FPQkWweyURHI76JEORiyzmZwbJSQw9HPC5cMwXPUOH2OCRdFbgI9A8mNA+M410PJFqwt3
 vd0IG4J0zGVzJNTWFpzc0XVKHDlQnxwbZ8E+npT9oWRysODHl5F0Q16GwL7wGxPtfF0ay
 u16H3OM2yVgVz8R/VivB2DSfFMjhhW1zXABT+bOVRHt57QUcIC08h16gXRLN07wWjJCu+
 OizKQxCWeTwpFFTB1akG4VrLbFmrEbWuFJ432WfCGNQHJJF3vBbuvfAMyry+sMHr5ZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=crBidmcr; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=crBidmcr
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 905A980BD4
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 18:32:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD202401DC;
 Tue,  8 Sep 2026 18:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8635D1F00A3A;
 Tue,  8 Sep 2026 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788892331;
 bh=l0CggrwevG1xFJXWU9JWMqvoGtAQryeGoT9XLBo0uuI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=crBidmcrpEcnBr67Ljy1VrLxiB9GDPbc+oVD+aJxu0WBgWe0tftkVIQr09iuviLxT
 5AjjKhYWInCjEnlJ6m/iPoeRccV6tD6azBT6MZh3/QGYhU6d/BdYzKxJAOlf89dgP4
 xGXh3tY9T1LYnMX5SvS1O0ttI6WhL8y/Ihq7HqM7p90/QwRt8CFNxWJh++liFe8IxR
 YVOs16jX3OWQ3emsqekKdjrqSmqFyLMSH2UM219oUtf1ww6Oto+lFY0AMD5ER1rQcd
 2JSzAr49CaPe6HlgxWELVMqIkMwF/FmrpCF+GHd965t5kFXyvnuSNj3Lqfq2fmMJqd
 FI06m+DSNAYVA==
Date: Tue, 8 Sep 2026 19:32:07 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Tieman <henry.w.tieman@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Message-ID: <20260908183207.GE40544@horms.kernel.org>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
 <20260907115221.926007-2-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907115221.926007-2-aaron.ma@canonical.com>
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

On Mon, Sep 07, 2026 at 07:52:21PM +0800, Aaron Ma wrote:
> Flow Director profiles retain handles to generic flow entries. Reset calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
> handles unchanged until replay replaces them.
> 
> If rebuild fails before replay completes, later driver removal follows a
> stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
> 
> The failure is reported as:
> 
>   KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>   RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>   ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
> 
> Clear the Flow Director handles while holding hw->fdir_fltr_lock before
> the hardware tables free their entries. A successful replay installs new
> handles, while a failed rebuild leaves them invalid for later cleanup.
> 
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
>   synchronize with concurrent ethtool filter add/del.

Reviewed-by: Simon Horman <horms@kernel.org>

