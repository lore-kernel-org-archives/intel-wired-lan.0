From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 29 Oct 2021 12:35:19 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Clear synchronized
 addrs when adding VFs in switchdev mode
In-Reply-To: <20211026154628.15787-1-marcin.szycik@linux.intel.com>
References: <20211026154628.15787-1-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB4554D097B4DEB20C0A47604B9C879@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Tuesday, October 26, 2021 9:16 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Clear synchronized addrs when
>adding VFs in switchdev mode
>
>When spawning VFs in switchdev mode, internal filter list of vsi is cleared,
>which includes MAC rules. However MAC entries stay on netdev's multicast
>list, which causes error message when bringing link up after spawning VFs
>("Failed to delete MAC filters"). __dev_mc_sync() is called and tries to unsync
>addresses that were already removed internally when adding VFs.
>
>This can be reproduced with:
>1) Load ice driver
>2) Change PF to switchdev mode
>3) Bring PF link up
>4) Bring PF link down
>5) Create a VF on PF
>6) Bring PF link up
>
>Added clearing of netdev's multicast (and also unicast) list when spawning VFs
>in switchdev mode, so the state of internal rule list and netdev's MAC list is
>consistent.
>
>Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
