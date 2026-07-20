Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF3EC4452B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 14:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C96CD606DB;
	Mon, 20 Jul 2026 14:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66DrZdHqecTe; Mon, 20 Jul 2026 14:09:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1331D606C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784556546;
	bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JUMrruXUpsCZp2il9eLCr87JudDUJAggdPa5fw1qmpZiWlICbASohTUWmFmGi8WlK
	 Y/JcNFXSH+Pn2p4Dxh5XaIwRWAfOe/NXj8NwexIcLtdJ4mLax/5g6eghXAVmreQDuT
	 Pev2C5ZAJwVnaFwwo4xmLJYEqAQyts57FPuLh0npIBDe38DM/745H2ntCPdtFGzyHm
	 kfAykNyNbU5WTLXCHL2MGVW2n5+jXzQjllFhC3UjN8EBmp+QEaqste5AetcU+jaFy+
	 tf+Lk9geKkhLcJ9jNhiiDf3NixwMbZszRvpsQ2TGDMeb+5cQdrTvejbLkubespPLrC
	 ipM8yPrtk2Fiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1331D606C8;
	Mon, 20 Jul 2026 14:09:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F941206
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 14:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F312B606C8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 14:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvTUI5tCIQh5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 14:09:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=mhun512@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E2C3A606B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2C3A606B4
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2C3A606B4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 14:09:02 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c167bda216fso840497866b.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 07:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556540; cv=none;
 d=google.com; s=arc-20260327;
 b=rjP+on9tmxcFajdvPKVugg3N5KnE2Kkxi/noQ0E7a1MHc6ksMK1ADFzLBuEseZJ6hI
 xV910jvSANK6IgDKE5hGXifeg4DNlZg/+2KUeu1FJ2ihG1K3j/qaVKLEuoYXs2U81xzW
 PQQJP7k306X62/vSA2d9spFN5Lipi/gyGfDVCKbU2Om8WbHBZnQ2e9ik1fNbaEkaLxee
 kzLPBEhbOd17IpTQDfZiV5hbWXcdI7JBjsTnDOpw3KW4Qv4lMLKz2ycfZ4Ywd6oZzDcK
 nts5eRdTYfXP4AM+TImGpkuMrRjO3Gywd58J//L0epR36AZu0yWkq9DcJL6wYfPzoKB+
 kgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
 fh=9UL4gFTa8OBTXOyaohB8oMVjFGCO7Rjd4F5LYezoFZ0=;
 b=guZBWjnUjWkVYN/PInJsY+oVV1ny7eOYBqmR+mEaKVwN9lKhIo91t7ifz1Eht6lyAG
 GrIEUxu/Q3swbKZ/A4tzTeevmK7xdVsUdBhZgBIwMPCUTyZvYwBcvHSPd8yqItWXIhp1
 BZEdffMkCxhbfNFJD3jeRBHNAyVcyCLm+mAix75lgh1dTBdpLXuAkiw5wZK6X7B3GCiT
 PaLhgshBASgj9WRH3ImiJPDKGkv0srbM3hODhV6XO4dz0oEGi69D0lO4P+dmvLkAwr3s
 z0uWKD8/qNKb3J0dDgYVhFocAa7GSk0CzVeiSpvzAhJm5Q97eHL8c3Ha5DPcKuP/tM9B
 yYsQ==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784556540; x=1785161340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
 b=aEQF3FiQfOkJITatHmutPxhYAzKIJc5l0AxV4Tny7KduHWgUPTQl98ddzUttuGXnth
 Y0IH5DlCIdsuS9KiYuL3gyjdNHHbOoXvuPa66m1Mj2Z5Bbhlgr+3xuejRpfsFK1Y7MQI
 MLHGMU/3tdAJWFVnqJeXDqGF7rijr/0FmJpXcokHIvU0Ks/UuhiBu5cBee3patuD0Eg6
 r7dxXGhCtdn72nW9W8rjyzQ19WF8XasN1EP5CfmysJrDoMfbzhTmVLn/ufmypZY/fpFu
 l0IdpbJjvNTW/3Bk+QzqFqaWfFnYdkRK+wwh6JJanWaoTPHVi40p5gJu6tdwJ9jP0RHo
 d6dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxtlFfryOsyr7Zo5v2fIc/TLflctAYli1sO9yEwSiJ3megNu8dNTjnRzKroTP5XG3r8mxL0V7xWGmoYqRcXD8=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxDBsZdca802R+5npPL060sLE+KXOYyizoKq8nuaiNWn9g0OCox
 blGW+dR5fne6AAmbT2cKys/cC4VoeJzTlo65B80251NKFWnzkuconEhdYFsZM6Z/SPn7WKy5SDu
 y0CpWTl6LybU9BQoR9H4fHCIcmwHBGw==
X-Gm-Gg: AfdE7cnJYf5XCpH9hkqL3Zhl0A6wH3TbcB5ynWOFIYJlstxTtUjTQSF//hsU0q9uEeS
 y5JtuWaApiPY4Gm5c9QXzqRIp3nY3ZMY35D2aK9+fxZ/2Dh3pczXBqUaf+/hzUH8pLWX6TZS0qq
 eqh/YA2dkpp5mMmeDZwa3rLah7Tst8Ka0RWJXYZsFp1w834lOOuXKietWzei2eGY2JI5rdIteBk
 DD+UmWLFwL9yUmXBzOwllw2fXYxmM3FFyxwG/njq9nTJxSLCxrQXWFb9qO3TrcEUjhPM+jWoGox
 PoJZR/Yb/IBFpJL+od8er71F09WSE9i8yZxVOJhjaOXRvigzFkeTOp/dBWOD4a6PKTI/mbY=
