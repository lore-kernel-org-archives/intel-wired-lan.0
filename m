Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53611C5AD4C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Nov 2023 11:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA15641E68;
	Thu, 23 Nov 2023 11:58:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA15641E68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700740711;
	bh=usNVUX8eOyIcyS9FkKqFeMkAMUu+leWncAL4laUJeYw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=O+U0HCwOmBLIOayJ8OotkTFtaCe8tdNptwOzpWhFJkRsj74EtxHrpGl3luypOsNRl
	 XTM5Rpnhgy3Lvhe+LsPC3X8uosuCdcrZRACbrz0lnKFfK0CyYIAFuE6Fisx9DifQAv
	 8zBWws9NAhg/I/gxf7y+tCnJCl+hysOvlEeczoVTGq6FzeMiJRDx2Y0OPaRA2p5aBB
	 /FAECJUXPi6cdK5XKNunjrQB0BuJ3n5yDx5rfMi4WYvEao0KsIKDm2ZPP8+badJGzN
	 BLVz0a80UoUB0Y1uWD+ohXzopsxTVYX74sIskT3F4yFhRkBKY1hFaSpCRULFH0Uupb
	 HC8hrVXHp8l/g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXIHaCqew3zG; Thu, 23 Nov 2023 11:58:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CFCE41E6A;
	Thu, 23 Nov 2023 11:58:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CFCE41E6A
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 05F671BF5DF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Nov 2023 11:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D25388202B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Nov 2023 11:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D25388202B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6s44vNTIMqm for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Nov 2023 11:58:27 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 213E182025
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Nov 2023 11:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 213E182025
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 648F3CE27FC;
 Thu, 23 Nov 2023 11:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262BC433C7;
 Thu, 23 Nov 2023 11:58:21 +0000 (UTC)
Date: Thu, 23 Nov 2023 11:58:19 +0000
From: Simon Horman <horms@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <20231123115819.GC6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700740703;
 bh=6rq3wbNnETxmGO38nmjeAXuf2R7yIaTdB+RurHtR94s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ReK8N3T9qK44A4ISJlFiWiFFDjP+AZ13R55LmXzAECstsIG0PbM/mCm8RJjxXX5hJ
 kP9D7KIB7sZeE8u/K9w89wgKRsDzRyuI1K1TmykhD4+SS9syKgtHAlrXwy4uOs4s5D
 321wrppn1hKNaJDxT2IFPnSGOgehxTCQNAMkfwxw84yZrQqxk8E/0dARIP0r4fXcg0
 uhN2iyBqwUOSBX+64+bJscIjZV/wajbCSQwZz/AiiwVlWMpUss+Ok1+A+8bTrOfUzJ
 1iw9GrbgfP87j6gT92nwY0dNnSZgxR9o6HL8O9Q7GuJmoZzqD7aYCNQDWN3qCkDKlt
 ZZ03JRsa1RdbA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ReK8N3T9
Subject: Re: [Intel-wired-lan] [PATCH v4 3/3] e1000e: Use
 pcie_capability_read_word() for reading LNKSTA
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVHVlLCBOb3YgMjEsIDIwMjMgYXQgMDI6MzQ6MjhQTSArMDIwMCwgSWxwbyBKw6RydmluZW4g
d3JvdGU6Cj4gVXNlIHBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoKSBmb3IgcmVhZGluZyBMTktT
VEEgYW5kIHJlbW92ZSB0aGUKPiBjdXN0b20gZGVmaW5lIHRoYXQgbWF0Y2hlcyB0byBQQ0lfRVhQ
X0xOS1NUQS4KPiAKPiBBcyBvbmx5IHNpbmdsZSB1c2VyIGZvciBjYXBfb2Zmc2V0IHJlbWFpbnMs
IHJlcGxhY2UgaXQgd2l0aCBhIGNhbGwgdG8KPiBwY2lfcGNpZV9jYXAoKS4gSW5zdGVhZCBvZiBl
MTAwMF9hZGFwdGVyLCBtYWtlIGxvY2FsIHZhcmlhYmxlIG91dCBvZgo+IHBjaV9kZXYgYmVjYXVz
ZSBib3RoIHVzZXJzIGFyZSBpbnRlcmVzdGVkIGluIGl0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEls
cG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4KPiBSZXZpZXdlZC1i
eTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPgoKUmV2aWV3
ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLXdpcmVkLWxhbiBtYWlsaW5nIGxp
c3QKSW50ZWwtd2lyZWQtbGFuQG9zdW9zbC5vcmcKaHR0cHM6Ly9saXN0cy5vc3Vvc2wub3JnL21h
aWxtYW4vbGlzdGluZm8vaW50ZWwtd2lyZWQtbGFuCg==
