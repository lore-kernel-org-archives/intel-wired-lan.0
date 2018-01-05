From: John Fastabend <john.fastabend@gmail.com>
Date: Thu, 4 Jan 2018 20:17:05 -0800
Subject: [Intel-wired-lan] [bpf-next V4 PATCH 03/14] i40e: setup
 xdp_rxq_info
In-Reply-To: <151497512387.18176.16261505821783867005.stgit@firesoul>
References: <151497504273.18176.10177133999720101758.stgit@firesoul>
 <151497512387.18176.16261505821783867005.stgit@firesoul>
Message-ID: <aeac85ab-4b22-4cda-1f1c-5c3493454448@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/03/2018 02:25 AM, Jesper Dangaard Brouer wrote:
> The i40e driver has a special "FDIR" RX-ring (I40E_VSI_FDIR) which is
> a sideband channel for configuring/updating the flow director tables.
> This (i40e_vsi_)type does not invoke XDP-ebpf code.
> 
> As suggested by Bj?rn (V2): Instead of marking this I40E_VSI_FDIR RX-ring
> a special case, reverse the logic and only select RX-rings of type
> I40E_VSI_MAIN to register xdp_rxq_info's for.
> 
> Driver hook points for xdp_rxq_info:
>  * reg  : i40e_setup_rx_descriptors (via i40e_vsi_setup_rx_resources)
>  * unreg: i40e_free_rx_resources    (via i40e_vsi_free_rx_resources)
> 
> Tested on actual hardware with samples/bpf program.
> 
> V2: Fixed bug in i40e_set_ringparam (memset zero) + match on I40E_VSI_MAIN.
> V4: Update patch desc that got out-of-sync with code.
> 
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: Bj?rn T?pel <bjorn.topel@intel.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---


Same here. LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>

