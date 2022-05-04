From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 4 May 2022 08:33:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: link representors
 to PCI device
In-Reply-To: <20220328145828.10097-2-marcin.szycik@linux.intel.com>
References: <20220328145828.10097-1-marcin.szycik@linux.intel.com>
 <20220328145828.10097-2-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB4554F4478F50EB104CB83F729CC39@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Monday, March 28, 2022 8:28 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: link representors to PCI
>device
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>Link port representors to parent PCI device to benefit from systemd defined
>naming scheme.
>
>Example from ip tool:
> - without linking:
>  eth0 ...
> - with linking:
>  eth0 ...
>  altname enp24s0f0npf0vf0
>
>The port representor name is being shown in altname, because the name is
>longer than IFNAMSIZ (16) limit. Altname can be used in ip tool.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_repr.c | 1 +
> 1 file changed, 1 insertion(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
