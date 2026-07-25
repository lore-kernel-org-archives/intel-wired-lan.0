Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A62C531D0
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jul 2026 13:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E01D04081F;
	Sat, 25 Jul 2026 13:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WecQ8aTkVeYE; Sat, 25 Jul 2026 13:55:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A46D6407FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784987739;
	bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kj18Uq7gF5+Qe1cU0l9tFOPCMbWCb+T7TfL8oatXL1WejVicOHFLJu6zF2Y4pLfkj
	 SnStjBsnFFhIeAINAkGph+Z0NXak0z5VRDnak0FTh+EAmg1emhX4cPtYKTnFN305EW
	 N0rKp+e9I/P3+krH1A2MbPd0pLZVzHzItKsL6SvlrltiglupD5TeJvVXlTi46bQ6XB
	 Z4VXOeWZQNWj85KVwxTnmdUAWgMSDmtJkDZ+J68PB8U2jhyzBLosQy8TKk/jByyL4h
	 GG19xiMwrDCKuJRvEBiC3zruuGR1c5BBhGbpcCchARP0BsXFc6yFom6H1eNQPl+RQt
	 WfV5+A0An1IZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A46D6407FA;
	Sat, 25 Jul 2026 13:55:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0198C2E5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 13:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB42660656
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 13:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCofjg9NV_xK for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jul 2026 13:55:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=mhun512@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0BAA060653
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BAA060653
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BAA060653
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 13:55:36 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so145349766b.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 06:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784987735; cv=none;
 d=google.com; s=arc-20260327;
 b=dcPXYIAs3kxixGKe9RSk3IRJsu4oKMrf99kMr2W7+ATMjlbrn5iyhf8vbu2OsAQhHy
 ZL3xHU0S3+6uxNMbL0elBxdEE90e/WosUGY51kyxCSgZmpx/hhswovzB+O/FtpTiC/nc
 RfiG3LuRtVJtmwy6XsH7FQx+QZeAd2diuz+ItfNZZLUYIjA4+sjYgT8NS51IpgFAmuTn
 34VmZ73yyvdqcYSL0lX69nxPcJP8MDC/A0YjITFMn+8b2GWFxa1wvyJor6lJ/hRYuNiY
 9UnPbxuBRM5Yi3UmBO5NOzctOyY+KRHkNhdABDMiA1e7bSFu2zp9awu7xVwZ9o6KvN4F
 gCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
 fh=Dt1pxotHPm96z3WgEh602oXLmtadlIZ9YXNH6S7RsFs=;
 b=gOJsQLDvqWzLZln9BFMfz624nsnZh1a0QDuFIoXFt6UADwwJ8XR2c6GWO85C33JKHR
 2zL/cVrvB0fPJHbh5RSzA5hjnIW+uxK6EJ0vBSW0n+rqBi6sGhLDEZuccJR8+0y8/haQ
 2yk5UAYmxADCDwMMHs4w+IA/QVNGnZ8ziavPm9/XImfSRgzYjeq1/BZu220H3DabHejK
 yMy7bDY6klg4on3MGoIR7hGUkwhtKTWal1WnVo3VH1AVlTC02QIBm+iAisrlr6Mt5wt2
 vBBy6IN2VQtETidbDYIstPFPL19ziyOXIWo28EYSMufPEoO4HiIJaWGksOfHkKa9lTmY
 wRdA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784987735; x=1785592535;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
 b=ovcsgh/uBUgbs8T0XeB7yP4rAXMsWXiSMhrh5Mby/zWgXNGnqu5cb1juCqOFrzcFqe
 Tkeyo3u/hAbtf82wOJqT3f7QN+lKgafRUd5ZqYpQP8rnezcVWf6v1FQMvoGMBao+6xyE
 UtvnUXirDXlBbKyvCEnZ0PsBPKwaihapqJhI6oR2YOfQPltwdecsNzEb1g3sCCC47fba
 YQBntNNvOoR9ZUSyUsz5pw+UuWiBKOsX/9SN2Bs5SMTBC6rYzwRGCjboFnbI5A7ZNaD4
 IIm2prdg/VUThfcHKIW0ov0gry7CqBcAbMHP1BGpBidkfwMh3uu153So004DrLvMh7mZ
 wP0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2NAkxWrAeWiMtt+0duVzW7ZHmOyN0kbt5ASuD/MpF3q/+dO85qCdro+x3aeLVoouCO/icGEzDO/0g1SSMcwQ=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyINUEO1W9lVmQpDtxu6OGbz/0sEYSMLqqFTDJcKhn4MeSDJQZr
 IVhO0Jsm7CyPFAekfVV/PJKmjdmiF9+rdtnFrt9bBeFbXtQKz8+p9YlSJFH0d905JW5fe1URbuj
 bmn0dBg79NbeWL8VTiBwwVRdHsHESHg==
X-Gm-Gg: AR+sD10dZUADEQISSLsGmZsALOmO5W1DXY1tG974Duc+SEada5CD/3Khoq37d6YOlZ6
 kpeh3C5HA5LfJA3GcffCsGaUynkkOHNjuIJt7IHvLYU/XOierEpxhkJllQBp3L9UaravxfpF6wj
 UwY2YWgW18rQhExlTb304sz4/v0OAm8K9bG1HCPbkaqU55+E3Y6PTD1Fz9jeTbGVrKgK61OuYzq
 l5BcyNx/hMEjrLzYXFH4as6ZSt5lehQxm20TC4ZZJoXlVXteynuLNwy+MmWO5LRM8rK1Xf/t4Qx
 HpVWfbdY8ukOfJK3o2FdrUBD2YmNb8BcF5DBsDNUTxtOI4fO1gmlHHe5bs3Zx2eldXP0JGs=
