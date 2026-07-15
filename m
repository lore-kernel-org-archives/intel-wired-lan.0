Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20730C4450A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 05:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9698406D9;
	Wed, 15 Jul 2026 05:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2Zcvk852xit; Wed, 15 Jul 2026 05:46:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9360406AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784094384;
	bh=IoG1Whp3gfhDFJ0umUwcIOIJfD5L91Xz9sc0pOou7vk=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oSeSOTamSpApIKBDkjDgCgS/57oMgWXlck1hrtGTJH1WfbQij7gBAnVj1tA0tAYAe
	 6jhxoPxZPeC9DnM50HUCxTF+ppp6wk7dFYDH6Lds5jOsPjs2MK/cl1uQWoXwtgAa1Q
	 T95xYZ61h0s+mPaHisK4Re6hYgrFIhKiJiww1cEWsMMUZjW8DK6f0cGGVJVQSGVnza
	 0ppQZaXfMI6WBcuqPoYxDKNHrFv1VSVL8b7R9lmQ5VMwF52hzFtOKcn6xJ8xoCjd+Q
	 G471mik/qez++QbIFtGxOlKQuULGffeTEHk4v8pMXsQQVVrNeTQZn55P1XDXOE+TfL
	 U1xdD0CUWeBDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9360406AF;
	Wed, 15 Jul 2026 05:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9833203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 05:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AD15406AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 05:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hRp8CfWGIUfy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 05:46:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=acelan.kao@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0AC69406A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AC69406A9
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AC69406A9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 05:46:21 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 873173F57C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 05:46:18 +0000 (UTC)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dc101287aso5664122a91.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Jul 2026 22:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784094377; x=1784699177;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IoG1Whp3gfhDFJ0umUwcIOIJfD5L91Xz9sc0pOou7vk=;
 b=eBZbvQDViRYXjPGOto5QTpMrtX7HiyTgKWiXQht9LHJmMJjSQ/5WH4AVGrUbnDhMIF
 kJMWgeEa6NUKXKDBWONjBY2a7P/MsXpK2HqQMUkh10pR9KChXP+ZWQNLaYXJ+LBrAvqg
 /01iDHHdw4iJuuF/3IKGjlhPHKEXQsCuD13HLk26KqaB8N7tyvfHFmMqURERDa4a4tfw
 r9q8fGUoOZJpdXOx9FncIOGaaf7KKNH4/WhoY0zFP3zXURqo7CPIKWgVkYjTb1Cd9sOQ
 mCENOtPf7XFZC3v3hVViB4QcICbLLIY4YGUAsYGigYLzcrIFDs+NPB4Ym1JpOm2JlVf+
 HCVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSM2DjEJHxgKqfABhBGco4CJIhCbckS8Ccf5FzX6+gLZ81f7qU1rOr2aoBeDPQDX7tmKoWvTOoJyKbxYQB8aE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YwENHIiFjLK5Dr0a35bjFLC00D5q3Jm+Vb6TUHKoiaz5jK46gYC
 nyt5F8J7zKT4tc9KK3FmxfxsvCH0ypeWkKCTKkWGbPltiTRdyhUOReG0VQh6bfKHFr1eBFycuxR
 5zR333Oc+wEdHPV4BCoq2SjVgGtpuWE/gYLFfB4TD9fLj0VXuLY3RTpvhDYXxZszu4GaHMM1e9l
 ofJc73bQurYkDtmDdqfiLxng==
X-Gm-Gg: AfdE7ckxyU+W2UTnFsXe7u1/18wuZPyepr0tQrobJ3/OBzL+HKKxUKPbHQ/9Qhf5lJV
 Voz5Suc0m3D0cSnAImYe9r5k8g72UbPX0ZBekf5c4mcXMIdxm5OfPArw0XJAXp7MXLCsl6x1DPq
 sCTkStM9XBxLcjbUXbha9tDSiCi2+ChExqxXQTxuP58jCpm2fenGEgv4MtbOBSPEX0FHBEo0rwI
 J7aIwF2+G/bdK4pDUH/SB/BjmTJ/5C2cqe3aOZkQKb7Bg91j/Es4nly6QDlejOgOs/K5FUwp0nD
 mf0nFw/wSQWJEsXNAUgtKWtqCN8UFm9oE2pK+94SPRhczCKBdn+gBrdHgcrfLa5N3lAlsJUOBEg
 sW/QRYrPlnr9D7tVVuCLc58Tn9tv6jhI7rM0kfGazqPu7hrinE+/sOpUT/k2wQ/xyOpQ=
