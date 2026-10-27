Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95244606A335
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=tJGBXXuR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRPIqqJP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FF9B60760;
	Tue, 27 Oct 2026 12:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m80SG_YaO1qt; Tue, 27 Oct 2026 12:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8CA660711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105118;
	b=sgKlQ+pEblHFdzOslXiqCpDiL0QzIpF+DILBwpSP5PJQqvW/jWImk4rxUpzLmbCeCDts
	 xKX3jgiRZo2FuYWd+5+JSWq/7BR2qhkzCvDWbcw6XRVYm/84NsOmSGPBAC1hpYOJe8wpM
	 rqDlaJNuX+QtEEPhjLqUXCoX6gvpXaEoMcQceGf14HmeoDVnzEyeUdVjEmapj3tJc4zlJ
	 EkPsIYO0PXkxAesKckRiw+8aq9yUwo3qTPgNw/Poun5r0xsXFfKNfyJ9gKEIb9PFqPyy/
	 cGQ4l2loaT3Wt53N+c0AaBI/Ypmw7Zo+tj69iLdt/4aJ3JFtf8wQ/oLMTEzs+OlWNYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8rARxPE73nvg4HDl8BXq2HThRMe4cw7sIRWSbPBB7mo=;
	b=sROxXjv9i69woFuq2257AsJetUNyq0dbGDH9f4tVBrbHOpTDrhesvwN+SnlfkDvmhTCL
	 5HfnOCz+XQ/AFS6yBGqoSyw6rZwXdVqzZGxdljdKxWX4ZDE1m92yBvzfvkwJwCSLWW9Vg
	 HW7PosS8fSdoWiuTJvA1Mt+11cXNb8IrSgmgDyFkFg4ljncrNQE56LJBEZvFdkR9QFKRL
	 plwRd2LzmG3I4cwKnmvxZmauNbq8L3DlzdYSkazmuNEyF66ErpbaeqyCvAkbI09TcP5oE
	 cxs6zhUtgqviqx3IHqaL1NBXpV/DyQwttpPG1SLL2isjaI7xKSGozHRg7q8rzaf6kNQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793105118;
	bh=8rARxPE73nvg4HDl8BXq2HThRMe4cw7sIRWSbPBB7mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tJGBXXuRIgwVihMNLvZ2tl28W3Xous7xpHy1EMq9EE/YylJiowztf0PoNROZHHbcT
	 PY13tiC2QmkzZHRZM7/BWJpmWeiTOoWZuGUkvkgv90bMPqtOeUYOn8KVIj/K1KVsqm
	 K+VKXXAF7lMxEloeEn5YTCLNz12iX/8J1zE3MPgtDVmjCvxGVTg5qIc9DhsjHrwFa5
	 eXipqDzHHKN0xfV8wWTO+tE+VDmTzLewU0LKAlhgAyoJ/rAQl6kloz4zPD4uYmFd51
	 2mD33THMTvcmoc3WTNr6IKuqckU+79xc55W1rs2CtRq52tIaYqGsA3yw2ATzoSVf28
	 2dQAz85JBl25Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8CA660711;
	Tue, 27 Oct 2026 12:45:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 463BA3D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BE0680CF1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_cbqsMvdVWc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:45:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8604680D00
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105117;
 b=DLERbguq2uBRyOGJpaL/GHPpMPErWamvx+LkyrhvOyM0e6bt2z6ITuRIK4XJJOYH68oP
 nbHL5c7I4o6cDMyzTbOw6kglw7Tx5TC9x56/i8l7B3Z5N56kIFHcGWQ7033bCcrtmuDCY
 6yYc41ZNXEerOLEvTvZSskPYUGJ8kiyL76f657i9mdYqP1nyzqJaArwWqFH+RMRJoyOSX
 GmC1FTLESNyqHvSZqZWqhUBhKzlfeYgfO0FPq2fNeaPDhbYTeJF458xzsJEW/n0+EmAec
 9Y9iOaWP+6JLLIeUXSk2DGD7ytSOELz2tTEQi+RvzpqG/gG4b6UILULqnFKJB+47BfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105117;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=8rARxPE73nvg4HDl8BXq2HThRMe4cw7sIRWSbPBB7mo=;
 b=O+qd0sppFhWHV6kLZaezxgT4dDdPtGOPxVHkvjhKVNM7D5Hy/sVylz5RMV2Y5UchecRN
 cXom7Zl8U5L1zRwSCNVil1C3//r/ueN7wnSeGmJzks2FBxE5mKbrbqj088Mbd202Rb+pm
 LMf38D/3tpVL4NVapmySx8lb2v58+McsvpWZNZ6rM74CGQSRBXqO6RnzpZb4UqvcgK0Ky
 LK0KdoPRkkGn5GXUi2hakotFh2zC8j4z3XQdfHap9fEYLfdQzKzgs1Y7L8yATQsfaHOJN
 hei0GJClOf2EcXNXjcwjClZKnAUhvx8Pm4729QiT5ZHQTDMibuxkxUF4fn2pAR5gZoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RRPIqqJP; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=edumazet@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RRPIqqJP
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8604680D00
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:45:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A16ED43CE6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824C31F031E7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793105116;
 bh=8rARxPE73nvg4HDl8BXq2HThRMe4cw7sIRWSbPBB7mo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=RRPIqqJP0S34a1u2yvRl3ThLhqOttRUdn4B8P6lTrJ6bqieh/Y94iDe0U+gPtGiRT
 owH8txV2l5FtzylUpukGMMQlrzceFA4W5Nk7Kp4ZWtYfznd7sRECQWhw9xFTZU1nr6
 SH04bvyTPMiUfwoszc1gMC601/B+uP3R3nl7x78DIZw7kvTFbeK3jFT/JI2pW/oRCq
 QdxMheBayi5JBK2xCN3hAkcBvTxJ9rHkkgnx1OseCrThCVv5yd4VkkgDtXU0Qk5bVM
 T0CsuI+2MeHx9RBlKQn3I2HQuFFC7UpkqktWo00afeHmssMnR/ElrGP2Ntapjm6WsL
 EwP/zkQY43WaQ==
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6b1afdf5196so1611380eaf.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 05:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByLdG5uoiCgSRBwyQUMtr+7sMRykC0gsE47Jxz07QgiCfT96ZIybWQiVyVOKHMHEBoPY1gyHnW+ZlX8YHDn3zk=@lists.osuosl.org
X-Gm-Message-State: AFq9FYICQ4hB9LOGGZVQ4okgJ/eagaUmt2fQVH8YCmMuAJPRu7+6/LDr
 u0VaPVwPq1NDjXjSsxlrvvAhu8zUUC1MHyhCRZn/N7dZ99NZU2M3L2hjXBO8jPLQSyOAioXsXeM
 MOKFln5QX5X2IzItmTN2HINY7KAl3hcA=
