Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB59606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pj3wxuSJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7YQBMkJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 971BA6082A;
	Tue, 17 Nov 2026 02:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnhNAiAeTq_U; Tue, 17 Nov 2026 02:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F2656081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794881841;
	b=Pr5e8dE5oKWnPn1odpQelFjEkPVHgOqc6vLrxmRu/gkPy9bMAnDS3xkF1avb7Au3bz06
	 /oihQBdC+SLciuSShrZ9QgHa29NZfnp12UEHxSBSEar3rXiRlYa+zYd+DSgL+ao1YnNQe
	 Y0z+Ghods0+pTVkEAGVGuJzuar6WYBNK1ZnnzyH+t73XPzUpXG6R8j+jajrXoYQmb7EF/
	 0HkbKIb4dHkNszBnigwc5Jfuoyld15V+jEGbri1Q5vWB5I40ht5U7KSmwss1i8QLyONyG
	 UhqK/nzJfo0ItA0/BiltbjNHZyQCgnCgDcAJjyVJ+rFj7+rMexOcNc2bf+adYpq0QvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794881841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e0nFLX3kmOFtLmTXd4F3aVcB+6sTaFXFNO+asoKn3JA=;
	b=rCyAuJuLYI13XaZdnN1G96l6Si7c3Nt69Hw8F80Auuxoj14goRCwFTbNLM35bt+Pi3SH
	 Jh/FWtMHEqrf6NciGOz7a8LZaQxhSK5gDABdJPfMkcdoWsPYv98xC03KPn7kYfdxLrjQa
	 DxXlkiD3jPvJ5nxOWGf3XnGzeugYUlYCfASv1lNMdTv8TwtroOmHASjlSAOmbSukY11WC
	 HUbxwKwBAj5g98NlMQt5wscxDyCwEMTg5PY0cGRC6R95a8jVor757oWY+ii6Ru7Eqr+nr
	 FTMRTyFeNgHViO7nqEnw0PNI2120h47aw0c2y7mHLGMIPVOMkwO5267Y/RizzcbE83g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794881841;
	bh=e0nFLX3kmOFtLmTXd4F3aVcB+6sTaFXFNO+asoKn3JA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pj3wxuSJ6MvFMLAr4IypnQml+EXeQIvmbMiKCpodHvul5fLAFq9oAtoR46PvpQ7No
	 uKiddOiPWdbNU+yvj2UP0QfdWjuEixRV0uGYV30omjSgK6zAby39Vtnt02kPJHPAcQ
	 y9YKQUNm6f++YPQuEViLUue76IxmbgrWbdhYfmhyRHLpuiwsoVhQKm5+yXfQSYBPOQ
	 0v8k/uFfLiQ1+3dEI31ximdLISYOyRbW9prOvP20OD2CalDF9bAkQ3Mdtxj8fDh7U6
	 lGyqup1NpTjYksbYfcjbq1AobBazond97uWKkbNLcUk3N1ZzkEseo5/ULULB3RJ86k
	 nRbfvQHF8tG4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F2656081F;
	Tue, 17 Nov 2026 02:17:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFDE313C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 02:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1FB481053
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 02:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZiJmHPyACtG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 02:17:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27D5B80C1C
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=i7YQBMkJ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27D5B80C1C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 02:17:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03351624C3;
 Tue, 17 Nov 2026 02:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F61F000C5;
 Tue, 17 Nov 2026 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794881836;
 bh=e0nFLX3kmOFtLmTXd4F3aVcB+6sTaFXFNO+asoKn3JA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=i7YQBMkJmtxEWd0fJ7GFx+gqgPsREc03S5UyeUvVjwEr8hPAlAN8lSuNSjxZ8cJki
 yQVmbPeDDDtG9wNXEMA/+0pwgxvpAmfbwwBAAZZx6owXZ1YMtJuXG14QCXmiiLU9Gk
 YoivBhBIY9N1PVaFuLVd+gzJsjNv33qN/Bik8Q0Grbf6e+UZMPvnyjUr8A73t1R9ts
 J2m8d55yhQkKtOpZwel4XXiIqigxSVfAwJRSgC/gfwKfHdsulC4omCz98VKjw8IuGa
 B058zZxF2ykQeSLXHA+veWENR2AJUhr1O20lOxo3UQ4LG+4M3ZhrZxvzRZV3SQ36mq
 +ofYpwaUdrJ+w==
Date: Mon, 16 Nov 2026 18:17:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Min Li
 <min.li@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Grzegorz
 Nitka <grzegorz.nitka@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Message-ID: <20261116181715.6f7d7f09@kernel.org>
In-Reply-To: <de304923-783b-4533-8507-514a15b3556e@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
 <de304923-783b-4533-8507-514a15b3556e@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 09:24:39 +0100 Ivan Vecera wrote:
> v2 no longer applies to net-next since net was merged in. It conflicts
> with 7a3837929d04 ("dpll: notify about a reference sync pair only if it
> was added") in dpll_pin_ref_sync_pair_add(). Patches 3 and 4 fail on
> the same lines and the rest applies cleanly. After patch 4 the
> resolution is:

What makes you think we'd rebase your patches for you?
-- 
pw-bot: cr
