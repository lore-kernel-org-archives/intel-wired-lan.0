From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 1 Oct 2020 06:23:14 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] e1000: remove unused and
 incorrect code
In-Reply-To: <20200918184152.604967-1-jesse.brandeburg@intel.com>
References: <20200918184152.604967-1-jesse.brandeburg@intel.com>
Message-ID: <DM6PR11MB2890E7A928B3724135A0A681BC300@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
> Brandeburg
> Sent: Friday, September 18, 2020 11:42 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1] e1000: remove unused and
> incorrect code
> 
> The e1000_clear_vfta function was triggering a warning in kbuild-bot
> testing. It's actually a bug but has no functional impact.
> 
> drivers/net/ethernet/intel/e1000/e1000_hw.c:4415:58: warning: Same
> expression in both branches of ternary operator. [duplicateExpressionTernary]
> 
> Fix this warning by removing the offending code and simplifying
> the routine to do exactly what it did before, no functional
> change.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> 
> NOTE: I don't recommend this go to stable as there is no functional
> change.
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

