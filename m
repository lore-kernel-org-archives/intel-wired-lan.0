Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E42CCC6B33
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 11:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72AAE806BC;
	Thu, 15 Oct 2026 11:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iiRH3va0PUti; Thu, 15 Oct 2026 11:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C85AF81102
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062346;
	b=PcQbYk/3j8cKaGrIjYBBOBL8BjqL/bweCuNoCSbwsJqC3/eG/8J3ZHSGCMINjZhBFG96
	 rNneZEa8LqzHUhHfEJMduyCAyIYTNNrNzp1kgw6PCK7Vr0DITdFVOpI+L4n+f4VHYmXoE
	 2+ePE9oNFIx2aByJytTp77+bXOBaPNObY2Hp3Ktp1W4dhXcJF/KqzKXS7gdAHKqhl/V54
	 hg3jhMyHCtfcUrx5UfAEoGJtN8ZILe0KmulUKO166lxmL9m1XDYt1EJI4tkVwmqlkFLAw
	 pM8NI37vi88FUzEKj/gp0IIMEjQlt/DTPqDi2WG77MNYLR0egxGvxwg6W+0ONLyycOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792062346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gpSCGiwFK8jb1vIu0OazDdrhB4i9b6EHzc8RrbUAqCI=;
	b=UOW8yEs/Nof4snFSxdaYhz+Fp5c3KqoYt53ehzdqsAs0FKYLgPxPANcPKEvw5gpi+yeJ
	 84hrkNtVjYnihR4y1CFLSgJ9OJINb1lqLpdfVn3D1btj7ItjC6hWmXOUqGZyWbVSwaooc
	 DQQHnQSQOuLF3Pnlc/s1H+TD4fibDFpXJdQQ56I12k5ncVJ9SZmrRTcAirdN/rhpfwe3O
	 KZrk+E1edlKZLehPqtHqP7NR9Da5EQrfIVvFrz0rAKZsSsO2fUwOodvCRnr/wZ6oZ3Cv8
	 /fVHQkz21GBu/VN9ypAUAnBURFftySh4DYHm/rGHTN+mGmnrhjXzgjLnAgxyYx+qMmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792062346;
	bh=gpSCGiwFK8jb1vIu0OazDdrhB4i9b6EHzc8RrbUAqCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zarSgiszonotjXNlts8yYVc3dN0w9j3MT16EPEyKJME4L2ZbZ016bt470xHCoRLVz
	 5j8SjTIP5oa0mczeBrBVUZznE4Ez5IQ42+diCSbqxZfbLEVLddrfPfoXHzswucg347
	 o8jd9AZiyUVq22UFHfydZK4ecvo04k1HYfZP2UNshOGE/a16CgZ8RfWXa6V8Z2EBDU
	 6TSThFoAFJ27CGhb8+DqIU22NY5cYRIzo82y1EQDVyqOdtC7cERUVPFWQAwbo77mnN
	 feZqpbu0kYj6vXw6l8WqQJEfutPdZm76kr1O7gJOaGuIg4+VtuIV6YQPd4ZKnZLxfP
	 spjg9Sz4YkH1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C85AF81102;
	Thu, 15 Oct 2026 11:05:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59AF449D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B182606ED
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oBhH-mlaS15v for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 11:05:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8569E605CA
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792062344;
 b=gVL/SCQTw5ASlIfuVGUq7dTsCs9KjPl42+GaWKNMkj6KZd6PCkcYw3I3W+/tuatLs4eO
 HmhmyslR+YVr+8j2kDme/EXpJ61/CNaBLYjeH5j1+qzkaGPcgGByY8eiG2NHarXVwi3FL
 Z3/6BtoRrTWOVKBdqC2WqX+WX9kgSQZwnY4/4gYiFj/LdOYYiuBnsNyivBSU1cWGYI+Ni
 zjxI5o8ihPAnH9OJvyo08D6+E3SOo0QZJc1IBuAOr/jX9tsKwSy5Nsq/w+WN4E/g0+BuK
 ywU0EWOzoAJ8k1Rc5PuyvexxhoZf09puYiJCKhRvnzmvI+T1NRuXd1tv/vU+L0r2eEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062344;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=gpSCGiwFK8jb1vIu0OazDdrhB4i9b6EHzc8RrbUAqCI=;
 b=jOZOzzSRSRvp/K6RuFjSv3iEtkcvfuL0JWe8vQHkN1Mp5INYQlYp9y7DAOWhOWOytFNV
 WVYtoDEsGtGcCI1WOAzSo1XC8QGdSaP14WGt1RD9MswBCKKk86XxTeRzmnr0rRA0Qjk3J
 i/efzFsneoBJUxeOq0cQPolZsHZxBNBt5aL3fZR8Fb91imTR6Vt+6/eYzmBuNW1hXl1I8
 ZbrI7+kkl5K0qoACiLeWwbX7oqL6TbBy/8h68NzUgzZ7XI8pyqRZrM7AG9uGopNGXGC9D
 bT0EMumJNO42QLs1DGYqyWY9XsLwhMV6eoiAtoV+jAxoYfOg/vCt7NuZVMDJ0mekykQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=l6LCn8t0; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=l6LCn8t0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8569E605CA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 11:05:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFD6543D4E;
 Thu, 15 Oct 2026 11:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2F1F000C6;
 Thu, 15 Oct 2026 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792062343;
 bh=gpSCGiwFK8jb1vIu0OazDdrhB4i9b6EHzc8RrbUAqCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=l6LCn8t04D+Qv5obZrwkKu8P27FNKN0hPhMkk36APmayhUMkDhMmutsQ1Nc+PqAYX
 psXMIXwulx7BOjShXFADnzt8VSBmuN0KbQ1iSrc6YZCgZybzayie/EcqHkV9GiF0h8
 y7wy7ExO0/AmEtflGZjuML+Yxl0UyA3+sQIOqgJC4eMoyz9oxSwfC1QAqJjtmbeTxz
 U/y7dSurYhkre+bADIq5VDkPZ0cEPDuzA05Jonj/42MASVqK1y9LqTlUMqYvQKRceJ
 sohQpW+in6+g2CExeFNw+5Zg8lYkvEWK2AunJywm0LmJo1biuzOA+KTKIVI5yqfQvo
 825RaNlz91EiA==
