Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBC4CA6012
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77B36813B6;
	Thu,  8 Oct 2026 18:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2IM2LQkEhHw; Thu,  8 Oct 2026 18:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9629813AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483423;
	b=c/Poe49DxsuIWWmNWyZ+2LtPRqoR3TdYtXC8sgmFC/2u1ILKFOtn4w45Xgbbm19OnHdp
	 sIZ3TG5s5ALn4hnHME7LwImjHjV4UpgO7ML/jsZNcM5quhm0hxdXfEmUIOK6fkyXBf6Zx
	 eUgaGHQIhQ6abGffeVhjUPF4h6zhYi+J7VcUKO+AKbwf64NfVG2m7VdIPUZBMHPiDY5jr
	 B6bjuDpDlALFBKBMWHeqDZbYtpU8NiEbkB1tRZ1EjtdKW+zpp+39Vd3sE8cEWyF1BZglZ
	 IoeLwySBW4dOKwlg3/3Bl9YNQ53Pws313rmUX0SjvlOYdceJ5gnimC90lnCpxKkMcow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=b/UMPJhzMEWnAvCXn5WFnSaqGrB9Q1emra2FhBKhl5w=;
	b=m84qErySB/FhWvoX8uV/IexKGQwwrXEswOp1xIeCx0JN6iYpRzeCS7SuHEc4ReUoXVP4
	 KunQGZpy7to+cV+gpmPeb1SjuuxMpEJoOAGEPLrMTFDzDKTIurmMHy1pidXAauIgS2LCw
	 fbSitrGqqcKAvPYDeGuu4C3LjT9yzRtYC5aWPSfDSLgomp3KuVQhIb9w2yQTYL1A+jMKy
	 Hvp2dS3mws9VCocnnE566LPg9A/eKEKdx6GJ5arate4XGJFZy4ED1wm8QUqxsjT8F2X4y
	 vF4CDPUVsv+R1hzAXHfUc2yOndoYnvUl4qKW1cWbpid66QJWaTExVBVjJjaK6RLYZVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483423;
	bh=b/UMPJhzMEWnAvCXn5WFnSaqGrB9Q1emra2FhBKhl5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=z2IpRpbFnmull5awHfoUBYQWhvtNIxP5jAkibJYcDt8pSbTsXCHqQHKv9OtF0Y3yV
	 AHgH8YK/71wDsqP25sRVI0BA7hnkEoSJffn6DxLstOSetBDqkCmy/tLCDkY5wodvQf
	 N8mk85yVjFE79fRMBHk8fYiOVi0FjyfmzXPoSNilJChqX2ZpJNbRT+lY4iLaXzBBv5
	 FaO1YxtHX+QPtIUonZTVS6Q11Mm+B6HFWWENeY+SQZl2LmGl9LSyUvSgRYihrnapX2
	 fYafTpj3r4fF072R6xksfaiyMA5FmFln+xR7D63I8lONMwiCb4ZFA/znBMewoTRwZu
	 j076SYaP3p3Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9629813AE;
	Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C1142B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51AED408ED
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMEXAMW1T92j for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8045E408D7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483419;
 b=jT8QMt8ksKPAfCro6Pic3wadIfdMQWxoRHdtxBlHy5r0OwvyWgAtmxKTL6tc1sXw/CRo
 GzCCkNFxPVrh8eOZBZAlpbQOukhiXuhTCdtwgd5XTvWr+VDgqmOVtckGNcp+CAEBYawYI
 dkZ1hIAI7sPvxfOi7GU73YID1zqbQU1kRw9QVP3RA3hC2kD78313AI+iPy65gNLwv4F6l
 vKXoGExdlnhm7ZF3XVwJVU+J3rrEXuLMbg/benxvn5s7O736Q9XTbvYSNeiO2QKFQ+4wX
 PIBPXgijkgza3Ft6m8DSQceNFwN/qx21/RLk7k8JPXzxrnye+2sTkBTgyvzK8Q4Eilw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483419;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=b/UMPJhzMEWnAvCXn5WFnSaqGrB9Q1emra2FhBKhl5w=;
 b=ocTv7wR8LaFcZsDrtZm7eza3GLTn0IvphcgnYbqRHlKA9V46klsOKp8iWFdg4rwaEMHw
 AN3VcLDXQusp5SuUXNTKswcIpVCeP20mc/4W2J+PmG1yM/hkcDbMNF81zR09PD1BlneSx
 fvSns9lX/kwiR72Vdkh0TafvlohauCv13I0CNDH2gdHTxGTROvqEmpFWrVeEJfkL0sWZo
 xpakECobYwogZ1PyHkC/dNgyMly1X3XZ3d6CtdJz18tb46XS7IJMhtZ/kXyPb0llNwEnD
 mx64JJss8ISq0D58uGvHsgjze/YxX/W0SMOnZ63NIFnXx//HYLDMxYHmQITm1Dbm/SA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TYpmkON0; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TYpmkON0
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8045E408D7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 395B360534;
 Thu,  8 Oct 2026 18:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2331F000FF;
 Thu,  8 Oct 2026 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483417;
 bh=b/UMPJhzMEWnAvCXn5WFnSaqGrB9Q1emra2FhBKhl5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TYpmkON0iTyzmGVShlx50kEK2hWLB06Zv2tfJ2NjmBs/5ewrMyLX/qMLk+g9hW7Zb
 OkXIqjj84uMes6On5BfTgyQhYc76LLdqZ1A31TuT5EgwHqJao019t5q7u2BtUE7pdi
 2Yd4dXZzeWeOVhyx7/pN680E6cQ6MdpiNDLrHacyHb0m85WQwKozf8PUj4T2XNZQli
 qM9rFiPXCIerfclplJPyL7yV0iPSXsrWJYLAPmadmAcmfk0obflmIs6/KyXConeyTW
 CM8iabSlM1Lk2QPcGZiJTFcD5+OBQB6bDRzt4TSKu0raax69+wjlqtSJnx3cxLh5/6
 p7785AJi/Dzzw==
Message-ID: <sashiko-outbox-164445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/9] e1000: use pskb_may_pull() in the 82544
 TSO workaround
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-5-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-5-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:57 +0000
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

> e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
> payload into the head for the 82544 TSO workaround.  It already checks
> the result.  Switch to pskb_may_pull(), which takes the length the head
> should end up with and checks it against the skb, so this driver no
> longer calls __pskb_pull_tail() directly.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D5

