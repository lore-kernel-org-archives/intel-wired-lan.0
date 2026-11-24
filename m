Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E5606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MTKBf9yX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW700L9I
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BC81605CF;
	Tue, 24 Nov 2026 11:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-SUNBAIbT2P; Tue, 24 Nov 2026 11:29:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38F37605E8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795519741;
	b=VzH/diS63Hyu20EJdh1x06BPSG37+wt8dnDGU3fS27lD2tXq9c7uqsI8wFUBiRW/NRYn
	 +NOR8F+IS6IhTFdnkfNpeAExxfJa2jQTboyrZq4OIDhR5mSi7MWvS2NfYSSgW8tzxXWbs
	 R4jqzyFcIV5F8PQU+gRfB1cnCJL5hM6tkrJEUTqhMzpQbKy6my3QP5pu8+KG/TeXZeYIk
	 jMy0kPy0opvE41D6Nl1OA0rri9LTPQceBipismFD++gYl3Vm5SguDjoHiPQ+q0DnsuUNd
	 jxtiGiBaGsXAgkJd+NJqLhOiMhuT4br3Ox1d+Jpbe3PiphH4Ho1dlab9I17kawt71Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795519741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QF7Z4ahA77tf4AHsZkjR7QnsK6GbHcCfwX/ToF0HL3U=;
	b=M/r6SkSMou2B/f/siJUiksBgdocQgs5fxE56fCfd3WuCOcPthpQ7BKfVv3rfvDXCswF4
	 +h/a2G9fLR8her4XJJbW0i4s7uHUm/xKzaM9KGOc3xqzNBgfNaEBB8FX5Cx82xBxMu7DU
	 J0zRwcZQcLUN4m4CPrn4kRnH23luWOlEB8DpZFq645d/ORPXjJOUztw4u0cd8T9fi+O0y
	 ZLTjNYkB6adQX7VPriGiS7fqlM9NKUn4iujKSf3HWD/MUdDeEwtMtg+RGtG9ff4hSPdFC
	 s/0SOlZ0NnSc0UCeqfHV4slOdeGtiu+07nE1iGBVFj6/JuzOpWeTiCOxAvBUw5LAYrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795519741;
	bh=QF7Z4ahA77tf4AHsZkjR7QnsK6GbHcCfwX/ToF0HL3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MTKBf9yXGnr5CRlnEqiLdIv0Fgw7V6vHAvnSIe64yzk9astxHHXaXy/hHNSYOLe2b
	 xD2ssc0Yxk3r3/zzqMx46AO1k8q/55/iFLcXEBGZERQYMefq+KEswdI0wTE8h3V7dy
	 /YjlN9XEdUEe7lNI4Gl2n+GLQBDMHTcV4OIkdxMOByTEPhzh5zvL2FfwVcl3GdFyyq
	 F2AxBMLyQseaNEPrIfs3wB5jiSiChl73zO7uZ9wpWcR0M5Vn5XNatAKmJF1uBs56NG
	 f6Rpty+OUGBbI03WKT8TAkz70DVdTowknj6OFa1lZPHU6ezwVXoHiPUbh6XHa4MN9m
	 rEJ1jrLViPy7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38F37605E8;
	Tue, 24 Nov 2026 11:29:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF874D43
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B108180CB0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dmi7rADGEgeN for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 11:28:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70F5280C87
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JW700L9I
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70F5280C87
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 11:28:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3ABCE43F8C;
 Tue, 24 Nov 2026 11:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA891F000C0;
 Tue, 24 Nov 2026 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795519737;
 bh=QF7Z4ahA77tf4AHsZkjR7QnsK6GbHcCfwX/ToF0HL3U=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=JW700L9IsGvqCpLi8XBcYh5DMneKnWfDPewXC89iUf7f837UEswqFt+SdiqSP8l+S
 1eSzhPcjym5IPYIZ2A0mhPoGb9W8/1n1BpSlZEb9fzVul7QB0YPBtv4jhG3ZjvoqwT
 nWQ3xzFXuewPR7QaYPzaQRXIUeihHEcmNZ+V8jyQt9XppgNiyD9SVlroEaniQ2tkzx
 yOYTJe/qJxAs8gZRpiQ9Zqtm14qGmtzqZ77NfLCu9e18TsgoejL9RGcZc+PfF3D8XQ
 w+FCY9jzAAbv5E5g/mnpJNeIqQUm8Uttb1YQJorYNYHErL6u9Q64atRwjVu9EmUbR0
 myfhz2FhC06kw==
Subject: Re: [PATCH net v7 1/3] igb: do not let XDP frames span more than one
 Rx buffer
