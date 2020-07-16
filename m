From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:48:52 +0000
Subject: [Intel-wired-lan] [PATCH S50 02/15] ice: Fix link broken after
 GLOBR reset
In-Reply-To: <20200713205318.32425-2-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-2-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145D7BE47E619EFF0D74AEF8C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S50 02/15] ice: Fix link broken after GLOBR
> reset
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> After a GLOBR, the link was broken so that a link up situation was being seen
> as a link down.
> 
> The problem was that the rebuild process was updating the port_info link
> status without doing any of the other things that need to be done when link
> changes.
> 
> This was causing the port_info struct to have current "UP" information so
> that any further UP interrupts were skipped as redundant.
> 
> The rebuild flow should *not* be updating the port_info struct link
> information, so eliminate this and leave it to the link event handling code.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


