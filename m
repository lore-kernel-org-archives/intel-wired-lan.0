Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB44DCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 662FA607C9;
	Tue,  6 Oct 2026 14:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9NqQ-QLedMN; Tue,  6 Oct 2026 14:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D463607CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791298526;
	b=im3o+DC5UQFhpPAY+WyfvSFEcb3QpsxyQaz4nd53wQbN+Qw4AyiTWnaRQBJ6qC/PEHLo
	 VhtxRRsnNoOGbwn8PdYj+XRZ+PLtdaeVXcSVtpkENXa2+ec5uDKZSKYr/xzHBLvgnFrK1
	 WwqbBM2vyG8XLNDxV32iUBaNFOkQjODBopdGLIVbTn1KxkxFimNAaH6xS0VdKbGpygb6h
	 NJ9w+ajyJpSUSAk9nK4QOZF0fwoDHBZbLUKn4aCR9GQCjVrI0xLIeSokBo+hJtXat8KBc
	 BW1xkNh7QqYD5Ywkb2s6ujPAyrPCivWzeEVUmgd77U+jmq9MbC9s39L9wCYmP5dIX/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791298526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=zup+xfscKkCJpXAuPoFx1vOFSbP1cn3d/Ubl9IkjUeY=;
	b=Nqifo5tJb9ENPhHjgMEamw6BY1yr/wgsYD+3y2cVWoHz5q7/5aXZJajYf9PmM6kEObX/
	 hWvhiE/EaIv04nE684KqGoQte/GfrQZVZWQNg1Z93kI2oHpzTrn1mMR+F2DG89JHSqiRQ
	 cee9IQrx9mcnHUXGuN6oLj/L5Z3UQizUQGgoXeXZ70JHFRhBTRusttZWmZm0a4gapZmki
	 MutF97ohe2o2zxPbCY5Utf/9f00d5eGFORDQECWWiPTUY9SlFQBn/wxwIt3eAuLif3C3M
	 tRumy0Bh2CWSqEdDKvSU1+Ncz6n87+l7RbsIDTg7oiQuH7jXVKPreH2MCJ67NcHGNZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791298526;
	bh=zup+xfscKkCJpXAuPoFx1vOFSbP1cn3d/Ubl9IkjUeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Taw7hJYQepdEmUyN1k5OSECsjPJ+hENbWeop+s/43grGj8oGoAlKrZ6p/MPo4RpjR
	 OqfhHIT/k82/VSwoKspBoQomLlEDWF8uLrHbG6Dg9yQjahvgBtgU+rRk9XA3dOph06
	 LS+oQcRXvFXZ2nBzhcMpY7JtVvGh7Juxh2Oyxdr4N4QaUKczyuQzaKCfF1+QoM1zCh
	 XCNmS7uutomweZn+U9zyYoFXkfQWA3rYKNm/Cq8dU28Xfqx903ao+h+AbAdEnakNse
	 KrzceYB1wZZjjjWQkd2zohYGI7jb5zK1na8UmPYIk9R0M7MW1dXXKm0G/UzG9A4v8l
	 01O9xTf260cHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D463607CA;
	Tue,  6 Oct 2026 14:55:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBC031D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D10F440604
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrtGpibcnhDo for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B28640602
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298190;
 b=Xd9Ddx0SpJ5zXjg+aXV1qZ6iWJyqK5TpY0f25PF1eJTjXGaiPpNUKEoj+WYPjkHG5YxB
 G8g8hCfqco7ihxMJhZC9YC43w7YgkmyzuICIVSnoeGaX5/ulZXtQPvjw1Eiu8SS4JXI9Y
 6WiRMVKkYpDJgYqgybJvsNKniC0J3ElkFHnrf3GbOBCwQRVzes2xwzAFFrc+7yRBMOfZp
 26b0O/zCqdKTXUcO4qPOgWQZ7auMWYusSd2EnYC6PL1YKkCsVY5/+ODy0shPkbQcfweEi
 vVYPnTX/3zCEtejKcQqOplJQwHXKpasA4c1JilpttD13B1e2uzBePA5BCYfPik03p1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298190;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=zup+xfscKkCJpXAuPoFx1vOFSbP1cn3d/Ubl9IkjUeY=;
 b=M702ssEDZ/7Gs6xjYIgtA7w6bzp7AzvKBXFC+KT6q4WpUZdQD8PaLd6MepeT+vq/GG2y
 W8y09LeLvoPL8KbI69oO5Ld9KA/BCn8BXVJCRQdtlL+mhUnv34ssj63ltGsCSgIBp4VIF
 hB4Ma0L8qJA8mdTnrZmBTaR0Fw8Geb4B+CN2AIyJXiI0+DbmWLULf4Xe89btV+ZsJ03u6
 VNPINmMF+hZTsR7MD07ia1PzFVciMCkX434yAXgcj8pLj6eQYTALI/W7WWtXLkvcSKP7X
 LC8DXRq5nV+6Mn3K1LAhCQT4GPzMPt5c+8vAGvsSg7UQKc02Zz4zuGp0jklX+q6owIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=grYi33w8; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=grYi33w8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B28640602
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:49:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA66A40949;
 Tue,  6 Oct 2026 14:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734FB1F0089B;
 Tue,  6 Oct 2026 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791298188;
 bh=zup+xfscKkCJpXAuPoFx1vOFSbP1cn3d/Ubl9IkjUeY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=grYi33w8PynkJ892vpUggIeod72XfL8A0XPePZtLVx2Dosj0lnB0RS8RVEryCuEjZ
 NAtW2LGPvQMYz4PaCoCOO7BplnfK0RDMIIYFhzAY+QtkqxFB4Xi3MupJiugCUi2rpm
 kPBgN3Sjom05mAl1fToG8pFP8AZ6MGEfnUZxlMDn45r71nMiIm90sfyXgmXefn4jHT
 diTeJnoj9EaObLTxXYB9zIGMwmkb42nCJFgi1O1Eh/Qz7bF81F1lTDYcURzp+Bf/0g
 u7IuXZpvk9hBYOY7kNFvYubOCzmwhMJw0sHM81JmOxyjQe2G3qc4nYlEs+5WdFI/jx
 putJBK1bBEDEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3 2/2] iavf: return 0 when TC flower filter not
 found after qdisc teardown
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261006143723.2883728-3-aleksandr.loktionov@intel.com>
References: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
 <20261006143723.2883728-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 14:49:48 +0000
