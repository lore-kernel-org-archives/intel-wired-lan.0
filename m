Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1BCC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 15:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B668080B8B;
	Mon, 24 Aug 2026 15:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kaiUtUuK3x-m; Mon, 24 Aug 2026 15:51:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787586668;
	bh=qGnYzb6sb2CaYap45m87vBaR83LJiJZymed/HuvCnUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRc952APMhvMFOX2howXxpNhqko5ZCImZT/ccL8ocWvWyDLAcKILJPbYZY1dszAam
	 mNf2u83m7Vu7f6tAMPe8btzht+10DqBIK5E5H7f90bfMkJGbcBd9szprzzzoWFUlid
	 4y6HrrLFIOudPUtjVam561D+kdHP36tGPkmas8ahxjfoHYZwJQ1oSVr8bjpUteoiMO
	 p0x558TUJ2GcypmXBYXf/zFjoQTH+Ji4Nr1zwV7814SIv8Z8xR/EV3vkCh9jX9kt/U
	 fHKYiCf/EDUyCPiKb5xiO0XN4RNsX/3PWRKTEE44FZpVRLFfUJFTFDN5NeX+9oh8Fa
	 bc5HLvq/tGUgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E803580B2C;
	Mon, 24 Aug 2026 15:51:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E5B29B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 15:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA17840068
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 15:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSUZafNs4ZDV for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 15:51:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K5zJ6lOW
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 256BD40029
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 15:51:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9C3940A9A;
 Mon, 24 Aug 2026 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA81F000E9;
 Mon, 24 Aug 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787586664;
 bh=qGnYzb6sb2CaYap45m87vBaR83LJiJZymed/HuvCnUk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K5zJ6lOWqJaiA4tHxVuhif8Mm3bjKQTt1ciDXs5YMdZjTdSI6wZ31p8MeOhn3VXtq
 ZzMfNkXtKEp33p4VVjw4fseQGwOnRr6N3i21KsAm6490Y/F2IlXdVtyt0butglDCVI
 Ai2yUFTH2CP+dMQg7x97akzd1bDmJBhgrue3bQyOUNzTPNFUTbB9pQg27mRp24e7Zy
 vX83Jt42erme+CQX05t6g8wnxu2QB/255FyNnNpt/vCNoiPpzKvyk01RayqM88VFUo
 1HvUfkuDeVj2aOpf37Uvgb4NBjOuLjm90qYkAjRYr7EHraleZPlJK/Qfl7mBeu76Jd
 uR8c/L2Rpvcgg==
Date: Mon, 24 Aug 2026 16:51:01 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Message-ID: <20260824155101.GW265046@horms.kernel.org>
References: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
 <20260824110838.GP265046@horms.kernel.org>
 <IA3PR11MB89864B9D29B763A29C25B823E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89864B9D29B763A29C25B823E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
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

On Mon, Aug 24, 2026 at 01:18:10PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>

...

> Good day, Simon
> 
> The clamp math is off, for the record: pkt_buf is ICE_PARSER_MAX_PKT_LEN + ICE_PARSER_PKT_REV = 536 bytes, so sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE is 504, not 488.
> 
> That said, the actual point stands: ice_parser_rt_pktbuf_set() stores the unclamped caller pkt_len into rt->pkt_len, and both raw RSS and raw FDIR VF paths can pass up to VIRTCHNL_MAX_SIZE_RAW_PACKET (1024) > ICE_PARSER_MAX_PKT_LEN (504). After this fix HO can't exceed 504 either, so HO >= pkt_len stops being a reliable exit for those inputs. Doesn't look like a guaranteed infinite loop to me - the graph's is_last_round action still ends parsing independent of HO - but there's no reason to leave a dangling bound in a bounds-fix patch. I'll send v2 that also stores the clamped length in rt->pkt_len, same Fixes: tag.

Thanks, much appreciated.

> 
> The DDP-table-index and FDIR IRQ-context points from Sashiko are unrelated to this patch - different code, different trust boundary (signed firmware package vs. VF input). 
> I think it should not block this fix.

Yes, agreed.
