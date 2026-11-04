Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56E606A329
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dra/a9ux;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRIysnoT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13F264043F;
	Wed,  4 Nov 2026 14:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3EQHwMnpmh7u; Wed,  4 Nov 2026 14:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DAFE5405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793803232;
	b=ZUvJOP8io3Nz8/LRNIpBVKBAi19rsBVGsCgpiSaZHnMIwQErBPFJ1Rizg4A9K6349n1J
	 V47WwLiQW05LgK0a/KZ3Gp7nQbR8nZNjhLn8K/wU4gKkVDCSm4EHgMcmV6FCbvX7SMaht
	 vdLBlrqQcfMW8Z+vF3knZ3HJDHjNqASQG5UtkjfRdo2O7PkXJYzw+r1sIaLC+53EEFQU2
	 L36i3EX5JJuMXWOf9larcoIg2rHBt00eYK0R2ZNldqlrvfpXKU+qznS9shQvuQ4H33LlG
	 OCi+3iKrm9CSMX8aSBb9pgSmihtjOTchlLtQ9dgy3TQNSMq2U3LrjNXw0XnwVqEBBqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793803232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=TjzRlJZ6kXiL/tl/S1kjtOseXIPl9De33t/R+rf6wnk=;
	b=sc0us7qmTJdHSoXBBzDH7RIxvcsewIot9HklyOIK2dgNd0kgdrO7QpuMQsImBnPciHNR
	 h0YDjY9UBp394Q3+Uv1aO+T3APzBeDXr9QbnuESQrKfi+6wzsE/1c1D/tk/4UvX28zQYL
	 LMjox1A8EdzQujyO41qEivqr4WMT9/C3bIGcWCEtaWsSW/fOUOuNu/mP5n2dvPwDlVEEo
	 qYt7ajh9fP3cl0XGlQTzjXvgfDnpg78MiM45ZxRtkiGVWDhTgzImFG1xqj0zKn7ezXDap
	 ccQ2H6F0zix+Ngf831AEgwMuHl+x1mg78DFBTDx3Isyvae91pKRhqMT7ZajKf0V9yrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793803232;
	bh=TjzRlJZ6kXiL/tl/S1kjtOseXIPl9De33t/R+rf6wnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dra/a9uxh1QScWVd9NIpTV/BbAGLU/+k3F0ReV91tEUhCcep8y6NZZ0tbWQXo3WZJ
	 K30A06nhMt79iKsq+pL6VwB0nR/6657oR+UF/WDmnhY5fKSvIjXe7de436CL55QJZB
	 qzvFVAWhPehoB2SYJ1K5Ead623ytpePtdL6yx52XZ+jG2V+dbKsNFRPA8RQrycbEN/
	 0/o1o5pRyya49B9rkoVKaqd3YrHMyzBGDe3fFzNE8IKHIlQe61DiS42/l+dO+BGhOj
	 fWDzhvyABoPVMHU/uOziEMOE6FcYk4/Ic/uWncd3/lg0INRz+P5frsXRYWJDFcg5OU
	 E3Bw7ozuML9hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAFE5405CF;
	Wed,  4 Nov 2026 14:40:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3539D341
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32B1E40068
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yLnRIoelQ6Fr for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 14:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DEF7440062
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793803229;
 b=IKRqcag3VgsVHgu9RxJ8rfuEUZUaheo5I3YpsQnxVLTnBrVpzXDLXMknKl0DxUpUJOIQ
 BQgU6rsN3v9yTZClRX2jw22yzIm/242dtjZVy8G4L+Pm6JIczPNlv6zKNF9KTCZsWncp/
 7Nz36ZI+VM0CKjFEMpVHMs8LMp3BRQnxuGemm7Af8vxpjNCwyRp7CWOOCPNJ6G2ra9nms
 hgOXEq6SJZjn05cfM1QKC+DNX6lKVwhGOt+d5tBtTaAZxE9WwlQcHvaAEbvZDmj3ra7X6
 5DO7CUDYx+siZXlXqrB45O1i05erImaaQE0RLc100xP2RR68jdDmMjaBYj2mvTKYWHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793803229;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=TjzRlJZ6kXiL/tl/S1kjtOseXIPl9De33t/R+rf6wnk=;
 b=LfB1qLLbJypLVGoBZ+5hhQ88++baZeA7G182vCRxMA+PAJxpCe7GU+i422dU4NinlUwY
 8rLMhK0IdFQ54W35oC8w/KYdABL8wYDILQI4sK89a0XwKdQAD76wc9zkmyO2G9QTfHd2T
 EqxaSovvmJ0rEknC7pD2RtVir67H0yxJnND2H5gnKzkKt8zLgt7re4C6OPFvX7TmaB1ql
 5GI+1+EdnYuDZUxz7JKfJqvHVY9xjydlffozHUgWqBvEXYo2is18+BD7n9Uav0Qn76FnB
 urRSd1f1zGelawHf1Wm5UXU3qdGBfuOh9T22mwb+jprEdID5nz0b4ieRkKqtyIL41CQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jRIysnoT; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jRIysnoT
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEF7440062
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 14:40:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7637E43931;
 Wed,  4 Nov 2026 14:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B96E1F000C1;
 Wed,  4 Nov 2026 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793803227;
 bh=TjzRlJZ6kXiL/tl/S1kjtOseXIPl9De33t/R+rf6wnk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jRIysnoThZ2kK4QFdb7ABASZd2Yq25Yw7wPgytd3NfgR5X8K1WgxBSRVHxpCfxkIZ
 ic2F+Cf1BjgPUFbBeHEN93Vu0FbzXiP84PYMqQBFGNpCHX2fdwaefUwa0Z04O+zo7g
 25WTPeB2REbr5Hqi9udSxf+IRv5OiVSeXVbeRCz9huw8UrejXYLeiZKptO6AhqWE2s
 ujqVAQBL69CQPOw5ivOtb2bB/91qX8Llx+fjlnM6aNYilCUL6hJz/TA0ukFeRgVh9X
 Ortl2/Z9xlZNblb9/ZjJDITjJ35e9TW3egNu5nBeSC4OQHelmxLMHEFY7Fb6MKVKGK
 rJ/m9rodlhDBA==
