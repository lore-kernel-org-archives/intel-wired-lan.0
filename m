Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E0CC44508
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 18:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FF6B40748;
	Wed, 15 Jul 2026 18:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5oXVEKcIX9-c; Wed, 15 Jul 2026 18:08:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 240D540735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784138921;
	bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mI9pbIz8KhWeGHkm4RgDOgeeWSnm5aW+QnmS2GEfbQNUjoL2A7MZPaRGyk0Rm4813
	 Hy4vBSe0P5OwcOWeEnl+1z3by/AvcGUcjbvwAZpGTjQC93ajCmet0t6qRMIrDhNVhR
	 sFPDL0czc4zVMxmFKERhuCrDkzM21Ht7IzcYLMJ4iaevimbxe5I4w4Md2TUyeu3Zjb
	 W5tGlIrB57juPglx4AjhVTWwBNKj18ZqCl13fOZ8f29OStZPbBbY0CDtkfQaC6hZ1O
	 uOkJ1nOOq20boB168Iwpw6OA1rpZ15lD5vxzcB3NO3EnapXsEYmejQ3yu5/hMy1dBl
	 eJyAFaooKlqTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 240D540735;
	Wed, 15 Jul 2026 18:08:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 360891F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 18:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27E5840735
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 18:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6SZorUngzN5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 18:08:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=almasrymina@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 74D2040688
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74D2040688
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74D2040688
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 18:08:38 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso12025ad.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 11:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784138918; cv=none;
 d=google.com; s=arc-20260327;
 b=agRKVWV/WtT+vV0qOThhWR5G4fDBi+x6Go2mwjZuvHi66+LXQrijsNbqO/DkIWbzXb
 RTUdBUGC2/+x7f2hMJnAqKBu/tug0OKuTg6RiKkhRx68Afk/IwYyuFXeZPhARhClRA8g
 uHE7M4WXCU8P916Aw371UXe+XzydH/+OeU6dxxqWBX85lhrW1e5hLJafcRMfTIGWBU52
 HiI9xnk1mRa0XiTHSdzygpl2p50+AGWLc7ECaPEDbVFS+DE+YX2thGnjfMqPoEnOKqri
 E61yovpYr/tRiWDrS06jt22AOj5uK18gEMFEE+muVs9jQiqff3nZevwz/397YbhAdYl7
 ZjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
 fh=fwyXmgVEeLZLB46okv1AIEXIiL0w4JBSCDAZp0OTtHc=;
 b=iBu4l6QCq+6jihCIU4GVFcS8BAsfTi7X6w2hQLlyp9C/XeFEeRqq9xDYJ898HtPwkM
 aJYREuHxyTxgatfP+Dj+/1z1tS5azIfAAM812856/RUEHNP09PFTc114xJyWU+oZhO1o
 DrVNdh/bZ2N5uSjl3xAFdvH9uOM2HKiAure2SVl5DlYgUP1J2cr91vHkei61nCqYyGUw
 yYsoMOLN/zm3x8jzfykZSBpkttHwmHF2qQV/yxxQqjsheXHgQCJWuIi+DkJWRLMHXym6
 7M9ACusZSXAJ7HKo2zvHzk4BjHmvvGQItPebCjiCVRCCacPqUAnksbRJLTkLzl7+tVDH
 RLpw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784138918; x=1784743718;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
 b=lGPQ8zM6hb0KiaozyqR0AqKsuhOTe/zVwgW8wPgaRRKqPW01JRRp3dkMn4/nVrASit
 DpoFfy8fb5RN3+iW8x9mqUn2gY7XceXzSMZvnXgobS3f5tne15pvXJJc8qkaZ/PVk/ZY
 Tzeuu4IFzZ1EbGnaFXfBDGELj6aWAdRUI0mpkWn8B1pCRUoRDehVifkBnVM4GFtVnK5T
 wec94xNklM+pE6Sy59YCfDWkdftVhUoRddAThy6OBnyzdYsPeXxMHoQKKqe6xACfDcVj
 q23j9ZqcvZn/qMHjPID8cPuYGiW+bOWfbs3+Ku90wYCaiLtBgxMjuo+5J2kKprAQVshO
 TJtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy4aRLng7UyNSQ7cY9NCMNKnr4Y2kOHfgiahjtrbTwaGT4P1V5ORaU3aBDVktC/49HZyrCx5Js3JThMkoKrF4=@lists.osuosl.org
