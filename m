Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD436C47DD9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Feb 2024 23:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F1B8403F9;
	Thu, 22 Feb 2024 23:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d2pcX0enDLNf; Thu, 22 Feb 2024 23:07:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9697041A14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708643241;
	bh=Y34mLEK0cZyHiOhgvSjxyPqet3s/p0HgIRzNxyGqUHE=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=r+oChMZG2rEYnn1O56D5rkHV2OIQBMDN2Ja0qzYSZUEOxEhz5UYHYOXIcXgpq+49i
	 /20ZxiSZqqThrcKK7In0++lw51EDgOeJnbEVn2n94KQiDa7/Qsv4/GpiDQHEL6XAYw
	 CcaPh3zH/ujSW3POkrk9Ig4TyDqigjEf6/DvR3v6vuLw9LMAd4Z4Vv5YqwJSHSjhzM
	 mrNhTuFm6I88ZH4sgorPb/VwVKo9ZBJqWpmpW91uvzA+/w/k30DCTmMLOlC+1YCwXf
	 qeu694fvVBdO6KKSw6GchGlplzui/CU7/kqbAmSr/XKlKtqC0R1rOfRuxykLSB/C8f
	 Opm2T8ltjnRUg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9697041A14;
	Thu, 22 Feb 2024 23:07:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BEEC91BF404
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Feb 2024 23:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A90AE41A14
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Feb 2024 23:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1KddavEFyUxb for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Feb 2024 23:07:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CC151403F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC151403F9
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC151403F9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Feb 2024 23:07:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E555563349;
 Thu, 22 Feb 2024 23:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C60DC433F1;
 Thu, 22 Feb 2024 23:07:18 +0000 (UTC)
Date: Thu, 22 Feb 2024 15:07:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20240222150717.627209a9@kernel.org>
In-Reply-To: <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho> <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1708643238;
 bh=tLpCJuni9rb3m7ZM7NstXMA+xk57bKi7V6ML0f7H35A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C7zPGvmIoOM00Pa+BaUg6Gb8zXykl8lKxj3yDTdfqz0XhLG75S7bvoUyR9JWzuX2o
 vZ04BUm9QphfO1ZI08Oh/CnYT3iGgvoLGoZBiT6CeZvVTX5f9he/Xn7hwNe46LhdIX
 Gw9ciuOYUPWC/mnydsxniAbEa9CGsut5rSWdyRitPTYzaJRoyZiIhjmZKm4Wy6EYgk
 +KaSghyQukozxRHekA4UZjn2xIv/ZBDVv2nvfzfCENswabQB6jeTELq1pelo5tna4j
 7bSUmfiHhvNe3HFiFMOwEq801XLiU6mnKJHdTFS2MCqaGe1M37LR8NdSZlaDwZXQk1
 jK9qRr4aTppfA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=C7zPGvmI
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
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
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, netdev@vger.kernel.org,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, intel-wired-lan@lists.osuosl.org,
 horms@kernel.org, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 22 Feb 2024 14:25:21 +0100 Mateusz Polchlopek wrote:
> >> This is kind of proprietary param similar to number of which were shot
> >> down for mlx5 in past. Jakub?  
> > 
> > I remain somewhat confused about what this does.
> > Specifically IIUC the problem is that the radix of each node is
> > limited, so we need to start creating multi-layer hierarchies
> > if we want a higher radix. Or in the "5-layer mode" the radix
> > is automatically higher?  
> 
> Basically, switching from 9 to 5 layers topology allows us to have 512 
> leaves instead of 8 leaves which improves performance. I will add this 
> information to the commit message and Documentation too, when we get an 
> ACK for devlink parameter.

Sounds fine. Please update the doc to focus on the radix, rather than
the layers. Layers are not so important to the user. And maybe give an
example of things which won't be possible with 5-layer config.

Jiri, I'm not aware of any other devices with this sort of trade off.
We shouldn't add the param if either:
 - this can be changed dynamically as user instantiates rate limiters;
 - we know other devices have similar needs.
If neither of those is true, param seems fine to me..
