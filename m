Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FA606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=NuTbZ62u;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcojK46x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E287660789;
	Mon, 23 Nov 2026 16:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24gzA1s2wh0u; Mon, 23 Nov 2026 16:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7E896077E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451466;
	b=EAFwqjRWop+5S9cnU8B1rrfhmplTTUcbnp6rwqoGxVP1ZopUz/W4dEul+6Ob07sEfk7q
	 n/iVpm69cZHfYk36xv4z/SHnyLuAJcSOHlX5KYMwHHfh3T3KaeRkAYdAQofHYadYqRTgh
	 K8zMmIg+9cWesYN/f5Bo3N8zHMJHM5vg0Du/qhDHPITiQSpJrCrtjXozKa8TZOMvELfio
	 u6N5D4iDiWGqsxNfgA+F61x+gN4siVP+SWfKuoNtGSx0rutdERCQklf6i/QFfyBB5qFnn
	 txx7iOe98zTG+XTmGlZw8dmlYB+d/ZnyiDeITFqx0B09aUseAacNEIkRa0qwUczUkDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jMtoEqXohvqbclVtS9Z+5YKaFu68bPrDQCuZaxatwVg=;
	b=a/8nqYZ1yED/jd+N7mjlO9G6g6wJyCEAgo535QbaHm+ulX6q65Jw6jSSlGa+V+hKQmga
	 T2qwa4ddAoRsao9Mxrp/X6HVPLoaS3exapY01s2m6wRxjLNyTtdvl/uY/6MLlNlKpTjTv
	 aALDEwdVN1p1lfJWOV6FtBrDQYBaB4Nep6SrO0Ot+dvQpjucydH0PHtIhfie3zZtTt0vY
	 GXUB2lZouETbwqCr3O6duNWar81PCYL0sUy9kEnJFCGnXXaGNW6ItXgfW8RxSOyVky2ur
	 aEJW+DgvLf8Rpymnt6ziontzE7MH0Pn4Q6RYqmzsF1l+TYMsPK/+vR5fYunxAKHbFRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451466;
	bh=jMtoEqXohvqbclVtS9Z+5YKaFu68bPrDQCuZaxatwVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NuTbZ62uviKdMzb+058ECx8xeMoeuv2egmQzFSEPmtdXbzCtXIElLxIi155/CnLfn
	 bJ5S/yucyT1VFBbR3HO+ILo4hOcCDW5dYQy6FWqwJP6uDmMpy34WngwGhRf8/VtGGL
	 TKWjNOhQBiku4+gDzjptxLvHNKdozFdVgI4CKgH68wDKkea6QCzrvNruHYlyzRR9Q6
	 gAWIpwDANzC5DUwjQ8NmYzfvcOfgKjn8O1XRXp5H9upcycChD3GWkC/dJ3SPFkGfIy
	 7gnxJQKYCV0cOUFe8zWIm2OkcAjcJX4gfQv+jW0QaP31vtOnEOYGPS4cdhxdtGA3x9
	 sLl+4/5U/RtAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7E896077E;
	Mon, 23 Nov 2026 16:31:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 312C3371
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 16:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16EE580C80
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 16:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6SmUgypL3Do for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 16:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62BB280C7B
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LcojK46x
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62BB280C7B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 16:31:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 977DC61ECF;
 Mon, 23 Nov 2026 16:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C91F000C0;
 Mon, 23 Nov 2026 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795451463;
 bh=jMtoEqXohvqbclVtS9Z+5YKaFu68bPrDQCuZaxatwVg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LcojK46x3wYV53qVzLH5hJDKmV2TAvMH7bVELtrYyr0zL68uIMU/dx8DQLFhpPmbw
 GFZ1/oB6yTH7t6lOUTaBn4mxsqpRjt+Qni3iNgsw3YJer5jZIXnEc2s+7VcgGJCAEE
 KY1AO9vM2uf0fwtvebGqLjQlOCHCC8xDLT7OTVzc36HYEVcLNRfGDIkbWM3kD/8blN
 7cFdV9ao45SOmJnViwYRJOZv5Q+1XMzsFAJ4+3OwxxjEUgfT3XApZEDeITTK1fdNOs
 jz55NsEp6RJCihCcgmwI3OETWc05nnH1MGRDEo7T+KKWn4w2CUoRLhc5EdrwAkaIJr
 WnBNENAPWSbUQ==
Date: Mon, 23 Nov 2026 16:30:58 +0000
From: Simon Horman <horms@kernel.org>
To: Changyul Lee <lcy8047@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] idpf: free the RDMA auxiliary device ID after
 deleting the device
Message-ID: <20261123163058.GG31322@horms.kernel.org>
References: <20261118051611.3892489-1-lcy8047@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118051611.3892489-1-lcy8047@gmail.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 12:16:11AM -0500, Changyul Lee wrote:
> idpf_unplug_aux_dev() returns the ID to idpf_idc_ida before
> auxiliary_device_delete() removes the device. If another idpf device
> plugs an RDMA auxiliary device in between, it can get the same ID, and
> its auxiliary_device_add() fails with -EEXIST because the old
> "idpf.<vendor>.rdma.core.<id>" or "idpf.<vendor>.rdma.vdev.<id>" device
> is still registered. RDMA is then not set up on that device.
> 
> Free the ID after auxiliary_device_delete(). It still has to be freed
> before auxiliary_device_uninit(), whose release callback frees adev.
> 
> Fixes: 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev deinitialization")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> ---
> Found with a static analysis tool we are developing.
> 
> Compile-tested only, with x86_64_defconfig plus IDPF and W=1.

Reviewed-by: Simon Horman <horms@kernel.org>

