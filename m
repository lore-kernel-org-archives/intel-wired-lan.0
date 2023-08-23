Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D17EE49A0
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Aug 2023 09:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8C4F60774;
	Wed, 23 Aug 2023 09:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8C4F60774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692784516;
	bh=ckNauWryncv5R43K0vmzVb2Bwqq6R7YrZ7B2kQjXD6s=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dzlyYDpcgPy0Oq3NDq+RHohKyYIaAOZkI6KVxcB8mRaQNf+LaHkwkk7LzD54zKcji
	 rX9KzxdNu5689Fxmk+6M2b2lvruYm2s8jhCxKlgAaSCGCYAynhiDg2vAyUk7XQ3GFh
	 2pEC6QvsGBVjXYcdR8bknx1bS4B2YCY4RGzJKuHyO40vQP8FNyJb0m+QGip8HgQQMy
	 E62R49vynTn4T7nY8r4nKxXyW+IFlQPq72yHXm9OI6IEhNnhNBUwDQye7TQkZPs2oW
	 UOvIFmsNYZEQxBmQO4C/Nw/Zg2Hf8zzYaa6bQgkfyac6v2Egi9tym/urYLxpAMjCaT
	 zsgjphxKwomcA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FD7EVRxuNTxt; Wed, 23 Aug 2023 09:55:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEC8D61018;
	Wed, 23 Aug 2023 09:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEC8D61018
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 102CA1BF34E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Aug 2023 09:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7C4E40093
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Aug 2023 09:55:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7C4E40093
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mGmhBKpEo8n0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Aug 2023 09:55:11 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B22D24005D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Aug 2023 09:55:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B22D24005D
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D581C61F47;
 Wed, 23 Aug 2023 09:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C5FC433C8;
 Wed, 23 Aug 2023 09:55:09 +0000 (UTC)
Date: Wed, 23 Aug 2023 12:55:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <20230823095505.GQ6029@unreal>
References: <20230816085454.235440-1-przemyslaw.kitszel@intel.com>
 <20230816143148.GX22185@unreal>
 <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
 <20230818182059.GZ22185@unreal>
 <12025d38-a5e2-5ddd-721f-c1c083785d22@intel.com>
 <20230821110146.GA6583@unreal>
 <CO1PR11MB5089F6E24C2570F710191DE7D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089F6E24C2570F710191DE7D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692784510;
 bh=374eqabuLD5eZtLmI9aX1HGOmzU8xfpSHRjCB9fqxSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KPJ59HFn9aOZHGfmcupSI9/idOeQTnJA/Cnp/LpHRBpLqREKi9fJFqTe85zZI2+3B
 2EB17ooMpxuZeujjaf7/gStxLs1MfLQ375Lr1+KQ5JvyS6Uo+55yGu0aTn0+tKl9tu
 LoRg5kXtKU5LsWKvTiLheQ1atK8XnDI55J4PV8qsiUvpxXZORXuzge0tmAhin3i+n8
 t4NCHQ9T8EzM7QVghb4zIr6F1G/SRuUgQ09QVaoGO8ufC68ShVXNQ8oGvaZ7JD7fUx
 MQlgBx6SqQ3P+HRCOiQvtFs6aSjSqszNHkWlB9KmY5n5ho9WQ9RUm/RNO4zasLwjes
 uVLLum77b8+Bg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KPJ59HFn
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
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Aug 22, 2023 at 08:46:46PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, August 21, 2023 4:02 AM
> > To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>;
> > Keller, Jacob E <jacob.e.keller@intel.com>
> > Subject: Re: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
> > 
> > On Mon, Aug 21, 2023 at 12:48:40PM +0200, Przemek Kitszel wrote:
> > > On 8/18/23 20:20, Leon Romanovsky wrote:
> > > > On Fri, Aug 18, 2023 at 02:20:51PM +0200, Przemek Kitszel wrote:
> > > > > On 8/16/23 16:31, Leon Romanovsky wrote:
> > > > > > On Wed, Aug 16, 2023 at 04:54:54AM -0400, Przemek Kitszel wrote:
> > > > > > > Extend struct ice_vf by vfdev.
> > > > > > > Calculation of vfdev falls more nicely into ice_create_vf_entries().
> > > > > > >
> > > > > > > Caching of vfdev enables simplification of
> > ice_restore_all_vfs_msi_state().
> > > > > >
> > > > > > I see that old code had access to pci_dev * of VF without any locking
> > > > > > from concurrent PCI core access. How is it protected? How do you make
> > > > > > sure that vfdev is valid?
> > > > > >
> > > > > > Generally speaking, it is rarely good idea to cache VF pci_dev pointers
> > > > > > inside driver.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Overall, I do agree that ice driver, as a whole, has room for improvement in
> > > > > terms of synchronization, objects lifetime, and similar.
> > > > >
> > > > > In this particular case, I don't see any reason of PCI reconfiguration
> > > > > during VF lifetime, but likely I'm missing something?
> > > >
> > > > You are caching VF pointer in PF,
> > >
> > > that's correct that the driver is PF/ice
> > >
> > > > and you are subjected to PF lifetime
> > > > and not VF lifetime.
> > >
> > > this belongs to struct ice_vf, which should have VF lifetime,
> > > otherwise it's already at risk
> > 
> > I'm not so sure about it. ICE used to use devm_* API and not explicit
> > kalloc/kfree calls, it is not clear anymore the lifetime scope of VF
> > structure.
> > 
> > Thanks
> > 
> 
> The ice_vf structure is now reference counted with a kref, and is created when VFs are added, and removed when the VF is removed.

Ohh, great, thanks

> 
> Thanks,
> Jake
> 
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
