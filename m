From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 20:40:45 +0000
Subject: [Intel-wired-lan] [PATCH S53 15/15] ice: Add space to unknown
 speed
In-Reply-To: <20200917201347.81570-15-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-15-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB2890499CBD122E634CCEB9B1BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 15/15] ice: Add space to unknown
> speed
> 
> From: Simon Perron Caissy <simon.perron.caissy@intel.com>
> 
> Add space to the end of 'Unknown' string  in  order to avoid
> concatenation with 'bps' string when formatting netdev log message.
> 
> Signed-off-by: Simon Perron Caissy <simon.perron.caissy@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
