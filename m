Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DD0CA9EC1
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8559140931;
	Fri,  9 Oct 2026 21:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PK1Cio0isI0Q; Fri,  9 Oct 2026 21:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B725340935
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579850;
	b=X4H/LDAvZxZdmrMin69jHfbG1IPv9FqDD4YiQfx8jDzGG4vIgazqjvRy5MhU7I/F9bDv
	 nWvHAZbuoxHESsfsLtRb+OjSbAgZYulSAOegiZztr3PLRKl/h4nezTfriYn7iJB1sRzxC
	 YGA2R9Lq93u3x0PZH/h9SlZlOdJd6ERFAUAwN32i8cSJi/aP952i3baez0Nk+D/jClqFD
	 q13RgJQOZw+T4ryKDoVtp6KEc/abr5uI284UnyVnrei2evkbtwy1BmT4MAOwmkMi1ap3U
	 QCLUixKBnMJ8EkRTHDrgndb6nWlxYc8mlQvaoCYg4yQ6fCAMEOuCRRuoB/JPsLXeLRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=C+iGm3rETZHxl0S6PJ5ZBGEn6TjvxY5fdrEq/NVDoyY=;
	b=GjeVEdautth3hFGRPfdG0eVF5qP/FzjAMd2vdKJ14r0OG7f2TDjEVcq60iUZtXEdaSOX
	 Ppn4QeSy+EJ2AgOUguWcMAheNAdsVaAiZg1vWPyryJqCh4OrgAeJ9LY3W9HxVtMcl41As
	 tqbaKYhc1MsLdf80B0igP8LSG4KZbTqJaWsrNX1MtrtQMoNmI41T+yGMPA/7HnaE0Q2Ky
	 QUC98enobla3PmT/osmzXaPU5br6MZhaLl2qEbjWDMRIafkrI/XJJiLqFl7mxMJMcinCo
	 965vSl7NvOObRqGjJ/utijo4rbxXm9JVZFHA8nVRmJrDpJaRiBHJtOM4zk8gCC6+nSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579850;
	bh=C+iGm3rETZHxl0S6PJ5ZBGEn6TjvxY5fdrEq/NVDoyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mu6JX1BeQrT/AFUBXM5VpzmsZeTqOCOEdl+2M05INmv8dAVkei0RyYvwe15t/X6cd
	 4+iqZzoix3DIp20S4awKf0LGcbkFF/136aE0eL4V6JEvtVqbys/ixJwUwIlXVr75oL
	 rB6npANJngAYDED5Kkmr+jwtsDkB0Oip9Ku8d3poraRJ5QJ80yueC8N8WfVNGvEol/
	 6cKyRtbqCpbKT/flugsWcEcNM3EEVW9J08zbtwqCVLLZA9NzERo8Jo2k9aa5g6BPXd
	 9UGW6ZPZ6VgE3aOsSM/swC3IUmZyP4g5rarihJY2dPIzBlJYx0Jja2yFA9AMIy9WIJ
	 fJTZCJFkyW+Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B725340935;
	Fri,  9 Oct 2026 21:04:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F029794E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4C4440053
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDAm4rMmSD1L for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 19FE840080
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579846;
 b=r+EOQm44gFwHMzhC64i1Nl8tqai7alzMx22s83aE15OB/04XtQxFzfGrxVZoPV2Tj/6K
 eHdH2uYjcsp9WmJFtHQoQIEaP+LtTqAtWMigP3HTeJ40EjtUBTBSI8MZDwJJNdH41WN3A
 sUGTrXM0zxZSznyI5QAPpyIeaPnLx9VNBc9n1BteZ3ZTWHGh1+Ft4AySzQ+4ufebg7kiI
 3cAl0RgzfrD56PObZpN2rMmGp65WWFtgGuqlOxInh2GL8Dx4Au2BcRPhzYePdVqHloexx
 xkq9AE02LSkTFnAeAyetDuP1wnWU5iGIcuKyajmnadHIB1Pkl5f7mSbQoXf4NyNz5xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579846;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=C+iGm3rETZHxl0S6PJ5ZBGEn6TjvxY5fdrEq/NVDoyY=;
 b=QV9M7kAmE2jZVdP4IPlCNqrPEpFeeFXOX9aamK5IrvGO9/AQJDtLEFlqi2qU3VqAS9SO
 jXzA78UqG11ZxfgqyUNjXiZJDj4Ni+vQ7PeEBZP5+TemUgti5gInjz7IJg0jpfuiqrvrW
 sHDVm4EiMfQNYdfmBdQj+7LNFee+uMonvWsuJafKu+fecLjTcjlNQy6LjpmWLJTuEP4qa
 BmWF0xhRwKmnvyl28vcWHBJ7UijUjU30iHl7ot60mYB6JVC6jPr8XX6OQLTHyN+9vMOhS
 TnHhQ/N5MZ/IZjSNt8fy6aAgqpOr/QK+NSkT8oYWVDa6tgyPPPTQK3G6dkg5q5W7D9A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="kifFBi/X"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kifFBi/X
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19FE840080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D93441E49;
 Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B501F00893;
 Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579845;
 bh=C+iGm3rETZHxl0S6PJ5ZBGEn6TjvxY5fdrEq/NVDoyY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kifFBi/XOQy0j8U/dD3anF3ruxwyZ4k6hF5ND57qfo0m3bQf0FXPqDuEFQJgXWwnZ
 B9gGXctxgo8dyFOkvbrrJ0lPfTNm4DZSIglYCl42IiVje7j1fhWkhNw4Is3ouMNCE3
 cBvc3+mE0IyMkTm9iz86s5AYFwSJXPSTMoBxMbKVypuySa+/BSYQZQt8IDxWji4sRN
 e05A72DpMRrMKRmV0Rd2ekbhffMq+R3Smos9I7UEoc3hgQHsWqXHJswYhVrpZ7deUt
 i64zwPVuaf5ki69cJnpAqnIYeKVgL98dYDtf2W4tQ2nDIzkph/7y33CA70gD+BGhpa
 dGzVhQuFBN8xg==
Message-ID: <sashiko-outbox-166077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: skbuff: don't reset truesize in
 skb_condense() if the pull fails
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-10-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-10-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:04:04 +0000
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

> skb_condense() pulls all of the frag data into the head and then sets
> truesize to cover just the head, but it ignores the return value of
> __pskb_pull_tail().  If the pull failed, the frags would still be
> attached and truesize would undercount them.
>=20
> It can't fail today.  The caller has checked that the head has room,
> that the skb isn't cloned and that the frags are readable, and pulling
> all of data_len eats every frag_list skb whole, so nothing is
> allocated.  Check the result anyway and leave the skb alone on
> failure, so this stays correct if any of that changes.  Use
> __skb_linearize(), which is what this pull is.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D10