X-Gm-Message-State: AOJu0YyuyoDMwe1QIDTyehIrHFWEzKkda+a3bfqeosQioxyuAec7bm+L
 QkXxUPvFao7/Ryr40e/7cYxORpd4jgjTTmr1EfAki8HeGwPzlixtudNnnV/kG/IS5gt4/sGdfqL
 cEFl3MJbGB32c24hASD+iq7RGc2oZIfnBjgHk5D6v
X-Gm-Gg: AfdE7ckp7b+AyuJFQkFuUvAsQQNn7O9CzO61DjDUsru1Ik1dJjeGGXJ36m2Y4cON+Kf
 vu1wYKnEkWX+iB+Tg7uOF4zDQhpXK7V/L+xiQ0d8DbGrKPbm03wY6VzT5uJog7St/M/+xF5uMOg
 VYHidu9TRsh+LHET9uWWQ+8x5EQA4RkV+nIBjuwOzqJIor0B/BNtPGko5sV/PO8ghy+EFIXkqIh
 WtwlRk7yvcMb7Te24tWqsx+Fz0M5BP0GCd1FkBh7gGZB2VAhU/gvW3NixDfj6DlLDt9aZmAqgBY
 s0ng84HG4p/S0IeAEv3L07g9/qyCwfC529GE8w==
X-Received: by 2002:a17:903:b8e:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2cf1a94694dmr10215ad.3.1784138917054; Wed, 15 Jul 2026 11:08:37
 -0700 (PDT)
MIME-Version: 1.0
References: <20260715074342.49281-1-mhun512@gmail.com>
In-Reply-To: <20260715074342.49281-1-mhun512@gmail.com>
Date: Wed, 15 Jul 2026 11:08:24 -0700
X-Gm-Features: AUfX_mzkA0hD7asNtCMsqlVotbVc-A8PQP0w85ziBMNVAOzmXkB_qMwVa23CiHg
Message-ID: <CAHS8izN635zULNXH1UOejjjG7ZygwPD7EuN1Z2LXAw5qUFAfaA@mail.gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
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
 d=google.com; s=20251104; t=1784138918; x=1784743718; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x/AT8S3JN9glEWAK1CajRZOnoyU5JvnfFpVjCNdoVhQ=;
 b=v5bye8LAChzOhs5N3Qh+/3jbziBuPjdSfVaRPBlz7h1TmIpPdb2Kum6/bYMsY1G+b+
 KjzYscdxnaNWh3b5d5uKmMzWVkCG2MiSa0lJi319F3HBpT3G16GKpkfPGFnBuzrCcX1T
 l3GD8jsk5qBzkyibFDY6OZwTPd7zFjV+GvgGuu/Y1pDpZxfRKoWxENfKsxT8KBsaG3qo
 t2a7DXQBmdUHlAICTawxNVppHLjh98KIiD+8+KOS9urs7L0721AHbCMM68OpIcCHFM2q
 zzVDHIFSDhgKX/r6INjwi5Q13HQ50l67seZ5pGlhDpipWxoAEH9xufBPuisSW9GwIWPS
 v5zg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=google.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=v5bye8LA
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
From: Mina Almasry via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Mina Almasry <almasrymina@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 15, 2026 at 12:44=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> =
wrote:
>
> idpf_probe() enables PCIe Precision Time Measurement with
> pci_enable_ptm(pdev, NULL), which programs the PTM control bits and sets
> pdev->ptm_enabled when the bus/controller supports it.
>
> If a later probe step fails, the error path releases the allocated
> workqueues and adapter memory without disabling PTM.  The remove path has
> the same imbalance when a successfully probed device is detached.  In
> both cases, the PCI core's software PTM state and the device's PTM contro=
l
> bits remain set with no bound driver.
>
> Add pci_disable_ptm() to the common probe unwind after the PTM enable and
> to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not enabled,
> so the non-fatal pci_enable_ptm() failure remains safe.
> pcim_enable_device() only arranges for pci_disable_device() and does not
> undo the PTM enable.
>
> Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina
