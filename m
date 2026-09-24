Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B499AC9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 09:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D83260B67;
	Thu, 24 Sep 2026 09:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wim3Nb0KyD_z; Thu, 24 Sep 2026 09:56:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 708B560B68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790243806;
	b=TBT97K863jeio4BcTposFRnIHcEC+UJ7MkJGyZO4oGrXlP/AOmGbX1T4S659x5EmFEV4
	 6++CQG2OsHOhP0931emoe5B34X+g1cNqjMGVGxTWa2ZDlAiciJMyivAtv23HvoOUqpsMK
	 NYUUE5KECYTY0qgRhYscq8oWKyruIzfPEu9zIc8+mlrE/KpYZ3K6vx+ZNPvjONGnyIIrz
	 sWbfpydT5i8GcjGsBNPx2RU0wAO3Su6uwvi5+i9BuKmQPhW8B6rrQXf9eP1Y6pguwyEhA
	 IMzOi7WEeqlQWMsxv2XrQYseR9ythxJoRL7YGFNfE5li/Mv5Suk0wUHLmR89XY8dFhA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790243806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
	b=VynLU1x5TOUOb33z5LdGDDgLhTJQ/57zx4DHht2zRE7DC25ypv4i4qUWg/KWxq0OLwmL
	 sFL/BCbPxcDFWq7Dt22lQgmV84fDbFG5A+zTi32boEzlky83SuwYkH1dtTSFph7NnuOZS
	 q1UNZz8/RcvSJjpRewErR7kKOSyq2SZMUS7P9OTACrP+n6oH0O/TVKtUivQ8zlZOF/RaI
	 kYxC31XHROt4owxvQrGM1EmfzlobwFjJgorsTH2COP1xF3V/Yu0WjRN059lVN4Stilux+
	 v68GWMSnn2zNQnonAhtSx8uNIiTK5/fU3LSz5B7bnpgHLTfHWXRB4rLC28WVN3kFoXA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790243806;
	bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cDQzuGb33bSEB5Cjx4UNdO3NBYpsHyBAf7ieqB6bLhZEPo4fh8OD55a4vExAYuuMD
	 YueKPqIchPTj+nkfuqpiqZ2qCfMs+uOm0jd4JsmqU5bLXfkbmXxDKvjQzkiVUgVKBF
	 GqTGE5RxdmuEPVIYwjZ8dWTIEznO+qUYq+BtwnHC4iIc04G2RNtiroC7yu6d68qIrx
	 e+1j3wp7rzFf/r3hgU4H2TUf4n26xTXGAdPgUo+tMmlQHSsGV0jr1UMi/EEkWNg50X
	 R2z44NWdFAcgMh7jdb3/ZsaycbV6N2k7p57C3Nkrf0e49b3HNzxCd3CmhG2dAOSJbq
	 jQYTF0M/ayw4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 708B560B68;
	Thu, 24 Sep 2026 09:56:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2159392
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 09:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2D9F40D98
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 09:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaKGpaAEnRVl for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 09:56:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8692940D8E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790243803;
 b=ID4b+IQ0RTTt25qb2LcLUJOJ903a3xpRox3Ck+eOegD1E7jvvGXCghqA+yKiFOYF5Upn
 eHZYhV7Tti34PakVY5Iu/UylI4TVTbGT5LM4YChrqcorAQ4RpMnmdBEVIouNP5njL6RNb
 Ylc0HyNf498O6GPYyOcQ3xlNF0VRRuy7vn0/su1pz50QOXsxjnvde2RNEsFFpyJJ0Bz3G
 pcom40Gf4vptp/SyVAZ61SLNa6pscTHlFd7dbsw1YcTDaHS8KSfgP23XRycuyrZXsE8Nk
 txlDU3GImkwa68HiN7Dg+SUqT0huFbnmfr7nIp2WHa1p24ond0f6pAuLa0XPY01JyBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790243803;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
 b=ERNjEe9EFrjn+NqkM2HPWy3KfIr5k1cmhxQWqXFScfujI/mxjGkEtggvmwt++8aHi6dZ
 k1ubCl/ZTiOcdMLjzgIa7CKB28T5Zk5q7FoUm+U2Qa1nW8oF2hZSko9eRkvcCrWtc+l37
 8qZPdV1zgJndUIT49eIXQtn20LFAxIGCUqXvkpZ6mUIBjbUNthVsJnYO73hJXy81Q0cxA
 O5BpXw+HOsPLE/I5bkx8gQzDyi9M7uHHvmXAXaNv2Rn5/+6xCB9dq+yGReySSFo1mE200
 mEh6wpWugLU297Q9GD/rSVpCGVPrQIWBPy5adOvYaiCCciGwthDAJ56hHVL8PpiWbSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WjkAIRKL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::f;
 helo=mail-qk2-x0f.google.com; envelope-from=nsvatoslav515@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WjkAIRKL
