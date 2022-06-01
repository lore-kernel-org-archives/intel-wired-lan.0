From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 1 Jun 2022 06:28:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: disable stripping in
 default VSI ctx
In-Reply-To: <20220530165122.8804-1-marcin.szycik@linux.intel.com>
References: <20220530165122.8804-1-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB45541AE66B00C50ED19AA2CF9CDF9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Monday, May 30, 2022 10:21 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v2] ice: disable stripping in default
>VSI ctx
>
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
>In case when driver is in eswitch mode, having VLAN stripping enabled causes
>failure in communication. All VLAN configuration commands are blocked.
>Because of that VF driver can't disable VLAN stripping at initialization. It leads
>to the situation when VLAN stripping on VF VSI is on, but in kernel it is off.
>
>To prevent this, disable VLAN stripping in VSI initialization. It doesn't break
>other usecases, because it is set according to kernel settings.
>
>To reproduce:
>modprobe ice
>devlink dev eswitch set $PF_PCI mode switchdev ip link add br0 type bridge ip
>link set br0 up ip link set $PF_DEV master br0 ip link set $PF_DEV up echo 1 >
>/sys/class/net/$PF_DEV/device/sriov_numvfs
>ip link set $VF1 up
>ip link set $VF1_PR master br0
>ip link set $VF1_PR up
>ip link add link $VF1 name vlan100 type vlan id 100 ip addr add
>$VLAN_IP/$MASK dev vlan100 ip link set vlan100 up
>
>On link partner:
>ip link add link $PF name vlan100 type vlan id 100 ip addr add
>$PEER_VLAN_IP/$MASK dev vlan100 ip link set vlan100 up ping $VLAN_IP
>
>Ping fails.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
>v2:
>   * Small corrections in commit msg
>   * Added reproduction steps
>   * Removed Fixes tag, added squash note
>
>This patch should be squashed with "ice: remove VLAN representor specific
>logs"
> drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
> 1 file changed, 3 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
