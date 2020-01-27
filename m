From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:17:03 +0000
Subject: [Intel-wired-lan] [PATCH S38 11/15] ice: remove unnecessary
 fallthrough comments
In-Reply-To: <20200122152138.41585-11-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-11-anthony.l.nguyen@intel.com>
Message-ID: <a7a390d219db4b0ba3869959c79b5fbd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 11/15] ice: remove unnecessary
> fallthrough comments
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Fallthrough comments are used to explicitly indicate the code is intended to
> flow from one case statement to the next in a switch statement rather than
> break out of the switch statement.  They are only needed when a case has
> one or more statements to execute before falling through to the next case,
> not when there is a list of cases for which the same statement(s) should be
> executed.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    | 1 -
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 --
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 2 --
>  drivers/net/ethernet/intel/ice/ice_main.c    | 2 --
>  drivers/net/ethernet/intel/ice/ice_sriov.c   | 2 --
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 1 -
>  6 files changed, 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


