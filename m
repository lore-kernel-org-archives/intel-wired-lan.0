Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB79C56208
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 14:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A2580E06;
	Thu,  6 Aug 2026 14:19:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jh8ukqfKp-49; Thu,  6 Aug 2026 14:19:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAB6680E01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786025971;
	bh=U6AiC35sShnPlOFQ9Pp15i1soMotoG1ABTLtkAnLaiY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=krC9dCKK4fpcfKGZQWhrt0G94Q++hQoi2WUZU1eOz60w19DeKU3K4Nt+mieEznHII
	 oHlAZYqw143faIMkairDMeS2WZ/NDhpLuJm+Ydb1jUsx32Me0awkOwyotaozg2n3Vn
	 v9czmUJI2+9Bmp9bzDASBw+tdRb7IUMMoh4gU9FMXwxCHkcRhwQ/lnhb4tqk8dcK1e
	 sRXrdyIREoOxCDYOjoZIGfYbcW5k71TsSgA7k0Uizbs0KG4RJ/pDujB96+T7n0Tz/I
	 +KJAgRHS9E/rk0M50S+wOsdBOxoE/9LOQV/96mnOYNybg6cDS6qkgZ+Yme/hQeCwK1
	 gRKbBbRon7Hkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAB6680E01;
	Thu,  6 Aug 2026 14:19:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0341028C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00FA0606C6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUkGU86ANA2U for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 14:19:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D85F6066C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D85F6066C
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D85F6066C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:19:29 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8228ed0081fso3496587b3.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 07:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786025968; x=1786630768;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U6AiC35sShnPlOFQ9Pp15i1soMotoG1ABTLtkAnLaiY=;
 b=HKfPv/54/q9AtqxMXQ768p4VGZf2VwHxDqgSu8GIrJ8G4ibITTXC67d+E+hehaPcBt
 ks507DZamGbS587h5oiUEnOPUDvhcJGFWSD++5Je/IRM8n4hr9BM3/6F3YQJ+lr4Pf+u
 Z2vpIp+DLkPTYJQ35Olf2EyEHecYzetHCmXql3+DG0psGseWESQBt76915FPPQugJbCp
 matemhhbKBJtl3HjmOLRJslApkV2R1MXLH/wzGkDHca6ublTP651BnrE/kpRiH401AwF
 j5hyRx9mvy8dR95YsRA0q3PFlNfrDMpgH2MG7tB0zllzQkpsmgCGS5IHTekpRIZamP+7
 mWdg==
X-Gm-Message-State: AOJu0YxJ43r0xnd1YYKf/HWw/q8BBGQvSgUvdhCrSsi0VMkbx6lbatqd
 OAohzpYMaVZluEeyPLcLmUHraslT/Nn5MOZUcFnVHR2jwlkBtLuKI3V/
X-Gm-Gg: AR+sD11rl7TC11T4SweLiOZ5DjVfj76zhgBXOFZpMR8ZhmwwJgJ5pnawZEHyJ1niLGB
 w0VWvnmPA/9OXAtFV9NPBWqVHAq7GhKQGf0PvnO6j8INkkGQZr0m8WN8Hin4qoywQhFD/l7hX9n
 xErQCtuD+4rRUe5a0UuWNxNFXHczAeJhWQcU5Dzp9pptYxKqEYkP9F+1vYFwByYVA7DmkfGMzrt
 rNk0IggipfDfxIW2wPKY//9lgDUEdPWUXVjF4ZwnmawR2cnum0iWb9PjDVw24S9ekWNMVP/z9ly
 SFbKle7Gr7cjep1zrfrglYzgTdw7Srm9xVv5lsjBR3NfC3HbLJs0XW9NRl6ywZ6g/PbOXeWOxiu
 NXhSYl1QLoHdP4Z3z98CHtT6x/MIyzSKCUcpyPK764B0CotK3aW4hcBXR4034EfZkcgkb0BBDqS
 EUis/1rWUI1opB7c/0sqOP2V20WeWWLGRkEItFhIBly3Ml/f1lbCwVX1oYLVqul24PiaPQVTH8B
 z5qBbvlh8kLvaLVKaxQpK+nCPKIi33VqoZF
X-Received: by 2002:a05:690c:498e:b0:81e:6cd1:5322 with SMTP id
 00721157ae682-820224a7cc1mr93970097b3.20.1786025968063; 
 Thu, 06 Aug 2026 07:19:28 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-820134d8ed2sm40002997b3.45.2026.08.06.07.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 07:19:27 -0700 (PDT)
Date: Thu, 06 Aug 2026 10:19:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.35c676937c974@gmail.com>
In-Reply-To: <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
 <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786025968; x=1786630768; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U6AiC35sShnPlOFQ9Pp15i1soMotoG1ABTLtkAnLaiY=;
 b=EZXUQOIOT4TqudHLYyVMd60ehc29vGkArTT8/Ln5ptAZrbeUd2ydXvIDn5UAg6Vk9D
 9PuF6R24YyBgWx7WM7w14MdJs5I2PBSePnYIu9zS4DrpuAXqi5kwDsbuf0hZtZdiEvG0
 UxFDcks/ozEstH524aG1l0yk6dOX05niJze5Ti5rXS4qQUHpdZ8x6VeFVlzHx08FyQE6
 9DANmhGlFJVw+1pk7+Dj2+8cVpB30vmHxevdzV1QmHdged0nGb8maNYpO+/WHn1OtLbk
 H9cGXIuw5z2h1fhkNh/QXsbB1jnlFvOv6uo8TTUZD9zTtbVTJvZUMd1cQMXxVj1MPhhb
 FESg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EZXUQOIO
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
> On 03/08/2026 23:06, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> > to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> > field in a single operation.
> > 
> > Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> > __le32 to ensure the fields are written correctly also on big endian
> > platforms.
> > 
> > Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > 
> > ---
> > 
> > Changes
> >   v1 -> v2
> >   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
> >   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index c724d429a7aa..91ca75e45463 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> >  				    struct idpf_tx_splitq_params *params,
> >  				    u16 td_cmd, u16 size)
> >  {
> > -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> > +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> 
> While it technically works, I find it unreadable. Looking at this line
> without reading commit msg, it looks like a bug where a 4-byte value is
> written to u8 field. The intent to zero an adjacent, unrelated field is
> not clear. Consider assigning these 4 fields manually, or adding a
> comment/function doc.

This is a bug fix, which generally should be the smallest surgical
change only.

That said, I do agree on the style, and a follow-up for net-next will
clean that up too:

	@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
					    struct idpf_tx_splitq_params *params,
					    u16 td_cmd, u16 size)
	 {
	-       *(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
	+       desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
	+
	+       desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
	+       desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
	+       desc->flow.qw1.ts[2] = params->offload.desc_ts[2];

The fix is queued. If there is consensus, I can respin. But given that
we will clean this up in net-next properly, my preference is to keep
the minimal fix as is.
