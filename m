From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jun 2020 15:48:22 +0000
Subject: [Intel-wired-lan] [next-queue] ixgbe: Cleanup unneeded delay in
 ethtool test
In-Reply-To: <20200626052141.1310945-1-jeffrey.t.kirsher@intel.com>
References: <20200626052141.1310945-1-jeffrey.t.kirsher@intel.com>
Message-ID: <DM5PR1101MB2154A1E21C3A9BB19E9495E68C930@DM5PR1101MB2154.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jeff Kirsher
> Sent: Thursday, June 25, 2020 10:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Jack Vogel
> <jack.vogel@oracle.com>; Venkat Venkatsubra
> <venkat.x.venkatsubra@oracle.com>
> Subject: [Intel-wired-lan] [next-queue] ixgbe: Cleanup unneeded delay in
> ethtool test
> 
> There is a 4 seconds delay in ixgbe_diag_test() that is holding up other ioctls
> such as SIOCGIFCONF that Oracle database applications use.
> One of Oracle's product runs "ethtool -t ethX online" periodically for system
> monitoring and that is impacting database applications that use SIOCGIFCONF
> at that same time.
> 
> This 4 second delay was needed in out early 1GbE parts to give the PHY time
> to recover from a reset.  This code was carried forward to the 10 GbE driver
> even it was not needed for the supported PHYs in the ixgbe driver.
> 
> CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> CC: Jack Vogel <jack.vogel@oracle.com>
> Reported-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