Message-ID: <sashiko-outbox-197456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v4 10/15] iavf: use new opcodes to request more
 than 16 queues
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103141646.303620-11-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
 <20261103141646.303620-11-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:40:26 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] iavf: divide-by-zero in iavf_fill_rss_lut() on reinit after iavf_d=
isable_vf()
- [Medium] iavf: unreachable request cancellation and validation bypass in =
iavf_set_channels()
- [Medium] iavf: dangling adapter->vsi_res pointer on iavf_parse_vf_resourc=
e_msg() error
- [Medium] iavf: unchecked iavf_parse_vf_resource_msg() error in completion=
 path
--

commit d1393a22db56329f01b19f599c0f60b4b3fbbf22
Author: Ahmed Zaki <ahmed.zaki@intel.com>

iavf: use new opcodes to request more than 16 queues

This commit adds support for negotiating VIRTCHNL_VF_LARGE_NUM_QPAIRS and
using the V2 queue enable/disable, queue-to-vector mapping, and RSS queue
region virtchnl opcodes to support more than 16 queues. It also updates
ethtool channel configuration to request queues asynchronously in large que=
ue
mode and adjusts VF resource parsing to handle queue count reductions and R=
SS
key/LUT size changes across resets.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net=
/ethernet/intel/iavf/iavf_ethtool.c
> index e7cf12eaa2689..3938c78597cb6 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
[ ... ]
> @@ -1730,15 +1742,29 @@ static int iavf_set_channels(struct net_device *n=
etdev,
>  	/* All of these should have already been checked by ethtool before this
>  	 * even gets to us, but just to be sure.
>  	 */
> -	if (num_req =3D=3D 0 || num_req > adapter->vsi_res->num_queue_pairs)
> +	if (num_req =3D=3D 0 || num_req > iavf_max_channels(adapter))
>  		return -EINVAL;
> =20
> -	if (num_req =3D=3D adapter->num_active_queues)
> +	/* PF has not answered our previous request yet */
> +	if (adapter->current_op =3D=3D VIRTCHNL_OP_REQUEST_QUEUES)
> +		return -EBUSY;
> +
> +	if (num_req =3D=3D adapter->num_active_queues) {
> +		/* drop a request that is not sent yet */
> +		adapter->aq_required &=3D ~IAVF_FLAG_AQ_REQUEST_QUEUES;
>  		return 0;
> +	}
> =20
>  	if (ch->rx_count || ch->tx_count || ch->other_count !=3D NONQ_VECS)
>  		return -EINVAL;

[Severity: Medium]
Can this cancellation path in iavf_set_channels() be reached when a user tr=
ies
to revert a pending channel change back to adapter->num_active_queues?

In LARGE_NUM_QPAIRS_SUPPORT mode, queuing a channel request sets
adapter->num_req_queues_next and IAVF_FLAG_AQ_REQUEST_QUEUES while leaving
adapter->num_active_queues unchanged. Because iavf_get_channels() still
reports:

    ch->combined_count =3D adapter->num_active_queues;

both ethnl_set_channels() and ethtool_set_channels() compare the requested
channels against the current values from iavf_get_channels() and return 0
without calling iavf_set_channels() when combined_count equals
adapter->num_active_queues.

Conversely, if a user requests a change to other_count (such as setting oth=
er
to 0) while leaving combined_count at adapter->num_active_queues, the ethto=
ol
core does invoke iavf_set_channels(), which hits the
num_req =3D=3D adapter->num_active_queues check before validating:

    if (ch->rx_count || ch->tx_count || ch->other_count !=3D NONQ_VECS)
        return -EINVAL;

Wouldn't that cause an invalid other_count request to drop
IAVF_FLAG_AQ_REQUEST_QUEUES and return 0 instead of -EINVAL?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index db769eead68f3..7285f665b4fb4 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
[ ... ]
> @@ -2496,6 +2523,14 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter=
 *adapter)
