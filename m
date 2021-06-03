From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Thu, 3 Jun 2021 04:15:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 1/2] ice: add ndo_bpf
 callback for safe mode netdev ops
In-Reply-To: <20210520063500.62037-2-maciej.fijalkowski@intel.com>
References: <20210520063500.62037-1-maciej.fijalkowski@intel.com>
 <20210520063500.62037-2-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB3292CA01DB8F9EF78A704DFEF13C9@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, May 20, 2021 12:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Jamal Hadi Salim <jhs@mojatatu.com>;
> bjorn at kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 1/2] ice: add ndo_bpf callback
> for safe mode netdev ops
> 
> ice driver requires a programmable pipeline firmware package in order to
> have a support for advanced features. Otherwise, driver falls back to so
> called 'safe mode'. For that mode, ndo_bpf callback is not exposed and when
> user tries to load XDP program, the following happens:
> 
> $ sudo ./xdp1 enp179s0f1
> libbpf: Kernel error message: Underlying driver does not support XDP in
> native mode link set xdp fd failed
> 
> which is sort of confusing, as there is a native XDP support, but not in the
> current mode. Improve the user experience by providing the specific
> ndo_bpf callback dedicated for safe mode which will make use of extack to
> explicitly let the user know that the DDP package is missing and that's the
> reason that the XDP can't be loaded onto interface currently.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
