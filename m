From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 2 Feb 2021 08:30:35 -0800
Subject: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion
 failed at net/ipv4/udp_tunnel_nic.c
In-Reply-To: <DB8PR04MB6460DD3585CE95CB77A2B650EAB59@DB8PR04MB6460.eurprd04.prod.outlook.com>
References: <DB8PR04MB6460F61AE67E17CC9189D067EAB99@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210129192750.7b2d8b25@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DB8PR04MB6460DD3585CE95CB77A2B650EAB59@DB8PR04MB6460.eurprd04.prod.outlook.com>
Message-ID: <20210202083035.3d54f97c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2 Feb 2021 09:59:56 +0000 Pierre Cheynier wrote:
> On Sat, 30 Jan 2021 04:27:00 +0100 Jakub Kicinski wrote:
> 
> > I must have missed that i40e_setup_pf_switch() is called from the probe
> > path.  
> 
> Do you want me to apply these patches, rebuild and tell you what's the
> outcome?

I was hoping someone from Intel would step in and help.
