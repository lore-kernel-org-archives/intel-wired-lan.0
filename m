Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3988FC56205
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 15:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6E5560763;
	Thu,  6 Aug 2026 15:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w87e-N9yVVjS; Thu,  6 Aug 2026 15:25:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 260BF607C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786029921;
	bh=GfbG1Rpbowvh+M7HemGorHD/Gmp98Ye7EdAOCnhIrW8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1WyU/l84m6KgWQg0LNhZ9wAtCk964XAtOIgb+9/8JysVO8BVPYZzU0OZKBurYfGbO
	 LvRHrnnLrkKg4i+aNcN1LcJbveObxWg9Tf6WZ/p1MN+/ojfIShU0ehE4UDlmWuJBBe
	 QSmB50uhukUfDsiBbcpM9KeLYdSEC5rYtsEji++/d0ubDa7N7PvOYZwB9gygJ+Hq0F
	 RmTL4Q2HXVnWtTrLj7xOeZl+tYDrhspD+fDis6EA48TyBQDcVxfCAlOQKwqec6jjac
	 BtIKyY9zkbSBoHy8Xln4+ewj8Z6N0f202uzWxf7mrj4ZPvIVH5liRSyub4bnFL0/CL
	 E6sObiSx7oL7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 260BF607C5;
	Thu,  6 Aug 2026 15:25:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7491A392
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B3BC607C5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ezXGCWfZZFQp for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 15:25:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 43A4B60763
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43A4B60763
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43A4B60763
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 15:25:19 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-821106b5b64so21922697b3.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 08:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786029918; x=1786634718;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GfbG1Rpbowvh+M7HemGorHD/Gmp98Ye7EdAOCnhIrW8=;
 b=iyzjPCHJg1NK2YHGKAJKcuCeDO5sl0/TSXakedrTKA8/Jn+fDLFSQtYvRWnK9brjSI
 4xbaYPK449Pjc9kK3GSpKRoT+wJTB2dMxaftdPu3h0H+CirRSNKD7Gi+FQkctmaZUdqa
 whORTE3qESIA1uYeW5Fa3wjaSU7hy3NqDFQgCVmAQdMNX4HSWSZ6I7ySLkkLv4DpAMKP
 AytEi0Koxnbk/i5yg10/ZEG8j0JW1bFtkA2+iaOhdKXNyKYMM7I3IhZWlhfbOYC9b5oN
 VJpBsJLYdTIT6frptdLQSmJwbtI6rgI9cXHbtG7xCjSQemkBxhK8scDCUFokeQ3sPTBY
 89lg==
X-Gm-Message-State: AOJu0YyrFpTC0ITYkTfXZzyje3BWykWJVIHN+K7DaT0Dp4wxSXB6lPQh
 HHpNgjr1Out3AqzFWyWL7PXMMcrdBsqB6lgYdd9F0TLSds2gTiwQdROy
X-Gm-Gg: AR+sD121GeFgvgFtk7l5HvtUI1lEaeSk4iE3arC/T6Qgrr4ZF4AzeHwJI9dANKmCrex
 9kx3/gy45KyagK3JR7yBbi2A7tlFCRpINeDljBAImbZPAatHjCDs0hLhK8NTzpXk64W3Wktkf9b
 Yd52QiH1/vzITR1WgBsnxGbjrXqA/zhSfN3nO5QEQQUV9Xk4+2Y2QzXHbPRNWzo/oc3NYFTglDu
 4izTRvQpcPdGiim3RwYzSl9zGkbONrccT1THau+GmUc6e9oXT345Ja/SxhoJVJOK2lMBXOF1HM6
 lsg3JaVNvEBCQ6fn/rp1WHgsIDM7WSecLUhnP0vv9QMtmiD2bRzyDvIVBLYUYEn4WjR74C4+haa
 B5AV7zH3Le/gVG/gqDLHh45JnHfobReeEGpr0H1jZOwFvfpsWrWfnvhzVyK3aN30KTuJmEEsyFX
 vsjAMWM7vanSPRqwxnzUxazboQdF9V3oOTMsjs1M9qQ++yc6wRdHgpcLBKp27Q1gQJ4FD7VighB
 E1q6RepmxCSNTlDPcz3Ypq3Y0kQPwJEht8h6ztNkHiWH8yh