> =20
>  		return -EAGAIN;
>  	}
> +	/* PF could cut our queues on reset, e.g. when RSS LUT got smaller */
> +	if (adapter->num_active_queues > adapter->vsi_res->num_queue_pairs) {
> +		adapter->flags |=3D IAVF_FLAG_REINIT_MSIX_NEEDED;
> +		adapter->num_req_queues =3D adapter->vsi_res->num_queue_pairs;
> +		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
> +
> +		return -EAGAIN;
> +	}

[Severity: Medium]
When iavf_parse_vf_resource_msg() schedules a reset and returns an error he=
re
(or -ENOMEM on RSS reallocation failure below), iavf_virtchnl_completion()
ignores the return value during VIRTCHNL_OP_GET_VF_RESOURCES handling:

drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:iavf_virtchnl_completion() {
    ...
    case VIRTCHNL_OP_GET_VF_RESOURCES: {
        ...
        iavf_parse_vf_resource_msg(adapter);

        if (VLAN_V2_ALLOWED(adapter))
            break;
    }
    fallthrough;
    case VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS: {
        ...
        iavf_process_config(adapter);
        adapter->flags |=3D IAVF_FLAG_SETUP_NETDEV_FEATURES;
        iavf_schedule_finish_config(adapter);
        iavf_set_queue_vlan_tag_loc(adapter);
        ...
}

If the PF reduced vsi_res->num_queue_pairs across a reset (for instance, wh=
en
switching a VF from a larger LUT back to a 16-queue VSI LUT and clearing
VIRTCHNL_VF_LARGE_NUM_QPAIRS), adapter->num_active_queues still holds the o=
ld
count (up to 256) until reset_task runs.

If VLAN_V2_ALLOWED(adapter) is false, execution falls through and runs
iavf_process_config() and iavf_schedule_finish_config() before adapter->vsi=
 or
RSS fields have been updated. In addition, if iavf_close() runs before the
scheduled reset_task executes, it sets IAVF_FLAG_AQ_DISABLE_QUEUES and runs
iavf_disable_queues() with LARGE_NUM_QPAIRS_SUPPORT(adapter) now false while
adapter->num_active_queues is still greater than 16:

    vqs.tx_queues =3D BIT(adapter->num_active_queues) - 1;

Should iavf_virtchnl_completion() check the return value of
iavf_parse_vf_resource_msg() and abort further post-resource configuration
when a reset has been scheduled?

>  	adapter->num_req_queues =3D 0;
>  	adapter->vsi.id =3D adapter->vsi_res->vsi_id;
> =20
> @@ -2504,13 +2539,54 @@ int iavf_parse_vf_resource_msg(struct iavf_adapte=
r *adapter)
>  	vsi->netdev =3D adapter->netdev;
>  	vsi->qs_handle =3D adapter->vsi_res->qset_handle;
>  	if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
> -		adapter->rss_key_size =3D adapter->vf_res->rss_key_size;
> -		adapter->rss_lut_size =3D adapter->vf_res->rss_lut_size;
> +		if ((adapter->rss_key &&
> +		     adapter->rss_key_size !=3D adapter->vf_res->rss_key_size) ||
> +		    (adapter->rss_lut &&
> +		     adapter->rss_lut_size !=3D adapter->vf_res->rss_lut_size)) {
> +			reconfig_rss =3D true;
> +		} else {
> +			adapter->rss_key_size =3D adapter->vf_res->rss_key_size;
> +			adapter->rss_lut_size =3D adapter->vf_res->rss_lut_size;
> +		}
>  	} else {
>  		adapter->rss_key_size =3D IAVF_HKEY_ARRAY_SIZE;
>  		adapter->rss_lut_size =3D IAVF_HLUT_ARRAY_SIZE;
>  	}
> =20
> +	if (reconfig_rss) {
> +		u8 *rss_key, *rss_lut;
> +
> +		rss_key =3D kzalloc(adapter->vf_res->rss_key_size, GFP_KERNEL);
> +		rss_lut =3D kzalloc(adapter->vf_res->rss_lut_size, GFP_KERNEL);
> +		if (!rss_lut || !rss_key) {
> +			kfree(rss_key);
> +			kfree(rss_lut);
> +			/* old buffers and sizes are kept, retry via reset */
> +			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
> +			return -ENOMEM;
> +		}
> +
> +		kfree(adapter->rss_key);
> +		kfree(adapter->rss_lut);
> +		adapter->rss_key =3D rss_key;
> +		adapter->rss_lut =3D rss_lut;
> +		adapter->rss_key_size =3D adapter->vf_res->rss_key_size;
> +		adapter->rss_lut_size =3D adapter->vf_res->rss_lut_size;
> +		iavf_init_rss(adapter);
> +	}

