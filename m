Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B349C05027
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Jan 2023 17:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F007E40AD1;
	Mon, 23 Jan 2023 17:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F007E40AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674493376;
	bh=WO5u+1vLfTXH2ycMBMvCzyDcwLnT/EqWxE6XBpr3opE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=G0QvtlumveZlcuHcJvOATAG2uGHzlfdWq9RSKdfXUwSB236YNK6pZaut5cSf6l0fy
	 u5ThtOP8Mei4SLmg7dpPnYA7CMLqpeFnMsbleX5blNMkuxbJX+C1PbuAVygv8Um7R3
	 q3xgqRJ7m8EFf1I+Aonlr27n51w0+gjf5ECKMAr7a6Z55yZ9trRvcSMZ4TrvbB4RXA
	 7BGKwi33dMLNweIGsU9bE019SqqmWnihpMZ+PZQxrmb+M6tVkfRZ7LekwmnJ8ZAgS/
	 70nkH7kOv6GUmSBdwQU8cIXwEno/i+grcqq+rr2LLtpGbRbDnqn0FfnT7E7nRZJ4/A
	 aaCwrces+x0Eg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RVgDHSK0lHbH; Mon, 23 Jan 2023 17:02:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 10C0640AD9;
	Mon, 23 Jan 2023 17:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10C0640AD9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 226F21BF859
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 17:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F04F7417B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 17:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F04F7417B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hh8T7Qr3miTg for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Jan 2023 17:02:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 063F4417A8
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 063F4417A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 17:02:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C1F3D60F1F;
 Mon, 23 Jan 2023 17:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6F9C433EF;
 Mon, 23 Jan 2023 17:02:49 +0000 (UTC)
Date: Mon, 23 Jan 2023 18:34:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y863Eg9XKcxzZET+@unreal>
References: <cover.1674481435.git.leon@kernel.org>
 <99049389f2f4fb967aac8026bd05f36ea13c47aa.1674481435.git.leon@kernel.org>
 <Y86jIClrwWJsPk9v@corigine.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y86jIClrwWJsPk9v@corigine.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674493370;
 bh=N50BI0eAmKLyjzAgI2VcGiyz4oyDgkoQN9/RlfmJQ9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g8lMhEHWsshNL4zKOk9nAg2yTrPyeUIAoqur5h7IY9O+Xu/yeqLKrDaRpDPfHEKlA
 O9b0S8d0aMfBF4hs+p8h8OTTD6RhVX29cZ8lmhjhMBk44lnEkYC7C2QQS/TCYMJsCh
 2Q17QM/4AykEFk7NAvhkQUJVk4HeWAimyaCTWCJSpFbLJ8e1g+fC6ZC8KtmHIn7I+m
 Zj2EBxvuIEu4ChmAbD1NKEnXo8Fs3uGhB6TNpVHQV1mWuULrdW+9pNcoIak83EL03h
 3xDS4mNwVU8sUHzSKEvMv3+IbtxsCW8i8Zd7dyGqhU0F9QtfFQajKwNMEOUxdqRBnZ
 334Ir4u3bWiCw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=g8lMhEHW
Subject: Re: [Intel-wired-lan] [PATCH net-next 06/10] nfp: fill IPsec state
 validation failure reason
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
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Veaceslav Falico <vfalico@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, oss-drivers@corigine.com,
 linux-doc@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Ayush Sawal <ayush.sawal@chelsio.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Andy Gospodarek <andy@greyhouse.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 23, 2023 at 04:09:20PM +0100, Simon Horman wrote:
> On Mon, Jan 23, 2023 at 04:00:19PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Rely on extack to return failure reason.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> 
> One minor suggestion below, but regardless this looks good to me.
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> > ---
> >  .../net/ethernet/netronome/nfp/crypto/ipsec.c | 38 +++++++++----------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
> > index 41b98f2b7402..7af41cbc8c0b 100644
> > --- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
> > +++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
> 
> ...
> 
> >  	if (x->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
> > -		nn_err(nn, "Unsupported xfrm offload tyoe\n");
> > +		NL_SET_ERR_MSG_MOD(extack, "Unsupported xfrm offload tyoe");
> 
> While we are here, maybe s/tyoe/type/ ?

Sure, will fix.

Thanks

> 
> ...
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
