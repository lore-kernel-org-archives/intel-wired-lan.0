Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCD4CD11DD
	for <intel-wired-lan@archiver.kernel.org>; Thu, 28 Mar 2024 17:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 691C6820FE;
	Thu, 28 Mar 2024 17:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wLUqtIuqA4nZ; Thu, 28 Mar 2024 17:24:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCC9A82116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1711646672;
	bh=X5EaHlL0oSRRcCjvz+Z8eb1oa70SXsgAWlpToy0jw6c=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=URSTFRg2INw47/Keo2t+wrFMexe0X5/lmLzgG0ewGe4P2V51xU7LuNapqka4uZCE5
	 ILbzSXtywKI9dorOibThtJtXF4NL/QSmXr4qt0X/ZFo+51RRFHXR2v15SuJipT36Q2
	 0iNWliGqwDAvzD1miWBk172nsnN1G8XuHIiQVjhvedWLZL8AnOVrgtBVkQct3g02hO
	 J4r4JYn8TY9VBoGYqUbFOp0blDbLch0JpFSaZ2dvpSM7wKT63sFY1UKSntr73/1mQC
	 f7JbueYWHSc8ZnSPvHorOE3V6lBf2XSbJmmP25nwdZbulUOYnpSuGYAfhbYRHcgGuc
	 WSVqzOBco9bpQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC9A82116;
	Thu, 28 Mar 2024 17:24:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 552381BF2F2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Mar 2024 17:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41EB182116
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Mar 2024 17:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id On3g13WTRqKI for <intel-wired-lan@lists.osuosl.org>;
 Thu, 28 Mar 2024 17:24:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A48A3820FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A48A3820FE
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A48A3820FE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Mar 2024 17:24:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C6E55617D5;
 Thu, 28 Mar 2024 17:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F12CC433C7;
 Thu, 28 Mar 2024 17:24:26 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:24:25 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Message-ID: <20240328172425.GE651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-6-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-6-ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1711646669;
 bh=2siyeS6uzlQMyBU1hT15aszZzeb4J26W0sbBxAvcBso=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EsQUQGBJqiyE5TBBV1xaMlo03QpVAjoKOs2v+yc9h3SArZNhlqDqOXHBukxqB1MXx
 mSnrkDZwp1EJRG/GjTmvIuuZFgvtgDPb9iU4m9v7fEXuBOeqXBL0UpY9f+Z60FbZiu
 Xx8jLPPfa1xXXjofs2s7fczcr9fEWhpQeSI329bsb1I7LJDipgT20fgmDesJxlTlZC
 BbWF9m789tpHEeAvD4v5nA6YVBxNju9Y0EGeyzE/JURIUvw6s7i1F7SCMtBjJenKeo
 sUh70/IgAKTKQ4w1h8tAR19+lwIYB8btXTAp3RwJpRc7u+AiLakViYUF3Hfq4PcIoU
 p50lOWz5kcoWw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=EsQUQGBJ
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 5/7] i40e: Consolidate
 checks whether given VSI is main
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksandr.loktionov@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Mar 27, 2024 at 08:57:31AM +0100, Ivan Vecera wrote:
> In the driver code there are 3 types of checks whether given
> VSI is main or not:
> 1. vsi->type ==/!= I40E_VSI_MAIN
> 2. vsi ==/!= pf->vsi[pf->lan_vsi]
> 3. vsi->seid ==/!= pf->vsi[pf->lan_vsi]->seid
> 
> All of them are equivalent and can be consolidated. Convert cases
> 2 and 3 to case 1.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

