From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 3 Feb 2021 09:08:42 -0800
Subject: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion
 failed at net/ipv4/udp_tunnel_nic.c
In-Reply-To: <DB8PR04MB6460398CFCE47ADD5EE773E1EAB49@DB8PR04MB6460.eurprd04.prod.outlook.com>
References: <DB8PR04MB6460F61AE67E17CC9189D067EAB99@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210129192750.7b2d8b25@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DB8PR04MB6460DD3585CE95CB77A2B650EAB59@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210202083035.3d54f97c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DM5PR11MB1705DDAEC74CA8918438EBA599B49@DM5PR11MB1705.namprd11.prod.outlook.com>
 <DB8PR04MB646092D87F51C2ACD180841EEAB49@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <DB8PR04MB6460398CFCE47ADD5EE773E1EAB49@DB8PR04MB6460.eurprd04.prod.outlook.com>
Message-ID: <20210203090842.22e5ccb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 3 Feb 2021 16:05:40 +0000 Pierre Cheynier wrote:
> On Wed, 3 Feb 2021 16:25:12 +0100 Pierre Cheynier wrote:
> > On Wed, 3 Feb 2021 15:23:54 +0100 Sokolowski, Jan wrote:
> >   
> > > It has been mentioned that the error only appeared recently, after upgrade to 5.10.X. What's the last known working configuration it was tested on? A bisection could help us investigate.  
> > 
> > I unfortunately moved from one LTS to another, meaning I was in 5.4 before, and this UDP tunnel offloading feature landed in 5.9 as far as I know.
> > 
> > Maybe Jakub can give pointers to specific 5.9 or 5.10 kernel versions I can eventually try, so that I can help refine where this was introduced (or if it was present from the start)?  
> 
> So I think I was incorrect, the support of this infrastructure for i40e appears in 5.10.
> From what I'm seeing, and Jakub will confirm, I think this started with the
> initial implementation for i40e (see 40a98cb6f01f013b8ab0ce7b28f705423ee16836).

Yup! I'm pretty sure it's my conversion. The full commit quote upstream:

40a98cb6f01f ("i40e: convert to new udp_tunnel infrastructure")

It should trigger if you have vxlan module loaded (or built in) 
and then reload or re-probe i40e.

Let us know if you can't repro it should pop up pretty reliably.
