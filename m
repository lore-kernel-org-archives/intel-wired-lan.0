Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7E3C44508
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 07:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05D3980D1D;
	Wed, 15 Jul 2026 07:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktmcyxj78sRA; Wed, 15 Jul 2026 07:40:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80B4880CEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784101225;
	bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vN8GtjfT/s5txehozHUaBfFgEdAgZbKztGD0ekk4PAxCKKR6gQ7wUkVm8uERCgiwz
	 8X7KxtqutaOp0c/Y7U22HLpdjNUCDqgNayPvgQn+35Nl6YGarSjQn+WWnTGP7cO130
	 LQFXdsfWtGgfuNXktUoQEstOZxNNTPnxbBdfq7vRVfFEO92Up2CkBxN54B3gZy5QZr
	 ChS/2XoQ9BvDoIUdxjNFc7hCUY9RYyxFIB7MCRDhz6mteGjCPu4TAQJKp/zSl7smdn
	 4QtdQgQ23wTpMQmX/AcpwfG7UhqcVLfGimcyFV2j6UqWsa37JHowSrWiPP4Wd3jNXp
	 /aScBmtyl7UUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80B4880CEC;
	Wed, 15 Jul 2026 07:40:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B20E49D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 07:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2992360639
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 07:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMJ_Cgf99dY0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 07:40:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=mhun512@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2BD00605E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BD00605E4
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BD00605E4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 07:40:22 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c166f1bbeaeso184465666b.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 00:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784101221; cv=none;
 d=google.com; s=arc-20260327;
 b=DBRg890NyJhVmUrNcrKGvAB1gtP+75chb79GWrktk3whykjg0yTg0CdLthvUDI2cA1
 Ch9PrwWqY+0IoWLOoeGNvHYtcZ5Duw2ln4rrc2bHSQp+K60cY1Vz5iBcw+YidYriRCwZ
 OcGX6Hopv4NxKwtKLgmCzaHEapKneGsR0QWSfyaDQQjK38mr+Iflrxs+uU27QMCtm0x0
 GhBQs4i+jaoQtXHveA+mL63ekbFpp7TknEkz9xrdeEhbO/RYjhpUjsCS8hZc5ey+HiH4
 7hurxN+Vtam0CMYdjKswRVV+3T6h2oQ2YjN3XJ6xV0CNdX2mrGps7HPPS4rgDfYVW81C
 BmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
 fh=m2eo6GegxmIobl9tMY5WOBGEICQ/aGdjQOrglkFCQ+g=;
 b=OJm6eLA23GmE/fTuV5mBcInuMMIqLs2DDRNSeOPdeiitMiIjsRWrilIMZ7dIsMl782
 hSJtpV1S3nPI7za9XPoqJFp2dXKI0H2xjICVG/GRM1YwZYg/t9/SDK06Y4gv24Ltsurc
 5oRTP+pvBgxekQZrvBQUwQbMQUxQ8BOfGyh2I9dmBvFwlOJioGvGpapBxbXGa45iy5I0
 MdUKBuMvQ5IOaArf8eo5rNM0E3pWuZ9qKreSejrlOKeAaHBLEC1dnVx05Vc4qA8v0mPD
 p6d1CDInFpj4Tf3CQX3Pi8xEYCmtrGVhvkh3NUgLD2byx1Fg2l1iVfhCIQA5MkWEhrbF
 nhww==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784101221; x=1784706021;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
 b=bit3ZQbB5DJt7lavqpx3LO50fESnN3nNZLbcuIkvqgc6arVp1GXtrpDcCdSFpOq+3R
 8X62NSF+oPHUsw9AFjnoJzv3xqtpCYZO9JmHRiFuMeh0qrLkvJFWDcIWQh1c/+Cu0LZX
 4/xjJ+35VN/Cbyo/rmWU3QFNCOsGY6IJ+7N6LXUfo53SyITb0zJyJ9WOvy7uzVYzB9iV
 K8z7BUiLMG0nzxEbOme16md+EdlLwiQcFa+vUsCydkFePLn0QjPAgnB2qkV4RmgR1n97
 cp+1UQin80tKt3Sxq/oiwSG+JQ4sjL/Tfv343ghT1mHQP9a5O7qeTaIv5N2BisTu8RAL
 Tu1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvPrCc0fCXrZtaHromJJN+RKujBnPnoakweCGrOZ39ry9V0nd6FXCm18FPhhI9x65n7E6alDzOE9L2DmRYnr4=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yy/kPUGD7qPyN44aq0HO9WDUinphqrKPXpfW2uI3DYNW+fFKSe8
 sgWUmWzfXJCOU5AMh/pLV7AsjAcGZ29xkVpIBrQcRrDubm839oOShn6LiHQ+oE2qqSIQQEusd8H
 FDpMcuVwtQkaQ0ulXoocARg3SHWw8FA==
