Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F55C3DA64
	for <intel-wired-lan@archiver.kernel.org>; Wed, 31 Jul 2024 14:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23D51409A0;
	Wed, 31 Jul 2024 14:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOWBHf9SPH4f; Wed, 31 Jul 2024 14:43:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D62B4098F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722437036;
	bh=2tggW0cwbO7Vcv1yVP1yjiiKdZEDFZJKNK9uba3K0sE=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4zBeFSVwiPiL7w8X4qrj/2ac2TiT9XH6oqOUBv7kF5O9eUMVFd2f+hj7VQtN1EGuN
	 jWZeWDi0OEc3P6PHUNOYv7URtL707PQ5siaAumcdqmzv4RyTSVvt2ro57C6wLa3CMY
	 wbQpsIzkC6q4DgRcvTjVG4gSliP2u03NPM89pnS85sZup/gzwgz91J0evriqTPUe7J
	 bV8fyMar+eWjBEgyGfouqCksJu+K6uc0KinDsqBMf2uHjd6vTbXenTeyBxSHUQjyLl
	 FeShD/4pQM+M02MNO6D5C69Add/n83tTfJcSpjbSUFi7LIv7QXyAWlhy4ntFkQfz1H
	 SHb4YJJ0+U4JQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D62B4098F;
	Wed, 31 Jul 2024 14:43:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 309B81BF4E3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jul 2024 14:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A24C60B1B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jul 2024 14:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAUZKshbqAAa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 31 Jul 2024 14:43:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 81F5860B1A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81F5860B1A
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81F5860B1A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 31 Jul 2024 14:43:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5911562484;
 Wed, 31 Jul 2024 14:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E59C116B1;
 Wed, 31 Jul 2024 14:43:52 +0000 (UTC)
Date: Wed, 31 Jul 2024 07:43:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Message-ID: <20240731074351.13676228@kernel.org>
In-Reply-To: <PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240730012212.775814-1-yoong.siang.song@intel.com>
 <20240730075507.7cf8741f@kernel.org>
 <PH0PR11MB5830E21A96A862B194D4A4A5D8B12@PH0PR11MB5830.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1722437033;
 bh=3uUQgB9NsO6QdRwnKkBcuAS4ZDSgOduuYPCnxlW5Kvk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=leb7xbLfru8tcQpwEZwAOOdUFIGDCp1thq7gTY1UcBFWmAZWS4lKpf3jdfAlD7efh
 5cdQcAU64khHHAIqGb1Hh9D7++C+qWjbPxBaMwbyxeWg+dE9O34nIPBJ51+RmCN2Vt
 zCUU4TYVoVpRerchg3Nm8zCx+a1mQ+UZH3P9Rz28ITevglLMFg56obR1McDMqu7N2v
 fTQvhxOWm/34xmqfN2MVe/EdYr08QSFjkaxGPFQUUJNeZGdgMNBTPAjs62fytClG+S
 1VEAomVL/gf/nNsiX2t0KuW6YmV5vfuYnlxMDmeXunBhwMPsDpIueHhDozX4kFGoGG
 ldPbmLW5yoeAQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=leb7xbLf
Subject: Re: [Intel-wired-lan] [PATCH iwl-next,
 v1 0/3] Add Default Rx Queue Setting for igc driver
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
Cc: "Neftin, Sasha" <sasha.neftin@intel.com>,
 Brett Creeley <brett.creeley@amd.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Blanco Alcaine,
 Hector" <hector.blanco.alcaine@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Shinas Rasheed <srasheed@marvell.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Paolo Abeni <pabeni@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Hay,
 Joshua A" <joshua.a.hay@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 31 Jul 2024 07:40:11 +0000 Song, Yoong Siang wrote:
> Regarding your suggestion of implementing a "wildcard rule,"
> are you suggesting the use of an ethtool command similar to the following?
> 
> ethtool -U <iface name> flow-type ether action <default queue>
> 
> I have a concern that users might be not aware that this nfc rule is having lowest priority,
> as the default queue would only take effect when no other filtering rules match.

I believe that ethtool n-tuple rules are expected to be executed in
order. User can use the 'loc' argument to place the rule at the end 
of the table.

> Do you see this as a potential issue? If not, I am willing to proceed with
> exploring the ethtool options you've mentioned.
