Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E010C55172
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 05:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F87660633;
	Tue,  4 Aug 2026 05:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sw5p6HPqeRJu; Tue,  4 Aug 2026 05:59:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E2136065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785823196;
	bh=W8JyDBWkDjCNqLnmCkyzKGxOBYAxowX6GpPeWx4YIb0=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lfQWYkVOeT61veXEswFsp+q5wPTR1FIPB+sXhS3qdplqFUU/ydwidRvlZD9eMH9Ap
	 nBB7D2XFa8t9tf0EY3QRePSWvs3PuzCqCX8ESZXwBm1W5aeADhDOhLd2vGcxo0Jjkx
	 B8QSlS/lpGdFSF+q0YPoFgxQnwBD7zEutWC+wPs1EHkb+1Bd9vArZYkIMc4VPSMIXF
	 FEHqtJBBkDSOLAkJ0IQj3g63Ku1lOMQNM/IREChp6FuS4yd0x929h595Tx1Vg2Xr1e
	 w6CcEi3RmDIh9GNhVNSdbvr1AT2OwYxwQNLKV9cjIhpHzfsY21345Fg4u2QMpkmzP9
	 Ehen+9Y4xPPPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E2136065E;
	Tue,  4 Aug 2026 05:59:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DEA923F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 05:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FD786065E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 05:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zptDRlC-eD0o for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 05:59:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=acelan.kao@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5ED4960633
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ED4960633
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ED4960633
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 05:59:51 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E8BE63FBBF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 05:59:48 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e4ef9a74aso8741825b3a.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 03 Aug 2026 22:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785823187; x=1786427987;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W8JyDBWkDjCNqLnmCkyzKGxOBYAxowX6GpPeWx4YIb0=;
 b=KvyrxhAEMzcj34YFdd+IDswNbYwOI2psvA+3xj8v85oYmhoem4bpOPRzp7BPXU6c0D
 vazKi6p3DaxY4jRyecAH+GXnXT62n/m4no6CXO1smPfJhBhv4f37Cj+M+obCfs9KfpnJ
 bKAb0ZUf91VWzVmXTfDCtf06vIEcSVgbdKHosYQAljSZ97dFauo052iZNNr0iv6mwqth
 pz8JQnbVduxkB3B8LNdHZSJFT3fgZJYYOk6/yKUJbmg3SO4lh+phz0TAdP9e3mp6/l7+
 GStCap0YezC+WUEUE+nlXyXxQ3Qmw+wD/IjcKtGOKvLgR6QrL/UbZaL47Y5vpXmlkt20
 m9ow==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCE7BSBKH0do2UtJ9r/vW2Sv1i1+3GhPdElMeJZMksRLtVn4oVRJPLrlX/jV4F3a6DRo4TgkJyNN+NU6yAyks=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyA1NLPUQ4ARTx8mXYPuyrX2wTSEX7mXS/5VwEjDDzdf+7JxAbA
 eyQH5VAYV6uGXWdVzgkK6IBb0vhpnAfL8Bx9y7Y0X0/gYhI/Hy2aQXOKQG+sp0ZfveCvczai1Ix
 uBmTeRfZNjt0514mPX5QTV9bcqzcDOKtXIcLR2pKTO1HB8JqDgMEn76eJuJyFarQzU2r/Fd/c4D
 /xZWVuNPA7yl0=
X-Gm-Gg: AR+sD13WZNVV4xSzat/GAiSWbHVk92RHKvpsy/pl4uuvE9l3EqUEtGYHv0bgndhJ5zg
 6S8OgH/Q6716bLBXT0Va92Z+CapKbaGSlzOztne0yJabA3x1DIriNhFZLfvQhZRtDGwHej2wMpw
 0soAnYgxSoGp6u3Tm/11HbNXxiqtNBCpVzjqMflG9MBumYMw3+3yunARjNhaaocRsMElT4rlfbd
 oVMfjJC+mlwC0gxSujs/59f+ECX/MrEPE4vaFLyq+NPgJ86KlGQZxXZU73hspPKCKyM1lsoumn8
 vcswg6Eae0FZIcnes4vytCPxCqgqPWHnVMaHJ2Nlpiue5nJCXw/75YUOaOZdji9+z/ZGsiuJEmN
 K7OtjoXxX7GlRZC7TuiKsek02pUjyteQ6asnqjFqVN3eF+QcRXps6weT2
