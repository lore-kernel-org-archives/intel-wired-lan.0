Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7123CCC6B33
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 11:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27EF2407B3;
	Thu, 15 Oct 2026 11:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8USci-dv7ooj; Thu, 15 Oct 2026 11:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 468684079D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062400;
	b=KEQs7xwL2mZV7lgoI4I5/3bQUlrmouLZTYQeZx/eRM28HJ0H0u863glm/1ZI4JeDt0P+
	 7/MuGZgfsdlmJhBY6gUbQBHeuCB7GauDR79Y3BYNrUcYv3IEQUxS4GmkhNsyZy5SO4cD6
	 78wMfm8VcxbSRCUI9+np3jK33BEP8PdUFc9Mpx1UIg7yXjvayBHfSEJLabIgiCBIeg0x2
	 ZoskjP5h9W4aqDdf8LKIBzT2vjCHcK1DnZvl0dV7e0dX2l+laSWdG3axfdFc7U7zz6/KD
	 DcYT3Kvl0wqKzURfhjpCqUD7ai8vbjNFvr5y+1R70ox2f7hY2la2O+UN0mT+yVvRG6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792062400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=KqfRqeg55xllEmN+mW50jYksLUAZ02E+Rd/PMlv8ulE=;
	b=sIN94wSGrQwOMZRmIL+0QHKI9lvaFhTI/yhTWP5+WhPQfHo7k762Y+kWslhsUa1JatrN
	 jofy+GXY8BKIvSBMEf/+l7IFNxPLbRyZqXPR8orr1TpDgF9G8UIvxtMQDGgExPGbxrnGR
	 9qxXD2UR8gmzFmpyRZHKrnwp9SNAQipXAEqoRzOeHY+NDxZPxRaSdjG8KcmzK0ChxCTo0
	 YLUEL2go9b1Gs7oaHEbEA77JKXuO9ezlGAeMyZmeS2EdvEKZW4cABVb9+GfurNqr0ytym
	 2wn24VY66S8PAQQ1F9/drpw8lg8eM8RaPChdF1EwNYsWtqmr6HxNdywT+ykvEkqwz6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792062400;
	bh=KqfRqeg55xllEmN+mW50jYksLUAZ02E+Rd/PMlv8ulE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Z7JzZnQYgtRimBykJOvRryg4EhNGRVqj+ioQN8tqJuTb6b9i4g560JPGc7pBR1ETE
	 lhnykxcrXSdlB5wCHePDsPs9OwjjnFe+4qJnRwnSMf3pbpj5UcblO0xckIv96I9jN1
	 oeX8M8AMP1yKyLmUX0btGUhZx/nVUQzIjn/Agfsr7EjwWTUItGlGoGA92XqKZktwmj
	 NLy5P+eYRoUNBaRU9/ahe1MRWYzwWXeACofGMBxwoMETZiJ7briQOw3L0Qk10nmNxP
	 4Ux3Zm+RWpDtTF90rf+TN/1Qy93AYG+Ce0jrhBNrpf+2Rs4+aT5whJMqibgg5x22sO
	 gZt/inxXFz4dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 468684079D;
	Thu, 15 Oct 2026 11:06:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B01EA58
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6061680DEC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ods0Bys-Ix4h for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 11:06:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92FBE80DE4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792062397;
 b=cIxQkdh827Ov1SlQLVLd8OhBhDzWm8upv6cGZC3Vy52b9QsujAWxC6JMkitdryup/CvP
 Kik1vBQUJE8C12bWOiRFNu/qQ0QxpCoc1bElAypTpRnHp8oVF4yl+8K+GDNiVO0AWLFoc
 vw/iwnoSnArlo9XnYUuEQHoKeQH2y91agKJE10TW4kXQH0O4xBLYZP/gNqNx8EBJscuRZ
 SnZxTGXnXh4VYUbQJRm6qFCMlHdk6gM8ib5iOcwM/8o2w9hGbH5XvKGKG/x/rRWL6icP6
 IX7f9JoQxG9F5y7AeksbiOAp1tjAG/rWtsTtmN0GrJqo+XeeNbtIaBzTBv/FESGGytQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062397;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=KqfRqeg55xllEmN+mW50jYksLUAZ02E+Rd/PMlv8ulE=;
 b=bmRyl47fTm35ceIsybyL5GeYecbSQPbt32tU2ZhaP+GvPWXGlXbHb99r3ECw+Ko8ZJwL
 R12HTvl4kOte5G+sJ7Y53IHWGVwZS+EWHmi4kp9qpU7NzmBbPdiaxHNRO32oXK9GUbTYR
 anbTejxgPGIr8qqV+a92h+HgP/RzqEuNva8gQyzkRqH693PNJIN+vc+UPNGaYRhlREAhT
 H7R4Fo3tLr/7Z0lUXwYpoc16Mj1PRcM/PpGYKAJgy+X8BMeabe6jOTWGtPaFMYRCJCSWU
 orxEWznJZIjPzVh57piv3EleflyYHAKWduefsx0xLlOf6Zqjdd0Gsn2i7/A3asDynhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WUzRWLXN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WUzRWLXN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92FBE80DE4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:06:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F17E360120;
 Thu, 15 Oct 2026 11:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9660F1F000C4;
 Thu, 15 Oct 2026 11:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792062395;
 bh=KqfRqeg55xllEmN+mW50jYksLUAZ02E+Rd/PMlv8ulE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WUzRWLXN2Hqr3c+PD2riskNiEPATUHGhNecX4aGxha7TO+CGmIZ0l2MIitWDsYxQD
 YkUy47ljiiPEdQyhooBJ8ThTN50u4a9XXH1J2birV+/PzPMrDfqwNCtrndYpLVcSDv
 QSPK/0zwP3WNqpbF8Mbaz9Z1lUQbHHgx1IAIrj/LPhyizYTuTWOwWRqO0qJP7S60ap
 FzuUsZreuVNfS/tdal39AHw0tl+nGrtc+x/Pf3zg1L0PCkivv5prGtEsmTggj2L+JS
 0uJAId9NJSGCH4JIUAG9GTjHZIJKlWHPp5YC92yMZr+mpQbfY2mGdhQl0ezIBxCNH5
 b3GCrs9IQFaxg==
