From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Tue, 29 Sep 2015 21:48:57 +0000
Subject: [Intel-wired-lan] [next PATCH S9 06/15] i40e: count drops
	in	netstat interface
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4D7@ORSMSX104.amr.corp.intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-7-git-send-email-catherine.sullivan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4D7@ORSMSX104.amr.corp.intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED167827A54B23@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: Intel-wired-lan
> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
> > Catherine Sullivan
> > Sent: Thursday, July 23, 2015 1:55 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [next PATCH S9 06/15] i40e: count drops in
> > netstat interface
> >
> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >
> > The i40e rx_dropped counter was not showing up in netstat -i.
> > Add the right counter to be updated with the stats.
> >
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Change-ID: I4dd552e9995836099184f9d9a08e90edb591155f

> Verified-by: Andrew Bowers <andrewx.bowers@intel.com>
> 
> Present in git log, code changes present in tree, netstat -I shows rx_dropped
> counter
>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Already verified, but wasn't flagged as such in patchwork.
