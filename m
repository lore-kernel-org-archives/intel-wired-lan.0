From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 29 Oct 2021 12:34:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Hide bus-info in
 ethtool for PRs in switchdev mode
In-Reply-To: <20211026155624.17106-1-marcin.szycik@linux.intel.com>
References: <20211026155624.17106-1-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB4554A9256F7C8A90871BD8FF9C879@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Tuesday, October 26, 2021 9:26 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Hide bus-info in ethtool for PRs
>in switchdev mode
>
>Disable showing bus-info information for port representors in switchdev
>mode. This fixes a bug that caused displaying wrong netdev descriptions in
>lshw tool - one port representor displayed PF branding string, and in turn one
>PF displayed a "generic" description. The bug occurs when many devices show
>the same bus-info in ethtool, which was the case in switchdev mode (PF and
>its port representors displayed the same bus-info). The bug occurs only if a
>port representor netdev appears before PF netdev in /proc/net/dev.
>
>In the examples below:
>ens6fX is PF
>ens6fXvY is VF
>ethX is port representor
>One irrelevant column was removed from output
>
>Before:
>$ sudo lshw -c net -businfo
>Bus info          Device      Description
>=========================================
>pci at 0000:02:00.0  eth102       Ethernet Controller E810-XXV for SFP
>pci at 0000:02:00.1  ens6f1       Ethernet Controller E810-XXV for SFP
>pci at 0000:02:01.0  ens6f0v0     Ethernet Adaptive Virtual Function
>pci at 0000:02:01.1  ens6f0v1     Ethernet Adaptive Virtual Function
>pci at 0000:02:01.2  ens6f0v2     Ethernet Adaptive Virtual Function
>pci at 0000:02:00.0  ens6f0       Ethernet interface
>
>Notice that eth102 and ens6f0 have the same bus-info and their descriptions
>are swapped.
>
>After:
>$ sudo lshw -c net -businfo
>Bus info          Device      Description
>=========================================
>pci at 0000:02:00.0  ens6f0      Ethernet Controller E810-XXV for SFP
>pci at 0000:02:00.1  ens6f1      Ethernet Controller E810-XXV for SFP
>pci at 0000:02:01.0  ens6f0v0    Ethernet Adaptive Virtual Function
>pci at 0000:02:01.1  ens6f0v1    Ethernet Adaptive Virtual Function
>pci at 0000:02:01.2  ens6f0v2    Ethernet Adaptive Virtual Function
>
>Fixes: 7aae80cef7ba ("ice: add port representor ethtool ops and stats")
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