Message-ID: <sashiko-outbox-172717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: intel: ice: Modernize ice_vsi_free() with
 scope-based guard(mutex)
To: "Ayush Yaduvanshi" <ayush37735@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261014110552.56976-1-ayush37735@gmail.com>
References: <20261014110552.56976-1-ayush37735@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:06:35 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: ice: TOCTOU race in ice_vsi_free() leads to UAF and double-fr=
ee
--

commit e281bf0eed51082082d6b00b9ef0752bccc1ae10
Author: Ayush Yaduvanshi <ayush37735@gmail.com>

net: intel: ice: Modernize ice_vsi_free() with scope-based guard(mutex)

This commit updates ice_vsi_free() to use a scope-based guard for
pf->sw_mutex instead of explicit mutex_lock() and mutex_unlock() calls.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ether=
net/intel/ice/ice_lib.c
> index 9e08db376d3d0..c695df4428223 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
>  		return;
>  	}
> =20
> -	mutex_lock(&pf->sw_mutex);
> +	guard(mutex)(&pf->sw_mutex);

[Severity: High]
Can this sequence lead to a use-after-free and double-free?

The validity check just before this lock is performed outside the mutex:

    if (!pf->vsi[vsi->idx] || pf->vsi[vsi->idx] !=3D vsi) {
        ...
        return;
    }

Does this create a race condition where two threads can bypass the check
concurrently, serialize on pf->sw_mutex, and cause the second thread to
dereference and double-free the VSI after the first thread clears it?

>  	/* updates the PF for this cleared VSI */
> =20
>  	pf->vsi[vsi->idx] =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014110552.5697=
6-1-ayush37735@gmail.com?part=3D1
