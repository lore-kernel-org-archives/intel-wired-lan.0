Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D8606A320
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jmZZKK7Q;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQlFHyVn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DA89404EB;
	Thu, 19 Nov 2026 11:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PbfKlZnVoacO; Thu, 19 Nov 2026 11:24:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE79040A62
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795087458;
	b=XrPJXpgVJ9obDPhihC6m2qKb6aLrnZo3uPOiWBL7KB6eVDJ2VfiVGZblUYTvQ4JYlcRr
	 4zBk+dvsfbRPGmnYru7rh9Tfg1FUI/vGDmp6UsNayXYaEcDeFPBUgw3DDkm/2g47YQmfU
	 Uh/OFXtq7RkQntAM2DfWKlMCV+3j9uRo+p2PPK8uJJcxo2QvfCcj+sjh8X9r1BZ/YCV/6
	 fksWyIUqbe9fOF/j1vsKQ5GV8uNtPrKqKjpsdfzGfYq4N9x53E7XiUc5YBgJakbZZ98nh
	 LpGrGTKGC0y1LH8qmPXjqAOVuBHXO9sJHIfs+uhbVak8u5TQx1zL5g/vEwr3GNpiB1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795087458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PAbCKhxpRkBffJWgsRtKYvAYQkiZqg3MoFHOfafjj7I=;
	b=dz0MiTFqLHOHdJn9DEoYIUY+XkQHI+zpZXW+eNL3IDWP+7ABYmoQQlLoiln22OxoNRWu
	 1RfbWoJQk+OvZgOVyaSU9rsZVYEluYmIAykcqm1lLvRS+49CMfz+g8JwyQhY6G0GtFQGi
	 V0H2H8dEXZFRNEJlHo3iNB1aH891yEJVS1jqmUP8WyRVJcJNx06z3IoAjKkTOdD7vVyaV
	 OC1eSQNaPqRPONMT0SsqW9UrA0rjuhpywChemcImp9Bfre2tGoaaJry5STXJ04ziNvWYn
	 Z5H4QrlqoitPh+Yfzk6w3u0/iZ4O1eg36uASzZcQqzYDmn1FhMu38unrkdEBIj2pt5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQlFHyVn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795087458;
	bh=PAbCKhxpRkBffJWgsRtKYvAYQkiZqg3MoFHOfafjj7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jmZZKK7Q3L8j0TXRJni8y24MVGSRqvljMbO80C+NC39/+hMUOYzyqlYJIjTkOK1z6
	 Vqgb07KNaALZOblZVsuV1NXQXv+eTu6kzJh2JIU4axs5EIdDJpk+3YDwhftmnUVpLS
	 7qza3w2fiGjzzwjvKRREXEHVknF/uh0++JI2rcrv2N+LCeILCkhswkcWmV1Jas6Vt9
	 OuFyv4thrQTw93sQYNMUn1xDRT8gXCWNKwkc4+5tyfLO1PZBj/O1vTshspfeyrRez6
	 YOqBRfUc3F9ib5kJaJtJMcQ/+Exu/KzWwsl2bQOBRhs6ST6l3TBosTU4dq+XuQlLp3
	 5PiL1NoLVp61Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE79040A62;
	Thu, 19 Nov 2026 11:24:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D686470B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCB2F40A63
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rt9hqEq4iEUS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 11:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F00CE40A59
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PQlFHyVn
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F00CE40A59
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 11:24:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BA1A44813;
 Thu, 19 Nov 2026 11:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE071F000C5;
 Thu, 19 Nov 2026 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795087455;
 bh=PAbCKhxpRkBffJWgsRtKYvAYQkiZqg3MoFHOfafjj7I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PQlFHyVnL719LmbhVpx+mjI6xRk6OVIKiMmHw+GvFflDKHLBFnA6zci52jYLuOSzo
 NR3pt0KAtun2FasVaOmNk9Goes6SYI/S3z11jEp131dN9pfVEj5G6+70AFwJR7/rC0
 xL+MxScusFNHVhNp84bPq1FIcloF1DPuHrolJw79YJMHRPNGNaWC7gV8bzMu0qF8q4
 4riiillfyhA9JZ9Pibu2KHH8MKff+15mr+Hon6kkW0dtC0Fi2F5pFh6Rrep+KlMk+R
 FInoyKoua3H2uw37uIiL4n5VHQztII/f66agXZ4ex/FSw1XwrzW5MoF874KGpt85P/
 +RrDtrl55zTDQ==
