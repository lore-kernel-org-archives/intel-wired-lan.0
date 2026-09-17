Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E69FC982C1
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 01:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04A8980E8E;
	Thu, 17 Sep 2026 01:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4G4C9MvDQt4C; Thu, 17 Sep 2026 01:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4701480E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789607651;
	b=aVfUSEjCxUZaxHtsNFUQBzl0Kvk+14EQEP9PphFE1ND0CaJWT8Pn1eSrbTIGWjXOHJiZ
	 Iaw+A1/uXjBCwnyIiGAy0STQnEsDIPvFBdw+L4u4c/e8pAMDswkeHuoU3AV6so8CYL4Xw
	 8/G8W9Do4+GDD7cASWFhC42uG43JnAfmKXcvgb+7L2/z+nahM2JigEcbY4E8HjqnGN9X3
	 SPXkd4WErMGoCmfSw3ls4JzGimqonQIhShdCWn2RgGHoaYbPfw8bqQbwmm10Z+mtD9oGb
	 S+xSfDTwgnRUWXXnV81sNa3wtZjXNewYwvi6UCyNDsu+u1h1LE+UA+rQp4ocKeBPvXg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789607651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wTGN7iZGG7qgPMwpmI5YXoFXqkPE5QrJoOdP2J2UgqE=;
	b=cTmkZDx0UX73z64mqr4815EWirshYK1G7/OHtZGmObsyFwBPkMKUPNYVwsuhgF32hF2k
	 9YzniH80U0akgaUHiqNgfxBpZcy5lbEqyBDnJMB97EYdvkJ51pL2hbTjvWROf/gP0Yg+3
	 DztyNJ8SPZMAUh1w+sTrgeshcm/sh4MhGyz/yPztwn3TET3C0JgTqxupfXTACOImww6C2
	 buc9YdeFK0fTBbgEhRCJzBH9s0zV45zSHFJMEGmkdjiiC9asqK1/Dq0qIbq0I5XN5KDP9
	 rBnEbg2krExy3O70XtO7FsnSeAYaLV8lxr3uf7e4NI5x1DSwt8HObYvpqUq7W5pYRcg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789607651;
	bh=wTGN7iZGG7qgPMwpmI5YXoFXqkPE5QrJoOdP2J2UgqE=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HROUnvFQNanlFX17j9Av3Kk58FHF2j2nUvSaMA03QltKQLj4wrjOTjyi0VAIyRDoG
	 Iof3hNJxg+OYbZQMwOEyN8btrRz7tXrN9F3WBFSuIRo7rL/jurb46NkacxGnbh8eND
	 +fjtxCPEqKQ2Iwp0iJCsJeLWpiC/FWIDt0zGqQ7aLJxBLoWiMTDWY1L5cV6cbfOfdU
	 WME+ee4kk9jGOMpVOzmNK8lrWov4CTt4kH4yu+zwUOMvFG0ELxI1HXBedGVuA95mNc
	 fRzm7GFN1Op8L9AfIGtn1BbrnmTOWw+zspUJx4Rl6y6af6oSe5UlfDGHpt1ScIkRzN
	 ArHKv0DLRLZcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4701480E9C;
	Thu, 17 Sep 2026 01:14:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD84637A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 01:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B73E86062D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 01:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTyQLetCP_qf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 01:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B5AEF6062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789607647;
 b=gvWwMggbDTWxMzEdVMPIUfcZGQHbreyC8V4HqChps/5h5lm2c2llvvC5id94yH/mcY0i
 rmyvWhWy5HYa9jr+Cz3OFjY9sJ/YiNE0RxS9RrO+6VOAReKv/SJjbzNq4q28mfyT0KxuU
 7efL5JX105DzgIYncmIm9nd0ElFH83poD0xnPyoG9CI7Xv7QbSV9FF9ipp0LP13KZmH3S
 fqSAcVnJFhJf5cQpqJvhQl86qeWmp+AeEAhJSRBoaya4wPNyuSY5DkT0M3M9tUK629T1h
 x6uEvTZs6sZrQtI1/Rr+r28IwVEjyqZnmknkwnsn5Uv4YXINSEGgGdgBR9gsxTPWPDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789607647;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Content-Type;
 bh=wTGN7iZGG7qgPMwpmI5YXoFXqkPE5QrJoOdP2J2UgqE=;
 b=FJCTiSweEtTt8vZb1jC1CXsIiqwxmwWNIA3SXDNkAQ34Z3m+WjvPgfAs8BY5c9t/4AQL
 CbxGf/rVnLWr7SX4Z6U7ECRyQtjQgBqNMCazPLV2AX+CRlalCAo4lZ9C3kXSSnloKx1pM
 SkiS9Nk8ti+iooMh5CrdT0IBorxC/Qhv2CBy5R59+5l+lIFmGM6M72S+x7q7y0K+MK76B
 7aVJGhpSkJoh6JvcTVIaG/oPHpyAxtx+HYLVEkL2yfImAkE9La6Tu/QAVRuMilFzRT1uF
 qU48K7a5wmDYAFGfjflVJJ45ZLek62fzaH13qgDLzTWYSnY7aslTv60pAt2qyi9ykaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="KjYD/6A3"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=hayatake396@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KjYD/6A3
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5AEF6062C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 01:14:06 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so507906a12.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 18:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789607644; cv=none;
 d=google.com; s=arc-20260327;
 b=KjZRI3ZOnKi7zQGFdlPETA++5NtmrvusaCQd1pQHSe4VgUU47xQhoJlU8RicM+fty7
 TfxWaIWXmOFuiOoDnCVfhUm6LbFA1uO6pzmcelZRT3u1SZCAjbKFS5iJYsVu2oQDdCmi
 qagK9boc9hB1qdwNN5KlE0Lhk8Fg4oZUCXj/bsaewqBWPMFJ6K0PxeAAOBwibLcxsYfb
 mRNXTRvl1HL3Zap94DV2T1RwZzT1JpkcqHDc686EgkAsQ6S6gu0imyZWoONtOrSUP3Rp
 l+vkLlKNeeilfpg59yfbVl8z9tQ4TQELHcdsNQvudYzIVIFLYEXOa6HOmlYEk9wAn8xB
 aR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=wTGN7iZGG7qgPMwpmI5YXoFXqkPE5QrJoOdP2J2UgqE=;
 fh=xrfjxzsmzMUme4pJRNwW+R4Rs/Aoywaq0gyH7HsI0GM=;
 b=eR1Wu1Q8AXHY0IyiiXyjWJ7+IvnG+Evm0YlAfQ6+Vu9E+jXkWNXFIftmz/d4oYHrS0
 4x1gidg0FULCmF2zC5algbnO4sm11LLlwlIaxWSLP7nXARdT1xHkpxekuKWZAusejEKc
 dcPJv6cQ21abHpBN1p7wMCpRk94LulcenKXmHzt7Qs0y46pW57CmRtVtnLEOnftpjFjL
 rgMCjvd4oAAxBee3uU+1qJ4TS56aGm91uNGd1S2atY22F+ygbIIBJj4RnsgdTGKXnOyH
 W804pnVitAOVaji8JyKMe0swrBlTb4SYIDmc4xDouCTahVqFGTWHjZwbDR/ApXHJaY/E
 v0gw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789607644; x=1790212444; darn=lists.osuosl.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wTGN7iZGG7qgPMwpmI5YXoFXqkPE5QrJoOdP2J2UgqE=;
 b=KjYD/6A3J9teqpwIsan7mnNV/ltbYosC7SXt0rpNTtN+IiIG+TG6JbiD49atkD8rXv
 I50cqJI1p6En8zOnjz+DjQIOAs6UH9HmFqzzcv7hHvdCpEnO7LhPtbleWP9M0mB8APoR
 NDxy5aJHHY5D/g0jS4Nzv3Q9z8sHZcJHYaaHE5uOyKyKyX35sAxYMDHR9dIlXEY5mZrt
 Rf3QsH6Z9OUmgdq5k7R2hl40Fkjf9SWFL2G5e3XbW99wUTcfZ83G6zv0uM5Rw4A6yp4L
 D0DKKggZ6Xj5Y3rkiNgMKV9JOJBQfuWjfO1ipXHyLw/BlgrKVFLwRcjxdESEQc4VIF0B
 HmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789607644; x=1790212444;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wTGN7iZGG7qgPMwpmI5YXoFXqkPE5QrJoOdP2J2UgqE=;
 b=phluPeUqfiqL36qyJbYi+LmOl+6kZ4y7ZMPyBzRlBHt0APq/5FDpju9qJPeaFezrBn
 EWlvEJgLDbuiCr+77hB6Dn1iiVFv90Yo0Atf7a+5lRUPhKavCWMrlF4K7e6QysMH5A85
 DZbTbTf1lQ79YKoG1PVx1sC1qeEFjcLwPO1G/IiJ9RbKWw4Mzd3UBodOvnQwVXpIA28U
 JbMrZROjlSTYOhDKoXoIOrszcvVlJImLqIdOnexNgNWkM/0vfoc98rFbdM950VDdaPAx
 vdVwaD9J/8AuaWP/VV3mPnzT50W6ouskrN+XFAK0h59CJO/L149CNcoMl7NaSReUoCcQ
 NiVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbAyKOiI98Z1wjEt+bXVGcjlZI6bKf//nti0wf70izvCC1HHJwZazxmjZWf3bvcU03ZKnxCkJjhHsiMdz3Zhw=@lists.osuosl.org
