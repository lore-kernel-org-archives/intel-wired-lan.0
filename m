From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 22:20:08 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: report correct VF link speed
 when link state is set to enable
In-Reply-To: <20200909082212.67583-1-sassmann@kpanic.de>
References: <20200909082212.67583-1-sassmann@kpanic.de>
Message-ID: <DM6PR11MB2890AC827D2F779D985D2513BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
> Behalf Of Stefan Assmann
> Sent: Wednesday, September 9, 2020 1:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Yang, Lihong <lihong.yang@intel.com>;
> sassmann at kpanic.de
> Subject: [PATCH] i40e: report correct VF link speed when link state is set to
> enable
> 
> When the virtual link state was set to "enable" ethtool would report
> link speed as 40000Mb/s regardless of the underlying device.
> Report the correct link speed.
> 
> Example from a XXV710 NIC.
> Before:
> $ ip link set ens3f0 vf 0 state auto
> $  ethtool enp8s2 | grep Speed
>         Speed: 25000Mb/s
> $ ip link set ens3f0 vf 0 state enable
> $ ethtool enp8s2 | grep Speed
>         Speed: 40000Mb/s
> After:
> $ ip link set ens3f0 vf 0 state auto
> $  ethtool enp8s2 | grep Speed
>         Speed: 25000Mb/s
> $ ip link set ens3f0 vf 0 state enable
> $ ethtool enp8s2 | grep Speed
>         Speed: 25000Mb/s
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

