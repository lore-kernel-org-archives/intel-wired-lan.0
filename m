From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:04:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/1] iavf: Enable setting RSS
 hash key
In-Reply-To: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224AB4C3C3519E61DA054CD828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, July 16, 2021 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 1/1] iavf: Enable setting RSS hash
> key
> 
> Driver support for changing the RSS hash key exists, however, checks have
> caused it to be reported as unsupported. Remove the check and allow the
> hash key to be specified.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


