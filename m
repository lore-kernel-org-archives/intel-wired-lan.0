Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B894C54E41
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Feb 2024 14:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C116183934;
	Fri, 23 Feb 2024 14:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwzIsvi4racS; Fri, 23 Feb 2024 14:28:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 266D883981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708698486;
	bh=lKtrW4GMnQVgdsk+OCSlRjQ4X6aX3oMpFPdIq4gaHdA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=jl2hiaLRjTU01g11eq9PyeTZnwX7cYNhrOINAWlS717RCeCvDL8ELTusDBLlVOTAi
	 W/IKBme3MsDtigrcC/AsFBI7Xi9LmqU8ppaOk5QWzvhj4r6rRGk+i/um/1jOFQ3BmB
	 hvpJPczzTdkeZYlHFAuHntZAPfJHmRpxbSp2S1UM/pfY8aUpXSR698eHqAj8qWd6Lo
	 qPy7+ofY9jiH4PGzQkATKZvYE4ZYUULD6sgSpthojk+AmhsM18Q6b+eg0tQ3yeWn62
	 ZZhO59w/RNkBkffWK5IjPokcHEtvTRsA7dFs48xPnu6BTH/USPNlU1yfS7eoFwqGTf
	 nT08mhPgm+3ug==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 266D883981;
	Fri, 23 Feb 2024 14:28:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9EA811BF405
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Feb 2024 14:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A4AC41E2B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Feb 2024 14:28:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9x2u5E5XRoSX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Feb 2024 14:28:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6649A40577
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6649A40577
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6649A40577
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Feb 2024 14:28:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 708D5CE0946;
 Fri, 23 Feb 2024 14:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D761C433C7;
 Fri, 23 Feb 2024 14:27:58 +0000 (UTC)
Date: Fri, 23 Feb 2024 06:27:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20240223062757.788e686d@kernel.org>
In-Reply-To: <ZdhpHSWIbcTE-LQh@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
 <ZdNLkJm2qr1kZCis@nanopsycho> <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org> <ZdhpHSWIbcTE-LQh@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1708698478;
 bh=dUmWQ9n7sIkmFlhrGkOwc5gWZDmdaEyboZBntzW4NCA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OZiOUqQbiTzJhC4dRHtzLn3RJK5XLUqNdWgPFw8q92Ju9AwDwLcEzii9k4FzGpndb
 ZNMQCIkQ0arvoOv3HfYqBhVvbnAnYZwC4NRKgHaY6tCf31tHEyPS4XM9yehTpXs9Ap
 kJtuYwlEChOKtOy86qGFE6GcoUfpRaMoGkvSGFiPq9CKQCbW/dbzChIArFjQW5YMLx
 2B7avkBHfIw1lAK6vRtZ1VcutYZx3pZ8rq6VJWRj3dIVTOAa1KrYfkJdODze/EvZCa
 AManKNhaPZ2qqjJYgyAtHrEkxw7MqhpYy2aSzjwEEl6OA5QhIfIECVmIx+KK7PXTsr
 Sg023Gj/g7yog==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OZiOUqQb
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

On Fri, 23 Feb 2024 10:45:01 +0100 Jiri Pirko wrote:
>> Jiri, I'm not aware of any other devices with this sort of trade off.
>> We shouldn't add the param if either:
>>  - this can be changed dynamically as user instantiates rate limiters;
>>  - we know other devices have similar needs.
>> If neither of those is true, param seems fine to me..  
> 
> Where is this policy documented? If not, could you please? Let's make
> this policy clear for now and for the future.

Because you think it's good as a policy or because not so much?
Both of the points are a judgment call, at least from upstream
perspective since we're working with very limited information.
So enshrining this as a "policy" is not very practical.

Do you recall any specific param that got rejected from mlx5?
Y'all were allowed to add the eq sizing params, which I think
is not going to be mlx5-only for long. Otherwise I only remember
cases where I'd try to push people to use the resource API, which
IMO is better for setting limits and delegating resources.
