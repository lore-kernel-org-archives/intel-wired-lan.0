Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C728C5B56A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Aug 2026 16:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05C4140345;
	Tue, 11 Aug 2026 16:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGr1xMhRtsp5; Tue, 11 Aug 2026 16:02:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A2AB407E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786464139;
	bh=M57msK1gt394tHHb8/wcEXScUoSQF7jRkGcnZ1po3R4=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UlhCb52IlddbnO9dOUlc3Be+E8Jz9GXO8RLOPEjtkao4EcCALK86MUPsOhgHRau7V
	 3VgzPibGcod2A5+jLRvJPfOMFjz39vkEtCUFRnGIGzb0iM8OkUit44dxHUIz6wU91J
	 3SB9eFEYK1AiULhhenFccHT9/2M8uivbieR5LVrNaQWYqct/eHenaxrcVCsOQOpyDh
	 SwFZDgOTLLqYmnHiXaTzSJS8+T97bSpPUBN+kRlJQ/pB2sG3lhEq3FgYVnYiOiZCK0
	 S5iZ2S6D3/KbK+ilgVdCKVuEIdCJ4O/Y/MDOhqDIbQRlMCHU1RHa6b8WyFzaXFV3oV
	 cQsH4vAEhBpHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A2AB407E6;
	Tue, 11 Aug 2026 16:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CED3F345
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 16:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C08BC407E6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 16:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4uBbR5MwLfG for <intel-wired-lan@lists.osuosl.org>;
 Tue, 11 Aug 2026 16:02:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jramaseu@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A61BA40345
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A61BA40345
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id A61BA40345
 for <intel-wired-lan@lists.osuosl.org>; Tue, 11 Aug 2026 16:02:16 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-4SHOdkvxNMqOKSwFbm3M6A-1; Tue,
 11 Aug 2026 12:01:50 -0400
X-MC-Unique: 4SHOdkvxNMqOKSwFbm3M6A-1
X-Mimecast-MFC-AGG-ID: 4SHOdkvxNMqOKSwFbm3M6A_1786464109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 772DA195604C; Tue, 11 Aug 2026 16:01:49 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4E2A19560AB; Tue, 11 Aug 2026 16:01:47 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: przemyslaw.korba@intel.com
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jramaseu@redhat.com
Date: Tue, 11 Aug 2026 18:01:39 +0200
Message-ID: <20260811160140.2161988-1-jramaseu@redhat.com>
In-Reply-To: <20260319111659.551039-1-przemyslaw.korba@intel.com>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: zbdYvKjtVCSbihuuAsBaUDICC9740k1rW71-GjOqvtw_1786464109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1786464134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M57msK1gt394tHHb8/wcEXScUoSQF7jRkGcnZ1po3R4=;
 b=ckkUJ1gz9b6r0EMrtZqfjzRblUmh4sYN/H81m929J6SJkISQ5zWk1jwifVFTg0Ati9mFsc
 1JlU4Flo3cbI6+33hryEhdT44x7evUJ3D5wvR9MRp2yXC1iRMhZoVDiidlFHgaqGzTkDQk
 2Q77jh+qw0/G7sFcQpiKV/F8DFBQRec=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ckkUJ1gz
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Mar 19, 2026 at 12:15 PM Przemyslaw Korba <przemyslaw.korba@intel.com> wrote:
>
> On E830, PTP time adjustment commands sent via
> SBQ don't generate completion responses, causing the driver to
> timeout waiting and return -EIO, when trying:
>
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
>
> Add support for posted mode not to wait for completion response.
>
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> - change "postpone" to "posted"
> - init struct with {} instead of {0}
> v1:
> https://lore.kernel.org/intel-wired-lan/20260310110700.345904-1-przemyslaw.korba@intel.com/
>
>  drivers/net/ethernet/intel/ice/ice_common.c   | 7 ++++++-
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 4 ++++
>  drivers/net/ethernet/intel/ice/ice_controlq.h | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 8866902efb91..c89c6ca1281b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1765,6 +1765,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
>  {
>         struct ice_sbq_cmd_desc desc = {0};
>         struct ice_sbq_msg_req msg = {0};
> +       struct ice_sq_cd cd = {};
>         u16 msg_len;
>         int status;
>
> @@ -1785,10 +1786,14 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
>                  */
>                 msg_len -= sizeof(msg.data);
>
> +       if (in->opcode == ice_sbq_msg_wr)
> +               cd.posted = 1;
> +
>         desc.flags = cpu_to_le16(flags);
>         desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
>         desc.param0.cmd_len = cpu_to_le16(msg_len);
> -       status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
> +       status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
> +
>         if (!status && !in->opcode)
>                 in->data = le32_to_cpu
>                         (((struct ice_sbq_msg_cmpl *)&msg)->data);
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> index dcb837cadd18..a6008dc77fa4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> @@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>         wr32(hw, cq->sq.tail, cq->sq.next_to_use);
>         ice_flush(hw);
>
> +       /* If the message is posted, don't wait for completion. */
> +       if (cd && cd->posted)
> +               goto sq_send_command_error;
> +
>         /* Wait for the command to complete. If it finishes within the
>          * timeout, copy the descriptor back to temp.
>          */
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
> index 788040dd662e..c50d6fcbacba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.h
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
> @@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
>  /* sq transaction details */
>  struct ice_sq_cd {
>         struct libie_aq_desc *wb_desc;
> +       u8 posted : 1;
>  };
>
>  /* rq event information */
>
> base-commit: acd2abc52dea91c3bc3d1b6dd8a92b9631d48bbf
> --
> 2.43.0
>
This is actually a valid fix to a,
885c5e57924dc0 ("ice: fix 'adjust' timer programming for E830 devices"),
which allows the E830 HW to continue in the function 
and then invoke the following: (with some ice_debug() messages enabled)

[ 2946.907728] ice 0000:6c:00.0: Failed to send message to PHY, err -5
[ 2946.907731] ice 0000:6c:00.0: Failed to prepare PHY ports for timer command 2, err -5
[ 2946.907733] ice 0000:6c:00.0: PTP failed to adjust time, err -5

But the patchwork lists it as Changes Requested. Any idea what happened with it?

Tested-by: Jakub Ramaseuski <jramaseu@redhat.com>