Message-Id: <20261006144948.734FB1F0089B@smtp.kernel.org>
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
- [Low] iavf: race condition in clsflower teardown logic
--

commit 3c89e574f59d7231645a9c5af1ee68174ff89b80
Author: Kiran Patil <kiran.patil@intel.com>

iavf: return 0 when TC flower filter not found after qdisc teardown

When an egress qdisc is destroyed, the driver proactively deletes all
associated cloud filters, decrementing num_cloud_filters to zero. This comm=
it
returns 0 instead of -EINVAL when the netdev layer subsequently tries to de=
lete
a filter that isn't found, provided num_cloud_filters is zero, to avoid
confusing upper layers.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index 2890e3c8005ee..c502e0a5391f3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -4163,7 +4163,8 @@ static int iavf_delete_clsflower(struct iavf_adapte=
r *adapter,
>  	if (filter) {
>  		filter->del =3D true;
>  		adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
> -	} else {
> +	} else if (adapter->num_cloud_filters) {
> +		/* other filters still tracked, so this one is a genuine miss */
>  		err =3D -EINVAL;
>  	}

[Severity: Low]
Can this logic incorrectly assume that a non-zero adapter->num_cloud_filters
means a genuine miss, ignoring that new filters might be added before the
asynchronous teardown completes?

If a user executes 'tc qdisc del' followed immediately by 'tc qdisc add' and
'tc filter add', the qdisc deletion initiates a deferred block destruction
via tcf_block_put(), which queues work to tc_filter_wq.

Meanwhile, the new qdisc and filter can be added successfully, incrementing
adapter->num_cloud_filters.

When the deferred teardown work finally executes iavf_delete_clsflower()
for the old filter, the filter will not be found in the list.

Because adapter->num_cloud_filters is now non-zero from the newly added
filter, the driver takes this 'else if' branch and incorrectly returns -EIN=
VAL.

Using a global counter to infer asynchronous teardown context seems brittle=
 and
can negate the patch's intended fix under these race conditions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006143723.2883=
728-1-aleksandr.loktionov@intel.com?part=3D2
