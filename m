Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C8C5DF94
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 11:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C654380B28;
	Mon, 24 Aug 2026 11:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rG_4i32cuvw; Mon, 24 Aug 2026 11:08:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787569724;
	bh=Le5WmkAN4u0IGX86Dtsiq5E/X6/dEQq9bQyFCSqFyPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rwSZuZrJorxi8Udop3SCfoyOzSWJqMGMeBHzcfV73XSz7YHyEdNL2UBEGdhOXxlDz
	 2nUaxz1VP/suR+O+MKyJT+xy48Ftp7JdPwnd3lnwSu0pda/e6OVJs18aFzTv6Aq+2q
	 J+nM8LxIWV7y1gzkQ1vvK8ZhXycRnMqwxu0lQUezVyrWbMn28B0hXsVkx5EWS/zopq
	 sxVXSO7j5YpIS/dgDctxomiTVoy5K2K7Ro47Ej5xkNqMdipvA57oII/vsaTzA3VBK7
	 kYVYHiTQE9zCW79wWC+nhNaWzxAWxgzX9iJ3m1PuFeQHqoIEduFpWZOBITqIq2G9r/
	 KlfQLJSTvpLXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C518C80B19;
	Mon, 24 Aug 2026 11:08:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C57AC3DA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 11:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7CE740077
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 11:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l4e-hKV4iU5y for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 11:08:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XEgiaHjX
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACEE040042
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 11:08:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E1D9A403ED;
 Mon, 24 Aug 2026 11:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4411F000E9;
 Mon, 24 Aug 2026 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787569721;
 bh=Le5WmkAN4u0IGX86Dtsiq5E/X6/dEQq9bQyFCSqFyPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XEgiaHjXxppXUG2pPcxKCT3GnPMBcvbqiKOl2ajhiOEZgjhE1aZKTQJfzT1D4POpX
 bZXR9lyoN8BBqfheSbsp0CobKK5Kgo33hNBc0LzXw+XtVmAZU2vbRvu2mhuu0Pg2Kf
 N0lxJ6c2Xoo0+QT0IJP3J9P3GmG8kL0Uoi7muj/njCi7avpyEcuOoEPIyqSuOogHJa
 4f8CdDRPavxiWFeudXz5OfEc+82JPhLWiEsS18Ow3C0A2MTx1pOh5wCqGDyLr+urB/
 mGKXpDqWulMGLEEA6UQd1DlO+upHz76RJ6IvJUsw2P6N496LOMkamfebPufuO+VSrZ
 np2eUtL5/k5WQ==
Date: Mon, 24 Aug 2026 12:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Message-ID: <20260824110838.GP265046@horms.kernel.org>
References: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
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

On Thu, Aug 20, 2026 at 01:43:14PM +0200, Aleksandr Loktionov wrote:
> ice_rt_ho_set() uses the HO register as the starting offset of an
> ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
> be advanced by user-controlled data reachable through
> ice_parse_raw_rss_pattern() -> ice_parser_run() ->
> ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
> VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
> size of pkt_buf.
> 
> Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
> be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
> so it stays correct if the packet buffer layout changes.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser_rt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> index 3995d66..bfdb50b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> @@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
>  
>  static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
>  {
> +	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
> +	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
>  	rt->gpr[ICE_GPR_HO_IDX] = ho;
>  	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
>  }

Hi,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/20260820114314.646344-1-aleksandr.loktionov%40intel.com

The first item flagged there seems of concern
and I am wondering if you could respond to it.

  Does this new clamp introduce an infinite loop?

  In ice_parser_rt_execute(), the loop termination condition is:

      if (rt->gpr[ICE_GPR_HO_IDX] >= rt->pkt_len) {
          break;
      }

  If a guest VM VF submits a raw RSS pattern with a pkt_len greater than 504
  bytes, ice_parser_rt_pktbuf_set() saves that unclamped length directly into
  rt->pkt_len (e.g., 1024).

  With this patch, the HO register is capped at 488 (sizeof(rt->pkt_buf) -
  ICE_GPR_HV_SIZE). Since 488 will never be greater than or equal to 1024,
  can this cause the parser to loop indefinitely if the state machine
  processes a repetitive sequence?