X-Received: by 2002:a17:90b:28c4:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-38e17db7bd5mr6184605a91.10.1784094376915; 
 Tue, 14 Jul 2026 22:46:16 -0700 (PDT)
X-Received: by 2002:a17:90b:28c4:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-38e17db7bd5mr6184580a91.10.1784094376304; 
 Tue, 14 Jul 2026 22:46:16 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm86874914eec.6.2026.07.14.22.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 22:46:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:46:09 +0800
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
Message-ID: <alcd_FnUdrQug5cm@acelan-Precision-5480>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6c3aae-c9b1-42da-b5fa-6f8ee9ebcae1@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784094378;
 bh=IoG1Whp3gfhDFJ0umUwcIOIJfD5L91Xz9sc0pOou7vk=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=P7xPp+mXbUEhruHoV7a+jX1u/PIuspN3CGYNetDZMRpmFordWnqQ6go4PteBc1M/o
 Z5JkKwabJHkN81bNkudLJdpdsNfCPO91NLNFS0pEs2TwchK68t2LTzrx5zuri4H9vN
 bfmXtAHPYp/6mGn5jv9dPJS4ESF9FuUbZb7HUA1pEJa71MwCToakOnBvXVyj7sPzVU
 KFSy6eq4dgHL64+9jdgRBwn+RxUOaXHMc7CrmLDhFEjIZYiNHuKaNT4X4wZ0U9GT4t
 LI8dDuKTZID5K05Ac8O5k6+YT2yPOvCo/b6t+2y4niTE+N0vFRSgwVGRWcbMbWl0dV
 6Jk8sefcEYAP2GFvWJFWvSMet3Q00QAUgLDglQvdGXkCBu/HQ1O97lLRl0GqqZV7RK
 Ko5dGfPjrFUqY+XhEQLPcmN3OdZ+GCgsvzIxwyaF+DjkmPy8fzNrAba+v1xNxSvV42
 nw5Awz5mt5hCTwUqkSdabwLQ+S1b+yJfd9wU4GL0HNP7/BdhiUR9gd3ZT+rkmyL9ym
 2cbOjEfyzVNIReqOwu6AW3Chki5JXr6jX/h+xh40j8cLz+siZJ/QiV+iKeOBqDaKL9
 JGkfYfA2AZn0u9Q7ZdLOGX+XpIt5fmlyGwplXVKdo2ildXs06FrvXMns6Lw9fuH22d
 0EU8E0LTH6BGjG5/jt1bkfKo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=P7xPp+mX
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

On Mon, Jun 29, 2026 at 07:42:43PM +0300, Ruinskiy, Dima wrote:
> Hi AceLan,
>
> Some more comments below.
>
> On 22/06/2026 4:57, Chia-Lin Kao (AceLan) wrote:
>
> > >
> > > Because 100 iterations of 100msec each - this translates to up-to 10
> > > seconds, no?
> > Yes, just in case it takes longer.
> > I think 5 seconds should be enough if you feel this is feasible.
> 5 seconds also sounds excessive, assuming the majority of the systems do not
> support / enable MAC passthrough via the FW feature (and I have a hunch it
> is the case). 2 seconds... maybe, but then you say that in some rare cases
> it exceeds 2 seconds as well. What if in some even rare cases it exceeds
> 5/10 seconds? Perhaps because of some glitch it will not come up at all on
> this cycle. Should the driver always wait?
>
> > I wish we can detect if the MAC passthrough is enabled, so that we
> > know if we need to poll for the MAC address.
> Unfortunately, like you I am not aware of any way for the driver to know
> whether MAC passthrough via FW is enabled. Because of this we have been
> exploring a simpler way to support this feature via ACPI objects (which are
> set by the BIOS when MAC passthrough is enabled and are easy for the driver
> to query). I know some vendors have already implemented it, and I am
> currently drafting a patch to send.
Any good news about this patch?

