From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 21:12:42 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Add support for Meteor
 Lake
In-Reply-To: <20200813083406.2857904-1-sasha.neftin@intel.com>
References: <20200813083406.2857904-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890D41D6A89686B74BA574ABC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Thursday, August 13, 2020 1:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Add support for Meteor Lake
> 
> Add devices ID's for the next LOM generations that will be
> available on the next Intel Client platform (Meteor Lake)
> This patch provides the initial support for these devices
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 2 ++
>  drivers/net/ethernet/intel/e1000e/hw.h      | 5 +++++
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 +++++++
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 6 ++++++
>  drivers/net/ethernet/intel/e1000e/ptp.c     | 1 +
>  5 files changed, 21 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
