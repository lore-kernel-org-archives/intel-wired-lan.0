From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:42:16 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 10/15] ice: Don't tell the OS
 that link is going down
In-Reply-To: <20200213213129.34023-9-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-9-anthony.l.nguyen@intel.com>
Message-ID: <7e4597c386854c15bc37399ced3aed66@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 10/15] ice: Don't tell the OS that link
> is going down
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Remove code that tell the OS that link is going down when user change flow
> control via ethtool. When link is up it isn't certain that link goes down after
> 0x0605 aq command. If link doesn't go down, OS thinks that link is down, but
> physical link is up. To reset this state user have to take interface down and
> up.
> 
> If link goes down after 0x0605 command, FW send information about that
> and after that driver tells the OS that the link goes down. So this code in
> ethtool is unnecessary.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 -------
>  1 file changed, 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


