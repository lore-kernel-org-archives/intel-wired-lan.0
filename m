From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 9 Jul 2019 01:40:31 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v3 1/6] xsk: replace
 ndo_xsk_async_xmit with ndo_xsk_wakeup
In-Reply-To: <1562244134-19069-2-git-send-email-magnus.karlsson@intel.com>
References: <1562244134-19069-1-git-send-email-magnus.karlsson@intel.com>
 <1562244134-19069-2-git-send-email-magnus.karlsson@intel.com>
Message-ID: <57e022b7-ac0e-6a9c-5078-c44988fd9fe6@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 07/04/2019 02:42 PM, Magnus Karlsson wrote:
> This commit replaces ndo_xsk_async_xmit with ndo_xsk_wakeup. This new
> ndo provides the same functionality as before but with the addition of
> a new flags field that is used to specifiy if Rx, Tx or both should be
> woken up. The previous ndo only woke up Tx, as implied by the
> name. The i40e and ixgbe drivers (which are all the supported ones)
> are updated with this new interface.
> 
> This new ndo will be used by the new need_wakeup functionality of XDP
> sockets that need to be able to wake up both Rx and Tx driver
> processing.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c          |  5 +++--
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c           |  7 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.h           |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        |  5 +++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c         |  4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c  |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.h  |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c    |  2 +-
>  include/linux/netdevice.h                            | 14 ++++++++++++--
>  net/xdp/xdp_umem.c                                   |  3 +--
>  net/xdp/xsk.c                                        |  3 ++-
>  12 files changed, 32 insertions(+), 19 deletions(-)

Looks good, but given driver changes to support the AF_XDP need_wakeup
feature are quite trivial, is there a reason that you updated mlx5 here
but not for the actual support such that all three in-tree drivers are
supported?

Thanks,
Daniel
