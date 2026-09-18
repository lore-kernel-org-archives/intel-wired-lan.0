Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B311AC982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 781A240BA1;
	Fri, 18 Sep 2026 15:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkkKAZfdmD9M; Fri, 18 Sep 2026 15:13:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E4AEF40B77
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789744383;
	b=TNGP1HYoDY5NVLn6Qts+j+Xrfi/R3wrWgtlAaaWnetN8EIC7lDUA6PT5/tjoqjzNtbBr
	 cNwJzngQMo5HdRWqAHPpZg+4LxBRVHHzGOjoS3Eejfr8Fn4blDc03Vg+lLDduh/x0+hk2
	 +gqFrUVUalGObV5ptqHTZKboiWky+JPDF8VAxpn0NXaeKNu65puO7K5aUx5RQU8SbevmZ
	 +MQTG2hovTDsq8tJ8AJ3JWqss00Q2SFCy4DFFPJ/qANaYL6qe05OBEUD//GsUtdo2mKtJ
	 ZJiEv5h/N82GGf+GaKASciTjegtqHQcQ01PmMhJJ8xr9F9Eg2gX2NgNef+aWIunhRJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789744383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7JuQi8XVapmXzyrEu95EKW/BozLvbkCfRHxSj1WN/DY=;
	b=OFq/XdbOwfHSqBX77oLh7zNF9Duq3G4FAZLj0fVbdlos3fKZaKf7O9JMNF4/8pVSaWSq
	 CtWtSEQxGdkmJb/isyTMnZi/MgRA6n0WDcjMMJ+zVJ5UUjGwj08u79rsc02vZlG894wF+
	 OuYDSxqKR0M4hiCCjaz/tPjvQneGp0Tt0v1EWlY2j2RUdvYOR5JZGiFMymtlaZhhlq8y6
	 qcRjB54wzNQICy3QSoSDkxVK763dwvMRvKQEhuWLKgfzQDPMRws/55FbgKtBMRjrA7Mxc
	 0MEVG5MZHmnvSDGZOebauPNj6hL5RstczT2Ln7OEHQd6/g18Wqe4b1OZf3/gqsqQ4hA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA5iQ8Z4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789744382;
	bh=7JuQi8XVapmXzyrEu95EKW/BozLvbkCfRHxSj1WN/DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNgSrrDzNQTVIaEd5piT8pDGr+agwnoe3l0by+FQ7cljzmdJ8dGQhuuggPP4D47DH
	 DTopljs+DZ2UVMNsIEDavX+4xed12qgXAfwYZ8aaCHxKWsP4E7qw4auyGy1rIapSb8
	 dVJIb+aRQ5Ks7g1PGiXnszIoGNqK8JU0rpW+o8fgaJt52mpQosgDzYAKAUow2NkhEM
	 j8r9waGWvTxN1WelBPw2fwSl7HTC4Rn8UDt3L5SyzQybtpYAUHDeqUlsDKyamf3Rf6
	 /FDTKgRXzXiJyrVg59rMOJHW6x2zVZ1DqelDNBJi9qw+y6ucso9e+Zvbw/VBigXeGl
	 Seifj05OeYuAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4AEF40B77;
	Fri, 18 Sep 2026 15:13:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB9F142D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D04DD40B6E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hl40ZepAe0ST for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:13:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B1CF40B6A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789744381;
 b=TlK2oijm13hpq08tpEKOYpJqCaEkWabXZARgC9KjfOZDY5YpPBZdHbsXNxpLVdcEty4D
 B0vM2ag3Brbw9vYttO+GTA+Kn+biKc1iTAmCn5Wj/gem3xbepsdGmSyv8jiFhbar+u7wL
 TS+NT1QJNr+VL+cVeaTcsDpCy3JrOlZhfac49SqFW5mN1wClaJideZyMjNO6xNnI6CmzY
 PcOv+TGLAgIa76Ys/dSn+TXLw68KHlI4kCBplbUmOCJ/80mILvCnk4ijvPl70k667xyOf
 Uz9TQTlcEEczMeScNqp3kNSk1OQNvLdfxjpWEXSyZOXWiFBfU91uURF5Ko0S0wwRG2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789744381;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=7JuQi8XVapmXzyrEu95EKW/BozLvbkCfRHxSj1WN/DY=;
 b=Yzwzll19DdspFQKy538rs9VbvEzl3Qd+jvfdWm70tLcJCr2kAJfr9sTHV5z38/dI1Idq
 DJlwoTJIvYFNhJ1GpQ2c/TIachZRAFUIQ34a8quIlTo1QFYW6AQHJr3dBigjXBq/Anj0y
 UMBwpLzVNk6pRSQDIMRjVaDTTMaZijPEjv3KrtxOPv4WMvQCLDnzUJg0uAysg3vAuAj4V
 SJwp+V9r32OPJ7XiSdVlQ3DE03nNs3mmHfHkzJhE8UxeClC1qgbdYlJcq5wXCXQfbD4sg
 hzxGTo0zoZRsXWD4OC45T5iyNTQ+DmN83hPLX+Js5WoEPlKP1T+7c53aO/MnVEXxtjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TA5iQ8Z4; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=TA5iQ8Z4
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B1CF40B6A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:13:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E657B601EF;
 Fri, 18 Sep 2026 15:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA2C1F000FF;
 Fri, 18 Sep 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789744379;
 bh=7JuQi8XVapmXzyrEu95EKW/BozLvbkCfRHxSj1WN/DY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TA5iQ8Z4hCP5RAOqfpXSeQAgUVOqN1vr7DdPtDXihQy/UcW7ZhGzh2aQDgQ3l+Tid
 2XNvYr+jgVnHHHEHm+L+MOJ5kWDpQ/9TBcfFSLhkCCWqfz2uhKUQY5gWdrNmj40OAC
 d7CRrF8DlzhJ2Npw0zdtYQwnWW4+l1/AHfA7wZGP3QOLLWYD1QqoDtNWMh460H/jhS
 MiOWr3cPbyh5icDRVVnPLG+vG0wNOzZnClzvKEnEKcRYFLfM30+ygbecy6RLIGw/dg
 ZdqEAPyfFghFHYlRnkv3+RSxwDZlLlPWmJfELGEovu44pZxcHzq0WTslcf/hJiuMsE
 +QmA79ogRUmFQ==
Date: Fri, 18 Sep 2026 16:12:55 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Avinash Dayanand <avinash.dayanand@intel.com>
Subject: Re: [PATCH iwl-net v2 4/5] iavf: fix TC boundary check in
 iavf_handle_tclass
Message-ID: <20260918151255.GN51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-5-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:50PM +0200, Aleksandr Loktionov wrote:
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> The condition 'tc < adapter->num_tc' only gates the destination-port
> check for in-range TCs; when tc is out of range (tc >= num_tc) the if
> body is skipped entirely and the function falls through to
> VIRTCHNL_ACTION_TC_REDIRECT and returns 0, silently steering traffic to
> a non-existent traffic class instead of rejecting the request.
> 
> Simply flipping the comparison to 'tc > adapter->num_tc' does not fix
> this: it would let every in-range, non-zero tc (tc <= num_tc) skip the
> destination-port requirement entirely, while an out-of-range tc with a
> destination port set would still fall through and return 0.
> 
> Fix this by explicitly rejecting tc >= adapter->num_tc with -EINVAL,
> and only then requiring a destination port for the remaining in-range,
> non-zero TCs.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
