From: Sokolowski, Jan <jan.sokolowski@intel.com>
Date: Wed, 10 Feb 2021 08:23:49 +0000
Subject: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion
 failed at net/ipv4/udp_tunnel_nic.c
In-Reply-To: <DB8PR04MB64608A64EA7B4ABAC3A15EE1EA8F9@DB8PR04MB6460.eurprd04.prod.outlook.com>
References: <DB8PR04MB6460F61AE67E17CC9189D067EAB99@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210129192750.7b2d8b25@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DB8PR04MB6460DD3585CE95CB77A2B650EAB59@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210202083035.3d54f97c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DM5PR11MB1705DDAEC74CA8918438EBA599B49@DM5PR11MB1705.namprd11.prod.outlook.com>
 <DB8PR04MB646092D87F51C2ACD180841EEAB49@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <DB8PR04MB6460398CFCE47ADD5EE773E1EAB49@DB8PR04MB6460.eurprd04.prod.outlook.com>,
 <20210203090842.22e5ccb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DB8PR04MB64608A64EA7B4ABAC3A15EE1EA8F9@DB8PR04MB6460.eurprd04.prod.outlook.com>
Message-ID: <DM5PR11MB17055BD7528EFFBE73C7B61C998D9@DM5PR11MB1705.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Issue has been reproduced and is under investigation, once we get more information/potential fixes, we'll contact you again.

Jan

-----Original Message-----
From: Pierre Cheynier <p.cheynier@criteo.com> 
Sent: Monday, February 8, 2021 10:10 AM
To: Jakub Kicinski <kuba@kernel.org>; Sokolowski, Jan <jan.sokolowski@intel.com>
Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
Subject: RE: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion failed at net/ipv4/udp_tunnel_nic.c


On Wed, 3 Feb 2021 18:08:31 +0100 Jakub Kicinski wrote:
> Yup! I'm pretty sure it's my conversion. The full commit quote upstream:
> 
> 40a98cb6f01f ("i40e: convert to new udp_tunnel infrastructure")
> 
> It should trigger if you have vxlan module loaded (or built in)
> and then reload or re-probe i40e.
> 
> Let us know if you can't repro it should pop up pretty reliably.

Not sure if this is under investigation on Intel side, I can help to test patches
or provide more info if needed.

--
Pierre
