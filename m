From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Jun 2020 15:42:30 +0000
Subject: [Intel-wired-lan] [PATCH net 1/3] ixgbe: protect ring accesses
 with READ- and WRITE_ONCE
In-Reply-To: <20200609131945.18373-1-ciara.loftus@intel.com>
References: <20200609131945.18373-1-ciara.loftus@intel.com>
Message-ID: <BN6PR1101MB21457C3EE7CA913B5D3797F58C800@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ciara Loftus
> Sent: Tuesday, June 9, 2020 6:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>;
> Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net 1/3] ixgbe: protect ring accesses with
> READ- and WRITE_ONCE
> 
> READ_ONCE should be used when reading rings prior to accessing the
> statistics pointer. Introduce this as well as the corresponding WRITE_ONCE
> usage when allocating and freeing the rings, to ensure protected access.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 12 ++++++------
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 +++++++++++---
>  2 files changed, 17 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


