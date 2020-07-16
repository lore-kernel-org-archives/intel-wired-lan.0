From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:49:28 +0000
Subject: [Intel-wired-lan] [PATCH S50 13/15] ice: reduce scope of
 variable
In-Reply-To: <20200713205318.32425-13-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-13-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145FBED2F8C1A0F17918B998C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S50 13/15] ice: reduce scope of variable
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> The scope of the macro local variable 'i' can be reduced.  Do so to avoid static
> analysis tools from complaining.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