[Severity: High]
Could calling iavf_init_rss() here divide by zero in iavf_fill_rss_lut() wh=
en
recovering after iavf_disable_vf()?

After initial probe allocates adapter->rss_key and adapter->rss_lut in
iavf_init_config_adapter(), if a reset fails or times out and invokes
iavf_disable_vf(), the call chain:

    iavf_disable_vf()
      -> iavf_free_interrupt_scheme()
        -> iavf_free_queues()

sets adapter->num_active_queues =3D 0 without freeing adapter->rss_key or
adapter->rss_lut.

If hardware later recovers in iavf_watchdog_step() from __IAVF_COMM_FAILED
back to __IAVF_STARTUP, iavf_init_get_resources() calls
iavf_parse_vf_resource_msg() while adapter->state is __IAVF_INIT_GET_RESOUR=
CES
and before __IAVF_INIT_CONFIG_ADAPTER has allocated queues, so
adapter->num_active_queues is still 0. If the PF's rss_key_size or
rss_lut_size changed across the reset, reconfig_rss is true and
iavf_init_rss() calls iavf_fill_rss_lut():

    int max =3D adapter->num_active_queues;

    if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && qregion->qregion_width)
        max =3D min(max, (int)BIT(qregion->qregion_width));

    for (int i =3D 0; i < adapter->rss_lut_size; i++)
        adapter->rss_lut[i] =3D i % max;

Since max is 0, wouldn't i % max trigger a divide-by-zero oops (and
iavf_init_config_adapter() later overwrite adapter->rss_key and
adapter->rss_lut without freeing them)?

> +
> +	if (init_req) {
> +		qnum =3D min_t(int, num_online_cpus(), IAVF_MAX_REQ_QUEUES);
> +		/* granted, or we have enough */
> +		if (num_req_queues || qnum <=3D adapter->vsi_res->num_queue_pairs)
> +			return 0;
> +
> +		adapter->current_op =3D VIRTCHNL_OP_UNKNOWN;
> +		adapter->extended_caps |=3D IAVF_EXTENDED_CAP_RECV_REQ_QUEUES;
> +
> +		return iavf_request_queues(adapter, qnum);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -2557,17 +2633,18 @@ static void iavf_init_get_resources(struct iavf_a=
dapter *adapter)
>  		goto err_alloc;
>  	}
> =20
> +	/* Some features require additional messages to negotiate extended
> +	 * capabilities. These are processed in sequence by the
> +	 * __IAVF_INIT_EXTENDED_CAPS driver state.
> +	 */
> +	adapter->extended_caps =3D IAVF_EXTENDED_CAPS;
> +
>  	err =3D iavf_parse_vf_resource_msg(adapter);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to parse VF resource message from PF (%d)\=
n",
>  			err);
>  		goto err_alloc;
>  	}
> -	/* Some features require additional messages to negotiate extended
> -	 * capabilities. These are processed in sequence by the
> -	 * __IAVF_INIT_EXTENDED_CAPS driver state.
> -	 */
> -	adapter->extended_caps =3D IAVF_EXTENDED_CAPS;
> =20
>  	iavf_change_state(adapter, __IAVF_INIT_EXTENDED_CAPS);
>  	return;

[Severity: Medium]
Does the err_alloc path in iavf_init_get_resources() leave adapter->vsi_res=
 as
a dangling pointer when iavf_parse_vf_resource_msg() fails?

In iavf_parse_vf_resource_msg(), adapter->vsi_res is assigned to
&adapter->vf_res->vsi_res[i] without clearing adapter->vsi_res beforehand.
With this patch, iavf_parse_vf_resource_msg() can now return an error after
adapter->vsi_res is set (for example, if iavf_request_queues() fails in the
init_req path, or if num_req_queues > adapter->vsi_res->num_queue_pairs
returns -EAGAIN).

When iavf_init_get_resources() jumps to err_alloc:

err_alloc:
    kfree(adapter->vf_res);
    adapter->vf_res =3D NULL;

adapter->vsi_res is not reset to NULL. If a subsequent retry in
__IAVF_INIT_GET_RESOURCES receives a resource message with no
VIRTCHNL_VSI_SRIOV VSI, wouldn't adapter->vsi_res remain non-NULL and point=
 to
the freed adapter->vf_res buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103141646.3036=
20-1-przemyslaw.kitszel@intel.com?part=3D10
