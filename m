From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Sep 2020 02:52:23 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix memleak in ice_set_ringparam
In-Reply-To: <20200827023410.3677-1-dinghao.liu@zju.edu.cn>
References: <20200827023410.3677-1-dinghao.liu@zju.edu.cn>
Message-ID: <DM6PR11MB2890B209C860067C2EF3AC60BC2A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Dinghao Liu <dinghao.liu@zju.edu.cn>
> Sent: Wednesday, August 26, 2020 7:34 PM
> To: dinghao.liu at zju.edu.cn; kjlu at umn.edu
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Alexei
> Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>;
> Jesper Dangaard Brouer <hawk@kernel.org>; John Fastabend
> <john.fastabend@gmail.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> bpf at vger.kernel.org
> Subject: [PATCH] ice: Fix memleak in ice_set_ringparam
> 
> When kcalloc() on rx_rings fails, we should free tx_rings
> and xdp_rings to prevent memleak. Similarly, when
> ice_alloc_rx_bufs() fails, we should free xdp_rings.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

