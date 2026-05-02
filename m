Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5D9CD13DA
	for <intel-wired-lan@archiver.kernel.org>; Sat,  2 May 2026 17:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DBD1610A0;
	Sat,  2 May 2026 17:27:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWfbe4pf0ihz; Sat,  2 May 2026 17:27:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD4056109B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777742841;
	bh=wlP+d1NIKAAByaeePWEIuCAi+E0RlB12el0dg4r9gnA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=KIE6vT7gZnBIcooIVzBQBWVqjkrnOeVcax0NA6nWsXtp5wXyhY/KcHjjlRb0ktxnZ
	 ggmcQPhxMA9n6Oci3eqcsAj8X26VZWEJWVNhwK88i0brqEefhmedzjwYWxiwn58qXa
	 4CTfAJd1u2wd0YED4XG/JCFaN9Anz2eFSjjbFor+B4d4WqVSDIzWsbmjVeunMNm6A+
	 zKDg4ySSjzpyYxqRSvslhFnxZ+/dg8LxRfXoRwph8MT2YaWMFah6YrqYWh1WvTA07w
	 z0xovUg/S6VIj3y2KCTN32hi7+EnthdTotYvdsI7oHZXWUCCMZJQfSBETm/rqacyXf
	 1hQx2EW+on3jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD4056109B;
	Sat,  2 May 2026 17:27:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2C29127
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0FE2412D3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsKnWv8EjWCm for <intel-wired-lan@lists.osuosl.org>;
 Sat,  2 May 2026 17:27:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 34F33412D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34F33412D2
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34F33412D2
 for <intel-wired-lan@lists.osuosl.org>; Sat,  2 May 2026 17:27:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E05B60120;
 Sat,  2 May 2026 17:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A8C19425;
 Sat,  2 May 2026 17:27:16 +0000 (UTC)
Date: Sat, 2 May 2026 10:27:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Message-ID: <20260502102715.2ac364c8@kernel.org>
In-Reply-To: <20260430094238.987976-3-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
 <20260430094238.987976-3-grzegorz.nitka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1777742837;
 bh=iuYfZKUsNFsWCYPYDPPaNu+LCCi5oQDcfqzf4SNpk70=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=l/a5kajjxzIX7CwRTkvhKQ0DYG8l2UfCCg5YkiLPBia0fvmdwd/b36WgPs/y3EOCf
 Oba4ioqDlb4yliOCAqRiCn1t1j21Q0XXIa741i1Gj/u+YVjEgijMYDthLOeqPhxE/b
 4FdfNHjgOiCLujSG60SEWhgQBijMV5dPTbJqPp2neSrXywc+3gBNMw8+6bGb080S5s
 SrxIIa5+ERxkrmONbsucmHHWWO+khgtawrjGPuqRd5oT3GoGvzD3vYwSOTIXilwXnD
 lISSAZ3Wh4Ts6VMB2fCVE8DGre5lt4VpkJg6i1OZwU14Twa9Yx6NzYl3tvLAXYcUgZ
 ZpzVXnW8Cwe3Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=l/a5kajj
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 2/8] dpll: allow
 registering FW-identified pin with a different DPLL
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
Cc: ivecera@redhat.com, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 edumazet@google.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 Prathosh.Satish@microchip.com, andrew+netdev@lunn.ch,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, pabeni@redhat.com,
 davem@davemloft.net, Jiri Pirko <jiri@nvidia.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 30 Apr 2026 11:42:32 +0200 Grzegorz Nitka wrote:
> Relax the (module, clock_id) equality requirement when registering a
> pin identified by firmware (pin->fwnode). Some platforms associate a
> FW-described pin with a DPLL instance that differs from the pin's
> (module, clock_id) tuple. For such pins, permit registration without
> requiring the strict match. Non-FW pins still require equality.

AI asks what prevents the modules from disappearing:

Does this relaxed check expose pin->module to a use-after-free during
netlink queries?
If module A registers a firmware-described pin allocated by module B,
they will have different module pointers. 
Because fwnode_dpll_pin_find() increases the pin's refcount but does
not take a reference to module B via try_module_get(), it appears module B
could be unloaded while module A still holds an active reference to the pin.
When module B unloads, its struct module memory is freed, leaving
pin->module as a dangling pointer.
A subsequent user-space Netlink query using DPLL_CMD_PIN_GET iterates over
the registered pins and calls nla_put_string() with module_name(pin->module),
which would dereference the freed module memory.