Date: Thu, 19 Nov 2026 11:24:09 +0000
From: Simon Horman <horms@kernel.org>
To: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v4] ice: fix Tx hang dump using stale tx_buf[0].skb
Message-ID: <20261119112409.GU860048@horms.kernel.org>
References: <20261112-ice-tx-hang-dump-v4-1-9125f687669b@hydroquebec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-ice-tx-hang-dump-v4-1-9125f687669b@hydroquebec.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 01:45:56PM -0500, Vincent Choiniere wrote:

...

> @@ -424,6 +429,78 @@ void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
>  	buf->vsi_num = vsi_num;
>  	buf->head = head;
>  	buf->intr = intr;
> +	buf->queue = tx_ring->q_index;
> +	buf->next_to_clean = tx_ring->next_to_clean;
> +	buf->next_to_use = tx_ring->next_to_use;
> +}
> +
> +/**
> + * ice_tx_hang_snapshot - copy the timed-out queue's ring at report time
> + * @pf: PF on which the Tx hang was detected
> + * @tx_ring: ring saved by ice_tx_timeout(), possibly stale
> + * @ev: event to fill in
> + *
> + * The saved ring may have been freed or replaced since the timeout (e.g. by
> + * ethtool -G or -L), and a freed ring may be reused for another queue. Use it
> + * only if the timeout was on the PF VSI, that VSI is up and the timed-out
> + * queue still maps to it. Those paths, and the reset paths, replace or free
> + * the rings under RTNL or from the service task itself, so with RTNL held the
> + * accesses below are to live memory for them. The ring may still have been
> + * reset in place since the timeout (e.g. by ethtool -G or an MTU change); as
> + * before, its state is read when the report is generated. Driver removal and
> + * devlink reload tear the VSIs down before the service task is stopped and are
> + * not covered here. ice_clean_tx_irq() may still run and free the skb at
> + * next_to_clean at any time, so only the pointer value is recorded and the skb
> + * itself is never dereferenced.
> + */
> +static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
> +				 struct ice_tx_hang_event *ev)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_q_vector *q_vector;
> +	struct ice_tx_buf *tx_buf;
> +	u16 ntc, ntu;
> +	void *desc;
> +	u32 size;
> +
> +	ASSERT_RTNL();
> +
> +	if (!tx_ring || !vsi || !vsi->tx_rings ||
> +	    test_bit(ICE_VSI_DOWN, vsi->state))
> +		return;
> +
> +	if (ev->vsi_num != vsi->vsi_num || ev->queue >= vsi->num_txq ||
> +	    vsi->tx_rings[ev->queue] != tx_ring)
> +		return;
> +
> +	q_vector = tx_ring->q_vector;
> +	if (!q_vector || !tx_ring->desc || !tx_ring->tx_buf || !tx_ring->count)
> +		return;
> +
> +	size = tx_ring->count * sizeof(struct ice_tx_desc);
> +	desc = kvmalloc(size, GFP_KERNEL);
> +	if (!desc)
> +		return;
> +
> +	ntc = READ_ONCE(tx_ring->next_to_clean);
> +	ntu = READ_ONCE(tx_ring->next_to_use);
> +
> +	if (ntc < tx_ring->count) {

Sorry to nit-pick, but I wonder if it would be nicer to move the kvmalloc()
call and associated error checking be moved here...

> +		tx_buf = &tx_ring->tx_buf[ntc];
> +		if (tx_buf->type == ICE_TX_BUF_SKB)
> +			ev->skb_ptr = READ_ONCE(tx_buf->skb);
> +
> +		memcpy(desc, tx_ring->desc, size);
> +		ev->next_to_clean = ntc;
> +		ev->next_to_use = ntu;
> +		strscpy(ev->irq_name, q_vector->name);
> +		ev->desc_ptr = tx_ring->desc;
> +		ev->dma = tx_ring->dma;
> +		ev->desc_size = size;
> +		ev->desc = desc;
> +	} else {
> +		kvfree(desc);

... and remove the else arm of the condition.

> +	}
>  }

And further, the sense of the condition could be reversed, saving some
indentation:

	if (ntc >= tx_ring->count)
		return

	desc = kvmalloc(size, GFP_KERNEL);
	if (!desc)
		return;

	tx_buf = &tx_ring->tx_buf[ntc];
	if (tx_buf->type == ICE_TX_BUF_SKB)
		ev->skb_ptr = READ_ONCE(tx_buf->skb);

	memcpy(desc, tx_ring->desc, size);
	ev->next_to_clean = ntc;
	ev->next_to_use = ntu;
	strscpy(ev->irq_name, q_vector->name);
	ev->desc_ptr = tx_ring->desc;
	ev->dma = tx_ring->dma;
	ev->desc_size = size;
	ev->desc = desc;

Regardless, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

