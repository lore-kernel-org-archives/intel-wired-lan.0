Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE4CC76196
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Apr 2023 22:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC5F581A29;
	Mon,  3 Apr 2023 22:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC5F581A29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680560459;
	bh=uRBiHKcaTWMdC2BaShRB6q3OVqqK5+9MP8bDDKULpcU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MN7DejAiThAf+q/HjEhdwkggT/bupULJrjqRbJYKPYi+d4CVp6odYpTjrG4VbUINf
	 MNDWuzSWwqvqqUdE2G30wXRQEnFySYF1Gkr2d81wtuIyVJJ63bbQ5tSvaMdisMjTXK
	 qWKA6KRMLLmeLHeBRpoJ1Gs28EoT/AnSEZIyfyxyh7q3g/CiuGVqu4GK4lqEQ91nQT
	 fXnwfsuFTMaShM5mUm4Go3RxdZvuF0K+hO1KhELbjASME/WO9bUsijvFKIF0D93rTw
	 1shwT6auT3CZrat7rW99+QYfZlQPMwI+ZTIrEbXhrJlFzkja4oDnFKOVIf0DXFAKrG
	 pqKPs+0JfKKoQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CkGSdBWxPnvU; Mon,  3 Apr 2023 22:20:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC19E81A73;
	Mon,  3 Apr 2023 22:20:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC19E81A73
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 4AF0F1BF33E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Apr 2023 22:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22F5C81A73
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Apr 2023 22:20:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22F5C81A73
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_Sq8o71X63I for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Apr 2023 22:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69A5F81A29
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69A5F81A29
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Apr 2023 22:20:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB76624CE;
 Mon,  3 Apr 2023 22:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7B6C433EF;
 Mon,  3 Apr 2023 22:20:54 +0000 (UTC)
Date: Mon, 3 Apr 2023 15:20:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Message-ID: <20230403152053.53253d7e@kernel.org>
In-Reply-To: <49947b6b-a59d-1db1-f405-0ab4e6e3356e@amd.com>
References: <20230329140404.1647925-1-pavan.kumar.linga@intel.com>
 <20230329140404.1647925-2-pavan.kumar.linga@intel.com>
 <49947b6b-a59d-1db1-f405-0ab4e6e3356e@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1680560454;
 bh=pvAng7h2GiVpbsii7yUXsD7CnnBM0WD9INMhxQ4f9oc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gJj8v2ns04e+YIClJMlw7eMueHRk5lNT4PUJUTy6TxBQVcXKFRzS2D0UH7CBpJC2V
 TQBRmYBKkCM0DmzKkkLMC7ypg/ieEjFssteZDFXr0MZFKFuGZj4871XcZB9pLO1H1d
 E74iYYLF4tTsRXOtrTbXfOY4lfCCIaxMzBqcaXfMhqtWX5A36LP0lbi4U4NOcC4EtT
 KVraOzl7ktcMdlxYKa+9pI0SV2es56UOW2E6y9L+2Y5ocEMLMLK/WMfUtOPIi6hGPq
 +6UCNWz00cLsNN+k1q/TysjkbpEx4AQrlWCfJaccsmlxKlAQLo8PSMwxfjbeyc5sUi
 aO87Y85Y1zvlw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gJj8v2ns
Subject: Re: [Intel-wired-lan] [PATCH net-next 01/15] virtchnl: add virtchnl
 version 2 ops
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
Cc: willemb@google.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Phani Burra <phani.r.burra@intel.com>,
 decot@google.com, shiraz.saleem@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 3 Apr 2023 15:01:55 -0700 Shannon Nelson wrote:
> > diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h  
> 
> If this is to be a standardized interface, why is this header buried in 
> the driver specific directory instead of something more accessible like 
> include/linux/idpf?

The noise about this driver being "a standard" is quite confusing.

Are you considering implementing any of it?

I haven't heard of anyone who is yet, so I thought all this talk of
a standard is pretty empty from the technical perspective :(
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
