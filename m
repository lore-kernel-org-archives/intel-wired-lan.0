From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:49:53 +0000
Subject: [Intel-wired-lan] [PATCH S39 10/15] ice: Don't tell the OS that
 link is going down
In-Reply-To: <20200127085927.13999-10-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-10-anthony.l.nguyen@intel.com>
Message-ID: <425ba8d6f3f7406c8d11d5c3d430b9e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 10/15] ice: Don't tell the OS that link is
> going down
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


