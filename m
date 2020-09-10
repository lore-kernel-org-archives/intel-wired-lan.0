From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 10 Sep 2020 06:56:26 +0000
Subject: [Intel-wired-lan] [PATCH] iavf-linux: Fix incorrect adapter get
 in iavf_resume
In-Reply-To: <20200902125459.30641-1-mateusz.palczewski@intel.com>
References: <20200902125459.30641-1-mateusz.palczewski@intel.com>
Message-ID: <DM6PR11MB289071A19881F3518A2AD776BC270@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Wednesday, September 2, 2020 5:55 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH] iavf-linux: Fix incorrect adapter get in
> iavf_resume
> 
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> When calling iavf_resume there was a crash because wrong
> function was used to get iavf_adapter and net_device pointers.
> Changed how iavf_resume is getting iavf_adapter and net_device
> pointers from pci_dev.
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
