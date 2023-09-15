Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304A9EE645C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 Sep 2023 13:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0AAE6136B;
	Fri, 15 Sep 2023 13:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0AAE6136B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694786331;
	bh=wbxY9u52uUJFuQy3la86q4uV+PkJXFq9H5Evs+hzWgQ=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8Dvat5gWPXC2y27G3+8U5LhZo3suu+bf9wUerDE9KZbbmSkHS7whW5ARKzigTNzAa
	 1RhVXpOVCCJgsLI6sQjLE3B8xAEmiu2zZCz8etvQaHJO2D90tpQTTyISbgW469Mw5G
	 Zc8tMJd7elwqD8r8XdhqSGF4gHHVYjUllVPkgyLmKztEnG4N75TuOc2MMo8lBPpgJW
	 2qNncyW6XoWcEWVTK/gBiz2QdmeY5iW98mNmxy/z4kBinoZmnSVX7qCTXmVCJGzDCV
	 Y/qlnwLEGLTtxn+dfxAmyI762iwNB7g6Srny8Q8yROg4j14uh24ACvZhVBsNwHOJEs
	 AwP5MT66x40OA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXr4yelCCjx3; Fri, 15 Sep 2023 13:58:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052266135B;
	Fri, 15 Sep 2023 13:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 052266135B
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BE6AF1BF3DD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 13:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A434E402F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 13:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A434E402F4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPgGls-yv9un for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 Sep 2023 13:58:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0522D40164
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 Sep 2023 13:58:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0522D40164
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qh9LK-006Y3M-A3; Fri, 15 Sep 2023 15:58:46 +0200
Date: Fri, 15 Sep 2023 15:58:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <145ec8c7-ae64-42a2-ab7f-b77b1b0d23bf@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
 <51ee86d8-5baa-4419-9419-bcf737229868@lunn.ch>
 <ZPCQ5DNU8k8mfAct@baltimore>
 <87ea2635-c0b3-4de4-bc65-cbc33a0d5814@lunn.ch>
 <ZQMYUM3F/9v9cTQM@baltimore>
 <3713a4ff-c977-c62e-aa56-9293cf2cfd1f@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3713a4ff-c977-c62e-aa56-9293cf2cfd1f@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=QvVRYtWOCyMDuzncQnkYEAfoirjzGGs2skJ72Y0JYro=; b=uQxf4rz0Q6q4sgnHDKl2jtTbnK
 hsYKYXGtz72u7tWy0W2KhSxEy+2Ihuek0I8ATLf1MwVULLqxcZ51PEv98sh5AbQdxHUpB2D0IA+Xs
 1wt4el7lJEfsrYkA2Vz0xWwU/l2PCOidRyyGqaGKhW5icXC67W5PLJBd/lp8cRSG4a4I=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=uQxf4rz0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
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
Cc: aelior@marvell.com, manishc@marvell.com, netdev@vger.kernel.org,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, "Greenwalt, Paul" <paul.greenwalt@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> Here I'd like to add that we're planning to try to use Phylink in ice
> soon. It may take a while and will most likely require core code
> expansion, since Phylink was originally developed for embedded HW and
> DeviceTree and doesn't fully support PCI devices.

Cool.

And yes, not having device tree will require some changes, but i don't
think it will require changes to the core of phylink, just the edges
where you instantiate phylink, using a different configuration
mechanism.

	Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
