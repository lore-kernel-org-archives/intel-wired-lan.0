Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E460BD2CDF8
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Oct 2024 16:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85BFA403A5;
	Tue, 22 Oct 2024 16:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXg6C3jf_qxJ; Tue, 22 Oct 2024 16:09:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4C46403B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729613381;
	bh=lW6zSNbEaNTzNEw3ThNlR2ODUiFFw434jjcBaaqN5RA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGGfUIWIM95i4rkC7mio+0z3Y9Y0gPTynDVLAnXDWaj1WZ7E9ly4lA5ENuoyUPyKJ
	 u6mycmUh1X9yhA8+jSNcEX7PSSjS7pbQV4zyMhWIDACa8GW1YbozIWgtg4BXHXlkEj
	 8J2+95zIGe49sb9D2+zE7NppdgDfc9CdQeM/zpyWS2FcET4ZfH8Yony+N/2pOY4GaO
	 RFhiuiWaasVBkRYhlnj4kaRQoDCInjGEvXLidZ6MBZTbnEQ3TPbfCq3PmPTrte3MJk
	 DzIkOUZ1xmqRCYDMHj0JNkRqU9TiZY99RdhryJMhDyS+q9Kc1p9xZwR8D9gL6X8ydS
	 FTMSaKC/kYUzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4C46403B3;
	Tue, 22 Oct 2024 16:09:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31CB4963
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 16:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B6A4403E7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 16:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-hFdktbFwRK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Oct 2024 16:09:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6884D40133
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6884D40133
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6884D40133
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 16:09:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 27A6EA4374E;
 Tue, 22 Oct 2024 16:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D43C4CEC3;
 Tue, 22 Oct 2024 16:09:35 +0000 (UTC)
Date: Tue, 22 Oct 2024 17:09:33 +0100
From: Simon Horman <horms@kernel.org>
To: Johnny Park <pjohnny0508@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20241022160933.GB402847@kernel.org>
References: <Zxc0HP27kcMwGyaa@Fantasy-Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxc0HP27kcMwGyaa@Fantasy-Ubuntu>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729613377;
 bh=QnKoIYE9I5tM9ij/E5vo0HAHKj+Hq9JhRSkLc/kxH3M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s0RZ03gFkurmzZ8vewcw+eUX3RlS8XIu9wwbIN0TpYNzmN4dJZmiw/LLOm4h/e80P
 lrd+ep6qwJ5ZH73eQB45IfEA7Qab2IHBDXVbiy6dl/TVyJ+RPNT/5xZmidoj6He2fS
 142I3p/f+ZrXZixSnnjESwaUHPt7uYF0FAY5QV/wiupto0ERfL0CabuDw+fTAkohiw
 t+tM7Ov5Ch0yokhLnKuMIjrnUjsw96aWRlsDktQQpwTAPateGrAr1wYufTN/wiREKU
 VDwX6NRjHqtfDTTjdWiIXkWLKkr8xPGprWsDxA5CwIR3rIW9LzuEJExZVJwkhn4d5w
 tkB41809o6Gpw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=s0RZ03gF
Subject: Re: [Intel-wired-lan] [PATCH] [net-next] igb: Fix spelling
 "intialize"->"initialize"
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Oct 21, 2024 at 11:11:56PM -0600, Johnny Park wrote:
> Simple patch that fixes the spelling mistake "intialize" in igb_main.c
> 
> Signed-off-by: Johnny Park <pjohnny0508@gmail.com>

Thanks Johnny,

I agree this is correct. But I am wondering if you could also fix the
following around 3909. It seems to be the only other non false-positive
flagged by codespell in this file.

mor -> more

-- 
pw-bot: changes-requested
