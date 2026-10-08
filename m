Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C20ECA6011
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C51540312;
	Thu,  8 Oct 2026 18:32:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oBSu0HcYljy5; Thu,  8 Oct 2026 18:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 87FE1404A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791484343;
	b=dv6eXULiFUyf6pFytIERTRP4ux1RT5eV2CInXyRJ3Py7SRgRpI6Y8tui7x7SRCCLgyeV
	 4l02E+pcndCEdaQC/F+kVHqLb3N7p8dxKxBbJptE0/S49bTmLNgcDx255SQ7ZxtQIEmYl
	 uPu8mMYr9HBR4Xbf1b3udGJs814MYu1W2Yc9Hx485bKXuVhe5Rmuxym1v85GKKP14xtFJ
	 5tK33bNY3nKKeiznu9uFWBXEwBQ6z0RlC1Nc2DJ2P/zbC/k2DY4SfwwZyCNIlOKhXimRY
	 fuidSAlYrKfGzHhKqUG4cythj3bzUtzQSxYQQtRnxkFA41B4omS+lyfjaCtBTPXPoAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791484343;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yVP7nsKdhF71GwWHA3GbXkemcPwhdJ4dqV5UW32uEtI=;
	b=espjlGhblJ7umsQKKzJysHhLcZ5M/hLoPxF4wQvKqDDGRm16xEY3ndPyXblmB5nv2l9o
	 M7aqOv59Vf8OwJzdBH51xc9uW6IGbpcBr4DpVcPzx6AgUxNqnVk7XjGhZzPdf4C5ZCbP5
	 7IXQbfsjiE6xZc6SqQWRy7d6nf4LUBsPCFioCPUm5Uc1/Tt726P9fSNTfCvkvi/+V5zVk
	 c8nTTuSSGVjCgGcrKtu2FTuJQuCl3ZIkro6JQHss7rD6uL6HCnCoKrU7TCPhhJ0/39tPP
	 l0BrmjlYh6RLFAkl4R1Fg5ySSfLklkQPesLhpVlK26PS1EU8zDPhTaLdrs9rNsFG/FQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=D08YY8lU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791484343;
	bh=yVP7nsKdhF71GwWHA3GbXkemcPwhdJ4dqV5UW32uEtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VieBu+dZu9ILjPIX4FW9JME+i9H6WygRvWkjblIs7Zp+0+PyYT/OkmHfL4xpTRhMC
	 9/c7LBDCILQ1ZxgcZehnAfh9td2E2J5NtizFDOrY9SgrcOCIdezHHw3J1H28VLmS9E
	 P3lWkCsSawecYrs15t7Q0Gjazy9MX5YZUSPcHymPa/X8tJrXdj/RW9R99BpOT7HKfS
	 dJ438XH3VvUImyNChJwukNsEF+6cGH9fEkBel8wFJTjprzJ7yvsWbxfyhyeSHFfjOP
	 IorSpPDDD1rK9KdaExpuV6Vu5yVmCxXx/FXlzfBdhnEXOxybtM1GQ8BnA4P/qvssVr
	 W52EwT+QNmuOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87FE1404A2;
	Thu,  8 Oct 2026 18:32:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 156D1338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E6B1402EA
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VP_cYxV5okFo for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:32:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3D0940906
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791484338;
 b=HPLYxeliQe7puzaxuBY/jrbFJ1WBcK1v5iLrOMN1VtP5fNpfGfwXMXQM0NFdWIQr+NHj
 s053PYiHJEzYlu2ENoelRQTuzQy7a+r0N3vRqiy/XmQDXlmH6ZAwks8JtVLnTeHvqJops
 gD34fLFLdIUNYqtkHk/AD4Imoej78jIRwVIH0sblk+KBz/qmTYVGsEbsS5ik3X7Ftr9wy
 fgFU8wldBoQWOqhvPT3dKACnOoaxNmiUATnIgsVvTD3Fgl3+CCejtsHROf9JE2LTgrn0X
 e4A+LwelBv9P8n8fr+ofOTy0nZQSA6ZwG7zR4ztf+vbc+FpNsJ+zSW5pNzQsxWvG/qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791484338;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=yVP7nsKdhF71GwWHA3GbXkemcPwhdJ4dqV5UW32uEtI=;
 b=oaLV6MkBkMvC0jV6NbtkhRzQG0lzpZVRDtTLfJ+DxqOwICKqaKDLzFtBFrRo0HdTT6kA
 kRVMxnfn/pUpoe5sId2PEkRYE9l4vQK8mwoJWvQfpZDz/6RVcNvN1Y8vY/zhxLDzIXU1/
 9lTU1AHES4zEHAfsGJ9VyVXCvdg1WLanLRWKlgh1Arr+EPjSPbUiqRtVIOUz0LqaLmu5U
 FYOqOpA2wHmXi/R9CLXPhSPhJAaNyLcdl9tbyr96UzcbxpErsZjc7zSMjP/IVdBqYq7BE
 Oo7SdHice00vP2fL95wzpEJvPwSf1bwzrFq3MJi+iouZBQwfOY1LwD0u2pt8DRnq/9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=molgen.mpg.de;
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=D08YY8lU; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=D08YY8lU
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3D0940906
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:32:17 +0000 (UTC)
Received: from [192.168.0.150] (ip-095-090-241-211.vkd79.pools.vodafone-ip.de
 [95.90.241.211])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 04E314C442F941;
 Thu, 08 Oct 2026 20:31:37 +0200 (CEST)
