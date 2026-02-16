Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33B3E63F3D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Feb 2026 09:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4433560B4C;
	Mon, 16 Feb 2026 09:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7H2XFi-QcVh; Mon, 16 Feb 2026 09:50:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21BFA60ACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771235452;
	bh=2zkssUp0Gj9UK4SY01tQRlARuMn/dYLo9zhZTnQb2fw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVByMXcigz83Zt44LWNz5phIex/kj9XSps/NP6eay33F68bgMt9yAwjWX9BS1V6ty
	 3o3ZgfcuEyUiNIj8YMz6Ifx3NkIyYrqBunfRwwWJrR3J5TXbtDHnkfktUXXg5oVL8T
	 9H1i2lcypaPHwt7TCZ/hxOtH1YysMZRbOOMtS9Ec7v3TjYLhexUBi+hVbcpTGy7gfE
	 n9Brl9AcYqKxzKjFVNqxiDZ/LzQhDvfGkwCXW/Teo8pS8jAOFfMjohaiqX28KY5sh+
	 /VmpiCXibVPZ5Ena4eZ9N+RHHMJ8D5mnfGjhuPc6gKZO/U0lqYGDtdwTTghJ/O/Hhn
	 q4kREl8Rlh9VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21BFA60ACD;
	Mon, 16 Feb 2026 09:50:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8451EB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Feb 2026 09:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30D03402D7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Feb 2026 09:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqsXuf0XDB8t for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Feb 2026 09:50:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3863A40175
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3863A40175
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3863A40175
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Feb 2026 09:50:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EB85C6011F;
 Mon, 16 Feb 2026 09:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2BAC116C6;
 Mon, 16 Feb 2026 09:50:46 +0000 (UTC)
Date: Mon, 16 Feb 2026 09:50:44 +0000
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <aZLodORhpbrDPJaO@horms.kernel.org>
References: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
 <20260213151344.2513857-1-horms@kernel.org>
 <IA3PR11MB89860CF09BBD00129F59A4FFE561A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89860CF09BBD00129F59A4FFE561A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771235447;
 bh=MwWFjpb1C+eOhzKyQeFDWoURC8HYjjTPP6Wc+G77Bq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pKrUyLK44/9uaqJs/pgx/NLvTJrhpGuj7l9ECuOkQqIgxoNnSviLXGZEdM1oPtXK6
 MXin4UOBzV8koqPc0T6lwxz/GscMAicdLpNWLBoihzsCKZdJIfo/1jNebJPXe4PnKo
 7VLnyyZvLwaRKQIV288K34y9aPhd2nAG2qU2E9pYWs7h3RADKQqGP5iFIsCq/Wlljj
 P8fpK4i53GXa5DZNG0FPJBilE02g4XkOrlVH1N6qe8bzq/RYH9rTBDfFuy4/sXsS/x
 VrsIW4rzJrZk1YL1g+6z7JoxEUepih40UK0+m8WLc2XdhbVsdGnnYKLAqIMxE4tC3K
 qSTBz3rH0A/1g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=pKrUyLK4
Subject: Re: [Intel-wired-lan] [iwl-next,
 v3] ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
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

On Fri, Feb 13, 2026 at 04:02:53PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, February 13, 2026 4:14 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: Simon Horman <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> > Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; pmenzel@molgen.mpg.de;
> > netdev@vger.kernel.org
> > Subject: Re: [iwl-next,v3] ixgbe: fix unaligned u32 access in
> > ixgbe_update_flash_X550()
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-
> > local.html
> > ---
> > ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> > 
> > This commit adds a u32 member to union ixgbe_hic_hdr2 to ensure 4-byte
> > alignment on the stack, preventing unaligned 32-bit accesses when
> > ixgbe_host_interface_command() treats the buffer as a u32 array.
> > 
> > > ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> > >
> > > ixgbe_host_interface_command() treats its buffer as a u32 array. The
> > > local buffer we pass in was a union of byte-sized fields, which
> > gives
> > > it 1-byte alignment on the stack. On strict-align architectures this
> > > can cause unaligned 32-bit accesses.
> > >
> > > Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte
> > > aligned, and pass the u32 member when calling
> > > ixgbe_host_interface_command().
> > >
> > > No functional change on x86; prevents unaligned accesses on
> > > architectures that enforce natural alignment.
> > >
> > > Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> > 
> > Does this Fixes tag point to the correct commit? The alignment issue
> > appears to have been introduced by commit 6a14ee0cfb19 ("ixgbe: Add
> > X550 support function pointers") from 2014-12-05, which introduced
> > both the union ixgbe_hic_hdr2 without a u32 member for proper
> > alignment and the
> > ixgbe_update_flash_X550() function that passes this buffer to
> > ixgbe_host_interface_command().
> 
> Commit is correct, please configure your AI to look all the history of the patch, where I explained that it was a 0 day issue.

Sorry about that. I did look over this myself, but I guess I must
a have forgotten to look over the patch history at the time.

...