X-Received: by 2002:a05:690c:6106:b0:820:122b:c3d2 with SMTP id
 00721157ae682-8213bf4d2f5mr30764887b3.11.1786029917833; 
 Thu, 06 Aug 2026 08:25:17 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8210f9f94b1sm22099257b3.22.2026.08.06.08.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 08:25:17 -0700 (PDT)
Date: Thu, 06 Aug 2026 11:25:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.102a89fcf35b5@gmail.com>
In-Reply-To: <2c551a5e-22f3-42c7-a6ef-daf246e57cc5@linux.intel.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
 <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
 <willemdebruijn.kernel.35c676937c974@gmail.com>
 <2c551a5e-22f3-42c7-a6ef-daf246e57cc5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786029918; x=1786634718; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GfbG1Rpbowvh+M7HemGorHD/Gmp98Ye7EdAOCnhIrW8=;
 b=G/qGOx+ucGUSYdiRZMlZQ6gq1Ypc11DxK+SVG6c6kEEjw1TNU54tQIoWDzkdiPl2FI
 39dhlspCuYIf06u7s3LR0DNpaRJk4cjPnu3hH4hKuwmC1fe8sD6p6C3fJHqsO7jx5uzk
 +MHHncpTzJnvqiY4DZV5CoRayQOmycSuS7xqqru1tFNVxyguRrxv2MnNnXSSbZO0A/5L
 z2jpz4N1FP7iGZ4T274bGUsXvG+cuVBIALJi6vjT6dlzcwPOVLgzVjV84O8tLjbakWOZ
 SlkOhuOqOlYvZqVkP3Z/yuMOexFbs5Zd7saqtWxk9+7gSXMd4jK4D/Uk+yJjA4nWFlqz
 KFmg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=G/qGOx+u
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
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

Marcin Szycik wrote:
> 
> 
> On 06/08/2026 16:19, Willem de Bruijn wrote:
> > Marcin Szycik wrote:
> >>
> >>
> >> On 03/08/2026 23:06, Willem de Bruijn wrote:
> >>> From: Willem de Bruijn <willemb@google.com>
> >>>
> >>> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> >>> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> >>> field in a single operation.
> >>>
> >>> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> >>> __le32 to ensure the fields are written correctly also on big endian
> >>> platforms.
> >>>
> >>> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> >>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> >>> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >>>
> >>> ---
> >>>
> >>> Changes
> >>>   v1 -> v2
> >>>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
> >>>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
> >>> ---
> >>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> index c724d429a7aa..91ca75e45463 100644
> >>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> >>>  				    struct idpf_tx_splitq_params *params,
> >>>  				    u16 td_cmd, u16 size)
> >>>  {
> >>> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> >>> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> >>
> >> While it technically works, I find it unreadable. Looking at this line
> >> without reading commit msg, it looks like a bug where a 4-byte value is
> >> written to u8 field. The intent to zero an adjacent, unrelated field is
> >> not clear. Consider assigning these 4 fields manually, or adding a
> >> comment/function doc.
> > 
> > This is a bug fix, which generally should be the smallest surgical
> > change only.
> 
> Agreed.
> > That said, I do agree on the style, and a follow-up for net-next will
> > clean that up too:
> > 
> > 	@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> > 					    struct idpf_tx_splitq_params *params,
> > 					    u16 td_cmd, u16 size)
> > 	 {
> > 	-       *(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> > 	+       desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> > 	+
> > 	+       desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
> > 	+       desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
> > 	+       desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
> > 
> > The fix is queued. If there is consensus, I can respin. But given that
> > we will clean this up in net-next properly, my preference is to keep
> > the minimal fix as is.
> 
> I'm fine with this.

Great.

> Was the cleanup patch already posted to next?

Not yet. I'll try to send the series later today.

It will have a (trivial) conflict with this line. But I will likely
need to respin again, so don't want t wait for that (and the merge
window).