Date: Thu, 15 Oct 2026 12:05:37 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 intel-wired-lan@lists.osuosl.org, edumazet@kernel.org,
 pabeni@redhat.com, davem@davemloft.net,
 Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
 rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 anzaki@gmail.com, brett.creeley@amd.com, jtornosm@redhat.com,
 ohartoov@nvidia.com
Subject: Re: [PATCH net-next v2 13/14] ice: represent RSS LUTs as devlink
 resources
Message-ID: <20261015110537.GF83879@horms.kernel.org>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-14-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009121433.30347-14-przemyslaw.kitszel@intel.com>
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

On Fri, Oct 09, 2026 at 02:04:24PM +0200, Przemek Kitszel wrote:
> E800 family offers three kinds of RSS LUTs: VSI LUT (sized 64), GLOBAL LUT
> (sized 512), and PF LUT (sized 2048). Until now the GLOBAL kind was not
> used at all. There are two possible usages for it, subsequent commit will
> give VF option to acquire it, and this one enables PF to switch between PF
> LUT and GLOBAL LUT - switching to smaller one is, again, to make it
> possible for VF to then acquire the former one.
> 
> Devlink resources are used to let user show current usage and change the
> allocation, see examples below.
> 
> Default state on 8-port card, asking for aggregate "whole device" usage,
> note that there are as many PF LUTs as there is PFs, and, for e810, there
> are 16 GLOBAL LUTs:
> $ devlink resource show devlink_index/11
> devlink_index/11:
>   name rss size 8 unit entry size_min 0 size_max 24 size_gran 1 dpipe_tables none
>     resources:
>       name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1 dpipe_tables none
>       name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1 dpipe_tables none
> 
> Now let's add GLOBAL LUT for a single PF (on one-port NIC):
> $ sudo devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
> And show it's resources after that:
> $ devlink resource show pci/0000:18:00.0
> pci/0000:18:00.0:
>   name rss size 2 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
>     resources:
>       name lut_512 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
>       name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
> Let's take the PF LUT out of that PF afterwards:
> $ sudo devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
> now `ethtool -x $ifacename` will report smaller RSS table.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Przemek,

With this patch applied the following errors show up for x86_64 W=1 builds
with gcc 16.2.1.

  .../resource.c:340:17: error: typename in expression
  .../resource.c:340:21: error: Expected ; at end of statement
  .../resource.c:340:21: error: got rel_err
  .../resource.c:340:17: error: undefined identifier 'int'
  .../resource.c:342:17: error: undefined identifier 'rel_err'
  .../resource.c:343:21: error: undefined identifier 'rel_err'
  .../resource.c:344:25: error: undefined identifier 'rel_err'
  .../resource.c:344:25: error: undefined identifier 'rel_err'
  .../resource.c:347:39: error: undefined identifier 'rel_err'

...

-- 
pw-bot: changes-requested