X-Received: by 2002:a17:907:983:b0:c15:f376:9642 with SMTP id
 a640c23a62f3a-c1f1f119245mr92930166b.65.1784987734642; Sat, 25 Jul 2026
 06:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260720143511.43408-1-mhun512@gmail.com>
 <IA3PR11MB8986986280690863E016ACA0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986986280690863E016ACA0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 25 Jul 2026 22:55:22 +0900
X-Gm-Features: AUfX_myEDpHU_7CZdJZCAMYsX-P6rIRFrfbnz5EzBgeFs4qgEBEIgk406Eww6Uc
Message-ID: <CAGEsz8HNGUXsiZ_4Eg6atPjzWnTbWoxDwGVybgks3DmGhyH-=w@mail.gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Olech,
 Milena" <milena.olech@intel.com>, 
 "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
 Mina Almasry <almasrymina@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784987735; x=1785592535; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
 b=X7LrW2Eu8TfGZc8M/Q4CpKmJFNKdXXAuJ1HUkmlusLYr0I9ku7ivSKBhC60hr6Zhvg
 9NbwLWs0kXc+M6DIQU8azyCReI5qlf/DpmZSt3Q0YxxacvRQ+R8IGYW3c/y4xxAmwxZV
 RbOQS5orc/PXwcKqWQtO+3i9Qt/dxuRQJe5vkK31lXxsPy2Dr6HoL65wkFtxdhraLQkY
 WO2wtNh8waa9x17vsMXZj9z+tEonBm7qXEBIHA9/9ft/H2Y9J3uHTTQYJOKVJ3vqpdCw
 uIwmzzBmPJuBmy4uhK6kBZFrn7y+nLtdouH7nG4ypAZYTPCyNoQZt79VOkxTUltBpU2U
 arUg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X7LrW2Eu
Subject: Re: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
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

Understood. I won=E2=80=99t repost it unless I receive concrete feedback.

Thanks for the clarification.

Best regards,
Myeonghun Park

2026=EB=85=84 7=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:17, L=
oktionov, Aleksandr
<aleksandr.loktionov@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Myeonghun Pak
> > Sent: Monday, July 20, 2026 4:35 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> > lan@lists.osuosl.org
> > Cc: Olech, Milena <milena.olech@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Mina Almasry <almasrymina@google.com>;
> > Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Myeonghun Pak
> > <mhun512@gmail.com>; Ijae Kim <ae878000@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
> > failure and on remove
> >
> > idpf_probe() enables PCIe Precision Time Measurement with
> > pci_enable_ptm(), which takes a reference on the device and on every
> > PTM-capable device up the path to the PTM Root.
> >
> > Neither the probe error path nor idpf_remove() drops that reference,
> > so the PTM enable counts of this device and of its upstream path stay
> > elevated with no bound driver, and the device's PTM control bits
> > remain set.  pcim_enable_device() only arranges for
> > pci_disable_device() and does not undo the PTM enable.
> >
> > Add the matching pci_disable_ptm() to the common probe unwind and to
> > idpf_remove().  pci_enable_ptm() failure is not fatal here, so guard
> > both calls with pcie_ptm_enabled(): pci_disable_ptm() decrements
> > dev->ptm_enable_cnt unconditionally and then recurses upstream, so
> > calling it after a failed enable would drive this device's count
> > negative and wrongly decrement parents shared with other endpoints.
> >
> > This issue was identified during our ongoing static-analysis research
> > while reviewing kernel code.
> >
> > Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v3:
> > - Rebased; aa8671af0c38 ("PCI/PTM: Drop pci_enable_ptm() granularity
> >   parameter") changed the call signature, so v2 no longer applied.
> > - Guard both pci_disable_ptm() calls with pcie_ptm_enabled(), as
> >   pci_disable_ptm() is refcounted and recurses upstream since
> >   e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and
> >   Switch Upstream Ports").  Raised by Tony Nguyen.
> > - Dropped the v2 claim that pci_disable_ptm() is a no-op when PTM was
> > not
> >   enabled; that is no longer true.
> >
> > Changes in v2:
> > - Disable PTM in the probe error path, as requested by Emil Tantilov.
> >
> >  drivers/net/ethernet/intel/idpf/idpf_main.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > index ab3c409..97bafeb 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -159,6 +159,8 @@ destroy_wqs:
> >       mutex_destroy(&adapter->queue_lock);
> >       mutex_destroy(&adapter->vc_buf_lock);
> >
> > +     if (pcie_ptm_enabled(pdev))
> > +             pci_disable_ptm(pdev);
> >       pci_set_drvdata(pdev, NULL);
> >       kfree(adapter);
> >  }
> > @@ -266,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >       if (err) {
> >               pci_err(pdev, "DMA configuration failed: %pe\n",
> > ERR_PTR(err));
> >
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       pci_set_master(pdev);
> > @@ -279,7 +281,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >       if (!adapter->init_wq) {
> >               dev_err(dev, "Failed to allocate init workqueue\n");
> >               err =3D -ENOMEM;
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       adapter->serv_wq =3D alloc_workqueue("%s-%s-service", @@ -366,6
> > +368,9 @@ err_mbx_wq_alloc:
> >       destroy_workqueue(adapter->serv_wq);
> >  err_serv_wq_alloc:
> >       destroy_workqueue(adapter->init_wq);
> > +err_disable_ptm:
> > +     if (pcie_ptm_enabled(pdev))
> > +             pci_disable_ptm(pdev);
> >  err_free:
> >       kfree(adapter);
> >       return err;
> > --
> > 2.47.1
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
