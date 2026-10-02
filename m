Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF35CA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C02CA40DA0;
	Fri,  2 Oct 2026 13:18:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDXTCjR488VL; Fri,  2 Oct 2026 13:18:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25ECD40DA2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947107;
	b=jWeI+n8lQ+KG26zYEesZLV8iG0V6mh73aEYZDWKlVPPF0mK8K0pulunjhy3IaPMfQkHc
	 ecifxwkanWf8tpImJeRqkU+sakJOjGGpYRCJ8/tRKa0HDv3jQJ8t7ZsFdefVLZIGlGarc
	 KFQooQIuYRfaQcYcnROYK/CWMxYbD/WPHpcmXUacVqfB7jTlNjZDezeLh1TmetkKAz5Rd
	 BvsfNMl/6VxWJ8Zo3atOQEh3wzBC576ILuiu95G+3xt7tktgqgmki/A217xMZIsltM4IQ
	 cQiZRAUMxB+Lr1yvMG5vyQlyVPNLC9IDTONF4aFfg0mIfZSGDUARBk1od0lcekaJs6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
	b=fwcIz8+dWSdDAKUSkvOkK3YdJ0ZEPmnnLx+Zc9qPh1vj82jFCsujcU6k3ZHPniFy8Zqd
	 t7MYUCYMWopZOql4WBaI1FCZt5wzLzj4FX+vOo2QpcN1Od/OM7bcwMSL/8z61XX+e3s33
	 DAgD2lIMjVHPXiLl3IqEGxBBs+ZvXNyLK0uZSHjvYvFZ0vbQ2nhP4Y1Qu07TC/eITyC2x
	 6hsJiliFYTelE4f0OniMP7xbrMKkeRacF1VXRIKT4M7X41T2fTRT0etTd2H2Y1GcOpXPD
	 mdi3XX1YZSsme5hiOODPlnDIud+AfEO3fQ022IKDfqORLKDiXu1ENFpFXINL5X2L8Jg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Hc84M6/f";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anXIQJzt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anXIQJzt;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Hc84M6/f";
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anXIQJzt;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Hc84M6/f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790947107;
	bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LHnevqbfEDDmQpKl6Nr13rpNBgLGnn3amJSpicCFBEjdNgeOke7NVzKA7wMPK+HWy
	 hFPbqjYnoEQ2amAMcMzOmLkNIkG4V39VoxMhjfxq46o8CXu8244CmcFuC13hvwdnb4
	 Z7hOUJmgoJVdpqDspS1lUDD2nC2KTSdEdijiWNtjBP8qLbXu5w5n6O90De/+Wq4m17
	 S+LdAL3b29jO7TaweowTWIHYdbuLhOpr70iddTXenzYhFk9shd0PXBqyCIQnViGzzf
	 kISDPZbykmelcSWhnp64++RnwdIffcdUC0CvUC0A2SDZaTv0EaahvHscr8i3UCx2GX
	 JnOJSB5IYkM7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25ECD40DA2;
	Fri,  2 Oct 2026 13:18:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E78A934D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D919340DA2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:18:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOil8wFgHrm1 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:18:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DE1FB40DA0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947105;
 b=courYcd4yQK9M205CfGAqoeGCWecGzQHPUmatY8fBOTMgGv+d31Ebr4MxTXHQLB6jgsE
 DpaqSSbLpNY5RGx/1VJbXm31MK2SF1sADfO73te0jXFLGUeAoJDx73n1fCGvVcmOmmIiM
 GLJ2Ul3u1kdrIhD2ov0o6f0hcr/xN1jr4TqzobWgJbsGcR2sesNO88V9mw3a/NcwaG93L
 sadxcl5NYGrr/75SqYeUsZgt7AN0B7vyybIdB1qEa5mBupAf0REvkLLDFbMqu5yiBRzzx
 JJ0GH1mFkGHKtkO/R5V4qq0yyNOMbJpOYMd0kbR6xDrWeaRgjdVSYuvpwbMgNqb1o6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947105;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=m16BS7c5V+zmn+rQLG0IHFuKfxUv3keHdp0z3VNYcowyfh3O1Ebd7z5jRo0Zc7UT2NUD
 Zpjaf/wy2p2HfVGHlF3RD5bEsTxfEul1dTbTHIQuDckYPw4zDc2gL2WDknS8hY8IovcpV
 YcMOi2CxLUXCjz+JwsH0rFVSloWh+rToDJTslOnINzWUTnFFW+6j2hAyPEkLwaJjbIQrp
 M6gh/ivNWhc4PvVs8LH1PqnmRkLwhnWrqlGvit4QEWR9b+VY8oMfgmhRWO7ZAXDtyGnVV
 hqmDBMrODIwkLenWBSBVRoO28zF+oHyO58fcMlHQP7esYvyDKGh2D09gnlV3jKJ2woQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Hc84M6/f"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=anXIQJzt; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=anXIQJzt; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Hc84M6/f"; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=anXIQJzt; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Hc84M6/f"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hc84M6/f; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=anXIQJzt; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=anXIQJzt; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Hc84M6/f; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=anXIQJzt; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Hc84M6/f
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE1FB40DA0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=Hc84M6/ftazHqgkE/vZvG1k44jNLhym8hfGj2ZUuUfZB3VOna+QD2Kjv23m7vlqSCC3hzN
 fXIzjkFvANfWGmvfPKhETFN+SsIS6ADmg5PZEmBdKoMTXUS6ZFpVs3IFwiloLkOsbJCttz
 GD+UGuA07XRdm5qnSQSpwsh8RQbqVPY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790947102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=anXIQJztFIGfPNeEh9CgMYMu5gm5HsG0Is2y4QBbKEe/zVEVwIH4pM46R+XFHboQv5lIht
 wO/7b2hRyXuUmuf+rIdRW/gJN77G4AkptrKcN6ovonAOEfnZgfuntpQd+YMg+gUXMX8ZBX
 aZED0ba6cnMr2CZmCd7UlwZulN97OAE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790947102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=anXIQJztFIGfPNeEh9CgMYMu5gm5HsG0Is2y4QBbKEe/zVEVwIH4pM46R+XFHboQv5lIht
 wO/7b2hRyXuUmuf+rIdRW/gJN77G4AkptrKcN6ovonAOEfnZgfuntpQd+YMg+gUXMX8ZBX
 aZED0ba6cnMr2CZmCd7UlwZulN97OAE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=Hc84M6/ftazHqgkE/vZvG1k44jNLhym8hfGj2ZUuUfZB3VOna+QD2Kjv23m7vlqSCC3hzN
 fXIzjkFvANfWGmvfPKhETFN+SsIS6ADmg5PZEmBdKoMTXUS6ZFpVs3IFwiloLkOsbJCttz
 GD+UGuA07XRdm5qnSQSpwsh8RQbqVPY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790947102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=anXIQJztFIGfPNeEh9CgMYMu5gm5HsG0Is2y4QBbKEe/zVEVwIH4pM46R+XFHboQv5lIht
 wO/7b2hRyXuUmuf+rIdRW/gJN77G4AkptrKcN6ovonAOEfnZgfuntpQd+YMg+gUXMX8ZBX
 aZED0ba6cnMr2CZmCd7UlwZulN97OAE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zob1KtCjSCYBg2TkSrCdgcCYXcxGjfohAaytPDnT6AI=;
 b=Hc84M6/ftazHqgkE/vZvG1k44jNLhym8hfGj2ZUuUfZB3VOna+QD2Kjv23m7vlqSCC3hzN
 fXIzjkFvANfWGmvfPKhETFN+SsIS6ADmg5PZEmBdKoMTXUS6ZFpVs3IFwiloLkOsbJCttz
 GD+UGuA07XRdm5qnSQSpwsh8RQbqVPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-PRbX39NwOhW8XAmihcVDpw-1; Fri,
 02 Oct 2026 09:08:15 -0400
