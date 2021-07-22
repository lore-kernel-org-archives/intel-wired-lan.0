From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 22 Jul 2021 09:55:09 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix ping is lost after
 untrusted VF had tried to change MAC
In-Reply-To: <BYAPR11MB3367EF5CEE54FC6415541454FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
References: <20210628121105.20640-1-mateusz.palczewski@intel.com>
 <BN6PR11MB392398056E8C2C4942BEC4038C189@BN6PR11MB3923.namprd11.prod.outlook.com>
 <BYAPR11MB33678799BFFC6AEEEE9EDDCCFC139@BYAPR11MB3367.namprd11.prod.outlook.com>
 <BYAPR11MB336713E82D26AEEA08B4A2FAFC139@BYAPR11MB3367.namprd11.prod.outlook.com>
 <BYAPR11MB3367955F8C5E5474683E46F7FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
 <BYAPR11MB3367A5CD95A08A740B0D3843FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
 <BYAPR11MB3367EF5CEE54FC6415541454FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
Message-ID: <BYAPR11MB3367A0CAB84E005DB86F4AA3FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Mateusz Palczewski
> Sent: Monday, June 28, 2021 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>;
> Patynowski, PrzemyslawX <przemyslawx.patynowski@intel.com>;
> Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix ping is lost after
> untrusted VF had tried to change MAC
>
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
>
> Make changes to MAC address dependent on the response of PF.
> Disallow changes to hw mac address and mac filter from untrusted VF,
> thanks to that ping is not lost if VF tries to change MAC.
> Add a new field in iavf_mac_filter, to indicate whether there was
> response from PF for given filter. Based on this field pass or discard
> the
filter.
> If untrusted VF tried to change it's address, it's not changed.
> Still filter was changed, because of that ping couldn't go through.
>
> Fixes: c5c922b3e09b ("iavf: fix MAC address setting for VFs when
> filter is
> rejected")
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Fixed function names in comments
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  1 +
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 47 ++++++++++++++++++-
>  3 files changed, 47 insertions(+), 2 deletions(-)
>
 
Tested-by: Gurucharan  G <Gurucharanx.g@intel.com> A Contingent Worker
> at Intel
