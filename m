From: Sokolowski, Jan <jan.sokolowski@intel.com>
Date: Wed, 3 Feb 2021 14:23:35 +0000
Subject: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion
 failed at net/ipv4/udp_tunnel_nic.c
In-Reply-To: <20210202083035.3d54f97c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <DB8PR04MB6460F61AE67E17CC9189D067EAB99@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210129192750.7b2d8b25@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <DB8PR04MB6460DD3585CE95CB77A2B650EAB59@DB8PR04MB6460.eurprd04.prod.outlook.com>
 <20210202083035.3d54f97c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <DM5PR11MB1705DDAEC74CA8918438EBA599B49@DM5PR11MB1705.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It has been mentioned that the error only appeared recently, after upgrade to 5.10.X. What's the last known working configuration it was tested on? A bisection could help us investigate.
Jan


-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jakub Kicinski
Sent: Tuesday, February 2, 2021 5:31 PM
To: Pierre Cheynier <p.cheynier@criteo.com>
Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
Subject: Re: [Intel-wired-lan] [5.10] i40e/udp_tunnel: RTNL: assertion failed at net/ipv4/udp_tunnel_nic.c

On Tue, 2 Feb 2021 09:59:56 +0000 Pierre Cheynier wrote:
> On Sat, 30 Jan 2021 04:27:00 +0100 Jakub Kicinski wrote:
> 
> > I must have missed that i40e_setup_pf_switch() is called from the probe
> > path.  
> 
> Do you want me to apply these patches, rebuild and tell you what's the
> outcome?

I was hoping someone from Intel would step in and help.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