From: netdev-bot+sashiko@kernel.org
To: tkusters@aweta.nl
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 sven.auhagen@voleatech.de, richardcochran@gmail.com, kurt@linutronix.de,
 sriram.yagnaraman@ericsson.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 11:28:55 +0000
Message-ID: <179551973551.3135.7270095499525377709@kernel.org>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] igb: missing IGB_TS_HDR_LEN room in 2 KiB build_skb buffers with
  XDP
- [Medium] igb_xdp_setup() now calls
  pm_runtime_get_sync(&adapter->pdev->dev) while holding RTNL (ndo_bpf…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it touches the
  same VMOLR.RLPML field the patch now manages, and it crosses a guest-…

--

igb: do not let XDP frames span more than one Rx buffer

While XDP is attached, this commit limits the receive length (RLPML, or the
PF pool's VMOLR when VFs are allocated) to the configured max frame size,
so a frame cannot span more than one Rx buffer. It moves the RLPML/VMOLR
programming out of igb_set_rx_mode() into a new igb_set_rlpml() called
from igb_configure(), leaves room for the Rx timestamp header in the XDP
buffer size check, and blocks rx-all and legacy-rx changes while XDP is
attached. If rx-all was requested while XDP was attached, removing XDP
runtime resumes the device and calls netdev_update_features().

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..5f1a5e2240e64 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1964,6 +1964,57 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)

[ ... ]

> +	/* igb_set_rx_mode() also updates this register, and the core calls
> +	 * it under the address lock
> +	 */
> +	netif_addr_lock_bh(adapter->netdev);
> +	vmolr = rd32(E1000_VMOLR(vfn));
> +	vmolr &= ~E1000_VMOLR_RLPML_MASK;
> +	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
> +	wr32(E1000_VMOLR(vfn), vmolr);
> +	netif_addr_unlock_bh(adapter->netdev);
> +}

[Severity: High]
This issue was not introduced by this patch. It is in the VF pool
counterpart of the VMOLR.RLPML programming that igb_set_rlpml() now does
for the PF pool, so it seemed worth raising here.

igb_rcv_msg_from_vf() hands the VF-supplied mailbox word directly to
igb_set_vf_rlpml():

igb_rcv_msg_from_vf()
    retval = igb_set_vf_rlpml(adapter, msgbuf[1], vf);

In igb_set_vf_rlpml(), size is an int and only the upper bound is
checked:

static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, int size,
				   int vfn)
{
	...
	if (size > MAX_JUMBO_FRAME_SIZE)
		size = MAX_JUMBO_FRAME_SIZE;

	vmolr = rd32(E1000_VMOLR(vfn));
	vmolr &= ~E1000_VMOLR_RLPML_MASK;
	vmolr |= size | E1000_VMOLR_LPE;
	wr32(E1000_VMOLR(vfn), vmolr);
	...
}

Suppose a VF sends E1000_VF_SET_LPE with msgbuf[1] = 0xFFFFFFFF. Then
size is negative and passes the signed check. It is also ORed into VMOLR
without being masked with E1000_VMOLR_RLPML_MASK.

Could a malicious VF use this to set AUPE, ROPE, BAM, MPME and the other
high VMOLR bits on its own pool? For a VF with an administrative port
VLAN the PF clears AUPE through igb_set_vmolr(adapter, vf, !vlan), and
igb_set_vf_promisc() never lets a VF set ROPE. This path seems to get
around both restrictions.

This looks like it goes back to commits 7d5753f08c5b and d3836f8e2517.
Would masking size with E1000_VMOLR_RLPML_MASK, or handling it as
unsigned, before the write be enough here?

[ ... ]

> @@ -2933,7 +3019,20 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  	}
>  
>  	if (running)
> -		igb_open(dev);
> +		err = igb_open(dev);
> +
> +	/* rx-all may have been requested while XDP was attached. A failed
> +	 * igb_open() leaves NAPI disabled, so do not reconfigure then. A down
> +	 * interface can be runtime suspended; resume it first, as ethtool
> +	 * does before it changes features.
> +	 */
> +	if (!prog && !err && (dev->wanted_features & NETIF_F_RXALL)) {
> +		pm_runtime_get_sync(&adapter->pdev->dev);

[Severity: Medium]
igb_xdp_setup() is called through ndo_bpf with RTNL held. Can this
pm_runtime_get_sync() deadlock with a runtime suspend that has already
started?

On a down interface, igb_runtime_idle() and the watchdog schedule a
runtime suspend with pm_schedule_suspend(). Suppose the pm_wq worker has
already set the device to RPM_SUSPENDING. It then runs:

rpm_suspend()
  igb_runtime_suspend()
    __igb_shutdown(pdev, NULL, 1)
      rtnl_lock();    <- waits for the RTNL held by igb_xdp_setup()

At the same time the XDP removal thread is in:

igb_xdp_setup()
  pm_runtime_get_sync()
    rpm_resume()
      sleeps TASK_UNINTERRUPTIBLE while runtime_status == RPM_SUSPENDING

Neither side can make progress, and RTNL stays held, so all network
configuration on the host would hang.

To hit this, rx-all has to be requested while XDP is attached, and the
XDP removal on the down interface has to race with the start of the
delayed runtime suspend.

The same pattern of RTNL plus pm_runtime_get_sync() already exists in
__igb_open() and in the ethtool core. So the root cause is __igb_shutdown()
taking RTNL from the runtime suspend path. This patch still adds a new
place on the XDP removal path that waits on runtime PM under RTNL, which
that path did not do before.

> +		/* still detached if the resume failed */
> +		if (netif_device_present(dev))
> +			netdev_update_features(dev);
> +		pm_runtime_put(&adapter->pdev->dev);
> +	}
>  
>  	return 0;
>  }

