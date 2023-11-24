Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF552C61D97
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Nov 2023 11:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A6B060B0B;
	Fri, 24 Nov 2023 11:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A6B060B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700823633;
	bh=hJaxiW27m9V2ZPWpEQ6hUmqE2wxqRpgh79hgkDrN1iQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cu2eaKggTbWQqnaRJwvBiEsE4bDpNA6T0GuJQv3fYEeAIHkNyz+NNYgLDkh+fJ3VG
	 Ns/i4ukXuGSMmdVqrnWS0uQeYxtHswdHVLKQ+GljGes0C9vkqhTSnvtl75tHFyiMaN
	 rdJ6LV4y16kgCAJ04j7B43VEl6aJnEMn0NiDkVakupPlawdZwak4VgDKvp7UWnnZGe
	 e0VuEcqTtB9mjUhW7JYDn1wK3/9+wk2NMqVj/rBCBXsnoNwki1Aw4h3xMhI/7dBoG7
	 iNOAOP1P1RChVWtIE6l749KYSdLHU4qPqzdw44k3DWZHFh35ZiR7HCZoKbICHEsHsx
	 febFQJkrZJQpA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8IYoJ_bFVhMF; Fri, 24 Nov 2023 11:00:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7747F614FF;
	Fri, 24 Nov 2023 11:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7747F614FF
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 1F29E1BF83C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 041F3614FF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 041F3614FF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXUem34GLR7s for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Nov 2023 11:00:30 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 737AE60B0B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Nov 2023 11:00:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 737AE60B0B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B421062135;
 Fri, 24 Nov 2023 11:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C18C433C7;
 Fri, 24 Nov 2023 11:00:27 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:00:25 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20231124110025.GE50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-6-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-6-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700823629;
 bh=lY5lbWMSvYgdNTnwGkTdkoM/X4wObIy/Mhn5AVhK97g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tXG9Rm0j28Ip4AJr/y+Y+3vmxmUP+7sQxEgg2Ig5u3DW0vUrxbRRJ9/npsUsyn//E
 9V9cAiCtF3/deX7X1wA8kRzOI05eywutRw+tiYX/xP9geW9cwhaEQJN0UYatdJxKMt
 fA2kqypGvSJkHSBJUfH/CtRXqnRF2jG7R0tCfp+8MM6wY6ffcLRYf2Zt34lCpvZEIf
 VMKOh7MDgnMsnRf8y266ziFbI6vjzxWaL9SYb0aa9DVUBQfC4MmEa/lA2zP9g5JHWC
 rJCBzK7qSfE6ehuAvdHZip8p/ifoUF/9UwBBZdqcDvWI6cZoAhMPTqnQ7yVUP875w0
 4vmbsRXo/uFxg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tXG9Rm0j
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 05/13] iavf: field prep
 conversion
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
Cc: Julia Lawall <Julia.Lawall@inria.fr>, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, Ahmed Zaki <ahmed.zaki@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Nov 21, 2023 at 01:19:13PM -0800, Jesse Brandeburg wrote:
> Refactor iavf driver to use FIELD_PREP(), which reduces lines of code
> and adds clarity of intent.
> 
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
> 
> Clean up a couple spots in the code that had repetitive
> y = cpu_to_*((blah << blah_blah) & blat)
> y |= cpu_to_*((blahs << blahs_blahs) & blats)
> to
> x = FIELD_PREP(blat blah)
> x |= FIELD_PREP(blats, blahs)
> y = cpu_to_*(x);
> 
> @prep@
> constant shift,mask;
> expression a;
> @@
> -((a << shift) & mask)
> +FIELD_PREP(mask, a)
> 
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
