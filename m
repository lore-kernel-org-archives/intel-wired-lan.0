From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jun 2020 15:49:35 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: Fix updating statistics
In-Reply-To: <20200624160422.58874-1-anthony.l.nguyen@intel.com>
References: <20200624160422.58874-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR1101MB2154C72E8B46F2C577B81F018C930@DM5PR1101MB2154.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, June 24, 2020 9:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] iavf: Fix updating statistics
> 
> Commit bac8486116b0 ("iavf: Refactor the watchdog state machine")
> inverted the logic for when to update statistics. Statistics should be updated
> when no other commands are pending, instead they were only requested
> when a command was processed. iavf_request_stats() would see a pending
> request and not request statistics to be updated. This caused statistics to
> never be updated; fix the logic.
> 
> Fixes: bac8486116b0 ("iavf: Refactor the watchdog state machine")
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


