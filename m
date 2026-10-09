Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C5CA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF4B74087F;
	Fri,  9 Oct 2026 20:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C7b2rDW4s1Ad; Fri,  9 Oct 2026 20:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 328DE408A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791577628;
	b=Eqt2VJnMvwvX3qT82Ooh7BCLwDHjDKeVu0iJGYRlPl6O7lUtDgNJd/cCNBfmxPf41Cpq
	 pluxAn7Jk2yUrSloLhyA6qpRTHDPvV+6Du1BQdk2YT7yJttytqYJMAWyTl1weTW11PWOR
	 Y3z9UJuf6t6dAC8CBAa1hQtgVufWm6N/74kBfDk7t5rJN9lmkKifEPgL5Mz3KcZDM9dKW
	 yLKsUQtDcfJAfFUfkcWNkbwXf2eEJd0J2ZquysEz4IUfE9DzSIe5MNOiiEr0QSewhheFz
	 EaF4HYqphwbUi0i0JUOwmTl4zoyg6GBRHbl0Al5bBegx1p+aAdfIQdKXosSKK5JCBmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791577628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=UsBRs59ZQ1eE13208G/HsDxsCoB/iIHyTiY1tVBEGrE=;
	b=PDk2t3WHU1dDTy8CfOb1Ga4sCoG6Awnruy9Tk/Htw0VIVBtDARSAHyczBeGjredLUD+v
	 1EnMPXTXxZm0xy7CjZPMQEeBF2cXbIGT0i1p8YUMqW4VWWW5HTDSF2tFSeOOZq7ZUt/Zt
	 I/j5lKg+E/ij0vtlqh0kTAMvhvUwF+rHadsZoxw5ZsRh6YhPYSOUvMN/w18brSmUq24OC
	 1VkEkAxF1nrFu0fAnSh4YpD75iIcRtZTk2pisIuzkj14sKHxGy38TxTOu8lV396sKLIt+
	 yNmiT5D/now1Ono3n+r/7VPvtXXtHjNBpySLzcUZXk8ctBSoRPy/N/p51eIRsIQbU9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791577628;
	bh=UsBRs59ZQ1eE13208G/HsDxsCoB/iIHyTiY1tVBEGrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=k85lOnELn0nKIWfbjh0RlXoAQVIsC48ZfNxqtnBr4HX/1+6mcpnD66+r97Adl10Ef
	 lKATnn47pLOCAOYK+rJtQvJDCu8vmXTf9DHc+F6ZR0x/BcEnqF9QFZAS4X0dIUm4mo
	 unsdVrmZkmDODAbRYtNsGeS/Dd3kQ6zg7n6/3f6ZIJ3vlf8zM2+6W7LNNBa572TGK3
	 hIPe8CDnHGUHpIrjxj0JHASikyxZ0SgS9guI3/XqrG5tKdnNHiPwhGPsugBD+GXkUl
	 lKN4Spf5DAko9yNFwRpn5LgKA3P1kuL+io9vNbqymDY7wUpSPlOHDKqi5EuG/c9Hpo
	 33L9oc3+s5TfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 328DE408A2;
	Fri,  9 Oct 2026 20:27:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57FA175
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C40E607B2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id reHlXoiWXAz6 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:27:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 569AE60727
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791577625;
 b=pjv8PweRvbJ+YLr+efXl08iZKGbH6M80WNfesKbraoNlBcVWridDSXTQxU7rbQ4vJDfw
 HMHMujTpIn0xKESrKAthmaUED/fXScd+WYSJnhnLS4lXX9eSQa8VqdOzMiBS+E11HS/uj
 EeF0m/eAs2+6tu6b0rYt3irIIlhSHVaKhmZqz8lzXOqsIcWpPD78uNawvgAu8au4Ew8wY
 FDNuYvayubN6/bGvpFrs9I90VsiObyW8M2/cy+3U1DA6SE12jknUEQQOiahpv/w5syuQX
 lET+4yqLwvVLF32Jjo+h+Bsi5RvadIVrjF7PXzesQgDaf4Tr28IhmR92azLYEvFW38w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791577625;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=UsBRs59ZQ1eE13208G/HsDxsCoB/iIHyTiY1tVBEGrE=;
 b=R/knLPQSOChHWEaIFgl/uCvcz/UO5sr+BD19sxgrrVScPjCLZrImF4NUNOjGOvdRwQ7G
 lh2ZZI1rXREVyowoAPSI/64WI03dViUezrX7OkyVk8vAJAZQVz4Khyy/w3KBRdTPs05td
 L31VxSbqefxjs/G+mvoxUfDOQ0JOFbnt0q5QLb386Widjo/QVSCjR+Op2w1iEfAZviRyr
 vy/cs1TMF3e5DLC/S01cKErM/W6lzevlrn8ehXDPbMRbvLk0zkleKaylCUtS2qzXidQ9X
 kjYUTrSn9wFLrITIReWidBJqYiS4wRfq/bWHC26Yin386rXFfbW/XGsQrJdInKdTuMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gR+WZG3M; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gR+WZG3M
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 569AE60727
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 785D940AC5;
 Fri,  9 Oct 2026 20:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2404E1F00893;
 Fri,  9 Oct 2026 20:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791577624;
 bh=UsBRs59ZQ1eE13208G/HsDxsCoB/iIHyTiY1tVBEGrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gR+WZG3MRK0SmV/QptEUDXAC0WePU68+ImSUrBwSZTE0YbxCN4ENqd1rMl86nghpY
 boBI3mHb5wCDmqYZN4yZlT6Yt3hTyvwOjISJyUicXazVo9I5fiO203Dxa7A2sX/Fwp
 vfQoXSD/nUI84QOADdzvR93CR+txEJl+iWSGCPjbqY0Ge8WkX4C8ODidiQmNYLB6A7
 LG1KSNj5Mc8b/FkmqlKkjhkauP9vD0OGZpjagK1qHjV2RE78cy9m+qEPzxLtUIWVoq
 xdze9KlePZCNxRfAxQIIfP4lrqqcKxaopELqP3sGti2axanUAYvZEH/iQE6X6WsXj5
 g9Q1TbnTkXXfA==
