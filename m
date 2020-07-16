From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:49:46 +0000
Subject: [Intel-wired-lan] [PATCH S50 06/15] ice: fix overwriting TX/RX
 descriptor values when rebuilding VSI
In-Reply-To: <20200713205318.32425-6-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-6-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21456A6B89E7E6191124FBDE8C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 06/15] ice: fix overwriting TX/RX
> descriptor values when rebuilding VSI
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> If a user sets the value of the TX or RX descriptors to some non-default value
> using 'ethtool -G' then we need to not overwrite the values when we rebuild
> the VSI. The VSI rebuild could happen as a result of a user setting the number
> of queues via the 'ethtool -L' command. Fix this by checking to see if the
> value we have stored is non-zero and if it is then don't change the value.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