[ ... ]

> @@ -2886,6 +2946,27 @@ static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
>  	}
>  }
>  
> +/* Check that a frame fits in one Rx buffer together with the inline Rx
> + * timestamp header, for the buffer size igb_set_rx_buffer_len() selects.
> + * The ring flags are only updated when the rings are configured, so they
> + * are not used here. For build_skb rings the frame is limited to
> + * IGB_MAX_FRAME_BUILD_SKB, which is below the 2 KiB hardware buffer size
> + * even with the header.
> + */
> +static bool igb_xdp_frame_fits(struct igb_adapter *adapter, int max_frame)
> +{
> +#if (PAGE_SIZE < 8192)
> +	if (!(adapter->flags & IGB_FLAG_RX_LEGACY)) {
> +		if (max_frame <= IGB_MAX_FRAME_BUILD_SKB &&
> +		    !IGB_2K_TOO_SMALL_WITH_PADDING)
> +			return true;
> +
> +		return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_3072;
> +	}
> +#endif
> +	return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_2048;
> +}
> +
>  static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  {
>  	int i, frame_size = dev->mtu + IGB_ETH_PKT_HDR_PAD;

[Severity: High]
The comment above igb_xdp_frame_fits() says IGB_MAX_FRAME_BUILD_SKB is
below the 2 KiB hardware buffer size even with the timestamp header.
That holds for SRRCTL.BSIZEPKT. Is that the limit that matters on a
build_skb ring, though?

On a build_skb ring the DMA starts at page_offset = IGB_SKB_PAD.
igb_skb_pad() computes IGB_SKB_PAD as SKB_WITH_OVERHEAD(2048) minus
IGB_MAX_FRAME_BUILD_SKB. That leaves exactly IGB_MAX_FRAME_BUILD_SKB
bytes (1536 on x86_64) before skb_shared_info, with no room for
IGB_TS_HDR_LEN. Only RLPML keeps the DMA inside that area.

With Rx timestamping on an 82580 or later MAC, the MAC prepends the
16-byte header and strips the 4-byte FCS, so it writes wire_len + 12
bytes. With XDP attached at MTU 1510, igb_set_rlpml() programs
min(IGB_MAX_FRAME_BUILD_SKB, max_frame_size) = 1536. Frames of 1525
to 1536 bytes on the wire are then accepted, and xdp.data_end in
igb_clean_rx_irq() ends up as much as 12 bytes past
xdp_data_hard_end(). At MTU 1500, max_frame_size is 1526, so double
tagged frames of 1525 and 1526 bytes still overflow.

For XDP_TX and XDP_REDIRECT, xdp_update_frame_from_buff() hits the
"missing reserved tailroom" XDP_WARN and the frame is dropped.

For XDP_PASS, igb_build_skb() calls napi_build_skb(), which zeroes
skb_shared_info over the last bytes of the payload. __skb_put() then
moves skb->tail past skb->end.

Once an admin has enabled hardware timestamping, for example through
ptp4l, any peer on the link can send such frames.

The non-XDP build_skb path has the same layout and an RLPML of
IGB_MAX_FRAME_BUILD_SKB, so part of this predates the patch. But the
commit message says the header room is reserved on all MACs, and the
build_skb branch in igb_xdp_frame_fits() is the one case where it is
not.

Should that branch also require max_frame + IGB_TS_HDR_LEN <=
IGB_MAX_FRAME_BUILD_SKB, with the build_skb RLPML and VMOLR limits
lowered to match? Or would you rather reserve IGB_TS_HDR_LEN in
IGB_SKB_PAD, or fall back to 3 KiB buffers while Rx timestamping is
enabled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-igb-rx-ts-fix-v7-0-63b03045978e%40aweta.nl
