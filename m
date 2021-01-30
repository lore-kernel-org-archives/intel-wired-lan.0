From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 Jan 2021 19:27:50 -0800
Subject: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion
 failed at net/ipv4/udp_tunnel_nic.c
In-Reply-To: <DB8PR04MB6460F61AE67E17CC9189D067EAB99@DB8PR04MB6460.eurprd04.prod.outlook.com>
References: <DB8PR04MB6460F61AE67E17CC9189D067EAB99@DB8PR04MB6460.eurprd04.prod.outlook.com>
Message-ID: <20210129192750.7b2d8b25@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 29 Jan 2021 17:44:12 +0000 Pierre Cheynier wrote:
> Dear list,
> 
> I noticed this assertion error recently after upgrading to 5.10.x (latest trial being 5.10.11).
> Coming indirectly with my usage of the vxlan module, the assertion output will probably give you the information required to guess my hardware context (i40e).
> 
> [    8.842462] ------------[ cut here ]------------
> [    8.847081] RTNL: assertion failed at net/ipv4/udp_tunnel_nic.c (557)
> [    8.853541] WARNING: CPU: 0 PID: 15 at net/ipv4/udp_tunnel_nic.c:557 __udp_tunnel_nic_reset_ntf+0xde/0xf0 [udp_tunnel]

> [    8.910283] RIP: 0010:__udp_tunnel_nic_reset_ntf+0xde/0xf0 [udp_tunnel]

> [    9.014499] Call Trace:
> [    9.016968]  i40e_setup_pf_switch+0x3e8/0x5e0 [i40e]
> [    9.021949]  i40e_probe.part.0.cold+0x87a/0x11f2 [i40e]
> [    9.065385]  local_pci_probe+0x42/0x80

Thanks for the report!

I must have missed that i40e_setup_pf_switch() is called from the probe
path.

Intel folks, does the UDP port table get reset only when reinit is true?
So can this be the fix?

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 521ea9df38d5..4f3e7201ec1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14269,7 +14269,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
        i40e_ptp_init(pf);
 
        /* repopulate tunnel port filters */
-       udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
+       if (!reinit)
+               udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
 
        return ret;
 }

Or do we need to exclude the first call like this?

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 521ea9df38d5..823c054f4c23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14269,7 +14269,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
        i40e_ptp_init(pf);
 
        /* repopulate tunnel port filters */
-       udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
+       if (pf->lan_vsi != I40E_NO_VSI)
+               udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
 
        return ret;
 }
