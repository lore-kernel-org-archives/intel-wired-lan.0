From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:46:47 +0000
Subject: [Intel-wired-lan] [PATCH S50 03/15] ice: fix link event
 handling timing
In-Reply-To: <20200713205318.32425-3-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-3-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21452308030BA479EF9B68FF8C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S50 03/15] ice: fix link event handling timing
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> When the driver experiences a link event (especially link up) there can be
> multiple events generated. Some of these are link fault and still have a state
> of DOWN set.  The problem happens when the link comes UP during the PF
> driver handling one of the LINK DOWN events.  The status of the link is
> updated and is now seen as UP, so when the actual LINK UP event comes,
> the port information has already been updated to be seen as UP, even
> though none of the UP activities have been completed.
> 
> After the link information has been updated in the link handler and
> evaluated for MEDIA PRESENT, if the state of the link has been changed to
> UP, treat the DOWN event as an UP event since the link is now UP.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