X-Received: by 2002:a05:6820:160a:b0:6d8:9568:8413 with SMTP id
 006d021491bc7-70ba0dcd52fmr5093612eaf.29.1793105115842; Tue, 27 Oct 2026
 05:45:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-2-magnus.karlsson@intel.com>
In-Reply-To: <20261027121442.907414-2-magnus.karlsson@intel.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 13:45:04 +0100
X-Gmail-Original-Message-ID: <CAL4WiipZoXk-fgKwSdAcEU9U3pytPtZA0QXqN0LXHK6y4RUQkQ@mail.gmail.com>
X-Gm-Features: AclHuK8mCS6wHzS36AH1Czb_foiMFwXwVsjs2YDT62ASqzMvBMTq5CeXZM9tV-o
Message-ID: <CAL4WiipZoXk-fgKwSdAcEU9U3pytPtZA0QXqN0LXHK6y4RUQkQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
 pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le mar. 27 oct. 2026 =C3=A0 13:15, Magnus Karlsson
<magnus.karlsson@intel.com> a =C3=A9crit :
>
> That USO works for 64-bit systems is just pure luck. Currently, the
> computation of the UDP segmentation header is performed using sizeof()
> a pointer instead of the sizeof() the UDP header that the pointer
> points to. Since the UDP header happens to be 8 bytes long and a
> pointer is 8 bytes long on a 64-bit system, this works on all those
> systems. But no such luck for anyone using a 32-bit system as 8 bytes
> !=3D 4 bytes. So fix this by using sizeof() the UDP header that the
> pointer points to instead.
>
> This was found by an LLM while implementing something else that used USO.
>
> Fixes: a54e3b8cffd6 ("Support UDP segmentation offload")

Missing prefix?

Fixes: a54e3b8cffd6 ("ice: Support UDP segmentation offload")

Other than this,
Reviewed-by: Eric Dumazet <edumazet@kernel.org>

pw-bot: cr