X-Gm-Message-State: AFuF++n48hO/f1YuTzthi5QVTIjWVhhTSLbRkRvv4bqpc9hOefB2fXU8
 cJRB23UM/ZJs1GCgZOCqa7JeRB5u2R6XM70bt2jeK74AJA+a2aRr5CprUftJ3MD62od8Clxz6pK
 EEobC4s9ZEO+48FjG19TQwe05oXMJ/ck=
X-Gm-Gg: AYBFou1rOoUOMfLBSsbKOyIDmJ+irKcG5aidFg0QnBqlQ9Vkc0Dc063WV7n+Q7e+UIG
 hhtGkvIbO5dzeSHWf8CZMg+JIirftI3vaNp8iRgH6JgR4gtdb/89oGJghXR83XrMgnXnhkiNJYP
 ffjTiUp0pFmr1DtdZIAzneWVZIQe/9iiIiSENoL/VRCa7KlcoZWzLXJnP4ehHA4kyVrPAojKEfZ
 hL/FJ9givjFTR4jb3YR/P+K6z95WvKWeTZfJiR5Y/lPmqK3kA5nDPBS43oRFZqOUr2Nsr5IT5J2
 zy0DU17AtLtWR61OmjTsEh5Wwt2kRRH2u7Rswgo+7J/YccaQDIOHspEq/B3/G47JIBzFYEMjP7g
 afYrI8UPeZz77EhxXVoFg+I+24/h20Opg5qRGNDCdOTx+
X-Received: by 2002:a05:6402:4441:b0:6aa:19bd:dc9d with SMTP id
 4fb4d7f45d1cf-6aa224027aemr7078573a12.13.1789607643731; Wed, 16 Sep 2026
 18:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260727225659.Cz3qz%anthony.l.nguyen@intel.com>
In-Reply-To: <20260727225659.Cz3qz%anthony.l.nguyen@intel.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Thu, 17 Sep 2026 10:13:52 +0900
X-Gm-Features: AcwNN1WNHJmJROdyw0qXGCsNQNq9b2MdTl530NFBfTrjxcdJ4Itk6wE5bd-Z7-Q
Message-ID: <CADFiAcLvxVh=E9Esjh1fQBVqtu-t_=8hyTCW0_dfb2VTKiJ6=A@mail.gmail.com>
Subject: Re: Patch "ice: fix empty PTYPE set for GTP RSS profiles" has been
 added to net-queue tree
To: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, 
 Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

Gentle ping on this series, posted about a 2 month ago:
https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=513764

Please let me know if anything is needed from my side.

Thanks,
Takeru