X-Received: by 2002:a17:907:c50e:b0:c15:e193:14ad with SMTP id
 a640c23a62f3a-c16b47289d2mr581296966b.13.1784556540095; Mon, 20 Jul 2026
 07:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260715074342.49281-1-mhun512@gmail.com>
 <37756e55-5feb-4f5c-9400-55a9762f9a77@intel.com>
In-Reply-To: <37756e55-5feb-4f5c-9400-55a9762f9a77@intel.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 20 Jul 2026 23:08:48 +0900
X-Gm-Features: AUfX_mxtVoqkdqPhiDiY7yGDPj-pWoFyQNJiWjpvvKZjBhKCfwEI-uuXWEFQe7I
Message-ID: <CAGEsz8HUg5yApfwtdHK4CAX7wfpBoyvrC2K8Pe1JZGu+G7hZ1A@mail.gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Milena Olech <milena.olech@intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784556540; x=1785161340; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
 b=FyooQ6ns4UIOS7KLZTOT56tu+ceZkGTf4fmyTr9w5xVODJp+0L5bOEKBFRlIuJ6kNn
 3z82cVJUSCtK9QDvl1iMphx5IyCwwimYx1MNl524pWyMV7ESjF/K5hdYmrG4nWeL6Q7D
 a1ZaaSDMQU59LcS+11ax3rZhQdUan7St2v26lIOMgRDqGIiKbf4M3AoECsid5HNMvHCe
 18qSCcR/1WKbBNzKwmFje9W0+ZbILhDk1+drhx6WkT+xHmWrJYg7sWNsh3GDX0Qibi2U
 iZMhphAUslEbyXimPTclTj5Q60/NsQ7w4i1bUD9xd3vQL5UGNkji/3yL1oaOrdciYTd7
 QOmg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FyooQ6ns
Subject: Re: [Intel-wired-lan] [PATCH v2] idpf: disable PCIe PTM on probe
 failure and removal
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

You are right, thanks for catching this. I missed that pci_disable_ptm()
now decrements dev->ptm_enable_cnt unconditionally and recurses upstream,
so calling it after a failed enable would corrupt the counts of parents
shared with other endpoints.

v3 will guard both call sites with pcie_ptm_enabled(), which idpf already
uses in idpf_ptp_set_caps(), so no new adapter field is needed. v2 also
needs a rebase since pci_enable_ptm() lost its granularity argument.

Thanks,
Myeonghun

2026=EB=85=84 7=EC=9B=94 18=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 5:21, T=
ony Nguyen <anthony.l.nguyen@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
>
>
> On 7/15/2026 12:43 AM, Myeonghun Pak wrote:
> > idpf_probe() enables PCIe Precision Time Measurement with
> > pci_enable_ptm(pdev, NULL), which programs the PTM control bits and set=
s
> > pdev->ptm_enabled when the bus/controller supports it.
> >
> > If a later probe step fails, the error path releases the allocated
> > workqueues and adapter memory without disabling PTM.  The remove path h=
as
> > the same imbalance when a successfully probed device is detached.  In
> > both cases, the PCI core's software PTM state and the device's PTM cont=
rol
> > bits remain set with no bound driver.
> >
> > Add pci_disable_ptm() to the common probe unwind after the PTM enable a=
nd
> > to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not enable=
d,
> > so the non-fatal pci_enable_ptm() failure remains safe.
> > pcim_enable_device() only arranges for pci_disable_device() and does no=
t
> > undo the PTM enable.
> >
> > Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Disable PTM in the probe error path, as requested by Emil Tantilov.
> >
> >   drivers/net/ethernet/intel/idpf/idpf_main.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/=
ethernet/intel/idpf/idpf_main.c
> > index 0dd741dcfc..f08ce13c20 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
> >       mutex_destroy(&adapter->queue_lock);
> >       mutex_destroy(&adapter->vc_buf_lock);
> >
> > +     pci_disable_ptm(pdev);
>
> Sashiko says:
>
> If pci_enable_ptm() failed earlier during idpf_probe() because it was
> unsupported by the bus or controller, does this unconditional call to
> pci_disable_ptm() corrupt the upstream PTM enable counts?
> Looking at pci_disable_ptm(), it does not check if the local device was
> successfully enabled. It climbs the PCIe tree and erroneously decrements
> atomic counters like ptm_enable_cnt on parent switches.
> Could this eventually break PTM for other downstream devices sharing the
> same
> switch if a parent's count is incorrectly decremented to -1?
>
> >       pci_set_drvdata(pdev, NULL);
> >       kfree(adapter);
> >   }
> > @@ -266,7 +267,7 @@ static int idpf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
> >       if (err) {
> >               pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(=
err));
> >
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       pci_set_master(pdev);
> > @@ -279,7 +280,7 @@ static int idpf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
> >       if (!adapter->init_wq) {
> >               dev_err(dev, "Failed to allocate init workqueue\n");
> >               err =3D -ENOMEM;
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       adapter->serv_wq =3D alloc_workqueue("%s-%s-service",
> > @@ -366,6 +367,8 @@ err_mbx_wq_alloc:
> >       destroy_workqueue(adapter->serv_wq);
> >   err_serv_wq_alloc:
> >       destroy_workqueue(adapter->init_wq);
> > +err_disable_ptm:
> > +     pci_disable_ptm(pdev);
>
> Like the issue in idpf_remove(), does this error path unconditionally
> disable
> PTM even if the earlier enable attempt failed?
> If a subsequent probe step fails (such as dma_set_mask_and_coherent or
> workqueue allocation), this path is taken regardless of whether
> pci_enable_ptm() succeeded.
> Would it make sense to track the PTM state in the adapter struct, and onl=
y
> call pci_disable_ptm() when it was successfully enabled?
>
> >   err_free:
> >       kfree(adapter);
> >       return err;
>
