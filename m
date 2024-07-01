Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AB4C2BD09
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Jul 2024 16:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB519403ED;
	Mon,  1 Jul 2024 16:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vzWNAyPxBv69; Mon,  1 Jul 2024 16:52:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE737405F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719852750;
	bh=fLCnjl+Rsd8HjuZD5+Mjan01eQ4pAzVGNEKFL+yKC3M=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=O5TYQHf9yV8X7IRq2sjtW+8l6cAj4oX39Yb+TQGx5IwP2ONahgWHBbAqsgnfHd9V/
	 LX4bVdZfUun6fHaoyOuUgFXsoVqdmAS2fvIV54489CVJaOGxhFzME5fB/X00O0xIuw
	 2zUolCJoycTFux7/6pCALLa7dvHX/8uPBe5RmgOhywdwebStlrOj+JqaTs77ptZfFY
	 dOfa+H1macLybyyA3Rc2wjDDJ5rISc3EbNkwuHz4REc6N4wEryQtqA8OHTHtDEl+ma
	 UKdJ+eaqGrhtj/zGjELDrZepimA+uuxjq9qXZxCFz82Z9cIN2uNCFcxZEpDhmCmLNc
	 KCSdOOzhgni9g==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE737405F8;
	Mon,  1 Jul 2024 16:52:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id D6D181BF34F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 16:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C18E760A8A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 16:52:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3YNYmgArOPJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Jul 2024 16:52:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E4C89605C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4C89605C0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4C89605C0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Jul 2024 16:52:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5FA93CE19A3;
 Mon,  1 Jul 2024 16:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40350C4AF0D;
 Mon,  1 Jul 2024 16:52:22 +0000 (UTC)
Date: Mon, 1 Jul 2024 17:52:19 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240701165219.GA598357@kernel.org>
References: <20240701090546.31243-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701090546.31243-1-wojciech.drewek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1719852743;
 bh=OO5BddTOzU4MLowLv5gGnciASTzd1P1u5eu4NiEuR9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KWojnd3+6+oawxA2iyT7b3tMlX1qFeubAfCaSKeUSxELAzbAg0sAJpobovDs85QlZ
 TKBwh2ap8jkGMFvWznkW0cq1ywVOLCD73Fh7ah2Op5DhGhWZJ8+YXVbmDydTPSWcTO
 UUYLJ06rOmIhWfNZJHMYVUVJOZD2zM5CMyl1S4pLfM/B9dnrBAx+iTJidet9kNSIst
 K9sOZf5pOUw6D5KYBRb69/ZKIDDvA833PuE2lpreystw4BndnxhaYPEhkmRui+rUI4
 MbJ62GJvM+8UtnKng/YjpX9s4VtbYnJU4OItulrdVeWTmfo6iw8Ks30CW0cxaI9+uS
 IUmNESnjRBiRw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KWojnd3+
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Fix recipe read procedure
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: przemyslaw.kitszel@intel.com, marcin.szycik@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jul 01, 2024 at 11:05:46AM +0200, Wojciech Drewek wrote:
> When ice driver reads recipes from firmware information about
> need_pass_l2 and allow_pass_l2 flags is not stored correctly.
> Those flags are stored as one bit each in ice_sw_recipe structure.
> Because of that, the result of checking a flag has to be casted to bool.
> Note that the need_pass_l2 flag currently works correctly, because
> it's stored in the first bit.
> 
> Fixes: bccd9bce29e0 ("ice: Add guard rule when creating FDB in switchdev")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

