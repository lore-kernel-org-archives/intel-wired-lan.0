From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 1 Jun 2022 06:36:51 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: don't set VF VLAN
 caps in switchdev
In-Reply-To: <20220425062756.14987-2-michal.swiatkowski@linux.intel.com>
References: <20220425062756.14987-1-michal.swiatkowski@linux.intel.com>
 <20220425062756.14987-2-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554695EC87967917F54C37B9CDF9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Monday, April 25, 2022 11:58 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Wilczynski, Michal <michal.wilczynski@intel.com>
>Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: don't set VF VLAN caps in
>switchdev
>
>In switchdev mode any VLAN manipulation from VF side isn't allowed.
>In order to prevent parsing VLAN commands don't set VF VLAN caps.
>This will result in removing VLAN specific opcodes from allowlist.
>If VF send any VLAN specific opcode PF driver will answer with not supported
>error.
>
>With this approach VF driver know that VLAN caps aren't supported so it
>shouldn't send VLAN specific opcodes. Thanks to that, some ugly errors will
>not show up in dmesg (ex. on creating VFs in switchdev mode there are errors
>about not supported VLAN insertion and stripping)
>
>Move setting VLAN caps to separate function, including switchdev mode
>specific code.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_virtchnl.c | 77 ++++++++++++-------
> 1 file changed, 50 insertions(+), 27 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
