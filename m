Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A76FC9833E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 09:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43AC5406E1;
	Mon, 28 Sep 2026 09:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6X39F6XuWTZO; Mon, 28 Sep 2026 09:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA887406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790586961;
	b=c7lp43iY9T1CoBdFXGG6A+5ffj4JojhTCncBOZhkaAjYmH0OSeSKKvUk8y/ydfE2B8Kj
	 c36/SUY92DXRSme7L02G0VassgCxeeHqg5CMwWyzxfvEHbtARxF2kdcex18PuU4em1g7P
	 qaBGkACVnaIZ+vqARoAn0yTouVJOoa5B85Wv6wyK83Ayy90xQiKx5E/RWU4jSg9vBf1aw
	 GlKWvRQ271M7MKsjHftIZDVipmUog4s4C7fqek++avTVEs+ayx0yqKerq1mtu1GuRAI9L
	 UXzzzHcd2o1A1HZBhwE0nlbw33BwFyQMSCAGTsrEaaG50/F3W2w8toLX5FKwPLusRTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790586961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kSzIqxDU2Z4/O/az/Uu82s65RFvMqhh8MlAp8bqUwPE=;
	b=SRaZTNhuvbyrnaOmG39VKIIEFzOl/UQegdyKhafsP+C+17qVhNa9IfrEr0t0iV5+HwTb
	 +8WRO0RmuYwBvxAnSsnVfwCtdAfFy9ThoXCcd0S9cjj56oR9YZWNgRG9YJJh6nTAeeQba
	 gkS0Wj9VPHdRaD7bJsMAhq9mKxol82AdvWygpG5K3tjTF1AsEnA8dE5FseiVEFY4d8Wiv
	 SeyxrjqwMNCOuGvRFZnAr0rsNXbz2z3ERHSU5R00AdIRY7ysprd5n5U/CvTEDwBaImWPi
	 ALhAwEsHFKekIkOgUXTd4L0gV6vWKYJk7c/JKbbMcZWZnzWaSvgKy+uSQCHJ8Yu23uA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790586961;
	bh=kSzIqxDU2Z4/O/az/Uu82s65RFvMqhh8MlAp8bqUwPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6Azww3nVG913a/yaFMWEd/rSoWzab6Z8p/sbgrNDbZNIdVLn0eCmZxfnS/2JpmF0Z
	 dGosr9Jur5wrZ8vzSXMS+Uwtv68PR9sd5ghWGnzRX1KFjDafLTtePk/rXaCCdnoMOX
	 wRKErQ2oENy7s22u5ccVsMyhXI9JS7NoEWyY8TQplJRe/DIRF+uIdb9X8pf7/V0Hx6
	 lukc4vcAupr0kbi24XMrv4+U8s8gQgpJzqx6H4sj+7zU1kHZr39O4FBua4nel8ugwN
	 P2hHu4U/G3Z1taAFw55E6Te3qR/tODJ4Tw40Ma3WZyg8bo+eF5CS8Gij/bxB2bJpkP
	 WDxXxhFTaWxww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA887406E6;
	Mon, 28 Sep 2026 09:16:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 125E124E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 09:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC53380DDB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 09:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaj6p2Vdc2bS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 09:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4847C80DD8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790586959;
 b=jP8gJHcGGh+JoImlPUGSUNHQqwRNDDei5SZFfao8rJkWytGLFRBj0Layse60FDTtBB2i
 JsRp+gfpl7mN4LNcQLlCpuv6bVuq3gRZdybv1sH/ozwnsULY8Kr6kUiQ/oA14PV8TZ43M
 JUfEMgEcVUITtsVmWk+VMgNQa7e5bhmqcDD65u5eq7Ow/cdh7HnhVarUh3ID/5RZurDfA
 8ktEDOGPAuFMZUcbcVSwKr4naMV+MtNgCRKqw81sIh2EVPMRhjA96/LcHqdjkfwHvrZNS
 IdVrLrm2jsxJeOXAx30QD0NdavnI46H8dNPSifDLl8Oh4CPfMaVtGlXZLDMko88976g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790586959;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=kSzIqxDU2Z4/O/az/Uu82s65RFvMqhh8MlAp8bqUwPE=;
 b=msmu61Yc/6ZIFS4nttvqJ2DBtzctg2ufJ5mr/rxPJ27t+QURyNiq606fM+FosXSJpcfs
 oegi0658AzZVUkhrL6ATi2Ojh9h7nMBhofWvvhvKzqi/jmjhtCahsLVuaeXHSIHlFqCx9
 2HtIpJDejPx3m8LVh3eDTr62DQkHaVkQNrVNPxb5w5HVyzYhH2IpJhmj6KYq0VyVptrKR
 TFbycioXS9RsH6WeFDvWzLLXXC2ZsHzQD6UTWIje2VlXJIBDYy8rCtQc7XmumFzeXnoGW
 PTYheTqr5cF1gEbSq5PSEcT5C36PPvHiH5AIM0FG25eFanooNKtOoDuOaTFcpadM7CA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ljpQiG5P; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ljpQiG5P
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4847C80DD8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 09:15:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 590E560052;
 Mon, 28 Sep 2026 09:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566101F000FF;
 Mon, 28 Sep 2026 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790586957;
 bh=kSzIqxDU2Z4/O/az/Uu82s65RFvMqhh8MlAp8bqUwPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ljpQiG5P227/LcY7idizoYLptGbyQgKSFUC8/2oATpP46sCxkyyiRZO+xBsfikhis
 wHhMaRx2n1sARJHUW5/G4R6prUcGQHvYGrw0yQd2RcG9bqu9e4OcM6OiFloxbNKYRK
 hIHOtNF99l1wcmgq+m14bpB1LuoOAC0EUzG+P4T7A3id3/jKcucFyFl3veZg9PForS
 eWQmq5NDyU4Y7fwKCaC80kiXyVSxNRER0amoFDf7IvyC+h9qF3riQVMYmYwH67SWy5
 HARXCmqAjZ2+Xa4nV8m3goX8w84KTf1HELKMzcl7e74VyIqb7Jjc6seRq8/bQs7e3e
 GYfm/3YK30Vlg==
Date: Mon, 28 Sep 2026 10:15:51 +0100
From: Simon Horman <horms@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Message-ID: <20260928091551.GK13925@horms.kernel.org>
References: <20260923234819.702327-1-oss.patchbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923234819.702327-1-oss.patchbox@gmail.com>
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

On Wed, Sep 23, 2026 at 07:48:06PM -0400, Yuho Choi wrote:
> idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
> calling request_irq(). On success, the name is released later through
> kfree(free_irq()), but when request_irq() fails, the error path only
> unwinds the previous vectors and the name for the failed one is leaked.
> 
> Free the allocated name on the request_irq() failure path, as done for
> the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name leak
> on request failure").
> 
> Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")

I don't believe that commit introduced this problem.

> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 defconfig + CONFIG_IDPF=m, W=1).
> 
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 4311ffa30bb1..e7d5e7923371 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4073,6 +4073,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
>  		if (err) {
>  			netdev_err(vport->netdev,
>  				   "Request_irq failed, error: %d\n", err);
> +			kfree(name);

name is allocated by kasprintf() which is a wrapper around kvasprintf_const().
And kvasprintf_const() documents that it's return value should be freed
using kfree_const(). I don't think it will make any run-time difference
here, but perhaps it would be best to follow that convention.

Also, for completeness, shouldn't there be error handling for the case
where the allocation of name fails?

>  			goto free_q_irqs;
>  		}
