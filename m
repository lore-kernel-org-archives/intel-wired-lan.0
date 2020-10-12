From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 12 Oct 2020 21:38:21 +0000
Subject: [Intel-wired-lan] [PATCH S53 08/15] ice: don't always return an
 error for Get PHY Abilities AQ command
In-Reply-To: <20200917201347.81570-8-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
 <20200917201347.81570-8-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB289091787C9AFEF9F4DF5E35BC070@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Thursday, September 17, 2020 1:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S53 08/15] ice: don't always return an error for
> Get PHY Abilities AQ command
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> There are times when the driver shouldn't return an error when the Get
> PHY abilities AQ command (0x0600) returns an error. Instead the driver
> should log that the error occurred and continue on. This allows the
> driver to load even though the AQ command failed. The user can then
> later determine the reason for the failure and correct it.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
