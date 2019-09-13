From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 13 Sep 2019 13:16:37 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v2 0/3] AF_XDP fixes for i40e,
 ixgbe and xdpsock
In-Reply-To: <20190913103948.32053-1-ciara.loftus@intel.com>
References: <20190913103948.32053-1-ciara.loftus@intel.com>
Message-ID: <03e25d27-fe42-306d-880f-31b3d995afd3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-09-13 12:39, Ciara Loftus wrote:
> This patch set contains some fixes for AF_XDP zero copy in the i40e and
> ixgbe drivers as well as a fix for the 'xdpsock' sample application when
> running in unaligned mode.
> 
> Patches 1 and 2 fix a regression for the i40e and ixgbe drivers which
> caused the umem headroom to be added to the xdp handle twice, resulting in
> an incorrect value being received by the user for the case where the umem
> headroom is non-zero.
> 
> Patch 3 fixes an issue with the xdpsock sample application whereby the
> start of the tx packet data (offset) was not being set correctly when the
> application was being run in unaligned mode.
> 
> This patch set has been applied against commit a2c11b034142 ("kcm: use
> BPF_PROG_RUN")
> 
> ---
> v2:
> - Rearranged local variable order in i40e_run_xdp_zc and ixgbe_run_xdp_zc
> to comply with coding standards.
>

Thanks Ciara!

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>


> Ciara Loftus (3):
>    i40e: fix xdp handle calculations
>    ixgbe: fix xdp handle calculations
>    samples/bpf: fix xdpsock l2fwd tx for unaligned mode
> 
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 4 ++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 ++--
>   samples/bpf/xdpsock_user.c                   | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