Received: from mail-qk2-x0f.google.com (mail-qk2-x0f.google.com
 [IPv6:2607:f8b0:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8692940D8E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 09:56:42 +0000 (UTC)
Received: by mail-qk2-x0f.google.com with SMTP id
 d75a77b69052e-52fb76906adso31304681cf.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 02:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243801; cv=none;
 d=google.com; s=arc-20260327;
 b=m/tEQrTAQeVTTksLiuUEgafgqmRaqPk6XiaOh8pDTLth/r7EgUVxwEbLgwtvNHZCY3
 2hoSNj1AcqJ3i2pjqdOWpf6udOQgMtYQbfBDNg/HSTfOQSz90E5s+38m2FwM2yRClukP
 zFIhB/ppKe6+Z1smqr/OVdoX/TiuiiiYY3YM4Skcl6Yhy9qQT/IXeLEssq7MTxQZhccd
 dz1XL55XPHUYIC34j14HwoD1B7CzjxYUFQJCWTxg/LJfc9/0uTpmwxc66p4qEfgZi7Qc
 J3bwMxACdHKVTCDaC4mLozkbkE21KjoPdYP+dIhRKUfYui7GQfWBrrpf++qRVPWOTBfP
 7BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
 fh=MRFVB32QFxmUFkDCcscpqZA3y7XA/4ROTDqeZhoHeTM=;
 b=sOJSd/k63mA6Zi7BjjigzEzgcM3kPDq84Paa3RFhhfs9m9EcW+WfKCBEDW8d/kQxBx
 2AfO83yW1tAktN+YvRddwgx9p7A+Ds0sYsRD4Y+/sfCdrMMaOQryEj7DTC5a85gBF5YA
 mGaP3/jx9JAOlZ86Mn5wRNdf0752zD9A74gnqTHX9+eS3NrYSim5BwXC/C7urnnKCvUd
 paVBpwlv079tGFlS2El52Joj+PfygbEhbEssJSCa2zxe5vAJqvujxcWqcUXlwFm/te9/
 8Ij4WsD4ODh6sFcHJ9+pcH35rBp0F34sOCGFyB2AyI22RsA3gFSTLuwIhYFcJWGb/h3u
 Cm5g==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790243801; x=1790848601; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
 b=WjkAIRKLNeOCb1Cd1/LkNgOybdjuwcqX3/SoFDaZ6qf9r02uYsuSz7x7fLqQU65BRc
 T3s7849v5ElMBT9e3vUjNBI9Dd4Wt1Be5vZy7+NDf6MLFXSC4aT+USU8nwVoYJHSxmwD
 G44qFHxcY+x2VSpbuxiIAcCVujjuZ4qm4Qr9wSKKWpy/jwvTy1wGbbL/1n00E/yHuczX
 DIAyfpfIq6ZrSmFeHKrYM5Bn+vISWjKkUcktCoUlcU/xlb7EVDcmNF6cItjuVSWjSJAi
 Pi2AVhDtcrZMo8munuqrskRGtkzY0YKl3FDmrhclkJkapEa5KpoBkx+31VvCJa59oMqF
 0k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790243801; x=1790848601;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
 b=QIkrmO+qdd71/OHNhUc1ib+4MRFnQE33F+LxrtdqMYP3crrRz95ImsuIo95AtKNLnO
 A9S7rR3ssFBtBTYq5890nGN2k1pwPn87+ap4nT82BqegKzWP1ULUmeTCtgfBic43OLUx
 19HOUk3+Sjhy8X/M8d6NDEPoVuAw6IjdqZGHCIbOWQDRt+rnHx2r6wi8NHyftF1X5qXp
 4qqZ8iFSOFcBUxkK6oV9hRjxr06r8laToQKV+nYSg0VBo+J4gTRu1219uTz75/C5PKy0
 hJneBfPRBgYf8OBYt0gh0BVgj9RxRed61FQIgWDQHbQTu7KU1x9aGUX50JKEaQ0Ha70/
 1CbQ==
X-Gm-Message-State: AFuF++kmHxUmbr31+Rp0rD/R+o/uqNe4IqsBB57RNCGZ/j5tLplm0Cv4
 PS+UWPA1fW63pB1FYjtkr8FaWSUGCx35B8JF//2ouM31tHy4JMNxJT39V3AtDxr+VUyrktzKzRH
 /5QHGjM1relWJQpSNRllCSY8F6HsLFT4=
X-Gm-Gg: AYBFou1dIiMq0+I0SKRclLwN8nXrkwNUPci49q369XM4UB8ClL5VFbVBi+iCyF+beiJ
 p0f8RiVid1XC+RNDXpPn0aSGOTUH8e8Pqy/V5NrFz8ZAHsK1rufP3F9XZAaBgJNmB71Bb7HGM7g
 C+jLsHdum93V8/lbfzDJVqw6nAtjQtGbtcvm5k21lIqj7ZUGFuRH2UKTX2W6edK+lFhJrg2sAja
 HgtvcY1UnU/2X1rPmvI3kX+QH7mxbeZlBgZtXQs+SSf1mSDmPLlCL+9pwe17qlBCVYgCtSjh0CJ
 ldXAIazPJiX67QDhRMXmCprXzNwZ5a37qYyiWeNrW+xxM1e+jYgCNMwc
X-Received: by 2002:a05:622a:410:b0:532:d838:12dc with SMTP id
 d75a77b69052e-532fe9eed7fmr14187851cf.3.1790243800860; Thu, 24 Sep 2026
 02:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260924095152.3069-1-nsvatoslav515@gmail.com>
In-Reply-To: <20260924095152.3069-1-nsvatoslav515@gmail.com>
From: =?UTF-8?B?0KHQstGP0YLQvtGB0LvQsNCyINCd0ZbQutC+0LvQtdC90LrQvg==?=
 <nsvatoslav515@gmail.com>
Date: Thu, 24 Sep 2026 12:56:28 +0300
X-Gm-Features: AclHuK83QQU4UjKE_sfTN9cHFKc0YIJOfadhF_smKbWELBPGpi5wSU3S_A9rXeo
Message-ID: <CAJ_tAk7VFvsRk-suqg7-JJHcm=N1kEt9-qgg6sD+u5oAfyB03Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Please drop this version. I accidentally sent this without staging my
local changes.
Sending v4 shortly with the actual code.


=D1=87=D1=82, 24 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:52 Svya=
toslav Nikolenko <nsvatoslav515@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> When e1000_probe() fails, the shared error handling ladder attempts to
> iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
> not a CE4100, this pointer remains uninitialized (NULL). On architectures
> like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
> which is fatal under panic_on_warn.
>
> Fix this by conditionally unmapping the CE4100 MDIO base only if the
> mac_type is e1000_ce4100, matching the exact logic used in e1000_remove()=
.
> The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
> be valid for all error paths reaching the err_sw_init label.
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dca1ef9e2e234b8d3599b
> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY r=
egisters")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> ---
> v3:
>   - Switched from pointer null-checks to checking hw->mac_type =3D=3D e10=
00_ce4100
>   - Removed redundant check for hw->hw_addr since it cannot be NULL here
>   - Added missing Cc: stable tag and Closes tag
> v2:
>   - Expanded commit message to answer reviewer questions (reproduction de=
tails)
>   - Added appropriate Fixes tags
>   - Added Reviewed-by tag from Aleksandr Loktionov
>
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/=
ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -       iounmap(hw->ce4100_gbe_mdio_base_virt);
> -       iounmap(hw->hw_addr);
> +       if (hw->ce4100_gbe_mdio_base_virt)
> +               iounmap(hw->ce4100_gbe_mdio_base_virt);
> +       if (hw->hw_addr)
> +               iounmap(hw->hw_addr);
>  err_ioremap:
>         disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter->fla=
gs);
>         free_netdev(netdev);
> --
> 2.47.3
>