X-Received: by 2002:a05:6a00:f07:b0:84e:2d5d:5e4d with SMTP id
 d2e1a72fcca58-84ee4998f2emr12535444b3a.68.1785823186950; 
 Mon, 03 Aug 2026 22:59:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:f07:b0:84e:2d5d:5e4d with SMTP id
 d2e1a72fcca58-84ee4998f2emr12535425b3a.68.1785823186626; 
 Mon, 03 Aug 2026 22:59:46 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84eecf81b08sm3430742b3a.22.2026.08.03.22.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 22:59:45 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:59:39 +0800
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <anF_hoO57nh2363f@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
 <IA3PR11MB8986B77F49DF672178FEE4BCE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
 <c3030882-55c8-486f-8ff3-571d001b99a1@intel.com>
 <ajiHH-RaHUjgraMh@acelan-Precision-5480>
 <1d6c3aae-c9b1-42da-b5fa-6f8ee9ebcae1@intel.com>
 <alcd_FnUdrQug5cm@acelan-Precision-5480>
 <0e28b9d1-ab9e-4934-b939-81557f6495b5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e28b9d1-ab9e-4934-b939-81557f6495b5@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785823188;
 bh=W8JyDBWkDjCNqLnmCkyzKGxOBYAxowX6GpPeWx4YIb0=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=Obpa3LDPcf/4q9N/O5KxNmaUiZ5Xp5yU5x93sQktTSEx7toBWnp3I9CfGo8vYj5FC
 U33jyNpBHpM5WbhwBxiNg+gS3u6CKTvM/D28Dy85BjkVgMTmRB/FlxJ+dacfeyz+8N
 KwzQK06m/tHB29teg1xnvNOjBgIvgagqq8a9dyV01gJTSh6RXcdtzutfL8D4fgqDXQ
 NDYaAGMTiXM3ZX0PU0fbI8zYlh0JxC83AXuffwZUhkoY+e04wb1ywXX0C8+SorezDL
 rnluQn4w/mFgRuubj/nFb74tzcGy7TnV4K5m2bPk0UkaMkqHY5bui5BJcEQfptOOSQ
 vA3SetW3Ty5cL5MW8pM3w6BKJq0TQSAJQpRTdJNVCU3yT1FrI9kkitXRTkA/Ms2MNK
 WOqs1t34lD7K//OoBvWyLWHpgldc85ujrrM780N+yNtzckGeZzB1CLuB2E/dgmgKe2
 PdlrMfViFa2O2JkxSLJVfn9Yhbkp5tP1ht/aOePdvEPBlXWR2+Ard6IbjTnHZConNa
 +UXP1igxOnB/MS2xNtyN4aBGL6cMwSgCXT3sYPA345z+UwEcOaFSIsi8rdms7Ns5th
 nz8v5yj2pPJoIYZeJ6Tb9lI+fPUxOMNrC4M6jmWhy5BHXAGv95dc5u1embfcCnlxvg
 aZ3xodEghcSkEWuBfkf3aDvQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Obpa3LDP
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough
 after reset
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
From: "Chia-Lin Kao \(AceLan\) via Intel-wired-lan"
 <intel-wired-lan@osuosl.org>
Reply-To: "Chia-Lin Kao \(AceLan\)" <acelan.kao@canonical.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 15, 2026 at 10:57:04AM +0300, Ruinskiy, Dima wrote:
> Hi AceLan,
>
> > > > I wish we can detect if the MAC passthrough is enabled, so that we
> > > > know if we need to poll for the MAC address.
> > > Unfortunately, like you I am not aware of any way for the driver to know
> > > whether MAC passthrough via FW is enabled. Because of this we have been
> > > exploring a simpler way to support this feature via ACPI objects (which are
> > > set by the BIOS when MAC passthrough is enabled and are easy for the driver
> > > to query). I know some vendors have already implemented it, and I am
> > > currently drafting a patch to send.
> > Any good news about this patch?
> The patch is here: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260706/055944.html
>
> I tested it on my setup with MAC passthrough enabled in the BIOS, with good
> results; no community feedback yet. I encourage you to try it. Lenovo and
> Dell laptops should have the capability.
Yes, the patch works for me.
Verified with both enable and disable of MAC passthrough, and it works
as expected.

Looking forward to see this patch merged.
Thanks.
>
> > > The mechanism I have in mind does not require BIOS support - the I225/I226
> > > FW already supports the required interrupt, AFAIK - it merely needs to be
> > > enabled in the igc driver. With that said, there still remains the question
> > > of how to notify the network stack above us that the MAC address has changed
> > > post-probe - and whether it is even supported.
> Looking at it again, this may not be as big of a deal as I feared. If we can
> call eth_hw_addr_set at any point in time to change the address, then we
> should be able to do this in a response to a FW interrupt. I can try to
> draft a patch for that, in parallel to collecting feedback on the ACPI
> approach. These are two different means to the same end, and some solutions
> may implement one but not the other.
>
> --Dima