Message-ID: <07ee6c66-034d-4cea-bce9-91c63a1aea86@molgen.mpg.de>
Date: Thu, 8 Oct 2026 20:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
To: Brian Vazquez <brianvv@google.com>,
 Brian Vazquez <brianvv.kernel@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 linux-kernel@vger.kernel.org, David Decotigny <decot@google.com>,
 Li Li <boolli@google.com>, Emil Tantilov <emil.s.tantilov@intel.com>
References: <20261008173334.2881475-1-brianvv@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1791484297; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=yVP7nsKdhF71GwWHA3GbXkemcPwhdJ4dqV5UW32uEtI=; 
 b=D08YY8lU1Jh4VjomGE1Py45b4kGOPmalwHrDgeqM0me/JLsVy00EsMZ3eNOpyae2N5HmBetyHo0N
 WqQESdogj92USlgSlHjmoaFCIVgQ6B8ydEi4WLqStyidIvxqj+Bu0xbN3Z+r+vlX6aOczm8SYrgk0n
 IKCa5KJ6425UC3ihFkTUAvMC1dChKVO/hhljARB13/c2UOs6CheAK8HoRPO2g/yhoLI/+UgcQVwNxo
 Oauw+K+4KZWIl2r/OdO+g6GgFzeV6ATHTXw6nggF9F8YIUSWxUavePbEoQtDe1PWY2H1uZJBiLi2pB
 S8dB6JCKVAkfh9G4kM9Dlm1cM6KiFvKg==
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

Dear Brian,


Thank you for your patch.

Am 08.10.26 um 19:33 schrieb Brian Vazquez:
> PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> function reset progress as a 2-bit state, not a flag:
> 
>    00b - reset in progress
>    01b - reset completed, written by the control plane
>    10b - function active, written by the control plane once the function
>          has completed VIRTCHNL2_OP_VERSION
>    11b - reserved

For me it’d be helpful if you mentioned the datasheet.

> idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
> rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
> although only 01b carries that meaning.
> 
> That only works if hardware moves the field to 00b as soon as the reset
> is triggered. On the devices tested it does not: PFSWR transitions
> PFR_STATE to 00b only when the field currently reads 01b. When the
> function is active (10b) the field keeps its value until the control
> plane finishes the reset and writes 01b, which takes a few hundred
> milliseconds.

Please mention the device, so it’s easier to reproduce. Also, the 
command to trigger the reset.

> Consequently, on a hard reset of an active function
> (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> reset is still being processed. The control plane tears the mailbox
> down underneath it, VERSION is never answered, and the driver sits in a
> 60 second virtchnl timeout (-ETIME) before going through a second hard
> reset which then succeeds.
> 
> Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> This is the stricter reading of the register definition and it does not
> depend on how the field got to its current value: functions that are
> still in progress (00b) or active (10b) keep polling until the control
> plane reports completion.
> 
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c844c..ce8a1bd0ec8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
>   	spinlock_t stats_lock;
>   };
>   
> +#define IDPF_RSTAT_COMPLETE		0x01
> +
>   /**
>    * struct idpf_reset_reg - Reset register offsets/masks
>    * @rstat: Reset status register
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2c148377540c..a827e0fa67c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
>   		 * register for us yet and 0xFFFFFFFF is not a valid value for
>   		 * the register, so treat that as invalid.
>   		 */
> -		if (reg_val != 0xFFFFFFFF && (reg_val & reset_reg->rstat_m))
> +		if (reg_val != 0xFFFFFFFF &&
> +		    (reg_val & reset_reg->rstat_m) == IDPF_RSTAT_COMPLETE)
>   			return 0;
>   
>   		usleep_range(5000, 10000);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
