From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 22:16:31 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/2] igc: Remove
 references to SYSTIMR register
In-Reply-To: <20200820230217.2005122-1-vinicius.gomes@intel.com>
References: <20200820230217.2005122-1-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB289048578A7315DD008F5161BC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Thursday, August 20, 2020 4:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH next-queue v1 1/2] igc: Remove references to
> SYSTIMR register
> 
> In i225, it's no longer necessary to use the SYSTIMR register to
> latch the timer value, the timestamp is latched when SYSTIML is read.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
