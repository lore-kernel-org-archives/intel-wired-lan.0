Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9272C4167B
	for <intel-wired-lan@archiver.kernel.org>; Sun,  3 Dec 2023 11:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39EE760E6D;
	Sun,  3 Dec 2023 11:41:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39EE760E6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701603711;
	bh=l5iI18XnSaio8hDGr1+5SDBK7+lceKP2jPmI9jwMtsA=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Qx4pmfe0FrcQwGOKdyYSiTfopDcFMlGH0lSnRS8aEHxFbKMPx+TMlWDxMnmZlxPlO
	 gWWkz/lVRqQPcc+dlRj/L/htQAVIlClWep8kf8FZmZwe3jPV3wA5QPHCpEiUWP4Dpa
	 O5oLT0q232hwfRNwYs5SDPeUu1Izv1E15wOyNf7M8FcQVa/il+ZwZJmHDmAvldtLp+
	 135zim733a5MepYZb89Ce1TUSwuRI6YazyW96dtvRoamS07k650Wt5ld921sTfr3kc
	 Le1+s65O24wpfkRanIvTWrczcP3KTPPNr9e9+4LmjDxjbKAka/Yu6FfxOe/9r0iXBX
	 FWpL5uqKbsshQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3cXi-YpRHmtp; Sun,  3 Dec 2023 11:41:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DE8660EC0;
	Sun,  3 Dec 2023 11:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DE8660EC0
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7DFB11BF36E
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 Dec 2023 11:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 544BB402DC
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 Dec 2023 11:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 544BB402DC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ovPzk2-Twapl for <intel-wired-lan@lists.osuosl.org>;
 Sun,  3 Dec 2023 11:41:47 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1A5540242
 for <intel-wired-lan@lists.osuosl.org>; Sun,  3 Dec 2023 11:41:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1A5540242
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A6FA960B83;
 Sun,  3 Dec 2023 11:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCE4C433C7;
 Sun,  3 Dec 2023 11:41:41 +0000 (UTC)
Date: Sun, 3 Dec 2023 11:41:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20231203114139.GG50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-3-ivecera@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-3-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701603705;
 bh=XccCxYSOFM8R5fg3IGTtouCQNjtf99QVUi/l5Jh6WSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d5lqdJZb4hhVJH0PsnHgitXGQdQJd18XdAvgVByoC9p5AJgHF+enWKjlVh7y2uU7v
 AZXqOa+wQmtIao804WE0taU2rYoHHTZTjja4tetQYA71XEmxqCb96pMVHI2w5YlsNE
 R9GPDbmcKEmBQ+MPI946qqEUgHLIQZATzAEHXSG25rsoC2oVbEMIQkJumvxFwGS/H9
 0N85iI1IRVLc/PbOjbgjKpxGOLOrNrUao4yBRFa8TS2bhDi3wIiWCTUjkvOGbo+6nv
 CxAPvFYqTwSawtGbs4sajQ4G8a3NpuQqAZm2y/8UARFhFumNyG28rHNPpGJc+TvxJH
 /5qSMmhNR+68Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=d5lqdJZb
Subject: Re: [Intel-wired-lan] [PATCH v5 2/5] i40e: Introduce and use macros
 for iterating VSIs and VEBs
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Nov 24, 2023 at 04:03:40PM +0100, Ivan Vecera wrote:
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
> 
> Replace pattern:
> for (i = 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
> 
> and pattern:
> for (i = 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
> 
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