Message-ID: <sashiko-outbox-166033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v2 2/6] ice: count number of VSIS in agg_vsi_list
To: "Jacob Keller" <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-2-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
 <20261009-jk-cleanup-vsi-aggregator-nodes-v2-2-313964c25c7b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 20:27:03 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ice: num_vsis inflated and stale entry left on VSI move failure
--

commit a9d16d503219ec18b5a73776a1a7f4b0b851cd1b
Author: Jacob Keller <jacob.e.keller@intel.com>

ice: count number of VSIS in agg_vsi_list

This patch adds a member num_vsis to the ice_sched_agg_info structure to tr=
ack
the number of VSIs associated with an aggregator node. The counter is
incremented when adding a VSI to the list and decremented when removing it,
avoiding the need to iterate over the agg_vsi_list.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/eth=
ernet/intel/ice/ice_sched.c
> index bcfc9db69e17e..08d0f685f6c45 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c

[ ... ]

> @@ -2915,24 +2920,26 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *=
pi, u32 agg_id,
>  		/* add VSI ID into the aggregator list */
>  		agg_vsi_info->vsi_handle =3D vsi_handle;
>  		list_add(&agg_vsi_info->list_entry, &agg_info->agg_vsi_list);
> +		agg_info->num_vsis++;
>  	}
>  	/* Move VSI node to new aggregator node for requested TC(s) */
>  	ice_for_each_traffic_class(tc) {
>  		if (!ice_is_tc_ena(*tc_bitmap, tc))
>  			continue;
> =20
>  		/* Move VSI to new aggregator */
>  		status =3D ice_sched_move_vsi_to_agg(pi, vsi_handle, agg_id, tc);
>  		if (status)
>  			break;

[Severity: Medium]
If ice_sched_move_vsi_to_agg() fails and returns an error here, the loop wi=
ll
break. Should the function roll back the agg_info->num_vsis increment and r=
emove
the newly added agg_vsi_info from agg_info->agg_vsi_list before returning?

Without a rollback, a stale VSI entry with an empty tc_bitmap remains in the
aggregator list, permanently inflating the num_vsis counter. If subsequent =
code
relies on num_vsis to enforce limits like ICE_MAX_VSIS_IN_AGG_NODE, this co=
uld
cause the aggregator to prematurely reject new VSIs.

> =20
>  		set_bit(tc, agg_vsi_info->tc_bitmap);
>  		if (old_agg_vsi_info)
>  			clear_bit(tc, old_agg_vsi_info->tc_bitmap);
>  	}
>  	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {
>  		list_del(&old_agg_vsi_info->list_entry);
>  		devm_kfree(ice_hw_to_dev(pi->hw), old_agg_vsi_info);
> +		old_agg_info->num_vsis--;
>  	}
>  	return status;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-jk-cleanup=
-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com?part=3D2
