From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Jun 2020 17:01:37 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 2/3] i40e: add xdp ring
 statistics to dump vsi debug output
In-Reply-To: <20200623130657.5668-2-ciara.loftus@intel.com>
References: <20200623130657.5668-1-ciara.loftus@intel.com>
 <20200623130657.5668-2-ciara.loftus@intel.com>
Message-ID: <BN6PR1101MB214566D9A528A8835E4476238C920@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ciara Loftus
> Sent: Tuesday, June 23, 2020 6:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2 2/3] i40e: add xdp ring statistics
> to dump vsi debug output
> 
> Prior to this, only the rx and tx ring statistics were dumped. The xdp ring
> statistics are now dumped as well.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


