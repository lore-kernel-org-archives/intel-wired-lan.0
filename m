Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EDDEE498E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Aug 2023 18:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D36E84196;
	Fri, 18 Aug 2023 18:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D36E84196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692382872;
	bh=36L2RKu65pkP2sbPwbcoDXSo+KlrQ8ZooJAV+PKPE+A=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AuMj8HaKUH+3bIlfzrzSBMdBkQfPyFjgrfhmzCQBfMaRNL4bO5nTu6ymbdbQNE6+M
	 qaupM02TXae0fuG6NgiOone4tMk4gVUHlIQZI5pgQjsftOg+yVayqjFEkTeG0QDJpS
	 NArWLtGoF4yIaovLL+ELQ7nNdLGheOygPcJjjs3T5QP8UwTVRY1DSf+9csLvmam03P
	 0apYHhUKXmE5QFnlW6wKl0dCqPAzvoprhSaaJqqmaunIijiHpP7Rq2VsOCy7wNNkG5
	 NaP0znZ6tDjiHCIZf5Ba5PwwJzlr5ITunXJC3V34bBU6Yu1WX+gbJmUEAf7jQnurkY
	 lHekAkI+v0p3Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVfDU4xlbiQQ; Fri, 18 Aug 2023 18:21:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71AA384190;
	Fri, 18 Aug 2023 18:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71AA384190
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 9D2EB1BF355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 18:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7753540156
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 18:21:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7753540156
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2qMd0jrMmQP6 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Aug 2023 18:21:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97134400C8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 18:21:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97134400C8
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AE52A63E3D;
 Fri, 18 Aug 2023 18:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BBC433CA;
 Fri, 18 Aug 2023 18:21:03 +0000 (UTC)
Date: Fri, 18 Aug 2023 21:20:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20230818182059.GZ22185@unreal>
References: <20230816085454.235440-1-przemyslaw.kitszel@intel.com>
 <20230816143148.GX22185@unreal>
 <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692382864;
 bh=5fxqgQEkZHL6btJ4/Au0C0GLYzcSoQRp1lYvf5OMydU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tuQYz5if+ijqMRJwbHBOnMHfraDlqs9NUUkc1TnPej4p5XJgz1qSzQzZJGocMaYWV
 j6Q4bZww5+8VBScmlvzqoV+aNUVxK90By8eOgRY6Uh5YBbPtjh9rjV5+AjY20VuLPV
 6UPAPgGebVn5YtbloV1ZgIUoyotS8hxCZFYc81m6BDKPmnbGwvr0qHyf6qAPZ3z5Yq
 MrKoAnqEKhmDQlyAnuQZN8R4R6L4WT0rQmWvOkU7V5Kz0RIOKgoCsWziTvWZOEF+Ty
 kPmQ07HrdgGM9ysbz2xXxqpDvUA2agamctMdAZ6DtDWnY5rhdE72HU+SmDlKkjGfU+
 b35pI6Fpp5edg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tuQYz5if
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: store VF's pci_dev ptr
 in ice_vf
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Aug 18, 2023 at 02:20:51PM +0200, Przemek Kitszel wrote:
> On 8/16/23 16:31, Leon Romanovsky wrote:
> > On Wed, Aug 16, 2023 at 04:54:54AM -0400, Przemek Kitszel wrote:
> > > Extend struct ice_vf by vfdev.
> > > Calculation of vfdev falls more nicely into ice_create_vf_entries().
> > > 
> > > Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().
> > 
> > I see that old code had access to pci_dev * of VF without any locking
> > from concurrent PCI core access. How is it protected? How do you make
> > sure that vfdev is valid?
> > 
> > Generally speaking, it is rarely good idea to cache VF pci_dev pointers
> > inside driver.
> > 
> > Thanks
> 
> Overall, I do agree that ice driver, as a whole, has room for improvement in
> terms of synchronization, objects lifetime, and similar.
> 
> In this particular case, I don't see any reason of PCI reconfiguration
> during VF lifetime, but likely I'm missing something?

You are caching VF pointer in PF, and you are subjected to PF lifetime
and not VF lifetime.

Thanks
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
