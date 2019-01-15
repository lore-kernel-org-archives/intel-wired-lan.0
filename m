From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 15 Jan 2019 21:03:49 +0100
Subject: [Intel-wired-lan] [PATCH bpf] xsk: Check if a queue exists
 during umem setup
In-Reply-To: <A2709E16AE7E444B9FD2D20EF44E15072BC9B039@IRSMSX104.ger.corp.intel.com>
References: <A2709E16AE7E444B9FD2D20EF44E15072BC9B039@IRSMSX104.ger.corp.intel.com>
Message-ID: <7023223e-b552-e353-d8cd-9563a7f7afe5@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/15/2019 10:19 AM, Kazimierczak, Krzysztof wrote:
> From 6cbcfa3d0909bc27af0be6122dc6bfbfa4c9269e Mon Sep 17 00:00:00 2001
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> Date: Thu, 10 Jan 2019 20:29:02 +0100
> Subject: [PATCH bpf] xsk: Check if a queue exists during umem setup
> 
> In the xdp_umem_assign_dev() path, the xsk code does not
> check if a queue for which umem is to be created exists.
> It leads to a situation where umem is not assigned to any
> Tx/Rx queue of a netdevice, without notifying the stack
> about an error. This affects both XDP_SKB and XDP_DRV
> modes - in case of XDP_DRV_ZC, queue index is checked by
> the driver.
> 
> This patch fixes xsk code, so that in both XDP_SKB and
> XDP_DRV mode of AF_XDP, an error is returned when requested
> queue index exceedes an existing maximum.
> 
> Fixes: c9b47cc1fabca ("xsk: fix bug when trying to use both copy and zero-copy on one queue id")
> Reported-by: Jakub Spizewski <jakub.spizewski@intel.com>
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

Applied, thanks!