X-Gm-Gg: AfdE7ck2pME2PrIQWyA3sA+SCRrJkwKU3o89n8qRaI00/IpOCcXf1NO9NlJoS6l7pMv
 HIO/MAypChpsX7eInIScoDxU9lkG2oChuD2Yk4R/JgfU8z7RTZ+Sa77r5uJqrhAtytsfLAWHGtu
 4v9WeQiQYWcZlbqOELNRFQn7bsGWG+qbTG8HTr1WBlJWYY1+YyR209O4ooXACFRYyR+3U/KwrPP
 KJI0PBuGBpSdnggB11BPZaaXt9AYGVIiY+UNBOuQ35W8i+p99WlpXUtAIn2GfOH7u2B3CYW8/hI
 ZujgK/G1QoH/fvWkJXesmDS4r/VNFJqbaXljWKVfOZ4/FtitJu+QJdBdf1UfJrKDjltSs83mJCp
 rpw20xQ==
X-Received: by 2002:a17:907:7b82:b0:c0e:883e:93fd with SMTP id
 a640c23a62f3a-c16619189d8mr390316766b.48.1784101220517; Wed, 15 Jul 2026
 00:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260714081124.90962-1-mhun512@gmail.com>
 <edc9c916-1a9b-407d-b2e4-cd8709287a34@intel.com>
In-Reply-To: <edc9c916-1a9b-407d-b2e4-cd8709287a34@intel.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 15 Jul 2026 16:40:08 +0900
X-Gm-Features: AUfX_mwF8rw8M5B3ICI8wj67I6_sihRqUfRxt_fZ9SmAsrUyUR8MYWyVag-xsxQ
Message-ID: <CAGEsz8EyKpppgu57nsdtw73H5HSufgKh7GMMhZcQuaJkQa=WMA@mail.gmail.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, 
 Milena Olech <milena.olech@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784101221; x=1784706021; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=igOCTwbRnr8tA6QltCFIDH42Xkuh1DYpx7zUIRQrrmQ=;
 b=qZtJu96wD7XD8nZ0YwAWuZJA5lahOQsg2Jg6TcwVSp46dL2/Qr6UdXyIx/nTMa5KQS
 ssrr8Lj3fu50F5qKncJ2hNvN6MJFA8mNA6kTqyRS2mg0bC5M9gZrOTIpA0J2SxfIraEU
 ne+K97015RoAQTPEE7ZdACtJArp2eWm4xQ5DB/SZYcMUWc90gw/O8hIXaDkQliad5SVM
 rIxD1a1ws93RhOo8vZq7YHU5rYADBES+ygVEWVQ1mzXRey6+6M4OlSQBqVir0Jpdd6VJ
 oIYd4LvnynQQtVWmAkSS1y34/zNSGuen3iFsODKI2TSE4XV3hz3tWVTb4/vOpobZeNv5
 LOUg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qZtJu96w
Subject: Re: [Intel-wired-lan] [PATCH] idpf: disable PCIe PTM on device
 removal
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

Thanks, you're right. A successful pci_enable_ptm() is followed by
several operations that may fail, and those paths currently return
without disabling PTM.

I'll add pci_disable_ptm() to the common probe error unwind path and
send a v2.

Thanks,
Myeonghun

2026=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:37, T=
antilov, Emil S <emil.s.tantilov@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On 7/14/2026 1:11 AM, Myeonghun Pak wrote:
> > idpf_probe() enables PCIe Precision Time Measurement with
> > pci_enable_ptm(pdev, NULL), which programs the PTM control bits and set=
s
> > pdev->ptm_enabled when the bus/controller supports it.  The teardown pa=
th
> > in idpf_remove() releases the workqueues, vports, mutexes and the adapt=
er
> > memory but never calls pci_disable_ptm(), so PTM is left enabled on the
> > device after the driver detaches.
> >
> > This leaves the PCI core's software PTM state and the device's PTM cont=
rol
> > bits set with no bound driver.  pcim_enable_device() only arranges for
> > pci_disable_device() on teardown and does not undo the PTM enable, so i=
t
> > is not a substitute here.
> >
> > Pair the enable with pci_disable_ptm(pdev) in idpf_remove(), matching t=
he
> > igc and mlx5 drivers which already disable PTM on their remove paths.
> >
> > Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/=
ethernet/intel/idpf/idpf_main.c
> > index 0dd741dcfc..3d3471d3f7 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
> >       mutex_destroy(&adapter->queue_lock);
> >       mutex_destroy(&adapter->vc_buf_lock);
> >
> > +     pci_disable_ptm(pdev);
> >       pci_set_drvdata(pdev, NULL);
> >       kfree(adapter);
> >   }
>
> I think another call will also be needed in idpf_probe() in the error
> path, following pci_enable_ptm().
>
> Thanks,
> Emil
