From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 20:46:25 +0000
Subject: [Intel-wired-lan] [PATCH S53 14/15] ice: join format strings to
 same line as ice_debug
In-Reply-To: <20200917201347.81570-14-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-14-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB28905024381D4215D798C40DBC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 14/15] ice: join format strings to same
> line as ice_debug
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When printing messages with ice_debug, align the printed string to the
> origin line of the message in order to ease debugging and tracking
> messages back to their source.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 102 ++++++------------
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  42 +++-----
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |  24 ++---
>  drivers/net/ethernet/intel/ice/ice_flow.c     |   9 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |  27 ++---
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  21 ++--
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  15 +--
>  7 files changed, 80 insertions(+), 160 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