>
> > For the FW interrupt mechanism also needs BIOS support, and we don't
> > have the power to push this.
> The mechanism I have in mind does not require BIOS support - the I225/I226
> FW already supports the required interrupt, AFAIK - it merely needs to be
> enabled in the igc driver. With that said, there still remains the question
> of how to notify the network stack above us that the MAC address has changed
> post-probe - and whether it is even supported.
>
> --Dima
>
> >
> > >
> > > Thanks,
> > > Dima.
> > >
> > > >
> > > > > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > > > > ---
> > > > >    drivers/net/ethernet/intel/igc/igc_main.c | 48
> > > > > +++++++++++++++++++++++
> > > > >    1 file changed, 48 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > index 2c9e2dfd8499..fa9752ed8bc5 100644
> > > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > @@ -11,6 +11,7 @@
> > > > >    #include <net/pkt_sched.h>
> > > > >    #include <linux/bpf_trace.h>
> > > > >    #include <net/xdp_sock_drv.h>
> > > > > +#include <linux/etherdevice.h>
> > > > >    #include <linux/pci.h>
> > > > >    #include <linux/mdio.h>
> > > > >
> > > > > @@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] = {
> > > > >
> > > > >    MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
> > > > >
> > > > > +static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32
> > > > > +*rah) {
> > > > > +	*ral = rd32(IGC_RAL(0));
> > > > > +	*rah = rd32(IGC_RAH(0));
> > > > > +
> > > > > +	addr[0] = *ral & 0xff;
> > > > > +	addr[1] = (*ral >> 8) & 0xff;
> > > > > +	addr[2] = (*ral >> 16) & 0xff;
> > > > > +	addr[3] = (*ral >> 24) & 0xff;
> > > > > +	addr[4] = *rah & 0xff;
> > > > > +	addr[5] = (*rah >> 8) & 0xff;
> > > > > +}
> > > > > +
> > > > > +static bool igc_is_lmvp_device(struct pci_dev *pdev) {
> > > > > +	switch (pdev->device) {
> > > > > +	case IGC_DEV_ID_I225_LMVP:
> > > > > +	case IGC_DEV_ID_I226_LMVP:
> > > > > +		return true;
> > > > > +	default:
> > > > > +		return false;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > > +static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
> > > > > +					      struct igc_hw *hw)
> > > > > +{
> > > > > +	u8 addr[ETH_ALEN] __aligned(2);
> > > > > +	u32 orig_ral, orig_rah;
> > > > > +	u32 ral, rah;
> > > > > +	int i;
> > > > > +
> > > > > +	if (!igc_is_lmvp_device(pdev))
> > > > > +		return;
> > > > > +
> > > > > +	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
> > > > > +
> > > > > +	for (i = 0; i < 100; i++) {
> > > > > +		msleep(100);
> > > > > +		igc_read_rar0(hw, addr, &ral, &rah);
> > > > > +		if ((ral != orig_ral || rah != orig_rah) &&
> > > > > +		    is_valid_ether_addr(addr))
> > > > > +			return;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >    enum latency_range {
> > > > >    	lowest_latency = 0,
> > > > >    	low_latency = 1,
> > > > > @@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
> > > > >    	 * known good starting state
> > > > >    	 */
> > > > >    	hw->mac.ops.reset_hw(hw);
> > > > > +	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
> > > > >
> > > > >    	if (igc_get_flash_presence_i225(hw)) {
> > > > >    		if (hw->nvm.ops.validate(hw) < 0) {
> > > > > --
> > > > > 2.53.0
> > > >
> > >
>