X-MC-Unique: PRbX39NwOhW8XAmihcVDpw-1
X-Mimecast-MFC-AGG-ID: PRbX39NwOhW8XAmihcVDpw_1790946492
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7919E1800627; Fri,  2 Oct 2026 13:08:11 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52B8B214; Fri,  2 Oct 2026 13:08:04 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core or
 global reset
Date: Fri,  2 Oct 2026 15:07:43 +0200
Message-ID: <20261002130752.2597259-2-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: F_lXEVqOHg9rgGP81TqA1ZyQ4SRCuYisHbXDgqFVNPE_1790946492
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and GENEVE
port is gone from both the boost TCAM and the driver table. The
udp_tunnel_nic core is never told about it and still considers the ports
programmed, so the Rx tunnel offloads silently stop working after the
reset. With VXLAN port 4789 offloaded, 64 flows that differ only in the
inner headers are spread over all six Rx queues of the test port by
RSS, after a CORER they all land in a single queue, the same as without
the port. Removing the port later trips the WARN_ON() in
ice_destroy_tunnel() because its table entry is no longer valid:

  WARNING: ice_flex_pipe.c:524 at ice_udp_tunnel_unset_port+0x56/0x280 [ice]
  ice 0000:04:00.3 enp4s0f3np3: Error removing UDP tunnel - -5
  ice 0000:04:00.3 enp4s0f3np3: UDP tunnel port sync failed port 4789 type vxlan: -5

Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the core
programs the ports again. A PF reset keeps the package and the table, so
it is left alone. No rtnl_lock is needed since commit 1ead7501094c
("udp_tunnel: remove rtnl_lock dependency").

i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram
port offloads after reset").

Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8c4b0fbc790644..f2121e79fca993 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7859,8 +7859,11 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
-	if (vsi && vsi->netdev)
+	if (vsi && vsi->netdev) {
 		netif_device_attach(vsi->netdev);
+		if (reset_type != ICE_RESET_PFR)
+			udp_tunnel_nic_reset_ntf(vsi->netdev);
+	}
 
 	ice_update_pf_netdev_link(pf);
 
-- 
2.55.0

